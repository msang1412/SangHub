


getgenv().remilia = {
	["Cache"] = {},
	["Script Config"] = {
		["Name"] = "remilia",
	},
	["Script Tasks"] = {
		"Idling",
		"Idling"
	}
}
LocalPlayer = game.Players.LocalPlayer
_G.loadstringMode = true
repeat
	wait()
	pcall(function()
		for i, v in pairs(getconnections(LocalPlayer.PlayerGui.Main.ChooseTeam.Container['Pirates'].Frame.TextButton.Activated)) do
			v.Function()
		end
	end)
until tostring(LocalPlayer.Team) ~= 'Natural'
    
repeat
	wait(1)
	print(" Functions - Waiting models")
until getgenv().remilia

print("OK Modules: Functions")

function FireRemotes(type, ...)
	gg0 = ({
		"CommF_",
		"Redeem"
	})[type]
	return game:GetService("ReplicatedStorage").Remotes[gg0]:InvokeServer(unpack({
		...
	}))
end

function PositionParser(type, ooooooo)
	return loadstring("return " .. type .. ".new(" .. ooooooo.x .. "," .. ooooooo.y .. "," .. ooooooo.z .. ")")() -- vai
end

function CheckCocoaRequirements()
	return getgenv().remilia.Data["Player Inventory"]["Mirror Fractal"] or (getgenv().remilia.Data["Player Inventory"]["Conjured Cocoa"] or {
		Count = 0
	}).Count > 10
end 

function Cocoa()
	return chotung2({
		"Chocolate Bar Battler",
		"Cocoa Warrior"
	})
end 

function CheckDoughKingRequirements()
	if getgenv().remilia.Data["Player Inventory"]["Mirror Fractal"] then
		return
	end
	return (GetBackpack("God's Chalice") and CheckCocoaRequirements()) or GetBackpack("Sweet Chalice")
end 

function DoughKing()
	if not GetBackpack("Sweet Chalice") then
		FireRemotes(1, "SweetChaliceNpc")
	end
	chotung2({
		"Head Baker",
		"Baking Staff",
		"Cookie Crafter",
		"Cake Guard"
	})
	FireRemotes(1, "CakePrinceSpawner") 
end  

function CheckHolyTorchProcess()
	if getgenv().remilia.Data["Player Data"].Level < 2000 then
		return
	end
	if getgenv().remilia.Data['Player Inventory'].Tushita or GetBackpack('Tushita') then
		return
	end
	if getgenv().remilia.Data.Sea ~= 3 then
		return
	end
	if not getgenv().remilia.Cache.Tushita then
		if getgenv().remilia.Data['Spawned Boss']["rip_indra True Form"] then
			return 1
		end
	elseif getgenv().remilia.Data['Spawned Boss']['Longma'] then
		return 2
	end
end 

function HolyTorch()
	local Process = CheckHolyTorchProcess()
	if Process == 1 then
		SetStatus(1, "Doing Holy Torch")
		repeat
			wait()
			local v59 = GetBackpack("Holy Torch")
			if v59 then
				break
			end
			TweenTo(game:GetService("Workspace").Map.Waterfall.SecretRoom.Room.Door.Door.Hitbox.CFrame + Vector3.new(math.random(- 1, 1), math.random(- 1, 1), math.random(- 1, 1)))
		until false
		EquipTool("Holy Torch")
		for v60 = 1, 5, 1 do
			if game:GetService("Workspace").Map.Turtle.QuestTorches:FindFirstChild("Torch" .. v60) then
				repeat
					wait()
					TweenTo(game:GetService("Workspace").Map.Turtle.QuestTorches:FindFirstChild("Torch" .. v60).CFrame)
				until game:GetService("Workspace").Map.Turtle.QuestTorches:FindFirstChild("Torch" .. v60).Particles.Main.Enabled
			end
		end
		game:GetService("Workspace").Map.Turtle:FindFirstChild("TushitaGate"):Destroy()
		getgenv().remilia.Cache.Tushita = FireRemotes(1, "TushitaProgress").OpenedDoor
	elseif Process == 2 then
		SetStatus(1, "Getting Tushita")
		chotung2("Longma")
	end
end 

function getAllServerData()
	v71, v72 = pcall(function()
		return game:HttpGet("http://localhost:8888/servers/get")
	end)
	if v71 and v72 then
		return game:GetService("HttpService"):JSONDecode(v72)
	end 
end 

function findServer(req)
	if _G.loadstringMode then
		return
	end
	for JobId, Data in getAllServerData() do
		if game.JobId ~= JobId and req(Data) and Data.PlayerCount < 11 and ((os.time() - Data.time) < (60 * 15)) then
			return {
				JobId,
				Data.Sea
			}
		end
	end
end 
function ServerCheck()
	pcall(function()
		v73 = getgenv().remilia.Data["Player Inventory"]
		local function filter(Data)
			if Data["Spawned Boss"]["Dough King"] and not v73["Mirror Fractal"] then
				return true
			elseif Data["Spawned Boss"]["Darkbeard"] and not v73["Dark Fragment"] then
				return true
			elseif Data["Spawned Boss"]["rip_indra True Form"] then
				return true
			end
		end
		local v72 = findServer(filter)
		if v72 and v72[2] == getgenv().remilia.Data.Sea then
			writefile("cancel-teleport", "true")
			game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", v72[1])
			wait(10)
		end
	end)
end

function PirateRaid()
	SetStatus(1, "Doing Pirate Raid")
	pcall(function()
		local function v57(_, v)
			if not string.find(v.Name, "Brigade") and not string.find(v.Name, "Friend") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and CaculateDistance(v.HumanoidRootPart.Position, Vector3.new(- 5543.5327148438, 313.80062866211, - 2964.2585449219)) < 400 then
				v58 = v
			end
		end
		table.foreach(workspace.Enemies:GetChildren(), v57)
		table.foreach(game.ReplicatedStorage:GetChildren(), v57)
		if not v58 then
			TweenTo(Vector3.new(- 5543.5327148438, 313.80062866211, - 2964.2585449219))
		else
			chotung2(tostring(v58))
		end
	end) 
  
end 




function getPortal(check2)
	local check3 = check2.Position
	local gQ = ({
		{
			Vector3.new(- 7894.6201171875, 5545.49169921875, - 380.246346191406),
			Vector3.new(- 4607.82275390625, 872.5422973632812, - 1667.556884765625),
			Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
			Vector3.new(3876.280517578125, 35.10614013671875, - 1939.3201904296875)
		},
		{
			Vector3.new(- 288.46246337890625, 306.130615234375, 597.9988403320312),
			Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
			Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
			Vector3.new(- 6508.5581054688, 89.034996032715, - 132.83953857422)
		},
		{
			Vector3.new(- 5058.77490234375, 314.5155029296875, - 3155.88330078125),
			Vector3.new(5756.83740234375, 610.4240112304688, - 253.9253692626953),
			Vector3.new(- 12463.8740234375, 374.9144592285156, - 7523.77392578125),
			Vector3.new(- 11993.580078125, 334.7812805175781, - 8844.1826171875),
			Vector3.new(5314.58203125, 25.419387817382812)
		}
	})[getgenv().remilia.Data.Sea]
	local aM, aN = Vector3.new(0, 0, 0), math.huge
	for _, aL in pairs(gQ) do
		if (aL - check3).Magnitude < aN and aM ~= aL then
			aM, aN = aL, (aL - check3).Magnitude
		end
	end
	return aM
end

function shizukuhuhu(is)
	wait(.5)
	pcall(function()
		repeat
			task.wait()
			game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
			LocalPlayer.Character.HumanoidRootPart.CFrame = is
		until LocalPlayer.Character.PrimaryPart.CFrame == is
		game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid", 9):ChangeState(15)
		LocalPlayer.Character:SetPrimaryPartCFrame(is)
		wait(0.1)
		LocalPlayer.Character.Head:Destroy()
		repeat
			task.wait()
		until LocalPlayer.Character:FindFirstChild("Humanoid").Health <= 0
		repeat
			task.wait()
		until LocalPlayer.Character:FindFirstChild("Head")
		wait(0.5)
	end)
end

function getSpawn(pos)
	pos = Vector3.new(pos.X, pos.Y, pos.Z)
	local lll, mmm = nil, math.huge
	for i, v in pairs(getgenv().remilia.Data["NPCs"]["Set Home Point"]) do
		if (v.p - pos).Magnitude < mmm then
			lll = v
			mmm = (v.p - pos).Magnitude
		end
	end
	return lll
end

function serrlog(err)
	if _G.loadstringMode then
		return (alert or print)(tostring(err))
	end
	return request({
		Url = "http://localhost:8888/e/" .. game.Players.LocalPlayer.Name,
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json"
		},
		Body = game:GetService("HttpService"):JSONEncode({
			error = err
		})
	})
end  

function huhucall(funct)
	print("Registed Protect Call")
	local v55, v56 = pcall(funct)
	if not v55 then
		warn(v56)
		serrlog(v56)
	end  
end 

serrlog("-----NEW PLACE MAKED-----")
function CaculateDistance(I, II)
	if not II then
		II = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
	end
	return (Vector3.new(I.X, I.Y, I.Z) - Vector3.new(II.X, I.Y, II.Z)).Magnitude
end

local v69 = {
	["Last Resort"] = 1,
	["Agility"] = 1,
	["Water Body"] = 1,
	["Heavenly Blood"] = 1,
	["Heightened Senses"] = 1,
	["Energy Core"] = 1
} 

function tablefind(t, g)
	for _, v in t do
		if v == g then
			return true
		end
	end 
end 

function CheckIsResetable()
	for _, v in LocalPlayer.Character:GetChildren() do
		if v:IsA("Tool") and (not v.ToolTip or v.ToolTip == "") then
			if not (v69[tostring(v)]) then
				return false
			end
		end
	end
	for _, v in LocalPlayer.Backpack:GetChildren() do
		if v:IsA("Tool") and (not v.ToolTip or v.ToolTip == "") then
			if not (v69[tostring(v)]) then
				return false
			end
		end
	end
	return true
end

function TweenTo(vg1, ne)
	(function()
		pcall(
            function()
			tweenses:Cancel()
		end)
		ne = not ( ne or false)
		if not LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character.Humanoid.Health < 1 then
			wait()
			return
		end
		if LocalPlayer.Character.Humanoid.Sit then
			LocalPlayer.Character.Humanoid:ChangeState("Jumping")
		end
		pos = PositionParser("CFrame", vg1)
		poshair = PositionParser("CFrame", vg1)
		local portal = getPortal(pos)
		if ne and CaculateDistance(portal, pos) < CaculateDistance(pos) and CaculateDistance(portal) > 1000 then
			wait()
			FireRemotes(1, "requestEntrance", portal)
			wait(.5)
		end
		local bypasspos = getSpawn(pos)
		if ne and getgenv().remilia.Data.Sea ~= 1 and CaculateDistance(pos) - CaculateDistance(bypasspos, pos) > 1000 and CaculateDistance(bypasspos) > 2500 and not getsenv(game.ReplicatedStorage.GuideModule)["_G"]["InCombat"] and CheckIsResetable() then
			shizukuhuhu(bypasspos)
			return
		end
		for a, b in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if b:IsA"BasePart" then
				b.CanCollide = false
			end
		end
		if not game.Players.LocalPlayer.Character:WaitForChild"Head":FindFirstChild"eltrul" then
			local ngu = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.Head)
			ngu.Name = "eltrul"
			ngu.MaxForce = Vector3.new(0, math.huge, 0)
			ngu.Velocity = Vector3.new(0, 0, 0)
		end
		if CaculateDistance(pos) < 5 then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
			return
		end
		local plpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		local v52 = CaculateDistance(poshair)
		if v52 > 350 then
			v53 = 330
		elseif v52 > 250 then
			v53 = 400
		else
			v53 = 500
		end
		divY = 0
		tweenses = game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(CaculateDistance(pos) / v53, Enum.EasingStyle.Linear), {
			CFrame = CFrame.new(poshair.X, poshair.Y + divY, poshair.Z)
		})
		tweenses:Play()
	end)()

end

v18 = require(game.ReplicatedStorage.GuideModule)
function GetCurrentQuest()
	for i, v in v18.Data do
		if i == "QuestData" then
			for i2, v2 in v18.Data.QuestData.Task do
				v19 = i2
			end
		end
	end
	return v19
end

function GetLower1MFruit()
	for _, v in getgenv().remilia.Data["Player Inventory"] do
		if v.Type == "Blox Fruit" and v.Value < 1000000 then
			return v
		end
	end
	for _, v in LocalPlayer.Character:GetChildren() do
		local v46 = getgenv().remilia.Data["Fruit Name To Id"][v.Name]
		if v46 and getgenv().remilia.Data["Fruit Prices"][v46] < 1000000 then
			return {
				Name = v46
			}
		end
	end
	for _, v in LocalPlayer.Backpack:GetChildren() do
		local v46 = getgenv().remilia.Data["Fruit Name To Id"][v.Name]
		if v46 and getgenv().remilia.Data["Fruit Prices"][v46] < 1000000 then
			return {
				Name = v46
			}
		end
	end
	return nil
end

function CheckRaidRequirements()
	if getgenv().remilia.Data["Player Data"].Level < 1100 then
		return
	end
	if getgenv().remilia.Data.Sea == 1 then
		return
	end
	if # getgenv().remilia.Data["Fruit Spawn"] > 0 then
		return false
	end
	if getgenv().remilia.Cache.IsJoinedRaid then
		return true
	end
	return GetLower1MFruit()
end

function GetNextIsland()
	local v43 = {
		{},
		{},
		{},
		{},
		{}
	}
	for _, v in game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren() do
		if string.find(v.Name, "Island ") and CaculateDistance(v.Position, Vector3.new(0, 0, 0)) > 7000 then
			pcall(
                function()
				table.insert(v43[tonumber(({
					string.gsub(v.Name, "Island ", "")
				})[1])], v)
			end)
		end
	end
	for i = 5, 1, - 1 do
		for _, v44 in v43[i] do
			if v44 and CaculateDistance(v44.Position) < 4500 then
				return v44
			end
		end
	end
end

function DisableMon(m, m2)
	if m2 then
		m = m2
	end
	pcall(
        function()
		m.HumanoidRootPart.CanCollide = false
		sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
		m.Humanoid.Health = 0
		m:BreakJoints()
	end)
end

getgenv().remilia.Cache.LoadFruit = {}
function LoadFruit(v45)
	warn("Load Fruit: ", v45)
	getgenv().remilia.Cache.LoadFruit[getgenv().remilia.Data["Fruit Id To Name"][v45]] = true
	wait(1)
	FireRemotes(1, "LoadFruit", v45)
end

function Raid()
	CurrentRaid = "Rumble"
	if getgenv().remilia.Data["Current Raid Type"][2] then
		CurrentRaid = getgenv().remilia.Data["Current Raid Type"][1]
	end
	SetStatus(1, "Raiding - " .. CurrentRaid .. " - Preparing ")
	if not CheckRaidRequirements() then
		return
	end
	if not getgenv().remilia.Cache.IsJoinedRaid then
		SetStatus(1, "Raiding - " .. tostring(CurrentRaid) .. " - Purchasing Chip ")
		if not GetBackpack("Special Microchip") then
			local v62 = os.time()
			repeat
				wait()
				vruanon = GetLower1MFruit()
				if vruanon then
					LoadFruit(tostring(vruanon.Name) or "")
					EquipTool(getgenv().remilia.Data["Fruit Id To Name"][tostring(vruanon.Name)])
					FireRemotes(1, "RaidsNpc", "Select", CurrentRaid)
					if os.time() - v62 > 10 then
						return
					end
				end
			until GetBackpack("Special Microchip")
		end
		v42 = "Boat Castle"
		if getgenv().remilia.Data.Sea == 2 then
			v42 = "CircleIsland"
		end
		local v63 = os.time()
		repeat
			wait()
			EquipTool("Special Microchip")
			fireclickdetector(Workspace.Map[v42].RaidSummon2.Button.Main.ClickDetector)
			if os.time() - v63 > 15 then
				return
			end
		until not GetBackpack("Special Microchip") or (CaculateDistance(Vector3.new(0, 0, 0)) > 8500 and LocalPlayer.PlayerGui.Main.Timer.Visible)
		print("Joined Raid")
		getgenv().remilia.Cache.IsJoinedRaid = os.time()
		wait(1)
	else
		for i = 0, 15, 1 do
			wait(1)
			if GetNextIsland() and LocalPlayer.PlayerGui.Main.Timer.Visible then
				break
			end
		end
		repeat
			task.wait()
			SetStatus(1, "Raiding - " .. tostring(CurrentRaid or "...") .. " - " .. tostring(GetNextIsland() or "Island Isnt Loaded Or Player Doesnt On Raid"))
			if GetNextIsland() then
				TweenTo(GetNextIsland().Position + Vector3.new(0, 70, 0))
			end
			table.foreach(workspace.Enemies:GetChildren(), DisableMon)
		until not GetNextIsland() or not LocalPlayer.PlayerGui.Main.Timer.Visible
		wait(3)
		if getgenv().remilia.Data['Player Data'].Level > 1700 then
			FireRemotes(1, "Awakener", "Awaken")
		end
		getgenv().remilia.Cache.IsJoinedRaid = false
	end
