
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
function checksum(str)
	local t = {}
	local j=1
	for i=1,#str do
	
		 t[j] = str:sub(i, i)
		j=j+1
		if ((i%2) == 0) then 
			t[j] = " "
			j=j+1 
		end 
	end
	str=table.concat(t,"")
	local i=1
	t = {}
	local cksum=0x00	
	for str in string.gmatch(str, "([0-9a-fA-F]+)%s+") do
                t[i] = "0x"..str
		print ("H: "..t[i].." ")
                i = i + 1
		
        end
	for i=1,#t do
                cksum = (cksum ~ tonumber(t[i]))  
        end
	
	return cksum
	
end
local limit=100 --ms 
local BTid,seg,Signature,padding=1,1,"AA55","7465737420737472696e67206e6f20"
local i=0
while i<120 do
local file =io.open("/home/betty/Downloads/bluetest.txt",'a')
local co=Timer(limit)--ms
coroutine.resume(co)  
local timestamp=socket.gettime() .. ""
timestamp=string.format("%.4f", timestamp)
local alltime, millisecond = timestamp:match("^([%d]+)%.([%d]+)")

alltime=os.date("%H%M%S",  alltime,  alltime,  alltime) .. millisecond
 
local msg= string.format("%02x", BTid) ..string.format("%08x", seg) ..string.format("%08x", alltime)  ..Signature..padding..string.format("%08x", seg)..string.format("%02x",checksum(padding..string.format("%08x", seg)))
--print (msg)
local j=1
local t = {}
for i=1,#msg do
	
	 t[j] = msg:sub(i, i)
	j=j+1
	if ((i%2) == 0) then 
		t[j] = " "
		j=j+1 
	end 
end
msg =  table.concat(t,"")
file:write(msg.."\n")
 

  
local timestamp=socket.gettime() .. ""
timestamp=string.format("%.4f", timestamp)
local alltime, millisecond = timestamp:match("^([%d]+)%.([%d]+)")

alltime=os.date("%H%M%S",  alltime,  alltime,  alltime) ..millisecond
 
local msg= string.format("%02x", BTid+1) ..string.format("%08x", seg) ..string.format("%08x", alltime)  ..Signature..padding..string.format("%08x", seg)..string.format("%02x",checksum(padding..string.format("%08x", seg)))
--print (msg)
local j=1
local t = {}
for i=1,#msg do
	
	 t[j] = msg:sub(i, i)
	j=j+1
	if ((i%2) == 0) then 
		t[j] = " "
		j=j+1 
	end 
end
msg =  table.concat(t,"")
file:write(msg.."\n")

local timestamp=socket.gettime() .. ""
timestamp=string.format("%.4f", timestamp)
local alltime, millisecond = timestamp:match("^([%d]+)%.([%d]+)")

alltime=os.date("%H%M%S",  alltime,  alltime,  alltime) ..millisecond
 
local msg= string.format("%02x", BTid+2) ..string.format("%08x", seg) ..string.format("%08x", alltime)  ..Signature..padding..string.format("%08x", seg)..string.format("%02x",checksum(padding..string.format("%08x", seg)))
--print (msg)
local j=1
local t = {}
for i=1,#msg do
	
	 t[j] = msg:sub(i, i)
	j=j+1
	if ((i%2) == 0) then 
		t[j] = " "
		j=j+1 
	end 
end
msg =  table.concat(t,"")
file:write(msg.."\n\n")

 

untilTimeout(co) 


local co=Timer(limit)--ms
coroutine.resume(co) 

local timestamp=socket.gettime() .. ""
timestamp=string.format("%.4f", timestamp)
local alltime, millisecond = timestamp:match("^([%d]+)%.([%d]+)")

alltime=os.date("%H%M%S",  alltime,  alltime,  alltime) ..millisecond
 
local msg= string.format("%02x", BTid+3) ..string.format("%08x", seg) ..string.format("%08x", alltime)  ..Signature..padding..string.format("%08x", seg)..string.format("%02x",checksum(padding..string.format("%08x", seg)))
--print (msg)
local j=1
local t = {}
for i=1,#msg do
	
	 t[j] = msg:sub(i, i)
	j=j+1
	if ((i%2) == 0) then 
		t[j] = " "
		j=j+1 
	end 
end
msg =  table.concat(t,"")
file:write(msg.."\n")
 

  
local timestamp=socket.gettime() .. ""
timestamp=string.format("%.4f", timestamp)
local alltime, millisecond = timestamp:match("^([%d]+)%.([%d]+)")

alltime=os.date("%H%M%S",  alltime,  alltime,  alltime)..millisecond
 
local msg= string.format("%02x", BTid+4) ..string.format("%08x", seg) ..string.format("%08x", alltime)  ..Signature..padding..string.format("%08x", seg)..string.format("%02x",checksum(padding..string.format("%08x", seg)))
--print (msg)
local j=1
local t = {}
for i=1,#msg do
	
	 t[j] = msg:sub(i, i)
	j=j+1
	if ((i%2) == 0) then 
		t[j] = " "
		j=j+1 
	end 
end
msg =  table.concat(t,"")
file:write(msg.."\n")

local timestamp=socket.gettime() .. ""
timestamp=string.format("%.4f", timestamp)
local alltime, millisecond = timestamp:match("^([%d]+)%.([%d]+)")

alltime=os.date("%H%M%S",  alltime,  alltime,  alltime)..millisecond
 
local msg= string.format("%02x", BTid+5) ..string.format("%08x", seg) ..string.format("%08x", alltime)  ..Signature..padding..string.format("%08x", seg)..string.format("%02x",checksum(padding..string.format("%08x", seg)))
--print (msg)
local j=1
local t = {}
for i=1,#msg do
	
	 t[j] = msg:sub(i, i)
	j=j+1
	if ((i%2) == 0) then 
		t[j] = " "
		j=j+1 
	end 
end
msg =  table.concat(t,"")
file:write(msg.."\n\n")


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
