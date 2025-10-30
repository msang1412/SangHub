loadstring(game:HttpGet("https://raw.githubusercontent.com/msang1412/SangHub/refs/heads/main/fastattack.lua"))()
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

-- BIẾN TOÀN CỤC ĐỂ KIỂM SOÁT
local hasCoreBrain = false
local isRunningAutoCyborg = false
local stopAllActivities = false

-- THÊM PHẦN CYBORG RAID SAU KHI CHỌN TEAM
local player = game:GetService("Players").LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local function StartAutoCyborg()
    if isRunningAutoCyborg then return end
    isRunningAutoCyborg = true
    
    print("start...")
    
    -- Config
    getgenv().AutoCyborg = true
    getgenv().SelectWeapon = "Melee"
    local TweenSpeed = 350
    local HeightAboveOrder = 25
    local hakiCooldown = 5
    local lastHakiTime = 0

    -- Services
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

    -- Helper
    local function SafeWaitForChild(parent, name)
        local success, result = pcall(function() return parent:WaitForChild(name) end)
        if success then return result else return nil end
    end

    -- Equip Weapon
    local function EquipWeapon(toolName)
        if stopAllActivities then return end
        local char = player.Character or player.CharacterAdded:Wait()
        local backpack = player:WaitForChild("Backpack")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        local function FindTool()
            for _, v in pairs(backpack:GetChildren()) do
                if v:IsA("Tool") and (string.find(v.Name:lower(), toolName:lower()) or (v:GetAttribute("WeaponType") == toolName)) then
                    return v
                end
            end
            for _, v in pairs(char:GetChildren()) do
                if v:IsA("Tool") and (string.find(v.Name:lower(), toolName:lower()) or (v:GetAttribute("WeaponType") == toolName)) then
                    return v
                end
            end
        end
        local tool = FindTool()
        if tool then humanoid:EquipTool(tool) end
    end

    -- Auto Haki
    local function AutoHaki()
        if stopAllActivities then return end
        if player.Character and not player.Character:FindFirstChild("HasBuso") then
            if tick() - lastHakiTime >= hakiCooldown then
                pcall(function() CommF:InvokeServer("Buso") end)
                lastHakiTime = tick()
            end
        end
    end

    -- Smooth Stay Above Target
    local function SmoothStayAbove(targetHRP)
        if stopAllActivities then return end
        if not targetHRP then return end
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        hrp.CFrame = CFrame.new(targetHRP.Position + Vector3.new(0, HeightAboveOrder, 0))
    end

    -- Keep Player in Air
    RunService.Heartbeat:Connect(function()
        if getgenv().AutoCyborg and not stopAllActivities then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = Vector3.zero
                hrp.AssemblyLinearVelocity = Vector3.zero
            end
        end
    end)

    -- Check Order
    local function OrderExists()
        local enemies = Workspace:FindFirstChild("Enemies")
        if not enemies then return false end
        local order = enemies:FindFirstChild("Order")
        if order and order:FindFirstChild("Humanoid") and order.Humanoid.Health > 0 and order:FindFirstChild("HumanoidRootPart") then
            return true
        else
            return false
        end
    end

    local function GetOrder()
        local timer = 0
        local order
        repeat
            order = Workspace:FindFirstChild("Enemies") and Workspace.Enemies:FindFirstChild("Order")
            if order and order:FindFirstChild("HumanoidRootPart") and order:FindFirstChild("Humanoid") then
                return order
            end
            task.wait(0.1)
            timer = timer + 0.1
        until timer >= 5
        return nil
    end

    -- KIỂM TRA CORE BRAIN TRONG INVENTORY
    local function CheckCoreBrainInInventory()
        local backpack = player:WaitForChild("Backpack")
        local char = player.Character
        
        if backpack:FindFirstChild("Core Brain") then
            return true
        end
        
        if char and char:FindFirstChild("Core Brain") then
            return true
        end
        
        return false
    end

    -- Startdutdit (nhét chip) - chỉ 1 lần click
    local function Startdutdit()
        local ok, btn = pcall(function()
            return workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector
        end)
        if ok and btn then
            fireclickdetector(btn)
            print("ra core brain roi...")
            return true
        else
            return false
        end
    end

    -- Check Core Brain và NHÉT LIÊN TỤC (sửa: spam đến khi Core Brain biến mất)
    task.spawn(function()
        while getgenv().AutoCyborg and not stopAllActivities do
            if CheckCoreBrainInInventory() then
                print("co core brain , stop ")
                -- set flags để dừng các phần khác
                hasCoreBrain = true
                stopAllActivities = true
                getgenv().AutoCyborg = false
                isRunningAutoCyborg = false

                -- spam nhét Core Brain đến khi biến mất
                local tries = 0
                repeat
                    local ok, btn = pcall(function()
                        return workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector
                    end)
                    if ok and btn then
                        fireclickdetector(btn)
                        tries = tries + 1
                        print("dut dit lan " .. tries)
                    else
                        warn("ko thay nut dang thu lai")
                    end
                    task.wait(0.5)
                until not CheckCoreBrainInInventory() or not hasCoreBrain

                if not CheckCoreBrainInInventory() then
                    print("da nhet xong , stop all")
                    hasCoreBrain = false
                    stopAllActivities = true
                    getgenv().AutoCyborg = false
                    isRunningAutoCyborg = false
                    break
                else
                    -- nếu vòng lặp bị hủy do điều kiện khác thì reset flags nhẹ
                    print("spam bi dung som")
                    hasCoreBrain = CheckCoreBrainInInventory()
                    stopAllActivities = true
                    getgenv().AutoCyborg = false
                    isRunningAutoCyborg = false
                    break
                end
            else
                task.wait(1)
            end
        end
    end)

    -- Main Loop - FARM ORDER (CHỈ CHẠY KHI KHÔNG CÓ CORE BRAIN)
    task.spawn(function()
        while task.wait(0.2) do
            if not getgenv().AutoCyborg or stopAllActivities then break end
            
            if CheckCoreBrainInInventory() then
                print("ra core brain roi dang spam nhet")
                repeat
                    task.wait(0.5)
                until not CheckCoreBrainInInventory() or stopAllActivities
                if stopAllActivities then break end
            end
            
            local char = player.Character
            if not char then continue end
            
            EquipWeapon(getgenv().SelectWeapon)
            AutoHaki()

            local chip = player.Backpack:FindFirstChild("Microchip") or char:FindFirstChild("Microchip")
            local hasChip = chip ~= nil
            local order = GetOrder()
            local orderExists = order ~= nil

            if orderExists then
                print("attack order...")
                repeat
                    if stopAllActivities then break end
                    
                    if CheckCoreBrainInInventory() then
                        print("co core brain , stop attack")
                        break
                    end
                    
                    task.wait(0.15)
                    AutoHaki()
                    EquipWeapon(getgenv().SelectWeapon)
                    order = GetOrder()
                    if order and order:FindFirstChild("HumanoidRootPart") then
                        SmoothStayAbove(order.HumanoidRootPart)
                        order.HumanoidRootPart.CanCollide = false
                        order.HumanoidRootPart.Size = Vector3.new(120,120,120)
                    end
                until not OrderExists() or not getgenv().AutoCyborg or stopAllActivities
                continue
            end

            if hasChip and not OrderExists() then
                print("co chip , dang cbi dut...")
                local ok, btn = pcall(function()
                    return Workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector
                end)
                if ok and btn then
                    fireclickdetector(btn)
                end

                local order = GetOrder()
                if order then
                    repeat
                        if stopAllActivities then break end
                        
                        if CheckCoreBrainInInventory() then
                            print("co core brain , stop attack")
                            break
                        end
                        
                        task.wait(0.15)
                        AutoHaki()
                        EquipWeapon(getgenv().SelectWeapon)
                        if order and order:FindFirstChild("HumanoidRootPart") then
                            SmoothStayAbove(order.HumanoidRootPart)
                            order.HumanoidRootPart.CanCollide = false
                            order.HumanoidRootPart.Size = Vector3.new(120,120,120)
                        end
                        order = GetOrder()
                    until not OrderExists() or not getgenv().AutoCyborg or stopAllActivities
                end
                continue
            end

            if not hasChip and not OrderExists() then
                print("ko co chip, dang mua...")
                pcall(function()
                    CommF:InvokeServer("BlackbeardReward", "Microchip", "1")
                    task.wait(0.3)
                    CommF:InvokeServer("BlackbeardReward", "Microchip", "2")
                end)
                task.wait(0.5)
            end
        end
    end)
