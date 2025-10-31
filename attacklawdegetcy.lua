game:GetService("StarterGui"):SetCore(
    "SendNotification",
    {
        Title = "sang hub",
        Text = "hub se dong",
        Icon = "rbxassetid://131665827881677",
        Duration = 999999999
    }
)
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
local hasFistOfDarkness = false

-- KIỂM TRA ĐÃ NHÉT CORE BRAIN CHƯA BẰNG BLOCKPART
task.spawn(function()
    task.wait(3) -- Chờ game load xong
    
    if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("CircleIsland") then
        local block = workspace.Map.CircleIsland:FindFirstChild("BlockPart")
        if block then
            warn("m chua nhet core brain - tiep tuc farm")
        else
            warn("m da nhet core brain - stop all")
            hasCoreBrain = true
            stopAllActivities = true
            return
        end
    else
        warn("Không tìm thấy Map hoặc CircleIsland trong workspace!")
    end
end)

-- HÀM NHÉT FIST OF DARKNESS VÀ CORE BRAIN
local function Startdutdit()
    local ok, btn = pcall(function()
        return workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector
    end)
    if ok and btn then
        fireclickdetector(btn)
        return true
    else
        return false
    end
end

-- HÀM SPAM NHÉT CHO ĐẾN KHI BIẾN MẤT
local function SpamdutditUntilGone(itemType)
    print("Bat dau spam nhet " .. itemType .. "...")
    local tries = 0
    local maxTries = 20
    
    repeat
        if tries >= maxTries then 
            print("Da thu nhet " .. maxTries .. " lan nhung van chua xong")
            break 
        end
        
        local success = Startdutdit()
        if success then
            tries = tries + 1
            print("Nhet " .. itemType .. " lan " .. tries)
        else
            print("Khong the nhet " .. itemType .. ", thu lai...")
        end
        task.wait(0.5)
        
        -- Kiểm tra xem item còn không
        if itemType == "Fist of Darkness" then
            if not CheckFistOfDarkness() then
                print("Da nhet Fist of Darkness thanh cong!")
                hasFistOfDarkness = false
                break
            end
        elseif itemType == "Core Brain" then
            if not CheckCoreBrainInInventory() then
                print("Da nhet Core Brain thanh cong!")
                hasCoreBrain = true
                stopAllActivities = true
                break
            end
        end
        
    until (itemType == "Fist of Darkness" and not hasFistOfDarkness) or 
          (itemType == "Core Brain" and hasCoreBrain) or 
          stopAllActivities
end

-- KIỂM TRA FIST OF DARKNESS TRONG INVENTORY
local function CheckFistOfDarkness()
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    local char = player.Character
    
    if backpack and backpack:FindFirstChild("Fist of Darkness") then
        return true
    end
    
    if char and char:FindFirstChild("Fist of Darkness") then
        return true
    end
    
    return false
end

-- KIỂM TRA CORE BRAIN TRONG INVENTORY
local function CheckCoreBrainInInventory()
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    local char = player.Character
    
    if backpack and backpack:FindFirstChild("Core Brain") then
        return true
    end
    
    if char and char:FindFirstChild("Core Brain") then
        return true
    end
    
    return false
end

