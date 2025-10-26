getgenv().safig = {
    AutoChooseTeam = true,
    Team = "Pirates"
}

local function setTeam(teamName)
    local CommF = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_")
    pcall(function()
        CommF:InvokeServer("SetTeam", teamName)
    end)
end

task.spawn(function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    repeat task.wait() until game:IsLoaded()
    if getgenv().safig.AutoChooseTeam and not player.Character then
        repeat
            task.wait(0.5)
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            if ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_") then
                setTeam(getgenv().safig.Team)
            end
        until player.Character or player.CharacterAdded:Wait()
    end
end)

-- 🌌 Crystal Hub - Chest AutoFarm (Console Only + Fist Check + Job History)
local MaxSpeed = 350
local LocalPlayer = game:GetService("Players").LocalPlayer
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

local ChestCount = 0
local MaxChests = 30
local JobHistoryFile = "jobhistory.json"

-- === Utility ===
local function getCharacter()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	char:WaitForChild("HumanoidRootPart")
	return char
end

local function hasFistOfDarkness()
	for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
		if v.Name == "Fist of Darkness" then
			return true
		end
	end
	for _, v in pairs(getCharacter():GetChildren()) do
		if v.Name == "Fist of Darkness" then
			return true
		end
	end
	return false
end

local function DistanceSort(tbl)
	local RootPart = getCharacter().HumanoidRootPart
	table.sort(tbl, function(a, b)
		return (RootPart.Position - a.Position).Magnitude < (RootPart.Position - b.Position).Magnitude
	end)
end

local function getChests()
	local Chests = {}
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and v.Name:find("Chest") and v:FindFirstChild("TouchInterest") then
			table.insert(Chests, v)
		end
	end
	DistanceSort(Chests)
	return Chests
end

local function noclip(on)
	for _, v in pairs(getCharacter():GetChildren()) do
		if v:IsA("BasePart") then
			v.CanCollide = not on
		end
	end
end

local function tpTo(pos, speed)
	local Root = getCharacter().HumanoidRootPart
	local dist = (Root.Position - pos).Magnitude
	while dist > 3 do
		local dir = (pos - Root.Position).Unit
		Root.CFrame = Root.CFrame + dir * (speed * task.wait())
		dist = (Root.Position - pos).Magnitude
	end
end

-- === Job History Handling ===
local function readJobHistory()
	local success, data = pcall(function()
		return HttpService:JSONDecode(readfile(JobHistoryFile))
	end)
	if success and type(data) == "table" then
		return data
	end
	return {}
end

local function writeJobHistory(data)
	pcall(function()
		writefile(JobHistoryFile, HttpService:JSONEncode(data))
	end)
end

local function isJobVisited(jobId)
	local history = readJobHistory()
	for _, id in ipairs(history) do
		if id == jobId then
			return true
		end
	end
	return false
end

local function addJobToHistory(jobId)
	local history = readJobHistory()
	table.insert(history, jobId)
	writeJobHistory(history)
end

-- === Hop Server ===
local function hopServer()
	print("Không còn rương, đang chuyển sang server mới...")
	task.wait(2)
	local placeId = game.PlaceId
	local servers = {}

	pcall(function()
		local data = HttpService:JSONDecode(game:HttpGet(
			"https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"
		))
		for _, s in ipairs(data.data) do
			if s.playing < s.maxPlayers and s.id ~= game.JobId and not isJobVisited(s.id) then
				table.insert(servers, s.id)
			end
		end
	end)

	if #servers > 0 then
		addJobToHistory(game.JobId)
		local target = servers[math.random(1, #servers)]
		print("Chuyển sang server:", target)
		TeleportService:TeleportToPlaceInstance(placeId, target, LocalPlayer)
	else
		print("Không tìm thấy server khác (toàn server trùng), xóa lịch sử và thử lại...")
		writeJobHistory({})
		task.wait(3)
		hopServer()
	end
end

-- === Main Loop ===
local visited = {}
print("Đang tìm rương trong map...")

while task.wait(1) do
	if hasFistOfDarkness() then
		print("Đã có Fist of Darkness — dừng nhặt rương.")
		break
	end

	local chests = getChests()

	if #chests == 0 then
		hopServer()
		break
	end

	for _, chest in ipairs(chests) do
		if hasFistOfDarkness() then
			print("Đã có Fist of Darkness — dừng nhặt rương.")
			return
		end

		if chest and chest.Parent and not visited[chest] then
			visited[chest] = true
			ChestCount += 1

			print(string.format("Đang nhặt rương [%d/%d]...", ChestCount, MaxChests))

			noclip(true)
			tpTo(chest.Position, MaxSpeed)
			noclip(false)
			task.wait(0.4)

			-- 🟢 Nhảy 1 cái sau khi nhặt xong rương
			local char = getCharacter()
			if char:FindFirstChildOfClass("Humanoid") then
				char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
			end

			if ChestCount >= MaxChests then
				print("Đã nhặt đủ 30 rương, chuyển sang server mới...")
				hopServer()
				return
			end
		end
	end
end