end

local function StartCyborgRaid()
    local attempts = 0
    local maxAttempts = 3
    local found = false
    local connection

    connection = PlayerGui.DescendantAdded:Connect(function(desc)  
        if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then  
            local text = desc.Text or ""  
              
            print("checking", text)  
              
            if string.find(text:lower(), "core brain") or string.find(text:lower(), "supply") then  
                print("da dut dit")  
                found = true  
                hasCoreBrain = true
                connection:Disconnect()
                
                -- CHẠY AUTO FARM CYBORG
                StartAutoCyborg()
                
            elseif string.find(text:lower(), "microchip") or string.find(text:lower(), "not found") then  
                print("chua phai bay gio")  
                found = true  
                connection:Disconnect()
                hasCoreBrain = false
            end  
        end  
          
        if desc:IsA("Frame") then  
            task.wait(0.1)  
            local textLabels = desc:GetDescendants()  
            for _, child in ipairs(textLabels) do  
                if child:IsA("TextLabel") and child.Text then  
                    local text = child.Text  
                    print("checking:", text)  
                      
                    if string.find(text:lower(), "core brain") or string.find(text:lower(), "supply") then  
                        print("da dut dit")  
                        found = true  
                        hasCoreBrain = true
                        connection:Disconnect()
                        
                        -- CHẠY AUTO FARM CYBORG
                        StartAutoCyborg()
                        return  
                    elseif string.find(text:lower(), "microchip") or string.find(text:lower(), "not found") then  
                        print("chua phai bay gio")  
                        found = true  
                        connection:Disconnect()
                        hasCoreBrain = false
                        return  
                    end  
                end  
            end  
        end  
    end)  

    local function ClickButton()  
        local ok, btn = pcall(function()  
            return workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector  
        end)  

        if ok and btn then  
            fireclickdetector(btn)  
            attempts += 1  
            print("dut dit " .. attempts .. "...")  
              
            if attempts < maxAttempts then  
                task.delay(1, ClickButton)  
            else  
                print("dut dit" .. maxAttempts .. " lan")  
            end  
        else  
            warn("ko thay lo dit")  
            if connection then
                connection:Disconnect()  
            end
        end  
    end  

    ClickButton()  

    task.delay(8, function()  
        if not found then  
            print("tried " .. maxAttempts .. " lan.")  
        end  
        if connection and connection.Connected then  
            connection:Disconnect()
        end  
    end)
