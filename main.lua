-- [[ SHIBUBU V7 : THE GOD OVERLORD EDITION ]]
-- [[ STATUS: UNDETECTED | ALL-IN-ONE MODULE ]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "SHIBUBU V7 | GOD OVERLORD",
   LoadingTitle = "Awakening the Overlord...",
   LoadingSubtitle = "by Shibubu AI",
   ConfigurationSaving = { Enabled = true, FolderName = "ShibubuV7", FileName = "GodMode" },
   KeySystem = false 
})

-- [[ 🛡️ TAB: SECURITY & BYPASS ]]
local SecurityTab = Window:CreateTab("🛡️ Security", 4483362458)
SecurityTab:CreateToggle({
   Name = "VC & LOG SHIELD",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
          local mt = getrawmetatable(game)
          setreadonly(mt, false)
          local old = mt.__namecall
          mt.__namecall = newcclosure(function(self, ...)
              if getnamecallmethod() == "FireServer" and (self.Name:lower():find("voice") or self.Name:lower():find("report")) then return nil end
              return old(self, ...)
          end)
      end
   end,
})
SecurityTab:CreateToggle({
   Name = "ANTI-FLING (STAY STILL)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AntiFling = Value
      while _G.AntiFling do
          if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
              game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
          end
          task.wait(0.1)
      end
   end,
})
SecurityTab:CreateToggle({
   Name = "ANTI-AFK (ALWAYS ON)",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
          game.Players.LocalPlayer.Idled:Connect(function()
              game:GetService("VirtualUser"):CaptureController()
              game:GetService("VirtualUser"):ClickButton2(Vector2.new())
          end)
      end
   end,
})

-- [[ 👁️ TAB: VISUALS & SPY ]]
local VisualTab = Window:CreateTab("👁️ Visuals", 4483345998)
VisualTab:CreateToggle({
   Name = "PHANTOM ESP",
   CurrentValue = false,
   Callback = function(Value)
      _G.Esp = Value
      while _G.Esp do
          for _, v in pairs(game.Players:GetPlayers()) do
              if v ~= game.Players.LocalPlayer and v.Character then
                  if not v.Character:FindFirstChild("ShibubuHighlight") then
                      local h = Instance.new("Highlight", v.Character)
                      h.Name = "ShibubuHighlight"
                      h.FillColor = Color3.fromRGB(168, 85, 247)
                  end
              end
          end
          task.wait(1)
      end
   end,
})
VisualTab:CreateButton({ Name = "🎥 SPECTATE NEXT", Callback = function()
    local p = game.Players:GetPlayers()
    _G.cur = (_G.cur or 0) + 1
    if _G.cur > #p then _G.cur = 1 end
    workspace.CurrentCamera.CameraSubject = p[_G.cur].Character.Humanoid
end})
VisualTab:CreateButton({ Name = "❌ STOP SPECTATE", Callback = function()
    workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
end})

-- [[ 👻 TAB: PHANTOM MOTION ]]
local PhantomTab = Window:CreateTab("📍 Phantom", 4483362143)
PhantomTab:CreateToggle({
   Name = "👻 NOCLIP (WALK THROUGH)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Noclip = Value
      game:GetService("RunService").Stepped:Connect(function()
          if _G.Noclip then
              for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                  if v:IsA("BasePart") then v.CanCollide = false end
              end
          end
      end)
   end,
})
PhantomTab:CreateToggle({
   Name = "🌊 WALK ON WATER",
   CurrentValue = false,
   Callback = function(Value)
      _G.WaterWalk = Value
      spawn(function()
          while _G.WaterWalk do
              for _, v in pairs(workspace:GetDescendants()) do
                  if v:IsA("BasePart") and (v.Name:lower():find("water") or v.Material == Enum.Material.Water) then
                      v.CanCollide = _G.WaterWalk
                  end
              end
              task.wait(1)
          end
      end)
   end,
})
PhantomTab:CreateToggle({
   Name = "📍 CLICK TP (CTRL+CLICK)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ClickTP = Value
      game.Players.LocalPlayer:GetMouse().Button1Down:Connect(function()
          if _G.ClickTP and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
              game.Players.LocalPlayer.Character:MoveTo(game.Players.LocalPlayer:GetMouse().Hit.p)
          end
      end)
   end,
})
PhantomTab:CreateSlider({ Name = "SPEED", Range = {16, 250}, Increment = 1, CurrentValue = 16, Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end})

-- [[ 🎣 TAB: FARMING & INTEL ]]
local FarmTab = Window:CreateTab("🎣 Farming", 4483362143)
FarmTab:CreateToggle({
   Name = "AUTO FISHING",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFish = Value
      spawn(function()
          while _G.AutoFish do
              local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
              if tool and (tool.Name:lower():find("rod") or tool.Name:lower():find("fish")) then
                  tool:Activate()
                  task.wait(math.random(7, 11))
                  tool:Activate()
              end
              task.wait(2)
          end
      end)
   end,
})
FarmTab:CreateToggle({
   Name = "🕵️‍♂️ CHAT LOGGER (F9 TO VIEW)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ChatLog = Value
      game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(data)
          if _G.ChatLog then print("[SPY] " .. data.FromSpeaker .. ": " .. data.Message) end
      end)
   end,
})

-- [[ 🌌 TAB: WORLD SETTINGS ]]
local WorldTab = Window:CreateTab("🌌 World", 4483362748)
WorldTab:CreateButton({ Name = "🌌 PURPLE VOID SKY", Callback = function()
    local sky = game.Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", game.Lighting)
    sky.SkyboxBk = "http://www.roblox.com/asset/?id=5701334035"
    sky.SkyboxDn = "http://www.roblox.com/asset/?id=5701334035"
    sky.SkyboxFt = "http://www.roblox.com/asset/?id=5701334035"
    sky.SkyboxLf = "http://www.roblox.com/asset/?id=5701334035"
    sky.SkyboxRt = "http://www.roblox.com/asset/?id=5701334035"
    sky.SkyboxUp = "http://www.roblox.com/asset/?id=5701334035"
end})

-- [[ ⚙️ SYSTEM SETTINGS ]]
local UserInputService = game:GetService("UserInputService")
local isOpen = true
UserInputService.InputBegan:Connect(function(input, processed)
   if input.KeyCode == Enum.KeyCode.LeftControl and not processed then
      isOpen = not isOpen
      local gui = game:GetService("CoreGui"):FindFirstChild("Rayfield")
      if gui then for _, f in pairs(gui:GetChildren()) do if f:IsA("Frame") then f.Visible = isOpen end end end
   end
end)

Rayfield:Notify({Title = "SHIBUBU V7 LOADED", Content = "กด [Left Ctrl] เพื่อเปิด/ปิด GUI", Duration = 5})
