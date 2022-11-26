local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
	Name = "Kadmos Hub",
	LoadingTitle = "Kadmos Hub - Money Clicker Simulator",
	LoadingSubtitle = "Kadmos Hub, Created by Founder",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Kadmos",
		FileName = "KMMoneyClickerSim"
	},
	KeySystem = false
})

--Category
local MainTab = Window:CreateTab("Main")
local MiscTab = Window:CreateTab("Misc")

--Variables
local RepStorage = game:GetService("ReplicatedStorage")

local autoClick = false
local minDelay = 0.3
local maxDelay = 1.1
local acBypass = false
local riskyGp = false

local doNoclip = false



-- Functions
local function ModNotif(offOrOn, modName, content, dismissTime)
    if content == nil then
        content = "Pressed"
    end
    if dismissTime == nil then
        dismissTime = 1.5
    end
        
    if offOrOn == true then
        Rayfield:Notify({Title = modName, Content = modName .. " set to True", Duration = dismissTime})
    elseif offOrOn == "button" then
        Rayfield:Notify({Title = modName, Content = content, Duration = dismissTime})
    else
        Rayfield:Notify({Title = modName, Content = modName .. " set to False", Duration = dismissTime})
    end
end





-- MAIN TAB --
--local MainSection =
MainTab:CreateSection("Auto Clicker")
local AutoClickToggle = MainTab:CreateToggle({
	Name = "Auto Click",
	CurrentValue = false,
	Flag = "ToggleAutoClicker",
	Callback = function(Value)
		if Value == true then
		    autoClick = true
		    ModNotif(Value, "Auto Clicker")
		else
		    autoClick = false
		    ModNotif(Value, "Auto Clicker")
		end
	end,
})

local AcBypassToggle = MainTab:CreateToggle({
	Name = "CPS Randomizer",
	CurrentValue = false,
	Flag = "ToggleACBypass",
	Callback = function(Value)
		if Value == true then
		    acBypass = true
		    ModNotif(Value, "CPS Randomizer")
		else
		    acBypass = false
		    ModNotif(Value, "CPS Randomizer")
		end
	end,
})

local MinDelaySlider = MainTab:CreateSlider({
	Name = "Minimum Delay",
	Range = {0.1, 1.9},
	Increment = 0.1,
	Suffix = "Min Delay",
	CurrentValue = 0.3,
	Flag = "SliderMinDelay",
	Callback = function(Value)
	    if minDelay > maxDelay then
	        minDelay = maxDelay
	        Value = minDelay
	    end
	    
		minDelay = Value
	end,
})

local MaxDelaySlider = MainTab:CreateSlider({
	Name = "Maximum Delay",
	Range = {0.1, 1.9},
	Increment = 0.1,
	Suffix = "Max Delay",
	CurrentValue = 1.1,
	Flag = "SliderMaxDelay",
	Callback = function(Value)
	    if maxDelay < minDelay then
	        maxDelay = minDelay
	        Value = maxDelay
	    end
	    
		maxDelay = Value
	end,
})


MainTab:CreateSection("Gamepass")
local GPButton = MainTab:CreateButton({
	Name = "Unlock All Gamepass",
	Callback = function()
	    game:GetService("Players").LocalPlayer.GamePassFolder.X2GEMS.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.VIP.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.X2SPEED.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.X2REBIRTH.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.GOLDTOOL.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.X2XP.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.Lucky.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.Triple.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.X2JUMP.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.X2MONEY.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.FastHatch.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.AutoHatch.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.RGBMONEY.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.DIAMONDTOOL.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.AUTOCLICK.Value = true
		    game:GetService("Players").LocalPlayer.GamePassFolder.AUTOREBIRTH.Value = true
		    if riskyGp == true then
		        game:GetService("Players").LocalPlayer.GamePassFolder.HOVERBOARD.Value = true -- This will kick
		    end
        ModNotif("button", "Unlock All Gamepass", "Done!", 1.0)
	end,
})

local RiskyGpToggle = MainTab:CreateToggle({
	Name = "Allow Risky Gamepass",
	CurrentValue = false,
	Flag = "ToggleRiskyGp",
	Callback = function(Value)
		if Value == true then
		    riskyGp = true
		    ModNotif(Value, "Allow Risky Gamepass")
		else
		    riskyGp = false
		    ModNotif(Value, "Allow Risky Gamepass")
		end
	end,
})




-- Misc TAB --
local MiscSection = MiscTab:CreateSection("Misc Features")

local PhaseToggle = MiscTab:CreateToggle({
	Name = "Phase",
	CurrentValue = false,
	Flag = "TogglePhase",
	Callback = function(Value)
		if Value == true then
		    doNoclip = true
		    ModNotif(Value, "Phase")
		else
		    doNoclip = false
		    ModNotif(Value, "Phase")
		    if game.Players.LocalPlayer.Character ~= nil then
            for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                    v.CanCollide = false
                end
            end
            end
		end
	end,
})

local DestroyButton = MiscTab:CreateButton({
	Name = "Destroy & Uninject",
	Callback = function()
	    Rayfield:Destroy()
	end,
})

local TestButton = MiscTab:CreateButton({
	Name = "Test",
	Callback = function()
        Rayfield:Notify({Title = "Test", Content = "Did stuff", Duration = 1.0})
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Click")
	end,
})






--Functions n stuff

local function RandomFloat(min, max)
    return math.random() + math.random(min, max)
end


game:GetService('RunService').Stepped:connect(function()
    if autoClick == true then
        if acBypass == false then
            RepStorage.RemoteEvent:FireServer("Click")
            wait(0.11)
        else
            RepStorage.RemoteEvent:FireServer("Click")
            wait(RandomFloat(minDelay, maxDelay))
        end
    end
    
    if doNoclip == true then
        if game.Players.LocalPlayer.Character ~= nil then
            for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                    v.CanCollide = false
                end
            end
        end
        wait(1)
    end
end)