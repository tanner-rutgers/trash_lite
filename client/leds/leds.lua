dofile("led_config.lua")

colors = {}
led_timer = tmr.create()
ws2812.init(ws2812.MODE_SINGLE)

function update_leds()
  print("Updating leds...")

  led_timer:unregister()

  if #colors > 1 then
    cycle_colors()
  elseif #colors == 1 then
    write_color(colors[1])
  else
    write_default_colors()
  end
end

function write_default_colors()
  write_color(DEFAULT_COLOR)
end

function update_led_colors(new_colors)
  if sjson.encode(colors) == sjson.encode(new_colors) then
    print("New colors same as current, not updating...")
  else
    print("New colors received, updating...")
    colors = new_colors
    update_leds()
  end
end

function cycle_colors()
  print("Cycling colors...")
  color_index = 0

  led_timer:alarm(2000, 1, function()
    color_index = color_index + 1
    if color_index > #colors then color_index = 1 end

    write_color(colors[color_index])
  end)
end

function write_color(color)
  local grb = { unpack(color) }
  print("Writing color " .. table.concat(grb, ","))
  for i=1, NUM_LEDS do
    for j = 1, 3 do
      table.insert(grb, 0)
    end
  end
  ws2812.write(string.char(unpack(grb)))
end

update_leds()
