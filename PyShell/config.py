from ignis.widgets import Widget
from ignis.utils import Utils
from ignis.app import IgnisApp

# Utility modules
from Utils.Hyprland import workspaces, client_title
from Utils.Media import speaker_volume, speaker_slider
from Utils.System import clock, battery_level, tray, power_menu, icon_list

app = IgnisApp.get_default()

# Apply the SCSS file
app.apply_css(f"{Utils.get_current_dir()}/style.scss")


#############
# ┓ ┏┓┏┓┏┳┓ #
# ┃ ┣ ┣  ┃  #
# ┗┛┗┛┻  ┻  #
#############
def left(monitor_name: str) -> Widget.Box:
    return Widget.Box(
        child=[
            icon_list("nixos", True),
            client_title(),
            # icon_client_title(),
            Widget.Separator(vertical=True, css_classes=["middle-separator"]),
        ],
        spacing=10,
    )


#################
# ┏┓┏┓┳┓┏┳┓┏┓┳┓ #
# ┃ ┣ ┃┃ ┃ ┣ ┣┫ #
# ┗┛┗┛┛┗ ┻ ┗┛┛┗ #
#################
def center() -> Widget.Box:
    return Widget.Box(
        child=[
            Widget.Separator(vertical=True, css_classes=["middle-separator"]),
            workspaces(),
            Widget.Separator(vertical=True, css_classes=["middle-separator"]),
        ],
        spacing=10,
    )


##############
# ┳┓┳┏┓┓┏┏┳┓ #
# ┣┫┃┃┓┣┫ ┃  #
# ┛┗┻┗┛┛┗ ┻  #
##############
def right() -> Widget.Box:
    return Widget.Box(
        child=[
            Widget.Separator(vertical=True, css_classes=["middle-separator"]),
            battery_level(),
            clock(),
            speaker_volume(),
            speaker_slider(),
            tray(),
            power_menu(),
        ],
        spacing=10,
    )


def bar(monitor_id: int = 0) -> Widget.Window:
    monitor_name = Utils.get_monitor(monitor_id).get_connector()
    return Widget.Window(
        namespace=f"ignis_bar_{monitor_id}",
        monitor=monitor_id,
        anchor=["left", "top", "right"],
        exclusivity="exclusive",
        child=Widget.CenterBox(
            css_classes=["bar"],
            start_widget=left(monitor_name),
            center_widget=center(),
            end_widget=right(),
        ),
    )


# this will display bar on all monitors
for i in range(Utils.get_n_monitors()):
    bar(i)
