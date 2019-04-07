function startup()
  if file.exists("config.lua") then
    print("Loading config.lua...")
    dofile("config.lua")
    print("Loaded config.lua.")

    -- config.lua must define `FILES`
    for n,f in pairs(FILES) do
      print("Looking for " .. f .. "...")
      if file.exists(f) then
        print("Found " .. f .. "; loading...")
        dofile(f)
      else
        print("No file named " .. f .. "; skipping.")
      end
    end
  else
    print("Could not find config.lua; please help a brother out...")
  end
end

-- wait a bit so we can flash this thing out of a restart loop
timer = tmr.create()
timer:alarm(5000, tmr.ALARM_SINGLE, startup)
