
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
				--print ("t:"..diff)
				coroutine.yield(diff)
				--diff=os.difftime(os.time(),init)
				--diff=socket.gettime()*1000-init
				diff=monotonic:elapsed()
			end
		end
	) 
	return co	 
    
end 
function nicetime(s)
    local l = "s"
    if s > 60 then
        s = s / 60
        l = "m"
        if s > 60 then
            s = s / 60
            l = "h"
            if s > 24 then
                s = s / 24
                l = "d" -- hmmm
            end
        end
    end
    if l == "s" then return string.format("%5.0f%s", s, l)
    else return string.format("%5.2f%s", s, l) end
end
function untilTimeout(co)
	while coroutine.status(co)~="dead" do
		local t=socket.gettime() .. ""
		local alltime, millisecond = t:match("^([%d]+)%.([%d]+)")
      		 
		--,os.date("%X", alltime)
	  -- print("time passed",select(1,coroutine.resume(co)))
		if alltime and millisecond and t then
	 	print("time passed (ms)",select(2,coroutine.resume(co)),"\nnow time:",os.date("%x %X", alltime, alltime).."."..millisecond.." ori "..t) --select return value from index 2
		
		end	   
		-- print('',coroutine.status(co))
	    --socket.sleep(0.02)
		ztimer.sleep(10)  --ms
	end
	monotonic:stop()
end

local BTid,seg,timestamp,padding=1,12,13,69
local msg= string.format("%01d", BTid)..string.format("%04d", seg)..string.format("%04d", timestamp)..string.format("%023d", padding)
print (msg)
--[[
print (socket.gettime())
socket.sleep(0.001)
print (socket.gettime())
socket.sleep(0.08)
print (socket.gettime())
]]  
local co=Timer(83)--ms
coroutine.resume(co)
--os.execute("")
local file =io.open("/home/betty/Downloads/bluetest.txt",'a')
file:write(msg.."\n")

file:close()

untilTimeout(co) 


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