end

function Get1MFruit()
	for _, v in getgenv().remilia.Data["Player Inventory"] do
		if v.Type == "Blox Fruit" and v.Value >= 1000000 then
			return v.Name
		end
	end
end

function GetSwanRequirements()
	return getgenv().remilia.Data["Player Data"].Level > 1100 and not getgenv().remilia.Data.Unlockables.FlamingoAccess and Get1MFruit()
end

function DoSwanRequirements()
	SetStatus(1, "Giving Fruit To Trevor")
	if not GetSwanRequirements() then
		return
	end
	local v47 = Get1MFruit()
	LoadFruit(v47)
	FireRemotes(1, "TalkTrevor", "1")
	FireRemotes(1, "TalkTrevor", "2")
	FireRemotes(1, "TalkTrevor", "3")
	getgenv().remilia.Data.Unlockables.FlamingoAccess = true  
    
end

function GetBartiloQuestProcess()
	if getgenv().remilia.Data["Player Inventory"]["Warrior Helmet"] then
		return
	end
	local Tasks = FireRemotes(1, "BartiloQuestProgress")
	if not Tasks.KilledBandits then
		return 1
	end
	if not Tasks.KilledSpring and getgenv().remilia.Data["Spawned Boss"]["Jeremy"] then
		return 2
	elseif Tasks.KilledSpring and not Tasks.DidPlates then
		return 3
	end
end

