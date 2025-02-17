// @ts-ignore
import { App, Astal, Gtk, Gdk } from "astal/gtk3";
// @ts-ignore
import { bind } from "astal";
// @ts-ignore
import Hyprland from "gi://AstalHyprland";
import { Tray } from "./Tray";
import {
  Divider,
  BatteryLevel,
  ClearNotifs,
  Media,
  AudioSlider,
  Time,
} from "./Smolwidgets";

function Workspaces() {
  const hypr = Hyprland.get_default();

  return (
    // @ts-ignore
    <box className="Workspaces">
      {bind(hypr, "workspaces").as((wss: any) =>
        wss
          .filter((ws: { id: number }) => !(ws.id >= -99 && ws.id <= -2)) // filter out special workspaces
          .sort((a: { id: number }, b: { id: number }) => a.id - b.id)
          .map((ws: { focus: () => unknown; id: any }) => (
            // @ts-ignore
            <button
              className={bind(hypr, "focusedWorkspace").as((fw: any) =>
                ws === fw ? "focused" : "",
              )}
              onClicked={() => ws.focus()}
            >
              {ws.id}
              {/* @ts-ignore */}
            </button>
          )),
      )}
      {/* @ts-ignore */}
    </box>
  );
}

function FocusedClient() {
  const hypr = Hyprland.get_default();
  const focused = bind(hypr, "focusedClient");

  return (
    // @ts-ignore
    <box className="Focused" visible={focused.as(Boolean)}>
      {focused.as(
        (
          client: any, // @ts-ignore
        ) => client && <label label={bind(client, "title").as(String)} />,
      )}
      {/* @ts-ignore */}
    </box>
  );
}

export function TopBar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;
  return (
    <window
      className="TopBar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <box hexpand>
        <box halign={Gtk.Align.START}>
          <ClearNotifs />
          <Workspaces />
        </box>
        <Divider />

        <box halign={Gtk.Align.END}>
          <box className="Tray">
            <AudioSlider />
            <Time />
            <BatteryLevel />
            <Tray />
          </box>
        </box>
      </box>
    </window>
  );
}
