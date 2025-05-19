from ignis.widgets import Widget
from ignis.utils import Utils
from ignis.services.system_tray import SystemTrayService, SystemTrayItem
from ignis.menu_model import IgnisMenuModel, IgnisMenuItem, IgnisMenuSeparator
import datetime
import subprocess
import asyncio

system_tray = SystemTrayService.get_default()


def clock() -> Widget.Label:
    # poll for current time every second in 12-hour format with AM/PM
    return Widget.Label(
        css_classes=["clock"],
        label=Utils.Poll(
            1_000, lambda self: datetime.datetime.now().strftime("%I:%M %p")
        ).bind("output"),
    )


def battery_level() -> Widget.Label:
    # poll for battery level every second
    return Widget.Box(
        css_classes=["clock"],
        child=[
            Widget.Label(label=" ", style="margin-right: 5px;"),
            Widget.Label(
                label=Utils.Poll(
                    1_000,
                    lambda self: subprocess.check_output(
                        ["cat", "/sys/class/power_supply/BAT0/capacity"]
                    )
                    .decode("utf-8")
                    .replace("\n", ""),
                ).bind("output")
            ),
            Widget.Label(label="%"),
        ],
    )


def tray_item(item: SystemTrayItem) -> Widget.Button:
    if item.menu:
        menu = item.menu.copy()
    else:
        menu = None

    return Widget.Button(
        child=Widget.Box(
            child=[
                Widget.Icon(image=item.bind("icon"), pixel_size=24),
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
    return Widget.Box(
        setup=lambda self: system_tray.connect(
            "added", lambda x, item: self.append(tray_item(item))
        ),
        spacing=10,
    )


def create_exec_task(cmd: str) -> None:
    # use create_task to run async function in a regular (sync) one
    asyncio.create_task(Utils.exec_sh_async(cmd))


def power_menu() -> Widget.Button:
    menu = Widget.PopoverMenu(
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
                on_activate=lambda x: create_exec_task(
                    "hyprctl dispatch exit 0"
                ),  # noqa: E501
            ),
        ),
    )
    return Widget.Button(
        child=Widget.Box(
            child=[Widget.Icon(image="system-shutdown-symbolic", pixel_size=20), menu]  # noqa: E501
        ),
        on_click=lambda x: menu.popup(),
    )


def icon_list(icon: str, label: bool = False) -> Widget.Label:
    icons = {
        "nixos": " ",
        "hypr": " ",
        "vscode": " ",
        "terminal": " ",
        "firefox": "󰈹 ",
        "discord": " ",
        "steam": " ",
        "kdenlive": " ",
        "pavucontrol": "󰓃 ",
        # Programming Languages
        "css": " ",
        "js": " ",
        "html": " ",
        "json": "󰘦 ",
        "python": " ",
        "react": " ",
    }
    if label:
        return Widget.Label(label=icons[icon])
    elif not label:
        return icons[icon]
