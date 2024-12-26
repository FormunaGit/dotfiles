import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, GLib, bind } from "astal"
import Hyprland from "gi://AstalHyprland"
function Workspaces() {
    const hypr = Hyprland.get_default()

    return <box className="Workspaces">
        {bind(hypr, "workspaces").as(wss => wss
            .filter(ws => !(ws.id >= -99 && ws.id <= -2)) // filter out special workspaces
            .sort((a, b) => a.id - b.id)
            .map(ws => (
                <button
                    className={bind(hypr, "focusedWorkspace").as(fw =>
                        ws === fw ? "focused" : "")}
                    onClicked={() => ws.focus()}>
                    {ws.id}
                </button>
            ))
        )}
    </box>
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
    return <window className="Bar" gdkmonitor={gdkmonitor} exclusivity={Astal.Exclusivity.EXCLUSIVE} anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT} application={App}>
        <box halign={Gtk.Align.START}>
            <label label='Hello' />
        </box>
    </window>
}
