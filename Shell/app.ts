import { App } from "astal/gtk3";
import style from "./style.scss";
import { TopBar } from "./widget/Bars.js";
// Notification Widget imports
import notif_style from "./notifications-widget/Notification.scss";
import NotificationPopups from "./notifications-widget/NotificationPopup.js";

App.start({
  css: style,
  main() {
    App.get_monitors().map(TopBar);
    App.get_monitors().map(NotificationPopups);
  },
});
