// Some small widgets for the bar
// @ts-ignore
import Battery from "gi://AstalBattery";
import { bind, execAsync } from "astal";
import Gdk from "gi://Gdk?version=3.0";
import Mpris from "gi://AstalMpris";
import Wp from "gi://AstalWp";
import { GLib, Variable } from "astal";

export function Time({ format = "%I:%M %p - %a, %b %d" }) {
  const time = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(format)!,
  );

  return (
    <label
      className="RoundWidget"
      onDestroy={() => time.drop()}
      label={time()}
    />
  );
}
export function Divider(): any {
  return <box hexpand></box>;
}

export function AudioSlider() {
  const speaker = Wp.get_default()?.audio.defaultSpeaker!;

  return (
    <box className="AudioSlider RoundWidget" css="min-width: 140px">
      <icon icon={bind(speaker, "volumeIcon")} />
      <slider
        hexpand
        onDragged={({ value }) => (speaker.volume = value)}
        value={bind(speaker, "volume")}
      />
    </box>
  );
}

function BatteryLevelIcon() {
  let batteryLevel = bind(Battery.get_default(), "percentage").as(
    (p) => `${Math.floor(p * 100)} %`,
  );
  if (batteryLevel >= 70) {
    return "󱊣";
  } else if (batteryLevel >= 40) {
    return "󱊢";
  } else if (batteryLevel >= 20) {
    return "󱊡";
  }
}

export function BatteryLevel() {
  const bat = Battery.get_default();

  return (
    <box
      className="RoundWidget"
      visible={bind(bat, "isPresent")}
      tooltipText="Whatcha doin here?"
    >
      <label label="󱊣 " />
      <label
        label={bind(bat, "percentage").as((p) => `${Math.floor(p * 100)} %`)}
      />
    </box>
  );
}

export function ClearNotifs() {
  return (
    <button
      className="RoundWidget"
      onClick={(_, event) => {
        if (event.button === Gdk.BUTTON_PRIMARY) {
          execAsync(`makoctl dismiss -a`);
        }
      }}
    >
      CN
    </button>
  );
}

export function Media() {
  const mpris = Mpris.get_default();

  return (
    <box className="RoundWidget">
      {bind(mpris, "players").as((ps) =>
        ps[0] ? (
          <box>
            <label
              label={bind(ps[0], "title").as(
                () => `${ps[0].title} - ${ps[0].artist}`,
              )}
            />
          </box>
        ) : (
          "Nothing Playing"
        ),
      )}
    </box>
  );
}
