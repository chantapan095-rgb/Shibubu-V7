-- [[ SHIBUBU V9.6 : THE SPECTER OVERLORD ]]
-- [[ FIXED INVIS | NEW VC SHIELD | SPECTATE SYSTEM ]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "SHIBUBU V9.6 | SPECTER",
   LoadingTitle = "Awakening Specter Mode...",
   LoadingSubtitle = "by Shibubu AI",
   ConfigurationSaving = { Enabled = true, FolderName = "ShibubuV9", FileName = "SpecterMode" },
   KeySystem = false 
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- [[ 🛡️ TAB 1: SECURITY (VC SHIELD) ]]
local SecurityTab = Window:CreateTab("🛡️ Security", 4483362458)
SecurityTab:CreateToggle({
   Name = "🛡️ VC STEALTH (Anti-Ban)",
   CurrentValue = true,
   Callback = function(Value)
      _G.VCAntiBan = Value
      task.spawn(function()
          while _G.VCAntiBan do
              local VC = game:GetService("VoiceChatService")
              if VC then VC:SetServiceEnabled(false) end
              task.wait(5)
          end
      end)
   end
})
SecurityTab:CreateButton({ Name = "🧹 CLEAN LOGS", Callback = function() game:GetService("LogService"):ClearOutput() end })

-- [[ 👁️ TAB 2: VISUALS (ESP & SPECTATE) ]]
local VisualTab = Window:CreateTab("👁️ Visuals", 4483345998)

-- ระบบ Pro-ESP
VisualTab:CreateToggle({
   Name = "ADVANCED PRO-ESP",
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
                  local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                  label.Text = string.format("👤 %s\n📏 %d Studs", p.DisplayName, dist)
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

-- ระบบ Spectate (ส่องผู้เล่น)
VisualTab:CreateSection("🎥 Spectate Tools")
local spectating = false
local currentTarget = 1

VisualTab:CreateButton({
   Name = "🎥 SPECTATE NEXT",
   Callback = function()
      local allPlayers = Players:GetPlayers()
      currentTarget = currentTarget + 1
      if currentTarget > #allPlayers then currentTarget = 1 end
      local target = allPlayers[currentTarget]
      if target and target.Character and target.Character:FindFirstChild("Humanoid") then
          Camera.CameraSubject = target.Character.Humanoid
          Rayfield:Notify({Title = "SPECTATING", Content = "กำลังส่อง: "..target.DisplayName, Duration = 2})
      end
   end
})

VisualTab:CreateButton({
   Name = "❌ STOP SPECTATE",
   Callback = function()
      Camera.CameraSubject = LocalPlayer.Character.Humanoid
      Rayfield:Notify({Title = "SPECTATING", Content = "กลับมาที่ตัวละครตัวเองแล้ว", Duration = 2})
   end
})

-- [[ 👻 TAB 3: PHANTOM (FIXED INVIS) ]]
local PhantomTab = Window:CreateTab("👻 Phantom", 4483362143)
PhantomTab:CreateToggle({
   Name = "👻 GHOST INVISIBILITY",
   CurrentValue = false,
   Callback = function(Value)
      _G.InvisActive = Value
      local char = LocalPlayer.Character
      local function SetInvis(state)
          for _, v in pairs(char:GetDescendants()) do
              if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "HumanoidRootPart" then
                  v.Transparency = state and 1 or 0
              end
          end
      end
      if Value then
          _G.InvisLoop = RunService.RenderStepped:Connect(function() SetInvis(true) end)
      else
          if _G.InvisLoop then _G.InvisLoop:Disconnect() end
          SetInvis(false)
      end
   end
})

-- [[ 🚀 SYSTEM HOTKEY ]]
local isOpen = true
game:GetService("UserInputService").InputBegan:Connect(function(i, p)
   if i.KeyCode == Enum.KeyCode.LeftControl and not p then
      isOpen = not isOpen
      local g = game:GetService("CoreGui"):FindFirstChild("Rayfield")
      if g then for _, f in pairs(g:GetChildren()) do if f:IsA("Frame") then f.Visible = isOpen end end end
   end
end)

Rayfield:Notify({Title = "V9.6 SPECTER LOADED", Content = "Shibubu, Your Specter is ready.", Duration = 5})
