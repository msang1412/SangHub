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

local MaxSpeed = 350
local LocalPlayer = game:GetService("Players").LocalPlayer
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

local ChestCount = 0
local MaxChests = 30
local JobHistoryFile = "jobhistory.json"

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

local function Startdutdit()
    local ok, btn = pcall(function()
        return workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector
    end)
    if ok and btn then
        fireclickdetector(btn)
        print("Đã kích hoạt Fist of Darkness Raid!")
    else
        print("Không tìm thấy nút RaidSummon")
    end
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

local TweenService = game:GetService("TweenService")

local HopGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SubText = Instance.new("TextLabel")
local Reason = Instance.new("TextLabel")
local CancelHint = Instance.new("TextLabel")
local ButtonCall = Instance.new("TextButton")

HopGui.Name = "RemiliaHopUI"
HopGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HopGui.IgnoreGuiInset = true
HopGui.Parent = game:GetService("CoreGui")
HopGui.Enabled = false

Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundTransparency = 1
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.Parent = HopGui

Title.Font = Enum.Font.GothamBold
Title.Text = "Sang"
Title.TextColor3 = Color3.fromRGB(200, 210, 255)
Title.TextSize = 70
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.Position = UDim2.new(0.5, 0, 0.5, -50)
Title.BackgroundTransparency = 1
Title.TextTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.TextYAlignment = Enum.TextYAlignment.Center
Title.Parent = Frame

SubText.Font = Enum.Font.Gotham
SubText.Text = "Hopping Server..."
SubText.TextColor3 = Color3.fromRGB(255, 255, 255)
SubText.TextSize = 28
SubText.AnchorPoint = Vector2.new(0.5, 0.5)
SubText.Position = UDim2.new(0.5, 0, 0.5, 10)
SubText.BackgroundTransparency = 1
SubText.TextTransparency = 1
SubText.TextXAlignment = Enum.TextXAlignment.Center
SubText.TextYAlignment = Enum.TextYAlignment.Center
SubText.Parent = Frame

Reason.Font = Enum.Font.Gotham
Reason.Text = ""
Reason.TextColor3 = Color3.fromRGB(220, 220, 220)
Reason.TextSize = 20
Reason.AnchorPoint = Vector2.new(0.5, 0.5)
Reason.Position = UDim2.new(0.5, 0, 0.5, 45)
Reason.BackgroundTransparency = 1
Reason.TextTransparency = 1
Reason.TextXAlignment = Enum.TextXAlignment.Center
Reason.TextYAlignment = Enum.TextYAlignment.Center
Reason.Parent = Frame

CancelHint.Font = Enum.Font.Gotham
CancelHint.Text = "Double click to abort the process."
CancelHint.TextColor3 = Color3.fromRGB(255, 255, 255)
CancelHint.TextTransparency = 0.5
CancelHint.TextSize = 16
CancelHint.AnchorPoint = Vector2.new(0.5, 0.5)
CancelHint.Position = UDim2.new(0.5, 0, 0.5, 75)
CancelHint.BackgroundTransparency = 1
CancelHint.TextTransparency = 1
CancelHint.TextXAlignment = Enum.TextXAlignment.Center
CancelHint.TextYAlignment = Enum.TextYAlignment.Center
CancelHint.Parent = Frame

ButtonCall.BackgroundTransparency = 1
ButtonCall.BorderSizePixel = 0
ButtonCall.Text = ""
ButtonCall.AutoButtonColor = false
ButtonCall.Size = UDim2.new(1, 0, 1, 0)
ButtonCall.Parent = Frame

local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Enabled = false
Blur.Parent = game.Lighting

local function fadeInUI()
	HopGui.Enabled = true
	Blur.Enabled = true
	TweenService:Create(Blur, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {Size = 45}):Play()

	for _, label in ipairs({Title, SubText, Reason, CancelHint}) do
		TweenService:Create(label, TweenInfo.new(1, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
	end
end

local function fadeOutUI()
	local blurTween = TweenService:Create(Blur, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {Size = 0})
	blurTween:Play()

	for _, label in ipairs({Title, SubText, Reason, CancelHint}) do
		TweenService:Create(label, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
	end

	task.wait(0.6)
	Blur.Enabled = false
	HopGui.Enabled = false
end

local lastClick = 0
local isCounting = true

ButtonCall.MouseButton1Click:Connect(function()
	local now = tick()
	if now - lastClick < 0.3 then
		isCounting = false
		fadeOutUI()
	end
	lastClick = now
end)

local function ShowHopUI(reasonText)
    Title.Text = "Sang"
    SubText.Text = "Hopping Server in 5s..."
    Reason.Text = "Reason: " .. (reasonText or "Collect Chest")
    isCounting = true
    fadeInUI()
    
    for i = 4, 0, -1 do
        if not isCounting then break end
        task.wait(1)
        if isCounting then
            SubText.Text = "Hopping Server in " .. i .. "s..."
        end
    end
    
    if isCounting then
        SubText.Text = "Hopping now..."
        task.wait(0.5)
        fadeOutUI()
        return true
    else
        return false
    end
end

local function hopServer(reason)
    print("Không còn rương, đang chuyển sang server mới...")
    
    local allowHop = ShowHopUI(reason or "No Chests Found")
    if not allowHop then
        print("Đã hủy hop server")
        return
    end
    
    task.wait(1)
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
        hopServer("Server List Refresh")
    end
end

local visited = {}
print("Đang tìm rương trong map...")

while task.wait(1) do
	if hasFistOfDarkness() then
		print("Đã có Fist of Darkness — kích hoạt raid!")
		Startdutdit()
		break
	end

	local chests = getChests()

	if #chests == 0 then
		hopServer("No Chests Found")
		break
	end

	for _, chest in ipairs(chests) do
		if hasFistOfDarkness() then
			print("Đã có Fist of Darkness — kích hoạt raid!")
			Startdutdit()
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

			local char = getCharacter()
			if char:FindFirstChildOfClass("Humanoid") then
				char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
			end

			if ChestCount >= MaxChests then
				print("Đã nhặt đủ 30 rương, chuyển sang server mới...")
				hopServer("Max Chests Reached")
				return
			end
		end
	end
end
