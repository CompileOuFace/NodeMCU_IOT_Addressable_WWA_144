passage=0

longueur=60*4;
CouleurEffet=0;
LedEffet=0;
Plafond=0;


stripPin = 2
resetPin = 4
strobePin = 6


leds_rgbw={}
for i=0,longueur do leds_rgbw[i] = 0 end

ficelle= string.char(0,0)

function LedsReadWrite ()


	if LedEffet<longueur-Plafond then
		LedEffet=LedEffet+4
		--print("Led ")
		--print(LedEffet )
	else
		--print("Led ")
		--print(LedEffet )
		
		LedEffet=0;
		if(Plafond<longueur)then
			Plafond=Plafond+4
		else
			Plafond=0
			if(CouleurEffet>=3)then
				CouleurEffet=0
			else
				CouleurEffet=CouleurEffet+1
				print("Couleur ")
			end
		end
		
		--print("Plafond ")
		--print(Plafond )
	end
	
	
	ficelle= string.char(0,0,0,0)
	
	for i=0,LedEffet+CouleurEffet do 
		
		thisled =string.char(0) 
		if (LedEffet+CouleurEffet %4 >CouleurEffet) then
			thisled =string.char(3)			
		elseif(i==LedEffet+CouleurEffet)then
			thisled =string.char(3) 
		elseif (i== LedEffet+CouleurEffet-4) then
			thisled =string.char(0) 
		end
		
		ficelle= ficelle..thisled 
		--ficelle= ficelle..tostring(leds_rgbw[i]-'0')
	
	end
	
	--tmr.wdclr()
	
     ws2812.write(stripPin,ficelle)
	 ficelle = nil;
	tmr.alarm(3, 500, tmr.ALARM_SINGLE, LedsReadWrite)--tmr,mode,temps,fct
end 

lastVal = {0,0,0,0,0,0,0}
gpio.mode(resetPin, gpio.OUTPUT)  
gpio.mode(strobePin, gpio.OUTPUT) 
gpio.mode(stripPin,gpio.OUTPUT)
gpio.write(resetPin, gpio.LOW)
gpio.write(strobePin, gpio.HIGH)
movingIdx=1
tmr.alarm(3, 500, tmr.ALARM_SINGLE, LedsReadWrite) --tmr,temps,mode,fct