function DoBartiloQuest()
	local CurrentTask = GetBartiloQuestProcess()
	if CurrentTask == 1 then
		SetStatus(1, "Doing Bartilo Quest - 1 - Defeat 50x Swan Pirate")
		if not IsQuestVisible() then
			FireRemotes(1, "StartQuest", "BartiloQuest", 1)
			return
		elseif not string.find(LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") then
			FireRemotes(1, "AbandonQuest")
			return
		end
		chotung2("Swan Pirate")
	elseif CurrentTask == 2 then
		SetStatus(1, "Doing Bartilo Quest - 2 - Defeat Jeremy")
		chotung2("Jeremy")
	elseif CurrentTask == 3 then
		SetStatus(1, "Doing Bartilo Quest - 3 - Solving Questplates")
		if (CFrame.new(- 1837.46155, 44.2921753, 1656.1987, 0.999881566, - 1.03885048e-22, - 0.0153914848, 1.07805858e-22, 1, 2.53909284e-22, 0.0153914848, - 2.55538502e-22, 0.999881566).Position - game.Players.LocalPlayer.Character.Head.Position).magnitude > 500 then
			TweenTo(
                CFrame.new(- 1837.46155, 44.2921753, 1656.1987, 0.999881566, - 1.03885048e-22, - 0.0153914848, 1.07805858e-22, 1, 2.53909284e-22, 0.0153914848, - 2.55538502e-22, 0.999881566))
		else
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(- 1836, 11, 1714)
			wait(.5)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(- 1850.49329, 13.1789551, 1750.89685)
			wait(1)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(- 1858.87305, 19.3777466, 1712.01807)
			wait(1)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(- 1803.94324, 16.5789185, 1750.89685)
			wait(1)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(- 1858.55835, 16.8604317, 1724.79541)
			wait(1)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(- 1869.54224, 15.987854, 1681.00659)
			wait(1)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(- 1800.0979, 16.4978027, 1684.52368)
			wait(1)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(- 1819.26343, 14.795166, 1717.90625)
			wait(1)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(- 1813.51843, 14.8604736, 1724.79541)
		end
	end
end

function GetSaberQuestProcess()
	if getgenv().remilia.Data["Player Inventory"]["Saber"] then
		return
	end
	local Tasks = FireRemotes(1, "ProQuestProgress")
	for _, v in Tasks.Plates do
		if v == false then
			return 1
		end
	end
	if not Tasks.UsedTorch then
		return 2
	elseif not Tasks.UsedCup then
		return 3
	elseif not Tasks.TalkedSon then
		return 4
	elseif not Tasks.KilledMob then
		return 5
	elseif not Tasks.UsedRelic then
		return 6
	elseif not Tasks.KilledShanks and getgenv().remilia.Data["Spawned Boss"]["Saber Expert"] then
		return 7
	end
end

function DoSaberQuest()
	local CurrentProcess = GetSaberQuestProcess()
	local JungleMap = workspace.Map.Jungle
	if CurrentProcess == 1 then
		SetStatus(1, "Doing Saber Puzzle - 1 - Touching Plates")
		print("do #1")
		for _, v in JungleMap.QuestPlates:GetChildren() do
			if v:FindFirstChild("Button") then
				TweenTo(v.Button.CFrame)
				repeat
					wait()
				until CaculateDistance(GetPlayerCFrame(LocalPlayer), v.Button.CFrame) < 5
				wait(1)
			end
		end
	elseif CurrentProcess == 2 then
		print("do #2")
		SetStatus(1, "Doing Saber Puzzle - 2 - Burning Torch")
		FireRemotes(1, "ProQuestProgress", "GetTorch")
		wait()
		FireRemotes(1, "ProQuestProgress", "DestroyTorch")
	elseif CurrentProcess == 3 then
		print("do #3")
		SetStatus(1, "Doing Saber Puzzle - 3 - Take The Cup And Filling With Water")
		FireRemotes(1, "ProQuestProgress", "GetCup")
		repeat
			wait()
			EquipTool("Cup")
		until LocalPlayer.Character:FindFirstChild("Cup")
		FireRemotes(1, "ProQuestProgress", "FillCup", LocalPlayer.Character.Cup)
		wait()
		FireRemotes(1, "ProQuestProgress", "SickMan")
	elseif CurrentProcess == 4 then
		print("do #4")
		FireRemotes(1, "ProQuestProgress", "RichSon")
		SetStatus(1, "Doing Saber Puzzle - 4 - Talking To Rich Son")
	elseif CurrentProcess == 5 then
		SetStatus(1, "Doing Saber Puzzle - 5 - Defeat Mob Leader")
		print("do #5")
		chotung2("Mob Leader")
	elseif CurrentProcess == 6 then
		print("do #6")
		SetStatus(1, "Doing Saber Puzzle - 6 - Placing Relic")
		FireRemotes(1, "ProQuestProgress", "RichSon")
		wait()
		FireRemotes(1, "ProQuestProgress", "PlaceRelic")
		wait()
	elseif CurrentProcess == 7 then
		SetStatus(1, "Doing Saber Puzzle - 7 - Defeat Saber Expert")
		chotung2("Saber Expert")
	end
end

function GetDressrosaProcess()
	local Tasks = FireRemotes(1, "DressrosaQuestProgress")
	if not Tasks.TalkedDetective then
		return 1
	elseif not Tasks.KilledIceBoss then
		return 2
	end
end

function DoDressrosaQuest()
	local CurrentProcess = GetDressrosaProcess()
	if CurrentProcess == 1 then
		SetStatus(1, "Doing Dressrosa Quest - 1 - Using Key")
		FireRemotes(1, "DressrosaQuestProgress", "Detective")
		FireRemotes(1, "DressrosaQuestProgress", "Detective")
		wait(1)
		FireRemotes(1, "DressrosaQuestProgress", "UseKey")
	elseif CurrentProcess == 2 then
		SetStatus(1, "Doing Dressrosa Quest - 2 - Defeating Ice Admiral")
		chotung2("Ice Admiral")
		wait(2)
		HopServer("Entering Second Sea", 4, true, 2)
	end
end

function CheckIsSpecializeBossSpawned()
	if getgenv().remilia.Data["Player Data"].Level < 400 then
		return
	end
	local v32 = getgenv().remilia.Data["Spawned Boss"]
	if (getgenv().remilia.Data.Unlockables.FlamingoAccess and not getgenv().remilia.Cache.ZQuestProgress1 and getgenv().remilia.Data["Spawned Boss"]["Don Swan"]) then
		return getgenv().remilia.Data["Spawned Boss"]["Don Swan"]
	end
	return v32["Core"] or v32["Thunder God"] or v32["Darkbeard"] or v32.Diablo or v32.Urban or v32.Deandre or v32["Dough King"] or v32["Soul Reaper"] or v32["Cake Prince"] or v32["rip_indra True Form"] or CheckBossMelee() 
end

function CheckBossMelee()
	local v32 = getgenv().remilia.Data["Spawned Boss"]
	if not getgenv().remilia.Data.Requirements.OpenWaterKey and v32["Tide Keeper"] then
		SetStatus(1, "Defeating Tide Keeper - Water Key")
		return v32["Tide Keeper"]
	elseif (not getgenv().remilia.Data.Requirements.OpenLibraryKey or not getgenv().remilia.Data.Requirements.OpenRengoku) and v32["Awakened Ice Admiral"] then
		SetStatus(1, "Defeating Awakened Ice Admiral - Library / Hidden Key")
		return v32["Awakened Ice Admiral"]
	end
end

function MeleeResCheck()
	if GetBackpack("Sweet Chalice") then
		FireRemotes(1, "CakePrinceSpawner")
	end
	if not getgenv().remilia.Data.Requirements.OpenLibrary and GetBackpack("Library Key") then
		return 1
	end
	if GetBackpack("Red Key") then
		FireRemotes(1, "CakeScientist", "Check")
	end
	if not getgenv().remilia.Cache.PreviousHero and getgenv().remilia.Data.Sea == 3 then
		return 2
	end
	if GetBackpack("Fire Essence") then
		if typeof(FireRemotes(1, "BuyDragonTalon", true)) == "string" then
			FireRemotes(1, "BuyDragonTalon")
		end
	end
	if GetBackpack("Hallow Essence") then
		return 3
	end
	return nil
end 

function DoMeleeRes()
	local v54 = MeleeResCheck()
	if v54 == 1 then
		repeat
			wait()
			TweenTo(CFrame.new(6375.9126, 296.634583, - 6843.14062, - 0.849467814, 1.5493983e-08, - 0.527640462, 3.70608895e-08, 1, - 3.0301031e-08, 0.527640462, - 4.5294577e-08, - 0.849467814))
		until CaculateDistance(CFrame.new(6375.9126, 296.634583, - 6843.14062, - 0.849467814, 1.5493983e-08, - 0.527640462, 3.70608895e-08, 1, - 3.0301031e-08, 0.527640462, - 4.5294577e-08, - 0.849467814)) < 15
		wait(1)
		getgenv().remilia.Data.Requirements.OpenLibrary = true
	elseif v54 == 2 then
		FireRemotes(1, "BuyElectricClaw", "Start")
		wait(5)
		repeat
			wait()
			TweenTo(CFrame.new(- 12548, 332.378, - 7617))
		until CaculateDistance(CFrame.new(- 12548, 332.378, - 7617)) < 30
		wait(1)
		getgenv().remilia.Cache.PreviousHero = (FireRemotes(1, "BuyElectricClaw", true) == 4)
	elseif v54 == 3 then
		wait()
		TweenTo(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
	end
end
function TeleportSea(sea)
	return FireRemotes(1, "Travel" .. ({
		"Main",
		"Dressrosa",
		"Zou"
	})[sea])
end
NPCList = require(game.ReplicatedStorage.GuideModule).Data.NPCList 

function GetQuest()
	local v22
	local v29 = remilia.Data["Player Data"].Level
	v119 = 0
	for QuestId, QuestList in Quests do
		if QuestId ~= "MarineQuest" or QuestId ~= "Trainees" or QuestId ~= "CitizenQuest" or QuestId ~= "BartiloQuest" then
			for QuestLevel, QuestData in QuestList do
				local v21 = v29 >= tonumber(QuestData.LevelReq) and tonumber(QuestData.LevelReq) > v119
				if v21 then
					v119 = tonumber(QuestData.LevelReq)
					v22 = {
						QuestId,
						Quests[QuestId]
					}
				end
			end
		end
	end
	print("resolved")
	v126 = {}
	for v127, v128 in v22[2] do
		print"cc"
		v126[v123.NameMon] = v127
	end
	for v122, v123 in v22[2] do
		for _, v124 in v123.Task do
			if v124 ~= 1 then
				if OldQuest then
					v125 = (v126[OldQuest] == 1 and 2) or 1
					v30 = {
						v125,
						v22[2][v125]
					}
				else
					v30 = {
						1,
						v22[2][1]
					}
				end
			end
		end
	end
	return {
		QuestId = v22[1],
		QuestLevel = v30[1],
		NameMon = v30[2].Name,
		QuestPosition = (function()
			for i, v in NPCList do
				for i1, v1 in v.Levels do
					if v1 == v30[2].LevelReq then
						return i.CFrame
					end
				end
			end
		end)()
	}
end

function GetQuest()
	local v22
	local v29 = tonumber(require(game.ReplicatedStorage.GuideModule).Data.LastQuestLevel)
	for QuestId, QuestList in Quests do
		if QuestId ~= "MarineQuest" or QuestId ~= "Trainees" or QuestId ~= "CitizenQuest" or QuestId ~= "BartiloQuest" then
			for QuestLevel, QuestData in QuestList do
				local v21 = (v29 == tonumber(QuestData.LevelReq))
				if v21 then
					v22 = {
						QuestId,
						Quests[QuestId]
					}
				end
			end
		end
	end
	if getgenv().remilia.Data["Player Data"].Level < 10 then
		v22 = {
			"BanditQuest1",
			Quests["BanditQuest1"]
		}
	end
	v23 = v22
	for _, v31 in v22[2][# v22[2]].Task do
		if v31 == 1 and v22[2][# v22[2]].LevelReq == v29 then
			v29 = v22[2][(# v22[2]) - 1].LevelReq
		end
	end
	for v25, v26 in v22[2] do
		for v27, v28 in v26.Task do
			if v28 > 1 then
				if v26.LevelReq == v29 then
					if v25 == 2 and GetCurrentQuest() == v26.Name then
						v30 = {
							1,
							v22[2][1]
						}
					else
						v30 = {
							v25,
							v26
						}
					end
				end
			end
		end
		if v26.LevelReq == v29 and (getgenv().remilia.Data["Spawned Boss"][v27] or getgenv().remilia.Data["Spawned Boss"][v26.Name]) then
			v30 = {
				# v22[2],
				v26
			}
			break
		end
	end
	return {
		QuestId = v23[1],
		QuestLevel = v30[1],
		NameMon = v30[2].Name,
		QuestPosition = (function()
			for i, v in require(game.ReplicatedStorage.GuideModule).Data.NPCList do
				for i1, v1 in v.Levels do
					if v1 == v30[2].LevelReq then
						return i.CFrame
					end
				end
			end
		end)()
	}
end
function CheckIsPositionOnSafezone(pos)
	for _, v in getgenv().remilia.Data.Safezones do
		if CaculateDistance(v[1], pos) < (v[2].Magnitude / 4) then
			return true
		end
	end
end

function SetStatus(idx, text)
	_G.cucucubububu(idx, text)
end

fcall = false
local Blacklist = {}

function GetHunterQuest()
	if getgenv().remilia.Data["Player Data"].Level > 750 then
		return
	end
	if t1 and os.time() - t1 < 10 then
		if PlayerHunterResult and not table.find(Blacklist, PlayerHunterResult.Name) and PlayerHunterResult.Character and PlayerHunterResult.Character:FindFirstChild("HumanoidRootPart") then
			return PlayerHunterResult
		end
		return
	end
	if PlayerHunterResult and not table.find(Blacklist, PlayerHunterResult.Name) and PlayerHunterResult.Character and PlayerHunterResult.Character:FindFirstChild("HumanoidRootPart") then
		return PlayerHunterResult
	end
	t1 = nil
	t3 = os.time()
	repeat
		task.wait()
		getgenv().Task1 = "Finding Hunter Target"
		getgenv().PlayerHunterResult = nil
		local QuestFrame = LocalPlayer.PlayerGui.Main.Quest
		local r2 = FireRemotes(1, "PlayerHunter")
		if r2 == "I don't have anything for you right now. Come back later." then
			return
		end
		local Name = string.gsub(string.gsub(QuestFrame.Container.QuestTitle.Title.Text, "Defeat ", ""), " %p(0/1)%p", "")
		print("test:", Name)
		if not table.find(Blacklist, Name) then
			Target = Players:FindFirstChild(Name)
			if Target then
				print(
                Target.Character:FindFirstChild("Humanoid"), Target.Character.Humanoid.MaxHealth < LocalPlayer.Character.Humanoid.MaxHealth + 500, Target.Data.Level.Value < getgenv().remilia.Data["Player Data"].Level + 100, not CheckIsPositionOnSafezone(Target.Character.PrimaryPart.CFrame))
				if Target.Character:FindFirstChild("Humanoid") and Target.Character.Humanoid.MaxHealth < LocalPlayer.Character.Humanoid.MaxHealth + 500 and Target.Data.Level.Value >= 20 and Target.Data.Level.Value < getgenv().remilia.Data["Player Data"].Level + 50 then
					print("pass")
					getgenv().PlayerHunterResult = Target
					break
				else
					FireRemotes(1, "AbandonQuest")
				end
			else
				FireRemotes(1, "AbandonQuest")
			end
		end
		if os.time() - t3 > 6 then
			print("Hop Server")
			HopServer("Finding new server for hunter quest", 4, 1)
			return
		end
	until getgenv().PlayerHunterResult
	return getgenv().PlayerHunterResult
end

function GetPlayerCFrame(Player)
	if not Player then
		Player = LocalPlayer
	end
	if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
		return false
	end
	return Player.Character.HumanoidRootPart.CFrame
end

function EquipTool(name)
	for _, v in game.Players.LocalPlayer.Backpack:GetChildren() do
		if v:IsA("Tool") and tostring(v) == name or v.ToolTip == name then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
		end
	end
end

function SendKey(key, hold)
	pcall(function()
		set_thread_identity(8)
		game:service("VirtualInputManager"):SendKeyEvent(true, key, false, game)
		task.wait(hold)
		game:service("VirtualInputManager"):SendKeyEvent(false, key, false, game)
	end)
end
function DoPlayerHunter()
	if not getgenv().PlayerHunterResult or not getgenv().PlayerHunterResult.Character then
		return
	end
	getgenv().Task1 = ""
	wait(1)
	local t3 = os.time()
	SetStatus(1, "Doing Player hunter Quest - " .. tostring(PlayerHunterResult))
	repeat
		task.wait()
		if LocalPlayer.PlayerGui.Main.PvpDisabled.Visible then
			FireRemotes(1, "EnablePvp")
		end
		set_thread_identity(8)
		if PlayerHunterResult and PlayerHunterResult.Character and PlayerHunterResult.Character:FindFirstChild("HumanoidRootPart") then
			TweenTo(GetPlayerCFrame(getgenv().PlayerHunterResult))
			if CaculateDistance(GetPlayerCFrame(getgenv().PlayerHunterResult)) < 20 then
				EquipTool(getgenv().remilia.Data["Current Weapon"])
				game:GetService("VirtualUser"):ClickButton1(Vector2.new(0, 0))
				if getgenv().PlayerHunterResult.Character.HumanoidRootPart.Velocity.Magnitude < 0.9 then
					SendKey("Z")
					SendKey("X")
				end
			end
			if os.time() - t3 > 65 then
				table.insert(Blacklist, Name)
				GetHunterQuest()
				break
			end
		else
			break
		end
	until not getgenv().PlayerHunterResult or not getgenv().PlayerHunterResult.Character or not PlayerHunterResult.Character:FindFirstChild("Humanoid") or getgenv().PlayerHunterResult.Character.Humanoid.Health <= 0 or not IsQuestVisible()
	print("ended")
	table.insert(Blacklist, Name)
	getgenv().PlayerHunterResult = nil
	t1 = os.time()
end

function CheckHornedMan()
	if getgenv().remilia.Data["Horned Man"] then
		return
	end
	if getgenv().remilia.Data.Sea ~= 3 then
		return
	end
	if getgenv().remilia.Data["Player Data"].Level < 1600 then
		return
	end
	if not getgenv().remilia.Cache.HornedManProcess then
		repeat
			wait()
			FireRemotes(1, "HornedMan", "Bet")
		until IsQuestVisible()
		getgenv().remilia.Cache.HornedManProcess = GetCurrentProcessingQuest()
	end
	if not getgenv().remilia.Data["Spawned Boss"][getgenv().remilia.Cache.HornedManProcess] then
		return
	end
	return getgenv().remilia.Cache.HornedManProcess
end 

function HornedMan()
	local v64 = getgenv().remilia.Cache.HornedManProcess
	if not v64 then
		return
	end
	SetStatus(1, "Doing Horned Man (Rainbow Haki) Quest - " .. tostring(v64))
	if not IsQuestVisible() then
		FireRemotes(1, "HornedMan", "Bet")
	elseif not string.find(GetCurrentProcessingQuest(), v64) then
		FireRemotes(1, "AbandonQuest")
		return
	end
	chotung2(v64)
	if v64 == "Beautiful Pirate" then
		getgenv().remilia.Data["Horned Man"] = true
	end
	getgenv().remilia.Cache.HornedManProcess = nil
end 


-- vo minh hung :yummy:

function GetNearestPlayer(pos)
	local ner = math.huge
	local ner2
	for i, v in pairs(game.Players:GetChildren()) do
		if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and (v.Character.HumanoidRootPart.Position - pos).Magnitude < ner then
			ner = (v.Character.HumanoidRootPart.Position - pos).Magnitude
		end
	end
	for i, v in pairs(game.Players:GetChildren()) do
		if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and (v.Character.HumanoidRootPart.Position - pos).Magnitude <= ner then
			ner2 = v.Name
		end
	end
	if game.Players.LocalPlayer.Name == ner2 then
		return true
	end
end

function isnetworkowner2(p1)
	local A = gethiddenproperty(game.Players.LocalPlayer, "SimulationRadius")
	local B = game.Players.LocalPlayer.Character or (game.Players.LocalPlayer.CharacterAdded:Wait())
	local C = game.WaitForChild(B, "HumanoidRootPart", 300)
	if C then
		if p1.Anchored then
			return false
		end
		if game.IsDescendantOf(p1, B) or (C.Position - p1.Position).Magnitude <= A and GetNearestPlayer(p1.Position) then
			return true
		end
	end
end

function tablefind(t, i)
	for _, v in t do
		if v == i then
			return true
		end
	end
end


function Click2()
	if t2 then
		return
	end
	t2 = true
	Click()
	task.wait()
	t2 = false
end

function factorial(n)
	if n == 0 then
		return 1
	else
		return n * factorial(n - 1)
	end
end

function BezierCurve(controlPoints, t)
	local n = # controlPoints - 1
	local point = Vector3.new()
	for i = 0, n do
		local coeff = (factorial(n) / (factorial(i) * factorial(n - i))) * t ^ i * (1 - t) ^ (n - i)
		point = point + controlPoints[i + 1] * Vector3.new(coeff, coeff, coeff)
	end
	return point
end

function GetBezierTablePositions(controlPointsTable, numPoints)
	local positions = {}
	local tIncrement = 1 / (numPoints - 1)
	for i = 1, numPoints do
		local t = (i - 1) * tIncrement
		table.insert(positions, BezierCurve(controlPointsTable, t))
	end
	return positions
end

function CheckFullMoon(cmm)
	if game.Lighting.Sky.MoonTextureId ~= "http://www.roblox.com/asset/?id=9709149431" then
		return
	elseif cmm then
		return true
	end
	return game.Lighting.ClockTime > 18 or game.Lighting.ClockTime < 5
end 


function GetNearbyPlayer(v109)
	v109 = v109 or 1000
	for _, v in Players:GetPlayers() do
		if tostring(v) ~= tostring(LocalPlayer) then
			v110 = GetPlayerCFrame(v)
			if v110 and CaculateDistance(v110) < v109 then
				return v
			end
		end
	end
end

function CheckSoulGuitarProcess()
	if getgenv().remilia.Data["Player Inventory"]["Soul Guitar"] or not getgenv().remilia.Data["Player Inventory"]["Dark Fragment"] or GetBackpack("Soul Guitar") or getgenv().remilia.Data.Sea ~= 3 then
		return
	end
	if getgenv().remilia.Data["Player Data"]["Level"] < 2300 then
		return
	end
	if getgenv().remilia.Cache.SoulGuitarProcess == nil then
		print("F5 Soul Guitar ne ban oi")
		getgenv().remilia.Cache.SoulGuitarProcess = FireRemotes(1, "GuitarPuzzleProgress", "Check")
	end
	v105 = getgenv().remilia.Cache.SoulGuitarProcess
	v106 = v106 or FireRemotes(1, "gravestoneEvent", 2)
	if praying or v105 == nil then
		praying = true
		print("cac khanh hung")
		if not CheckFullMoon() then
			HopServer("Finding Full Moon Server", 3, 1)
			wait(6)
			return
		end
		SetStatus(1, "Soul Guitar - 1 - Praying")
		return 8
	end
	if not v105.Swamp then
		SetStatus(1, "Soul Guitar / 2 / Living Zombie")
		return 1
	elseif not v105.Gravestones then
		SetStatus(1, "Soul Guitar / 3 / Gravestones")
		return 2
	elseif not v105.Ghost then
		SetStatus(1, "Soul Guitar / 4 / Talk To Ghost")
		return 3
	elseif not v105.Trophies then
		SetStatus(1, "Soul Guitar / 5 / Trophy")
		return 4
	elseif not v105.Pipes then
		SetStatus(1, "Soul Guitar / 6 / Pipe")
		return 5
	elseif ConDiMeMayThieuMaterialKiaDmmmm() then
		SetStatus(1, "Soul Guitar / 7 / Purchasing Soul Guitar")
		return 6
	end
end 

function ConDiMeMayThieuMaterialKiaDmmmm()
	Ectoplasm2 = false
	local Inv = getgenv().remilia.Data["Player Inventory"]
	local Data = getgenv().remilia.Data["Player Data"]
	if not Inv["Bones"] or Inv["Bones"].Count < 500 then
		return
	elseif not Inv["Ectoplasm"] or Inv["Ectoplasm"].Count < 250 then
		return
	elseif not Inv["Dark Fragment"] then
		return
	elseif Data["Fragments"] < 5000 then
		return
	end
	return true
end 



function DoSoulGuitar()
	local v112 = CheckSoulGuitarProcess()
	local BlankTablets = {
		"Segment6",
		"Segment2",
		"Segment8",
		"Segment9",
		"Segment5"
	}
	local Trophy = {
		["Segment1"] = "Trophy1",
		["Segment3"] = "Trophy2",
		["Segment4"] = "Trophy3",
		["Segment7"] = "Trophy4",
		["Segment10"] = "Trophy5",
	}
	local Pipes = {
		["Part1"] = "Really black",
		["Part2"] = "Really black",
		["Part3"] = "Dusty Rose",
		["Part4"] = "Storm blue",
		["Part5"] = "Really black",
		["Part6"] = "Parsley green",
		["Part7"] = "Really black",
		["Part8"] = "Dusty Rose",
		["Part9"] = "Really black",
		["Part10"] = "Storm blue",
	}
	warn(v112)
	if v112 == 8 then
		print("playing")
		while CaculateDistance(CFrame.new(- 8654, 140, 6167)) > 5 do
			wait()
			TweenTo(CFrame.new(- 8654, 140, 6167))
		end
		v106 = FireRemotes(1, "gravestoneEvent", 2, true)
		praying = false
	elseif v112 == 1 then
		v107 = getgenv().remilia.Data["Enemy Spawns"]["Living Zombie"]
		while CaculateDistance(v107[1]) > 30 do
			wait()
			TweenTo(v107[1])
		end
		if GetNearbyPlayer() then
			HopServer("Hop Server Cuz There Player Nearby: " .. tostring(GetNearbyPlayer()), 1, 1)
			wait(4)
			return
		end
		v111 = 0
		repeat
			wait(1)
			v111 = v111 + 1
			v108 = 0
			for _, v in SortMon() do
				if v.Name == "Living Zombie" then
					v108 = v108 + 1
				end
			end
			if v108 >= 6 then
				break
			end
		until v111 > 30
		chotung2("Living Zombie")
		getgenv().remilia.Cache.SoulGuitarProcess = nil
	elseif v112 == 2 then
		v116 = workspace.Map["Haunted Castle"]
		while CaculateDistance(CFrame.new(- 8800, 178, 6033)) > 10 do
			wait()
			TweenTo(CFrame.new(- 8800, 178, 6033))
		end
		for v114, v115 in {
			Placard1 = "Right",
			Placard2 = "Right",
			Placard3 = "Left",
			Placard4 = "Right",
			Placard5 = "Left",
			Placard6 = "Left",
			Placard7 = "Left"
		} do
			fireclickdetector(v116[v114][v115].ClickDetector)
		end
		getgenv().remilia.Cache.SoulGuitarProcess = nil
	elseif v112 == 3 then
		FireRemotes(1, "GuitarPuzzleProgress", "Ghost")
		getgenv().remilia.Cache.SoulGuitarProcess = nil
	elseif v112 == 4 then
		if CaculateDistance(CFrame.new(- 9530.0126953125, 6.104853630065918, 6054.83349609375)) > 30 then
			TweenTo(CFrame.new(- 9530.0126953125, 6.104853630065918, 6054.83349609375))
		else
			local DepTraiv4 = game.workspace.Map["Haunted Castle"].Tablet
			for i, v in pairs(BlankTablets) do
				local x = DepTraiv4[v]
				if x.Line.Position.X ~= 0 then
					repeat
						wait()
						fireclickdetector(x.ClickDetector)
					until x.Line.Position.X == 0
				end
			end
			for i, v in pairs(Trophy) do
				local x = game.workspace.Map["Haunted Castle"].Trophies.Quest[v].Handle.CFrame
				x = tostring(x)
				x = x:split(", ")[4]
				local c = "180"
				if x == "1" or x == "-1" then
					c = "90"
				end
				if not string.find(tostring(DepTraiv4[i].Line.Rotation.Z), c) then
					repeat
						wait()
						fireclickdetector(DepTraiv4[i].ClickDetector)
					until string.find(tostring(DepTraiv4[i].Line.Rotation.Z), c)
				end
			end
		end
		getgenv().remilia.Cache.SoulGuitarProcess = nil
	elseif v112 == 5 then
		for i, v in pairs(Pipes) do
			pcall(function()
				local x = game.workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model[i]
				if x.BrickColor.Name ~= v then
					repeat
						wait()
						fireclickdetector(x.ClickDetector)
					until x.BrickColor.Name == v
				end
			end)
		end
		getgenv().remilia.Cache.SoulGuitarProcess = nil
	elseif v112 == 6 then
		FireRemotes(1, "soulGuitarBuy")
		getgenv().remilia.Cache.SoulGuitarProcess = nil
	end
end



LoadTime = os.time()
function CheckCdkProcess()
	local v82 = getgenv().remilia.Data["Player Inventory"]
	if not v82.Yama or v82.Yama.Mastery < 350 or not v82.Tushita or v82.Tushita.Mastery < 350 or v82["Cursed Dual Katana"] then
		return
	end
	local v83 = v83 or FireRemotes(1, "CDKQuest", "Progress")
	if not v83 then
		print(1132)
		return
	end
	if workspace.Map.Turtle.Cursed:FindFirstChild("Breakable") then
		FireRemotes(1, "CDKQuest", "OpenDoor")
		FireRemotes(1, "CDKQuest", "OpenDoor", true)
		workspace.Map.Turtle.Cursed.Breakable:Destroy()
	end
	v86 = {
		Good = "Tushita",
		Evil = "Yama"
	}
	v101 = {
		Good = 1,
		Evil = 2
	}
	v102 = workspace.Map.Turtle.Cursed
	if v83.Good == 4 and v83.Evil == 4 then
		print"final"
		return {
			"cac llon",
			"di me"
		}
	end
	if v83.Good == 3 or v83.Evil == 3 then
		print("burn")
		return {
			"cac bu"
		}
	end
	if v83.Opened then
		for i, v in v83 do
			if i ~= "Opened" and i ~= "Finished" and v < 3 then
				ForceCDK = true
				getgenv().remilia.Cache.CdkCache1 = {
					i,
					v + 1
				}
				if not GetBackpack(v86[i]) then
					FireRemotes(1, "LoadItem", v86[i])
				end
				FireRemotes(1, "CDKQuest", "StartTrial", i)
				return {
					i,
					v + 1
				}
			end
		end
	end
	local v88 = getgenv().remilia.Cache.CdkCache1
	if not v88 then
		return
	end
	if v88[1] == "Evil" and v88[2] == 3 then
		ForceCDK2 = true
		if not getgenv().remilia.Data["Spawned Boss"]["Soul Reaper"] then
			SetStatus(2, "CDK / Evil 3 / Waiting Soul Reaper Spawn")
			return
		end
	end
	if v88[1] == "Good" then
		if v88[2] == 2 then
			SetStatus(2, "CDK / Good 2 / Waiting Pirate Raid")
			return
		end
		if v88[2] == 3 and not getgenv().remilia.Data["Spawned Boss"]["Cake Queen"] then
			SetStatus(2, "CDK / Good 3 / Waiting Cake Queen Spawn")
			if not Queen1 and os.time() - LoadTime > 25 and not getgenv().remilia.Data["Spawned Boss"]["Cake Queen"] then
				HopServer('Finding Mẹ Béo', 2, 1)
				wait(6)
			end
			return
		end
	end
	return v88
end 



function GetHazeMon()
	v87 = {}
	for _, v in LocalPlayer.QuestHaze:GetChildren() do
		if v.Value > 0 then
			table.insert(v87, v.Name)
		end
	end
	return v87
end 


function DoCdk()
	local v84 = CheckCdkProcess()
	if not v84 then
		print(1255, v84)
		return
	end
	print(unpack(v84))
	v104 = workspace.Map.Turtle.Cursed
	if v84[1] == "cac llon" then
		if v104.Pedestal3.ProximityPrompt.Enabled then
			if CaculateDistance(v104.Pedestal3.CFrame) > 5 then
				TweenTo(v104.Pedestal3.CFrame)
			else
				fireproximityprompt(v104.Pedestal3.ProximityPrompt)
				wait(1)
				pcall(function()
					LocalPlayer.Character.Humanoid.Health = 0
				end)
				wait(10)
			end
		else
			TweenTo(CFrame.new(- 12341.66796875, 603.3455810546875, - 6550.6064453125))
			wait(5)
			pcall(function()
				LocalPlayer.Character.Humanoid.Health = 0
			end)
			wait(4)
		end
	elseif v84[1] == "cac bu" then
		for i = 1, 3, 1 do
			repeat
				wait()
				TweenTo(v104:FindFirstChild("Pedestal" .. i).CFrame)
			until CaculateDistance(v104:FindFirstChild("Pedestal" .. i).CFrame) < 5
			fireproximityprompt(v104:FindFirstChild("Pedestal" .. i).ProximityPrompt)
		end
	elseif v84[1] == "Evil" then
		if v84[2] == 1 then
			local v85 = SortMon()
			if v85[1] then
				SetStatus(2, "CDK / Evil 1 / Damaging")
				pcall(function()
					for _, v in v85 do
						if v.Name == "Forest Pirate" then
							repeat
								wait()
								TweenTo(v.HumanoidRootPart.CFrame)
							until game.Players.LocalPlayer.Character.Humanoid.Health < 1
						end
					end
					TweenTo(getgenv().remilia.Data["Enemy Spawns"]["Forest Pirate"][50])
				end)
			end
		elseif v84[2] == 2 then
			SetStatus(2, "CDK / Evil 2 / Farming Haze Mon")
			chotung2(GetHazeMon())
		elseif v84[2] == 3 and getgenv().remilia.Data["Spawned Boss"]["Soul Reaper"] then
			SetStatus(1, "CDK / Evil 3 / Soul Reaper")
			repeat
				wait(4)
				pcall(function()
					TweenTo(getgenv().remilia.Data["Spawned Boss"]["Soul Reaper"].HumanoidRootPart.CFrame, true)
				end)
				v89 = workspace.Map:FindFirstChild("HellDimension")
			until getgenv().LoadDimension == true or os.time() - getgenv().DimensionTick < 10
			repeat
				wait()
			until not getgenv().LoadDimension == true
			DoDimension(v89, workspace._WorldOrigin.Locations["Hell Dimension"])
			getgenv().DimensionTick = 0
		elseif v84[2] == 4 then
			if v84[3] then
				if CaculateDistance(v84[3].CFrame) > 5 then
					TweenTo(v84[3].CFrame)
				else
					fireproximityprompt(v84[3].ProximityPrompt)
				end
			end
		end
	elseif v84[1] == "Good" then
		if v84[2] == 1 then
			SetStatus(2, "CDK / Good 1 / Boat Quest")
			for _, v93 in getnilinstances() do
				if string.find(v93.Name, "Luxury Boat") then
					repeat
						wait()
						local v94 = v93:GetModelCFrame()
						TweenTo(v94)
						FireRemotes(1, "CDKQuest", "BoatQuest", workspace.NPCs:WaitForChild("Luxury Boat Dealer", 10))
					until CaculateDistance(v94) < 4
				end
			end
		elseif v84[2] == 3 then
			SetStatus(1, "CDK / Good 3 / Cake Queen")
			alert('CDK / ', tostring(remilia.Data["Spawned Boss"]["Cake Queen"]))
			v95 = workspace.Map:FindFirstChild("HeavenlyDimension")
			if getgenv().LoadDimension == true or os.time() - getgenv().DimensionTick < 5 then
				repeat
					wait()
				until not getgenv().LoadDimension == true
				DoDimension(v95, workspace._WorldOrigin.Locations["Heavenly Dimension"])
				getgenv().DimensionTick = 0
			else
				Queen1 = true
				conchoteru("Cake Queen")
			end
		elseif v84[2] == 4 then
			if v84[3] then
				if CaculateDistance(v84[3].CFrame) > 5 then
					TweenTo(v84[3].CFrame)
				else
					fireproximityprompt(v84[3].ProximityPrompt)
				end
			end
		end
	end
	v83 = nil
end

function GetDimensionTorch(v96)
	for _, v91 in v96:GetChildren() do
		if string.find(v91.Name, "Torch") and v91:FindFirstChild("ProximityPrompt") and v91.ProximityPrompt.Enabled then
			return v91
		end
	end 
end 

function DoDimension(...)
	v90 = {
		...
	}
	if not v90 or v90 == nil then
		return
	end
	v98 = 2
	if string.find(tostring(v90[1]), "Hell") then
		v98 = 1
	end
	repeat
		task.wait()
		v97 = GetDimensionTorch(v90[1])
		if v97 then
			print("firing torch")
			repeat
				wait()
				TweenTo(v97.Position)
				fireproximityprompt(v97.ProximityPrompt)
			until CaculateDistance(v97.Position) < 4
		end
		v92 = v90[2].Position
		TweenTo(v92 + Vector3.new(0, 80, 0))
		table.foreach(workspace.Enemies:GetChildren(), DisableMon)
	until v90[1]:FindFirstChild"Exit" and (tostring(v90[1].Exit.BrickColor) == "Cloudy grey" or tostring(v90[1].Exit.BrickColor) == "Olivine")
	TweenTo(v90[1].Exit.CFrame)
	repeat
		wait()
	until GetPlayerCFrame() and GetPlayerCFrame().Y < 2500 
    
end 

v40, v41 = 0



function GetNextBringPoint(MonName)
	if not getgenv().remilia.Data["Enemy Spawns"][MonName] then
		local v65 = workspace.Enemies:FindFirstChild(MonName) or game.ReplicatedStorage:FindFirstChild(MonName) or getgenv().remilia.Data['Spawned Boss'][MonName]
		if not v65 then
			return
		end
		return v65:GetModelCFrame()
	end
	if not getgenv().remilia.Data["Enemy Spawns"][MonName][v40] then
		v40 = 0
	end
	v40 = v40 + 1
	return getgenv().remilia.Data["Enemy Spawns"][MonName][v40] or getgenv().remilia.Data["Enemy Spawns"][MonName][1]
end

function Grab(a1)
	if t4 and os.time() - t4 < 2 then
		return
	end
	t4 = os.time()
	pcall(
        function()
		sethiddenproperty(LocalPlayer, "SimulationRadius", 2000)
	end)
	a1 = tostring(a1)
	if not workspace.Enemies:FindFirstChild(a1) then
		return
	end
	local v35, v36 = workspace.Enemies:FindFirstChild(a1), {}
	for _, v in workspace.Enemies:GetChildren() do
		if v35:FindFirstChild("HumanoidRootPart") and v.Name == a1 and CaculateDistance(v.HumanoidRootPart.Position, v35.HumanoidRootPart.Position) < 400 then
            --Instance.new("Part", v).Name = "Chit Tao Di Huhuhu"
			table.insert(v36, v.HumanoidRootPart.Position)
		end
	end
	local v37, v38 = nil, 0
	for _, v in v36 do
		if not v37 then
			v37 = v
		else
			v37 = v37 + v
		end
		v38 = v38 + 1
	end
	if # v36 == 0 then
		return
	end
	local v39 = v37 / v38
	for _, v in workspace.Enemies:GetChildren() do
		if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and CaculateDistance(v.HumanoidRootPart.Position, v39) < 400 and v.Name == a1 then
			v.HumanoidRootPart.CFrame = CFrame.new(v39)
		end
	end
end

function MeleeTask()
	local CurrentPlayerBeli = getgenv().remilia.Data["Player Data"].Beli
	local CurrentPlayerFragments = getgenv().remilia.Data["Player Data"].Fragments
	local Melees = getgenv().remilia.Data.Melees
	if not Melees then
		return
	end
	if not Melees["Black Leg"] then
		SetStatus(2, "Farming Until Reach 150,000$")
		if CurrentPlayerBeli > 150000 then
			FireRemotes(1, "BuyBlackLeg")
		end
	elseif Melees["Black Leg"] < 300 then
		SetStatus(2, "Farming Until Black Leg Reach 300 Mastery")
		if not GetBackpack("Black Leg") then
			FireRemotes(1, "BuyBlackLeg")
		end
	elseif Melees["Black Leg"] >= 300 and not Melees["Electro"] then
		if CurrentPlayerBeli < 500000 then
			SetStatus(2, "Farming Until Reach 500,000$")
		else
			FireRemotes(1, "BuyElectro")
		end
	elseif Melees["Electro"] < 300 then
		SetStatus(2, "Farming Until Electro Reach 300 Mastery")
		if not GetBackpack("Electro") then
			FireRemotes(1, "BuyElectro")
		end
	elseif Melees["Electro"] >= 300 and not Melees["Fishman Karate"] then
		SetStatus(2, "Farming Until Reach 750,000$")
		if CurrentPlayerBeli > 750000 then
			FireRemotes(1, "BuyFishmanKarate")
		end
	elseif Melees["Fishman Karate"] < 300 then
		SetStatus(2, "Farming Until Fishman Karate Reach 300 Mastery")
		if not GetBackpack("Fishman Karate") then
			FireRemotes(1, "BuyFishmanKarate")
		end
	elseif Melees["Fishman Karate"] >= 300 and not Melees["Dragon Claw"] then
		SetStatus(2, "Farming Until Reach 1,5k f")
		if CurrentPlayerFragments >= 1500 then
			FireRemotes(1, "BlackbeardReward", "DragonClaw", "2")
		end
	elseif Melees["Dragon Claw"] < 300 then
		SetStatus(2, "Farming Until Dragon Claw Reach 300 Mastery")
		if not GetBackpack("Dragon Claw") then
			FireRemotes(1, "BlackbeardReward", "DragonClaw", "2")
		end
	elseif Melees["Dragon Claw"] >= 300 and not Melees["Superhuman"] then
		SetStatus(2, "Farming Until Reach 3M b$")
		if CurrentPlayerBeli >= 3000000 then
			FireRemotes(1, "BuySuperhuman")
		end
	elseif Melees["Superhuman"] < 400 then
		SetStatus(2, "Farming Until Superhuman Reach 400 Mastery")
		if not GetBackpack("Superhuman") then
			FireRemotes(1, "BuySuperhuman")
		end
	elseif Melees["Superhuman"] >= 400 and Melees["Black Leg"] <= 400 then
		SetStatus(2, "Farming Until Black Leg Reach 400 Mastery")
		if not GetBackpack("Black Leg") then
			FireRemotes(1, "BuyBlackLeg")
		end
	elseif Melees["Black Leg"] >= 400 and not Melees["Death Step"] then
		SetStatus(2, "Farming Until Reach 5kf and 2,5m$ For Death Step")
		if CurrentPlayerBeli >= 2500000 and CurrentPlayerFragments >= 5000 then
			FireRemotes(1, "BuyDeathStep")
		end
	elseif Melees["Death Step"] < 400 then
		if not GetBackpack("Death Step") then
			FireRemotes(1, "BuyDeathStep")
		end
		SetStatus(2, "Farming Until Death Step Reach 400 Mastery")
	elseif Melees["Electro"] <= 400 then
		if not GetBackpack("Electro") then
			FireRemotes(1, "BuyElectro")
		end
		SetStatus(2, "Farming Until Electro Reach 400 Mastery")
	elseif not Melees["Electric Claw"] then
		SetStatus(2, "Farming Until Reach 5kf and 2,5m$ For Electric Claw")
		if CurrentPlayerBeli >= 2500000 and CurrentPlayerFragments >= 5000 then
			FireRemotes(1, "BuyElectricClaw")
		end
	elseif Melees["Electric Claw"] < 400 then
		if not GetBackpack("Electric Claw") then
			FireRemotes(1, "BuyElectricClaw")
		end
		SetStatus(2, "Farming Until Electric Claw Reach 400 Mastery")
	elseif Melees["Fishman Karate"] < 400 then
		if not GetBackpack("Fishman Karate") then
			FireRemotes(1, "BuyFishmanKarate")
		end
		SetStatus(2, "Farming Until Fishman Karate Reach 400 Mastery")
	elseif not Melees["Sharkman Karate"] then
		SetStatus(2, "Farming Until Enough Beli and Fragments For Sharkman Karate")
		if CurrentPlayerBeli > 2500000 and CurrentPlayerFragments >= 5000 then
			FireRemotes(1, "BuySharkmanKarate")
		end
	elseif Melees["Sharkman Karate"] < 400 then
		SetStatus(2, "Farming Until Sharkman Karate Reach 400 Mastery")
		if not GetBackpack("Sharkman Karate") then
			FireRemotes(1, "BuySharkmanKarate")
		end
	elseif Melees["Dragon Claw"] < 400 then
		SetStatus(2, "Farming Until Dragon Claw Reach 400 Mastery")
		if not GetBackpack("Dragon Claw") then
			FireRemotes(1, "BlackbeardReward", "DragonClaw", "2")
		end
	elseif not Melees["Dragon Talon"] then
		SetStatus(2, "Farming Until Enough Beli and Fragments For Dragon Talon")
		if CurrentPlayerBeli > 2500000 and CurrentPlayerFragments >= 5000 then
			FireRemotes(1, "BuyDragonTalon")
		end
	elseif Melees["Dragon Talon"] < 400 then
		SetStatus(2, "Farming Until Dragon Talon Reach 400 Mastery")
		if not GetBackpack("Dragon Talon") then
			FireRemotes(1, "BuyDragonTalon")
		end
	elseif not Melees["Godhuman"] then
		SetStatus(2, "Godhuman")
		getgenv().Task2 = "Godhuman"
		if getgenv().remilia.Data["Player Inventory"]["Magma Ore"] and getgenv().remilia.Data["Player Inventory"]["Magma Ore"].Count >= 20 and CurrentPlayerFragments >= 5000 and CurrentPlayerBeli >= 5000000 then
			FireRemotes(1, "BuyGodhuman", true)
			FireRemotes(1, "BuyGodhuman")
		end
	elseif Melees["Godhuman"] < 400 then
		SetStatus(2, "Farming Until Godhuman Reach 400 Mastery")
		if Task2 == "Godhuman" then
			getgenv().Task2 = ""
		end
		if not GetBackpack("Godhuman") then
			FireRemotes(1, "BuyGodhuman")
		end
	elseif not ForceCDK then
		passed1 = false
		for v78, v79 in getgenv().remilia.Data["Player Inventory"] do
			if v79.Type == "Sword" then
				if v78 == "Yama" or v78 == "Tushita" then
					v81 = 350
				else
					for _, v80 in v79.MasteryRequirements do
						v81 = v80
					end
				end
				if v79.Mastery < v81 then
					SetStatus(2, "Mastery Farming: " .. v78 .. " (" .. v79.Mastery .. " / " .. v81 .. ")")
					getgenv().remilia.Data["Current Weapon"] = "Sword"
					if not GetBackpack(v78) then
						FireRemotes(1, "LoadItem", v78)
					end
					passed1 = true
					return
				end
			end
		end
		if not passed1 then
			for i, v in getgenv().remilia.Data.Melees do
				if v < 600 then
					if not GetBackpack(i) then
						FireRemotes(1, "Buy" .. string.gsub(tostring(i), " ", ""))
					end
					getgenv().remilia.Data["Current Weapon"] = "Melee"
					SetStatus(2, "Farming Until " .. tostring(i) .. " Reach 600 Mastery")
					break
				end
			end
		end
	end
end
v74 = {
	["Fish Tail"] = {
		20,
		3,
		{
			"Fishman Raider",
			"Fishman Captain"
		}
	},
	["Dragon Scale"] = {
		10,
		3,
		{
			"Dragon Crew Warrior",
			"Dragon Crew Archer"
		}
	},
	["Magma Ore"] = {
		20,
		2,
		{
			"Magma Ninja"
		}
	},
	["Mystic Droplet"] = {
		10,
		2,
		{
			"Sea Soldier",
			"Water Fighter"
		}
	}
}
function MeleeTask2()
	local CurrentPlayerBeli = getgenv().remilia.Data["Player Data"].Beli
	local CurrentPlayerFragments = getgenv().remilia.Data["Player Data"].Fragments
	local Melees = getgenv().remilia.Data.Melees
	if not Melees then
		return
	end
	if not Melees["Black Leg"] and CurrentPlayerBeli > 150000 then
		FireRemotes(1, "BuyBlackLeg")
	elseif Melees["Black Leg"] and Melees["Black Leg"] >= 300 and CurrentPlayerBeli > 500000 and not Melees["Electro"] then
		FireRemotes(1, "BuyElectro")
	elseif Melees["Electro"] and Melees["Electro"] >= 300 and CurrentPlayerBeli > 750000 and not Melees["Fishman Karate"] then
		FireRemotes(1, "BuyFishmanKarate")
	elseif Melees["Fishman Karate"] and Melees["Fishman Karate"] > 300 and CurrentPlayerFragments > 1500 and not Melees["Dragon Claw"] then
		FireRemotes(1, "BlackbeardReward", "DragonClaw")
	end
end

function CheckRaceV2Upgradeable()
	if getgenv().remilia.Data["Player Data"].Level < 900 or getgenv().remilia.Data["Player Data"].Beli < 1000000 or not getgenv().remilia.Data["Player Inventory"]["Warrior Helmet"] or getgenv().remilia.Data["Player Data"]["Race Level"] ~= 1 then
		return
	end
	return true
end

function CheckRaceV3Upgradeable()
	if getgenv().remilia.Data["Player Data"].Level < 1100 or getgenv().remilia.Data["Player Data"].Beli < 2500000 or getgenv().remilia.Data["Player Data"]["Race Level"] ~= 2 then
		return
	end
	local v48 = {
		"Fajita",
		"Jeremy",
		"Diamond"
	}
	local v49 = getgenv().remilia.Data["Player Data"].Race
	for i, v in getgenv().remilia.Cache.RaceV3[v49] do
		if v49 == "Human" then
			if getgenv().remilia.Data["Spawned Boss"][v48[i]] then
				return getgenv().remilia.Data["Spawned Boss"][v48[i]]
			end
		elseif v49 == "Skypiean" then
			for _, v in Players:GetPlayers() do
				if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Data.Race.Value == "Skypiea" and not CheckIsPositionOnSafezone(GetPlayerCFrame(v)) then
					return v
				end
			end
		elseif v49 == "Mink" then
			return true
		elseif v49 == "Fishman" then
		end
	end
end

getgenv().remilia.Cache.RaceV3 = {
	Human = {
		0,
		0,
		0
	},
	Mink = {
		0
	},
	Fishman = {
		false
	},
	Skypiea = {
		false
	}
}

local v51 = false
function DoRaceV3()
	local Race = getgenv().remilia.Data["Player Data"].Race
	local v50 = CheckRaceV3Upgradeable()
	if not v50 then
		return
	end
	if not v51 then
		FireRemotes(1, "Wenlocktoad", "1")
		wait()
		FireRemotes(1, "Wenlocktoad", "2")
		v51 = true
		RefreshRace()
	end
	if Race == "Human" then
		SetStatus(1, "Doing Race V3 Quest - Human - Defeating " .. tostring(v50))
		chotung2(v50.Name, 1)
		FireRemotes(1, "Wenlocktoad", "3")
	elseif Race == "Skypiean" then
		TweenTo(GetPlayerCFrame(v))
		Click()
	end
end

function GetBackpack(i)
	local v33 = {}
	for _, v in LocalPlayer.Backpack:GetChildren() do
		if v:IsA("Tool") then
			if tostring(v) == i or string.find(tostring(v), i) or v.ToolTip == i then
				return v
			end
		end
	end
	for _, v in LocalPlayer.Character:GetChildren() do
		if v:IsA("Tool") then
			if tostring(v) == i or string.find(tostring(v), i) or v.ToolTip == i then
				return v
			end
		end
	end
end

v34 = false
function DoRaceV2()
	print("call")
	SetStatus(1, "Doing Race V2 Quest")
	if not CheckRaceV2Upgradeable() then
		print("#1 break")
		return
	end
	FireRemotes(1, "Alchemist", "1")
	FireRemotes(1, "Alchemist", "2")
	if not GetBackpack("Flower 1") and workspace:FindFirstChild("Flower1").Transparency == 0 then
		TweenTo(workspace.Flower1.CFrame)
		print("#1 flower")
		v67 = true
	elseif not GetBackpack("Flower 2") and workspace:FindFirstChild("Flower2").Transparency == 0 then
		TweenTo(workspace.Flower2.CFrame)
		print("#2 flower")
	elseif not GetBackpack("Flower 3") then
		chotung2("Swan Pirate")
		print("#3 flower")
	else
		TweenTo(getgenv().remilia.Data.Safezones[1][1] + Vector3.new(math.random(- 6, 6), math.random(- 6, 6), math.random(- 6, 6)))
		FireRemotes(1, "Alchemist", "3")
		wait(3)
		if v67 and not GetBackpack('Flower 1') then
			getgenv().remilia.Data["Player Data"]["Race Level"] = 2
		end
	end  
    
end


function SortMon()
	_, v70 = pcall(function()
		uaaa = {}
		for _, v in workspace.Enemies:GetChildren() do
			if v.Name ~= "PirateBasic" and v.Name ~= "PirateBrigade" and v:FindFirstChild"HumanoidRootPart" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
				table.insert(uaaa, v)
			end
		end
		table.sort(uaaa, function(aL, aM)
			return CaculateDistance(aL.HumanoidRootPart.Position) < CaculateDistance(aM.HumanoidRootPart.Position)
		end)
		return uaaa
	end)
	return v70 or workspace.Enemies:GetChildren()
end 

function CheckIsMonAvailable(m)
	return workspace.Enemies:FindFirstChild(m) or game.ReplicatedStorage:FindFirstChild(m)
end 

function conchoteru(vc)
	dicho = tostring(vc)
	mm2 = dicho
	if mm2 == "Deandre" or mm2 == "Diablo" or mm2 == "Urban" then
		alert("Main Process", "Deeating Elite")
		FireRemotes(1, "EliteHunter")
	end
	ngu = game.ReplicatedStorage:FindFirstChild(dicho) or workspace.Enemies:FindFirstChild(dicho)
	if ngu then
		v = ngu
		if v.Parent == workspace.Enemies and (not v:FindFirstChild("Humanoid") or v.Humanoid.Health < 1) then
			return
		end
		if v:FindFirstChild("HumanoidRootPart") then
			repeat
				task.wait()
				EquipTool(getgenv().remilia.Data["Current Weapon"])
				if v:FindFirstChild("HumanoidRootPart") then
					if getgenv().remilia.Cache.DashSkillTick and os.time() - getgenv().remilia.Cache.DashSkillTick < 5 then
						TweenTo(v.HumanoidRootPart.CFrame + Vector3.new(0, 300, 40))
					else
						TweenTo(v.HumanoidRootPart.CFrame + Vector3.new(0, 40, 15))
						Click2()
					end
				else
					v:Destroy()
				end
			until not v or not v:FindFirstChild("Humanoid") or v.Humanoid.Health < 1
			return true
		end
	end 
end 

function chotung2(mm)
	local EnemyList = workspace.Enemies
	if typeof(mm) ~= "table" then
		mm = {
			mm
		}
	end
	for _, v5 in mm do
		if not workspace.Enemies:FindFirstChild(v5) then
			repeat
				task.wait()
				local v6 = GetNextBringPoint(v5) + Vector3.new(0, 55, 0)
				if CaculateDistance(v6) > 55 then
					repeat
						task.wait()
						TweenTo(v6)
					until CaculateDistance(v6) < 10
				else
					LocalPlayer.Character.HumanoidRootPart.CFrame = PositionParser("CFrame", v6)
				end
			until CaculateDistance(v6) < 10
		end
		for _, v in SortMon() do
			if table.find(mm, v.Name) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
				repeat
					task.wait()
					Grab(v)
					EquipTool(getgenv().remilia.Data["Current Weapon"])
					if v:FindFirstChild("HumanoidRootPart") then
						if getgenv().remilia.Cache.DashSkillTick and os.time() - getgenv().remilia.Cache.DashSkillTick < 5 then
							TweenTo(v.HumanoidRootPart.CFrame + Vector3.new(0, 80, 40))
						else
							TweenTo(v.HumanoidRootPart.CFrame + Vector3.new(0, 40, 15))
							Click2()
						end
					else
						v:Destroy()
					end
				until not v or not v:FindFirstChild("Humanoid") or v.Humanoid.Health < 1
				return true
			end
		end
	end
end
LocalPlayer.Character.ChildAdded:Connect(
    function(c)
	if string.find(c.Name, "Fruit") and not getgenv().remilia.Cache.LoadFruit[c.Name] then
		if getgenv().remilia.Cache.LoadFruit[c.Name] then
			getgenv().remilia.Cache.LoadFruit[c.Name] = nil
			return
		end
		wait(1)
		vlthua = tostring(c.Parent)
            --repeat wait()
		FireRemotes(1, "StoreFruit", tostring(c:GetAttribute("OriginalName") or getgenv().remilia.Data["Fruit Name To Id"][tostring(c)]), c) 
              
            --until tostring(c.Parent) ~= vlthua or (getgenv().StoreSecs and os.time()-getgenv().StoreSecs < 5)
            --c:Destroy()
	end
end)

LocalPlayer.Backpack.ChildAdded:Connect(
    function(c)
	if string.find(c.Name, "Fruit") and not getgenv().remilia.Cache.LoadFruit[c.Name] then
		if getgenv().remilia.Cache.LoadFruit[c.Name] then
			getgenv().remilia.Cache.LoadFruit[c.Name] = nil
			return
		end
		wait(1)
		vlthua = tostring(c.Parent)
            --repeat wait()
		FireRemotes(1, "StoreFruit", tostring(c:GetAttribute("OriginalName") or getgenv().remilia.Data["Fruit Name To Id"][tostring(c)]), c)
           -- until tostring(c.Parent) ~= vlthua or (getgenv().StoreSecs and os.time()-getgenv().StoreSecs < 5)
	end
end)

function SnipeFruit()
	for i, v in FireRemotes(1, "GetFruits") do
		if v.OnSale and table.find(Config.Main["Snipe Fruit"]["Snipe List"], v.Name) and tostring(getgenv().remilia.Data["Player Data"].DevilFruit) == "" then
			wait(3)
			FireRemotes("PurchaseRawFruit", v.Name)
		end
	end
end

function EatFruit(Fruit)
	if getgenv().remilia.Data["Fruit Prices"][getgenv().remilia.Data["Fruit Name To Id"][Fruit] or Fruit] < getgenv().remilia.Data["Fruit Prices"][getgenv().remilia.Data["Player Data"].DevilFruit] then
		return
	end
	if not Fruit then
		return
	end
	while tostring(Fruit.Parent) == tostring(LocalPlayer) do
		repeat
			wait()
			TweenTo(GetPlayerCFrame(LocalPlayer) + Vector3.new(0, 500, 0))
			EquipTool(tostring(Fruit))
		until LocalPlayer.Character:FindFirstChild("EatRemote")
		wait()
		LocalPlayer.Character.EatRemote:InvokeServer()
	end
end

function IsQuestVisible()
	return LocalPlayer.PlayerGui.Main.Quest.Visible
end

function NameParser(i)
	if string.find(i, "Mil. ") then
		i = string.gsub(i, "Mil. ", "Military ")
	end
	return i
end

function GetCurrentProcessingQuest()
	local QuestFrame = LocalPlayer.PlayerGui.Main.Quest
	if not QuestFrame.Visible then
		return false
	end
	if string.find(QuestFrame.Container.QuestTitle.Title.Text, "Military") then
		return string.gsub(
            QuestFrame.Container.QuestTitle.Title.Text:gsub("%s*Defeat%s*(%d*)%s*(.-)%s*%b()", "%2"), "Military", "Mil.")
	end
	return QuestFrame.Container.QuestTitle.Title.Text:gsub("%s*Defeat%s*(%d*)%s*(.-)%s*%b()", "%2")
end


function CheckZouRequirements()
	if getgenv().remilia.Data["Player Data"].Level < 1525 or not getgenv().remilia.Cache.ZQuestProgress1 then
		return
	end
	return getgenv().remilia.Cache.ZQuestProgress1 == 0
end 

function DoZouQuest()
	if not CheckZouRequirements() then
		return
	end
	SetStatus(1, "Doing Sea 3 Quest")
	repeat
		wait()
		FireRemotes(1, "ZQuestProgress", "Begin")
	until CaculateDistance(Vector3.new(0, 0, 0)) > 8000
	spawn(function()
		chotung2("rip_indra")
	end)
	repeat
		wait(1)
	until CaculateDistance(Vector3.new(0, 0, 0)) < 6000
	HopServer("Teleport To Zou For Next Process", 3, true, 3)
end 


OldPos = nil
function CaculateEnemyVelocity()
	if not remilia.Enemy:IsAlive() then
		return
	end
	OldPos = OldPos or remilia.Enemy:GetPosition()
	dig = remilia.Enemy:GetPosition() - OldPos
	OldPos = remilia.Enemy:GetPosition()
end

function RedeemX2Codes()
	if not getgenv().remilia.Data["Exp Boost Expired"] then
		return
	end
	FireRemotes(2, ({
		"Sub2CaptainMaui",
		"CODE_SERVICIO",
		"CINCODEMAYO_BOOST",
		"15B_BESTBROTHERS",
		"DEVSCOOKING",
		"GAMERROBOT_YT",
		"ADMINGIVEAWAY",
		"GAMER_ROBOT_1M",
		"TY_FOR_WATCHING",
		"kittgaming",
		"Sub2Fer999",
		"Enyu_is_Pro",
		"Magicbus",
		"JCWK",
		"Starcodeheo",
		"Bluxxy",
		"fudd10_v2",
		"FUDD10",
		"BIGNEWS",
		"THEGREATACE",
		"SUB2GAMERROBOT_EXP1",
		"Sub2OfficialNoobie",
		"StrawHatMaine",
		"SUB2NOOBMASTER123",
		"Sub2Daigrock",
		"Axiore",
		"TantaiGaming"
	})[math.random(1, 25)])
end

function LevelFarm()
	lCall = lCall or os.time()
	if Task1 == "Finding Hunter Target" then
		return
	end
	if os.time() - lCall < 3 then
		return
	end
	if getgenv().Task2 == "Godhuman" then
		v77 = getgenv().remilia.Data["Player Inventory"]
		for v75, v76 in v74 do
			if not v77[v75] or v77[v75].Count < v76[1] then
				if getgenv().remilia.Data.Sea ~= v76[2] then
					HopServer("Farming Godhuman Material: " .. v75 .. " x" .. v76[1], 3, 1, v76[2])
					wait(6)
				else
					SetStatus(1, "Farming Godhuman Material - " .. v75 .. "x" .. v76[1])
					chotung2(v76[3])
					return
				end
			end
		end
		if getgenv().remilia.Data["Player Data"]["Beli"] > 5000000 and getgenv().remilia.Data["Player Data"].Fragments >= 5000 then
			FireRemotes(1, "BuyGodhuman")
		end
	end
	if getgenv().remilia.Data["Exp Boost Expired"] and not getgenv().remilia.Data["Player Inventory"]["Soul Guitar"] and getgenv().remilia.Data["Player Inventory"].Ectoplasm and getgenv().remilia.Data["Player Inventory"].Ectoplasm.Count < 250 then
		SetStatus(1, "Farming Soul Guitar Material: Ectoplasm")
		if getgenv().remilia.Data.Sea ~= 2 then
			HopServer("SG Material", 1, 1, 2)
			wait(4)
			return
		end
		chotung2({
			"Ship Deckhand",
			"Ship Engineer",
			"Ship Steward",
			"Ship Officer"
		})
		return
	end
	if getgenv().remilia.Data["Player Data"].Level >= 725 and (getgenv().remilia.Data.Sea == 1 or (not getgenv().remilia.Data.Requirements.OpenWaterKey and getgenv().remilia.Data.Sea == 3)) then
		HopServer("  ", 1, 1, 2)
		wait(4)
	end
	if getgenv().remilia.Data["Player Data"].Level >= 1525 and getgenv().remilia.Data.Sea ~= 3 and getgenv().remilia.Cache.ZQuestProgress1 == 1 and getgenv().remilia.Data.Requirements.OpenWaterKey then
		HopServer("  ", 1, 1, 3)
		wait(4)
	end
	local CurrentQuest = GetQuest()
	if getgenv().remilia.Data["Player Data"].Level == getgenv().remilia.Data["Max Level"] or ( getgenv().remilia.Data["Exp Boost Expired"] and getgenv().remilia.Data.Sea == 3 and getgenv().remilia.Data["Player Data"].Level > 2049 and getgenv().remilia.Data["Player Inventory"].Bones and getgenv().remilia.Data["Player Inventory"].Bones.Count < 500) then
		if getgenv().remilia.Data["Player Data"].Level == getgenv().remilia.Data["Max Level"] and getgenv().remilia.Data["Player Data"].Fragments < 20000 then
			SetStatus(1, "Farming Cake Prince")
			chotung2(
                   getgenv().remilia.Data["Spawned Boss"]["Cake Prince"] or getgenv().remilia.Data["Spawned Boss"]["Dough King"] or {
				"Head Baker",
				"Baking Staff",
				"Cookie Crafter",
				"Cake Guard"
			})
		else
			SetStatus(1, "Farming Bone")
			chotung2({
				"Reborn Skeleton",
				"Living Zombie",
				"Demonic Soul",
				"Posessed Mummy"
			})
		end
	elseif CurrentQuest then
		RedeemX2Codes()
		SetStatus(1, "Level Farming - " .. tostring(CurrentQuest.NameMon))
		wait()
		if (IsQuestVisible() == true) and (string.sub(GetCurrentProcessingQuest(), 1, - 2) ~= CurrentQuest.NameMon) then
			FireRemotes(1, "AbandonQuest")
			wait()
			wait()
		end
		if not IsQuestVisible() then
			while CaculateDistance(CurrentQuest.QuestPosition) > 15 do
				TweenTo(CurrentQuest.QuestPosition)
				wait()
				wait()
				return
			end
			LocalPlayer.Character:SetPrimaryPartCFrame(PositionParser("CFrame", CurrentQuest.QuestPosition))
			wait(1)
			OldQuest = CurrentQuest.NameMon
			FireRemotes(1, "StartQuest", CurrentQuest.QuestId, CurrentQuest.QuestLevel)
		end
    
            --warn(CurrentQuest.QuestId, CurrentQuest.QuestLevel, CurrentQuest.NameMon)
		if CurrentQuest.QuestId == "BartiloQuest" then
			CurrentQuest.NameMon = "Swan Pirate"
		end
		repeat
			task.wait()
			if not GetCurrentProcessingQuest() then
				return
			end
			chotung2(NameParser(CurrentQuest.NameMon))
		until not IsQuestVisible() or not string.find(GetCurrentProcessingQuest(), CurrentQuest.NameMon)
	end
end

function SkipFarm()
	RedeemX2Codes()
	if getgenv().remilia.Data["Player Data"].Level < 30 then
		SetStatus(1, "Skip Farming - 1 - Sky Bandit")
		return chotung2("Sky Bandit")
	end
	SetStatus(1, "Skip Farming - 2 - Shanda - God Guard")
	return chotung2({
		"Shanda",
		"God's Guard"
	})
end

function NhatFruit()
	for _, v in getgenv().remilia.Data["Fruit Spawn"] do
		SetStatus(1, "Collecting Fruit: " .. tostring(v))
		repeat
			wait()
			pcall(function()
				TweenTo(v.Handle.CFrame or v:GetModelCFrame())
			end)
		until v.Parent ~= workspace
	end
end



print"oo gya"

print("ok")
repeat
	wait()
	print"Waiting Model - 2 "
until getgenv().remilia 
print("OK Modules: Dataload")
getgenv().remilia["Data"] = {
	["Max Level"] = 2550,
	["Unlockables"] = FireRemotes(1, "GetUnlockables"),
	["Current Weapon"] = "Melee",
	["Player Data"] = {
		["Race Level"] = nil
	},
	["Horned Man"] = FireRemotes(1, "HornedMan") == 1,
	["Player Inventory"] = {},
	["Elite Count"] = 0,
	["Exp Boost Expired"] = false,
	["Melees"] = {},
	["Requirements"] = {},
	["Spawned Boss"] = {},
	["Chest"] = {},
	["Mob List"] = {},
	["Enemy Spawns"] = {},
	["Fruit Spawn"] = {},
	["Fruit Prices"] = {},
	["Fruit Id To Name"] = {},
	["Fruit Name To Id"] = {},
	["NPCs"] = {},
	["Safezones"] = {},
	["Sea"] = (function()
		return ({
			Zou = 3,
			Dressrosa = 2,
			Main = 1
		})[getsenv(game.ReplicatedStorage.GuideModule)["_G"]["CurrentWorld"]]
	end)(), -- indent = tay :sob:
	["Script Env"] = {}
}

for i, v in FireRemotes(1, "GetFruits") do
	getgenv().remilia.Data["Fruit Prices"][v.Name] = v.Price 
end


c1 = 0
for _, v1 in FireRemotes(1, "GetFruits") do
	c1 = c1 + 1
	local Parts = {}
	for Part in string.gmatch(v1.Name, "[^-]+") do
		table.insert(Parts, Part)
	end
	local Key = table.concat(Parts, "-")
	local Value = Parts[1] .. " Fruit"
	getgenv().remilia.Data["Fruit Id To Name"][Key] = Value
end
getgenv().remilia.Data["Fruit Id To Name"]["Human-Human: Buddha"] = "Human: Buddha Fruit"
getgenv().remilia.Data["Fruit Id To Name"]["Bird-Bird: Phoenix"] = "Bird: Phoenix Fruit"
getgenv().remilia.Data["Fruit Id To Name"]["Bird-Bird: Falcon"] = "Bird: Falcon Fruit"
for i, v in getgenv().remilia.Data["Fruit Id To Name"] do
	getgenv().remilia.Data["Fruit Name To Id"][v] = i 
end 

getgenv().remilia.Data["Fruit Name To Id"]["Human: Buddha Fruit"] = "Human-Human: Buddha"
getgenv().remilia.Data["Fruit Name To Id"]["Bird: Phoenix Fruit"] = "Bird-Bird: Phoenix"
getgenv().remilia.Data["Fruit Name To Id"]["Bird: Falcon Fruit"] = "Bird-Bird: Falcon"

warn("Parsed " .. tostring(c1) .. " Fruits")



table.foreach(workspace._WorldOrigin.SafeZones:GetChildren(), function(_, v)
	table.insert(getgenv().remilia.Data.Safezones, {
		v.CFrame,
		v.Mesh.Scale
	}) 
end) 


local MeleesTable = {
	"BlackLeg",
	"Electro",
	"FishmanKarate",
	"DragonClaw",
	"Superhuman",
	"DeathStep",
	"ElectricClaw",
	"SharkmanKarate",
	"DragonTalon",
	"Godhuman"
} 



function RefreshInventory(i, ii)
	if ii then
		i = ii
	end
	if i:IsA('Tool') and tostring(i.ToolTip) == "Melee" then
		i:WaitForChild("Level")
		CurrentMelee = i
		getgenv().remilia.Data.Melees[i.Name] = i.Level.Value
	end
	if i.Name == "Hidden Key" then
		FireRemotes(1, "OpenRengoku")
	elseif i.Name == "Library Key" then
	elseif i.Name == "Water Key" then
		repeat
			task.wait()
			EquipTool('Water Key')
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate", true);
		until typeof(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)) ~= "string"
		getgenv().remilia.Data.Requirements.OpenWaterKey = true
	end
end

getgenv().remilia.Data.Requirements.OpenLibrary = FireRemotes(1, "OpenLibrary") 


LocalPlayer.Character.ChildAdded:Connect(RefreshInventory)
LocalPlayer.Backpack.ChildAdded:Connect(RefreshInventory)

for _, M1 in MeleesTable do
	if M1 == "DragonClaw" then
		FireRemotes(1, "BlackbeardReward", "DragonClaw", "2")
	else
		FireRemotes(1, "Buy" .. M1)
		wait()
		EquipTool("Melee")
		wait()
	end 
    
end 

Quests = require(game.ReplicatedStorage.Quests) 

local MonList = {}
for _, v1 in Quests do
	for _, v2 in v1 do
		getgenv().remilia.Data["Mob List"][v2.Name] = v2.LevelReq
	end 
end 

function Bosses(i, ii)
	spawn(function()
		if ii then
			i = ii
		end
		if i:FindFirstChild('Humanoid') and (string.find(tostring(i.Humanoid.DisplayName), "Boss") or i.Name == "Deandre" or i.Name == "Diablo" or i.Name == "Urban" or i.Name == "Core") and i.Humanoid.Health > 0 then
			if i.Name == 'Soul Reaper' then
				request(
        {
					Url = "https://discord.com/api/webhooks/1266066727368790058/4Q1FIq0wAHQ1RBes4s4gOkTDzIH8c6ffs32I4F4bhUcqNlWfPYu_lWQS8N--dqKJVaQ6",
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json"
					},
					Body = game:GetService("HttpService"):JSONEncode({
						content = "SPAWNED NIGGA"
					})
				})
			end
			getgenv().remilia.Cache["Spawned Boss"][i.Name] = i
		end
	end) 
end 

getgenv().remilia.Cache["Spawned Boss"] = {}
workspace.Enemies.ChildAdded:Connect(Bosses) 
game.ReplicatedStorage.ChildAdded:Connect(Bosses) 


repeat
	wait(1)
until tostring(LocalPlayer.Team) ~= "Nature" and LocalPlayer:FindFirstChild("Data") 

function ParseMobName(a)
	return tostring(tostring(a):gsub(" %pLv. %d+%p", ""):gsub(" %pRaid Boss%p", ""):gsub(" %pBoss%p", ""))
end 

function AddPoint()
	local data = {
		Melee = LocalPlayer.Data.Stats.Melee.Level.Value,
		Defense = LocalPlayer.Data.Stats['Defense'].Level.Value,
		["Blox Fruit"] = LocalPlayer.Data.Stats["Demon Fruit"].Level.Value,
		Gun = LocalPlayer.Data.Stats.Gun.Level.Value,
		Sword = LocalPlayer.Data.Stats.Sword.Level.Value
	}
	r6 = remilia.Data["Current Weapon"]
	if data.Defense < remilia.Data["Player Data"].Level / 1.5 then
		r6 = "Defense"
	end
	if data[r6] >= remilia.Data["Max Level"] then
		return
	end
	FireRemotes(1, "AddPoint", r6, 300)
end 

for i, v in LocalPlayer.Data:GetChildren() do
	if pcall(function()
		return v.Value
	end) then
		getgenv().remilia["Data"]["Player Data"][tostring(v)] = v.Value
		spawn(function()
			v:GetPropertyChangedSignal("Value"):Connect(function()
				getgenv().remilia["Data"]["Player Data"][tostring(v)] = v.Value
			end)
		end)
	end
end


function kgay(a)
	if a:IsA("Part") then
		return a.CFrame
	else
		return a:GetModelCFrame().Position
	end 
end 
    
function gay0(_, tungcucsac)
	if tungcucsac == nil then
		return
	end
	mn = ParseMobName(tostring(tungcucsac))
	if not tungcucsac then
		return
	end
	if not getgenv().remilia.Data["Enemy Spawns"][tostring(mn)] then
		getgenv().remilia.Data["Enemy Spawns"][mn] = {}
	end
	table.insert(getgenv().remilia.Data["Enemy Spawns"][tostring(mn)], kgay(tungcucsac))
	local v33 = os.time()
end
    
    
function v0(i, nghiem)
	if nghiem == nil then
		return
	end
	spawn(function()
		local hoang = (string.lower(tostring(nghiem)))
		if nghiem:FindFirstChild("Head") then
			if nghiem.Head:FindFirstChild("QuestBBG") then
				if not getgenv().remilia.Data.NPCs[tostring(nghiem)] then
					getgenv().remilia.Data.NPCs[tostring(nghiem)] = {}
				end
				table.insert(getgenv().remilia.Data.NPCs[tostring(nghiem)], nghiem:GetModelCFrame())
			else
				gay0(nghiem)
			end
		end
	end)
end 

table.foreach(workspace.Enemies:GetChildren(), gay0) 


table.foreach(game.Workspace.NPCs:GetChildren(), v0)

table.foreach(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren(), gay0)

table.foreach(getnilinstances(), v0)
table.foreach(game.ReplicatedStorage:GetChildren(), v0)


getgenv().remilia["Data"]["Elite Count"] = FireRemotes(1, "EliteHunter", "Progress") 

_G.upelite = function()
	getgenv().remilia["Data"]["Elite Count"] = getgenv().remilia["Data"]["Elite Count"] + 1
end 

_G.pirateraid = function(b1)
	b2 = (b1 and os.time()) or 0
	getgenv().remilia.Cache.PirateRaidStamp = b2 
end 

ruanuong2 = Instance.new("StringValue", workspace) 
ruanuong2.Name = "LastNotification"  
ruanuong2.Changed:Connect(function(c)
	v21 = c
	if string.find(v21, "HUNTER MISSION COMPLETED") then
		_G.upelite()
	end
	if string.find(v21, "torch") then
		getgenv().DimensionTick = os.time()
		getgenv().LoadDimension = false
	end
	if string.find(v21, "oading..") then
		getgenv().LoadDimension = true
	end
	if string.find(v21, "been spotted approaching") then
		_G.pirateraid(1)
	end
	if string.find(v21, "Good job") then
		_G.pirateraid()
	end
	if string.find(v21, "store one") then
		getgenv().StoreSecs = os.time()
	end
    
end) 



local old; 
old = hookfunction(require(game.ReplicatedStorage.Notification).new, function(a, b)
	v21 = tostring(tostring(a or "") .. tostring(b or "")) or ""
	workspace.LastNotification.Value = v21
	return old(a, b)
end) 


print("Enemy Spawns Region Loaded")

function mysplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end
      
function CheckBoneRollable()
	if not remilia.Data["Player Inventory"].Bones or remilia.Data["Player Inventory"].Bones.Count < 50 then
		return
	end
	if bonescd then
		if os.time() - bonescd[1] > bonescd[2] then
			bonescd = nil
		else
			return
		end
	end
	local v316, v317, v318, v319 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Bones", "Check")
	if v318 == 0 or v318 == "0" then
    --print("On Countdown For Now", v316, v317, v318, v319)
		v37 = mysplit(v319, ":")
		bonescd = {
			os.time(),
			((tonumber(v37[1]) * 60) + tonumber(v37[2])) * 60
		}
	else
		FireRemotes(1, "Bones", "Buy", 1, 1)
	end
end
v31 = false; 
remilia.Data["Current Raid Type"] = {}
gay19999 = (function()
	while task.wait(3) do
		local v35, v36 = pcall(function()
			repeat
				wait()
			until LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild"Humanoid" and LocalPlayer.Character.Humanoid.Health > 0
			ServerCheck()
			CheckBoneRollable()
			AddPoint()
			for _, v in {
				unpack(LocalPlayer.Character:GetChildren()),
				unpack(LocalPlayer.Backpack:GetChildren())
			} do
				RefreshInventory(v)
				if v:IsA("Tool") and string.find(tostring(v), "Fruit") and ( v.ToolTip == "" or not v.ToolTip) then
					FireRemotes(1, "StoreFruit", tostring(v:GetAttribute("OriginalName") or remilia.Data["Fruit Name To Id"][tostring(v)]), v)
				end
			end
			for _, v in {
				unpack(require(game:GetService("ReplicatedStorage").Raids).advancedRaids),
				unpack(require(game:GetService("ReplicatedStorage").Raids).raids)
			} do
				if string.find(remilia.Data['Player Data'].DevilFruit, v) then
					remilia.Data["Current Raid Type"] = {
						v,
						(v ~= "Dough-Dough" or remilia.Data["Player Inventory"]["Mirror Fractal"])
					}
				end
			end
			getgenv().Task1 = nil
			getgenv().remilia.Cache["Spawned Boss"] = {}
			table.foreach(workspace.Enemies:GetChildren(), Bosses)
			table.foreach(game.ReplicatedStorage:GetChildren(), Bosses)
			getgenv().remilia.Data["Spawned Boss"] = remilia.Cache["Spawned Boss"]
			if not v31 or os.time() - v31 > 36000 then
				FireRemotes(1, "Cousin", "Buy")
				v31 = os.time()
			end
			v32 = {}
			for _, v in FireRemotes(1, "getInventory") do
				v32[v.Name] = v
			end
			getgenv().remilia["Data"]["Player Inventory"] = v32
			if remilia.Data.Sea == 3 and remilia["Data"]["Elite Count"] >= 30 and not remilia.Data["Player Inventory"].Yama and not GetBackpack("Yama") then
				repeat
					wait()
					getgenv().Task1 = "Pulling Yama"
					fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector)
				until GetBackpack("Yama")
			end
			v34 = {}
			for i, v in workspace:GetChildren() do
				if string.find(v.Name, "Fruit") and pcall(function()
					return v:FindFirstChild("Handle")
				end) and not table.find(v34, v) then
					table.insert(v34, v)
				end
			end
			CurrentMelee = GetBackpack("Melee")
			if CurrentMelee then
				if CurrentMelee:FindFirstChild("Level") and GetBackpack(CurrentMelee.Name) and GetBackpack(CurrentMelee.Name):FindFirstChild("Level") then
					getgenv().remilia["Data"]["Melees"][tostring(CurrentMelee)] = GetBackpack(CurrentMelee.Name).Level.Value
				end
			end
			getgenv().remilia.Data["Fruit Spawn"] = v34
			getgenv().remilia.Cache.ZQuestProgress1 = FireRemotes(1, "ZQuestProgress", "Check")
			getgenv().remilia.Data["Script Env"] = getsenv(game.ReplicatedStorage.GuideModule)
			getgenv().remilia.Data["Exp Boost Expired"] = ( getgenv().remilia.Data["Script Env"]["_G"]["ServerData"]["ExpBoost"] == 0)
		end)
		if not v35 then
			serrlog(" Data.lua / " .. tostring(v36))
			print("recall", v36)
			return gay19999()
		end
	end
end)  
spawn(gay19999)
print("done")
getgenv().remilia.Data["Unlockables"] = FireRemotes(1, "GetUnlockables")
function RefreshRace()
	local v27, v28 = FireRemotes(1, "Alchemist", "1"), FireRemotes(1, "Wenlocktoad", "1")
	getgenv().remilia.Data["Player Data"]["Race Level"] = 1
	if LocalPlayer.Character:FindFirstChild("RaceTransformed") then
		getgenv().remilia.Data["Player Data"]["Race Level"] = 4
	elseif v28 == - 2 then
		getgenv().remilia.Data["Player Data"]["Race Level"] = 3
	elseif v27 == - 2 then
		getgenv().remilia.Data["Player Data"]["Race Level"] = 2
	end 

end 
RefreshRace()

print("Current Race Level: " .. tostring(getgenv().remilia.Data["Player Data"]["Race Level"])) 

pcall(function()
	print("Current Quest: " .. tostring(GetQuest().QuestId or "nil"))
  
end)

workspace.Enemies.ChildAdded:Connect(function(c)
	if c:FindFirstChild("Humanoid") and c:FindFirstChild("HumanoidRootPart") then
		v38 = c.HumanoidRootPart.ChildAdded:Connect(function(ch)
			if c:FindFirstChild("HumanoidRootPart") then
				if ({
					MeleeSwing = 1,
					SwordSwing = 1,
					BodyVelocity = 1,
					TouchInterest = 1
				})[tostring(ch)] then
					return
				end
				if CaculateDistance(c.HumanoidRootPart.CFrame) < 60 then
					getgenv().remilia.Cache.DashSkillTick = os.time()
				end
			end
		end)
		v39 = c.HumanoidRootPart.ChildRemoved:Connect(function(ch)
			if c:FindFirstChild("HumanoidRootPart") then
				if ({
					MeleeSwing = 1,
					SwordSwing = 1,
					BodyVelocity = 1,
					TouchInterest = 1
				})[tostring(ch)] then
					return
				end
				if CaculateDistance(c.HumanoidRootPart.CFrame) < 60 then
					getgenv().remilia.Cache.DashSkillTick = 0
				end
			end
		end)
		c.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			if c.Humanoid.Health <= 0 then
				pcall(v38.Disconnect)
				pcall(v39.Disconnect)
			end
		end)
	end 
end)


getgenv().remilia.Cache.PreviousHero = (FireRemotes(1, "BuyElectricClaw", true) == 4) 
getgenv().remilia.Data["IsDone"] = true
getgenv().remilia.Cache.Tushita = FireRemotes(1, "TushitaProgress").OpenedDoor
repeat
	wait()
until getgenv().remilia and getgenv().remilia.Data 
print("OK Module: Checks")
print(getgenv().remilia.Data.Sea)

function start()
	while task.wait() do
		if getgenv().remilia.Data.FullyLoaded then
			local Level = getgenv().remilia.Data["Player Data"].Level
			if CheckHolyTorchProcess() then
				getgenv().Task1 = "Holy Torch"
			elseif MeleeResCheck() then
				getgenv().Task1 = "nich ga"
			elseif CheckCdkProcess() then
				getgenv().Task1 = "Cursed Dual Katana"
			elseif CheckDoughKingRequirements() then
				getgenv().Task1 = "Dough King / 2"
			elseif getgenv().remilia.Cache.PirateRaidStamp and os.time() - getgenv().remilia.Cache.PirateRaidStamp < 180 then
				getgenv().Task1 = "Pirate Raid"
			elseif CheckRaidRequirements() then
				getgenv().Task1 = "Raid"
			elseif CheckZouRequirements() then
				getgenv().Task1 = "Zou"
			elseif CheckSoulGuitarProcess() then
				getgenv().Task1 = "Soul Guitar"
			elseif # getgenv().remilia.Data["Fruit Spawn"] > 0 then
				getgenv().Task1 = "Collect Fruit"
			elseif CheckIsSpecializeBossSpawned() then
				getgenv().Task1 = "Defeating Specialize Boss"
			elseif getgenv().remilia.Data.Sea == 1 then
				if Level > 60 and GetHunterQuest() then
					getgenv().Task1 = "Player Hunter"
				elseif Level > 200 and GetSaberQuestProcess() then
					getgenv().Task1 = "Saber"
					GetSaberQuestProcess()
				elseif Level > 700 and GetDressrosaProcess() then
					getgenv().Task1 = "Dressrosa"
				elseif Level < 300 then
					getgenv().Task1 = "Skip Farm"
				else
					getgenv().Task1 = "Level Farm"
				end
			elseif getgenv().remilia.Data.Sea == 2 then
				if Level > 850 and GetBartiloQuestProcess() then
					getgenv().Task1 = "Bartilo Quest"
				elseif CheckRaceV2Upgradeable() then
					getgenv().Task1 = "Alchemist"
				elseif CheckRaceV3Upgradeable() then
					getgenv().Task1 = "Wenlocktoad"
				elseif GetSwanRequirements() then
					getgenv().Task1 = "Swan"
				else
					getgenv().Task1 = "Level Farm"
				end
			elseif getgenv().remilia.Data.Sea == 3 then
				if not CheckCocoaRequirements() then
					getgenv().Task1 = "Dough King / 1"
				elseif CheckHornedMan() then
					getgenv().Task1 = "Horned Man"
				else
					getgenv().Task1 = "Level Farm"
				end
			end
		end
	end
end

function gayseg()
	spawn(function()
		local v1, v2 = pcall(start)
		if not v1 then
			serrlog("EventsCheck.lua / " .. tostring(v2))
			return gayseg()
		end
	end) 
end 

gayseg()
local sitinklib = loadstring(game:HttpGet("https://github.com/ErutTheTeru/uilibrary/blob/main/Sitink%20Lib/Source.lua?raw=true"))()

if not isfile(tostring(LocalPlayer)) then
	writefile(tostring(LocalPlayer), "0") 
end 

cachedtime = tonumber(readfile(tostring(LocalPlayer)))
starttime = os.time()

function shizuku()
	v1 = os.time() - starttime
	v2 = v1 + cachedtime
	writefile(tostring(LocalPlayer), tostring(v2))
	print(v1, v2)
	return v2
end 
repeat
	wait()
	if _G.loadstringMode then
		Subscription = {
			discord_avatar = "https://pic.re/image",
			subscription_type = "chich",
			discord_username = "tao bi gay",
			time_expired = 1
		}
		break
	end
	pcall(function()
		Subscription = game:GetService("HttpService"):JSONDecode(game:HttpGet("http://localhost:8888/subscription/get"))
	end) 
until type(Subscription) == "table" 


writefile("avatar.png", game:HttpGet(Subscription.discord_avatar)) 
writefile("remilia.png", game:HttpGet("https://www.waifu.com.mx/wp-content/uploads/2023/05/Remilia-Scarlet-Cover.jpg"))

Subscription.discord_avatar = getcustomasset("avatar.png"); 
function disp_time(time, cc)
	time = tonumber(time)
	if not time then
		return "[err]"
	end
	local days = math.floor(time / 86400)
	local hours = math.floor(math.fmod(time, 86400) / 3600)
	local minutes = math.floor(math.fmod(time, 3600) / 60)
	local seconds = math.floor(math.fmod(time, 60))
	if cc then
		return (days .. "day, " .. hours .. "hrs, " .. minutes .. "min, " .. seconds .. "sec.")
	end
	return (days .. "day, " .. hours .. "hrs.")
end 
     
     

print("Subscription Fetched", Subscription.username)
local Notify = sitinklib:Notify({

	["Title"] = "Remilia",
	["Description"] = "",
	["Color"] = Color3.fromRGB(127.00000002980232, 146.00000649690628, 242.00000077486038),
	["Content"] = "Interface Initalized",
	["Time"] = 1,
	["Delay"] = 10
})

getgenv().alert = function(title, desc)
	sitinklib:Notify({
		["Title"] = "Remilia",
		["Description"] = title or "",
		["Color"] = Color3.fromRGB(127.00000002980232, 146.00000649690628, 242.00000077486038),
		["Content"] = desc or "",
		["Time"] = 1,
		["Delay"] = 10
	})
end
local sitinkgui = sitinklib:Start({
	["Name"] = "bi xam 1234",
	["Description"] = "- cac cac cac cac cac cac ?????",
	["Info Color"] = Color3.fromRGB(5.000000176951289, 59.00000028312206, 113.00000086426735),
	["Logo Info"] = getcustomasset("remilia.png"),
	["Logo Player"] = Subscription.discord_avatar,
	["Name Info"] = "[ User Info ]",
	["Name Player"] = Subscription.discord_username,
	["Info Description"] = "Type: " .. tostring(Subscription.subscription_type) .. ", Time Left: " .. disp_time(Subscription.time_expired - os.time()),
	["Tab Width"] = 135,
	["Color"] = Color3.fromRGB(127.00000002980232, 146.00000649690628, 242.00000077486038),
	["CloseCallBack"] = function()
	end
})
local MainTab = sitinkgui:MakeTab("Co Moi 1 Tab A")
local Section = MainTab:Section({
	["Title"] = "Script Configuration",
	["Content"] = "Watch / Config What Script Will Do"
})

local Seperator = Section:Seperator("Local Player")
local ScriptTask = Section:Paragraph({
	["Title"] = "Script Tasks",
	["Content"] = "Loading..."
})
local Elapsed = Section:Paragraph({
	["Title"] = "Elapsed Time",
	["Content"] = "Loading..."
})
local Melees = Section:Paragraph({
	["Title"] = "Melees",
	["Content"] = "Loading..."
})
local Valuements = Section:Paragraph({
	["Title"] = "Valuements",
	["Content"] = "Loading..."
})
local Mythici = Section:Paragraph({
	["Title"] = "Mythical Items",
	["Content"] = "Loading..."
})

Status = {
	"n/a",
	"n/a"
}
_G.cucucubububu = function(s, i)
	Status[s] = i
	ScriptTask:Set({
		Content = Status[1] .. " / " .. Status[2],
		Title = "Script Status"
	})
end 
spawn(function()
	while wait(3) do
		spawn(function()
			rua1234 = ""
			for i, c in remilia.Data.Melees do
				rua1234 = rua1234 .. " " .. tostring(i) .. " ( " .. tostring(c) .. " )"
			end
			Melees:Set({
				Title = "Melees",
				Content = rua1234
			})
			rua11223 = ""
			for i, v in remilia.Data["Player Data"] do
				if ({
					Level = true,
					Beli = true,
					Fragments = true,
					DevilFruit = true
				})[i] then
					rua11223 = rua11223 .. tostring(i) .. " : " .. tostring(v) .. " "
				end
			end
			Valuements:Set({
				Title = "Valuements",
				Content = rua11223
			})
			ruacho = ""
			for _, v in remilia.Data["Player Inventory"] do
				if v.Rarity and v.Rarity == 4 then
					ruacho = ruacho .. " - " .. tostring(v.Name) .. " "
				end
			end
			Mythici:Set({
				Title = "Mythical Items",
				Content = ruacho
			})
			Elapsed:Set({
				Title = "Elapsed Time",
				Content = (disp_time(shizuku(), 1))
			})
		end)
	end 
    
end) 

local Paragraph1 = Section:Paragraph({
	["Title"] = "⚠️ Warning",
	["Content"] = "Changing Some Fields On This Will Also Effectively On Another Accounts"
})

local Button = Section:Button({
	["Title"] = "Hop Server",
	["Content"] = "Hopping Served (Usually Using If Script Got Paused / Idle) ",
	["Callback"] = function()
		HopServer("Requested By User", 3, 1)
	end
})
Section:Toggle({

	["Title"] = "Disable 3d Rendering",

	["Content"] = "Stop rendering game elements for better efficiency",
	["Default"] = true,
	["Callback"] = function(v)
		pcall(function()
			game:GetService("RunService"):Set3dRenderingEnabled(v)
		end)
	end
}) 
Section:Toggle({

	["Title"] = "Pause Script",

	["Content"] = "Pausing All Of The Process That Script Is Processing",
	["Default"] = false,
	["Callback"] = function(v)
		pcall(function()
			getgenv().StopTask = v
		end)
	end
}) 
Section:Toggle({

	["Title"] = "Auto Chests",

	["Content"] = "Automatically Collecting Chests",
	["Default"] = false,
	["Callback"] = function(v) 
		getgenv().AutoChests = v
	end
}) 


Section:Dropdown({
	["Title"] = "Tween To NPCs",
	["Multi"] = false,
	["Options"] = (function()
		v3 = {
			"none"
		}
		table.foreach(remilia.Data.NPCs, function(v)
			table.insert(v3, v)
		end)
		return v3
	end)(),
	["Default"] = {
		"none"
	},
	["Place Holder Text"] = "Select Npc To Tween",
	["Callback"] = function(Value)
		Value = Value[1]
		if Value == "none" then
			return
		end
		alert('Interaction', 'Attempt to tween to: ' .. tostring(Value))
		TweenTo(remilia.Data.NPCs[Value])
	end
}) 
Section:Dropdown({
	["Title"] = "Tween To Safezones",
	["Multi"] = false,
	["Options"] = (function()
		v3 = {
			"none"
		}
		table.foreach(remilia.Data.Safezones, function(v, v2)
			table.insert(v3, tostring(v))
		end)
		return v3
	end)(),
	["Default"] = {
		"none"
	},
	["Place Holder Text"] = "Select Safezone To Tween",
	["Callback"] = function(Value)
		Value = Value[1]
		if Value == "none" then
			return
		end
		TweenTo(remilia.Data.Safezones[Value][1])
	end
}) 
Section:Dropdown({
	["Title"] = "Teleport Sea",
	["Multi"] = false,
	["Options"] = {
		"none",
		"1",
		"2",
		"3"
	},
	["Default"] = {
		"none"
	},
	["Place Holder Text"] = "Select Sea To Teleport",
	["Callback"] = function(Value)
		Value = Value[1]
		if Value == "none" then
			return
		end
		if remilia.Data.Sea == tonumber(Value) then
			return
		end
		HopServer("Sea Teleport", 5, tonumber(Value))
	end
}) 
Section:Dropdown({
	["Title"] = "Buy Melee",
	["Multi"] = false,
	["Options"] = {
		"none",
		"BlackLeg",
		"Electro",
		"FishmanKarate",
		"DragonClaw",
		"Superhuman",
		"DeathStep",
		"ElectricClaw",
		"SharkmanKarate",
		"DragonTalon",
		"Godhuman"
	},
	["Default"] = {
		"none"
	},
	["Place Holder Text"] = "Select Melee To Buy",
	["Callback"] = function(Value)
		Value = Value[1]
		if Value == "none" then
			return
		end
		FireRemotes(1, "Buy" .. tostring(Value))
	end
}) 
Section:TextInput({
	["Title"] = "Teleport To Job Id",
	["Content"] = "Teleport To The Spefix Server By Job Id",
	["Place Holder Text"] = "Enter Job Id Here...",
	["Clear Text On Focus"] = true,
	["Callback"] = function(Value)
		print(Value, Value[1])
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Value, game.Players.LocalPlayer)
	end
})


local TextInput = Section:TextInput({
	["Title"] = "Text Input",
	["Content"] = "",
	["Place Holder Text"] = "Enter you text here...",
	["Clear Text On Focus"] = true,
	["Callback"] = function(Value)
		print(Value)
	end
})
local TextInput1 = Section:TextInput({
	["Title"] = "Text Input",
	["Content"] = "This is a Text Input",
	["Place Holder Text"] = "Enter you text here...",
	["Clear Text On Focus"] = true,
	["Callback"] = function(Value)
		print(Value)
	end
})

local Toggle1 = Section:Toggle({
	["Title"] = "Toggle",
	["Content"] = "This is a Toggle",
	["Default"] = false,
	["Callback"] = function(Value) 
		print(Value)
	end
})
local Slider = Section:Slider({
	["Title"] = "Slider",
	["Content"] = "",
	["Min"] = 0,
	["Max"] = 100,
	["Increment"] = 1,
	["Default"] = 30,
	["Callback"] = function(Value)
		print(Value)
	end
})

local Slider1 = Section:Slider({
	["Title"] = "Slider",
	["Content"] = "This is a Slider",
	["Min"] = 0,
	["Max"] = 100,
	["Increment"] = 1,
	["Default"] = 30,
	["Callback"] = function(Value)
		print(Value)
	end
})
local Dropdown = Section:Dropdown({
	["Title"] = "Dropdown",
	["Multi"] = true,
	["Options"] = {
		"Option 1",
		"Option 2"
	},
	["Default"] = {
		"Option 1"
	},
	["Place Holder Text"] = "Select Options",
	["Callback"] = function(Value)
		print(Value)
	end
})

    


wait(1)
local old = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
local com = getupvalue(old, 2)
require(game.ReplicatedStorage.Util.CameraShaker):Stop()

getgenv().Click = function()
	_G.a1 = os.time() 
end 

spawn(
    function()
	while task.wait() do
		if _G.a1 then
			if os.time() - _G.a1 ~= 0 then
			else
				pcall(
                    function()
					com.activeController.hitboxMagnitude = 600
					if true then
						com.activeController.hitboxMagnitude = 6000
						com.activeController.active = false
						com.activeController.blocking = false
						com.activeController.focusStart = 0
						com.activeController.hitSound = nil
						com.activeController.increment = 0
						com.activeController.timeToNextAttack = 0
						com.activeController.timeToNextBlock = 0
						com.activeController:attack()
					end
					Attack()
				end)
			end
		end
	end
end)

local ply = game.Players.LocalPlayer

local Combatfram1 = debug.getupvalues(require(ply.PlayerScripts.CombatFramework))
local Combatfram2 = Combatfram1[2]

function GetCurrentBlade()
	local p13 = Combatfram2.activeController
	local ret = p13.blades[1]
	if not ret then
		return
	end
	while ret.Parent ~= game.Players.LocalPlayer.Character do
		ret = ret.Parent
	end
	return ret
end

function blademon(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Enemies = game:GetService("Workspace").Enemies:GetChildren()
	for i = 1, # Enemies do
		local v = Enemies[i]
		local Human = v:FindFirstChildOfClass("Humanoid")
		if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes + 5 then
			table.insert(Hits, Human.RootPart)
		end
	end
	return Hits
end

function Attack()
	pcall(
        function()
		local a = game.Players.LocalPlayer
		local b = getupvalues(require(a.PlayerScripts.CombatFramework))[2]
		function GetCurrentBlade()
			local c = b.activeController
			local d = c.blades[1]
			if not d then
				return
			end
			while d.Parent ~= game.Players.LocalPlayer.Character do
				d = d.Parent
			end
			return d
		end
		local e = b.activeController
		for f = 1, 1 do
			local g = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
                    a.Character, {
				a.Character.HumanoidRootPart
			}, 60)
			local h = {}
			local i = {}
			for j, k in pairs(g) do
				if k.Parent:FindFirstChild("HumanoidRootPart") and not i[k.Parent] then
					table.insert(h, k.Parent.HumanoidRootPart)
					i[k.Parent] = true
				end
			end
			g = h
			if # g > 0 then
				local l = debug.getupvalue(e.attack, 5)
				local m = debug.getupvalue(e.attack, 6)
				local n = debug.getupvalue(e.attack, 4)
				local o = debug.getupvalue(e.attack, 7)
				local p = (l * 798405 + n * 727595) % m
				local q = n * 798405
				(function()
					p = (p * m + q) % 1099511627776
					l = math.floor(p / m)
					n = p - l * m
				end)()
				o = o + 1
				debug.setupvalue(e.attack, 5, l)
				debug.setupvalue(e.attack, 6, m)
				debug.setupvalue(e.attack, 4, n)
				debug.setupvalue(e.attack, 7, o)
				pcall(
                        function()
					if a.Character:FindFirstChildOfClass("Tool") and e.blades and e.blades[1] then
						e.animator.anims.basic[1]:Play(0.1, 0.1, 0.1)
						game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange", tostring(GetCurrentBlade()))
						game.ReplicatedStorage.Remotes.Validator:FireServer(
                                    math.floor(p / 1099511627776 * 16777215), o)
						game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", g, f, "")
					end
				end)
			end
		end
		b.activeController.timeToNextAttack = - math.huge
		b.activeController.attacking = false
		b.activeController.timeToNextBlock = 0
		b.activeController.humanoid.AutoRotate = 80
		b.activeController.increment = 4
		b.activeController.blocking = false
		b.activeController.hitboxMagnitude = 600
	end)
end
local HopGui = Instance.new("ScreenGui");
local HopFrame = Instance.new("Frame");
local NameHub = Instance.new("TextLabel");
local UIStroke = Instance.new("UIStroke");
local HopIn = Instance.new("TextLabel");
local DropShadowHolder = Instance.new("Frame");
local DropShadow = Instance.new("ImageLabel");
local Reason = Instance.new("TextLabel");
local ClickTo = Instance.new("TextLabel");
local ButtonCall = Instance.new("TextButton");

HopGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HopGui.Name = "HopGui"
HopGui.Parent = game:GetService("CoreGui")
HopGui.Enabled = false 

HopFrame.AnchorPoint = Vector2.new(0.5, 0.5)
HopFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
HopFrame.BackgroundTransparency = 0.9990000128746033
HopFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
HopFrame.BorderSizePixel = 0
HopFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
HopFrame.Size = UDim2.new(1, 0, 1, 0)
HopFrame.Name = "HopFrame"
HopFrame.Parent = HopGui

NameHub.Font = Enum.Font.Gotham
NameHub.Text = "Remilia"
NameHub.TextColor3 = Color3.fromRGB(175.00000476837158, 187.00000405311584, 230.00000149011612)
NameHub.TextSize = 85
NameHub.AnchorPoint = Vector2.new(0.5, 0.5)
NameHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NameHub.BackgroundTransparency = 0.9990000128746033
NameHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
NameHub.BorderSizePixel = 0
NameHub.Position = UDim2.new(0.5, 0, 0.5, - 45)
NameHub.Size = UDim2.new(0, 200, 0, 80)
NameHub.Name = "NameHub"
NameHub.Parent = HopFrame

UIStroke.Color = Color3.fromRGB(175.00000476837158, 187.00000405311584, 230.00000149011612)
UIStroke.Thickness = 1.5
UIStroke.Parent = NameHub

HopIn.Font = Enum.Font.Gotham
HopIn.Text = "hold on a sec"
HopIn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopIn.TextSize = 20
HopIn.AnchorPoint = Vector2.new(0.5, 0.5)
HopIn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HopIn.BackgroundTransparency = 0.9990000128746033
HopIn.BorderColor3 = Color3.fromRGB(0, 0, 0)
HopIn.BorderSizePixel = 0
HopIn.Position = UDim2.new(0.5, 0, 0.5, 0)
HopIn.Size = UDim2.new(0, 200, 0, 30)
HopIn.Name = "HopIn"
HopIn.Parent = HopFrame

DropShadowHolder.BackgroundTransparency = 1
DropShadowHolder.BorderSizePixel = 0
DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
DropShadowHolder.ZIndex = 0
DropShadowHolder.Name = "DropShadowHolder"
DropShadowHolder.Parent = HopFrame

DropShadow.Image = "rbxassetid://6015897843"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageTransparency = 0.999
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
DropShadow.BackgroundTransparency = 1
DropShadow.BorderSizePixel = 0
DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
DropShadow.Size = UDim2.new(1, 47, 1, 47)
DropShadow.ZIndex = 0
DropShadow.Name = "DropShadow"
DropShadow.Parent = DropShadowHolder

Reason.Font = Enum.Font.Gotham
Reason.Text = ""
Reason.TextColor3 = Color3.fromRGB(255, 255, 255)
Reason.TextSize = 16
Reason.AnchorPoint = Vector2.new(0.5, 0.5)
Reason.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Reason.BackgroundTransparency = 0.9990000128746033
Reason.BorderColor3 = Color3.fromRGB(0, 0, 0)
Reason.BorderSizePixel = 0
Reason.Position = UDim2.new(0.5, 0, 0.5, 32)
Reason.Size = UDim2.new(0, 200, 0, 16)
Reason.Name = "Reason"
Reason.Parent = HopFrame

ClickTo.Font = Enum.Font.Gotham
ClickTo.Text = "Click to this frame to abort the process"
ClickTo.TextColor3 = Color3.fromRGB(255, 255, 255)
ClickTo.TextSize = 16
ClickTo.TextTransparency = 0.5
ClickTo.AnchorPoint = Vector2.new(0.5, 0.5)
ClickTo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClickTo.BackgroundTransparency = 0.9990000128746033
ClickTo.BorderColor3 = Color3.fromRGB(0, 0, 0)
ClickTo.BorderSizePixel = 0
ClickTo.Position = UDim2.new(0.5, 0, 0.5, 50)
ClickTo.Size = UDim2.new(1, 0, 1, 0)
ClickTo.Name = "ClickTo"
ClickTo.Parent = HopFrame

ButtonCall.Font = Enum.Font.SourceSans
ButtonCall.Text = ""
ButtonCall.TextColor3 = Color3.fromRGB(0, 0, 0)
ButtonCall.TextSize = 14
ButtonCall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ButtonCall.BackgroundTransparency = 0.9990000128746033
ButtonCall.BorderColor3 = Color3.fromRGB(0, 0, 0)
ButtonCall.BorderSizePixel = 0
ButtonCall.Size = UDim2.new(1, 0, 1, 0)
ButtonCall.Name = "ButtonCall"
ButtonCall.Parent = HopFrame

local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = game.Lighting
Blur.Enabled = true

function fadein()
	for i = 0, 50, 5 do
		Blur.Size = i
		wait()
	end 
end 
function fadeout()
	for i = 50, 0, - 5 do
		Blur.Size = i
		wait()
	end 
end 


getgenv().HopServer = function(reasonreal, time, lockabort, teleportsea)
	getgenv().lockabort = lockabort
	if not reasonreal then
		reasonreal = ''
	end
	if reasonreal == '' then
		HopGui.Enabled = false
		fadeout()
		return
	end
	if not time then
		time = 3
	end
	HopGui.Enabled = true
	fadein()
	Reason.Text = "Reason: " .. reasonreal
	txt1 = "Hopping"
	if teleportsea then
		txt1 = "Wraping"
	end
	local t0 = time * 10
	while task.wait(0.1) do
		HopIn.Text = "Delay " .. txt1 .. ": " .. t0 / 10
		t0 = t0 - 1
		if math.floor(t0) == 0 then
			break
		end
		if getgenv().CancelHop then
			getgenv().CancelHop = false
			return
		end
	end
	wait(.4)
	local tb1 = {
		"Main",
		"Dressrosa",
		"Zou"
	}
	if tb1[teleportsea] then
		ClickTo.Text = "wrapping..."
		FireRemotes(1, "Travel" .. tb1[teleportsea])
		wait()
		return
	end
	ClickTo.Text = "finding a new server..."
	for i = 1, 100, 1 do
		if getgenv().CancelHop then
			getgenv().CancelHop = false
			ClickTo.Text = "Process cancelled."
			wait(1)
			return
		end
		_G.Hopping = true
		for a, b in game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(i) do
			if a ~= game.JobId and b.Count < 9 then
				print(a, b.Count)
				wait(1)
				pcall(function()
					clearteleportqueue()
				end)
				HopIn.Text = "Joining Server: " .. a .. " Player Count: " .. b.Count .. "/12"
				game:GetService("TeleportService"):SetTeleportGui(HopGui)
				ClickTo.Text = "Processing..."
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, a, game.Players.LocalPlayer)
				wait(10)
			end
		end
	end
	game:GetService("TeleportService"):Teleport(game.PlaceId)
    
    
