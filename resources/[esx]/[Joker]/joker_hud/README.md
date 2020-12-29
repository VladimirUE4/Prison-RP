2)  Esx_status client > main.lua  52
```
	Citizen.CreateThread(function()
	  while true do

	  	for i=1, #Status, 1 do
	  		Status[i].onTick()
	  	end

			SendNUIMessage({
				update = true,
				status = GetStatusData()
			})
		TriggerEvent('stx_fwui:updateStatus', GetStatusData(true)) 
	    Citizen.Wait(Config.TickTime)

	  end
	end)

end)
```
