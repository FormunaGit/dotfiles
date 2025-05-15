from ignis.widgets import Widget
from ignis.services.hyprland import HyprlandService, HyprlandWorkspace

# Variable for controlling Hyprland
hyprland = HyprlandService.get_default()


def keyboard_layout() -> Widget.EventBox:
    return Widget.EventBox(
        on_click=lambda self: hyprland.main_keyboard.switch_layout("next"),
        child=[Widget.Label(label=hyprland.main_keyboard.bind("active_keymap"))],                                                                                                                 # noqa: E501
    )


def workspace_button(workspace: HyprlandWorkspace) -> Widget.Button:
    widget = Widget.Button(
        css_classes=["workspace"],
        on_click=lambda x: workspace.switch_to(),
        child=Widget.Label(label=str(workspace.id)),
    )
    if workspace.id == hyprland.active_workspace.id:
        widget.add_css_class("active")

    return widget


def scroll_workspaces(direction: str) -> None:
    current = hyprland.active_workspace["id"]
    if direction == "up":
        target = current - 1
        hyprland.switch_to_workspace(target)
    else:
        target = current + 1
        if target == 11:
            return
        hyprland.switch_to_workspace(target)


def workspaces() -> Widget.EventBox:
    return Widget.EventBox(
        css_classes=["workspaces"],
        spacing=5,
        child=hyprland.bind_many(
            ["workspaces", "active_workspace"],
            transform=lambda workspaces, active_workspace: [
                workspace_button(i) for i in workspaces
            ],
        ),
    )


def client_title() -> Widget.Label:
    return Widget.Label(
        ellipsize="end",
        max_width_chars=40,
        label=hyprland.active_window.bind("title"),
    )