end

-- Gọi hàm Cyborg Raid
StartCyborgRaid()

-- PHẦN AUTO FARM CHEST VÀ FIST OF DARKNESS
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
        print(" da nhet Fist of Darkness!")
    else
        print("ko thay lo dit")
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
SubText.Text = "Đang chuyển server..."
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
CancelHint.Text = "Double click để hủy"
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
    Title.Text = "sang hub"
    SubText.Text = "Đang chuyển server trong 5s..."
    Reason.Text = "Reason: " .. (reasonText or "Thu thập rương")
    isCounting = true
    fadeInUI()
    
    for i = 4, 0, -1 do
        if not isCounting then break end
        task.wait(1)
        if isCounting then
            SubText.Text = "Đang chuyển server trong " .. i .. "s..."
        end
    end
    
    if isCounting then
        SubText.Text = "Đang chuyển server..."
        task.wait(0.5)
        fadeOutUI()
        return true
    else
        return false
    end
end

local function hopServer(reason)
    print("ko co chest hop...")
    
    local allowHop = ShowHopUI(reason or "Không tìm thấy rương")
    if not allowHop then
        print("huy hop")
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
        print("job id:", target)
        TeleportService:TeleportToPlaceInstance(placeId, target, LocalPlayer)
    else
        print("ko tim thay sv...")
        writeJobHistory({})
        task.wait(3)
        hopServer("Làm mới danh sách server")
    end
end

local visited = {}
print("checking...")

-- VÒNG LẶP CHÍNH - CHỈ CHẠY KHI CHƯA CÓ CORE BRAIN
while task.wait(1) and not hasCoreBrain and not stopAllActivities do
    -- KIỂM TRA NẾU ĐANG CHẠY AUTO CYBORG THÌ DỪNG NHẶT CHEST
    if hasCoreBrain or isRunningAutoCyborg or stopAllActivities then
        print("da dut key k can nhat chest nx")
        break
    end

	if hasFistOfDarkness() then
		print("da co key dang nhet...")
		Startdutdit()
        
        -- SAU KHI NHÉT FIST OF DARKNESS, BẬT AUTOCYBORG
        task.wait(2) -- Chờ một chút để raid bắt đầu
        print("da nhat dc key se doi sang attack law sau it giay")
        StartAutoCyborg()
		break
	end

	local chests = getChests()

	if #chests == 0 then
		hopServer("Không tìm thấy rương")
		break
	end

	for _, chest in ipairs(chests) do
        -- KIỂM TRA LẠI TRƯỚC KHI NHẶT MỖI CHEST
        if hasCoreBrain or isRunningAutoCyborg or stopAllActivities then
            print("da dut key k can nhat chest nx")
            return
        end

		if hasFistOfDarkness() then
			print("co key cbi doi sang attack law")
			Startdutdit()
            
            -- SAU KHI NHÉT FIST OF DARKNESS, BẬT AUTOCYBORG
            task.wait(2) -- Chờ một chút để raid bắt đầu
            print("doi sang attack law")
            StartAutoCyborg()
			return
		end

		if chest and chest.Parent and not visited[chest] then
			visited[chest] = true
			ChestCount += 1

			print(string.format(" Đang nhặt rương [%d/%d]...", ChestCount, MaxChests))

			noclip(true)
			tpTo(chest.Position, MaxSpeed)
			noclip(false)
			task.wait(0.4)

			local char = getCharacter()
			if char:FindFirstChildOfClass("Humanoid") then
				char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
			end

			if ChestCount >= MaxChests then
				print("du 30 ruong hop...")
				hopServer("Limit Chest Hop[Collect Chest]")
				return
			end
		end
	end
end

-- THÔNG BÁO KHI ĐÃ CHUYỂN SANG CHẾ ĐỘ AUTO CYBORG
if hasCoreBrain or isRunningAutoCyborg then
    print("chuyen sang attack law")
end

-- THÔNG BÁO KHI DỪNG HOÀN TOÀN
if stopAllActivities then
    print("stop all- tai vi da dut key")
end