-- SỬA LẠI HÀM AUTOCYBORG
local function StartAutoCyborg()
    if isRunningAutoCyborg then 
        print("AutoCyborg da chay roi")
        return 
    end
    isRunningAutoCyborg = true
    
    print("Bat dau AutoCyborg...")
    
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

    -- KIỂM TRA REMOTE TRƯỚC KHI DÙNG
    local function GetCommF()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes and remotes:FindFirstChild("CommF_") then
            return remotes.CommF_
        end
        return nil
    end

    -- Helper function an toàn
    local function SafeWaitForChild(parent, name, timeout)
        timeout = timeout or 5
        local startTime = tick()
        while tick() - startTime < timeout do
            if stopAllActivities then return nil end
            local child = parent:FindFirstChild(name)
            if child then return child end
            task.wait(0.1)
        end
        return nil
    end

    -- Equip Weapon an toàn
    local function EquipWeapon(toolName)
        if stopAllActivities then return end
        local char = player.Character
        if not char then return end
        
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
            return nil
        end
        
        local tool = FindTool()
        if tool then 
            pcall(function()
                humanoid:EquipTool(tool)
            end)
        end
    end

    -- Auto Haki an toàn
    local function AutoHaki()
        if stopAllActivities then return end
        if not player.Character then return end
        
        local char = player.Character
        if char and not char:FindFirstChild("HasBuso") then
            if tick() - lastHakiTime >= hakiCooldown then
                local commF = GetCommF()
                if commF then
                    pcall(function() 
                        commF:InvokeServer("Buso") 
                    end)
                    lastHakiTime = tick()
                end
            end
        end
    end

    -- Smooth Stay Above Target an toàn
    local function SmoothStayAbove(targetHRP)
        if stopAllActivities then return end
        if not targetHRP or not targetHRP.Parent then return end
        
        local char = player.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        pcall(function()
            hrp.CFrame = CFrame.new(targetHRP.Position + Vector3.new(0, HeightAboveOrder, 0))
        end)
    end

    -- Keep Player in Air
    RunService.Heartbeat:Connect(function()
        if getgenv().AutoCyborg and not stopAllActivities then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                pcall(function()
                    hrp.Velocity = Vector3.zero
                    hrp.AssemblyLinearVelocity = Vector3.zero
                end)
            end
        end
    end)

    -- Check Order an toàn
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
            if stopAllActivities then return nil end
            
            local enemies = Workspace:FindFirstChild("Enemies")
            if enemies then
                order = enemies:FindFirstChild("Order")
                if order and order:FindFirstChild("HumanoidRootPart") and order:FindFirstChild("Humanoid") then
                    return order
                end
            end
            task.wait(0.1)
            timer = timer + 0.1
        until timer >= 5
        return nil
    end

    -- KIỂM TRA VÀ SPAM NHÉT CORE BRAIN KHI CÓ
    task.spawn(function()
        while getgenv().AutoCyborg and not stopAllActivities do
            if CheckCoreBrainInInventory() then
                print("Phat hien Core Brain, dung farm va bat dau spam nhet...")
                -- set flags để dừng các phần khác
                hasCoreBrain = true
                stopAllActivities = true
                getgenv().AutoCyborg = false
                isRunningAutoCyborg = false

                -- SPAM NHÉT CORE BRAIN
                SpamdutditUntilGone("Core Brain")
                break
            else
                task.wait(1)
            end
        end
    end)

    -- Main Loop - FARM ORDER (CHỈ CHẠY KHI KHÔNG CÓ CORE BRAIN)
    task.spawn(function()
        while task.wait(0.2) do
            if not getgenv().AutoCyborg or stopAllActivities then 
                print("Dung AutoCyborg")
                break 
            end
            
            if CheckCoreBrainInInventory() then
                print("Phat hien Core Brain, dung farm")
                break
            end
            
            local char = player.Character
            if not char then 
                task.wait(1)
                continue 
            end
            
            EquipWeapon(getgenv().SelectWeapon)
            AutoHaki()

            local backpack = player:FindFirstChild("Backpack")
            if not backpack then 
                task.wait(1)
                continue 
            end
            
            local chip = backpack:FindFirstChild("Microchip") or char:FindFirstChild("Microchip")
            local hasChip = chip ~= nil
            local order = GetOrder()
            local orderExists = order ~= nil

            if orderExists then
                print("Dang tan cong Order...")
                repeat
                    if stopAllActivities then break end
                    
                    if CheckCoreBrainInInventory() then
                        print("Co Core Brain, dung tan cong")
                        break
                    end
                    
                    task.wait(0.15)
                    AutoHaki()
                    EquipWeapon(getgenv().SelectWeapon)
                    order = GetOrder()
                    if order and order:FindFirstChild("HumanoidRootPart") then
                        pcall(function()
                            SmoothStayAbove(order.HumanoidRootPart)
                            order.HumanoidRootPart.CanCollide = false
                            order.HumanoidRootPart.Size = Vector3.new(120,120,120)
                        end)
                    end
                until not OrderExists() or not getgenv().AutoCyborg or stopAllActivities
                continue
            end

            if hasChip and not OrderExists() then
                print("Co Microchip, bat dau raid...")
                Startdutdit()

                -- Chờ Order xuất hiện
                local waitTime = 0
                repeat
                    task.wait(0.5)
                    waitTime = waitTime + 0.5
                    order = GetOrder()
                until order or waitTime >= 10

                if order then
                    print("Order da xuat hien, bat dau tan cong...")
                    repeat
                        if stopAllActivities then break end
                        
                        if CheckCoreBrainInInventory() then
                            print("Co Core Brain, dung tan cong")
                            break
                        end
                        
                        task.wait(0.15)
                        AutoHaki()
                        EquipWeapon(getgenv().SelectWeapon)
                        if order and order:FindFirstChild("HumanoidRootPart") then
                            pcall(function()
                                SmoothStayAbove(order.HumanoidRootPart)
                                order.HumanoidRootPart.CanCollide = false
                                order.HumanoidRootPart.Size = Vector3.new(120,120,120)
                            end)
                        end
                        order = GetOrder()
                    until not OrderExists() or not getgenv().AutoCyborg or stopAllActivities
                end
                continue
            end

            if not hasChip and not OrderExists() then
                print("Khong co Microchip, dang mua...")
                local commF = GetCommF()
                if commF then
                    pcall(function()
                        commF:InvokeServer("BlackbeardReward", "Microchip", "1")
                        task.wait(0.3)
                        commF:InvokeServer("BlackbeardReward", "Microchip", "2")
                    end)
                end
                task.wait(0.5)
            end
        end
        print("Ket thuc AutoCyborg")
        isRunningAutoCyborg = false
    end)
