from ignis.services.mpris import MprisService, MprisPlayer
from ignis.widgets import Widget
from ignis.services.audio import AudioService

mpris = MprisService.get_default()
audio = AudioService.get_default()


def mpris_title(player: MprisPlayer) -> Widget.Box:
    return Widget.Box(
        spacing=10,
        setup=lambda self: player.connect(
            "closed",
            lambda x: self.unparent(),  # remove widget when player is closed
        ),
        child=[
            Widget.Icon(image="audio-x-generic-symbolic"),
            Widget.Label(
                ellipsize="end",
                max_width_chars=20,
                label=player.bind("title"),
            ),
        ],
    )


def media() -> Widget.Box:
    return Widget.Box(
        spacing=10,
        child=[
            Widget.Label(
                label="No media players",
                visible=mpris.bind("players", lambda value: len(value) == 0),
            )
        ],
        setup=lambda self: mpris.connect(
            "player-added", lambda x, player: self.append(mpris_title(player))
        ),
    )


def speaker_volume() -> Widget.Box:
    return Widget.Box(
        child=[
            Widget.Icon(
                image=audio.speaker.bind("icon_name"),
                style="margin-right: 5px;",
            ),
            Widget.Label(
                label=audio.speaker.bind(
                    "volume", transform=lambda value: str(value)
                )
            ),
            Widget.Label(label="%"),
        ]
    )


def speaker_slider() -> Widget.Scale:
    return Widget.Scale(
        min=0,
        max=100,
        step=5,
        value=audio.speaker.bind("volume"),
        on_change=lambda x: audio.speaker.set_volume(x.value),
        css_classes=["volume-slider"],  # we will customize style in style.css
    )
