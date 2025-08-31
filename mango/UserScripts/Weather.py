#!/usr/bin/env python3
# weather using python

import requests
import json
import os
from datetime import datetime
from bisect import bisect_left

# weather icons
weather_icons = {
    "sunnyDay": "󰖙",
    "clearNight": "󰖔",
    "cloudyFoggyDay": "",
    "cloudyFoggyNight": "",
    "rainyDay": "",
    "rainyNight": "",
    "snowyIcyDay": "",
    "snowyIcyNight": "",
    "severe": "",
    "default": "",
}

# Get current location based on IP address
def get_location():
    response = requests.get("https://ipinfo.io?token=095e65ba6e9ddc")
    data = response.json()
    loc = data["loc"].split(",")
    return float(loc[0]), float(loc[1]), data.get("city", "Unknown")
  

def find_nearest_hour_index(times, target_time):
    dt_list = [datetime.fromisoformat(t) for t in times]
    target_dt = datetime.fromisoformat(target_time)

    pos = bisect_left(dt_list, target_dt)
    if pos == 0:
        return 0
    if pos == len(dt_list):
        return len(dt_list) - 1
    before = dt_list[pos - 1]
    after = dt_list[pos]
    if abs(after - target_dt) < abs(target_dt - before):
        return pos
    else:
        return pos - 1


latitude, longitude, city = get_location()


url = (
    f"https://api.open-meteo.com/v1/forecast?"
    f"latitude={latitude}&longitude={longitude}"
    f"&current_weather=true"
    f"&hourly=temperature_2m,relative_humidity_2m,visibility,wind_speed_10m,precipitation_probability"
    f"&daily=temperature_2m_max,temperature_2m_min"
    f"&timezone=auto"
)

data = requests.get(url).json()
current = data["current_weather"]

temp = f"{current['temperature']}°C"

wind_text = f"  {current['windspeed']} km/h"

code = current["weathercode"]
status_map = {
    0: "Sunny",
    1: "Mainly Clear",
    2: "Partly Cloudy",
    3: "Cloudy",
    45: "Fog",
    48: "Fog",
    51: "Light Drizzle",
    61: "Rain",
    63: "Rain Showers",
    71: "Snow",
    80: "Rain Showers",
    95: "Thunderstorm",
}
status = status_map.get(code, "Unknown")

if code == 0:
    icon = weather_icons["sunnyDay"]
elif code in (1, 2, 3, 45, 48):
    icon = weather_icons["cloudyFoggyDay"]
elif code in (51, 61, 63, 80, 95):
    icon = weather_icons["rainyDay"]
elif code in (71,):
    icon = weather_icons["snowyIcyDay"]
else:
    icon = weather_icons["default"]

temp_feel_text = f"Feels like {temp}"

temp_min = f"{data['daily']['temperature_2m_min'][0]}°C"
temp_max = f"{data['daily']['temperature_2m_max'][0]}°C"
temp_min_max = f"  {temp_min}\t\t  {temp_max}"

hour_index = find_nearest_hour_index(data["hourly"]["time"], current["time"])

humidity = data["hourly"]["relative_humidity_2m"][hour_index]
humidity_text = f"  {humidity}%"

visibility = data["hourly"]["visibility"][hour_index] / 1000
visibility_text = f"  {visibility:.1f} km"

rain_probs = data["hourly"]["precipitation_probability"][hour_index:hour_index+6]
prediction = f" (hourly) {rain_probs}" if rain_probs else ""

try:
    aqi_url = (
        f"https://air-quality-api.open-meteo.com/v1/air-quality?"
        f"latitude={latitude}&longitude={longitude}&current=us_aqi"
    )
    aqi_data = requests.get(aqi_url).json()
    air_quality_index = aqi_data["current"]["us_aqi"]
except Exception:
    air_quality_index = "N/A"

tooltip_text = str.format(
    "\t\t{}\t\t\n{}\n{}\n{}\n\n{}\n{}\n{}{}",
    f'<span size="xx-large">{temp}</span>',
    f"<big> {icon}</big>",
    f"<b>{status}</b>",
    f"<small>{temp_feel_text}</small>",
    f"<b>{temp_min_max}</b>",
    f"{wind_text}\t{humidity_text}",
    f"{visibility_text}\tAQI {air_quality_index}",
    f"<i> {prediction}</i>",
)

out_data = {
    "text": f"{icon}  {temp}",
    "alt": status,
    "tooltip": tooltip_text,
    "class": str(code),
}
print(json.dumps(out_data))

simple_weather = (
    f"{icon}  {status}\n"
    + f"  {temp} ({temp_feel_text})\n"
    + f"{wind_text} \n"
    + f"{humidity_text} \n"
    + f"{visibility_text} AQI {air_quality_index}\n"
)

try:
    with open(os.path.expanduser("~/.cache/.weather_cache"), "w") as file:
        file.write(simple_weather)
except Exception as e:
    print(f"Error writing to cache: {e}")

