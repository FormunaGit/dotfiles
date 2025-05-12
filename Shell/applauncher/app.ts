// @ts-ignore
import { App } from "astal/gtk3"
import style from "./Launcher.scss"
import Applauncher from "./Launcher"

App.start({
    instanceName: "launcher",
    css: style,
    main: Applauncher,
})