end
---- Events 
ButtonCall.Activated:Connect(function()
	if lockabort then
		ClickTo.Text = "Aborting Locked!"
		wait(.6)
		ClickTo.Text = "Click to this frame to abort the process"
		return
	end
	getgenv().CancelHop = true
	getgenv().HopServer()
end)     


    
Config = {
	["Main"] = {
		["Team"] = "Pirates" -- Pirates/Marines/Auto
	},
	["Process"] = {
		["Force Staying In Second Sea Until Have Race V3"] = true,
	},
	["Demon Fruit"] = {
		["Sniping Fruit"] = {
			'Dough'
		}, --Fruit to snipe when it on stock
		["Only Eat Awakenable Fruit"] = true,
		["Allow To Purchase Fruit Although Current Fruit Is Awakened"] = true, --Allow To Purchase/Eat Fruit Listed In Top Although Current Fruit Is Awakened
	},
	["Connection"] = {
		["Allow To Execute Script Through Third Party Program"] = true,
		["Network Sharing"] = true, --Will Share Your Data To Script Network, It Mean That When You Server Have Speficalize Boss That Another Account Wants, Current Account Will Sharing With It.
	},
	["Farming"] = {
		["Type Of Farming When Done All Tasks"] = "Auto Bounty", -- Auto Bounty / Nearby Farm / Close Instance
		["Custom Autobounty Script"] = {
			false,
			""
		}
	},
	["Utilly"] = {
		["Black Screen"] = true,
		["Auto Add Friends / Accept Requests"] = true,
		["Anti Flagging"] = true,
		["Fast Mode"] = true,
		["Avoid Same Servers"] = true
	}
}
getgenv().remilia = remilia or {
	["Cache"] = {},
	["Script Config"] = {
		["Name"] = "remilia",
	},
	["Script Tasks"] = {
		"Idling",
		"Idling"
	}
}

