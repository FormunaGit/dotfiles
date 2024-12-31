import { App } from "astal/gtk3"
import style from "./style.scss"
import { TopBar, BottomBar } from "./widget/Bars"

App.start({
    css: style,
    main() {
        App.get_monitors().map(TopBar)
        App.get_monitors().map(BottomBar)
    },
})
