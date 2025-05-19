import subprocess
import os
import time


def cmder(command: str):
    return command.split(' ')


while True:
    battery_level = subprocess.check_output(["cat", "/sys/class/power_supply/BAT0/capacity"])  # noqa: E501
    battery_level = battery_level.decode('utf-8').replace("\n", "")

    is_charging = subprocess.check_output(["cat", "/sys/class/power_supply/BAT0/capacity"])  # noqa: E501
    is_charging = battery_level.replace("\n", "")
    if battery_level < "20" and is_charging != "Charging":
        os.system(f'notify-send -u critical "BATTERY WARNING!!!" "Please charge your laptop! It is at {battery_level}%!"')  # noqa: E501
    time.sleep(1)