Players = game.Players 
LocalPlayer = Players.LocalPlayer 
Character = LocalPlayer.Character 

function Include(file)
	loadstring(game:HttpGet("http://localhost:8888/files/modules/" .. file))() 
end 


repeat
	wait()
	pcall(function()
		for i, v in pairs(getconnections(LocalPlayer.PlayerGui.Main.ChooseTeam.Container[Config.Main.Team or 'Pirates'].Frame.TextButton.Activated)) do
			v.Function()
		end
	end) 
until tostring(LocalPlayer.Team) == Config.Main.Team

if not _G.loadstringMode then
	Include("Functions.lua")
	repeat
		wait()
	until FireRemotes
	Include("Data.lua")
	repeat
		wait()
	until getgenv().remilia.Data.IsDone
	wait(4)
	if remilia.Data["Player Inventory"]["Cursed Dual Katana"] then
		if Config.Farming["Type Of Farming When Done All Tasks"] == "Auto Bounty" then
			if Config.Farming["Custom Autobounty Script"][1] then
				loadstring(Config.Farming["Custom Autobounty Script"][2])()
			else
				Include("Autobounty.lua")
			end
			return
		end
	end
	Include("EventsCheck.lua")
	Include("Ui.lua")
	Include("Click.lua")
	wait()
	Include("Hop.lua")
