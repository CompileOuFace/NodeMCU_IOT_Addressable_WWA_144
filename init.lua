
uart.setup(0,115200,8,0,1,0)
--uart.setup(0,921600,8,0,1,0)

print("Baud Rate set to 74880 by DDrmx")

print("\n")
print("NodeMCU Started")



local exefile= "Func"
local luaFile = {exefile..".lua"}
local lcFile = {exefile..".lc"}
for i, f in ipairs(luaFile) do
    if file.open(f) then
		file.close()
		for j, g in ipairs(lcFile) do
			if file.open(g) then
			  file.close()
			  file.remove(g)
			end
		end
      print("Compile File:"..f)
      node.compile(f)
      print("Remove File:"..f)
      file.remove(f)
	  
	  dofile(exefile..".lc")
		
		
    end
 end
 
exefile= "Rainbow"
luaFile = {exefile..".lua"}
lcFile = {exefile..".lc"}
 for i, f in ipairs(luaFile) do
    if file.open(f) then
		file.close()
		for j, g in ipairs(lcFile) do
			if file.open(g) then
			  file.close()
			  file.remove(g)
			end
		end
      print("Compile File:"..f)
      node.compile(f)
      print("Remove File:"..f)
      file.remove(f)
	  
	  dofile(exefile..".lc")
	  
	  
    end
 end
luaFile = nil;
lcFile = nil;

	gpio.mode(1, gpio.INPUT, gpio.PULLUP)
	if gpio.read(1) == 1 then


		local exefile= "Func"
		if file.open(exefile..".lc") then
			print(exefile..".lc non voulu")
			--dofile(exefile..".lc")
		else
			print(exefile..".lc not exist")
		end

		local exefile= "Rainbow"
		if file.open(exefile..".lc") then
			--print(exefile..".lc non voulu")
			dofile(exefile..".lc")
		else
			print(exefile..".lc not exist")
		end
	end

exefile=nil;

print("Fin de l'init")
collectgarbage()
