import os
import datetime
import asyncio
from ignis.menu_model import IgnisMenuModel, IgnisMenuItem, IgnisMenuSeparator  # type: ignore
from ignis import widgets, utils  # type: ignore
from ignis.css_manager import CssManager, CssInfoPath  # type: ignore
from ignis.services.audio import AudioService  # type: ignore
from ignis.services.system_tray import SystemTrayService, SystemTrayItem  # type: ignore
from ignis.services.hyprland import HyprlandService  # type: ignore
from ignis.services.mpris import MprisService, MprisPlayer  # type: ignore

css_manager = CssManager.get_default()

css_manager.apply_css(
    CssInfoPath(
        name="main",
        compiler_function=lambda path: utils.sass_compile(path=path),
        path=os.path.join(utils.get_current_dir(), "style.scss"),
    )
)

audio = AudioService.get_default()
system_tray = SystemTrayService.get_default()
hyprland = HyprlandService.get_default()
mpris = MprisService.get_default()


def workspace_button(workspace) -> widgets.Button:
    if hyprland.is_available:
        # return hyprland_workspace_button(workspace)
        widget = widgets.Button(
            css_classes=["workspace"],
            on_click=lambda x: workspace.switch_to(),
            child=widgets.Label(label=str(workspace.id)),
        )
        if workspace.id == hyprland.active_workspace.id:
            widget.add_css_class("active")

        return widget
    else:
        return widgets.Button()


def scroll_workspaces(direction: str, monitor_name: str = "") -> None:
    if hyprland.is_available:
        current = hyprland.active_workspace["id"]
        if direction == "up":
            target = current - 1
            hyprland.switch_to_workspace(target)
        else:
            target = current + 1
            if target == 11:
                return
            hyprland.switch_to_workspace(target)
    else:
        pass


def workspaces() -> widgets.EventBox:
    if hyprland.is_available:
        return widgets.EventBox(
            on_scroll_up=lambda x: scroll_workspaces("up"),
            on_scroll_down=lambda x: scroll_workspaces("down"),
            css_classes=["workspaces"],
            spacing=5,
            child=hyprland.bind_many(  # bind also to active_workspace to regenerate workspaces list when active workspace changes
                ["workspaces", "active_workspace"],
                transform=lambda workspaces, active_workspace: [
                    workspace_button(i) for i in workspaces
                ],
            ),
        )
    else:
        return widgets.EventBox()


def mpris_title(player: MprisPlayer) -> widgets.Box:
    return widgets.Box(
        spacing=10,
        setup=lambda self: player.connect(
            "closed",
            lambda x: self.unparent(),  # remove widget when player is closed
        ),
        child=[
            widgets.Icon(image="audio-x-generic-symbolic"),
            widgets.Label(
                ellipsize="end",
                max_width_chars=20,
                label=player.bind("title"),
            ),
        ],
    )


def media() -> widgets.Box:
    return widgets.Box(
        spacing=10,
        child=[
            widgets.Label(
                label="",
                visible=mpris.bind("players", lambda value: len(value) == 0),
            )
        ],
        setup=lambda self: mpris.connect(
            "player-added", lambda x, player: self.append(mpris_title(player))
        ),
    )


def hyprland_client_title() -> widgets.Label:
    return widgets.Label(
        ellipsize="end",
        max_width_chars=40,
        label=hyprland.active_window.bind("title"),
    )


def client_title() -> widgets.Label:
    if hyprland.is_available:
        return hyprland_client_title()
    else:
        return widgets.Label()


def clock() -> widgets.Label:
    # poll for current time every second
    return widgets.Label(
        css_classes=["clock"],
        label=utils.Poll(
            1_000, lambda self: datetime.datetime.now().strftime("%I:%M %p")
        ).bind("output"),
    )


def speaker_volume() -> widgets.Box:
    return widgets.Box(
        child=[
            widgets.Icon(
                image=audio.speaker.bind("icon_name"), style="margin-right: 5px;"  # type: ignore
            ),
            widgets.Label(
                label=audio.speaker.bind("volume", transform=lambda value: str(value))  # type: ignore
            ),
            widgets.Label(label="%"),
        ]
    )