end

LocalPlayer.CharacterAdded:Connect(function()
	wait(1)
	FireRemotes(1, "Buso")
end)
FireRemotes(1, "Buso")






function CheckKick(v)
	if v.Name == "ErrorPrompt" then
		getgenv().StopRecv = true
		if v.Visible then
			getgenv().CancelRecv = true
			if v.TitleFrame.ErrorTitle.Text ~= "Teleport Failed" then
				if _G.Hopping then
					return
				end
				game:GetService("TeleportService"):TeleportToPlaceInstance(
                    game.PlaceId, game.JobId, game.Players.LocalPlayer)
			end
		end
		v:GetPropertyChangedSignal("Visible"):Connect(
            function()
			if v.Visible then
				v.Visible = false
				if _G.Hopping then
					return
				end
				if v.TitleFrame.ErrorTitle.Text ~= "Teleport Failed" then
					game:GetService("TeleportService"):TeleportToPlaceInstance(
                            game.PlaceId, game.JobId, game.Players.LocalPlayer)
				end
			end
		end)
	end
end
wait(1)
game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(CheckKick)

function factorial(n)
	if n == 0 then
		return 1
	else
		return n * factorial(n - 1)
	end

end


function BezierCurve(controlPoints, t)
	local n = # controlPoints - 1
	local point = Vector3.new()
	for i = 0, n do
		local coeff = (factorial(n) / (factorial(i) * factorial(n - i))) * t ^ i * (1 - t) ^ (n - i)
		point = point + controlPoints[i + 1] * Vector3.new(coeff, coeff, coeff)
	end
	return point
