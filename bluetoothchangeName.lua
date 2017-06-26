
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
		ztimer.sleep(1)  --ms
	end
	monotonic:stop()
end
local limit=20 --ms
while true do
local i=0
local seg,Signature,padding=1,"AA55","74657374"

while i<10 do
  local co=Timer(limit)--ms
  coroutine.resume(co)
  local timestamp=socket.gettime() .. ""
  timestamp=string.format("%.4f", timestamp)
  local alltime, millisecond = timestamp:match("^([%d]+)%.([%d]+)")

  alltime=os.date("%H%M%S",  alltime,  alltime,  alltime) .. millisecond
  local msg= string.format("%04x", seg) ..string.format("%08x", alltime)  ..Sig$

  os.execute("sudo echo -e 'AT+BTN="..msg.."\r\n' > /dev/ttyUSB1")
  untilTimeout(co)
  i=i+1
  seg=seg+1

end
end


