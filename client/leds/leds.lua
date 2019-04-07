dofile("led_config.lua")

function initialize_leds()
  ws2812.init(ws2812.MODE_SINGLE)

  strip_buffer = ws2812.newBuffer(NUM_LEDS, 3)

  ws2812_effects.init(strip_buffer)
  ws2812_effects.set_speed(INITIAL_LEDS.SPEED)
  ws2812_effects.set_brightness(INITIAL_LEDS.BRIGHTNESS)
  ws2812_effects.set_mode(INITIAL_LEDS.MODE)
  ws2812_effects.start()
end

initialize_leds()