end

-- PHẦN AUTO FARM CHEST VÀ FIST OF DARKNESS - CHỈ CHẠY KHI CHƯA CÓ CORE BRAIN
if not hasCoreBrain and not stopAllActivities then
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

    -- CẬP NHẬT HÀM KIỂM TRA FIST OF DARKNESS
    local function hasFistOfDarkness()
        return CheckFistOfDarkness()
    end

    local function DistanceSort(tbl)
        local RootPart = getCharacter().HumanoidRootPart
        table.sort(tbl, function(a, b)
            return (RootPart.Position - a.Position).Magnitude < (RootPart.Position - b.Position).Magnitude
        end
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
        end
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

    -- VÒNG LẶP CHÍNH - CHỈ CHẠY KHI CHƯA CÓ CORE BRAIN
    while task.wait(1) and not hasCoreBrain and not stopAllActivities do
        -- KIỂM TRA NẾU ĐANG CHẠY AUTO CYBORG THÌ DỪNG NHẶT CHEST
        if hasCoreBrain or isRunningAutoCyborg or stopAllActivities then
            print("da dut key k can nhat chest nx")
            break
        end

        -- KIỂM TRA FIST OF DARKNESS
        if hasFistOfDarkness() then
            print("Phat hien Fist of Darkness, bat dau spam nhet...")
            
            -- SPAM NHÉT FIST OF DARKNESS
            SpamdutditUntilGone("Fist of Darkness")
            
            -- SAU KHI NHÉT FIST OF DARKNESS THÀNH CÔNG, BẬT AUTOCYBORG
            if not hasFistOfDarkness then
                print("Da nhet Fist of Darkness thanh cong, bat dau AutoCyborg...")
                task.wait(2) -- Chờ một chút để raid bắt đầu
                StartAutoCyborg()
            end
            break
        end

        local chests = getChests()

        if #chests == 0 then
            -- Hàm hop server đã được xóa để giữ code ngắn gọn
            print("Khong co chest, can hop server...")
            break
        end

        for _, chest in ipairs(chests) do
            -- KIỂM TRA LẠI TRƯỚC KHI NHẶT MỖI CHEST
            if hasCoreBrain or isRunningAutoCyborg or stopAllActivities then
                print("da dut key k can nhat chest nx")
                return
            end

            -- KIỂM TRA FIST OF DARKNESS TRƯỚC KHI NHẶT CHEST
            if hasFistOfDarkness() then
                print("Phat hien Fist of Darkness, dung nhat chest de nhet...")
                -- SPAM NHÉT FIST OF DARKNESS
                SpamdutditUntilGone("Fist of Darkness")
                
                -- SAU KHI NHÉT FIST OF DARKNESS THÀNH CÔNG, BẬT AUTOCYBORG
                if not hasFistOfDarkness then
                    print("Chuyen sang AutoCyborg...")
                    task.wait(2)
                    StartAutoCyborg()
                end
                return
            end

            if chest and chest.Parent then
                ChestCount += 1

                print(string.format("Dang nhat ruong [%d/%d]...", ChestCount, MaxChests))

                noclip(true)
                tpTo(chest.Position, MaxSpeed)
                noclip(false)
                task.wait(0.4)

                local char = getCharacter()
                if char:FindFirstChildOfClass("Humanoid") then
                    char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end

                if ChestCount >= MaxChests then
                    print("du 30 ruong can hop server...")
                    break
                end
            end
        end
    end
end

-- THÔNG BÁO KHI ĐÃ CHUYỂN SANG CHẾ ĐỘ AUTO CYBORG
if hasCoreBrain or isRunningAutoCyborg then
    print("Da chuyen sang che do AutoCyborg")
end

-- THÔNG BÁO KHI DỪNG HOÀN TOÀN
if stopAllActivities then
    print("Da dung tat ca hoat dong - vi da nhet Core Brain")
end
