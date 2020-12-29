Map = {

    {name="Penitencier",color=39, id=188, x=1713.78, y=2559.93, z=45.56},


  }









Citizen.CreateThread(function()

	

	for i=1, #Map, 1 do

		local blip = AddBlipForCoord(Map[i].x, Map[i].y, Map[i].z) 

    	SetBlipSprite (blip, Map[i].id)

    	SetBlipDisplay(blip, 4)

    	SetBlipScale  (blip, 1.0)

    	SetBlipColour (blip, Map[i].color)

    	SetBlipAsShortRange(blip, true)

  		BeginTextCommandSetBlipName("STRING") 

  		AddTextComponentString(Map[i].name)

		EndTextCommandSetBlipName(blip)



		local zoneblip = AddBlipForRadius(Map[i].x, Map[i].y, Map[i].z, 800.0)

		SetBlipSprite(zoneblip,1)

		SetBlipColour(zoneblip,Map[i].color)

		SetBlipAlpha(zoneblip,100)

	end

end)