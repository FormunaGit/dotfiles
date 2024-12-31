// Some small widgets for the bar
// @ts-ignore
import Battery from "gi://AstalBattery"
import { bind, exec } from "astal"

export function Divider() {
    return <box hexpand></box>;
}

export function BatteryLevel() {
    const bat = Battery.get_default()

    return <box className="Battery" visible={bind(bat, "isPresent")} tooltipText="Whatcha doin here?">
        <label label="󱊣 " />
        <label label={bind(bat, "percentage").as(p => `${Math.floor(p * 100)} %`)} />
    </box>
}

export function ClearNotifs() {
    return <button
        className="ClearNotifications"
        onClicked={exec(['makoctl', 'dismiss', '-a'])}>Clear Notifications</button>
}