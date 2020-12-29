function UpdateSourie(status)
    if status then
        RMenu:Get('location', 'main').EnableMouse = true;
    else
        RMenu:Get('location', 'main').EnableMouse = false;
    end
end


function HelpMsg(msg)
	AddTextEntry('LocationNotif', msg)
	BeginTextCommandDisplayHelp('LocationNotif')
	EndTextCommandDisplayHelp(0, false, true, -1)
end



function CreateCamera()
    Wait(1)
    local coords = vector3(-257.56, -339.16, 30.19)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords)
    SetCamFov(cam, 50.0)
    PointCamAtCoord(cam, zone.x, zone.y, zone.z+1.5)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 0, 1500, 1, 1)
end