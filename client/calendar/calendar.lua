dofile("calendar_config.lua")

function update_leds_from_calendar()
  print("Getting calendar data...")
  http.get(CALENDAR_SCRIPT_URL, nil, function(code, response)
    if (code == 200) then
      print("Fetching calendar successful, response = " .. response)
      local data = sjson.decode(response)
      update_leds_from_garbage_data(data)
    else
      print("Failed to fetch calendar, status = " .. code .. ", response = " .. (response or ""))
    end
  end)
end

function update_leds_from_garbage_data(data)
  local colors = {}
  for k,v in pairs(data) do
    if (v) then
      table.insert(colors, BIN_COLORS[k])
    end
  end

  update_led_colors(colors)
end

tmr.create():alarm(1000 * 60, 1, update_leds_from_calendar)