end

function GetBezierTablePositions(controlPointsTable, numPoints)
	local positions = {}
	local tIncrement = 1 / (numPoints - 1)
	for i = 1, numPoints do
		local t = (i - 1) * tIncrement
		table.insert(positions, BezierCurve(controlPointsTable, t))
	end
	return positions
end
 
for i, v in getgenv().remilia.Data["Enemy Spawns"] do
	spawn(function()
		v3 = {}
		for i2, v2 in v do
			table.insert(v3, PositionParser("Vector3", v2))
		end
		local Bezier = GetBezierTablePositions(v3, 100)
		if Bezier then
			Bezier2 = Bezier
			for v4 = 100, 0, - 1 do
				table.insert(Bezier2, Bezier[v4])
			end
			getgenv().remilia.Data["Enemy Spawns"][i] = Bezier2
		end
	end)
end 

getgenv().remilia.Data.FullyLoaded = true 
wait(4)

getgenv().remilia.Cache.PreviousHero = (FireRemotes(1, "BuyElectricClaw", true)) ~= 4 
if typeof(FireRemotes(1, "BuySharkmanKarate", true)) ~= "string" then
	getgenv().remilia.Data.Requirements.OpenWaterKey = true 
end 
for i, v in pairs(game.Workspace:GetChildren()) do
	if v.Name == "Script" then
		v:Destroy()
	end
