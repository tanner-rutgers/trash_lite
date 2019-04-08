dofile("led_config.lua")

colors = {}
led_timer = tmr.create()
ws2812.init(ws2812.MODE_SINGLE)
buffer = ws2812.newBuffer(NUM_LEDS, 3)

function update_leds()
  print("Updating leds...")

  led_timer:unregister()

  if #colors > 1 then
    -- ws2812_effects.stop()
    cycle_colors()
  elseif #colors == 1 then
    -- ws2812_effects.stop()
    write_color(colors[1])
  else
    write_default_colors()
  end
end

function write_default_colors()
  ws2812_effects.init(buffer)
  ws2812_effects.set_speed(255)
  ws2812_effects.set_brightness(30)
  ws2812_effects.set_mode("rainbow")
  ws2812_effects.start()
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

function write_color(grb)
  print("Writing color " .. table.concat(grb, ","))
  ws2812_effects.set_mode("static")
  ws2812_effects.set_color(unpack(grb))
end

update_leds()
