import { bind, Variable } from "astal";
// @ts-ignore
import AstalTray from "gi://AstalTray"

export const trayVisible = Variable(true);

export const Tray = () => {
    const tray = AstalTray.get_default()
    bind(tray, "items").as(items => {
        trayVisible.set(items.length != 0);
    })
    return <box className="RoundWidget">
        {bind(tray, "items").as(items => items.map(item => (
            <menubutton
                className="RoundWidget"
                tooltipMarkup={bind(item, "tooltipMarkup")}
                usePopover={false}
                actionGroup={bind(item, "action-group").as(ag => ["dbusmenu", ag])}
                menuModel={bind(item, "menu-model")}>
                <icon gicon={bind(item, "gicon")} />
            </menubutton>
        )))}
    </box>
}
