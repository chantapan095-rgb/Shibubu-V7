-- [[ SHIBUBU V9.0 : THE UNSEEN EMPEROR ]]
-- [[ GOD-LEVEL: ANTI-ADMIN, PRO-ESP, INVIS, AUTO-CHAT ]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "SHIBUBU V9.0 | UNSEEN EMPEROR",
   LoadingTitle = "Bypassing Security Systems...",
   LoadingSubtitle = "by Shibubu AI",
   ConfigurationSaving = { Enabled = true, FolderName = "ShibubuV9", FileName = "EmperorMode" },
   KeySystem = false 
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")

-- [[ 🛡️ TAB 1: EMPEROR SECURITY (ANTI-ADMIN) ]]
local SecurityTab = Window:CreateTab("🛡️ Security", 4483362458)

local function ServerHop()
    local x = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, s in pairs(x.data) do
        if s.playing < s.maxPlayers and s.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
        end
    end
end

SecurityTab:CreateToggle({
   Name = "🛡️ ANTI-ADMIN (Auto Server Hop)",
   CurrentValue = true,
   Callback = function(Value)
      _G.AntiAdmin = Value
      spawn(function()
          while _G.AntiAdmin do
              for _, p in pairs(Players:GetPlayers()) do
                  -- ตรวจสอบ Badge หรือ Rank (ตัวอย่างเบื้องต้น)
                  if p:GetRankInGroup(0) > 200 or p.Name:lower():find("admin") or p.Name:lower():find("mod") then
                      Rayfield:Notify({Title = "⚠️ ADMIN DETECTED", Content = "ย้ายเซิร์ฟเวอร์หนีทันที!", Duration = 5})
                      task.wait(0.5)
                      ServerHop()
                  end
              end
              task.wait(2)
          end
      end)
   end
})

SecurityTab:CreateButton({ Name = "🧹 CLEAN ALL LOGS", Callback = function() game:GetService("LogService"):ClearOutput() end })

-- [[ 👁️ TAB 2: OVERLORD VISUALS ]]
local VisualTab = Window:CreateTab("👁️ Visuals", 4483345998)
VisualTab:CreateToggle({
   Name = "ELITE ESP (Name/Dist/HP)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ProEsp = Value
      while _G.ProEsp do
          for _, p in pairs(Players:GetPlayers()) do
              if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                  local hrp = p.Character.HumanoidRootPart
                  local bgu = hrp:FindFirstChild("ShibubuESP") or Instance.new("BillboardGui", hrp)
                  bgu.Name = "ShibubuESP"
                  bgu.AlwaysOnTop = true
                  bgu.Size = UDim2.new(0, 200, 0, 50)
                  bgu.StudsOffset = Vector3.new(0, 4, 0)

                  local label = bgu:FindFirstChild("Info") or Instance.new("TextLabel", bgu)
                  label.Name = "Info"
                  label.BackgroundTransparency = 1
                  label.Size = UDim2.new(1, 0, 1, 0)
                  label.Font = Enum.Font.Code
                  label.TextColor3 = Color3.fromRGB(168, 85, 247)
                  label.TextStrokeTransparency = 0
                  
                  local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                  local hp = math.floor(p.Character.Humanoid.Health)
                  label.Text = string.format("👤 %s\n📏 %d Studs | ❤️ %d", p.DisplayName, dist, hp)
              end
          end
          task.wait(0.1)
          if not _G.ProEsp then
              for _, v in pairs(Players:GetPlayers()) do
                  if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                      local e = v.Character.HumanoidRootPart:FindFirstChild("ShibubuESP")
                      if e then e:Destroy() end
                  end
              end
          end
      end
   end
})

-- [[ 👻 TAB 3: PHANTOM GHOST (INVIS/FLY) ]]
local PhantomTab = Window:CreateTab("👻 Phantom", 4483362143)
PhantomTab:CreateToggle({
   Name = "GHOST INVISIBILITY",
   CurrentValue = false,
   Callback = function(Value)
      for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
          if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = Value and 1 or 0 end
      end
   end
})

-- [[ 💬 TAB 4: SOCIAL MIMIC (AUTO-CHAT) ]]
local SocialTab = Window:CreateTab("💬 Social", 4483362458)
SocialTab:CreateToggle({
   Name = "AUTO-MIMIC CHAT",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoChat = Value
      local phrases = {"Nice music!", "I love this game", "Just chilling here", "Practice makes perfect", "Hello everyone"}
      spawn(function()
          while _G.AutoChat do
              game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(phrases[math.random(1, #phrases)], "All")
              task.wait(math.random(30, 60))
          end
      end)
   end
})

-- [[ 🎹 TAB 5: HARMONY (MASTER) ]]
local MusicTab = Window:CreateTab("🎹 Harmony", 4483362143)
local function PlayMusic(sheet)
    _G.Playing = true
    spawn(function()
        for i = 1, #sheet do
            if not _G.Playing then break end
            local c = sheet:sub(i,i)
            if c == " " then task.wait(0.3) elseif c == "|" then task.wait(0.7) else
                VirtualInputManager:SendKeyEvent(true, c, false, game)
                task.wait(0.15)
                VirtualInputManager:SendKeyEvent(false, c, false, game)
            end
        end
    end)
end
MusicTab:CreateButton({Name = "🎶 รักแรก (Full)", Callback = function() PlayMusic("t y u o p o u y t | t y u o p a s d") end})
MusicTab:CreateButton({Name = "🛑 STOP", Callback = function() _G.Playing = false end})

Rayfield:Notify({Title = "V9.0 OMNIPOTENT", Content = "Empire is ready, Overlord.", Duration = 5})
