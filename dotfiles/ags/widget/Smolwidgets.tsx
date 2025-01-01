// Some small widgets for the bar
// @ts-ignore
import Battery from "gi://AstalBattery"
import { bind, execAsync } from "astal"
import Gdk from "gi://Gdk?version=3.0";

export function Divider() {
    return <box hexpand></box>;
}

function BatteryLevelIcon() {
    let batteryLevel = bind(Battery.get_default(), "percentage").as(p => `${Math.floor(p * 100)} %`)
    if (batteryLevel >= 70) {
        return "󱊣"
    }else if (batteryLevel >= 40) {
        return "󱊢"
    }else if (batteryLevel >= 20) {
        return "󱊡"
    }
}

export function BatteryLevel() {
    const bat = Battery.get_default()

    return <box className="Battery" visible={bind(bat, "isPresent")} tooltipText="Whatcha doin here?">
        <label label="󱊣 " />
        <label label={bind(bat, "percentage").as(p =>
            `${Math.floor(p * 100)} %`
        )}/></box>
}

export function ClearNotifs() {
    return <button
        className="ClearNotifications"
        onClick={(_, event) =>{ if (event.button === Gdk.BUTTON_PRIMARY){ execAsync(`makoctl dismiss -a`) }}}
    >Clear Notifications</button>
}