def tray_item(item: SystemTrayItem) -> widgets.Button:
    if item.menu:
        menu = item.menu.copy()
    else:
        menu = None

    return widgets.Button(
        child=widgets.Box(
            child=[
                widgets.Icon(image=item.bind("icon"), pixel_size=24),
                menu,
            ]
        ),
        setup=lambda self: item.connect("removed", lambda x: self.unparent()),
        tooltip_text=item.bind("tooltip"),
        on_click=lambda x: menu.popup() if menu else None,
        on_right_click=lambda x: menu.popup() if menu else None,
        css_classes=["tray-item"],
    )


def tray():
    return widgets.Box(
        setup=lambda self: system_tray.connect(
            "added", lambda x, item: self.append(tray_item(item))
        ),
        spacing=10,
    )


def speaker_slider() -> widgets.Scale:
    return widgets.Scale(
        min=0,
        max=100,
        step=1,
        value=audio.speaker.bind("volume"),  # type: ignore
        on_change=lambda x: audio.speaker.set_volume(x.value),  # type: ignore
        css_classes=["volume-slider"],  # we will customize style in style.css
    )


def create_exec_task(cmd: str) -> None:
    # use create_task to run async function in a regular (sync) one
    asyncio.create_task(utils.exec_sh_async(cmd))


def logout() -> None:
    if hyprland.is_available:
        create_exec_task("hyprctl dispatch exit 0")
    else:
        pass


def power_menu() -> widgets.Button:
    menu = widgets.PopoverMenu(
        model=IgnisMenuModel(
            IgnisMenuItem(
                label="Lock",
                on_activate=lambda x: create_exec_task("swaylock"),
            ),
            IgnisMenuSeparator(),
            IgnisMenuItem(
                label="Suspend",
                on_activate=lambda x: create_exec_task("systemctl suspend"),
            ),
            IgnisMenuItem(
                label="Hibernate",
                on_activate=lambda x: create_exec_task("systemctl hibernate"),
            ),
            IgnisMenuSeparator(),
            IgnisMenuItem(
                label="Reboot",
                on_activate=lambda x: create_exec_task("systemctl reboot"),
            ),
            IgnisMenuItem(
                label="Shutdown",
                on_activate=lambda x: create_exec_task("systemctl poweroff"),
            ),
            IgnisMenuSeparator(),
            IgnisMenuItem(
                label="Logout",
                enabled=hyprland.is_available,
                on_activate=lambda x: logout(),
            ),
        ),
    )
    return widgets.Button(
        child=widgets.Box(
            child=[widgets.Icon(image="system-shutdown-symbolic", pixel_size=20), menu]
        ),
        on_click=lambda x: menu.popup(),
    )


def left() -> widgets.Box:
    return widgets.Box(child=[workspaces()], spacing=0)


def center() -> widgets.Box:
    return widgets.Box(
        child=[
            client_title(),
            widgets.Separator(vertical=True, css_classes=["middle-separator"]),
            media(),
        ],
        spacing=10,
    )


def right() -> widgets.Box:
    return widgets.Box(
        child=[
            tray(),
            widgets.Separator(vertical=True, css_classes=["middle-separator"]),
            speaker_volume(),
            speaker_slider(),
            widgets.Separator(vertical=True, css_classes=["middle-separator"]),
            clock(),
            widgets.Separator(vertical=True, css_classes=["middle-separator"]),
            power_menu(),
        ],
        spacing=10,
    )


def bar(monitor_id: int = 0) -> widgets.Window:
    return widgets.Window(
        namespace=f"ignis_bar_{monitor_id}",
        monitor=monitor_id,
        anchor=["left", "top", "right"],
        exclusivity="exclusive",
        child=widgets.CenterBox(
            css_classes=["bar"],
            start_widget=left(),
            center_widget=center(),
            end_widget=right(),
        ),
    )


# this will display bar on all monitors
for i in range(utils.get_n_monitors()):
    bar(i)
