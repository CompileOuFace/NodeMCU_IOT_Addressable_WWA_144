-- Copyright (c) 2015 by Geekscape Pty. Ltd.  Licence LGPL V3.
--
-- http://www.esp8266.com/viewtopic.php?f=21&t=1143

BRIGHT     = 128--1 -- 64

ON         = 1 * 255


BUTTON_PIN = 3       -- GPIO0
LED_PIN    = 2       -- GPIO2 => pin D4
--ws2812.init()

NB_LED = 59

PIXELS     = 8
TIME_ALARM = 25      -- 0.025 second, 40 Hz
TIME_SLOW  = 500000  -- 0.500 second,  2 Hz


gpio.mode(BUTTON_PIN, gpio.INPUT, gpio.PULLUP)

function colourWheel(index)
  if index < 85 then
    return string.char(index * 3 / BRIGHT, (255 - index * 3) / BRIGHT, 0)
  elseif index < 170 then
    index = index - 85
    return string.char((255 - index * 3) / BRIGHT, 0, index * 3 / BRIGHT)
  else
    index = index - 170
    return string.char(0, index * 3 / BRIGHT, (255 - index * 3) / BRIGHT)
  end
end


function rainbow10led(index)

rainbow_speed = 28
  buffer = ""
  tmr.wdclr()
  for pixel = 0, NB_LED do
    buffer = buffer .. colourWheel((index + pixel * rainbow_speed) % 256)
  end
  --buffer = string.char(0,0,0,0)..buffer --resolved -- Verrue v0.94
  return buffer
end

function rainbowStrip(index)
	
rainbow_speed = 1
  buffer = ""
  tmr.wdclr()
  for pixel = 0, NB_LED do
    buffer = buffer .. colourWheel((index + pixel * rainbow_speed) % 256)
  end
  --buffer = string.char(0,0,0,0)..buffer --resolved -- Verrue v0.94
  return buffer
end

function HSV_1(index)
	
rainbow_speed = 1
  
  return colourWheel((index* rainbow_speed) % 256)
end

rainbow_index = 0
previous =0
cycle = 0

function rainbowHandler()
 
  if (rainbow_index+1 >= 255) then
		cycle=cycle+1
	end
		
	if (cycle < 3) then
		WHITE		=0
	else
		WHITE		=255
	end
	
	ws2812.write(LED_PIN, "\0\0\0") -- Verrue v0.94
	ws2812.write(LED_PIN, string.rep(HSV_1(rainbow_index),NB_LED))
	ws2812.write(LED_PIN, "\0\0\0") -- Verrue v0.94
	
   
	
	
    rainbow_index = (rainbow_index + 1) % 256
	
  
    print("rainbow"..(tmr.now()-previous)/1000);
	previous=tmr.now()
	--print(tmr.now());
  tmr.alarm(1, 200, tmr.ALARM_SINGLE, rainbowHandler)--tmr,temps,mode,fct
end


tmr.alarm(1, 500, tmr.ALARM_SINGLE, rainbowHandler)
