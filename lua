local SitConnection
local AddedConnection

local PassedTime = tick()

local function Do()
	if SitConnection then SitConnection:Disconnect() SitConnection = nil end
	local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")	
	Humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
		if Humanoid.Sit == true then
			PassedTime = tick()
		end
	end)
	
	if AddedConnection then AddedConnection:Disconnect() AddedConnection = nil end
		AddedConnection = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").ChildAdded:Connect(function(child)
		if child:IsA("BodyVelocity") and child.Name == "BodyVelocity" and child.MaxForce == Vector3.new(1000000000, 1000000000, 1000000000) then
			local CurrentTime = (tick() - PassedTime)			
			if CurrentTime < 0.1 then
				game.Players.LocalPlayer.Character.Humanoid.Sit = false
			end		
			child.MaxForce = Vector3.new(0, 0, 0)
			spawn(function()
				child:Destroy()
			end)
		end
	end)
end
Do()
game.Players.LocalPlayer.CharacterAdded:Connect(function()
	Do()
end)