end
game.Workspace.ChildAdded:Connect(function(child)
	if child.Name == "Script" then
		child:Destroy()
	end
end)
mainthread = (function()
	local v8, v9 = pcall(function()
		while game:GetService("RunService").Stepped:Wait() do
			if not getgenv().StopTask then
				MeleeTask()
        
       
        
        --if getgenv().Task1 == "Level Farm" then
				if getgenv().Task1 == "Swan" then
					DoSwanRequirements()
				elseif getgenv().Task1 == "Zou" then
					DoZouQuest()
				elseif getgenv().Task1 == "Level Farm" then
					LevelFarm()
				elseif getgenv().Task1 == "Defeating Specialize Boss" then
					SetStatus(1, "Defeating " .. tostring(CheckIsSpecializeBossSpawned()))
					v10 = CheckIsSpecializeBossSpawned()
					conchoteru(v10.Name, true)
				elseif getgenv().Task1 == "Raid" then
					Raid()
				elseif getgenv().Task1 == "Bartilo Quest" then
					DoBartiloQuest()
				elseif getgenv().Task1 == "Alchemist" then
					DoRaceV2()
				elseif getgenv().Task1 == "Wenlocktoad" then
					DoRaceV3()
				elseif getgenv().Task1 == "Saber" then
					DoSaberQuest()
				elseif getgenv().Task1 == "Dressrosa" then
					DoDressrosaQuest()
				elseif getgenv().Task1 == "Skip Farm" then
					SkipFarm()
				elseif getgenv().Task1 == "Player Hunter" then
					DoPlayerHunter()
				elseif getgenv().Task1 == "Collect Fruit" then
					NhatFruit()
				elseif getgenv().Task1 == "Dough King / 1" then
					Cocoa()
				elseif getgenv().Task1 == "Dough King / 2" then
					DoughKing()
				elseif getgenv().Task1 == "Pirate Raid" then
					PirateRaid()
				elseif getgenv().Task1 == "Holy Torch" then
					HolyTorch()
				elseif getgenv().Task1 == "Horned Man" then
					HornedMan()
				elseif getgenv().Task1 == "Cursed Dual Katana" then
					DoCdk()
				elseif Task1 == "nich ga" then
					DoMeleeRes()
				elseif Task1 == "Soul Guitar" then
					DoSoulGuitar()
				end
			end
			t0 = false
		end
	end)
	if not v8 then
		serrlog("KaitunLoader.lua / " .. tostring(v9))
		return mainthread()
	end 
end)
mainthread()