
local socket = require("socket")  -- for having a sleep function ( could also use os.execute(sleep 10))
local ztimer   = require "lzmq.timer"
local monotonic = ztimer.monotonic()
function Timer(t)  
    -- create coroutine  
    local co = coroutine.create(
		function ()
			--local init = os.time()
			--local init = socket.gettime()*1000
			monotonic:start()
			--local diff=os.difftime(os.time(),init)
			--local diff=socket.gettime()*1000-init
			local diff=monotonic:elapsed()			
			while diff<t do
				print ("t:"..diff)
				coroutine.yield(diff)
				--diff=os.difftime(os.time(),init)
				--diff=socket.gettime()*1000-init
				diff=monotonic:elapsed()
			end
		end
	) 
	return co	 
    
end 
function untilTimeout(co)
	while coroutine.status(co)~="dead" do
		 --local t=socket.gettime() .. ""
		--local alltime, millisecond = t:match("^([%d]+)%.([%d]+)")
      		 
		--,os.date("%X", alltime)
	  -- print("time passed",select(1,coroutine.resume(co)))
		 --[[if alltime and millisecond and t then
	 	print("time passed (ms)",select(2,coroutine.resume(co)),"\nnow time:",os.date("%c", alltime).."."..millisecond.." ori "..t) --select return value from index 2
		
		end 
		 ]]
		-- print('',coroutine.status(co))
	    --socket.sleep(0.02)
		coroutine.resume(co)
		--ztimer.sleep(1)  --ms
	end
	monotonic:stop()
end

local BTid,seg,padding=1,1,69
local i=0
while i<10 do
local co=Timer(8)--ms
coroutine.resume(co)
--os.execute("")
local file =io.open("/home/betty/Downloads/bluetest.txt",'a')
local timestamp=socket.gettime() .. ""
local alltime, millisecond = timestamp:match("^([%d]+)%.([%d]+)")

alltime=os.date("%H%M%S",  alltime,  alltime,  alltime).."."..millisecond
 
local msg= string.format("%01d", BTid).." "..string.format("%04d", seg).." "..string.format("%.4f", alltime) .." "..string.format("%023x", padding)
--print (msg)
file:write(msg.."\n")
 

 
--os.execute("") 
local timestamp=socket.gettime() .. ""
local alltime, millisecond = timestamp:match("^([%d]+)%.([%d]+)")

alltime=os.date("%H%M%S",  alltime,  alltime,  alltime).."."..millisecond
 
local msg= string.format("%01d", BTid+3).." "..string.format("%04d", seg).." "..string.format("%.4f", alltime) .." "..string.format("%023x", padding)
--print (msg)
file:write(msg.."\n")

file:close() 
i=i+1
seg=seg+1
untilTimeout(co) 
end 

--[[
local function is_timed_out(elapsed, timeout)
  if elapsed >= timeout then return true end
  if (timeout - elapsed) < 100 then return true end
  return false, string.format("timeout expected (%d - %d) but got %d", timeout - 100, timeout, elapsed)
end 
local monotonic = ztimer.monotonic()
monotonic:start()
--socket.sleep(0.08)
ztimer.sleep(80)  --ms
local stoped = monotonic:elapsed()
print(stoped)
socket.sleep(0.08) --s
stoped = monotonic:elapsed()
print(stoped)
 ]]
