import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { bind } from "astal"
// @ts-ignore
import Hyprland from "gi://AstalHyprland"
import { Tray } from "./tray"
import { Divider, BatteryLevel, ClearNotifs } from "./Smolwidgets"

function Workspaces() {
    const hypr = Hyprland.get_default()

    return <box className="Workspaces">
        {bind(hypr, "workspaces").as(wss => wss
            .filter((ws: { id: number }) => !(ws.id >= -99 && ws.id <= -2)) // filter out special workspaces
            .sort((a: { id: number }, b: { id: number }) => a.id - b.id)
            .map((ws: { focus: () => unknown; id: any }) => (
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

function FocusedClient() {
    const hypr = Hyprland.get_default()
    const focused = bind(hypr, "focusedClient")

    return <box
        className="Focused"
        visible={focused.as(Boolean)}>
        {focused.as(client => (
            client && <label label={bind(client, "title").as(String)} />
        ))}
    </box>
}

export function TopBar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
    return <window className="Top Bar" gdkmonitor={gdkmonitor} exclusivity={Astal.Exclusivity.EXCLUSIVE} anchor={TOP | LEFT | RIGHT} application={App}>
        <box hexpand>
            <box halign={Gtk.Align.START}>
                <Workspaces/>
            </box>
            <Divider/>

            <FocusedClient/>

            <Divider/>
            <box halign={Gtk.Align.END}>
                <box className="Tray">
                    <Tray/>
                </box>
            </box>
        </box>
    </window>
}

export function BottomBar(gdkmonitor: Gdk.Monitor) {
    const { BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor
    return <window className="Bottom Bar" gdkmonitor={gdkmonitor} exclusivity={Astal.Exclusivity.EXCLUSIVE} anchor={BOTTOM | LEFT | RIGHT} application={App}>
        <box hexpand>
            <box halign={Gtk.Align.START}>
                <BatteryLevel/>
            </box>
            <Divider/>
            <box halign={Gtk.Align.END}>
                <ClearNotifs/>
            </box>
        </box>
    </window>
}