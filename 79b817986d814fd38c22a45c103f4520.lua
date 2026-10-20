-- Meizu Hub v1.1.0  (rebranded Banana Hub, UI library inlined, accent=Meizu blue, hide-button=black M)
-- Colors & open/close button customized. No remote loadstring dependency remains.

-- REBRANDED: Banana Hub -> Meizu Hub v1.1.0 (mechanical rename only)
-- NOTE: UI library still loads remotely from original Banana GitHub URL (line ~2280).
-- The in-game Banana fruit strings and the remote UI-lib URL are intentionally unchanged.

local function geniter(f, s, c)
	if type(f) ~= "function" then
		local mt = getmetatable(f)

		if type(mt) == "table" and mt.__iter then
			f, s, c = mt.__iter(f)
		elseif type(f) == "table" then
			f, s, c = next, f, nil
		end
	end

	return function()
		local r = table.pack(f(s, c))

		if r[1] == nil then
			return false
		end

		c = r[1]

		return true, table.unpack(r, 1, r.n)
	end
end

ply = game.Players
plr = ply.LocalPlayer
Root = plr.Character.HumanoidRootPart
replicated = game:GetService("ReplicatedStorage")
Lv = game.Players.LocalPlayer.Data.Level.Value
TeleportService = game:GetService("TeleportService")
TW = game:GetService("TweenService")
Lighting = game:GetService("Lighting")
Enemies = workspace.Enemies
vim1 = game:GetService("VirtualInputManager")
vim2 = game:GetService("VirtualUser")
TeamSelf = plr.Team
RunSer = game:GetService("RunService")
Stats = game:GetService("Stats")
Energy = plr.Character.Energy.Value
plr.CharacterAdded:Connect(function(char)
	pcall(function()
		Root = char:WaitForChild("HumanoidRootPart", 10)
		local en = char:WaitForChild("Energy", 10)
		if en then Energy = en.Value end
	end)
end)
BringConnections = {}
BossList = {}
MaterialList = {}
NPCList = {}
shouldTween = false
getgenv().OnFarm = false
getgenv().AutoMaterial = false
NextIs = false
senth = false
senth2 = false
SoulGuitar = false
KenTest = true
debug = false
Brazier1 = false
Brazier2 = false
Brazier3 = false
Sec = 0.1
ClickState = 0
Num_self = 25

do
	local Loading

	repeat
		Loading = plr.PlayerGui:WaitForChild("Main"):WaitForChild("Loading") and game:IsLoaded()
		wait()
	until Loading
end

World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089

do
	Marines = function()
		replicated.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
	end
end

do
	Pirates = function()
		replicated.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
	end
end

if World1 then
	BossList = {
		"The Gorilla King",
		"Bobby",
		"The Saw",
		"Yeti",
		"Mob Leader",
		"Vice Admiral",
		"Saber Expert",
		"Warden",
		"Chief Warden",
		"Swan",
		"Magma Admiral",
		"Fishman Lord",
		"Wysper",
		"Thunder God",
		"Cyborg",
		"Ice Admiral",
		"Greybeard"
	}
elseif World2 then
	BossList = {
		"Diamond",
		"Jeremy",
		"Orbitus",
		"Don Swan",
		"Smoke Admiral",
		"Awakened Ice Admiral",
		"Tide Keeper",
		"Darkbeard",
		"Cursed Captain",
		"Order"
	}
elseif World3 then
	BossList = {
		"Stone",
		"Hydra Leader",
		"Kilo Admiral",
		"Captain Elephant",
		"Beautiful Pirate",
		"Cake Queen",
		"Dough King",
		"Longma",
		"Soul Reaper",
		"rip_indra True Form",
		"Tyrant of the Skies"
	}
end

if World1 then
	MaterialList = {
		"Leather + Scrap Metal",
		"Angel Wings",
		"Magma Ore",
		"Fish Tail"
	}
elseif World2 then
	MaterialList = {
		"Leather + Scrap Metal",
		"Radioactive Material",
		"Ectoplasm",
		"Mystic Droplet",
		"Magma Ore",
		"Vampire Fang"
	}
elseif World3 then
	MaterialList = {
		"Scrap Metal",
		"Demonic Wisp",
		"Conjured Cocoa",
		"Dragon Scale",
		"Gunpowder",
		"Fish Tail",
		"Mini Tusk"
	}
end

local t1 = {
	"Snow Lurker",
	"Arctic Warrior",
	"Hidden Key",
	"Awakened Ice Admiral"
}
local t2 = {
	"Part",
	"SpawnLocation",
	"Terrain",
	"WedgePart",
	"MeshPart"
}
local t3 = {
	"Swan Pirate",
	"Jeremy"
}
local t4 = {
	"Fajita",
	"Jeremy",
	"Diamond"
}
local t5 = { "Cookie Crafter" }
local t6 = { "Reborn Skeleton" }
local t7 = {
	["Pirate Millionaire"] = CFrame.new(-712.8272705078125, 98.577049255371094, 5711.9541015625),
	["Pistol Billionaire"] = CFrame.new(-723.43316650390625, 147.42906188964844, 5931.9931640625),
	["Dragon Crew Warrior"] = CFrame.new(7021.50439453125, 55.762702941894531, -730.12908935546875),
	["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),
	["Female Islander"] = CFrame.new(4692.7939453125, 797.9766845703125, 858.8480224609375),
	["Venomous Assailant"] = CFrame.new(4902, 670, 39),
	["Marine Commodore"] = CFrame.new(2401, 123, -7589),
	["Marine Rear Admiral"] = CFrame.new(3588, 229, -7085),
	["Fishman Raider"] = CFrame.new(-10941, 332, -8760),
	["Fishman Captain"] = CFrame.new(-11035, 332, -9087),
	["Forest Pirate"] = CFrame.new(-13446, 413, -7760),
	["Mythological Pirate"] = CFrame.new(-13510, 584, -6987),
	["Jungle Pirate"] = CFrame.new(-11778, 426, -10592),
	["Musketeer Pirate"] = CFrame.new(-13282, 496, -9565),
	["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),
	["Living Zombie"] = CFrame.new(-10227, 421, 6161),
	["Demonic Soul"] = CFrame.new(-9579, 6, 6194),
	["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),
	["Peanut Scout"] = CFrame.new(-1993, 187, -10103),
	["Peanut President"] = CFrame.new(-2215, 159, -10474),
	["Ice Cream Chef"] = CFrame.new(-877, 118, -11032),
	["Ice Cream Commander"] = CFrame.new(-877, 118, -11032),
	["Cookie Crafter"] = CFrame.new(-2021, 38, -12028),
	["Cake Guard"] = CFrame.new(-2024, 38, -12026),
	["Baking Staff"] = CFrame.new(-1932, 38, -12848),
	["Head Baker"] = CFrame.new(-1932, 38, -12848),
	["Cocoa Warrior"] = CFrame.new(95, 73, -12309),
	["Chocolate Bar Battler"] = CFrame.new(647, 42, -12401),
	["Sweet Thief"] = CFrame.new(116, 36, -12478),
	["Candy Rebel"] = CFrame.new(47, 61, -12889),
	Ghost = CFrame.new(5251, 5, 1111)
}
local t8 = {
	RFJobsRemoteFunction = replicated.Modules.Net["RF/JobsRemoteFunction"],
	RFCraft = replicated:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/Craft")
}

EquipWeapon = function(p1)
	if not p1 then
		return
	end

	if plr.Backpack:FindFirstChild(p1) then
		plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(p1))
	end
end
weaponSc = function(p2)
	for _, child in pairs(plr.Backpack:GetChildren()) do
		if child:IsA("Tool") and child.ToolTip == p2 then
			EquipWeapon(child.Name)
		end
	end
end

local t9 = {}

t9.__index = t9

do
	t9.Alive = function(p3)
		if not p3 then
			return
		end

		local Humanoid = p3:FindFirstChild("Humanoid")

		return Humanoid and Humanoid.Health > 0
	end
end

t9.Pos = function(p4, p5)
	return (Root.Position - mode.Position).Magnitude <= p5
end
t9.Dist = function(p6, p7)
	return (Root.Position - p6:FindFirstChild("HumanoidRootPart").Position).Magnitude <= p7
end
t9.DistH = function(p8, p9)
	return (Root.Position - p8:FindFirstChild("HumanoidRootPart").Position).Magnitude > p9
end

do
	t9.Kill = function(p10, p11)
		if p10 and p11 then
			if not p10:GetAttribute("Locked") then
				p10:SetAttribute("Locked", p10.HumanoidRootPart.CFrame)
			end

			PosMon = p10:GetAttribute("Locked").Position
			BringEnemy()
			EquipWeapon(_G.SelectWeapon)

			local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")

			if (Tool and Tool:FindFirstChild("ToolTip") and Tool.ToolTip or "") == "Blox Fruit" then
				_tp(p10.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.rad(90), 0))
			else
				_tp(p10.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, math.rad(180), 0))
			end

			if RandomCFrame then
				wait(0.5)
				_tp(p10.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
				wait(0.5)
				_tp(p10.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
				wait(0.5)
				_tp(p10.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
				wait(0.5)
				_tp(p10.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
				wait(0.5)
				_tp(p10.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
			end
		end
	end
end

t9.Kill2 = function(p12, p13)
	if p12 and p13 then
		if not p12:GetAttribute("Locked") then
			p12:SetAttribute("Locked", p12.HumanoidRootPart.CFrame)
		end

		PosMon = p12:GetAttribute("Locked").Position
		BringEnemy()
		EquipWeapon(_G.SelectWeapon)

		local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
		local ToolTip = Tool and Tool:FindFirstChild("ToolTip") and Tool.ToolTip

		if (ToolTip or "") == "Blox Fruit" then
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.rad(90), 0))
		else
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(0, 10, 8) * CFrame.Angles(0, math.rad(180), 0))
		end

		if RandomCFrame then
			wait(0.1)
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
			wait(0.1)
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
			wait(0.1)
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
			wait(0.1)
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
			wait(0.1)
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
		end
	end
end

do
	t9.KillSea = function(p14, p15)
		if p14 and p15 then
			if not p14:GetAttribute("Locked") then
				p14:SetAttribute("Locked", p14.HumanoidRootPart.CFrame)
			end

			PosMon = p14:GetAttribute("Locked").Position
			BringEnemy()
			EquipWeapon(_G.SelectWeapon)

			local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")

			if (Tool and Tool:FindFirstChild("ToolTip") and Tool.ToolTip or "") == "Blox Fruit" then
				_tp(p14.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.rad(90), 0))
			else
				notween(p14.HumanoidRootPart.CFrame * CFrame.new(0, 50, 8))
				wait(0.85)
				notween(p14.HumanoidRootPart.CFrame * CFrame.new(0, 400, 0))
				wait(1)
			end
		end
	end
end

do
	t9.Sword = function(p16, p17)
		if p16 then
			if p17 then
				if not p16:GetAttribute("Locked") then
					p16:SetAttribute("Locked", p16.HumanoidRootPart.CFrame)
				end

				PosMon = p16:GetAttribute("Locked").Position
				BringEnemy()
				weaponSc("Sword")
				_tp(p16.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

				if RandomCFrame then
					wait(0.1)
					_tp(p16.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
					wait(0.1)
					_tp(p16.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
					wait(0.1)
					_tp(p16.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
					wait(0.1)
					_tp(p16.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
					wait(0.1)
					_tp(p16.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
				end
			end
		end
	end
end

t9.Mas = function(p18, p19)
	if p18 and p19 then
		if not p18:GetAttribute("Locked") then
			p18:SetAttribute("Locked", p18.HumanoidRootPart.CFrame)
		end

		PosMon = p18:GetAttribute("Locked").Position
		BringEnemy()

		if p18.Humanoid.Health <= HealthM then
			_tp(p18.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))

			local SelectedMasterySkills = _G.SelectedMasterySkills

			if type(SelectedMasterySkills) ~= "table" then
				SelectedMasterySkills = {
					"Z",
					"X",
					"C",
					"V",
					"F"
				}
			end

			for k, SelectedMasterySkill in pairs(SelectedMasterySkills) do
				if type(k) == "number" then
					Useskills("Blox Fruit", SelectedMasterySkill)
				elseif type(k) == "string" and SelectedMasterySkill == true then
					Useskills("Blox Fruit", k)
				end
			end
		else
			weaponSc("Melee")
			_tp(p18.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
		end
	end
end

do
	t9.Masgun = function(p20, p21)
		if p20 and p21 then
			if not p20:GetAttribute("Locked") then
				p20:SetAttribute("Locked", p20.HumanoidRootPart.CFrame)
			end

			PosMon = p20:GetAttribute("Locked").Position
			BringEnemy()

			if p20.Humanoid.Health <= HealthM then
				_tp(p20.HumanoidRootPart.CFrame * CFrame.new(0, 35, 8))

				local SelectedMasterySkills = _G.SelectedMasterySkills

				if type(SelectedMasterySkills) ~= "table" then
					SelectedMasterySkills = {
						"Z",
						"X",
						"C",
						"V",
						"F"
					}
				end

				for k, SelectedMasterySkill in pairs(SelectedMasterySkills) do
					if type(k) == "number" then
						Useskills("Gun", SelectedMasterySkill)
					elseif type(k) == "string" and SelectedMasterySkill == true then
						Useskills("Gun", k)
					end
				end
			else
				weaponSc("Melee")
				_tp(p20.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
			end
		end
	end
end

statsSetings = function(p22, p23)
	if p22 == "Melee" then
		if plr.Data.Points.Value ~= 0 then
			replicated.Remotes.CommF_:InvokeServer("AddPoint", "Melee", p23)
		end
	elseif p22 == "Defense" then
		if plr.Data.Points.Value ~= 0 then
			replicated.Remotes.CommF_:InvokeServer("AddPoint", "Defense", p23)
		end
	elseif p22 == "Sword" then
		if plr.Data.Points.Value ~= 0 then
			replicated.Remotes.CommF_:InvokeServer("AddPoint", "Sword", p23)
		end
	elseif p22 == "Gun" then
		if plr.Data.Points.Value ~= 0 then
			replicated.Remotes.CommF_:InvokeServer("AddPoint", "Gun", p23)
		end
	elseif p22 == "Devil" and plr.Data.Points.Value ~= 0 then
		replicated.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", p23)
	end
end
BringEnemy = function(p24)
	if not _B then
		return
	end

	if not p24 then
		local HumanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return
		end

		local huge = math.huge

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			local Humanoid = child:FindFirstChildOfClass("Humanoid")
			local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart")

			if Humanoid and HumanoidRootPart2 and Humanoid.Health > 0 then
				local Magnitude = (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude

				if Magnitude < huge then
					huge = Magnitude
					p24 = child
				end
			end
		end

		if not p24 then
			return
		end
	end

	local u34 = false

	local function v35(p25)
		local Humanoid = p25:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = p25:FindFirstChild("HumanoidRootPart")

		return Humanoid and HumanoidRootPart and Humanoid.Health > 0, HumanoidRootPart, Humanoid
	end
	local function v38(p26)
		if isnetworkowner then
			return isnetworkowner(p26)
		end

		return p26.ReceiveAge == 0 and not p26.Anchored and p26.Velocity.Magnitude > 0
	end

	pcall(function()
		if sethiddenproperty then
			sethiddenproperty(plr, "SimulationRadius", math.huge)
		end

		local Position = p24.HumanoidRootPart.Position

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if child ~= p24 then
				local v42, v43, v44 = v35(child)

				if v42 and child.Name == p24.Name then
					local Magnitude = (v43.Position - Position).Magnitude

					if Magnitude <= 3000 then
						if not v43:FindFirstChild("BodyVelocity") then
							local BodyVelocity = Instance.new("BodyVelocity")

							BodyVelocity.Name = "BodyVelocity"
							BodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
							BodyVelocity.Velocity = Vector3.zero
							BodyVelocity.Parent = v43
						end

						if Magnitude <= 10 then
							u34 = true
						end

						if not u34 and v38(v43) then
							v43.CFrame = CFrame.new(Position)
						end

						v43.CanCollide = false
						v44.WalkSpeed = 0
						v44.JumpPower = 0
					end
				end
			end
		end

		if p24 and p24:FindFirstChild("HumanoidRootPart") then
			p24.HumanoidRootPart.CanCollide = false
			p24.Humanoid.WalkSpeed = 0
			p24.Humanoid.JumpPower = 0
		end
	end)
end

do
	local function v47(p27, p28)
		local LocalPlayer = game.Players.LocalPlayer
		local Name
		local v50, v51, v52 = pairs(LocalPlayer.Character:GetChildren())
		local v53 = geniter(v50, v51, v52)

		while true do
			local v54 = table.pack(v53())

			if not v54[1] then
				break
			end

			local v55 = v54[3]

			if v55:IsA("Tool") and v55.ToolTip == p27 then
				Name = v55.Name

				break
			end
		end

		if not Name then
			local v56, v57, v58 = pairs(LocalPlayer.Backpack:GetChildren())

			for _, v1 in v56, v57, v58 do
				if v1:IsA("Tool") then
					if v1.ToolTip == p27 then
						Name = v1.Name

						break
					end
				end
			end
		end

		if Name then
			if LocalPlayer.PlayerGui:FindFirstChild("Main") then
				if LocalPlayer.PlayerGui.Main:FindFirstChild("Skills") then
					local v61 = LocalPlayer.PlayerGui.Main.Skills:FindFirstChild(Name)

					if v61 then
						local v62 = v61:FindFirstChild(p28)

						if not v62 then
							return false
						end

						local Title = v62:FindFirstChild("Title")

						if Title and Title:IsA("TextLabel") and Title.TextColor3.R < 0.5 then
							return false
						end

						local Cooldown = v62:FindFirstChild("Cooldown")

						if Cooldown and (Cooldown.Size.X.Scale > 0 or Cooldown.AbsoluteSize.X > 0) then
							return false
						end

						return true
					end
				end
			end
		end

		return true
	end

	Useskills = function(p29, p30)
		if p29 == "Melee" then
			weaponSc("Melee")

			if not v47(p29, p30) then
				return
			end

			if p30 == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game)
				vim1:SendKeyEvent(false, "Z", false, game)
			elseif p30 == "X" then
				vim1:SendKeyEvent(true, "X", false, game)
				vim1:SendKeyEvent(false, "X", false, game)
			elseif p30 == "C" then
				vim1:SendKeyEvent(true, "C", false, game)
				vim1:SendKeyEvent(false, "C", false, game)
			elseif p30 == "V" then
				vim1:SendKeyEvent(true, "V", false, game)
				vim1:SendKeyEvent(false, "V", false, game)
			elseif p30 == "F" then
				vim1:SendKeyEvent(true, "F", false, game)
				vim1:SendKeyEvent(false, "F", false, game)
			elseif p30 == "Y" then
				vim1:SendKeyEvent(true, "Y", false, game)
				vim1:SendKeyEvent(false, "Y", false, game)
			end
		elseif p29 == "Sword" then
			weaponSc("Sword")

			if not v47(p29, p30) then
				return
			end

			if p30 == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game)
				vim1:SendKeyEvent(false, "Z", false, game)
			elseif p30 == "X" then
				vim1:SendKeyEvent(true, "X", false, game)
				vim1:SendKeyEvent(false, "X", false, game)
			elseif p30 == "C" then
				vim1:SendKeyEvent(true, "C", false, game)
				vim1:SendKeyEvent(false, "C", false, game)
			elseif p30 == "V" then
				vim1:SendKeyEvent(true, "V", false, game)
				vim1:SendKeyEvent(false, "V", false, game)
			elseif p30 == "F" then
				vim1:SendKeyEvent(true, "F", false, game)
				vim1:SendKeyEvent(false, "F", false, game)
			elseif p30 == "Y" then
				vim1:SendKeyEvent(true, "Y", false, game)
				vim1:SendKeyEvent(false, "Y", false, game)
			end
		elseif p29 == "Blox Fruit" then
			weaponSc("Blox Fruit")

			if not v47(p29, p30) then
				return
			end

			if p30 == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game)
				vim1:SendKeyEvent(false, "Z", false, game)
			elseif p30 == "X" then
				vim1:SendKeyEvent(true, "X", false, game)
				vim1:SendKeyEvent(false, "X", false, game)
			elseif p30 == "C" then
				vim1:SendKeyEvent(true, "C", false, game)
				vim1:SendKeyEvent(false, "C", false, game)
			elseif p30 == "V" then
				vim1:SendKeyEvent(true, "V", false, game)
				vim1:SendKeyEvent(false, "V", false, game)
			elseif p30 == "F" then
				vim1:SendKeyEvent(true, "F", false, game)
				vim1:SendKeyEvent(false, "F", false, game)
			elseif p30 == "Y" then
				vim1:SendKeyEvent(true, "Y", false, game)
				vim1:SendKeyEvent(false, "Y", false, game)
			end
		elseif p29 == "Gun" then
			weaponSc("Gun")

			if not v47(p29, p30) then
				return
			end

			if p30 == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game)
				vim1:SendKeyEvent(false, "Z", false, game)
			elseif p30 == "X" then
				vim1:SendKeyEvent(true, "X", false, game)
				vim1:SendKeyEvent(false, "X", false, game)
			elseif p30 == "C" then
				vim1:SendKeyEvent(true, "C", false, game)
				vim1:SendKeyEvent(false, "C", false, game)
			elseif p30 == "V" then
				vim1:SendKeyEvent(true, "V", false, game)
				vim1:SendKeyEvent(false, "V", false, game)
			elseif p30 == "F" then
				vim1:SendKeyEvent(true, "F", false, game)
				vim1:SendKeyEvent(false, "F", false, game)
			elseif p30 == "Y" then
				vim1:SendKeyEvent(true, "Y", false, game)
				vim1:SendKeyEvent(false, "Y", false, game)
			end
		end

		if p29 == "nil" and p30 == "Y" then
			vim1:SendKeyEvent(true, "Y", false, game)
			vim1:SendKeyEvent(false, "Y", false, game)
		end
	end
end

do
	local v65 = getrawmetatable(game)
	local __namecall = v65.__namecall

	setreadonly(v65, false)
	v65.__namecall = newcclosure(function(...)
		local v67 = getnamecallmethod()
		local t10 = { ... }

		if tostring(v67) == "FireServer" and tostring(t10[1]) == "RemoteEvent" and tostring(t10[2]) ~= "true" and tostring(t10[2]) ~= "false" then
			if _G.FarmMastery_G and not SoulGuitar or _G.FarmMastery_Dev or _G.FarmBlazeEM or _G.Prehis_Skills or _G.SeaBeast1 or _G.FishBoat or _G.PGB or _G.Leviathan1 or _G.Complete_Trials or _G.AimMethod and ABmethod == "Aim Player" or _G.AimMethod and ABmethod == "Nearest Aim" then
				t10[2] = MousePos

				return __namecall(unpack(t10))
			end
		end

		return __namecall(...)
	end)
end

GetConnectionEnemies = function(p31)
	for _, child in pairs(replicated:GetChildren()) do
		if child:IsA("Model") then
			if (typeof(p31) == "table" and table.find(p31, child.Name) or child.Name == p31) and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 then
				return child
			end
		end
	end

	local children, v72 = game.Workspace.Enemies:GetChildren()

	for _, v1 in next, children, v72 do
		if v1:IsA("Model") then
			if (typeof(p31) == "table" and table.find(p31, v1.Name) or v1.Name == p31) and v1:FindFirstChild("Humanoid") and v1.Humanoid.Health > 0 then
				return v1
			end
		end
	end
end
LowCpu = function()
	local Terrain = game.Workspace.Terrain

	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 0
	game.Lighting.GlobalShadows = false
	game.Lighting.FogEnd = 9e9
	game.Lighting.Brightness = 0
	settings().Rendering.QualityLevel = "Level01"

	for _, descendant in pairs(game:GetDescendants()) do
		if not (descendant:IsA("Part") or descendant:IsA("Union") or descendant:IsA("CornerWedgePart")) then
			if not descendant:IsA("TrussPart") then
				if not descendant:IsA("Decal") then
					if not descendant:IsA("Texture") then
						if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
							descendant.Lifetime = NumberRange.new(0)
						elseif descendant:IsA("Explosion") then
							descendant.BlastPressure = 1
							descendant.BlastRadius = 1
						elseif descendant:IsA("Fire") or descendant:IsA("SpotLight") or descendant:IsA("Smoke") or descendant:IsA("Sparkles") then
							descendant.Enabled = false
						elseif descendant:IsA("MeshPart") then
							descendant.Material = "Plastic"
							descendant.Reflectance = 0
							descendant.TextureID = 10385902758728956
						end

						continue
					end
				end

				descendant.Transparency = 1

				continue
			end
		end

		descendant.Material = "Plastic"
		descendant.Reflectance = 0
	end

	for _, child in pairs(game.Lighting:GetChildren()) do
		if child:IsA("BlurEffect") or child:IsA("SunRaysEffect") or child:IsA("ColorCorrectionEffect") or child:IsA("BloomEffect") or child:IsA("DepthOfFieldEffect") then
			child.Enabled = false
		end
	end
end
CheckF = function()
	if not (GetBP("Dragon-Dragon") or GetBP("Gas-Gas")) then
		if not (GetBP("Yeti-Yeti") or GetBP("Kitsune-Kitsune") or not not GetBP("T-Rex-T-Rex")) then
			return
		end
	end

	return true
end
CheckBoat = function()
	local v80, v81, v82 = pairs(workspace.Boats:GetChildren())
	local v83 = geniter(v80, v81, v82)
	local v84 = table.pack(v83())

	if v84[1] then
		local v85 = v84[3]

		while tostring(v85.Owner.Value) ~= tostring(plr.Name) do
			local v86 = table.pack(v83())

			if not v86[1] then
				return false
			end

			v85 = v86[3]
		end

		return v85
	end

	return false
end
CheckEnemiesBoat = function()
	for _, child in pairs(workspace.Enemies:GetChildren()) do
		if child.Name == "FishBoat" then
			if child:FindFirstChild("Health").Value > 0 then
				return true
			end
		end
	end

	return false
end
CheckPirateGrandBrigade = function()
	for _, child in pairs(workspace.Enemies:GetChildren()) do
		if (child.Name == "PirateGrandBrigade" or child.Name == "PirateBrigade") and child:FindFirstChild("Health").Value > 0 then
			return true
		end
	end

	return false
end
CheckShark = function()
	for _, child in pairs(workspace.Enemies:GetChildren()) do
		if child.Name == "Shark" and t9.Alive(child) then
			return true
		end
	end

	return false
end

do
	CheckTerrorShark = function()
		for _, child in pairs(workspace.Enemies:GetChildren()) do
			if child.Name == "Terrorshark" and t9.Alive(child) then
				return true
			end
		end

		return false
	end
end

do
	CheckPiranha = function()
		for _, child in pairs(workspace.Enemies:GetChildren()) do
			if child.Name == "Piranha" then
				if t9.Alive(child) then
					return true
				end
			end
		end

		return false
	end
end

CheckFishCrew = function()
	for _, child in pairs(workspace.Enemies:GetChildren()) do
		if child.Name ~= "Fish Crew Member" then
			if child.Name ~= "Haunted Crew Member" then
				continue
			end
		end

		if t9.Alive(child) then
			return true
		end
	end

	return false
end

do
	CheckHauntedCrew = function()
		for _, child in pairs(workspace.Enemies:GetChildren()) do
			if child.Name == "Haunted Crew Member" and t9.Alive(child) then
				return true
			end
		end

		return false
	end
end

do
	CheckSeaBeast = function()
		if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
			return true
		end

		return false
	end
end

do
	CheckLeviathan = function()
		if workspace.SeaBeasts:FindFirstChild("Leviathan") then
			return true
		end

		return false
	end
end

do
	UpdStFruit = function()
		local children, v102 = plr.Backpack:GetChildren()

		for _, v1 in next, children, v102 do
			StoreFruit = v1:FindFirstChild("EatRemote", true)

			if StoreFruit then
				replicated.Remotes.CommF_:InvokeServer("StoreFruit", StoreFruit.Parent:GetAttribute("OriginalName"), plr.Backpack:FindFirstChild(v1.Name))
			end
		end
	end
end

collectFruits = function(p32)
	if p32 then
		local Character = plr.Character

		for _, child in pairs(workspace:GetChildren()) do
			if string.find(child.Name, "Fruit") then
				child.Handle.CFrame = Character.HumanoidRootPart.CFrame
			end
		end
	end
end
Getmoon = function()
	if World1 then
		return Lighting.FantasySky.MoonTextureId
	end

	if World2 then
		return Lighting.FantasySky.MoonTextureId
	end

	if World3 then
		return Lighting.Sky.MoonTextureId
	end
end
DropFruits = function()
	local children, v109 = plr.Backpack:GetChildren()

	for _, v1 in next, children, v109 do
		if string.find(v1.Name, "Fruit") then
			EquipWeapon(v1.Name)
			wait(0.1)

			if plr.PlayerGui.Main.Dialogue.Visible == true then
				plr.PlayerGui.Main.Dialogue.Visible = false
			end

			EquipWeapon(v1.Name)
			plr.Character:FindFirstChild(v1.Name).EatRemote:InvokeServer("Drop")
		end
	end

	for _, child in pairs(plr.Character:GetChildren()) do
		if string.find(child.Name, "Fruit") then
			EquipWeapon(child.Name)
			wait(0.1)

			if plr.PlayerGui.Main.Dialogue.Visible == true then
				plr.PlayerGui.Main.Dialogue.Visible = false
			end

			EquipWeapon(child.Name)
			plr.Character:FindFirstChild(child.Name).EatRemote:InvokeServer("Drop")
		end
	end
end

do
	GetBP = function(p33)
		return plr.Backpack:FindFirstChild(p33) or plr.Character:FindFirstChild(p33)
	end
end

do
	GetIn = function(p34)
		for _, v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(v1) == "table" then
				if v1.Name == p34 then
					return true
				end

				if plr.Character:FindFirstChild(p34) then
					return true
				end

				if plr.Backpack:FindFirstChild(p34) then
					return true
				end
			end
		end

		return false
	end
end

GetM = function(p35)
	for _, v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
		if type(v1) == "table" and v1.Type == "Material" and v1.Name == p35 then
			return v1.Count
		end
	end

	return 0
end
GetWP = function(p36)
	local response = replicated.Remotes.CommF_:InvokeServer("getInventory")

	if type(response) ~= "table" then
		return false
	end

	for _, v1 in pairs(response) do
		if type(v1) == "table" and v1.Type == "Sword" then
			if v1.Name == p36 then
				return true
			end

			if plr.Character then
				if plr.Character:FindFirstChild(p36) then
					return true
				end
			end

			if not plr.Backpack then
				continue
			end

			if plr.Backpack:FindFirstChild(p36) then
				return true
			end
		end
	end

	return false
end
getInfinity_Ability = function(p37, p38)
	if not Root then
		return
	end

	if p37 == "Soru" and p38 then
		local next_ = next
		local v122, v123 = getgc()

		for _, v1 in next_, v122, v123 do
			if plr.Character.Soru then
				if typeof(v1) == "function" and getfenv(v1).script == plr.Character.Soru then
					local next_2 = next
					local v127, v128 = getupvalues(v1)

					for _, v2 in next_2, v127, v128 do
						if typeof(v2) == "table" then
							repeat
								wait(Sec)
								v2.LastUse = 0
							until plr.Character.Humanoid.Health <= 0
						end
					end
				end
			end
		end
	elseif p37 == "Energy" and p38 then
		plr.Character.Energy.Changed:connect(function()
			if p38 then
				plr.Character.Energy.Value = Energy
			end
		end)
	elseif p37 == "Observation" and p38 then
		plr.VisionRadius.Value = math.huge
	end
end
Hop = function()
	pcall(function()
		for i = math.random(1, math.random(40, 75)), 100 do
			for k, v1 in next, replicated.__ServerBrowser:InvokeServer(i), nil do
				if tonumber(v1.Count) < 12 then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, k)
				end
			end
		end
	end)
end

local Part = Instance.new("Part", workspace)

Part.Size = Vector3.new(1, 1, 1)
Part.Name = "Rip_Indra"
Part.Anchored = true
Part.CanCollide = false
Part.CanTouch = false
Part.Transparency = 1

do
	local PartName = workspace:FindFirstChild(Part.Name)

	if PartName and PartName ~= Part then
		PartName:Destroy()
	end
end

do
	task.spawn(function()
		while task.wait() do
			if Part and Part.Parent == workspace then
				if shouldTween then
					getgenv().OnFarm = true
				else
					getgenv().OnFarm = false
				end
			else
				getgenv().OnFarm = false
			end
		end
	end)
end

do
	task.spawn(function()
		local LocalPlayer = game.Players.LocalPlayer

		while true do
			task.wait()

			if not LocalPlayer.Character then
				continue
			end

			if LocalPlayer.Character.PrimaryPart then
				break
			end
		end

		Part.CFrame = LocalPlayer.Character.PrimaryPart.CFrame

		while task.wait() do
			pcall(function()
				if getgenv().OnFarm then
					if not _G.WasOnFarm then
						_G.WasOnFarm = true
					end

					if Part and Part.Parent == workspace then
						local PrimaryPart = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart

						if PrimaryPart and (PrimaryPart.Position - Part.Position).Magnitude <= 200 then
							PrimaryPart.CFrame = CFrame.new(Part.Position)
						else
							Part.CFrame = PrimaryPart.CFrame
						end
					end

					local Character = LocalPlayer.Character

					if Character then
						for _, child in pairs(Character:GetChildren()) do
							if child:IsA("BasePart") then
								child.CanCollide = false
							end
						end
					end
				elseif _G.WasOnFarm then
					_G.WasOnFarm = false

					local Character = LocalPlayer.Character

					if Character then
						for _, child in pairs(Character:GetChildren()) do
							if child:IsA("BasePart") then
								child.CanCollide = true
							end
						end
					end
				end
			end)
		end
	end)
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")
game:GetService("RunService")

do
	local LocalPlayer = game:GetService("Players").LocalPlayer

	sea1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
	sea2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
	sea3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089

	local t11 = {
		["Tween Speed"] = 200,
		["Bypass Teleport"] = false,
		["Up Y"] = false,
		["Up Y When Low Health"] = false,
		["Same Y"] = false
	}
	local cFrame = CFrame.new(10641.0918, -1953.92981, 9825.07031, -0.652825892, -9.2805891e-08, -0.757508039, -2.73638356e-08, 1, -9.89323823e-08, 0.757508039, -4.38572947e-08, -0.652825892)
	local cFrame2 = CFrame.new(-16271.126, 25.5847301, 1371.98755, 0.999396622, -5.78875188e-08, -0.0347310975, 5.52972779e-08, 1, -8.7544322e-08, 0.034731105, 8.28877091e-08, 0.999396741)

	Convert_CFrame = function(p39)
		if not p39 then
			return
		end

		if typeof(p39) == "Vector3" then
			return CFrame.new(p39)
		end

		if typeof(p39) == "CFrame" then
			return p39
		end

		if typeof(p39) == "Model" then
			return p39:GetPivot()
		end

		if p39.CFrame then
			return p39.CFrame
		end

		return nil
	end
	GetDistance = function(p40, p41, p42)
		if p40 == nil then
			return 9e9
		end

		local Character = LocalPlayer.Character

		if not Character then
			return 9e9
		end

		local Humanoid = Character:FindFirstChild("Humanoid")

		if not Humanoid or Humanoid.Health <= 0 then
			return 9e9
		end

		if p41 == nil then
			p41 = Character:FindFirstChild("HumanoidRootPart")

			if not p41 then
				return 9e9
			end
		end

		local v151 = Convert_CFrame(p40)
		local v152 = Convert_CFrame(p41)

		if p42 then
			return (Vector3.new(v151.X, 0, v151.Z) - Vector3.new(v152.X, 0, v152.Z)).Magnitude
		end

		return (v151.Position - v152.Position).Magnitude
	end
	InArea = function(p43)
		local _WorldOrigin = workspace:FindFirstChild("_WorldOrigin")

		if not _WorldOrigin then
			return {
				Name = ""
			}
		end

		local v154 = Convert_CFrame(p43)
		local children, v156 = _WorldOrigin.Locations:GetChildren()

		for _, v1 in next, children, v156 do
			if v1:FindFirstChild("Mesh") and (v154.Position - v1.Position).Magnitude <= v1.Mesh.Scale.X then
				return v1
			end
		end

		return {
			Name = ""
		}
	end
	GetSpawnPoint = function(p44)
		local Pirates_ = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("PlayerSpawns") and workspace._WorldOrigin.PlayerSpawns:FindFirstChild("Pirates")

		if not Pirates_ then
			return
		end

		local children, v161 = Pirates_:GetChildren()

		for _, v1 in next, children, v161 do
			if v1:FindFirstChild("Part") and (v1.Part.Position - p44.Position).Magnitude <= 2500 then
				return v1
			end
		end
	end
	CheckLegendaryItems = function()
		local function v164(p45)
			local children, v166 = LocalPlayer.Backpack:GetChildren()

			for _, v1 in next, children, v166 do
				if v1:IsA("Tool") then
					if v1.Name == p45 then
						return v1
					end

					if string.find(v1.Name, p45) then
						return v1
					end
				end
			end

			local children2, v170 = LocalPlayer.Character:GetChildren()

			for _, v1 in next, children2, v170 do
				if v1:IsA("Tool") and (v1.Name == p45 or string.find(v1.Name, p45)) then
					return v1
				end
			end
		end

		if v164("God's Chalice") or v164("Fist of Darkness") or v164("Sweet Chalice") or v164("Hallow Essence") or v164("Flower1") then
			return true
		end

		return false
	end
	WaitForHumanoid = function()
		local Character = LocalPlayer.Character

		if not Character then
			return nil
		end

		local Humanoid = Character:FindFirstChild("Humanoid")

		if Humanoid then
			return Humanoid
		end

		local v175 = tick() + 5
		local Humanoid2

		while true do
			if not (tick() < v175) then
				return nil
			end

			Humanoid2 = Character:FindFirstChild("Humanoid")

			if Humanoid2 then
				break
			end

			task.wait(0.1)
		end

		return Humanoid2
	end
	checkinventory = function(p46)
		if p46 then
			for _, v1 in pairs(ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
				if v1.Name == p46 then
					return true
				end
			end
		end

		return false
	end
	getdis = function(p47, p48)
		local CFrame_ = p48 or LocalPlayer.Character.HumanoidRootPart.CFrame

		return (CFrame.new(p47.X, CFrame_.Y, p47.Z).Position - CFrame.new(CFrame_.X, CFrame_.Y, CFrame_.Z).Position).Magnitude
	end
	CanBypassTeleport = function(p49)
		local Name = InArea(p49).Name

		if Name == "" then
			return false
		end

		if t11["Bypass Teleport"] and not Name:find("Dimension") then
			if not (Name:find("Submerged") or Name == "Sealed Cavern") then
				if not Name:lower():find("under") and not CheckLegendaryItems() then
					if LocalPlayer.Data and LocalPlayer.Data.LastSpawnPoint and LocalPlayer.Data.LastSpawnPoint.Value == "SubmergedIsland" then
						return false
					end

					if GetDistance(p49.Position) <= 3500 then
						return false
					end

					return true
				end
			end
		end

		return false
	end
	GetBypassCFrame = function(p50)
		local huge = math.huge
		local v182
		local children = workspace._WorldOrigin.PlayerSpawns.Pirates:GetChildren()
		local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return nil
		end

		for _, v1 in next, children, nil do
			if v1:FindFirstChild("Part") and (p50.Position - HumanoidRootPart.Position).Magnitude >= 3000 and GetSpawnPoint(v1.Part) ~= GetSpawnPoint(HumanoidRootPart) and (v1.Part.Position - HumanoidRootPart.Position).Magnitude <= 10000 and (v1.Part.Position - p50.Position).Magnitude <= huge then
				huge = (v1.Part.Position - p50.Position).Magnitude
				v182 = v1
			end
		end

		return v182
	end
	BypassTP = function(p51)
		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local v188 = WaitForHumanoid()

		if not v188 or v188.Health <= 0 then
			return
		end

		if CanBypassTeleport(p51) and GetBypassCFrame(p51) then
			local v189 = GetBypassCFrame(p51)

			if v189 and v189:FindFirstChild("Part") then
				Character.LastSpawnPoint.Disabled = true
				ReplicatedStorage.Remotes.CommF_:InvokeServer("SetLastSpawnPoint", v189.Name)
				ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
				Character:PivotTo(v189.Part.CFrame)
				v188:ChangeState(15)

				while true do
					task.wait()

					if not LocalPlayer.Character then
						continue
					end

					if WaitForHumanoid() and WaitForHumanoid().Health > 0 then
						break
					end
				end
			end
		end
	end
	totopofgreattree = function()
		if getdis(CFrame.new(28310.0234, 14895.1123, 109.456741)) > 1500 then
			ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28310.0234, 14895.1123, 109.456741))
			wait(0.3)
		end

		local cFrame3 = CFrame.new(28607.5352, 14896.5449, 106.011726)

		_tp(cFrame3)

		repeat
			wait()
		until getdis(cFrame3) <= 5

		wait(0.5)

		for i = 1, 4 do
			ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "TeleportBack")
		end
	end
	requestentrance = function(p52)
		local Position = p52

		if typeof(p52) == "CFrame" then
			Position = p52.Position
		end

		local t12

		if sea1 then
			t12 = {
				Sky3 = Vector3.new(-7894, 5547, -380),
				Sky3Exit = Vector3.new(-4607, 874, -1667),
				UnderWater = Vector3.new(61163, 11, 1819),
				["Underwater City"] = Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625),
				["Pirate Village"] = Vector3.new(-1242.4625244140625, 4.7870597839355469, 3901.282958984375),
				UnderwaterExit = Vector3.new(4050, -1, -1814)
			}
		elseif sea2 then
			t12 = {
				["Swan Mansion"] = Vector3.new(-390, 332, 673),
				["Swan Room"] = Vector3.new(2285, 15, 905),
				["Cursed Ship"] = Vector3.new(923, 126, 32852),
				["Zombie Island"] = Vector3.new(-6509, 83, -133)
			}
		else
			t12 = {
				["Hydra Island"] = Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625),
				Mansion = Vector3.new(-12462, 375, -7552),
				Castle = Vector3.new(-5036, 315, -3179),
				["Temple of Time"] = Vector3.new(28286, 14897, 103),
				["Greate Tree"] = Vector3.new(3024.1709, 2280.69434, -7325.12793)
			}

			if not checkinventory("Valkyrie Helm") then
				return
			end
		end

		local v194
		local huge = math.huge

		for _, v1 in pairs(t12) do
			local Magnitude = typeof(v1) == "Vector3" and (v1 - Position).Magnitude or (v1.Position - Position).Magnitude

			if Magnitude < huge then
				huge = Magnitude
				v194 = v1
			end
		end

		if v194 and huge and huge < getdis(p52) then
			pcall(function()
				if _G.TweenCache then
					_G.TweenCache:Cancel()
				end
			end)

			local ok = not (typeof(v194) == "Vector3" and v194.X == 3024.1709 and v194.Y == 2280.69434 and v194.Z == -7325.12793)

			if not ok then
				ok = not (ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Check") >= 2)
			end

			if ok then
				if huge < getdis(p52) then
					ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", typeof(v194) == "Vector3" and v194 or v194.Position)
					wait(1)
				end
			else
				totopofgreattree()
				wait(1)
			end
		end
	end
	_tp = function(p53)
		local cFrame3

		if typeof(p53) == "Vector3" then
			cFrame3 = CFrame.new(p53)
		elseif typeof(p53) == "CFrame" then
			cFrame3 = p53
		else
			cFrame3 = p53 and p53.CFrame
		end

		if not cFrame3 then
			return
		end

		if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
			return
		end

		local HumanoidRootPart = plr.Character.HumanoidRootPart

		getgenv().OnFarm = false
		pcall(function()
			if CanBypassTeleport(cFrame3) then
				BypassTP(cFrame3)
				task.wait(0.5)
			end
		end)
		pcall(function()
			requestentrance(p53)
		end)

		if sea3 then
			if getdis(cFrame3.Position, cFrame.Position) < 2000 then
				local HumanoidRootPart2 = plr.Character.HumanoidRootPart

				if math.abs(cFrame.Position.Y - HumanoidRootPart2.CFrame.Y) > 1000 then
					repeat
						task.wait()
						old_tp(cFrame2)

						if getdis(cFrame2) < 10 then
							local Net = ReplicatedStorage.Modules.Net

							Net["RF/SubmarineWorkerSpeak"]:InvokeServer("AskKilledTikiBoss")
							task.wait(0.5)
							Net["RF/SubmarineWorkerSpeak"]:InvokeServer("TravelToSubmergedIsland")
						end
					until getdis(cFrame3.Position) < 2000

					task.wait(0.6)
					pcall(function()
						if HumanoidRootPart2:FindFirstChild("BodyClip") then
							HumanoidRootPart2.BodyClip:Destroy()
						end
					end)
				end
			end
		end

		local Magnitude = (cFrame3.Position - HumanoidRootPart.Position).Magnitude
		local tweenInfo = TweenInfo.new(Magnitude / (Magnitude <= 15 and (getgenv().TweenSpeedNear or 180) or getgenv().TweenSpeedFar or 150), Enum.EasingStyle.Linear)
		local tween = game:GetService("TweenService"):Create(Part, tweenInfo, {
			CFrame = CFrame.new(cFrame3.Position)
		})

		if plr.Character.Humanoid.Sit == true then
			Part.CFrame = CFrame.new(Part.Position.X, cFrame3.Y, Part.Position.Z)
		end

		tween:Play()
		task.spawn(function()
			while tween.PlaybackState == Enum.PlaybackState.Playing do
				if shouldTween then
					task.wait(0.1)
				else
					tween:Cancel()

					break
				end
			end

			getgenv().OnFarm = true
		end)

		return tween
	end
end

old_tp = function(p54)
	if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
		plr.Character.HumanoidRootPart.CFrame = p54
	end
end
TeleportToTarget = function(p55)
	local v207 = _tp(p55)

	if v207 then
		v207.Completed:Wait()
	end

	task.wait(0.1)
end
notween = function(p56)
	plr.Character.HumanoidRootPart.CFrame = p56
end

do
	BTP = function(p57)
		local LocalPlayer = game.Players.LocalPlayer
		local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
		local Humanoid = LocalPlayer.Character.Humanoid
		local Main = LocalPlayer.PlayerGui.Main
		local Position = HumanoidRootPart.Position

		repeat
			Humanoid.Health = 0
			HumanoidRootPart.CFrame = p57
			Main.Quest.Visible = false

			if (HumanoidRootPart.Position - Position).Magnitude > 1 then
				Position = HumanoidRootPart.Position
				HumanoidRootPart.CFrame = p57
			end

			task.wait(0.5)
		until (p57.Position - HumanoidRootPart.Position).Magnitude <= 2000
	end
end

do
	spawn(function()
		while task.wait() do
			pcall(function()
				if _G.Auto_StartRaid or _G.SailBoat_Hydra or _G.WardenBoss or _G.AutoFactory or _G.HighestMirage or _G.HCM or _G.PGB or _G.Leviathan1 or _G.UPGDrago or _G.Complete_Trials or _G.TpDrago_Prehis or _G.BuyDrago or _G.AutoFireFlowers or _G.DT_Uzoth or _G.AutoBerry or _G.Prefully or _G.Prehis_Find or _G.Prehis_Skills or _G.Prehis_DB or _G.Prehis_DE or _G.FarmBlazeEM or _G.Dojoo or _G.CollectPresent or _G.AutoLawKak or _G.TpLab or _G.AutoPhoenixF or _G.AutoFarmChest or _G.AutoHytHallow or _G.LongsWord or _G.BlackSpikey or _G.AutoHolyTorch or _G.TrainDrago or _G.AutoSaber or _G.FarmMastery_Dev or _G.CitizenQuest or _G.AutoEctoplasm or _G.KeysRen or _G.Auto_Rainbow_Haki or _G.obsFarm or _G.AutoBigmom or _G.Doughv2 or _G.AuraBoss or _G.Raiding or _G.Auto_Cavender or _G.TpPly or _G.Bartilo_Quest or _G.Level or _G.FarmEliteHunt or _G.AutoZou or _G.AutoFarm_Bone or getgenv().AutoMaterial or _G.CraftVM or _G.FrozenTP or _G.TPDoor or _G.AcientOne or _G.AutoFarmNear or _G.AutoRaidCastle or _G.DarkBladev3 or _G.AutoFarmRaid or _G.Auto_Cake_Prince or _G.Addealer or _G.TPNpc or _G.TwinHook or _G.FindMirage or _G.FarmChestM or _G.Shark or _G.TerrorShark or _G.Piranha or _G.MobCrew or _G.SeaBeast1 or _G.FishBoat or _G.AutoPole or _G.AutoPoleV2 or _G.Auto_SuperHuman or _G.AutoDeathStep or _G.Auto_SharkMan_Karate or _G.Auto_Electric_Claw or _G.AutoDragonTalon or _G.Auto_Def_DarkCoat or _G.Auto_God_Human or _G.Auto_Tushita or _G.AutoMatSoul or _G.AutoKenVTWO or _G.AutoSerpentBow or _G.AutoFMon or _G.Auto_Soul_Guitar or _G.TPGEAR or _G.AutoSaw or _G.AutoTridentW2 or _G.AutoEvoRace or _G.AutoGetQuestBounty or _G.MarinesCoat or _G.TravelDres or _G.Defeating or _G.DummyMan or _G.Auto_Yama or _G.Auto_SwanGG or _G.SwanCoat or _G.AutoEcBoss or _G.Auto_Mink or _G.Auto_Human or _G.Auto_Skypiea or _G.Auto_Fish or _G.CDK_TS or _G.CDK_YM or _G.CDK or _G.AutoFarmGodChalice or _G.AutoFistDarkness or _G.AutoMiror or _G.Teleport or _G.AutoKilo or _G.AutoGetUsoap or _G.Praying or _G.TryLucky or _G.AutoColShad or _G.AutoUnHaki or _G.Auto_DonAcces or _G.AutoRipIngay or _G.DragoV3 or _G.DragoV1 or _G.SailBoats or NextIs or _G.FarmGodChalice or _G.IceBossRen or senth or senth2 or _G.Lvthan or _G.beasthunter or _G.DangerLV or _G.Relic123 or _G.tweenKitsune or _G.Collect_Ember or _G.AutofindKitIs or _G.snaguine or _G.TwFruits or _G.tweenKitShrine or _G.Tp_LgS or _G.Tp_MasterA or _G.tweenShrine or _G.FarmMastery_G or _G.FarmMastery_S or _G.FarmBoss or _G.AutoFarmAllBoss or _G.AutoFishSlap or _G.FarmTyrant or _G.FarmPhaBinh or _G.AutoSpawnCP or _G.AutoBerryH or _G.AutoChestBP or _G.FarmEliteHop or _G.AutoHop_Dough or _G.AutoDoughKing or _G.AutoAttackDoughKing or _G.StartEvent or _G.AutoMysticIsland or _G.AutoPlayerHunter or _G.SafeMode or _G.AutoKillMob or _G.AutoStartPrehistoric or _G.AutoUnHaki or _G.AutoAttackRipIndra or _G.AutoFarmIsland or _G.AutoFarmDungeon or _G.AutoFarmCandy or _G.AutoTP_Gift or _G.AutoTPGift or _G.AutoTPAndCollect or _G.MasterAutoLevel or _G.MasterAutoCandy or _G.TPFloor1 or _G.TPFloor2 or _G.TPFloor3 or _G.TPFloor4 or _G.AutoMagnetToken then
					shouldTween = true

					if not plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
						local BodyVelocity = Instance.new("BodyVelocity")

						BodyVelocity.Name = "BodyClip"
						BodyVelocity.Parent = plr.Character.HumanoidRootPart
						BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
						BodyVelocity.Velocity = Vector3.new(0, 0, 0)
					end

					if not plr.Character:FindFirstChild("highlight") then
						local Highlight = Instance.new("Highlight")

						Highlight.Name = "highlight"
						Highlight.Enabled = true
						Highlight.FillColor = Color3.fromRGB(0, 255, 254)
						Highlight.OutlineColor = Color3.fromRGB(0, 255, 254)
						Highlight.FillTransparency = 0.5
						Highlight.OutlineTransparency = 0.2
						Highlight.Parent = plr.Character
					end

					for _, descendant in pairs(plr.Character:GetDescendants()) do
						if descendant:IsA("BasePart") then
							descendant.CanCollide = false
						end
					end
				else
					shouldTween = false

					if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
						plr.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
					end

					if plr.Character:FindFirstChild("highlight") then
						plr.Character:FindFirstChild("highlight"):Destroy()
					end
				end
			end)
		end
	end)
end

QuestB = function()
	if World1 then
		if _G.FindBoss == "The Gorilla King" then
			bMon = "The Gorilla King"
			Qname = "JungleQuest"
			Qdata = 3
			PosQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
			PosB = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)
		elseif _G.FindBoss == "Bobby" then
			bMon = "Bobby"
			Qname = "BuggyQuest1"
			Qdata = 3
			PosQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
			PosB = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
		elseif _G.FindBoss == "The Saw" then
			bMon = "The Saw"
			PosB = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
		elseif _G.FindBoss == "Yeti" then
			bMon = "Yeti"
			Qname = "SnowQuest"
			Qdata = 3
			PosQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
			PosB = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
		elseif _G.FindBoss == "Mob Leader" then
			bMon = "Mob Leader"
			PosB = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
		elseif _G.FindBoss == "Vice Admiral" then
			bMon = "Vice Admiral"
			Qname = "MarineQuest2"
			Qdata = 2
			PosQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)
			PosB = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
		elseif _G.FindBoss == "Saber Expert" then
			bMon = "Saber Expert"
			PosB = CFrame.new(-1458.89502, 29.8870335, -50.633564)
		elseif _G.FindBoss == "Warden" then
			bMon = "Warden"
			Qname = "ImpelQuest"
			Qdata = 1
			PosB = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, -4.49946401e-06, 0.975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, 0.220546961)
			PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
		elseif _G.FindBoss == "Chief Warden" then
			bMon = "Chief Warden"
			Qname = "ImpelQuest"
			Qdata = 2
			PosB = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939)
			PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
		elseif _G.FindBoss == "Swan" then
			bMon = "Swan"
			Qname = "ImpelQuest"
			Qdata = 3
			PosB = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812)
			PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
		elseif _G.FindBoss == "Magma Admiral" then
			bMon = "Magma Admiral"
			Qname = "MagmaQuest"
			Qdata = 3
			PosQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)
			PosB = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
		elseif _G.FindBoss == "Fishman Lord" then
			bMon = "Fishman Lord"
			Qname = "FishmanQuest"
			Qdata = 3
			PosQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
			PosB = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
		elseif _G.FindBoss == "Wysper" then
			bMon = "Wysper"
			Qname = "SkyExp1Quest"
			Qdata = 3
			PosQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)
			PosB = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
		elseif _G.FindBoss == "Thunder God" then
			bMon = "Thunder God"
			Qname = "SkyExp2Quest"
			Qdata = 3
			PosQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
			PosB = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
		elseif _G.FindBoss == "Cyborg" then
			bMon = "Cyborg"
			Qname = "FountainQuest"
			Qdata = 3
			PosQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
			PosB = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
		elseif _G.FindBoss == "Ice Admiral" then
			bMon = "Ice Admiral"
			Qdata = nil
			PosQBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
			PosB = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
		elseif _G.FindBoss == "Greybeard" then
			bMon = "Greybeard"
			Qdata = nil
			PosQBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
			PosB = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
		end
	end

	if World2 then
		if _G.FindBoss == "Diamond" then
			bMon = "Diamond"
			Qname = "Area1Quest"
			Qdata = 3
			PosQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)
			PosB = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
		elseif _G.FindBoss == "Jeremy" then
			bMon = "Jeremy"
			Qname = "Area2Quest"
			Qdata = 3
			PosQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
			PosB = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
		elseif _G.FindBoss == "Orbitus" then
			bMon = "Orbitus"
			Qname = "MarineQuest3"
			Qdata = 3
			PosQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)
			PosB = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
		elseif _G.FindBoss == "Don Swan" then
			bMon = "Don Swan"
			PosB = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
		elseif _G.FindBoss == "Smoke Admiral" then
			bMon = "Smoke Admiral"
			Qname = "IceSideQuest"
			Qdata = 3
			PosQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
			PosB = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
		elseif _G.FindBoss == "Awakened Ice Admiral" then
			bMon = "Awakened Ice Admiral"
			Qname = "FrostQuest"
			Qdata = 3
			PosQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)
			PosB = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
		elseif _G.FindBoss == "Tide Keeper" then
			bMon = "Tide Keeper"
			Qname = "ForgottenQuest"
			Qdata = 3
			PosQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)
			PosB = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
		elseif _G.FindBoss == "Darkbeard" then
			bMon = "Darkbeard"
			Qdata = nil
			PosQBoss = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
			PosB = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
		elseif _G.FindBoss == "Cursed Captain" then
			bMon = "Cursed Captain"
			Qdata = nil
			PosQBoss = CFrame.new(916.928589, 181.092773, 33422)
			PosB = CFrame.new(916.928589, 181.092773, 33422)
		elseif _G.FindBoss == "Order" then
			bMon = "Order"
			Qdata = nil
			PosQBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
			PosB = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
		end
	end

	if World3 then
		if _G.FindBoss == "Stone" then
			bMon = "Stone"
			Qname = "PiratePortQuest"
			Qdata = 3
			PosQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)
			PosB = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
		elseif _G.FindBoss == "Hydra Leader" then
			bMon = "Hydra Leader"
			Qname = "VenomCrewQuest"
			Qdata = 3
			PosQBoss = CFrame.new(5211.021484375, 1004.35778859375, 758.18475341796875)
			PosB = CFrame.new(5821.89794921875, 1019.0950927734375, -73.719230651855469)
		elseif _G.FindBoss == "Kilo Admiral" then
			bMon = "Kilo Admiral"
			Qname = "MarineTreeIsland"
			Qdata = 3
			PosQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)
			PosB = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
		elseif _G.FindBoss == "Captain Elephant" then
			bMon = "Captain Elephant"
			Qname = "DeepForestIsland"
			Qdata = 3
			PosQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)
			PosB = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
		elseif _G.FindBoss == "Beautiful Pirate" then
			bMon = "Beautiful Pirate"
			Qname = "DeepForestIsland2"
			Qdata = 3
			PosQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
			PosB = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
		elseif _G.FindBoss == "Cake Queen" then
			bMon = "Cake Queen"
			Qname = "IceCreamIslandQuest"
			Qdata = 3
			PosQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
			PosB = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, -0.417492568, 0.0167988986, -0.90852499)
		elseif _G.FindBoss == "Longma" then
			bMon = "Longma"
			Qdata = nil
			PosQBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
			PosB = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
		elseif _G.FindBoss == "Soul Reaper" then
			bMon = "Soul Reaper"
			Qdata = nil
			PosQBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
			PosB = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
		end
	end
end
QuestBeta = function()
	QuestB()

	return {
		[0] = _G.FindBoss,
		bMon,
		Qdata,
		Qname,
		PosB,
		PosQBoss
	}
end

do
	local Quests = require(game:GetService("ReplicatedStorage"):WaitForChild("Quests"))
	local GuideModule = require(game:GetService("ReplicatedStorage"):WaitForChild("GuideModule"))
	local t13 = {
		"MarineQuest",
		"BartiloQuest",
		"CitizenQuest",
		"Trainees"
	}

	CheckSea = function(p58)
		if (game.PlaceId == 2753915549 or game.PlaceId == 85211729168715) and p58 == 1 then
			return true
		end

		if (game.PlaceId == 4442272183 or game.PlaceId == 79091703265657) and p58 == 2 then
			return true
		end

		if (game.PlaceId == 7449423635 or game.PlaceId == 100117331123089) and p58 == 3 then
			return true
		end

		return false
	end
	GetQuestPointFromNPC = function(p59)
		for _, child in pairs(workspace.NPCs:GetChildren()) do
			if child.Name == p59 and child:FindFirstChild("HumanoidRootPart") then
				return child.HumanoidRootPart.CFrame
			end
		end

		for _, child in pairs(replicated.NPCs:GetChildren()) do
			if child.Name == p59 and child:FindFirstChild("HumanoidRootPart") then
				return child.HumanoidRootPart.CFrame
			end
		end

		return nil
	end
	GetQuests = function()
		local Value = plr.Data.Level.Value
		local n1 = 0
		local t14 = {}

		if Value >= 700 and CheckSea(1) then
			t14.Mob = "Galley Captain"
			t14.NameQuest = "FountainQuest"
			t14.ID = 2
			t14.LevelReq = 700
		elseif Value >= 1500 and CheckSea(2) then
			t14.Mob = "Water Fighter"
			t14.NameQuest = "ForgottenQuest"
			t14.ID = 2
			t14.LevelReq = 1450
		else
			for k, Quest in pairs(Quests) do
				for k2, v1 in pairs(Quest) do
					local LevelReq = v1.LevelReq

					for k3 in pairs(v1.Task) do
						if LevelReq <= Value and n1 <= LevelReq and v1.Task[k3] > 1 then
							if not table.find(t13, k) then
								n1 = LevelReq
								t14.Mob = k3
								t14.NameQuest = k
								t14.ID = k2
								t14.LevelReq = LevelReq
							end
						end
					end
				end
			end
		end

		return t14
	end
	GetQuestPoint = function()
		if GuideModule and GuideModule.Data then
			if GuideModule.Data.LastClosestNPC then
				return GetQuestPointFromNPC(GuideModule.Data.LastClosestNPC)
			end
		end

		return nil
	end
end

MaterialMon = function()
	local LocalPlayer = game.Players.LocalPlayer
	local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	shouldRequestEntrance = function(p60, p61)
		if p61 <= (HumanoidRootPart.Position - p60).Magnitude then
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", p60)
		end
	end

	if World1 then
		if SelectMaterial == "Angel Wings" then
			MMon = {
				"Shanda",
				"Royal Squad",
				"Royal Soldier",
				"Wysper",
				"Thunder God"
			}
			MPos = CFrame.new(-4698, 845, -1912)
			SP = "Default"
			shouldRequestEntrance(Vector3.new(-4607.82275, 872.54248, -1667.55688), 10000)
		elseif SelectMaterial == "Leather + Scrap Metal" then
			MMon = {
				"Brute",
				"Pirate"
			}
			MPos = CFrame.new(-1145, 15, 4350)
			SP = "Default"
		elseif SelectMaterial == "Magma Ore" then
			MMon = {
				"Military Soldier",
				"Military Spy",
				"Magma Admiral"
			}
			MPos = CFrame.new(-5815, 84, 8820)
			SP = "Default"
		elseif SelectMaterial == "Fish Tail" then
			MMon = {
				"Fishman Warrior",
				"Fishman Commando",
				"Fishman Lord"
			}
			MPos = CFrame.new(61123, 19, 1569)
			SP = "Default"
			shouldRequestEntrance(Vector3.new(61163.8515625, 5.3423423767089844, 1819.7841796875), 17000)
		end
	elseif World2 then
		if SelectMaterial == "Leather + Scrap Metal" then
			MMon = { "Marine Captain" }
			MPos = CFrame.new(-2010.5059814453125, 73.00115966796875, -3326.620849609375)
			SP = "Default"
		elseif SelectMaterial == "Magma Ore" then
			MMon = {
				"Magma Ninja",
				"Lava Pirate"
			}
			MPos = CFrame.new(-5428, 78, -5959)
			SP = "Default"
		elseif SelectMaterial == "Ectoplasm" then
			MMon = {
				"Ship Deckhand",
				"Ship Engineer",
				"Ship Steward",
				"Ship Officer"
			}
			MPos = CFrame.new(911.35827636719, 125.95812988281, 33159.5390625)
			SP = "Default"
			shouldRequestEntrance(Vector3.new(61163.8515625, 5.3423423767089844, 1819.7841796875), 18000)
		elseif SelectMaterial == "Mystic Droplet" then
			MMon = { "Water Fighter" }
			MPos = CFrame.new(-3385, 239, -10542)
			SP = "Default"
		elseif SelectMaterial == "Radioactive Material" then
			MMon = { "Factory Staff" }
			MPos = CFrame.new(295, 73, -56)
			SP = "Default"
		elseif SelectMaterial == "Vampire Fang" then
			MMon = { "Vampire" }
			MPos = CFrame.new(-6033, 7, -1317)
			SP = "Default"
		end
	elseif World3 then
		if SelectMaterial == "Scrap Metal" then
			MMon = {
				"Jungle Pirate",
				"Forest Pirate"
			}
			MPos = CFrame.new(-11975.78515625, 331.77340698242188, -10620.0302734375)
			SP = "Default"
		elseif SelectMaterial == "Fish Tail" then
			MMon = {
				"Fishman Raider",
				"Fishman Captain"
			}
			MPos = CFrame.new(-10993, 332, -8940)
			SP = "Default"
		elseif SelectMaterial == "Conjured Cocoa" then
			MMon = {
				"Chocolate Bar Battler",
				"Cocoa Warrior"
			}
			MPos = CFrame.new(620.63446044921875, 78.936447143554688, -12581.369140625)
			SP = "Default"
		elseif SelectMaterial == "Dragon Scale" then
			MMon = {
				"Dragon Crew Archer",
				"Dragon Crew Warrior"
			}
			MPos = CFrame.new(6594, 383, 139)
			SP = "Default"
		elseif SelectMaterial == "Gunpowder" then
			MMon = { "Pistol Billionaire" }
			MPos = CFrame.new(-84.855690002441406, 85.620613098144531, 6132.0087890625)
			SP = "Default"
		elseif SelectMaterial == "Mini Tusk" then
			MMon = { "Mythological Pirate" }
			MPos = CFrame.new(-13545, 470, -6917)
			SP = "Default"
		elseif SelectMaterial == "Demonic Wisp" then
			MMon = { "Demonic Soul" }
			MPos = CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)
			SP = "Default"
		end
	end
end

do
	QuestNeta = function()
		local v235 = GetQuests()

		return {
			v235.Mob,
			v235.ID,
			v235.NameQuest,
			v235.LevelReq,
			v235.Mob,
			(GetQuestPoint())
		}
	end
end

local lib = (function()
if getgenv().Nousigi then
	for i, v in ipairs(game.CoreGui:GetChildren()) do
		pcall(function()
			if v:IsA("ScreenGui") and v.Name ~= "RobloxGui" and (
				string.find(v.Name, "Meizu Hub") or
				string.find(v.Name, "Banana") or
				string.find(v.Name, "Night Slayer") or
				string.find(v.Name, "Redz") or
				string.find(v.Name, "Killua Hub")
			) then
				v:Destroy()
			end
		end)
	end
end
getgenv().Nousigi = true
getgenv().MeizuHubVersion = 114

local DisableAnimation = game.Players.LocalPlayer.PlayerGui:FindFirstChild('TouchGui')
local T1UIColor = {
	["Border Color"] = Color3.fromRGB(56, 132, 255),
	["Click Effect Color"] = Color3.fromRGB(230, 230, 230),
	["Setting Icon Color"] = Color3.fromRGB(230, 230, 230),
	["Logo Image"] = "rbxassetid://5009915795",
	["Search Icon Color"] = Color3.fromRGB(240, 240, 230),
	["Search Icon Highlight Color"] = Color3.fromRGB(56, 132, 255),
	["GUI Text Color"] = Color3.fromRGB(246, 247, 255),
	["Text Color"] = Color3.fromRGB(242, 244, 255),
	["Placeholder Text Color"] = Color3.fromRGB(158, 164, 185),
	["Title Text Color"] = Color3.fromRGB(56, 132, 255),
	["Background Main Color"] = Color3.fromRGB(8, 8, 13),
	["Background 1 Color"] = Color3.fromRGB(16, 17, 24),
	["Background 1 Transparency"] = 0.3,
	["Background 2 Color"] = Color3.fromRGB(22, 24, 34),
	["Background 3 Color"] = Color3.fromRGB(28, 30, 42),
	["Background Image"] = "",
	["Page Selected Color"] = Color3.fromRGB(56, 132, 255),
	["Section Text Color"] = Color3.fromRGB(242, 244, 255),
	["Section Underline Color"] = Color3.fromRGB(56, 132, 255),
	["Toggle Border Color"] = Color3.fromRGB(56, 132, 255),
	["Toggle Checked Color"] = Color3.fromRGB(230, 230, 230),
	["Toggle Desc Color"] = Color3.fromRGB(167, 174, 196),
	["Button Color"] = Color3.fromRGB(56, 132, 255),
	["Label Color"] = Color3.fromRGB(22, 24, 34),
	["Dropdown Icon Color"] = Color3.fromRGB(230, 230, 230),
	["Dropdown Selected Color"] = Color3.fromRGB(56, 132, 255),
	["Dropdown Selected Check Color"] = Color3.fromRGB(30, 90, 200),
	["Textbox Highlight Color"] = Color3.fromRGB(56, 132, 255),
	["Box Highlight Color"] = Color3.fromRGB(56, 132, 255),
	["Slider Line Color"] = Color3.fromRGB(56, 132, 255),
	["Slider Highlight Color"] = Color3.fromRGB(30, 90, 200),
	["Tween Animation 1 Speed"] = DisableAnimation and 0 or 0.15,
	["Tween Animation 2 Speed"] = DisableAnimation and 0 or 0.25,
	["Tween Animation 3 Speed"] = DisableAnimation and 0 or 0.08,
	["Text Stroke Transparency"] = 0.5
}

getgenv().UIColor = T1UIColor
getgenv().AllControls = {}
getgenv().UIToggled = false

-- ===== Killua custom icon (hide-button = round, header logo = square) =====
getgenv().KilluaIconRoundUrl = "https://p16-flow-file-sign.ibyteimg.com/tos-mya-i-u8dpqn1f20/rc/pc/super_tool/00a49c15a79549d7b884d9ed6cc80146.png?rcl=202610172337041FAF492263436E3B4434&rk3s=8e244e95&rrcfp=f512b60b&x-expires=1792856341&x-signature=1xBnaswdUsSY9rcauXA3az4fJIg%3D"
getgenv().KilluaIconSquareUrl = "https://p16-flow-file-sign.ibyteimg.com/tos-mya-i-u8dpqn1f20/rc/pc/super_tool/ad7e25dd88844885a6acff637d2380a1.png?rcl=202610172337041FAF492263436E3B4434&rk3s=8e244e95&rrcfp=f512b60b&x-expires=1792856341&x-signature=%2B7%2FSiApKXa5oJ3ZhAX9p59HyRnk%3D"
local function _loadAsset(url, fname)
	local ok, res = pcall(function()
		local data = game:HttpGet(url)
		if not data or #data < 2000 then return nil end
		if writefile then
			pcall(writefile, fname, data)
			local gsa = getsynasset or getcustomasset
			if gsa then
				local asset = gsa(fname)
				if asset and asset ~= "" then return asset end
			end
		end
		return nil
	end)
	if ok and res then return res end
	return nil
end
getgenv().KilluaAsset = _loadAsset(getgenv().KilluaIconRoundUrl, "meizu_killua_round.png") or "rbxassetid://5009915795"
getgenv().KilluaLogoAsset = _loadAsset(getgenv().KilluaIconSquareUrl, "meizu_killua_square.png") or getgenv().KilluaAsset
-- Header logo uses the square framed icon
getgenv().UIColor["Logo Image"] = getgenv().KilluaLogoAsset

-- ===== Theme accent color system (live recolor) =====
getgenv().AccentColor = Color3.fromRGB(56, 132, 255)
getgenv().AccentDark = Color3.fromRGB(30, 90, 200)
getgenv().SetThemeAccent = function(r, g, b)
	r = tonumber(r) or 56; g = tonumber(g) or 132; b = tonumber(b) or 255
	local old = getgenv().AccentColor
	local oldDark = getgenv().AccentDark
	local newC = Color3.fromRGB(r, g, b)
	local dr = math.clamp(math.floor(r * 0.55), 0, 255)
	local dg = math.clamp(math.floor(g * 0.55), 0, 255)
	local db = math.clamp(math.floor(b * 0.55), 0, 255)
	local newDark = Color3.fromRGB(dr, dg, db)
	getgenv().AccentColor = newC
	getgenv().AccentDark = newDark
	local uc = getgenv().UIColor
	local accentKeys = {"Border Color","Search Icon Highlight Color","Title Text Color","Page Selected Color","Section Underline Color","Toggle Border Color","Button Color","Dropdown Selected Color","Textbox Highlight Color","Box Highlight Color","Slider Line Color"}
	for _, k in ipairs(accentKeys) do uc[k] = newC end
	uc["Dropdown Selected Check Color"] = newDark
	uc["Slider Highlight Color"] = newDark
	local gui = game.CoreGui:FindFirstChild("Killua Hub GUI")
	if gui then
		for _, obj in ipairs(gui:GetDescendants()) do
			pcall(function()
				if obj:IsA("UIStroke") then
					if obj.Color == old then obj.Color = newC elseif obj.Color == oldDark then obj.Color = newDark end
				elseif obj:IsA("TextLabel") then
					if obj.TextColor3 == old then obj.TextColor3 = newC elseif obj.TextColor3 == oldDark then obj.TextColor3 = newDark end
					if obj.BackgroundColor3 == old then obj.BackgroundColor3 = newC elseif obj.BackgroundColor3 == oldDark then obj.BackgroundColor3 = newDark end
				elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
					if obj.ImageColor3 == old then obj.ImageColor3 = newC elseif obj.ImageColor3 == oldDark then obj.ImageColor3 = newDark end
					if obj.BackgroundColor3 == old then obj.BackgroundColor3 = newC elseif obj.BackgroundColor3 == oldDark then obj.BackgroundColor3 = newDark end
				elseif obj:IsA("Frame") or obj:IsA("TextButton") or obj:IsA("TextBox") or obj:IsA("ScrollingFrame") then
					if obj.BackgroundColor3 == old then obj.BackgroundColor3 = newC elseif obj.BackgroundColor3 == oldDark then obj.BackgroundColor3 = newDark end
				end
			end)
		end
	end
	pcall(function() if getgenv().BtnHideStroke then getgenv().BtnHideStroke.Color = newC end end)
end

-- ===== Vietnamese UI translation (runtime text patch) =====
getgenv().ViDict = {
	["Accept Allies"] = "Chấp nhận đồng minh",
	["Accept Quests"] = "Nhận nhiệm vụ",
	["Accept Rainbow Quest Faster"] = "Hoàn thành nhiệm vụ Rainbow nhanh hơn",
	["Accessory"] = "Phụ kiện",
	["Aimbot - Skills : False"] = "Aimbot - Kỹ năng : Tắt",
	["Aimbot - Skills : True"] = "Aimbot - Kỹ năng : Bật",
	["Aimbot Camera Closet Players"] = "Aimbot camera về người chơi gần nhất",
	["Aimbot Method Skills"] = "Phương pháp kỹ năng AimBot",
	["Anti AFK"] = "Chống AFK",
	["Auto Anti - Admin Join Server"] = "Tự động tránh Admin vào server",
	["Auto Attack Fish Boat"] = "Tự động tấn công thuyền cá",
	["Auto Attack Leviathan"] = "Tự động tấn công Leviathan",
	["Auto Attack PirateGrandBrigade"] = "Tự động tấn công Pirate Grand Brigade",
	["Auto Attack Rip Indra"] = "Tự động tấn công Rip Indra",
	["Auto Attack Sea Beast"] = "Tự động tấn công Sea Beast",
	["Auto Awakening"] = "Tự động thức tỉnh",
	["Auto Bigmom"] = "Tự động farm Bigmom",
	["Auto Bisento V2"] = "Tự động lấy Bisento V2",
	["Auto Black Spikey"] = "Tự động lấy Black Spikey",
	["Auto Blox Fruit"] = "Tự động dùng Trái",
	["Auto Buy Bait"] = "Tự động mua mồi câu",
	["Auto Buy Chip [Beli]"] = "Tự động mua chip [Beli]",
	["Auto Buy Chip [Devil Fruit]"] = "Tự động mua chip [Devil Fruit]",
	["Auto Buy Fruit Shop"] = "Tự động mua ở cửa hàng Trái",
	["Auto Buy Microchip Law"] = "Tự động mua Microchip Law",
	["Auto Canvendish Sword"] = "Tự động lấy kiếm Cavendish",
	["Auto Chest Bypass"] = "Tự động mở rương (vượt qua)",
	["Auto Collect Azure Ember"] = "Tự động nhặt Azure Ember",
	["Auto Collect Dino Bones"] = "Tự động nhặt xương khủng long",
	["Auto Collect Dragon Eggs"] = "Tự động nhặt trứng rồng",
	["Auto Collect Fruit"] = "Tự động nhặt Trái",
	["Auto Collect Gear"] = "Tự động nhặt Gear",
	["Auto Collect Mirage Chest"] = "Tự động nhặt rương Mirage",
	["Auto Complete Quest"] = "Tự động hoàn thành nhiệm vụ",
	["Auto Complete Trial Race"] = "Tự động hoàn thành thử thách chủng tộc",
	["Auto Cybrog"] = "Tự động lấy Cyborg",
	["Auto Dark Blade V3"] = "Tự động lấy Dark Blade V3",
	["Auto Darkbeard"] = "Tự động farm Darkbeard",
	["Auto DeathStep"] = "Tự động lấy Death Step",
	["Auto Defense"] = "Tự động phòng thủ",
	["Auto Dojo Trainer"] = "Tự động luyện Dojo",
	["Auto Done Bartilo Quest"] = "Tự động hoàn thành nhiệm vụ Bartilo",
	["Auto Done Citizen Quest"] = "Tự động hoàn thành nhiệm vụ Citizen",
	["Auto Dough King [Fully]"] = "Tự động Dough King [Đầy đủ]",
	["Auto Drago (V1)"] = "Tự động Drago (V1)",
	["Auto Drago (V2)"] = "Tự động Drago (V2)",
	["Auto Drago (V3)"] = "Tự động Drago (V3)",
	["Auto Dragon Hunter"] = "Tự động farm Dragon Hunter",
	["Auto Dragon Trident"] = "Tự động lấy Dragon Trident",
	["Auto DragonTalon"] = "Tự động lấy Dragon Talon",
	["Auto Drive To Hydra Island"] = "Tự động lái thuyền đến đảo Hydra",
	["Auto Drop Fruit"] = "Tự động thả Trái",
	["Auto ElectricClaw"] = "Tự động lấy Electric Claw",
	["Auto Enable PvP"] = "Tự động bật PvP",
	["Auto Factory Raid"] = "Tự động đột kích nhà máy",
	["Auto Farm All Boss"] = "Tự động farm tất cả Boss",
	["Auto Farm All Island"] = "Tự động farm tất cả đảo",
	["Auto Farm Berry"] = "Tự động farm Berry",
	["Auto Farm Berry + Hop"] = "Farm Berry + đổi server",
	["Auto Farm Bone"] = "Tự động farm xương",
	["Auto Farm Boss"] = "Tự động farm Boss",
	["Auto Farm Boss TOTS"] = "Tự động farm Boss TOTS",
	["Auto Farm Cake Prince"] = "Tự động farm Cake Prince",
	["Auto Farm Chest"] = "Tự động farm rương",
	["Auto Farm Dough King"] = "Tự động farm Dough King",
	["Auto Farm Dough King + Hop"] = "Farm Dough King + đổi server",
	["Auto Farm Dungeon"] = "Tự động farm Dungeon",
	["Auto Farm Ectoplasm"] = "Tự động farm Ectoplasm",
	["Auto Farm Elite"] = "Tự động farm Elite",
	["Auto Farm Elite + Hop"] = "Farm Elite + đổi server",
	["Auto Farm Level"] = "Tự động farm Level",
	["Auto Farm Magnet Token"] = "Tự động farm Magnet Token",
	["Auto Farm Material Skull Guitar"] = "Tự động farm vật phẩm Skull Guitar",
	["Auto Farm Materials"] = "Tự động farm nguyên liệu",
	["Auto Farm Nearest"] = "Tự động farm quái gần nhất",
	["Auto Farm Observation"] = "Tự động farm Quan sát",
	["Auto Find Kitsune Island"] = "Tự động tìm Đảo Kitsune",
	["Auto Find Mirage Island"] = "Tự động tìm Đảo Mirage",
	["Auto Find Prehistoric Island"] = "Tự động tìm Đảo Tiền sử",
	["Auto Fish Crew Member"] = "Tự động farm Fish Crew Member",
	["Auto Fishing"] = "Tự động câu cá",
	["Auto Get CDK [ Last Quest ]"] = "Tự động lấy CDK [Nhiệm vụ cuối]",
	["Auto Get PlayerQuest"] = "Tự động lấy nhiệm vụ người chơi",
	["Auto Godhuman"] = "Tự động lấy Godhuman",
	["Auto Gun"] = "Tự động dùng súng",
	["Auto Haki Observation"] = "Tự động Haki Quan sát",
	["Auto Haunted Crew Member"] = "Tự động farm Haunted Crew Member",
	["Auto Hop Server with time"] = "Tự động đổi server theo thời gian",
	["Auto Key Rengoku"] = "Tự động lấy chìa khóa Rengoku",
	["Auto Kill Law"] = "Tự động giết Law",
	["Auto Kill Mob"] = "Tự động giết quái",
	["Auto Kill Player After Trial"] = "Tự động giết người chơi sau thử thách",
	["Auto Kill Player Quest"] = "Tự động giết người chơi theo nhiệm vụ",
	["Auto Lei Accessory"] = "Tự động lấy phụ kiện Lei",
	["Auto Long Sword"] = "Tự động lấy Long Sword",
	["Auto Look At Moon"] = "Tự động nhìn mặt trăng",
	["Auto Marine Coat"] = "Tự động lấy áo Hải quân",
	["Auto Mastery All Sword"] = "Tự động luyện kiếm",
	["Auto Mastery Fruits"] = "Tự động luyện Trái",
	["Auto Mastery Gun"] = "Tự động luyện súng",
	["Auto Melee"] = "Tự động đánh cận chiến",
	["Auto Midnight Blade"] = "Tự động lấy Midnight Blade",
	["Auto Observation V2"] = "Tự động lấy Quan sát V2",
	["Auto Patch Prehistoric Event"] = "Tự động vá sự kiện Tiền sử",
	["Auto Piranha"] = "Tự động farm Piranha",
	["Auto Pirate Raid"] = "Tự động đột kích Hải tặc",
	["Auto Pole V1"] = "Tự động lấy Pole V1",
	["Auto Pole V2 [Beta]"] = "Tự động lấy Pole V2 [Beta]",
	["Auto Pray Gravestone"] = "Tự động cầu nguyện tại bia mộ",
	["Auto Press W"] = "Tự động nhấn W",
	["Auto Pull Lever"] = "Tự động kéo cần",
	["Auto Quest Fishing"] = "Tự động nhiệm vụ câu cá",
	["Auto Quest Sea 2"] = "Tự động nhiệm vụ Biển 2",
	["Auto Quest Sea 3"] = "Tự động nhiệm vụ Biển 3",
	["Auto Raid + Next Island"] = "Đột kích + sang đảo tiếp theo",
	["Auto Rainbow Colors"] = "Tự động đổi màu cầu vồng",
	["Auto Random Bones"] = "Tự động xương ngẫu nhiên",
	["Auto Random Fruit"] = "Tự động quay Trái ngẫu nhiên",
	["Auto Relic Drago Trial [Beta]"] = "Tự động Relic thử thách Drago [Beta]",
	["Auto Rengoku Sword"] = "Tự động lấy kiếm Rengoku",
	["Auto Reset When Complete Volcano"] = "Tự động đặt lại khi hoàn thành núi lửa",
	["Auto Saber Sword"] = "Tự động lấy kiếm Saber",
	["Auto Safe Mode"] = "Tự động chế độ an toàn",
	["Auto Sail Boat"] = "Tự động lái thuyền",
	["Auto SanguineArt"] = "Tự động lấy Sanguine Art",
	["Auto Saw Sword"] = "Tự động lấy kiếm Saw",
	["Auto Select Dungeon Chip"] = "Tự động chọn chip Dungeon",
	["Auto Sell Fish"] = "Tự động bán cá",
	["Auto Serpent Bow"] = "Tự động lấy Serpent Bow",
	["Auto Set Spawn Point"] = "Tự động đặt điểm hồi sinh",
	["Auto Shark"] = "Tự động farm Shark",
	["Auto Sharkman Karate"] = "Tự động lấy Sharkman Karate",
	["Auto Skull Guitar"] = "Tự động lấy Skull Guitar",
	["Auto Soul Reaper"] = "Tự động farm Soul Reaper",
	["Auto Spam Skill Z"] = "Tự động spam kỹ năng Z",
	["Auto Start Law Raids"] = "Tự động mở đột kích Law",
	["Auto Start Prehistoric Event"] = "Tự động bắt đầu sự kiện Tiền sử",
	["Auto Start Raid"] = "Tự động bắt đầu đột kích",
	["Auto Store Fruit"] = "Tự động cất Trái",
	["Auto Summon Boss"] = "Tự động triệu hồi Boss",
	["Auto Summon Cake Prince"] = "Tự động triệu hồi Cake Prince",
	["Auto Superhuman"] = "Tự động lấy Superhuman",
	["Auto Swan Coat"] = "Tự động lấy áo Swan",
	["Auto Swan Glasses"] = "Tự động lấy kính Swan",
	["Auto Swords"] = "Tự động dùng kiếm",
	["Auto Teleport Barista Cousin"] = "Tự động dịch đến Barista Cousin",
	["Auto Teleport Frozen Dimension"] = "Tự động dịch đến Không gian băng giá",
	["Auto Teleport To Lab"] = "Tự động dịch đến Phòng thí nghiệm",
	["Auto Teleport to Race Doors"] = "Tự động dịch đến cửa chủng tộc",
	["Auto Teleport to Shrine Actived"] = "Tự động dịch đến đền thờ đã kích hoạt",
	["Auto Terror Shark"] = "Tự động farm Terror Shark",
	["Auto Trade Azure Ember"] = "Tự động đổi Azure Ember",
	["Auto Train Drago v4"] = "Tự động luyện Drago V4",
	["Auto Train V4"] = "Tự động luyện V4",
	["Auto Training Dummy"] = "Tự động luyện với bù nhìn",
	["Auto Travel"] = "Tự động di chuyển",
	["Auto Try Luck Gravestone"] = "Tự động thử may mắn bia mộ",
	["Auto Turn on Buso"] = "Tự động bật Buso",
	["Auto Turn on Race V3"] = "Tự động bật chủng tộc V3",
	["Auto Turn on Race V4"] = "Tự động bật chủng tộc V4",
	["Auto Turn on Spin  xyz"] = "Tự động bật Spin xyz",
	["Auto Tushita CDK"] = "Tự động lấy Tushita CDK",
	["Auto Tushita Sword"] = "Tự động lấy kiếm Tushita",
	["Auto Tween Advanced Fruit Dealer"] = "Tự động di chuyển đến thương nhân Trái",
	["Auto Tween To Highest Point"] = "Tự động di chuyển đến điểm cao nhất",
	["Auto Tween To Mirage Island"] = "Tự động di chuyển đến Đảo Mirage",
	["Auto Tween to Fruit"] = "Tự động di chuyển đến Trái",
	["Auto Tween to NPC"] = "Tự động di chuyển đến NPC",
	["Auto Twin Hooks"] = "Tự động lấy Twin Hooks",
	["Auto Unlocked DonSwan"] = "Tự động mở khóa Don Swan",
	["Auto Unlocked Haki"] = "Tự động mở khóa Haki",
	["Auto Upgrade Angel"] = "Tự động nâng cấp Angel",
	["Auto Upgrade FishMan"] = "Tự động nâng cấp Fishman",
	["Auto Upgrade Human"] = "Tự động nâng cấp Human",
	["Auto Upgrade Mink"] = "Tự động nâng cấp Mink",
	["Auto Usoap's Hat"] = "Tự động lấy mũ Usopp",
	["Auto Warden Sword"] = "Tự động lấy kiếm Warden",
	["Auto Yama CDK"] = "Tự động lấy Yama CDK",
	["Auto Yama Sword"] = "Tự động lấy kiếm Yama",
	["Bone"] = "Xương",
	["Bring Mobs"] = "Kéo quái về",
	["Buso/Aura Colours"] = "Màu Buso/Aura",
	["Buy Bisento"] = "Mua Bisento",
	["Buy Bizarre Rifle"] = "Mua Bizarre Rifle",
	["Buy Black Cape"] = "Mua áo choàng đen",
	["Buy Black Leg"] = "Mua Black Leg",
	["Buy Boats"] = "Mua thuyền",
	["Buy Buso"] = "Mua Buso",
	["Buy Buso Colors"] = "Mua màu Buso",
	["Buy Cannon"] = "Mua pháo",
	["Buy Cutlass"] = "Mua Cutlass",
	["Buy Cyborg Race (2.5k)"] = "Mua chủng tộc Cyborg (2.5k)",
	["Buy Death Step"] = "Mua Death Step",
	["Buy Draco Race"] = "Mua chủng tộc Draco",
	["Buy DragonClaw"] = "Mua Dragon Claw",
	["Buy DragonTalon"] = "Mua Dragon Talon",
	["Buy Dual Flintlock"] = "Mua Dual Flintlock",
	["Buy Dual-Headed Blade"] = "Mua Dual-Headed Blade",
	["Buy Duel Katana"] = "Mua Duel Katana",
	["Buy Dungeon Chips [Beli]"] = "Mua chip Dungeon [Beli]",
	["Buy Dungeon Chips [Devil Fruit]"] = "Mua chip Dungeon [Devil Fruit]",
	["Buy ElectricClaw"] = "Mua Electric Claw",
	["Buy Electro"] = "Mua Electro",
	["Buy Fishman Karate"] = "Mua Fishman Karate",
	["Buy Flintlock"] = "Mua Flintlock",
	["Buy Geppo"] = "Mua Geppo",
	["Buy Ghoul Mask"] = "Mua mặt nạ Ghoul",
	["Buy Ghoul Race"] = "Mua chủng tộc Ghoul",
	["Buy Godhuman"] = "Mua Godhuman",
	["Buy Iron Mace"] = "Mua Iron Mace",
	["Buy Kabucha"] = "Mua Kabucha",
	["Buy Katana"] = "Mua Katana",
	["Buy Ken"] = "Mua Ken",
	["Buy Legendary Sword"] = "Mua kiếm huyền thoại",
	["Buy Microchip Law"] = "Mua Microchip Law",
	["Buy Musket"] = "Mua Musket",
	["Buy Pipe"] = "Mua Pipe",
	["Buy Refined Flintlock"] = "Mua Refined Flintlock",
	["Buy Refund Stats"] = "Mua hoàn lại điểm",
	["Buy Reroll Race"] = "Mua quay chủng tộc",
	["Buy SanguineArt"] = "Mua Sanguine Art",
	["Buy Sharkman Karate"] = "Mua Sharkman Karate",
	["Buy Slingshot"] = "Mua ná giáo",
	["Buy Soru"] = "Mua Soru",
	["Buy Soul Cane"] = "Mua Soul Cane",
	["Buy Spy"] = "Mua Spy",
	["Buy Superhuman"] = "Mua Superhuman",
	["Buy Swordsman Hat"] = "Mua mũ kiếm khách",
	["Buy Tomoe Ring"] = "Mua nhẫn Tomoe",
	["Buy Triple Katana"] = "Mua Triple Katana",
	["Buy True Triple Katana Sword"] = "Mua True Triple Katana",
	["Cake Prince Status"] = "Trạng thái Cake Prince",
	["Cam"] = "Cam",
	["Cavender + Twin Hooks + Bigmom"] = "Cavendish + Twin Hooks + Bigmom",
	["Change Transparency can see"] = "Độ trong suốt để nhìn thấy",
	["ChangeBusoStage"] = "Đổi cấp Buso",
	["Chest"] = "Rương",
	["Choose Island"] = "Chọn đảo",
	["Choose Material"] = "Chọn nguyên liệu",
	["Choose Sea Event"] = "Chọn sự kiện Biển",
	["Click"] = "Nhấp",
	["Collect Berry"] = "Thu thập Berry",
	["Combat / AimBot"] = "Chiến đấu / AimBot",
	["Configure - God"] = "Cấu hình - God",
	["Copy JobID"] = "Sao chép ID máy chủ",
	["Craft Dino Hood"] = "Chế tạo mũ khủng long",
	["Craft Dragonheart"] = "Chế tạo Dragonheart",
	["Craft Dragonstorm"] = "Chế tạo Dragonstorm",
	["Craft LegendaryScroll"] = "Chế tạo cuộn huyền thoại",
	["Craft LeviathanBoat"] = "Chế tạo thuyền Leviathan",
	["Craft LeviathanCrown"] = "Chế tạo vương miện Leviathan",
	["Craft LeviathanShield"] = "Chế tạo khiên Leviathan",
	["Craft MythicalScroll"] = "Chế tạo cuộn thần thoại",
	["Craft SharkAnchor"] = "Chế tạo mỏ neo Shark",
	["Craft SharkTooth"] = "Chế tạo răng Shark",
	["Craft T-Rex Skull"] = "Chế tạo hộp sọ T-Rex",
	["Craft TerrorJaw"] = "Chế tạo Terror Jaw",
	["Craft Volcanic Magnet"] = "Chế tạo nam châm núi lửa",
	["Crafting Items"] = "Vật phẩm chế tạo",
	["Cursed Dual Katana"] = "Cursed Dual Katana",
	["Dash No Cooldown"] = "Lướt không hồi chiêu",
	["Disable Chat GUI"] = "Tắt giao diện chat",
	["Disable Leader Board GUI"] = "Tắt bảng xếp hạng",
	["Disable Notify"] = "Tắt thông báo",
	["Do"] = "Đỏ",
	["Dojo Quest"] = "Nhiệm vụ Dojo",
	["Dough King"] = "Dough King",
	["Drago Trial"] = "Thử thách Drago",
	["Dungeon Event / Raiding"] = "Sự kiện Dungeon / Đột kích",
	["Enable Fly"] = "Bật bay",
	["Entity Sea Event"] = "Sinh vật sự kiện Biển",
	["Esp"] = "ESP",
	["Esp Advanced Dealer"] = "ESP thương nhân cao cấp",
	["Esp Berry"] = "ESP Berry",
	["Esp Chest"] = "ESP rương",
	["Esp Flower"] = "ESP hoa",
	["Esp Fruit"] = "ESP Trái",
	["Esp Gear"] = "ESP Gear",
	["Esp Haki Color"] = "ESP màu Haki",
	["Esp Island"] = "ESP đảo",
	["Esp Legendary Sword"] = "ESP kiếm huyền thoại",
	["Esp Mirage Island"] = "ESP Đảo Mirage",
	["Esp Player"] = "ESP người chơi",
	["Esp SeaEvent Island"] = "ESP đảo sự kiện Biển",
	["Farm All Island"] = "Farm tất cả đảo",
	["Farm Boss"] = "Farm Boss",
	["Farm Elite Hunter"] = "Farm Elite Hunter",
	["Farm Material"] = "Farm nguyên liệu",
	["Farm Mob"] = "Farm quái",
	["Farm Rip Indra"] = "Farm Rip Indra",
	["Farming"] = "Farm",
	["Farming Bone"] = "Farm xương",
	["Farming Cake"] = "Farm bánh",
	["Farming Mastery"] = "Farm Mastery",
	["Fast Attack"] = "Tấn công nhanh",
	["Fighting - Style"] = "Phong cách đánh",
	["Fighting Melee Styles"] = "Các kiểu chiến đấu cận chiến",
	["Fishing"] = "Câu cá",
	["Fragments shop"] = "Cửa hàng Fragments",
	["Frozen Dimension"] = "Không gian băng giá",
	["Frozen Dimension : False"] = "Không gian băng giá : Tắt",
	["Frozen Dimension : True"] = "Không gian băng giá : Bật",
	["Frozen Dimension Event"] = "Sự kiện Không gian băng giá",
	["Fruit And Raid"] = "Trái & Đột kích",
	["Fruits Options"] = "Tùy chọn Trái",
	["Full Moon"] = "Trăng tròn",
	["Game Time"] = "Thời gian trong game",
	["Gear"] = "Trang bị",
	["Get Fruit In Inventory Below 1M"] = "Lấy Trái trong túi dưới 1M",
	["Get player quests"] = "Lấy nhiệm vụ người chơi",
	["Graphics / Haki Stats"] = "Đồ họa / Chỉ số Haki",
	["Home"] = "Trang chủ",
	["Hong"] = "Hồng",
	["Hop Delay (Minutes)"] = "Thời gian chờ đổi server (phút)",
	["Hop Server"] = "Đổi server",
	["Hop to Lowest Pings Server"] = "Đổi server ping thấp nhất",
	["Hop to Lowest Players"] = "Đổi server ít người nhất",
	["Ignore Same Teams"] = "Bỏ qua cùng phe",
	["Info And Status"] = "Thông tin & Trạng thái",
	["Input Job Id"] = "Nhập ID máy chủ",
	["Instance Energy [ INF ]"] = "Năng lượng vô hạn",
	["Instance Mink V3 [ INF ]"] = "Mink V3 vô hạn",
	["Instance Observation Range [ INF ]"] = "Tầm quan sát vô hạn",
	["Instance Soru [ INF ]"] = "Soru vô hạn",
	["Instinct / Observation"] = "Bản năng / Quan sát",
	["Items Law/Order Sword"] = "Vật phẩm kiếm Law/Order",
	["Kill Aura"] = "Vòng thần sát thương",
	["Kitsune Island"] = "Đảo Kitsune",
	["Kitsune Island / Event"] = "Đảo Kitsune / Sự kiện",
	["Kitsune Island : False"] = "Đảo Kitsune : Chưa xuất hiện",
	["Kitsune Island : True"] = "Đảo Kitsune : Đã xuất hiện",
	["Legendary Sword"] = "Kiếm huyền thoại",
	["Local Player"] = "Người chơi",
	["LocalPlayer Settings"] = "Cài đặt người chơi",
	["Look Moon + Auto V3"] = "Nhìn trăng + tự động V3",
	["Mirage And Race"] = "Mirage & Chủng tộc",
	["Mirage Island"] = "Đảo Mirage",
	["Mirage Island : False"] = "Đảo Mirage : Chưa xuất hiện",
	["Mirage Island : True"] = "Đảo Mirage : Đã xuất hiện",
	["Miscellaneous"] = "Tiện ích",
	["Moon : 0 / 8"] = "Mặt trăng : 0 / 8",
	["Moon : 1 / 8"] = "Mặt trăng : 1 / 8",
	["Moon : 2 / 8"] = "Mặt trăng : 2 / 8",
	["Moon : 3 / 8 [ Next Night ]"] = "Mặt trăng : 3 / 8 [ Đêm tới ]",
	["Moon : 4 / 8 [ Full Moon ]"] = "Mặt trăng : 4 / 8 [ Trăng tròn ]",
	["Moon : 5 / 8 [ Last Night ]"] = "Mặt trăng : 5 / 8 [ Đêm cuối ]",
	["Moon : 6 / 8"] = "Mặt trăng : 6 / 8",
	["Moon : 7 / 8"] = "Mặt trăng : 7 / 8",
	["Mystic Island / Full Moon"] = "Đảo bí ẩn / Trăng tròn",
	["NPC Health % Switch to Weapon"] = "% máu NPC để đổi vũ khí",
	["Night Slayer Hub"] = "Meizu Hub",
	["No Clip"] = "Xuyên tường",
	["No Clip Ship"] = "Xuyên tường trên thuyền",
	["Open Awakenings Expert"] = "Mở chuyên gia thức tỉnh",
	["Open Title Selection"] = "Mở chọn danh hiệu",
	["Player Gui / Others"] = "Giao diện người chơi / Khác",
	["Pole / God Enal's"] = "Pole / God Enel",
	["Prehistoric Island"] = "Đảo Tiền sử",
	["Prehistoric Island : False"] = "Đảo Tiền sử : Chưa xuất hiện",
	["Prehistoric Island : True"] = "Đảo Tiền sử : Đã xuất hiện",
	["Quest And Item"] = "Nhiệm vụ & Vật phẩm",
	["Quest Number : Collect!!"] = "Nhiệm vụ : Đang thu thập!!",
	["Quest Number : No Quest!!"] = "Nhiệm vụ : Chưa có!!",
	["Quest Number : Quest1"] = "Nhiệm vụ : Nhiệm vụ 1",
	["Quest Number : Quest2"] = "Nhiệm vụ : Nhiệm vụ 2",
	["Quest Number : Quest3"] = "Nhiệm vụ : Nhiệm vụ 3",
	["Quest Number : Quest4"] = "Nhiệm vụ : Nhiệm vụ 4",
	["Quest Numbers : CDK done!!"] = "Nhiệm vụ : CDK xong!!",
	["Quest Numbers : tushita quest 1"] = "Nhiệm vụ : Tushita 1",
	["Quest Numbers : tushita quest 2"] = "Nhiệm vụ : Tushita 2",
	["Quest Numbers : yama quest 1"] = "Nhiệm vụ : Yama 1",
	["Quest Numbers : yama quest 2"] = "Nhiệm vụ : Yama 2",
	["Quest Numbers : yama quest 3"] = "Nhiệm vụ : Yama 3",
	["Quests Players"] = "Nhiệm vụ người chơi",
	["Raids Dungeons"] = "Đột kích Dungeon",
	["Rain Fruits (Client)"] = "Mưa Trái (client)",
	["Redeem All Codes"] = "Nhập tất cả mã quà",
	["Rejoin Server"] = "Tham gia lại server",
	["Remove Death & Respawned VFX"] = "Tắt hiệu ứng chết/hồi sinh",
	["Remove Hit VFX"] = "Tắt hiệu ứng đánh trúng",
	["Remove Lighting Effect"] = "Tắt hiệu ứng ánh sáng",
	["Remove Sky Fog"] = "Tắt sương mù",
	["Rengoku Sword"] = "Kiếm Rengoku",
	["Rip Indra"] = "Rip Indra",
	["Safe Mode"] = "Chế độ an toàn",
	["Sea Event"] = "Sự kiện Biển",
	["Sea Event / Setting Sail"] = "Sự kiện Biển / Khởi hành",
	["Search Section name"] = "Tìm tên mục...",
	["Search section or Function..."] = "Tìm kiếm mục hoặc chức năng...",
	["Select Aim Method"] = "Chọn phương pháp Aim",
	["Select Bait"] = "Chọn mồi câu",
	["Select Boats"] = "Chọn thuyền",
	["Select Boss"] = "Chọn Boss",
	["Select Chip"] = "Chọn chip",
	["Select Fishing Rod"] = "Chọn cần câu",
	["Select Fruit Shop"] = "Chọn cửa hàng Trái",
	["Select Haki States"] = "Chọn trạng thái Haki",
	["Select Island"] = "Chọn đảo",
	["Select Mob"] = "Chọn quái",
	["Select NPCs"] = "Chọn NPC",
	["Select Players"] = "Chọn người chơi",
	["Select Portal"] = "Chọn cổng dịch chuyển",
	["Select Sea Level"] = "Chọn Biển",
	["Select Skills to Use"] = "Chọn kỹ năng dùng",
	["Select Time"] = "Chọn thời gian",
	["Select Travelling"] = "Chọn điểm đến",
	["Select Weapon"] = "Chọn vũ khí",
	["Server - Function"] = "Máy chủ - Chức năng",
	["Session"] = "Phiên",
	["Set Marine Team"] = "Chọn phe Hải quân",
	["Set Pirate Team"] = "Chọn phe Hải tặc",
	["Setting"] = "Cài đặt",
	["Settings / Configure"] = "Cài đặt / Cấu hình",
	["Ship Speed"] = "Tốc độ thuyền",
	["Ship Speed Modifier"] = "Bộ điều chỉnh tốc độ thuyền",
	["Shop Options"] = "Tùy chọn cửa hàng",
	["Shopping"] = "Mua sắm",
	["Skull Guitars / Misc"] = "Đàn Skull / Linh tinh",
	["Spectate Select Players"] = "Theo dõi người chơi",
	["Speed Fly Mode"] = "Tốc độ bay",
	["Spy Leviathan : Already Done!!"] = "Giám sát Leviathan : Đã xong!!",
	["Start Law Raids"] = "Bắt đầu đột kích Law",
	["Stats And Esp"] = "Chỉ số & ESP",
	["Stats Upgrade"] = "Nâng cấp chỉ số",
	["Stats Value"] = "Giá trị chỉ số",
	["Stop Items"] = "Dừng nhặt vật phẩm",
	["Swap Drago Race"] = "Đổi chủng tộc Drago",
	["TP Exit (1)"] = "Dịch ra lối (1)",
	["TP Exit (2)"] = "Dịch ra lối (2)",
	["TP Exit (3)"] = "Dịch ra lối (3)",
	["TP Exit (4)"] = "Dịch ra lối (4)",
	["Talk With Stone"] = "Nói chuyện với Stone",
	["Talk with kitsune statue"] = "Nói chuyện với tượng Kitsune",
	["Teleport"] = "Dịch chuyển",
	["Teleport To Select Players"] = "Dịch đến người chơi",
	["Teleport [Job ID]"] = "Dịch chuyển [ID máy chủ]",
	["Teleport to Ancient Clock"] = "Dịch đến Đồng hồ cổ",
	["Teleport to Ancient One"] = "Dịch đến Ancient One",
	["Teleport to Temple of Time"] = "Dịch đến Đền Thời gian",
	["Tim"] = "Tím",
	["Time Zone"] = "Múi giờ",
	["Trade Items Azure"] = "Đổi vật phẩm Azure",
	["Trang"] = "Trắng",
	["Travel - Island"] = "Di chuyển - Đảo",
	["Travel - NPCs"] = "Di chuyển - NPC",
	["Travel - Portal"] = "Di chuyển - Cổng dịch",
	["Travel - Worlds"] = "Di chuyển - Thế giới",
	["Travel Dressrosa (World 2)"] = "Đến Dressrosa (Thế giới 2)",
	["Travel East Blue (World 1)"] = "Đến East Blue (Thế giới 1)",
	["Travel Zou (World 3)"] = "Đến Zou (Thế giới 3)",
	["Trials Quest V4"] = "Nhiệm vụ thử thách V4",
	["True Triple Katana Sword"] = "Kiếm True Triple Katana",
	["Turn on Fast Mode"] = "Bật chế độ nhanh",
	["Turn on Full Bright"] = "Bật sáng toàn màn hình",
	["Turn on Ice Walk"] = "Bật đi trên băng",
	["Turn on Low CPU"] = "Bật tiết kiệm CPU",
	["Turn on RTX Mode"] = "Bật chế độ RTX",
	["Turn on Time"] = "Bật đổi thời gian",
	["Turn on Walk on Water"] = "Bật đi trên nước",
	["Turn on increase Boats"] = "Bật tăng tốc thuyền",
	["Tushita + Yama"] = "Tushita + Yama",
	["Tween To Upgrade Droco Trial"] = "Di chuyển nâng cấp thử thách Draco",
	["Tween to Drago Trials"] = "Di chuyển đến thử thách Drago",
	["Tween to Legendary Sword Dealer"] = "Di chuyển đến người bán kiếm huyền thoại",
	["Tyrant of the Skies"] = "Bạo chúa trên trời",
	["Tyrant of the Skies: ✅"] = "Bạo chúa trên trời: ✅",
	["Tyrant of the Skies: ❌"] = "Bạo chúa trên trời: ❌",
	["UI Theme Color"] = "Màu giao diện",
	["Unlock All Portals"] = "Mở khóa tất cả cổng",
	["Update 30 / Magnet Token"] = "Update 30 / Magnet Token",
	["Upgrade Dragon Talon With Uzoth"] = "Nâng cấp Dragon Talon với Uzoth",
	["Upgrade Races V2 And V3"] = "Nâng cấp chủng tộc V2 & V3",
	["Vang"] = "Vàng",
	["Volcanic Crafting"] = "Chế tạo núi lửa",
	["Volcano Event"] = "Sự kiện Núi lửa",
	["Weapon World1"] = "Vũ khí Thế giới 1",
	["World observations"] = "Quan sát thế giới",
	["Xam Den"] = "Xám Đen",
	["Xanh Duong"] = "Xanh Dương",
	["Xanh La"] = "Xanh Lá",
	["Xanh Ngoc"] = "Xanh Ngọc",
}
getgenv().TranslateUI = function()
	local dict = getgenv().ViDict
	if not dict then return end
	local gui = game.CoreGui:FindFirstChild("Killua Hub GUI")
	if not gui then return end
	for _, obj in ipairs(gui:GetDescendants()) do
		if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
			local t = obj.Text
			if t and dict[t] then
				obj.Text = dict[t]
			end
		end
	end
end
task.spawn(function()
	while true do
		task.wait(3)
		pcall(function() getgenv().TranslateUI() end)
	end
end)


local currcolor = {}
local Library = {};
local Library_Function = {}
local TweenService = game:GetService('TweenService')
local uis = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function makeDraggable(topBarObject, object)
	local dragging = nil
	local dragInput = nil
	local dragStart = nil
	local startPosition = nil
	topBarObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPosition = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	topBarObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	uis.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			if not djtmemay and cac then
				TweenService:Create(object, TweenInfo.new(DisableAnimation and 0 or 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
				}):Play()
			elseif not djtmemay and not cac then
				object.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
			end
		end
	end)
end

Library_Function.Gui = Instance.new('ScreenGui')
Library_Function.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.Gui.Name = 'Killua Hub GUI'
Library_Function.Gui.Enabled = false
Library_Function.Gui.DisplayOrder = 999

getgenv().ReadyForGuiLoaded = false
spawn(function()
	repeat
		task.wait()
	until getgenv().ReadyForGuiLoaded
	if getgenv().UIToggled then
		Library_Function.Gui.Enabled = true
	end
end)


Library_Function.NotiGui = Instance.new('ScreenGui')
Library_Function.NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.NotiGui.Name = 'Killua Hub Notification'
Library_Function.NotiGui.DisplayOrder = 1000

Library_Function.HideGui = Instance.new('ScreenGui')
Library_Function.HideGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.HideGui.Name = 'Killua Hub Btn'
Library_Function.HideGui.DisplayOrder = 1001


local btnHide = Instance.new('TextButton', Library_Function.HideGui) 
btnHide.BackgroundTransparency = 1
btnHide.Text = ""
btnHide.TextColor3 = Color3.fromRGB(0, 0, 0)
btnHide.TextSize = 26
btnHide.Font = Enum.Font.SourceSansBold
btnHide.AnchorPoint = Vector2.new(0, 1)
btnHide.Size = UDim2.new(0, 50, 0, 50)
btnHide.Position = UDim2.new(0, 15, 1, -15)

local btnHideFrame = Instance.new('Frame', btnHide)
btnHideFrame.AnchorPoint = Vector2.new(0, 1)
btnHideFrame.Size = UDim2.new(0, 50, 0, 50)
btnHideFrame.Position = UDim2.new(0, 0, 1, 0)
btnHideFrame.Name = "dut dit"
btnHideFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
btnHideFrame.BackgroundTransparency = getgenv().UIToggled and 0 or .25

local imgHide = Instance.new('ImageLabel', btnHide)
imgHide.AnchorPoint = Vector2.new(0, 0)
imgHide.Image = getgenv().KilluaAsset
imgHide.BackgroundTransparency = 1
imgHide.Size = UDim2.new(0, getgenv().UIToggled and (getgenv().T1 and 30 or 40) or (getgenv().T1 and 25 or 30), 0, getgenv().UIToggled and (getgenv().T1 and 30 or 40) or (getgenv().T1 and 25 or 30))
imgHide.AnchorPoint = Vector2.new(.5, .5)
imgHide.Position = UDim2.new(.5, 0, .5, 0)
imgHide.Visible = true
imgHide.ScaleType = Enum.ScaleType.Crop

local UICornerBtnHide = Instance.new("UICorner")
UICornerBtnHide.Parent = btnHideFrame
UICornerBtnHide.CornerRadius = UDim.new(1, 0)

local btnHideStroke = Instance.new("UIStroke", btnHideFrame)
btnHideStroke.Color = Color3.fromRGB(56, 132, 255)
btnHideStroke.Thickness = 1.5
btnHideStroke.Transparency = 0.2
getgenv().BtnHideStroke = btnHideStroke

Library.ToggleUI = function()
	getgenv().UIToggled = not getgenv().UIToggled
	local sizeXY = getgenv().UIToggled and (getgenv().T1 and 30 or 40) or (getgenv().T1 and 25 or 30)
	TweenService:Create(imgHide, TweenInfo.new(DisableAnimation and 0 or .25), {
		Size = UDim2.new(0, sizeXY, 0, sizeXY)
	}):Play()
	TweenService:Create(btnHideFrame, TweenInfo.new(DisableAnimation and 0 or .25), {
		BackgroundTransparency = getgenv().UIToggled and 0 or .25
	}):Play()
	local gui = game.CoreGui:FindFirstChild("Killua Hub GUI")
	if gui then
		local main = getgenv().MainFrame or gui:FindFirstChild("Main", true)
		local sc = main and main:FindFirstChildOfClass("UIScale")
		if DisableAnimation or not main or not sc then
			gui.Enabled = getgenv().UIToggled
			return
		end
		if getgenv().UIToggled then
			gui.Enabled = true
			sc.Scale = 0.85
			TweenService:Create(sc, TweenInfo.new(.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
		else
			TweenService:Create(sc, TweenInfo.new(.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Scale = 0.85 }):Play()
			task.delay(.2, function() if not getgenv().UIToggled then gui.Enabled = false end end)
		end
	end
end

Library.DestroyUI = function()
	for i, v in ipairs(game.CoreGui:GetChildren()) do
		if string.find(v.Name, "Killua Hub") or string.find(v.Name, "Meizu Hub") then
			v:Destroy()
		end
	end
end

if true then
	local button = btnHide -- Assuming this is a TextButton or ImageButton
	local UIS = game:GetService("UserInputService")
	
	local dragging = false
	local dragInput, dragStart, startPos
	local holdTime = 0 -- drag activates on movement threshold
	local holdStarted = 0
	
	-- Function to update the button's position
	local function update(input)
		local delta = input.Position - dragStart
		button.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
	
	-- Function to detect the start of dragging (for both mouse and touch)
	local function onInputBegan(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			holdStarted = 0 -- drag only starts after movement threshold
			dragStart = input.Position
			startPos = button.Position
	
			-- Listen for release to stop dragging
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					holdStarted = 0 -- Reset the hold timer
				end
			end)
		end
	end
	
	-- Function to detect when dragging stops
	local function onInputEnded(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			local wasDragging = dragging
			dragging = false
			holdStarted = 0 -- Reset the hold timer
			if not wasDragging then
				Library.ToggleUI()
			end
		end
	end
	
	-- Detect input movement (for both mouse and touch)
	local function onInputChanged(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
			if dragStart and (input.Position - dragStart).Magnitude > 8 then
				holdStarted = tick()
			end
		end
	end
	
	-- Connect the events
	button.InputBegan:Connect(onInputBegan)
	button.InputEnded:Connect(onInputEnded)
	button.InputChanged:Connect(onInputChanged)
	
	-- RenderStepped updates the position while dragging
	RunService.RenderStepped:Connect(function()
		if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
			dragging = true
		end
	
		if dragging and dragInput then
			update(dragInput)
		end
	end)
		
end

-- toggle is handled in onInputEnded (tap = toggle, drag = move)

local NotiContainer = Instance.new("Frame")
local NotiList = Instance.new("UIListLayout")

NotiContainer.Name = "NotiContainer"
NotiContainer.Parent = Library_Function.NotiGui
NotiContainer.AnchorPoint = Vector2.new(1, 1)
NotiContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
NotiContainer.BackgroundTransparency = 1.000
NotiContainer.Position = UDim2.new(1, -5, 1, -5)
NotiContainer.Size = UDim2.new(0, 350, 1, -10)

NotiList.Name = "NotiList"
NotiList.Parent = NotiContainer
NotiList.SortOrder = Enum.SortOrder.LayoutOrder
NotiList.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotiList.Padding = UDim.new(0, 5)


Library_Function.Gui.Parent = game:GetService('CoreGui')
Library_Function.NotiGui.Parent = game:GetService('CoreGui')
Library_Function.HideGui.Parent = game:GetService('CoreGui')

function Library_Function.Getcolor(color)
	return {
		math.floor(color.r * 255),
		math.floor(color.g * 255),
		math.floor(color.b * 255)
	}
end

local libCreateNoti = function(Setting)
	getgenv().TitleNameNoti = Setting.Title or ""; 
	local Description = Setting.Description or Setting.Desc or Setting.Content or ""; 
	local Duration = Setting.Duration or Setting.Timeshow or Setting.Delay or 10;

	local NotiFrame = Instance.new("Frame")
	local Noticontainer = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Topnoti = Instance.new("Frame")
	local Ruafimg = Instance.new("ImageLabel")
	local RuafimgCorner = Instance.new("UICorner")
	local TextLabelNoti = Instance.new("TextLabel")
	local CloseContainer = Instance.new("Frame")
	local CloseImage = Instance.new("ImageLabel")
	local TextButton = Instance.new("TextButton")
	local TextLabelNoti2 = Instance.new("TextLabel")

	NotiFrame.Name = "NotiFrame"
	NotiFrame.Parent = NotiContainer
	NotiFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	NotiFrame.BackgroundTransparency = 1.000
	NotiFrame.ClipsDescendants = true
	NotiFrame.Position = UDim2.new(0, 0, 0, 0)
	NotiFrame.Size = UDim2.new(1, 0, 0, 0)
	NotiFrame.AutomaticSize = Enum.AutomaticSize.Y

	Noticontainer.Name = "Noticontainer"
	Noticontainer.Parent = NotiFrame
	Noticontainer.Position = UDim2.new(1, 0, 0, 0)
	Noticontainer.Size = UDim2.new(1, 0, 1, 6)
	Noticontainer.AutomaticSize = Enum.AutomaticSize.Y
	Noticontainer.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = Noticontainer

	Topnoti.Name = "Topnoti"
	Topnoti.Parent = Noticontainer
	Topnoti.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	Topnoti.BackgroundTransparency = 1.000
	Topnoti.Position = UDim2.new(0, 0, 0, 5)
	Topnoti.Size = UDim2.new(1, 0, 0, 25)

	Ruafimg.Name = "Ruafimg"
	Ruafimg.Parent = Topnoti
	Ruafimg.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	Ruafimg.BackgroundTransparency = 1.000
	Ruafimg.Position = UDim2.new(0, 5, 0, getgenv().T1 and 5 or 0)
	Ruafimg.Size = UDim2.new(0, getgenv().T1 and 30 or 25, 0, getgenv().T1 and 15 or 25)
	Ruafimg.Image = getgenv().UIColor["Logo Image"]

	RuafimgCorner.CornerRadius = UDim.new(1, 0)
	RuafimgCorner.Name = "RuafimgCorner"
	RuafimgCorner.Parent = Ruafimg
	
	local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
	local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
	local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
	local color = colorR .. ',' .. colorG .. ',' .. colorB
    TextLabelNoti.Text = "<font color=\"rgb(" .. tostring(color or "255,206,27") .. ")\">" .. tostring("Night Slayer Hub") .. "</font> " .. tostring(getgenv().TitleNameNoti or "")
    
	TextLabelNoti.Name = "TextLabelNoti"
	TextLabelNoti.Parent = Topnoti
	TextLabelNoti.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextLabelNoti.BackgroundTransparency = 1.000
	TextLabelNoti.Position = UDim2.new(0, getgenv().T1 and 40 or 35, 0, 0)
	TextLabelNoti.Size = UDim2.new(1, getgenv().T1 and -40 or -35, 1, 0)
	TextLabelNoti.Font = Enum.Font.GothamBold
	TextLabelNoti.TextSize = 14.000
	TextLabelNoti.TextWrapped = true
	TextLabelNoti.TextXAlignment = Enum.TextXAlignment.Left
	TextLabelNoti.RichText = true
	TextLabelNoti.TextColor3 = getgenv().UIColor["GUI Text Color"]

	CloseContainer.Name = "CloseContainer"
	CloseContainer.Parent = Topnoti
	CloseContainer.AnchorPoint = Vector2.new(1, 0.5)
	CloseContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	CloseContainer.BackgroundTransparency = 1.000
	CloseContainer.Position = UDim2.new(1, -4, 0.5, 0)
	CloseContainer.Size = UDim2.new(0, 22, 0, 22)

	CloseImage.Name = "CloseImage"
	CloseImage.Parent = CloseContainer
	CloseImage.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	CloseImage.BackgroundTransparency = 1.000
	CloseImage.Size = UDim2.new(1, 0, 1, 0)
	CloseImage.Image = "rbxassetid://3926305904"
	CloseImage.ImageRectOffset = Vector2.new(284, 4)
	CloseImage.ImageRectSize = Vector2.new(24, 24)
	CloseImage.ImageColor3 = getgenv().UIColor["Search Icon Color"]

	TextButton.Parent = CloseContainer
	TextButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextButton.BackgroundTransparency = 1.000
	TextButton.Size = UDim2.new(1, 0, 1, 0)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = ""
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 14.000

	if Description then
		TextLabelNoti2.Name = 'TextColor'
		TextLabelNoti2.Parent = Noticontainer
		TextLabelNoti2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TextLabelNoti2.BackgroundTransparency = 1.000
		TextLabelNoti2.Position = UDim2.new(0, 10, 0, 35)
		TextLabelNoti2.Size = UDim2.new(1, -15, 0, 0)
		TextLabelNoti2.Font = Enum.Font.GothamBold
		TextLabelNoti2.Text = Description
		TextLabelNoti2.TextSize = 14.000
		TextLabelNoti2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabelNoti2.RichText = true
		TextLabelNoti2.TextColor3 = getgenv().UIColor["Text Color"]
		TextLabelNoti2.AutomaticSize = Enum.AutomaticSize.Y
		TextLabelNoti2.TextWrapped = true
	end

	local function remove()
		TweenService:Create(Noticontainer, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			Position = UDim2.new(1, 0, 0, 0)
		}):Play()
		wait(.25)
		NotiFrame:Destroy()
	end

	TweenService:Create(Noticontainer, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
		Position = UDim2.new(0, 0, 0, 0)
	}):Play()

	TextButton.MouseEnter:Connect(function()
		TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
		}):Play()
	end)

	TextButton.MouseLeave:Connect(function()
		TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = getgenv().UIColor["Search Icon Color"]
		}):Play()
	end)

	TextButton.MouseButton1Click:Connect(function()
		wait(.25)
		remove()
	end)

	spawn(function()
		wait(Duration)
		remove()
	end)

end

function Library:Notify(Setting, bypass)
	if not getgenv().Config or bypass then
		local s, e = pcall(function()
			libCreateNoti(Setting)
		end)
		if e then
			print(e)
		end
	end
end

function Library:CreateWindow(Setting)
    local TitleNameMain = Setting.Title or "Night Slayer Hub"
    getgenv().MainDesc = Setting.Desc or Setting.Subtitle or ""
    
    if Setting.Image and Setting.Image ~= "" then
        getgenv().UIColor["Logo Image"] = Setting.Image
    end
    
	local djtmemay = false
	cac = false

	local Main = Instance.new("Frame")
	local maingui = Instance.new("ImageLabel")
	local MainCorner = Instance.new("UICorner")
	local TopMain = Instance.new("Frame")
	local Ruafimg = Instance.new("ImageLabel")
	local TextLabelMain = Instance.new("TextLabel")
	local PageControl = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local ControlList = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local ControlTitle = Instance.new("TextLabel")
	local MainPage = Instance.new("Frame")
	local UIPage = Instance.new("UIPageLayout")
	local Concacontainer = Instance.new("Frame")
	local Concacmain = Instance.new("Frame")
	local MainContainer

	Main.Name = "Main"
	Main.Parent = Library_Function.Gui
	Main.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
	Main.BackgroundTransparency = 1.000
	Main.Position = UDim2.new(0.5, 25, 0.5, 12)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Size = UDim2.new(0, 580, 0, 340)

	makeDraggable(Main, Main)

	local MainScale = Instance.new("UIScale")
	MainScale.Name = "MainScale"
	MainScale.Parent = Main
	MainScale.Scale = 1
	getgenv().MainFrame = Main

	maingui.Name = "maingui"
	maingui.Parent = Main
	maingui.AnchorPoint = Vector2.new(0.5, 0.5)
	maingui.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	maingui.BackgroundTransparency = 1.000
	maingui.Position = UDim2.new(0.5, 0, 0.5, 0)
	maingui.Selectable = true
	maingui.Size = UDim2.new(1, 30, 1, 30)
	maingui.Image = "rbxassetid://8068653048"
	maingui.ScaleType = Enum.ScaleType.Slice
	maingui.SliceCenter = Rect.new(15, 15, 175, 175)
	maingui.SliceScale = 1.300
	maingui.ImageColor3 = getgenv().UIColor["Border Color"]
	maingui.ImageTransparency = 1

	maingui.ImageColor3 = getgenv().UIColor['Title Text Color']

	MainContainer = Instance.new("ImageLabel")
	MainContainer.Name = "MainContainer"
	MainContainer.Parent = Main
	MainContainer.BackgroundColor3 = Color3.fromRGB(12, 13, 20)
	MainContainer.BackgroundTransparency = 0.08
	MainContainer.Size = UDim2.new(1, 0, 1, 0)

	local uistr = Instance.new("UIStroke", MainContainer);
	uistr.Thickness = 1.5;
	uistr.Color = Color3.fromRGB(56, 132, 255);
	uistr.Transparency = 0.35;
	uistr.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	local strokeGradient = Instance.new("UIGradient", uistr);
	strokeGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, getgenv().UIColor["Border Color"]),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 180, 255))
	};
	strokeGradient.Rotation = 45;

	local uigradient = Instance.new("UIGradient", MainContainer);
	uigradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
	}
	uigradient.Rotation = 90
	uigradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.92),
		NumberSequenceKeypoint.new(1, 0.92)
	}

	getgenv().ReadyForGuiLoaded = true
	
	MainCorner.CornerRadius = UDim.new(0, 12)
	MainCorner.Name = "MainCorner"
	MainCorner.Parent = MainContainer

	Concacontainer.Name = "Concacontainer"
	Concacontainer.Parent = MainContainer
	Concacontainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Concacontainer.BackgroundTransparency = 1.000
	Concacontainer.ClipsDescendants = true
	Concacontainer.Position = UDim2.new(0, 0, 0, 56)
	Concacontainer.Size = UDim2.new(1, 0, 1, -56)
	
	Concacmain.Name = "Concacmain"
	Concacmain.Parent = Concacontainer
	Concacmain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Concacmain.BackgroundTransparency = 1.000
	Concacmain.Selectable = true
	Concacmain.Size = UDim2.new(1, 0, 1, 0)
	
	TopMain.Name = "TopMain"
	TopMain.Parent = MainContainer
	TopMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopMain.BackgroundTransparency = 1.000
	TopMain.Size = UDim2.new(1, 0, 0, 56)
	
	local TopStroke = Instance.new("Frame", TopMain)
	TopStroke.Name = "TopStroke"
	TopStroke.BackgroundColor3 = getgenv().UIColor["Border Color"]
	TopStroke.BackgroundTransparency = 0.7
	TopStroke.BorderSizePixel = 0
	TopStroke.Position = UDim2.new(0, 0, 1, -1)
	TopStroke.Size = UDim2.new(1, 0, 0, 1)
	
	Ruafimg.Name = "Ruafimg"
	Ruafimg.Parent = TopMain
	Ruafimg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Ruafimg.BackgroundTransparency = 1.000
	Ruafimg.Position = UDim2.new(0, 12, 0, 8)
	Ruafimg.Size = UDim2.new(0, 40, 0, 40)
	Ruafimg.Image = getgenv().UIColor["Logo Image"]

	TextLabelMain.Name = "TextLabelMain"
	TextLabelMain.Parent = TopMain
	TextLabelMain.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextLabelMain.BackgroundTransparency = 1.000
	TextLabelMain.Position = UDim2.new(0, 62, 0, 8)
	TextLabelMain.Size = UDim2.new(0, 260, 0, 22)
	TextLabelMain.Font = Enum.Font.GothamBold
	TextLabelMain.RichText = true
	TextLabelMain.TextSize = 19.000
	TextLabelMain.TextXAlignment = Enum.TextXAlignment.Left
	TextLabelMain.RichText = false
	TextLabelMain.Text = TitleNameMain or "Meizu Hub"
	TextLabelMain.TextColor3 = Color3.fromRGB(242, 242, 248)
	-- Subtitle label (BLOX FRUITS - MOBILE COMPANION)
	local SubtitleLabel = Instance.new("TextLabel")
	SubtitleLabel.Name = "SubtitleLabel"
	SubtitleLabel.Parent = TopMain
	SubtitleLabel.BackgroundTransparency = 1
	SubtitleLabel.Position = UDim2.new(0, 62, 0, 30)
	SubtitleLabel.Size = UDim2.new(0, 340, 0, 16)
	SubtitleLabel.Font = Enum.Font.GothamMedium
	SubtitleLabel.TextSize = 11
	SubtitleLabel.TextColor3 = Color3.fromRGB(168, 162, 175)
	SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	SubtitleLabel.Text = string.upper(getgenv().MainDesc or "BLOX FRUITS - MOBILE COMPANION | v1.1.0")
	-- Logo: rounded frame with accent border
	Ruafimg.ClipsDescendants = true
	local LogoCorner = Instance.new("UICorner", Ruafimg)
	LogoCorner.CornerRadius = UDim.new(0, 10)
	local LogoStroke = Instance.new("UIStroke", Ruafimg)
	LogoStroke.Thickness = 1.5
	LogoStroke.Color = getgenv().UIColor["Border Color"]
	LogoStroke.Transparency = 0.15
	-- Minimize & Close buttons (top-right, rounded glass)
	local function MakeHeaderBtn(btnText, offX, onClick)
		local b = Instance.new("TextButton")
		b.Parent = TopMain
		b.BackgroundColor3 = Color3.fromRGB(42, 36, 50)
		b.BackgroundTransparency = 0.25
		b.Position = UDim2.new(1, offX, 0, 12)
		b.Size = UDim2.new(0, 28, 0, 28)
		b.AutoButtonColor = true
		b.Font = Enum.Font.GothamBold
		b.TextSize = 17
		b.Text = btnText
		b.TextColor3 = Color3.fromRGB(238, 238, 242)
		local bc = Instance.new("UICorner", b)
		bc.CornerRadius = UDim.new(0, 8)
		local bs = Instance.new("UIStroke", b)
		bs.Thickness = 0.8
		bs.Color = Color3.fromRGB(110, 85, 120)
		bs.Transparency = 0.45
		b.MouseButton1Click:Connect(function() pcall(onClick) end)
		return b
	end
	local collapsed = false
	local TWS = game:GetService("TweenService")
	MakeHeaderBtn("—", -68, function()
		collapsed = not collapsed
		if collapsed then
			Concacontainer.Visible = false
			TWS:Create(Main, TweenInfo.new(0.25), {Size = UDim2.new(0, 580, 0, 56)}):Play()
		else
			Concacontainer.Visible = true
			TWS:Create(Main, TweenInfo.new(0.25), {Size = UDim2.new(0, 580, 0, 340)}):Play()
		end
	end)
	MakeHeaderBtn("×", -34, function()
		Library.ToggleUI()
	end)
	TextLabelMain.TextWrapped = true
	TextLabelMain.TextXAlignment = Enum.TextXAlignment.Left
	TextLabelMain.TextColor3 = getgenv().UIColor["GUI Text Color"]

	-- v1.1.0: removed RichText font-tag override to fix title layout

	PageControl.Name = "Background1"
	PageControl.Parent = Concacmain
	PageControl.Position = UDim2.new(0, 6, 0, 5)
	PageControl.Size = UDim2.new(0, 165, 1, -10)
	PageControl.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
	PageControl.BackgroundTransparency = 0.35

	local pageControlStroke = Instance.new("UIStroke", PageControl)
	pageControlStroke.Color = Color3.fromRGB(90, 90, 70)
	pageControlStroke.Thickness = 0

	local pageControlGradient = Instance.new("UIGradient", PageControl)
	pageControlGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 34)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 38, 46))
	}
	pageControlGradient.Rotation = 90
	pageControlGradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.06),
		NumberSequenceKeypoint.new(1, 0.12)
	}

	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = PageControl

	ControlList.Name = "ControlList"
	ControlList.Parent = PageControl
	ControlList.Active = true
	ControlList.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	ControlList.BackgroundTransparency = 1.000
	ControlList.BorderColor3 = Color3.fromRGB(27, 42, 53)
	ControlList.BorderSizePixel = 0
	ControlList.Position = UDim2.new(0, 0, 0, 44)
	ControlList.Size = UDim2.new(1, -4, 1, -48)
	ControlList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	ControlList.CanvasSize = UDim2.new(0, 0, 0, 0)
	ControlList.ScrollBarThickness = 5
	ControlList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

	UIListLayout.Parent = ControlList
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	ControlTitle.Name = "GUITextColor"
	ControlTitle.Parent = PageControl
	ControlTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	ControlTitle.BackgroundTransparency = 1.000
	ControlTitle.Position = UDim2.new(0, 5, 0, 0)
	ControlTitle.Size = UDim2.new(1, 0, 0, 25)
	ControlTitle.Font = Enum.Font.GothamBold
	ControlTitle.Text = TitleNameMain
	ControlTitle.TextSize = 14.000
	ControlTitle.TextXAlignment = Enum.TextXAlignment.Left
	ControlTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]
	ControlTitle.Visible = false

	local PageSearch = Instance.new("Frame")
	local PageSearchCorner = Instance.new("UICorner")
	local SearchFrame = Instance.new("Frame")
	local SearchIcon = Instance.new("ImageLabel")
	local SearchBox = Instance.new("TextBox")

	PageSearch.Name = "PageSearch"
	PageSearch.Parent = PageControl
	PageSearch.AnchorPoint = Vector2.new(0.5, 0)
	PageSearch.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
	PageSearch.Position = UDim2.new(0.5, 0, 0, 8)
	PageSearch.Size = UDim2.new(1, -12, 0, 30)
	PageSearch.ClipsDescendants = true

	PageSearchCorner.Parent = PageSearch
	PageSearchCorner.CornerRadius = UDim.new(0, 8)

	SearchFrame.Name = "SearchFrame"
	SearchFrame.Parent = PageSearch
	SearchFrame.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	SearchFrame.BackgroundTransparency = 1
	SearchFrame.Size = UDim2.new(0, 25, 1, 0)

	SearchIcon.Name = "SearchIcon"
	SearchIcon.Parent = SearchFrame
	SearchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	SearchIcon.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	SearchIcon.BackgroundTransparency = 1
	SearchIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	SearchIcon.Size = UDim2.new(0, 16, 0, 16)
	SearchIcon.Image = "rbxassetid://8154282545"
	SearchIcon.ImageColor3 = Color3.fromRGB(240, 240, 230)

    SearchBox.Name = "SearchBox"
    SearchBox.Parent = PageSearch
    SearchBox.Active = true
    SearchBox.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
    SearchBox.BackgroundTransparency = 1
    SearchBox.CursorPosition = -1
    SearchBox.Position = UDim2.new(0, 30, 0, 0)
    SearchBox.Size = UDim2.new(1, -30, 1, 0)
    SearchBox.Font = Enum.Font.GothamBold
    SearchBox.PlaceholderColor3 = Color3.fromRGB(170, 170, 160)
    SearchBox.PlaceholderText = "Tìm kiếm mục..."
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(235, 235, 230)
    SearchBox.TextSize = 12
    SearchBox.TextTruncate = Enum.TextTruncate.AtEnd
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left

	MainPage.Name = "MainPage"
	MainPage.Parent = Concacmain
	MainPage.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	MainPage.BackgroundTransparency = 1.000
	MainPage.ClipsDescendants = true
	MainPage.Position = UDim2.new(0, 177, 0, 5)
	MainPage.Size = UDim2.new(1, -183, 1, -10)

	UIPage.Name = "UIPage"
	UIPage.Parent = MainPage
	UIPage.FillDirection = Enum.FillDirection.Vertical
	UIPage.SortOrder = Enum.SortOrder.LayoutOrder
	UIPage.EasingDirection = Enum.EasingDirection.InOut
	UIPage.EasingStyle = Enum.EasingStyle.Quart
	UIPage.Padding = UDim.new(0, 10)
	UIPage.TweenTime = DisableAnimation and 0 or 0.35

	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ControlList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
	end)

	local Shadow = Instance.new("ImageLabel", Main)
	Shadow.Name = "Shadow"
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	Shadow.BackgroundTransparency = 1
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Size = UDim2.new(1, 40, 1, 40)
	Shadow.ZIndex = 0
	Shadow.Image = "rbxassetid://5028857084"
	Shadow.ImageTransparency = 0.35
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(24, 24, 276, 276)

    -- Thêm biến để lưu thông tin section
    local sectionInfo = {}
    
    -- Tạo hàm GlobalSearch nếu chưa tồn tại
    if not GlobalSearch then
        GlobalSearch = function(searchText)
            searchText = string.lower(searchText)
            
            if searchText == "" then
                -- Hiển thị tất cả như cũ
                for _, control in pairs(getgenv().AllControls) do
                    control.TabButton.Visible = true
                    control.Section.Visible = true
                    control.Element.Visible = true
                end
                -- Hiển thị tất cả tab
                for _, tab in pairs(ControlList:GetChildren()) do
                    if not tab:IsA('UIListLayout') then
                        tab.Visible = true
                    end
                end
                return
            end
            
            -- Ẩn tất cả trước
            for _, control in pairs(getgenv().AllControls) do
                control.Section.Visible = false
                control.Element.Visible = false
            end
            
            -- Ẩn tất cả tab
            for _, tab in pairs(ControlList:GetChildren()) do
                if not tab:IsA('UIListLayout') then
                    tab.Visible = false
                end
            end
            
            -- Tạo bản đồ section
            local sectionsWithElements = {}
            local elementsInSection = {}
            
            -- Phân tích từng control
            for _, control in pairs(getgenv().AllControls) do
                local elementName = string.lower(control.Name or "")
                local sectionName = string.lower(control.SectionName or "")
                
                -- Kiểm tra phần tử (sử dụng string.find thay vì string.match)
                local elementFound = string.find(elementName, searchText, 1, true) ~= nil
                -- Kiểm tra section
                local sectionFound = string.find(sectionName, searchText, 1, true) ~= nil
                
                -- Tạo bản đồ section
                if not elementsInSection[control.Section] then
                    elementsInSection[control.Section] = {}
                end
                table.insert(elementsInSection[control.Section], {
                    control = control,
                    elementFound = elementFound,
                    sectionFound = sectionFound
                })
                
                -- Đánh dấu section có phần tử khớp
                if elementFound then
                    sectionsWithElements[control.Section] = true
                end
            end
            
            -- Xử lý hiển thị
            local foundTabs = {}
            
            for section, elements in pairs(elementsInSection) do
                local shouldShowSection = false
                local hasElementMatch = false
                
                -- Kiểm tra section có khớp không
                for _, elementInfo in ipairs(elements) do
                    if elementInfo.sectionFound then
                        shouldShowSection = true
                    end
                    if elementInfo.elementFound then
                        hasElementMatch = true
                    end
                end
                
                -- Logic hiển thị
                for _, elementInfo in ipairs(elements) do
                    local control = elementInfo.control
                    
                    if elementInfo.elementFound then
                        -- Phần tử khớp: hiển thị phần tử
                        control.Element.Visible = true
                        
                        -- Nếu section cũng khớp hoặc có phần tử khớp: hiện section
                        if elementInfo.sectionFound or hasElementMatch then
                            control.Section.Visible = true
                        end
                        
                        foundTabs[control.TabName] = true
                        control.TabButton.Visible = true
                    elseif elementInfo.sectionFound and not hasElementMatch then
                        -- Section khớp nhưng không có phần tử khớp: chỉ hiện section
                        control.Section.Visible = true
                        control.Element.Visible = false
                        
                        foundTabs[control.TabName] = true
                        control.TabButton.Visible = true
                    end
                end
            end
            
            -- Hiển thị các tab có kết quả
            for tabName, _ in pairs(foundTabs) do
                for _, tab in pairs(ControlList:GetChildren()) do
                    if not tab:IsA('UIListLayout') and string.find(tab.Name, tabName, 1, true) then
                        tab.Visible = true
                    end
                end
            end
            
            -- Nếu không tìm thấy gì cả, hiển thị thông báo
            if not next(foundTabs) then
                -- Có thể thêm thông báo "Không tìm thấy kết quả" ở đây nếu muốn
            end
        end
    end
    
    -- Kết nối sự kiện search (giữ nguyên)
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        GlobalSearch(SearchBox.Text)
    end)

	local Main_Function = {}

	local LayoutOrderBut = -1
	local LayoutOrder = -1
	local PageCounter = 1

	function Main_Function:AddTab(PageName)

		local Page_Name = tostring(PageName)
		local Page_Title = Page_Name

		LayoutOrder = LayoutOrder + 1
		LayoutOrderBut = LayoutOrderBut + 1

		--Control 
		local PageName = Instance.new("Frame")
		local Frame = Instance.new("Frame")
		local TabNameCorner = Instance.new("UICorner")
		local Line = Instance.new("Frame")
		local InLine = Instance.new("Frame")
		local LineCorner = Instance.new("UICorner")
		local TabTitleContainer = Instance.new("Frame")
		local TabTitle = Instance.new("TextLabel")
		local PageButton = Instance.new("TextButton")


		PageName.Name = Page_Name .. "_Control"
		PageName.Parent = ControlList
		PageName.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageName.BackgroundTransparency = 1.000
		PageName.Size = UDim2.new(1, -10, 0, 30)
		PageName.LayoutOrder = LayoutOrderBut

		Frame.Parent = PageName
		Frame.BackgroundColor3 = getgenv().UIColor["Page Selected Color"]
		Frame.BackgroundTransparency = 1.000
		Frame.Position = UDim2.new(0, 5, 0, 0)
		Frame.Size = UDim2.new(1, -5, 1, 0)

		TabNameCorner.CornerRadius = UDim.new(0, 8)
		TabNameCorner.Name = "TabNameCorner"
		TabNameCorner.Parent = Frame

		Line.Name = "Line"
		Line.Parent = Frame
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		Line.BackgroundTransparency = 1.000
		Line.Position = UDim2.new(0, 4, 0.5, 0)
		Line.Size = UDim2.new(1, -8, 1, 0)

		InLine.Name = "PageInLine"
		InLine.Parent = Line
		InLine.AnchorPoint = Vector2.new(0, 0.5)
		InLine.BorderSizePixel = 0
		InLine.Position = UDim2.new(0, 0, 0.5, 0)
		InLine.Size = UDim2.new(0, 4, 1, -8)
		InLine.BackgroundColor3 = getgenv().UIColor["Page Selected Color"]
		InLine.BackgroundTransparency = 1.000

		LineCorner.Name = "LineCorner"
		LineCorner.CornerRadius = UDim.new(1, 0)
		LineCorner.Parent = InLine

		TabTitleContainer.Name = "TabTitleContainer"
		TabTitleContainer.Parent = Frame
		TabTitleContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TabTitleContainer.BackgroundTransparency = 1.000
		TabTitleContainer.Position = UDim2.new(0, 15, 0, 0)
		TabTitleContainer.Size = UDim2.new(1, -15, 1, 0)

		TabTitle.Name = "GUITextColor"
		TabTitle.Parent = TabTitleContainer
		TabTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TabTitle.BackgroundTransparency = 1.000
		TabTitle.Size = UDim2.new(1, 0, 1, 0)
		TabTitle.Font = Enum.Font.GothamBold
		TabTitle.Text = Page_Name
		TabTitle.TextColor3 = Color3.fromRGB(230, 230, 230)
		TabTitle.TextSize = 12.000
		TabTitle.TextXAlignment = Enum.TextXAlignment.Left
		TabTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]

		PageButton.Name = "PageButton"
		PageButton.Parent = PageName
		PageButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageButton.BackgroundTransparency = 1.000
		PageButton.Size = UDim2.new(1, 0, 1, 0)
		PageButton.Font = Enum.Font.SourceSans
		PageButton.Text = ""
		PageButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		PageButton.TextSize = 14.000

		-- Container

		local PageContainer = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local PageTitle = Instance.new("TextLabel")
		local PageList = Instance.new("ScrollingFrame")
		local Pagelistlayout = Instance.new("UIListLayout")

		local CurrentPage = PageCounter
		PageCounter = PageCounter + 1
		PageContainer.Name = "Page" .. CurrentPage
		PageContainer.Parent = MainPage
		PageContainer.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
		PageContainer.Position = UDim2.new(0, 0, 0, 0)
		PageContainer.Size = UDim2.new(1, 0, 1, 0)
		PageContainer.LayoutOrder = LayoutOrder
		PageContainer.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]

		UICorner.CornerRadius = UDim.new(0, 8)
		UICorner.Parent = PageContainer

		PageTitle.Name = "GUITextColor"
		PageTitle.Parent = PageContainer
		PageTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageTitle.BackgroundTransparency = 1.000
		PageTitle.Position = UDim2.new(0, 5, 0, 0)
		PageTitle.Size = UDim2.new(1, 0, 0, 25)
		PageTitle.Font = Enum.Font.GothamBold
		PageTitle.Text = Page_Title
		PageTitle.TextSize = 16.000
		PageTitle.TextXAlignment = Enum.TextXAlignment.Left
		PageTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]

		PageList.Name = "PageList"
		PageList.Parent = PageContainer
		PageList.Active = true
		PageList.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageList.BackgroundTransparency = 1.000
		PageList.BorderColor3 = Color3.fromRGB(27, 42, 53)
		PageList.BorderSizePixel = 0
		PageList.Position = UDim2.new(0, 5, 0, 30)
		PageList.Size = UDim2.new(1, -10, 1, -30)
		PageList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageList.ScrollBarThickness = 5
		PageList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageList.ScrollingEnabled = true
		PageList.VerticalScrollBarInset = Enum.ScrollBarInset.Always

		Pagelistlayout.Name = "Pagelistlayout"
		Pagelistlayout.Parent = PageList
		Pagelistlayout.SortOrder = Enum.SortOrder.LayoutOrder
		Pagelistlayout.Padding = UDim.new(0, 5)
		Pagelistlayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			PageList.CanvasSize = UDim2.new(0, 0, 0, Pagelistlayout.AbsoluteContentSize.Y)
		end)

		local PageSearch = Instance.new("Frame")
		local PageSearchCorner = Instance.new("UICorner")
		local SearchFrame = Instance.new("Frame")
		local SearchIcon = Instance.new("ImageLabel")
		local SearchButton = Instance.new("TextButton")
		local SearchBox = Instance.new("TextBox")

		PageSearch.Name = "Page Search"
		PageSearch.Parent = PageContainer
		PageSearch.AnchorPoint = Vector2.new(1, 0)
		PageSearch.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
		PageSearch.Position = UDim2.new(1, -5, 0, 5)
		PageSearch.Size = UDim2.new(0, 20, 0, 20)
		PageSearch.ClipsDescendants = true

		PageSearchCorner.CornerRadius = UDim.new(0, 6)
		PageSearchCorner.Name = "PageSearchCorner"
		PageSearchCorner.Parent = PageSearch

		SearchFrame.Name = "SearchFrame"
		SearchFrame.Parent = PageSearch
		SearchFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchFrame.BackgroundTransparency = 1.000
		SearchFrame.Size = UDim2.new(0, 20, 0, 20)

		SearchIcon.Name = "SearchIcon"
		SearchIcon.Parent = SearchFrame
		SearchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchIcon.BackgroundTransparency = 1.000
		SearchIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
		SearchIcon.Size = UDim2.new(0, 16, 0, 16)
		SearchIcon.Image = "rbxassetid://8154282545"
		SearchIcon.ImageColor3 = getgenv().UIColor["Search Icon Color"]

		SearchButton.Name = "Search Button"
		SearchButton.Parent = SearchFrame
		SearchButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchButton.BackgroundTransparency = 1.000
		SearchButton.Size = UDim2.new(1, 0, 1, 0)
		SearchButton.Font = Enum.Font.SourceSans
		SearchButton.Text = ""
		SearchButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		SearchButton.TextSize = 14.000

		SearchBox.Name = "Search Box"
		SearchBox.Parent = PageSearch
		SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchBox.BackgroundTransparency = 1.000
		SearchBox.Position = UDim2.new(0, 30, 0, 0)
		SearchBox.Size = UDim2.new(1, -30, 1, 0)
		SearchBox.Font = Enum.Font.GothamBold
		SearchBox.Text = ""
		SearchBox.TextSize = 14.000
		SearchBox.TextXAlignment = Enum.TextXAlignment.Left
		SearchBox.PlaceholderText = "Tìm tên mục..."
		SearchBox.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
		SearchBox.TextColor3 = getgenv().UIColor["Text Color"]
		
		local Openned = false 

		SearchButton.MouseEnter:Connect(function()
			TweenService:Create(SearchIcon, TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]), {
				ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
			}):Play()
		end)

		SearchButton.MouseLeave:Connect(function()
			TweenService:Create(SearchIcon, TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]), {
				ImageColor3 = getgenv().UIColor["Search Icon Color"]
			}):Play()
		end)

		SearchButton.MouseButton1Click:Connect(function()
			Openned = not Openned
			local size = Openned and UDim2.new(0, 175, 0, 20) or  UDim2.new(0, 20, 0, 20)
			game.TweenService:Create(PageSearch, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
				Size = size
			}):Play()
		end)

		local function hideOtherFrame()
			for i, v in next, PageList:GetChildren() do 
				if not v:IsA('UIListLayout') then 
					v.Visible = false
				end
			end
		end
		
		local function showFrameName()
			for i, v in pairs(PageList:GetChildren()) do
				if not v:IsA('UIListLayout') then 
					if string.find(string.lower(v.Name), string.lower(SearchBox.Text)) then 
						v.Visible = true
					end
				end
			end
		end
		
		SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
			hideOtherFrame()
			showFrameName()
		end)

		for i, v in pairs(ControlList:GetChildren()) do
			if not (v:IsA('UIListLayout')) then
				if i == 2 then 
					v.Frame.Line.PageInLine.BackgroundTransparency = 0
					v.Frame.BackgroundTransparency = 0.85
				end
			end
		end

		PageButton.MouseButton1Click:Connect(function()
			if tostring(UIPage.CurrentPage) == PageContainer.Name then 
				return
			end

			for i, v in pairs(MainPage:GetChildren()) do
				if not (v:IsA('UIPageLayout')) and not (v:IsA('UICorner')) then
					v.Visible = false
				end
			end

			PageContainer.Visible = true 
			UIPage:JumpTo(PageContainer)

			for i, v in next, ControlList:GetChildren() do
				if not (v:IsA('UIListLayout')) then
					if v.Name == Page_Name .. "_Control" then 
						TweenService:Create(v.Frame.Line.PageInLine, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundTransparency = 0
						}):Play()
						TweenService:Create(v.Frame, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundTransparency = 0.85
						}):Play()
					else
						TweenService:Create(v.Frame.Line.PageInLine, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundTransparency = 1
						}):Play()
						TweenService:Create(v.Frame, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundTransparency = 1
						}):Play()
					end
				end
			end
		end)

		local pageFunction = {}

		function pageFunction:AddSection(Section_Name, Toggleable, SectionGap, SectionColor)
			local Toggleable = Toggleable or false
			local Section = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Topsec = Instance.new("Frame")
			local Sectiontitle = Instance.new("TextLabel")
			local Linesec = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")
			local SectionList = Instance.new("UIListLayout")
			
			Section.Name = Section_Name .. "_Dot"
			Section.Parent = PageList
			Section.Size = UDim2.new(1, -5, 0, 30)
			Section.BackgroundColor3 = Color3.fromRGB(48, 48, 56)
			Section.BackgroundTransparency = 0.25
			Section.ClipsDescendants = true

			local sectionStroke = Instance.new("UIStroke", Section)
			sectionStroke.Color = Color3.fromRGB(120, 120, 140)
			sectionStroke.Thickness = 1
			sectionStroke.Transparency = 0.75

			local sectionGradient = Instance.new("UIGradient", Section)
			sectionGradient.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 46)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(48, 48, 56))
			}
			sectionGradient.Rotation = 90
			sectionGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0.05),
				NumberSequenceKeypoint.new(1, 0.15)
			}

			UICorner.CornerRadius = UDim.new(0, 8)
			UICorner.Parent = Section

			Topsec.Name = "Topsec"
			Topsec.Parent = Section
			Topsec.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Topsec.BackgroundTransparency = 1.000
			Topsec.Size = UDim2.new(0, 445, 0, 30)

			Sectiontitle.Name = "Sectiontitle"
			Sectiontitle.Parent = Topsec
			Sectiontitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Sectiontitle.BackgroundTransparency = 1.000
			Sectiontitle.Size = UDim2.new(1, 0, 1, 0)
			Sectiontitle.Font = Enum.Font.GothamBold
			Sectiontitle.Text = Section_Name
			Sectiontitle.TextSize = 14.000
			Sectiontitle.TextColor3 = getgenv().UIColor["Section Text Color"]

			Linesec.Name = "Linesec"
			Linesec.Parent = Topsec
			Linesec.AnchorPoint = Vector2.new(0.5, 1)
			Linesec.BorderSizePixel = 0
			Linesec.Position = UDim2.new(0.5, 0, 1, -2)
			Linesec.Size = UDim2.new(1, -10, 0, 2)
			Linesec.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]

			local LineShadow = Instance.new("ImageLabel", Linesec)
			LineShadow.Name = "LineShadow"
			LineShadow.AnchorPoint = Vector2.new(0.5, 0.5)
			LineShadow.BackgroundColor3 = Color3.fromRGB(163,162,165)
			LineShadow.BackgroundTransparency = 1
			LineShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
			LineShadow.Size = UDim2.new(1, 8, 1, 8)
			LineShadow.ZIndex = 0
			LineShadow.Image = "rbxassetid://5028857084"
			LineShadow.ImageTransparency = 0.6
			LineShadow.ScaleType = Enum.ScaleType.Slice
			LineShadow.SliceCenter = Rect.new(24, 24, 276, 276)

			UIGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.51, 0.02),
				NumberSequenceKeypoint.new(1, 1)
			}
			UIGradient.Parent = Linesec

			SectionList.Name = "SectionList"
			SectionList.Parent = Section
			SectionList.SortOrder = Enum.SortOrder.LayoutOrder
			SectionList.Padding = UDim.new(0, 5)

			local SizeSectionY
			local sectionIsVisible = false
			if Toggleable then
				local VisibilitySectionFrame = Instance.new("Frame")
				local VisibilitySectionFrameCorner = Instance.new("UICorner")
				local visibility = Instance.new("ImageButton")
				local visibility_off = Instance.new("ImageButton")
				local VisibilityButton = Instance.new("TextButton")
				VisibilityButton.Name = "VisibilityButton"
				VisibilityButton.Parent = Topsec
				VisibilityButton.AnchorPoint = Vector2.new(1, 0.5)
				VisibilityButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				VisibilityButton.BackgroundTransparency = 1.000
				VisibilityButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				VisibilityButton.BorderSizePixel = 0
				VisibilityButton.Font = Enum.Font.SourceSans
				VisibilityButton.Text = ""
				VisibilityButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				VisibilityButton.TextSize = 14.000
				VisibilityButton.ZIndex = 2
				VisibilityButton.Position = UDim2.new(1, -5, 0.5, 0)
				VisibilityButton.Size = UDim2.new(0, 20, 0, 20)
				VisibilitySectionFrame.Name = "VisibilitySectionFrame"
				VisibilitySectionFrame.Parent = Topsec
				VisibilitySectionFrame.AnchorPoint = Vector2.new(1, 0.5)
				VisibilitySectionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				VisibilitySectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				VisibilitySectionFrame.BorderSizePixel = 0
				VisibilitySectionFrame.Position = UDim2.new(1, -5, 0.5, 0)
				VisibilitySectionFrame.Size = UDim2.new(0, 20, 0, 20)
				VisibilitySectionFrameCorner.CornerRadius = UDim.new(0, 8)
				VisibilitySectionFrameCorner.Name = "VisibilitySectionFrameCorner"
				VisibilitySectionFrameCorner.Parent = VisibilitySectionFrame
				visibility.Name = "visibility"
				visibility.Parent = VisibilitySectionFrame
				visibility.AnchorPoint = Vector2.new(0.5, 0.5)
				visibility.BackgroundTransparency = 1.000
				visibility.LayoutOrder = 4
				visibility.Position = UDim2.new(0.5, 0, 0.5, 0)
				visibility.Size = UDim2.new(1, -4, 1, -4)
				visibility.ZIndex = 2
				visibility.Image = "rbxassetid://3926307971"
				visibility.ImageRectOffset = Vector2.new(84, 44)
				visibility.ImageRectSize = Vector2.new(36, 36)
				visibility.ImageTransparency = 1
				visibility_off.Name = "visibility_off"
				visibility_off.Parent = VisibilitySectionFrame
				visibility_off.AnchorPoint = Vector2.new(0.5, 0.5)
				visibility_off.BackgroundTransparency = 1.000
				visibility_off.LayoutOrder = 4
				visibility_off.Position = UDim2.new(0.5, 0, 0.5, 0)
				visibility_off.Size = UDim2.new(1, -4, 1, -4)
				visibility_off.ZIndex = 2
				visibility_off.Image = "rbxassetid://3926307971"
				visibility_off.ImageRectOffset = Vector2.new(564, 44)
				visibility_off.ImageRectSize = Vector2.new(36, 36)
				visibility_off.ImageTransparency = 0
				VisibilityButton.MouseButton1Down:Connect(function()
					sectionIsVisible = not sectionIsVisible
					TweenService:Create(visibility, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"] / 2), {
						ImageTransparency = sectionIsVisible and 0 or 1
					}):Play()
					wait(getgenv().UIColor["Tween Animation 1 Speed"] / 4)
					TweenService:Create(visibility_off, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"] / 2), {
						ImageTransparency = sectionIsVisible and 1 or 0
					}):Play()
					TweenService:Create(Section, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size =  UDim2.new(1, -5, 0, (sectionIsVisible and SizeSectionY or 30))
					}):Play()
				end)
			end
			if SectionGap then
				local SectionGap = Instance.new("Frame")
				SectionGap.Name = "SectionGap"
				SectionGap.Parent = PageList
				SectionGap.Size = UDim2.new(1, -5, 0, 30)
				SectionGap.ClipsDescendants = true
				SectionGap.Transparency = 1
			end

			SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if (not Toggleable) then
					Section.Size = UDim2.new(1, -5, 0, SectionList.AbsoluteContentSize.Y + 5)
				end
				SizeSectionY = SectionList.AbsoluteContentSize.Y + 5
				if sectionIsVisible then
					TweenService:Create(Section, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size =  UDim2.new(1, -5, 0, SizeSectionY)
					}):Play()
				end
			end)
			local sectionFunction = {}
			function sectionFunction:AddToggle(idk,Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local Desc = Setting.Desc or Setting.Description
				local Default = Setting.Default
				if Default == nil then
					Default = false
				end
				local Callback = Setting.Callback
				local ToggleFrame = Instance.new("Frame")
				local TogFrame1 = Instance.new("Frame")
				local checkbox = Instance.new("ImageLabel")
				local check = Instance.new("Frame")
				local ToggleDesc = Instance.new("TextLabel")
				local ToggleTitle = Instance.new("TextLabel")
				local ToggleBg = Instance.new("Frame")
				local ToggleCorner = Instance.new("UICorner")
				local ToggleButton = Instance.new("TextButton")
				local ToggleList = Instance.new("UIListLayout")
				ToggleFrame.Name = "ToggleFrame"
				ToggleFrame.Parent = Section
				ToggleFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ToggleFrame.BackgroundTransparency = 1.000
				ToggleFrame.Position = UDim2.new(0, 0, 0.300000012, 0)
				ToggleFrame.Size = UDim2.new(1, 0 , 0, 0)
				ToggleFrame.AutomaticSize = Enum.AutomaticSize.Y
				TogFrame1.Name = "TogFrame1"
				TogFrame1.Parent = ToggleFrame
				TogFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
				TogFrame1.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				TogFrame1.BackgroundTransparency = 1.000
				TogFrame1.Position = UDim2.new(0.5, 0, 0.5, 0)
				TogFrame1.Size = UDim2.new(1, -10, 0, 0)
				TogFrame1.AutomaticSize = Enum.AutomaticSize.Y
				checkbox.Name = "checkbox"
				checkbox.Parent = TogFrame1
				checkbox.AnchorPoint = Vector2.new(1, 0.5)
				checkbox.BackgroundColor3 = Color3.fromRGB(60, 63, 75)
				checkbox.BackgroundTransparency = 0
				checkbox.Position = UDim2.new(1, -8, 0.5, 3)
				checkbox.Size = UDim2.new(0, 42, 0, 22)
				checkbox.Image = "rbxassetid://4552505888"
				checkbox.ImageTransparency = 1
				checkbox.ImageColor3 = getgenv().UIColor["Toggle Border Color"]
				local SwitchTrackCorner = Instance.new("UICorner", checkbox)
				SwitchTrackCorner.CornerRadius = UDim.new(1, 0)
				check.Name = "check"
				check.Parent = checkbox
				check.AnchorPoint = Vector2.new(0, 0.5)
				check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				check.Position = UDim2.new(0, 3, 0.5, 0)
				check.Size = UDim2.new(0, 16, 0, 16)
				local SwitchKnobCorner = Instance.new("UICorner", check)
				SwitchKnobCorner.CornerRadius = UDim.new(1, 0)
				local cac = 5
				if Desc then
					cac = 0
					ToggleDesc.Name = "ToggleDesc"
					ToggleDesc.Parent = TogFrame1
					ToggleDesc.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
					ToggleDesc.BackgroundTransparency = 1.000
					ToggleDesc.Position = UDim2.new(0, 15, 0, 20)
					ToggleDesc.Size = UDim2.new(1, -50, 0, 0)
					ToggleDesc.Font = Enum.Font.GothamBlack
					ToggleDesc.Text = Desc
					ToggleDesc.TextSize = 13.000
					ToggleDesc.TextWrapped = true
					ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
					ToggleDesc.RichText = true
					ToggleDesc.AutomaticSize = Enum.AutomaticSize.Y
					ToggleDesc.TextColor3 = getgenv().UIColor["Toggle Desc Color"]
				else
					ToggleDesc.Text = ''
				end
				ToggleTitle.Name = "TextColor"
				ToggleTitle.Parent = TogFrame1
				ToggleTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ToggleTitle.BackgroundTransparency = 1.000
				ToggleTitle.Position = UDim2.new(0, 10, 0, cac)
				ToggleTitle.Size = UDim2.new(1, -10, 0, 20)
				ToggleTitle.Font = Enum.Font.GothamBlack
				ToggleTitle.Text = Title
				ToggleTitle.TextSize = 14.000
				ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
				ToggleTitle.TextYAlignment = Enum.TextYAlignment.Center
				ToggleTitle.RichText = true
				ToggleTitle.AutomaticSize = Enum.AutomaticSize.Y
				ToggleTitle.TextColor3 = getgenv().UIColor["Text Color"]
				ToggleBg.Name = "Background1"
				ToggleBg.Parent = TogFrame1
				ToggleBg.Size = UDim2.new(1, 0, 1, 6)
				ToggleBg.ZIndex = 0
				ToggleBg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				ToggleBg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				ToggleCorner.CornerRadius = UDim.new(0, 8)
				ToggleCorner.Name = "ToggleCorner"
				ToggleCorner.Parent = ToggleBg
				local ToggleStroke = Instance.new("UIStroke", ToggleBg)
				ToggleStroke.Thickness = 1
				ToggleStroke.Transparency = 0.75
				ToggleStroke.Color = Color3.fromRGB(120, 120, 140)
				ToggleButton.Name = "ToggleButton"
				ToggleButton.Parent = TogFrame1
				ToggleButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ToggleButton.BackgroundTransparency = 1.000
				ToggleButton.AnchorPoint = Vector2.new(1, 0.5)
				ToggleButton.Size = UDim2.new(0, 42, 0, 22)
				ToggleButton.Position = UDim2.new(1, -8, 0.5, 3)
				ToggleButton.Font = Enum.Font.SourceSans
				ToggleButton.Text = ""
				ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				ToggleButton.TextSize = 14.000
				ToggleList.Name = "ToggleList"
				ToggleList.Parent = ToggleFrame
				ToggleList.HorizontalAlignment = Enum.HorizontalAlignment.Center
				ToggleList.SortOrder = Enum.SortOrder.LayoutOrder
				ToggleList.VerticalAlignment = Enum.VerticalAlignment.Center
				ToggleList.Padding = UDim.new(0, 5)
				local function ChangeStage(val)
					local knobPos = val and UDim2.new(1, -3, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
					local knobAnchor = val and Vector2.new(1, 0.5) or Vector2.new(0, 0.5)
					local trackColor = val and getgenv().UIColor["Toggle Border Color"] or Color3.fromRGB(60, 63, 75)
					game.TweenService:Create(check, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Position = knobPos,
						AnchorPoint = knobAnchor
					}):Play()
					game.TweenService:Create(checkbox, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						BackgroundColor3 = trackColor
					}):Play()
				end
				ChangeStage(Default)
				local function ButtonClick()
					Default = not Default
				    ChangeStage(Default)
				    if Callback then
				        pcall(Callback, Default)
				    end
				end
				ToggleButton.MouseButton1Down:Connect(function()
					ButtonClick()
				end)
				local toggleFunction = {}
				function toggleFunction.SetStage(value)
					if value ~= Default then
						ButtonClick()
					end
				end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = ToggleFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
                if Callback and Default ~= nil then
                    pcall(Callback, Default)
                end
                
				return toggleFunction
			end
        function sectionFunction:AddButton(Setting, Callback)
        	local Title = Setting.Title or Setting.Text or ""
        	local Callback = Setting.Callback or Setting.Func or function() end
            local Button = Instance.new("Frame")
            local RowBG_1 = Instance.new("Frame")
            local UICorner_1 = Instance.new("UICorner")
            local RowHover_1 = Instance.new("Frame")
            local UICorner_2 = Instance.new("UICorner")
            local TextColor_1 = Instance.new("TextLabel")
            local ClickArea_1 = Instance.new("Frame")
            local UICorner_3 = Instance.new("UICorner")
            local UIGradient_1 = Instance.new("UIGradient")
            local ImageLabel_1 = Instance.new("ImageLabel")
            local Frame_1 = Instance.new("Frame")
            local UICorner_4 = Instance.new("UICorner")
            local UIScale_1 = Instance.new("UIScale")
            local Button_1 = Instance.new("TextButton")
            
            Button.Name = "Button"
            Button.Parent = Section
            Button.BackgroundColor3 = Color3.fromRGB(163,162,165)
            Button.BackgroundTransparency = 1
            Button.Size = UDim2.new(1, 0,0, 40)
             
            RowBG_1.Name = "RowBG"
            RowBG_1.Parent = Button
            RowBG_1.AnchorPoint = Vector2.new(0.5, 0.5)
            RowBG_1.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
            RowBG_1.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
            RowBG_1.Position = UDim2.new(0.5, 0,0.5, 0)
            RowBG_1.Size = UDim2.new(1, -10,1, 0)
             
            UICorner_1.Parent = RowBG_1
            UICorner_1.CornerRadius = UDim.new(0,10)
             
            RowHover_1.Name = "RowHover"
            RowHover_1.Parent = RowBG_1
            RowHover_1.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
            RowHover_1.BackgroundTransparency = 1
            RowHover_1.Size = UDim2.new(1, 0,1, 0)
            RowHover_1.ZIndex = 2
             
            UICorner_2.Parent = RowHover_1
            UICorner_2.CornerRadius = UDim.new(0,10)
             
            TextColor_1.Name = "TextColor"
            TextColor_1.Parent = RowBG_1
             TextColor_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
             TextColor_1.BackgroundTransparency = 1
             TextColor_1.Position = UDim2.new(0, 12,0, 0)
             TextColor_1.Size = UDim2.new(1, -110,1, 0)
             TextColor_1.Font = Enum.Font.GothamBold
             TextColor_1.Text = Title
             TextColor_1.TextColor3 = getgenv().UIColor["GUI Text Color"]
             TextColor_1.TextSize = 14
             TextColor_1.TextStrokeTransparency = 0.8500000238418579
             TextColor_1.TextXAlignment = Enum.TextXAlignment.Left
             
             ClickArea_1.Name = "ClickArea"
             ClickArea_1.Parent = RowBG_1
             ClickArea_1.AnchorPoint = Vector2.new(1, 0.5)
             ClickArea_1.BackgroundColor3 = Color3.fromRGB(56, 132, 255)
             ClickArea_1.Position = UDim2.new(1, -8,0.5, 0)
             ClickArea_1.Size = UDim2.new(0, 94,0, 30)
             ClickArea_1.ClipsDescendants = true  -- THÊM DÒNG NÀY: Ngăn ripple tràn ra
             
             UICorner_3.Parent = ClickArea_1
             UICorner_3.CornerRadius = UDim.new(0, 12)
             
             UIGradient_1.Parent = ClickArea_1
             UIGradient_1.Color = ColorSequence.new{
                 ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 216, 77)), 
                 ColorSequenceKeypoint.new(0.4, Color3.fromRGB(56, 132, 255)), 
                 ColorSequenceKeypoint.new(0.6, Color3.fromRGB(235, 186, 17)), 
                 ColorSequenceKeypoint.new(1, Color3.fromRGB(215, 166, 7))
             }
             UIGradient_1.Rotation = 90
             
             ImageLabel_1.Parent = ClickArea_1
             ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
             ImageLabel_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
             ImageLabel_1.BackgroundTransparency = 1
             ImageLabel_1.Position = UDim2.new(0.5, 0,0.5, 0)
             ImageLabel_1.Size = UDim2.new(1, 14,1, 14)
             ImageLabel_1.ZIndex = 0
             ImageLabel_1.Image = "rbxassetid://5028857084"
             ImageLabel_1.ImageTransparency = 0.7
             ImageLabel_1.ScaleType = Enum.ScaleType.Slice
             ImageLabel_1.SliceCenter = Rect.new(24, 24, 276, 276)
             
             Frame_1.Parent = ClickArea_1
             Frame_1.AnchorPoint = Vector2.new(0.5, 0)
             Frame_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
             Frame_1.BackgroundTransparency = 0.8
             Frame_1.Position = UDim2.new(0.5, 0,0, 2)
             Frame_1.Size = UDim2.new(1, -6,0, 10)
             Frame_1.ZIndex = 2
             
             UICorner_4.Parent = Frame_1
             UICorner_4.CornerRadius = UDim.new(0,10)
             
             UIScale_1.Parent = ClickArea_1
             
             Button_1.Name = "Button"
             Button_1.Parent = ClickArea_1
             Button_1.Active = true
             Button_1.AutoButtonColor = false
             Button_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
             Button_1.BackgroundTransparency = 1
             Button_1.Size = UDim2.new(1, 0,1, 0)
             Button_1.Font = Enum.Font.GothamBold
             Button_1.Text = "Click"
             Button_1.TextColor3 = Color3.fromRGB(240, 240, 240)
             Button_1.TextSize = 13

             -- UIScale mặc định
             UIScale_1.Scale = 1
             
             -- HOVER (chỉ phóng to)
             local scaleHover = TweenService:Create(UIScale_1, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1.05 })
             local scaleNormal = TweenService:Create(UIScale_1, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1 })
             
             Button_1.MouseEnter:Connect(function()
             	scaleHover:Play()
             end)
             
             Button_1.MouseLeave:Connect(function()
             	scaleNormal:Play()
             end)
             
                Button_1.MouseButton1Down:Connect(function()
                    
                    -- Lấy kích thước thực tế của ClickArea
                    local w = ClickArea_1.AbsoluteSize.X
                    local h = ClickArea_1.AbsoluteSize.Y
                    
                    -- Tạo ripple với hình dạng bo góc giống button (chữ nhật bo góc)
                    local ripple = Instance.new("Frame")
                    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
                    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
                    ripple.Size = UDim2.new(0, 0, 0, 0)
                    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ripple.BackgroundTransparency = 0.6
                    ripple.ZIndex = 20
                    ripple.Parent = ClickArea_1
                    
                    -- Tạo UICorner cho ripple với bo góc y hệt button
                    local rippleCorner = Instance.new("UICorner")
                    rippleCorner.CornerRadius = UICorner_3.CornerRadius -- Lấy góc bo từ button
                    rippleCorner.Parent = ripple
                    
                    -- Animation ripple mở rộng từ tâm ra đầy đủ button
                    local rippleTween = TweenService:Create(
                        ripple,
                        TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {
                            Size = UDim2.new(1, 0, 1, 0),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0.5, 0, 0.5, 0)
                        }
                    )
                    
                    rippleTween:Play()
                    rippleTween.Completed:Connect(function()
                        ripple:Destroy()
                    end)
                    
                    Callback()
                end)
                local f = {}
                function f:SetTitle(vl)
                    TextColor_1.Text = vl
                end
                local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = Button,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
                return f
            end
        
			function sectionFunction:AddLabel(text)
				local Title = text
                local LabelFrame = Instance.new("Frame")
                local LabelBG = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local TextColor = Instance.new("TextLabel")
                
                LabelFrame.Name = "LabelFrame"
                LabelFrame.Parent = Section
                LabelFrame.AutomaticSize = Enum.AutomaticSize.Y
                LabelFrame.BackgroundColor3 = Color3.fromRGB(163,162,165)
                LabelFrame.BackgroundTransparency = 1
                LabelFrame.Size = UDim2.new(1, 0,0, 0)
                
                LabelBG.Name = "LabelBG"
                LabelBG.Parent = LabelFrame
                LabelBG.AnchorPoint = Vector2.new(0.5, 0)
                LabelBG.AutomaticSize = Enum.AutomaticSize.Y
                LabelBG.BackgroundColor3 = Color3.fromRGB(38,38,46)
                LabelBG.BackgroundTransparency = 0.25
                LabelBG.Position = UDim2.new(0.5, 0,0, 0)
                LabelBG.Size = UDim2.new(1, -10,0, -10)
                
                UICorner.Parent = LabelBG
                UICorner.CornerRadius = UDim.new(0,6)
                
                
                TextColor.Name = "TextColor"
                TextColor.Parent = LabelBG
                TextColor.AutomaticSize = Enum.AutomaticSize.Y
                TextColor.BackgroundColor3 = Color3.fromRGB(163,162,165)
                TextColor.BackgroundTransparency = 1
                TextColor.Position = UDim2.new(0, 12,0, 6)
                TextColor.Size = UDim2.new(1, -24,1, -12)
                TextColor.Font = Enum.Font.GothamMedium
                TextColor.Text = Title
                TextColor.TextColor3 = Color3.fromRGB(240,240,230)
                TextColor.TextSize = 14
                TextColor.TextStrokeTransparency = 0.8500000238418579
                TextColor.TextWrapped = true
                TextColor.TextXAlignment = Enum.TextXAlignment.Left
				local labelFunction = {}
				function labelFunction:SetText(text)
					TextColor.Text = text
				end
				function labelFunction.SetColor(color)
					TextColor.TextColor3 = color
				end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = LabelFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return labelFunction
			end
            function sectionFunction:AddDropdownSection(Setting)
                local Title = tostring(Setting.Text or Setting.Title or "")
                local Search = Setting.Search or false
              
                local DropdownFrame = Instance.new("Frame")
                local Dropdownbg = Instance.new("Frame")
                local Dropdowncorner = Instance.new("UICorner")
                local Topdrop = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local ImgDrop = Instance.new("ImageLabel")
                local DropdownButton = Instance.new("TextButton")
                local Dropdownlisttt = Instance.new("Frame")
                local DropdownScroll = Instance.new("ScrollingFrame")
                local ScrollContainer = Instance.new("Frame")
                local ScrollContainerList = Instance.new("UIListLayout")
                
                DropdownFrame.Name = Title .. "DropdownSectionFrame"
                DropdownFrame.Parent = Section
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                DropdownFrame.BackgroundTransparency = 1.000
                DropdownFrame.Position = UDim2.new(0, 0, 0.473684222, 0)
                DropdownFrame.Size = UDim2.new(1, 0, 0, 25)
                
                Dropdownbg.Name = "Background1"
                Dropdownbg.Parent = DropdownFrame
                Dropdownbg.AnchorPoint = Vector2.new(0.5, 0.5)
                Dropdownbg.Position = UDim2.new(0.5, 0, 0.5, 0)
                Dropdownbg.Size = UDim2.new(1, -10, 1, 0)
                Dropdownbg.ClipsDescendants = true
                Dropdownbg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                Dropdownbg.BackgroundTransparency = 0.25
                
                Dropdowncorner.CornerRadius = UDim.new(0, 8)
                Dropdowncorner.Name = "Dropdowncorner"
                Dropdowncorner.Parent = Dropdownbg
                
                Topdrop.Name = "Background2"
                Topdrop.Parent = Dropdownbg
                Topdrop.Size = UDim2.new(1, 0, 0, 25)
                Topdrop.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                Topdrop.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                
                UICorner.CornerRadius = UDim.new(0, 8)
                UICorner.Parent = Topdrop
                
                local Dropdowntitle
                if Search then
                    Dropdowntitle = Instance.new("TextBox")
                    Dropdowntitle.PlaceholderText = Title
                    Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
                else
                    Dropdowntitle = Instance.new("TextLabel")
                    Dropdowntitle.Text = Title
                end
                
                Dropdowntitle.Name = "TextColorPlaceholder"
                Dropdowntitle.Parent = Topdrop
                Dropdowntitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                Dropdowntitle.BackgroundTransparency = 1.000
                Dropdowntitle.Position = UDim2.new(0, 10, 0, 0)
                Dropdowntitle.Size = UDim2.new(1, -40, 1, 0)
                Dropdowntitle.Font = Enum.Font.GothamBlack
                Dropdowntitle.TextSize = 14.000
                Dropdowntitle.TextXAlignment = Enum.TextXAlignment.Left
                Dropdowntitle.ClipsDescendants = true
                Dropdowntitle.TextColor3 = getgenv().UIColor["Text Color"]
                
                ImgDrop.Name = "ImgDrop"
                ImgDrop.Parent = Topdrop
                ImgDrop.AnchorPoint = Vector2.new(1, 0.5)
                ImgDrop.BackgroundTransparency = 1.000
                ImgDrop.BorderColor3 = Color3.fromRGB(27, 42, 53)
                ImgDrop.Position = UDim2.new(1, -6, 0.5, 0)
                ImgDrop.Size = UDim2.new(0, 15, 0, 15)
                ImgDrop.Image = "rbxassetid://6954383209"
                ImgDrop.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
                
                DropdownButton.Name = "DropdownButton"
                DropdownButton.Parent = Topdrop
                DropdownButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                DropdownButton.BackgroundTransparency = 1.000
                DropdownButton.Size = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1 , 0)
                DropdownButton.Position = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0 , 0 , 0 , 0)
                DropdownButton.Font = Enum.Font.GothamBold
                DropdownButton.Text = ""
                DropdownButton.TextColor3 = Color3.fromRGB(230, 230, 230)
                DropdownButton.TextSize = 14.000
                
                Dropdownlisttt.Name = "Dropdownlisttt"
                Dropdownlisttt.Parent = Dropdownbg
                Dropdownlisttt.BackgroundTransparency = 1.000
                Dropdownlisttt.BorderSizePixel = 0
                Dropdownlisttt.Position = UDim2.new(0, 0, 0, 25)
                Dropdownlisttt.Size = UDim2.new(1, 0, 0, 0)
                Dropdownlisttt.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                
                DropdownScroll.Name = "DropdownScroll"
                DropdownScroll.Parent = Dropdownlisttt
                DropdownScroll.Active = true
                DropdownScroll.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                DropdownScroll.BackgroundTransparency = 1.000
                DropdownScroll.BorderSizePixel = 0
                DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
                DropdownScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
                DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownScroll.ScrollBarThickness = 5
                DropdownScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
                DropdownScroll.ScrollingEnabled = true
                DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
                
                ScrollContainer.Name = "ScrollContainer"
                ScrollContainer.Parent = DropdownScroll
                ScrollContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                ScrollContainer.BackgroundTransparency = 1.000
                ScrollContainer.Position = UDim2.new(0, 5, 0, 5)
                ScrollContainer.Size = UDim2.new(1, -15, 1, -5)
                
                ScrollContainerList.Name = "ScrollContainerList"
                ScrollContainerList.Parent = ScrollContainer
                ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
                ScrollContainerList.Padding = UDim.new(0, 5)
                
                -- Tạo internal section để chứa các control
                local InternalSection = Instance.new("Frame")
                InternalSection.Name = "InternalSection"
                InternalSection.Parent = ScrollContainer
                InternalSection.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                InternalSection.BackgroundTransparency = 1.000
                InternalSection.Size = UDim2.new(1, 0, 0, 0)
                InternalSection.AutomaticSize = Enum.AutomaticSize.Y
                
                local InternalList = Instance.new("UIListLayout")
                InternalList.Name = "InternalList"
                InternalList.Parent = InternalSection
                InternalList.SortOrder = Enum.SortOrder.LayoutOrder
                InternalList.Padding = UDim.new(0, 5)
                
                local isOpen = false
                
                DropdownButton.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    
                    local listsize = isOpen and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 0)
                    local mainsize = isOpen and UDim2.new(1, 0, 0, 230) or UDim2.new(1, 0, 0, 25)
                    local DropCRotation = isOpen and 90 or 0
                    
                    TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Size = listsize
                    }):Play()
                    TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Size = mainsize
                    }):Play()
                    TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Rotation = DropCRotation
                    }):Play()
                end)
                
                ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
                end)
                
                InternalList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    local contentHeight = math.min(InternalList.AbsoluteContentSize.Y + 10, 300)
                    local listsize = isOpen and UDim2.new(1, 0, 0, contentHeight) or UDim2.new(1, 0, 0, 0)
                    local mainsize = isOpen and UDim2.new(1, 0, 0, contentHeight + 25) or UDim2.new(1, 0, 0, 25)
                    
                    if isOpen then
                        TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            Size = listsize
                        }):Play()
                        TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            Size = mainsize
                        }):Play()
                    end
                end)
                
                -- Tạo dropdown section functions (CHỈ CÓ SLIDER)
                local dropdownSectionFunction = {}
                
                -- HÀM TẠO SLIDER (RỘNG HƠN, SÁT VIỀN)
                function dropdownSectionFunction:AddSlider(Setting)
                    local TitleText = tostring(Setting.Text or Setting.Title) or ""
                    local minValue = tonumber(Setting.Min) or 0
                    local maxValue = tonumber(Setting.Max) or 100
                    local Precise = Setting.Precise or false
                    local DefaultValue = tonumber(Setting.Default) or 0
                    local Callback = Setting.Callback
                    local Rounding = Setting.Rouding or Setting.Rounding
                    
                    local SliderFrame = Instance.new("Frame")
                    local SliderCorner = Instance.new("UICorner")
                    local SliderBG = Instance.new("Frame")
                    local SliderBGCorner = Instance.new("UICorner")
                    local SliderTitle = Instance.new("TextLabel")
                    local SliderBar = Instance.new("Frame")
                    local SliderButton = Instance.new("TextButton")
                    local SliderBarCorner = Instance.new("UICorner")
                    local Bar = Instance.new("Frame")
                    local BarCorner = Instance.new("UICorner")
                    local Sliderboxframe = Instance.new("Frame")
                    local Sliderbox = Instance.new("UICorner")
                    local Sliderbox_2 = Instance.new("TextBox")
                    
                    SliderFrame.Name = TitleText
                    SliderFrame.Parent = InternalSection
                    SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    SliderFrame.BackgroundTransparency = 1.000
                    SliderFrame.Size = UDim2.new(1, 0, 0, 50)  -- Chiếm toàn bộ chiều rộng
                    
                    SliderCorner.CornerRadius = UDim.new(0, 8)
                    SliderCorner.Name = "SliderCorner"
                    SliderCorner.Parent = SliderFrame
                    
                    SliderBG.Name = "Background1"
                    SliderBG.Parent = SliderFrame
                    SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
                    SliderBG.Size = UDim2.new(1, -5, 1, 0)  -- Chiếm gần toàn bộ (trừ 5 pixel)
                    SliderBG.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
                    SliderBG.BackgroundTransparency = 0.25
                    
                    SliderBGCorner.CornerRadius = UDim.new(0, 8)
                    SliderBGCorner.Name = "SliderBGCorner"
                    SliderBGCorner.Parent = SliderBG
                    
                    SliderTitle.Name = "TextColor"
                    SliderTitle.Parent = SliderBG
                    SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    SliderTitle.BackgroundTransparency = 1.000
                    SliderTitle.Position = UDim2.new(0, 10, 0, 0)
                    SliderTitle.Size = UDim2.new(0.65, -10, 0, 25)  -- Title chiếm 65%
                    SliderTitle.Font = Enum.Font.GothamBlack
                    SliderTitle.Text = TitleText
                    SliderTitle.TextSize = 14.000
                    SliderTitle.RichText = true
                    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
                    SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
                    
                    SliderBar.Name = "SliderBar"
                    SliderBar.Parent = SliderFrame
                    SliderBar.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderBar.Position = UDim2.new(0.5, 0, 0.5, 14)
                    SliderBar.Size = UDim2.new(0.9, 0, 0, 6)  -- Thanh slider rộng 90%
                    SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    
                    SliderButton.Name = "SliderButton"
                    SliderButton.Parent = SliderBar
                    SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    SliderButton.BackgroundTransparency = 1.000
                    SliderButton.Size = UDim2.new(1, 0, 1, 0)
                    SliderButton.Font = Enum.Font.GothamBold
                    SliderButton.Text = ""
                    SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
                    SliderButton.TextSize = 14.000
                    
                    SliderBarCorner.CornerRadius = UDim.new(1, 0)
                    SliderBarCorner.Name = "SliderBarCorner"
                    SliderBarCorner.Parent = SliderBar
                    
                    Bar.Name = "Bar"
                    Bar.BorderSizePixel = 0
                    Bar.Parent = SliderBar
                    Bar.Size = UDim2.new(0, 0, 1, 0)
                    Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
                    
                    BarCorner.CornerRadius = UDim.new(1, 0)
                    BarCorner.Name = "BarCorner"
                    BarCorner.Parent = Bar
                    
                    Sliderboxframe.Name = "Background2"
                    Sliderboxframe.Parent = SliderFrame
                    Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
                    Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
                    Sliderboxframe.Size = UDim2.new(0.25, 0, 0, 25)  -- Textbox chiếm 25%
                    Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    
                    Sliderbox.CornerRadius = UDim.new(0, 8)
                    Sliderbox.Name = "Sliderbox"
                    Sliderbox.Parent = Sliderboxframe
                    
                    Sliderbox_2.Name = "TextColor"
                    Sliderbox_2.Parent = Sliderboxframe
                    Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    Sliderbox_2.BackgroundTransparency = 1.000
                    Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
                    Sliderbox_2.Font = Enum.Font.GothamBold
                    Sliderbox_2.Text = ""
                    Sliderbox_2.TextSize = 14.000
                    Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
                    
                    SliderButton.MouseEnter:Connect(function()
                        TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]
                        }):Play()
                    end)
                    
                    SliderButton.MouseLeave:Connect(function()
                        TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
                        }):Play()
                    end)
                    
                    local callBackAndSetText = function(val)
                        Sliderbox_2.Text = tostring(val)
                        Callback(tonumber(val))
                    end
                    if DefaultValue then
                        if DefaultValue <= minValue then
                            DefaultValue = minValue
                        elseif DefaultValue >= maxValue then
                            DefaultValue = maxValue
                        end
                        Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
                        Sliderbox_2.Text = tostring(DefaultValue)
                    end
                    
                    
                    local dragging = false
                    local dragInput
                    local holdTime = 0
                    local holdStarted = 0
                    
                    local function onInputBegan(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            holdStarted = tick()
                            
                            input.Changed:Connect(function()
                                if input.UserInputState == Enum.UserInputState.End then
                                    dragging = false
                                    holdStarted = 0
                                end
                            end)
                        end
                    end
                    
                    local function onInputEnded(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                            holdStarted = 0
                        end
                    end
                    
                    local function onInputChanged(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                            dragInput = input
                        end
                    end
                    
                    SliderButton.InputBegan:Connect(onInputBegan)
                    SliderButton.InputEnded:Connect(onInputEnded)
                    SliderButton.InputChanged:Connect(onInputChanged)
                    
                    RunService.RenderStepped:Connect(function()
                        if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
                            dragging = true
                        end
                        
                        if dragging and dragInput then
                            local barWidth = math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
                            local percentage = barWidth / SliderBar.AbsoluteSize.X
                            local value = minValue + (maxValue - minValue) * percentage
                            
                            if Rounding then
                                value = tonumber(string.format("%.".. Rounding .."f", value))
                            elseif not Precise then
                                value = math.floor(value)
                            end
                            
                            value = math.clamp(value, minValue, maxValue)
                            
                            pcall(function()
                                callBackAndSetText(value)
                            end)
                            Bar.Size = UDim2.new(percentage, 0, 1, 0)
                        end
                    end)
                    
                    local function GetSliderValue(Value)
                        Value = tonumber(Value) or minValue
                        Value = math.clamp(Value, minValue, maxValue)
                        
                        if Rounding then
                            Value = tonumber(string.format("%.".. Rounding .."f", Value))
                        elseif not Precise then
                            Value = math.floor(Value)
                        end
                        
                        local percentage = (Value - minValue) / (maxValue - minValue)
                        Bar.Size = UDim2.new(percentage, 0, 1, 0)
                        callBackAndSetText(Value)
                    end
                    
                    Sliderbox_2.FocusLost:Connect(function()
                        GetSliderValue(Sliderbox_2.Text)
                    end)
                    
                    local slider_function = {}
                    function slider_function.SetValue(Value)
                        GetSliderValue(Value)
                    end
                    
                    function slider_function.GetValue()
                        return tonumber(Sliderbox_2.Text) or minValue
                    end
                    
                    return slider_function
                end
                
                function dropdownSectionFunction:SetOpen(state)
                    if state ~= isOpen then
                        DropdownButton.MouseButton1Click:Fire()
                    end
                end
                
                function dropdownSectionFunction:GetOpen()
                    return isOpen
                end
                
                function dropdownSectionFunction:SetTitle(newTitle)
                    if Search then
                        Dropdowntitle.PlaceholderText = newTitle
                    else
                        Dropdowntitle.Text = newTitle
                    end
                end
                
                local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = DropdownFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
                return dropdownSectionFunction
            end
            
			function sectionFunction:AddDropdown(idk, Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local List = Setting.Values
				local Search = Setting.Search or false
				local Selected = Setting.Selected or Setting.Multi or false
				local Slider = Setting.Slider or false
				local SliderRelease = Setting.SliderRelease or false
				local Default = (function ()
                    if Setting.Default then
                        if type(Setting.Default) == "number" then
                            return List[Setting.Default]
                        elseif type(Setting.Default) == "string" then
                            return Setting.Default
                        end
                    end
                    return nil
                end)()
				local Callback = Setting.Callback
				local pairs = Setting.SortPairs or pairs
				local DropdownFrame = Instance.new("Frame")
				local Dropdownbg = Instance.new("Frame")
				local Dropdowncorner = Instance.new("UICorner")
				local Topdrop = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local ImgDrop = Instance.new("ImageLabel")
				local DropdownButton = Instance.new("TextButton")
				local Dropdownlisttt = Instance.new("Frame")
				local DropdownScroll = Instance.new("ScrollingFrame")
				local ScrollContainer = Instance.new("Frame")
				local ScrollContainerList = Instance.new("UIListLayout")
				local dropdownLeave = false
				local Dropdowntitle;
				if Search then
					Dropdowntitle = Instance.new("TextBox")
				else
					Dropdowntitle = Instance.new("TextLabel")
				end
				DropdownFrame.Name = Title .. "DropdownFrame"
				DropdownFrame.Parent = Section
				DropdownFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownFrame.BackgroundTransparency = 1.000
				DropdownFrame.Position = UDim2.new(0, 0, 0.473684222, 0)
				DropdownFrame.Size = UDim2.new(1, 0, 0, 25)
				Dropdownbg.Name = "Background1"
				Dropdownbg.Parent = DropdownFrame
				Dropdownbg.AnchorPoint = Vector2.new(0.5, 0.5)
				Dropdownbg.Position = UDim2.new(0.5, 0, 0.5, 0)
				Dropdownbg.Size = UDim2.new(1, -10, 1, 0)
				Dropdownbg.ClipsDescendants = true
				Dropdownbg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				Dropdownbg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				Dropdowncorner.CornerRadius = UDim.new(0, 8)
				Dropdowncorner.Name = "Dropdowncorner"
				Dropdowncorner.Parent = Dropdownbg
				Topdrop.Name = "Background2"
				Topdrop.Parent = Dropdownbg
				Topdrop.Size = UDim2.new(1, 0, 0, 25)
				Topdrop.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				Topdrop.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				UICorner.CornerRadius = UDim.new(0, 8)
				UICorner.Parent = Topdrop
				Dropdowntitle.Name = "TextColorPlaceholder"
				Dropdowntitle.Parent = Topdrop
				Dropdowntitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Dropdowntitle.BackgroundTransparency = 1.000
				Dropdowntitle.Position = UDim2.new(0, 10, 0, 0)
				Dropdowntitle.Size = UDim2.new(1, -40, 1, 0)
				Dropdowntitle.Font = Enum.Font.GothamBlack
				Dropdowntitle.Text = ''
				Dropdowntitle.TextSize = 14.000
				Dropdowntitle.TextXAlignment = Enum.TextXAlignment.Left
				Dropdowntitle.ClipsDescendants = true
				local Sel = Instance.new("StringValue", Dropdowntitle)
				Sel.Value = ""
				if Default and table.find(List, Default) then
					Sel.Value = Default
				end
				if not Selected then
					if Search then
						Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "");
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "");
					end
				else
					if Search then
						Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "");
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "");
					end
				end
				Dropdowntitle.TextColor3 = getgenv().UIColor["Text Color"]
				ImgDrop.Name = "ImgDrop"
				ImgDrop.Parent = Topdrop
				ImgDrop.AnchorPoint = Vector2.new(1, 0.5)
				ImgDrop.BackgroundTransparency = 1.000
				ImgDrop.BorderColor3 = Color3.fromRGB(27, 42, 53)
				ImgDrop.Position = UDim2.new(1, -6, 0.5, 0)
				ImgDrop.Size = UDim2.new(0, 15, 0, 15)
				ImgDrop.Image = "rbxassetid://6954383209"
				ImgDrop.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
				DropdownButton.Name = "DropdownButton"
				DropdownButton.Parent = Topdrop
				DropdownButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownButton.BackgroundTransparency = 1.000
				DropdownButton.Size = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1 , 0)
				DropdownButton.Position = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0 , 0 , 0 , 0)
				DropdownButton.Font = Enum.Font.GothamBold
				DropdownButton.Text = ""
				DropdownButton.TextColor3 = Color3.fromRGB(230, 230, 230)
				DropdownButton.TextSize = 14.000
				Dropdownlisttt.Name = "Dropdownlisttt"
				Dropdownlisttt.Parent = Dropdownbg
				Dropdownlisttt.BackgroundTransparency = 1.000
				Dropdownlisttt.BorderSizePixel = 0
				Dropdownlisttt.Position = UDim2.new(0, 0, 0, 25)
				Dropdownlisttt.Size = UDim2.new(1, 0, 0, 25)
				Dropdownlisttt.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownScroll.Name = "DropdownScroll"
				DropdownScroll.Parent = Dropdownlisttt
				DropdownScroll.Active = true
				DropdownScroll.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownScroll.BackgroundTransparency = 1.000
				DropdownScroll.BorderSizePixel = 0
				DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
				DropdownScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
				DropdownScroll.ScrollBarThickness = 5
				DropdownScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.ScrollingEnabled = true
				DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
				ScrollContainer.Name = "ScrollContainer"
				ScrollContainer.Parent = DropdownScroll
				ScrollContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ScrollContainer.BackgroundTransparency = 1.000
				ScrollContainer.Position = UDim2.new(0, 5, 0, 5)
				ScrollContainer.Size = UDim2.new(1, -15, 1, -5)
				ScrollContainerList.Name = "ScrollContainerList"
				ScrollContainerList.Parent = ScrollContainer
				ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
				ScrollContainerList.Padding = UDim.new(0, 5)
				ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
				end)
				local isbusy = false
				local found = {}
				local searchtable = {}
				local function edit()
					for i in pairs(found) do
						found[i] = nil
					end
					for h, l in pairs(ScrollContainer:GetChildren()) do
						if not l:IsA("UIListLayout") and not l:IsA("UIPadding") and not l:IsA('UIGridLayout') then
							l.Visible = false
						end
					end
					Dropdowntitle.Text = string.lower(Dropdowntitle.Text)
				end
				local function SearchDropdown()
					local Results = {}
					for i, v in pairs(searchtable) do
						if string.find(v, Dropdowntitle.Text) then
							table.insert(found, v)
						end
					end
					for a, b in pairs(ScrollContainer:GetChildren()) do
						for c, d in pairs(found) do
							if d == b.Name then
								b.Visible = true
							end
						end
					end
				end
				local function clear_object_in_list()
					for i, v in next, ScrollContainer:GetChildren() do
						if v:IsA('Frame') then
							v:Destroy()
						end
					end
				end
				local ListNew
                local OrderedList = {} -- Thêm biến lưu thứ tự
                if Selected then
                    ListNew = {}
                    for _, value in ipairs(List) do
                        -- Kiểm tra nếu value trùng với Default thì set true
                        ListNew[value] = (value == Default)
                        table.insert(OrderedList, value) -- Lưu thứ tự
                    end
                else
                    ListNew = List
                end
				local function refreshlist(SortPairs)
					pairs = SortPairs or pairs
					clear_object_in_list()
					searchtable = {}
					for i, v in pairs(ListNew) do
						if Selected then
							table.insert(searchtable, string.lower(i))
						elseif Slider then
							table.insert(searchtable, string.lower(v['Title']))
						else
							table.insert(searchtable, string.lower(v))
						end
					end
					if Selected then
                        for _, i in ipairs(OrderedList) do
                            local v = ListNew[i]
							local SampleItem = Instance.new("Frame")
							local SampleItemCorner = Instance.new("UICorner")
							local SampleItemBG = Instance.new("Frame")
							local SampleItemBGCorner = Instance.new("UICorner")
							local SampleItemTitle = Instance.new("TextLabel")
							local SampleItemCheck = Instance.new("ImageButton")
							local SampleItemButton = Instance.new("TextButton")
							SampleItem.Name = string.lower(i)
							SampleItem.Parent = ScrollContainer
							SampleItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
							SampleItem.BackgroundTransparency = 1.000
							SampleItem.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItem.LayoutOrder = 1
							SampleItem.Position = UDim2.new(0, 0, 0.208333328, 0)
							SampleItem.Size = UDim2.new(1, 0, 0, 25)
							SampleItemCorner.CornerRadius = UDim.new(0, 8)
							SampleItemCorner.Name = "SampleItemCorner"
							SampleItemCorner.Parent = SampleItem
							SampleItemBG.Name = "SampleItemBG"
							SampleItemBG.Parent = SampleItem
							SampleItemBG.AnchorPoint = Vector2.new(0.5, 0.5)
							SampleItemBG.BackgroundColor3 = v and UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255)
							SampleItemBG.BackgroundTransparency = v and .5 or 1
							SampleItemBG.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItemBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							SampleItemBG.Size = UDim2.new(1, 0, 1, 0)
							SampleItemBGCorner.CornerRadius = UDim.new(0, 8)
							SampleItemBGCorner.Name = "SampleItemBGCorner"
							SampleItemBGCorner.Parent = SampleItemBG
							SampleItemTitle.Name = "SampleItemTitle"
							SampleItemTitle.Parent = SampleItemBG
							SampleItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemTitle.BackgroundTransparency = 1.000
							SampleItemTitle.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItemTitle.Position = UDim2.new(0, 10, 0, 0)
							SampleItemTitle.Size = UDim2.new(1, -40, 0, 25)
							SampleItemTitle.Font = Enum.Font.GothamBlack
							SampleItemTitle.Text = tostring(i)
							SampleItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemTitle.TextSize = 14.000
							SampleItemTitle.TextStrokeTransparency = 0.500
							SampleItemTitle.TextXAlignment = Enum.TextXAlignment.Left
							SampleItemCheck.Name = "SampleItemCheck"
							SampleItemCheck.Parent = SampleItemBG
							SampleItemCheck.AnchorPoint = Vector2.new(1, 0.5)
							SampleItemCheck.BackgroundTransparency = 1.000
							SampleItemCheck.Position = UDim2.new(1, 0, 0.5, 0)
							SampleItemCheck.Size = UDim2.new(0, 25, 0, 25)
							SampleItemCheck.ZIndex = 2
							SampleItemCheck.Image = "rbxassetid://3926305904"
							SampleItemCheck.ImageColor3 = UIColor["Dropdown Selected Check Color"]
							SampleItemCheck.ImageRectOffset = Vector2.new(312, 4)
							SampleItemCheck.ImageRectSize = Vector2.new(24, 24)
							SampleItemCheck.ImageTransparency = v and 0 or 1
							SampleItemButton.Name = "SampleItemButton"
							SampleItemButton.Parent = SampleItem
							SampleItemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemButton.BackgroundTransparency = 1.000
							SampleItemButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
							SampleItemButton.BorderSizePixel = 0
							SampleItemButton.Size = UDim2.new(1, 0, 1, 0)
							SampleItemButton.Font = Enum.Font.SourceSans
							SampleItemButton.TextColor3 = getgenv().UIColor["Text Color"]
							SampleItemButton.TextSize = 14.000
							SampleItemButton.TextTransparency = 1.000
							SampleItemButton.MouseEnter:Connect(function()
								if v then
									return
								end
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = .7
								}
										):Play()
							end)
							SampleItemButton.MouseLeave:Connect(function()
								if v then
									return
								end
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = 1
								}
										):Play()
							end)
							SampleItemButton.MouseButton1Click:Connect(function()
								v = not v
								TweenService:Create(
											SampleItemCheck,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									ImageTransparency = v and 0 or 1
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = v and UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = v and .5 or 1
								}
										):Play()
								if Callback then
									Callback(i, v)
									ListNew[i] = v
								end
								local selectedText = {}
								for key, isSelected in pairs(ListNew) do
									if isSelected then
										table.insert(selectedText, tostring(key))
									end
								end
								local joinedText = table.concat(selectedText, ", ")
								if Search then
									Dropdowntitle.PlaceholderText = Title .. ': ' .. joinedText
								else
									Dropdowntitle.Text = Title .. ': ' .. joinedText
								end
							end)
						end
					elseif Slider then
						for i, v in pairs(ListNew) do
							local TitleText = tostring(v.Title) or ""
							local minValue = tonumber(v.Min) or 0
							local maxValue = tonumber(v.Max) or 100
							local Precise = v.Precise or false
							local DefaultValue = tonumber(v.Default) or minValue
							local SizeChia = 365;
							local SliderFrame = Instance.new("Frame")
							local SliderCorner = Instance.new("UICorner")
							local SliderBG = Instance.new("Frame")
							local SliderBGCorner = Instance.new("UICorner")
							local SliderTitle = Instance.new("TextLabel")
							local SliderBar = Instance.new("Frame")
							local SliderButton = Instance.new("TextButton")
							local SliderBarCorner = Instance.new("UICorner")
							local Bar = Instance.new("Frame")
							local BarCorner = Instance.new("UICorner")
							local Sliderboxframe = Instance.new("Frame")
							local Sliderbox = Instance.new("UICorner")
							local Sliderbox_2 = Instance.new("TextBox")
							SliderFrame.Name = string.lower(v['Title'])
							SliderFrame.Parent = ScrollContainer
							SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
							SliderFrame.BackgroundTransparency = 1.000
							SliderFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
							SliderFrame.Size = UDim2.new(1, 0, 0, 50)
							SliderCorner.CornerRadius = UDim.new(0, 8)
							SliderCorner.Name = "SliderCorner"
							SliderCorner.Parent = SliderFrame
							SliderBG.Name = "Background1"
							SliderBG.Parent = SliderFrame
							SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
							SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							SliderBG.Size = UDim2.new(1, -10, 1, 0)
							SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							SliderBGCorner.CornerRadius = UDim.new(0, 8)
							SliderBGCorner.Name = "SliderBGCorner"
							SliderBGCorner.Parent = SliderBG
							SliderTitle.Name = "TextColor"
							SliderTitle.Parent = SliderBG
							SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							SliderTitle.BackgroundTransparency = 1.000
							SliderTitle.Position = UDim2.new(0, 10, 0, 0)
							SliderTitle.Size = UDim2.new(1, -10, 0, 25)
							SliderTitle.Font = Enum.Font.GothamBlack
							SliderTitle.Text = TitleText
							SliderTitle.TextSize = 14.000
							SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
							SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
							SliderBar.Name = "SliderBar"
							SliderBar.Parent = SliderFrame
							SliderBar.AnchorPoint = Vector2.new(.5, 0.5)
							SliderBar.Position = UDim2.new(.5, 0, 0.5, 14)
							SliderBar.Size = UDim2.new(1, -24, 0, 6)
							SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							SliderButton.Name = "SliderButton "
							SliderButton.Parent = SliderBar
							SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							SliderButton.BackgroundTransparency = 1.000
							SliderButton.Size = UDim2.new(1, 0, 1, 0)
							SliderButton.Font = Enum.Font.GothamBold
							SliderButton.Text = ""
							SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
							SliderButton.TextSize = 14.000
							SliderBarCorner.CornerRadius = UDim.new(1, 0)
							SliderBarCorner.Name = "SliderBarCorner"
							SliderBarCorner.Parent = SliderBar
							Bar.Name = "Bar"
							Bar.BorderSizePixel = 0
							Bar.Parent = SliderBar
							Bar.Size = UDim2.new(0, 0, 1, 0)
							Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
							BarCorner.CornerRadius = UDim.new(1, 0)
							BarCorner.Name = "BarCorner"
							BarCorner.Parent = Bar
							Sliderboxframe.Name = "Background2"
							Sliderboxframe.Parent = SliderFrame
							Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
							Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
							Sliderboxframe.Size = UDim2.new(0, 150, 0, 25)
							Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							Sliderbox.CornerRadius = UDim.new(0, 8)
							Sliderbox.Name = "Sliderbox"
							Sliderbox.Parent = Sliderboxframe
							Sliderbox_2.Name = "TextColor"
							Sliderbox_2.Parent = Sliderboxframe
							Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Sliderbox_2.BackgroundTransparency = 1.000
							Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
							Sliderbox_2.Font = Enum.Font.GothamBold
							Sliderbox_2.Text = ""
							Sliderbox_2.TextSize = 14.000
							Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
							SliderButton.MouseEnter:Connect(function()
								TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
									BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]
								}):Play()
							end)
							SliderButton.MouseLeave:Connect(function()
								TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
									BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
								}):Play()
							end)
							local callBackAndSetText = function(val)
								Sliderbox_2.Text = val
								ListNew[i].Default = val
								Callback(i, v)
							end
							if DefaultValue then
								if DefaultValue <= minValue then
									DefaultValue = minValue
								elseif DefaultValue >= maxValue then
									DefaultValue = maxValue
								end
								Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
								callBackAndSetText(DefaultValue)
							end
							if SliderRelease then
								local dragging = false
								local dragInput
								local holdTime = 0
								local holdStarted = 0

										-- Function to detect the start of dragging (for both mouse and touch)
								local function onInputBegan(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										holdStarted = tick() -- Record the time when holding starts
										
												-- Listen for release to stop dragging
										input.Changed:Connect(function()
											if input.UserInputState == Enum.UserInputState.End then
												dragging = false
												holdStarted = 0 -- Reset the hold timer
											end
										end)
									end
								end
										
										-- Function to detect when dragging stops
								local function onInputEnded(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										dragging = false
										holdStarted = 0 -- Reset the hold timer
									end
								end

										-- Detect input movement (for both mouse and touch)
								local function onInputChanged(input)
									if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
										dragInput = input
									end
								end
										
										-- Connect the events
								SliderButton.InputBegan:Connect(onInputBegan)
								SliderButton.InputEnded:Connect(onInputEnded)
								SliderButton.InputChanged:Connect(onInputChanged)
										
										-- RenderStepped updates the position while dragging
								RunService.RenderStepped:Connect(function()
									if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
										dragging = true
									end
									if dragging and dragInput then
										local value = Precise and  tonumber(string.format("%.1f", (((tonumber(maxValue) - tonumber(minValue)) / SliderBar.AbsoluteSize.X) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SliderBar.AbsoluteSize.X) * Bar.AbsoluteSize.X) + tonumber(minValue))
										pcall(function()
											callBackAndSetText(value)
										end)
										Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X), 0, 6)
									end
								end)
							else
								local dragging = false
								local dragInput
								local holdTime = 0 -- Time to hold before dragging is enabled
								local holdStarted = 0

										-- Function to detect the start of dragging (for both mouse and touch)
								local function onInputBegan(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										holdStarted = tick() -- Record the time when holding starts
										
												-- Listen for release to stop dragging
										input.Changed:Connect(function()
											if input.UserInputState == Enum.UserInputState.End then
												dragging = false
												holdStarted = 0 -- Reset the hold timer
											end
										end)
									end
								end
										
										-- Function to detect when dragging stops
								local function onInputEnded(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										dragging = false
										holdStarted = 0 -- Reset the hold timer
									end
								end

										-- Detect input movement (for both mouse and touch)
								local function onInputChanged(input)
									if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
										dragInput = input
									end
								end
										
										-- Connect the events
								SliderButton.InputBegan:Connect(onInputBegan)
								SliderButton.InputEnded:Connect(onInputEnded)
								SliderButton.InputChanged:Connect(onInputChanged)
										
										-- RenderStepped updates the position while dragging
								RunService.RenderStepped:Connect(function()
									if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
										dragging = true
									end
									if dragging and dragInput then
										local value = Precise and  tonumber(string.format("%.1f", (((tonumber(maxValue) - tonumber(minValue)) / SliderBar.AbsoluteSize.X) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SliderBar.AbsoluteSize.X) * Bar.AbsoluteSize.X) + tonumber(minValue))
										pcall(function()
											callBackAndSetText(value)
										end)
										Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X), 0, 6)
									end
								end)
							end
							local function GetSliderValue(Value)
								if tonumber(Value) <= minValue then
									Bar.Size = UDim2.new(0, (0 * SliderBar.AbsoluteSize.X), 0, 6)
									callBackAndSetText(minValue)
								elseif tonumber(Value) >= maxValue then
									Bar.Size = UDim2.new(0, (maxValue  /  maxValue * SliderBar.AbsoluteSize.X), 0, 6)
									callBackAndSetText(maxValue)
								else
									Bar.Size = UDim2.new(1 - ((maxValue - Value) / (maxValue - minValue)), 0, 0, 6)
									callBackAndSetText(Value)
								end
							end
							Sliderbox_2.FocusLost:Connect(function()
								GetSliderValue(Sliderbox_2.Text)
							end)
						end
					else
						for i, v in pairs (ListNew) do
							if typeof(v) == "string" then
								local SampleItem = Instance.new("Frame")
								local SampleItemCorner = Instance.new("UICorner")
								local SampleItemBG = Instance.new("Frame")
								local SampleItemBGCorner = Instance.new("UICorner")
								local SampleItemTitle = Instance.new("TextLabel")
								local SampleItemCheck = Instance.new("ImageButton")
								local SampleItemButton = Instance.new("TextButton")
								SampleItem.Name = string.lower(v)
								SampleItem.Parent = ScrollContainer
								SampleItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
								SampleItem.BackgroundTransparency = 1.000
								SampleItem.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItem.LayoutOrder = 1
								SampleItem.Position = UDim2.new(0, 0, 0.208333328, 0)
								SampleItem.Size = UDim2.new(1, 0, 0, 25)
								SampleItemCorner.CornerRadius = UDim.new(0, 8)
								SampleItemCorner.Name = "SampleItemCorner"
								SampleItemCorner.Parent = SampleItem
								SampleItemBG.Name = "SampleItemBG"
								SampleItemBG.Parent = SampleItem
								SampleItemBG.AnchorPoint = Vector2.new(0.5, 0.5)
								SampleItemBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemBG.BackgroundTransparency = 1
								SampleItemBG.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItemBG.Position = UDim2.new(0.5, 0, 0.5, 0)
								SampleItemBG.Size = UDim2.new(1, 0, 1, 0)
								SampleItemBGCorner.CornerRadius = UDim.new(0, 8)
								SampleItemBGCorner.Name = "SampleItemBGCorner"
								SampleItemBGCorner.Parent = SampleItemBG
								SampleItemTitle.Name = "SampleItemTitle"
								SampleItemTitle.Parent = SampleItemBG
								SampleItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemTitle.BackgroundTransparency = 1.000
								SampleItemTitle.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItemTitle.Position = UDim2.new(0, 10, 0, 0)
								SampleItemTitle.Size = UDim2.new(1, -40, 0, 25)
								SampleItemTitle.Font = Enum.Font.GothamBlack
								SampleItemTitle.Text = v
								SampleItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemTitle.TextSize = 14.000
								SampleItemTitle.TextStrokeTransparency = 0.500
								SampleItemTitle.TextXAlignment = Enum.TextXAlignment.Left
								SampleItemCheck.Name = "SampleItemCheck"
								SampleItemCheck.Parent = SampleItemBG
								SampleItemCheck.AnchorPoint = Vector2.new(1, 0.5)
								SampleItemCheck.BackgroundTransparency = 1.000
								SampleItemCheck.Position = UDim2.new(1, 0, 0.5, 0)
								SampleItemCheck.Size = UDim2.new(0, 25, 0, 25)
								SampleItemCheck.ZIndex = 2
								SampleItemCheck.Image = "rbxassetid://3926305904"
								SampleItemCheck.ImageColor3 = UIColor["Dropdown Selected Check Color"]
								SampleItemCheck.ImageRectOffset = Vector2.new(312, 4)
								SampleItemCheck.ImageRectSize = Vector2.new(24, 24)
								SampleItemCheck.ImageTransparency = 1
								SampleItemButton.Name = "SampleItemButton"
								SampleItemButton.Parent = SampleItem
								SampleItemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemButton.BackgroundTransparency = 1.000
								SampleItemButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
								SampleItemButton.BorderSizePixel = 0
								SampleItemButton.Size = UDim2.new(1, 0, 1, 0)
								SampleItemButton.Font = Enum.Font.SourceSans
								SampleItemButton.TextColor3 = getgenv().UIColor["Text Color"]
								SampleItemButton.TextSize = 14.000
								SampleItemButton.TextTransparency = 1.000
								SampleItemButton.MouseEnter:Connect(function()
									if Sel.Value == v then
										return
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = .7
									}
											):Play()
								end)
								SampleItemButton.MouseLeave:Connect(function()
									if Sel.Value == v then
										return
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = 1
									}
											):Play()
								end)
								SampleItemButton.MouseButton1Click:Connect(function()
									if Search then
										Dropdowntitle.PlaceholderText = Title .. ': ' .. v or ""
										Sel.Value = v
									else
										Dropdowntitle.Text = Title .. ': ' .. v or ""
										Sel.Value = v
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = UIColor["Dropdown Selected Check Color"]
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = .5
									}
											):Play()
									if Callback then
										Callback(v)
									end
									if Search then
										Dropdowntitle.Text = ""
									end
									refreshlist()
								end)
								if Sel.Value == v then
									SampleItemBG.BackgroundTransparency = .5;
									SampleItemBG.BackgroundColor3 = UIColor["Dropdown Selected Check Color"]
									SampleItem.LayoutOrder = 0
								end
							end
						end
					end
				end
				if Search then
					Dropdowntitle.Changed:Connect(function()
						edit()
						SearchDropdown()
					end)
				end
				if typeof(Default) ~= 'table' then
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "")
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "")
					end
				elseif Slider then
					Dropdowntitle.Text = ''
					Dropdowntitle.PlaceholderText = Title .. ': '
				elseif Selected then
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': '
					else
						Dropdowntitle.Text = Title .. ': '
					end
				end
				DropdownButton.MouseButton1Click:Connect(function()
					refreshlist()
					isbusy = not isbusy
					local listsize = isbusy and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
					local mainsize = isbusy and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
					local DropCRotation = isbusy and 90 or 0
					TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = listsize
					}):Play()
					TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = mainsize
					}):Play()
					TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Rotation = DropCRotation
					}):Play()
				end)
				local dropdownFunction = {
					rf = refreshlist
				}
				function dropdownFunction:ClearText(v)
					if not Selected then
						if Search then
							Dropdowntitle.PlaceholderText = Title .. ': ' .. (v or "")
						else
							Dropdowntitle.Text = Title .. ': ' .. (v or "")
						end
					else
						Dropdowntitle.Text = Title .. ': ' .. (v or "")
					end
				end
				function dropdownFunction:GetNewList(List)
					Sel.Value = ""
							--refreshlist()
					isbusy = false
					local listsize = isbusy and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
					local mainsize = isbusy and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
					local DropCRotation = isbusy and 90 or 0
					TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = listsize
					}):Play()
					TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = mainsize
					}):Play()
					TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Rotation = DropCRotation
					}):Play()
					ListNew = {}
					ListNew = List
					refreshlist()
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': '
					else
						Dropdowntitle.Text = Title .. ': '
					end
				end
				-- THÊM ĐOẠN NÀY
                function dropdownFunction:SetValue(value)
                    if not Selected then
                        -- Dropdown đơn lẻ (single)
                        if table.find(ListNew, value) then
                            Sel.Value = value
                            if Search then
                                Dropdowntitle.PlaceholderText = Title .. ': ' .. value
                            else
                                Dropdowntitle.Text = Title .. ': ' .. value
                            end
                            if Callback then
                                Callback(value)
                            end
                            refreshlist()
                        end
                    else
                        -- Dropdown multi-select
                        if ListNew[value] ~= nil then
                            ListNew[value] = true
                            if Search then
                                Dropdowntitle.PlaceholderText = Title .. ': '
                            else
                                Dropdowntitle.Text = Title .. ': '
                            end
                            if Callback then
                                Callback(value, true)
                            end
                            refreshlist()
                        end
                    end
                end
                
                function dropdownFunction:GetValue()
                    if not Selected then
                        return Sel.Value
                    else
                        local result = {}
                        for key, val in pairs(ListNew) do
                            if val == true then
                                table.insert(result, key)
                            end
                        end
                        return result
                    end
                end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = DropdownFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName,
                    SetValue = dropdownFunction.SetValue,  -- THÊM DÒNG NÀY
                    GetValue = dropdownFunction.GetValue   -- THÊM DÒNG NÀY
                }
                table.insert(getgenv().AllControls, controlData)
                
                if Default and Callback then
                    pcall(Callback, Default)
                end
                
                return dropdownFunction
			end

function sectionFunction:AddKeyBind(Setting, Callback)
    local TitleText = tostring(Setting.Title or Setting.Text) or ""
    local Default = Setting.Default or Setting.Key or "F"
    local Mode = Setting.Mode or "Toggle" -- Hold hoặc Toggle
    local Callback = Setting.Callback or Callback or function() end
    
    local function GetKeyString(key)
        local keyStr = tostring(key)
        keyStr = keyStr:gsub("Enum.UserInputType.", "")
        keyStr = keyStr:gsub("Enum.KeyCode.", "")
        return keyStr
    end
    
    local CurrentKey = GetKeyString(Default)
    local CurrentMode = Mode
    local Picking = false
    local ToggleState = false
    local HoldActive = false
    
    -- UI Elements (BỎ ModeButton)
    local BindFrame = Instance.new("Frame")
    local BindCorner = Instance.new("UICorner")
    local BindBG = Instance.new("Frame")
    local ButtonCorner = Instance.new("UICorner")
    local BindButtonTitle = Instance.new("TextLabel")
    local BindCor = Instance.new("Frame")
    local ButtonCorner_2 = Instance.new("UICorner")
    local Bindkey = Instance.new("TextButton")
    
    BindFrame.Name = TitleText .. "bguvl"
    BindFrame.Parent = Section
    BindFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    BindFrame.BackgroundTransparency = 1.000
    BindFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
    BindFrame.Size = UDim2.new(1, 0, 0, 35)
    
    BindCorner.CornerRadius = UDim.new(0, 8)
    BindCorner.Name = "BindCorner"
    BindCorner.Parent = BindFrame
    
    BindBG.Name = "Background1"
    BindBG.Parent = BindFrame
    BindBG.AnchorPoint = Vector2.new(0.5, 0.5)
    BindBG.Position = UDim2.new(0.5, 0, 0.5, 0)
    BindBG.Size = UDim2.new(1, -10, 1, 0)
    BindBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
    BindBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
    
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Name = "ButtonCorner"
    ButtonCorner.Parent = BindBG
    
    BindButtonTitle.Name = "TextColor"
    BindButtonTitle.Parent = BindBG
    BindButtonTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    BindButtonTitle.BackgroundTransparency = 1.000
    BindButtonTitle.Position = UDim2.new(0, 10, 0, 0)
    BindButtonTitle.Size = UDim2.new(1, -10, 1, 0)
    BindButtonTitle.Font = Enum.Font.GothamBlack
    BindButtonTitle.Text = TitleText
    BindButtonTitle.TextSize = 14.000
    BindButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
    BindButtonTitle.TextColor3 = getgenv().UIColor["Text Color"]
    
    BindCor.Name = "Background2"
    BindCor.Parent = BindBG
    BindCor.AnchorPoint = Vector2.new(1, 0.5)
    BindCor.Position = UDim2.new(1, -5, 0.5, 0)
    BindCor.Size = UDim2.new(0, 150, 0, 25)
    BindCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
    
    ButtonCorner_2.CornerRadius = UDim.new(0, 8)
    ButtonCorner_2.Name = "ButtonCorner"
    ButtonCorner_2.Parent = BindCor
    
    Bindkey.Name = "Bindkey"
    Bindkey.Parent = BindCor
    Bindkey.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    Bindkey.BackgroundTransparency = 1.000
    Bindkey.Size = UDim2.new(1, 0, 1, 0)
    Bindkey.Font = Enum.Font.GothamBold
    Bindkey.Text = CurrentKey
    Bindkey.TextSize = 14.000
    Bindkey.TextColor3 = getgenv().UIColor["Text Color"]
    
    -- Change Key
    Bindkey.MouseButton1Click:Connect(function()
        if Picking then return end
        
        Picking = true
        Bindkey.Text = "..."
        
        task.wait(0.2)
        
        local Connection
        Connection = uis.InputBegan:Connect(function(input)
            if Picking then
                local Key
                
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    Key = input.KeyCode.Name
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Key = "MouseLeft"
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    Key = "MouseRight"
                end
                
                if Key then
                    Picking = false
                    CurrentKey = Key
                    Bindkey.Text = Key
                    Connection:Disconnect()
                end
            end
        end)
    end)
    
    -- Input Began (Press)
    uis.InputBegan:Connect(function(input, gpe)
        if gpe or Picking then return end
        if uis:GetFocusedTextBox() then return end
        
        local pressedKey
        if input.UserInputType == Enum.UserInputType.Keyboard then
            pressedKey = input.KeyCode.Name
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            pressedKey = "MouseLeft"
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            pressedKey = "MouseRight"
        end
        
        if pressedKey == CurrentKey then
            if CurrentMode == "Toggle" then
                ToggleState = not ToggleState
                pcall(Callback, ToggleState)
            elseif CurrentMode == "Hold" then
                HoldActive = true
                pcall(Callback, true)
            end
        end
    end)
    
    -- Input Ended (Release) - Only for Hold mode
    uis.InputEnded:Connect(function(input)
        if Picking then return end
        if uis:GetFocusedTextBox() then return end
        
        local releasedKey
        if input.UserInputType == Enum.UserInputType.Keyboard then
            releasedKey = input.KeyCode.Name
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            releasedKey = "MouseLeft"
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            releasedKey = "MouseRight"
        end
        
        if releasedKey == CurrentKey and CurrentMode == "Hold" and HoldActive then
            HoldActive = false
            pcall(Callback, false)
        end
    end)
    
    local controlData = {
        Name = TitleText,
        Section = Section,
        Element = BindFrame,
        SectionName = Section_Name,
        TabName = Page_Name,
        TabButton = PageName
    }
    table.insert(getgenv().AllControls, controlData)
    
    local keybindFunction = {}
    
    function keybindFunction:Set(newKey)
        CurrentKey = GetKeyString(newKey)
        Bindkey.Text = CurrentKey
    end
    
    function keybindFunction:Get()
        return CurrentKey
    end
    
    function keybindFunction:SetMode(mode)
        if mode == "Hold" or mode == "Toggle" then
            CurrentMode = mode
            ToggleState = false
            HoldActive = false
        end
    end
    
    function keybindFunction:GetMode()
        return CurrentMode
    end
    
    function keybindFunction:GetState()
        if CurrentMode == "Toggle" then
            return ToggleState
        elseif CurrentMode == "Hold" then
            return HoldActive
        end
        return false
    end
    
    if Callback and Default then
        pcall(Callback, Default)
    end
    
    return keybindFunction
end
			function sectionFunction:AddInput(idk, Setting)
				local TitleText = tostring(Setting.Text or Setting.Title) or ""
				local Placeholder = tostring(Setting.Placeholder) or ""
				local Default = Setting.Default or false
				local Number_Only = Setting.Numeric or false
				local Callback = Setting.Callback
				local BoxFrame = Instance.new("Frame")
				local BoxCorner = Instance.new("UICorner")
				local BoxBG = Instance.new("Frame")
				local ButtonCorner = Instance.new("UICorner")
				local Boxtitle = Instance.new("TextLabel")
				local BoxCor = Instance.new("Frame")
				local ButtonCorner_2 = Instance.new("UICorner")
				local Boxxx = Instance.new("TextBox")
				local Lineeeee = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				BoxFrame.Name = "BoxFrame"
				BoxFrame.Parent = Section
				BoxFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				BoxFrame.BackgroundTransparency = 1.000
				BoxFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
				BoxFrame.Size = UDim2.new(1, 0, 0, 60)
				BoxCorner.CornerRadius = UDim.new(0, 8)
				BoxCorner.Name = "BoxCorner"
				BoxCorner.Parent = BoxFrame
				BoxBG.Name = "Background1"
				BoxBG.Parent = BoxFrame
				BoxBG.AnchorPoint = Vector2.new(0.5, 0.5)
				BoxBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				BoxBG.Size = UDim2.new(1, -10, 1, 0)
				BoxBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				BoxBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				ButtonCorner.CornerRadius = UDim.new(0, 8)
				ButtonCorner.Name = "ButtonCorner"
				ButtonCorner.Parent = BoxBG
				Boxtitle.Name = "TextColor"
				Boxtitle.Parent = BoxBG
				Boxtitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Boxtitle.BackgroundTransparency = 1.000
				Boxtitle.Position = UDim2.new(0, 10, 0, 0)
				Boxtitle.Size = UDim2.new(1, -10, 0.5, 0)
				Boxtitle.Font = Enum.Font.GothamBlack
				Boxtitle.Text = TitleText
				Boxtitle.TextSize = 14.000
				Boxtitle.TextXAlignment = Enum.TextXAlignment.Left
				Boxtitle.TextColor3 = getgenv().UIColor["Text Color"]
				BoxCor.Name = "Background2"
				BoxCor.Parent = BoxBG
				BoxCor.AnchorPoint = Vector2.new(1, 0.5)
				BoxCor.ClipsDescendants = true
				BoxCor.Position = UDim2.new(1, -5, 0, 40)
				BoxCor.Size = UDim2.new(1, -10, 0, 25)
				BoxCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				ButtonCorner_2.CornerRadius = UDim.new(0, 8)
				ButtonCorner_2.Name = "ButtonCorner"
				ButtonCorner_2.Parent = BoxCor
				Boxxx.Name = "TextColorPlaceholder"
				Boxxx.Parent = BoxCor
				Boxxx.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Boxxx.BackgroundTransparency = 1.000
				Boxxx.Position = UDim2.new(0, 5, 0, 0)
				Boxxx.Size = UDim2.new(1, -5, 1, 0)
				Boxxx.Font = Enum.Font.GothamBold
				Boxxx.PlaceholderText = Placeholder
				Boxxx.Text = ""
				Boxxx.TextSize = 14.000
				Boxxx.TextXAlignment = Enum.TextXAlignment.Left
				Boxxx.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
				Boxxx.TextColor3 = getgenv().UIColor["Text Color"]
				Lineeeee.Name = "TextNSBoxLineeeee"
				Lineeeee.Parent = BoxCor
				Lineeeee.BackgroundTransparency = 1.000
				Lineeeee.Position = UDim2.new(0, 0, 1, -2)
				Lineeeee.Size = UDim2.new(1, 0, 0, 6)
				Lineeeee.BackgroundColor3 = getgenv().UIColor["Box Highlight Color"]
				UICorner.CornerRadius = UDim.new(1, 0)
				UICorner.Parent = Lineeeee
				Boxxx.Focused:Connect(function()
					TweenService:Create(Lineeeee, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundTransparency = 0
					}):Play()
				end)
				if Number_Only then
					Boxxx:GetPropertyChangedSignal("Text"):Connect(function()
						if tonumber(Boxxx.Text) then
						else
							Boxxx.PlaceholderText = Placeholder
							Boxxx.Text = ''
						end
					end)
				end
				Boxxx.FocusLost:Connect(function()
					TweenService:Create(Lineeeee, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundTransparency = 1
					}):Play()
					if Boxxx.Text ~= '' then
						Callback(Boxxx.Text)
					end
				end)
				local textbox_function = {}
				if Default then
					Boxxx.Text = Default
				end
				function textbox_function.SetValue(Value)
					Boxxx.Text = Value
					Callback(Value)
				end
				local controlData = {
                    Name = TitleText,
                    Section = Section,
                    Element = BoxFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
                if Callback and Default then
                    pcall(Callback, Default)
                end
                
				return textbox_function;
			end
			function sectionFunction:AddSlider(Setting)
				local TitleText = tostring(Setting.Text or Setting.Title) or ""
				local minValue = tonumber(Setting.Min) or 0
				local maxValue = tonumber(Setting.Max) or 100
				local Precise = Setting.Precise or false
				local DefaultValue = tonumber(Setting.Default) or 0
				local Callback = Setting.Callback
				local SizeChia = 400;
				local SliderFrame = Instance.new("Frame")
				local SliderCorner = Instance.new("UICorner")
				local SliderBG = Instance.new("Frame")
				local SliderBGCorner = Instance.new("UICorner")
				local SliderTitle = Instance.new("TextLabel")
				local SliderBar = Instance.new("Frame")
				local SliderButton = Instance.new("TextButton")
				local SliderBarCorner = Instance.new("UICorner")
				local Bar = Instance.new("Frame")
				local BarCorner = Instance.new("UICorner")
				local Sliderboxframe = Instance.new("Frame")
				local Sliderbox = Instance.new("UICorner")
				local Sliderbox_2 = Instance.new("TextBox")
				SliderFrame.Name = TitleText .. 'buda'
				SliderFrame.Parent = Section
				SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				SliderFrame.BackgroundTransparency = 1.000
				SliderFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
				SliderFrame.Size = UDim2.new(1, 0, 0, 50)
				SliderCorner.CornerRadius = UDim.new(0, 8)
				SliderCorner.Name = "SliderCorner"
				SliderCorner.Parent = SliderFrame
				SliderBG.Name = "Background1"
				SliderBG.Parent = SliderFrame
				SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				SliderBG.Size = UDim2.new(1, -10, 1, 0)
				SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				SliderBGCorner.CornerRadius = UDim.new(0, 8)
				SliderBGCorner.Name = "SliderBGCorner"
				SliderBGCorner.Parent = SliderBG
				SliderTitle.Name = "TextColor"
				SliderTitle.Parent = SliderBG
				SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				SliderTitle.BackgroundTransparency = 1.000
				SliderTitle.Position = UDim2.new(0, 10, 0, 0)
				SliderTitle.Size = UDim2.new(1, -10, 0, 25)
				SliderTitle.Font = Enum.Font.GothamBlack
				SliderTitle.Text = TitleText
				SliderTitle.TextSize = 14.000
				SliderTitle.RichText = true
				SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
				SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
				SliderBar.Name = "SliderBar"
				SliderBar.Parent = SliderFrame
				SliderBar.AnchorPoint = Vector2.new(.5, 0.5)
				SliderBar.Position = UDim2.new(.5, 0, 0.5, 14)
				SliderBar.Size = UDim2.new(1, -24, 0, 6)
				SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				SliderButton.Name = "SliderButton "
				SliderButton.Parent = SliderBar
				SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				SliderButton.BackgroundTransparency = 1.000
				SliderButton.Size = UDim2.new(1, 0, 1, 0)
				SliderButton.Font = Enum.Font.GothamBold
				SliderButton.Text = ""
				SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
				SliderButton.TextSize = 14.000
				SliderBarCorner.CornerRadius = UDim.new(1, 0)
				SliderBarCorner.Name = "SliderBarCorner"
				SliderBarCorner.Parent = SliderBar
				Bar.Name = "Bar"
				Bar.BorderSizePixel = 0
				Bar.Parent = SliderBar
				Bar.Size = UDim2.new(0, 0, 1, 0)
				Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
				BarCorner.CornerRadius = UDim.new(1, 0)
				BarCorner.Name = "BarCorner"
				BarCorner.Parent = Bar
				Sliderboxframe.Name = "Background2"
				Sliderboxframe.Parent = SliderFrame
				Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
				Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
				Sliderboxframe.Size = UDim2.new(0, 150, 0, 25)
				Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				Sliderbox.CornerRadius = UDim.new(0, 8)
				Sliderbox.Name = "Sliderbox"
				Sliderbox.Parent = Sliderboxframe
				Sliderbox_2.Name = "TextColor"
				Sliderbox_2.Parent = Sliderboxframe
				Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Sliderbox_2.BackgroundTransparency = 1.000
				Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
				Sliderbox_2.Font = Enum.Font.GothamBold
				Sliderbox_2.Text = ""
				Sliderbox_2.TextSize = 14.000
				Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
				SliderButton.MouseEnter:Connect(function()
					TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]
					}):Play()
				end)
				SliderButton.MouseLeave:Connect(function()
					TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
					}):Play()
				end)
				local callBackAndSetText = function(val)
					Sliderbox_2.Text = val
					Callback(tonumber(val))
				end
				if DefaultValue then
					if DefaultValue <= minValue then
						DefaultValue = minValue
					elseif DefaultValue >= maxValue then
						DefaultValue = maxValue
					end
					Sliderbox_2.Text = tostring(DefaultValue)
					Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
				end
				local dragging = false
				local dragInput
				local holdTime = 0 -- Time to hold before dragging is enabled
				local holdStarted = 0

						-- Function to detect the start of dragging (for both mouse and touch)
				local function onInputBegan(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						holdStarted = tick() -- Record the time when holding starts
						
								-- Listen for release to stop dragging
						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								dragging = false
								holdStarted = 0 -- Reset the hold timer
							end
						end)
					end
				end
						
						-- Function to detect when dragging stops
				local function onInputEnded(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
						holdStarted = 0 -- Reset the hold timer
					end
				end

						-- Detect input movement (for both mouse and touch)
				local function onInputChanged(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						dragInput = input
					end
				end
						
						-- Connect the events
				SliderButton.InputBegan:Connect(onInputBegan)
				SliderButton.InputEnded:Connect(onInputEnded)
				SliderButton.InputChanged:Connect(onInputChanged)
						
						-- RenderStepped updates the position while dragging
				RunService.RenderStepped:Connect(function()
					if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
						dragging = true
					end
					if dragging and dragInput then
						local value = Setting.Rouding and  tonumber(string.format("%.".. Setting.Rouding or 1 .."f", (((tonumber(maxValue) - tonumber(minValue)) / SliderBar.AbsoluteSize.X) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SliderBar.AbsoluteSize.X) * Bar.AbsoluteSize.X) + tonumber(minValue))
						pcall(function()
							callBackAndSetText(value)
						end)
						Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X), 0, 6)
					end
				end)
				local function GetSliderValue(Value)
					if tonumber(Value) <= minValue then
						Bar.Size = UDim2.new(0, (0 * SliderBar.AbsoluteSize.X), 0, 6)
						callBackAndSetText(minValue)
					elseif tonumber(Value) >= maxValue then
						Bar.Size = UDim2.new(0, (maxValue  /  maxValue * SliderBar.AbsoluteSize.X), 0, 6)
						callBackAndSetText(maxValue)
					else
						Bar.Size = UDim2.new(1 - ((maxValue - Value) / (maxValue - minValue)), 0, 0, 6)
						callBackAndSetText(Value)
					end
				end
				Sliderbox_2.FocusLost:Connect(function()
					GetSliderValue(Sliderbox_2.Text)
				end)
				local slider_function = {}
				function slider_function.SetValue(Value)
					GetSliderValue(Value)
				end
				local controlData = {
                    Name = TitleText,
                    Section = Section,
                    Element = SliderFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
                if Callback and DefaultValue then
                    pcall(Callback, DefaultValue)
                end
                
				return slider_function
			end
			return sectionFunction
		end
        local pagefunc = {}
        function pagefunc:AddLeftGroupbox(name)
            return pageFunction:AddSection(name)
        end
        function pagefunc:AddRightGroupbox(name)
            return pageFunction:AddSection(name)
        end
		return pagefunc
        end

	return Main_Function
end

return Library

end)()
local v237 = lib:CreateWindow({
	Title = "Meizu Hub",
	Subtitle = "BLOX FRUITS - MOBILE COMPANION | v1.1.0",
	Image = getgenv().KilluaLogoAsset
})
local t15 = {
	Info = v237:AddTab("Info And Status"),
	Main = v237:AddTab("Farming"),
	Settings = v237:AddTab("Setting"),
	Fish = v237:AddTab("Fishing"),
	Quests = v237:AddTab("Quest And Item"),
	SeaEvent = v237:AddTab("Sea Event"),
	Race = v237:AddTab("Mirage And Race"),
	Prehistoric = v237:AddTab("Volcano Event"),
	Esp = v237:AddTab("Stats And Esp"),
	Raids = v237:AddTab("Fruit And Raid"),
	Combat = v237:AddTab("Local Player"),
	Travel = v237:AddTab("Teleport"),
	Shop = v237:AddTab("Shopping"),
	Misc = v237:AddTab("Miscellaneous")
}

-- v1.1.1: removed forced pink accent; default is Meizu blue (56,132,255)
lib.ToggleUI()

-- v1.1.4: anti-old-ui guard - every 0.2s kill old "Meizu Hub GUI" and force-lock header layout
spawn(function()
	while task.wait(0.2) do
		pcall(function()
			local cg = game:GetService("CoreGui")
			for _, g in ipairs(cg:GetChildren()) do
				if g:IsA("ScreenGui") and g ~= Library_Function.Gui and g ~= Library_Function.NotiGui and g ~= Library_Function.HideGui then
					local n = g.Name
					if n == "Meizu Hub GUI" or n == "Meizu Hub Notification" or n == "Meizu Hub Btn" or string.find(n, "Banana") or string.find(n, "Night Slayer") or string.find(n, "Redz") then
						g:Destroy()
					end
				end
			end
			local gui = Library_Function.Gui
			if gui then
				gui.Enabled = getgenv().UIToggled
				gui.DisplayOrder = 999
				local icon = gui:FindFirstChild("Ruafimg", true)
				if icon then
					icon.Position = UDim2.new(0, 12, 0, 8)
					icon.Size = UDim2.new(0, 40, 0, 40)
				end
				local title = gui:FindFirstChild("TextLabelMain", true)
				if title then title.Position = UDim2.new(0, 62, 0, 8) end
				local sub = gui:FindFirstChild("SubtitleLabel", true)
				if sub then sub.Text = string.upper(getgenv().MainDesc or "BLOX FRUITS - MOBILE COMPANION | v1.1.4") end
			end
		end)
	end
end)

do
	local v239 = t15.Info:AddLeftGroupbox("Time Zone"):AddLabel("")

	UpdateOS = function()
		local v240 = os.date("*t")
		local v241 = v240.hour % 24
		local v242 = v241 < 12 and "AM"
		local v243 = string.format("%02i:%02i:%02i %s", (v241 - 1) % 12 + 1, v240.min, v240.sec, v242 or "PM")
		local v244 = string.format("%02d/%02d/%04d", v240.day, v240.month, v240.year)
		local LocalizationService = game:GetService("LocalizationService")
		local LocalPlayer = game:GetService("Players").LocalPlayer
		local countryRegionCode

		if getgenv().countryRegionCode then
			countryRegionCode = getgenv().countryRegionCode
		else
			local ok

			ok, countryRegionCode = pcall(function()
				return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)
			end)

			if ok then
				getgenv().countryRegionCode = countryRegionCode
			else
				getgenv().countryRegionCode = "Không xác định"
			end
		end

		v239:SetText(v244 .. " - " .. v243 .. " [ " .. countryRegionCode .. " ]")
	end
end

spawn(function()
	while true do
		UpdateOS()
		wait(1)
	end
end)

do
	local v249 = t15.Info:AddLeftGroupbox("Game Time"):AddLabel("")

	UpdateGameTime = function()
		local v250 = math.floor(workspace.DistributedGameTime + 0.5)

		v249:SetText(math.floor(v250 / 3600) % 24 .. " Hour (h) " .. math.floor(v250 / 60) % 60 .. " Minute (m) " .. math.floor(v250 / 1) % 60 .. " Second (s)")
	end
end

spawn(function()
	while true do
		UpdateGameTime()
		wait(1)
	end
end)

do
	local v251 = t15.Info:AddLeftGroupbox("Mirage Island"):AddLabel("Status: ")
	local s1 = ""

	spawn(function()
		pcall(function()
			while true do
				wait(1)

				local status = game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") ~= nil and "✅" or "❌"

				if status ~= s1 then
					v251:SetText("Trạng thái: " .. status)
					s1 = status
				end
			end
		end)
	end)
end

do
	local v254 = t15.Info:AddLeftGroupbox("Kitsune Island"):AddLabel("Status: ")
	local s2 = ""

	spawn(function()
		while task.wait(1) do
			local status = game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") and "✅" or "❌"

			if status ~= s2 then
				v254:SetText("Trạng thái: " .. status)
				s2 = status
			end
		end
	end)
end

do
	local v257 = t15.Info:AddLeftGroupbox("Prehistoric Island"):AddLabel("Status: ")
	local s3 = ""

	task.spawn(function()
		while task.wait(1) do
			local status = game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") and "✅" or "❌"

			if status ~= s3 then
				v257:SetText("Trạng thái: " .. status)
				s3 = status
			end
		end
	end)
end

do
	local v260 = t15.Info:AddLeftGroupbox("Frozen Dimension"):AddLabel("Status: ")
	local s4 = ""

	spawn(function()
		while wait(1) do
			local status = game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") and "✅" or "❌"

			if status ~= s4 then
				v260:SetText("Trạng thái: " .. status)
				s4 = status
			end
		end
	end)
end

do
	local v263 = t15.Info:AddLeftGroupbox("Cake Prince Status"):AddLabel("")

	spawn(function()
		while wait(1) do
			local response = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
			local s5 = "Cake Prince: ✅"

			if string.len(response) >= 86 then
				s5 = "Killed: " .. string.sub(response, 39, 41)
			end

			v263:SetText(s5)
		end
	end)
end

do
	local v266 = t15.Info:AddLeftGroupbox("Rip Indra"):AddLabel("Status: ")
	local s6 = ""

	spawn(function()
		while wait(1) do
			local RipIndraTrueForm = game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form")

			RipIndraTrueForm = (RipIndraTrueForm or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra")) and "✅"
			RipIndraTrueForm = RipIndraTrueForm or "❌"

			if RipIndraTrueForm ~= s6 then
				v266:SetText("Trạng thái: " .. RipIndraTrueForm)
				s6 = RipIndraTrueForm
			end
		end
	end)
end

do
	local v269 = t15.Info:AddLeftGroupbox("Dough King"):AddLabel("Status: ")
	local s7 = ""

	spawn(function()
		while wait(1) do
			local status = (game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") or game:GetService("Workspace").Enemies:FindFirstChild("Dough King")) and "✅" or "❌"

			if status ~= s7 then
				v269:SetText("Trạng thái: " .. status)
				s7 = status
			end
		end
	end)
end

do
	local v272 = t15.Info:AddLeftGroupbox("Full Moon"):AddLabel("")

	task.spawn(function()
		while task.wait(1) do
			local MoonTextureId = game:GetService("Lighting").Sky.MoonTextureId
			local s8 = "Moon: 0/5"

			if MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
				s8 = "Moon: 5/5 (Full Moon) ✅"
			elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
				s8 = "Moon: 4/5"
			elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
				s8 = "Moon: 3/5"
			elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
				s8 = "Moon: 2/5"
			elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
				s8 = "Moon: 1/5"
			end

			v272:SetText(s8)
		end
	end)
end

do
	local v275 = t15.Info:AddLeftGroupbox("Legendary Sword"):AddLabel("Status: ")

	spawn(function()
		while wait(1) do
			local s9 = "Not Found"

			if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1") then
				s9 = "Shisui ✅"
			elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2") then
				s9 = "Wando ✅"
			elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3") then
				s9 = "Saddi ✅"
			end

			v275:SetText(s9)
		end
	end)
end

local v277 = t15.Info:AddLeftGroupbox("Bone"):AddLabel("")

GRP_Main_Select_Weapon = t15.Main:AddLeftGroupbox("Select Weapon")
WeaponDropdown = GRP_Main_Select_Weapon:AddDropdown("Select_Weapon", {
	Text = "Select Weapon",
	Values = {
		"Melee",
		"Sword",
		"Blox Fruit",
		"Gun"
	},
	Default = "Melee",
	Callback = function(p62)
		_G.ChooseWP = p62
	end
})

do
	spawn(function()
		while task.wait(0.5) do
			pcall(function()
				if _G.ChooseWP == "Melee" then
					for _, child in pairs(plr.Backpack:GetChildren()) do
						if child.ToolTip == "Melee" then
							_G.SelectWeapon = child.Name
						end
					end
				elseif _G.ChooseWP == "Sword" then
					for _, child in pairs(plr.Backpack:GetChildren()) do
						if child.ToolTip == "Sword" then
							_G.SelectWeapon = child.Name
						end
					end
				elseif _G.ChooseWP == "Gun" then
					for _, child in pairs(plr.Backpack:GetChildren()) do
						if child.ToolTip == "Gun" then
							_G.SelectWeapon = child.Name
						end
					end
				elseif _G.ChooseWP == "Blox Fruit" then
					for _, child in pairs(plr.Backpack:GetChildren()) do
						if child.ToolTip == "Blox Fruit" then
							_G.SelectWeapon = child.Name
						end
					end
				end
			end)
		end
	end)
end

GRP_Main_Farming = t15.Main:AddLeftGroupbox("Farming")
FarmLevel = GRP_Main_Farming:AddToggle("Auto_Farm_Level", {
	Text = "Auto Farm Level",
	Default = false,
	Callback = function(p63)
		_G.Level = p63

		if not p63 then
			alreadyTeleported = false
			teleporting = false
		end
	end
})

do
	local u286 = false
	local u287 = false

	_G.CheckQuestVisible = function(p64)
		local LocalPlayer = p64 or game.Players.LocalPlayer
		local Quest = LocalPlayer.PlayerGui:FindFirstChild("Main") and LocalPlayer.PlayerGui.Main:FindFirstChild("Quest")
		local TrackedQuestFrame = LocalPlayer.PlayerGui:FindFirstChild("TrackedQuestFrame")

		if Quest and Quest.Visible then
			local s10 = ""

			pcall(function()
				s10 = Quest.Container.QuestTitle.Title.Text
			end)

			return true, s10
		end

		if TrackedQuestFrame then
			if TrackedQuestFrame.Enabled then
				local s11 = ""

				pcall(function()
					s11 = TrackedQuestFrame.Frame.header.textLabel.Text
				end)

				if s11 == "" then
					pcall(function()
						s11 = TrackedQuestFrame.Frame.header.textLabel.textLabel.Text
					end)
				end

				return true, s11
			end
		end

		return false, ""
	end

	local function v293()
		if not plr.Character then
			return false
		end

		local HumanoidRootPart = plr.Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return false
		end

		if HumanoidRootPart.Position.Y < -1000 then
			return true
		end

		local vector3 = Vector3.new(10533.28, 0, 9940.48)

		return (Vector3.new(HumanoidRootPart.Position.X, 0, HumanoidRootPart.Position.Z) - vector3).Magnitude < 4500
	end
	local function v296(...)
		local Main = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main")

		if not Main then
			return nil
		end

		local v298 = Main

		for _, v1 in ipairs({ ... }) do
			if v298 then
				v298 = v298:FindFirstChild(v1)

				continue
			end

			return nil
		end

		return v298
	end
	local function v301(...)
		if select("#", ...) == 1 and select(1, ...) == "Quest" then
			local TrackedQuestFrame = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TrackedQuestFrame")

			if TrackedQuestFrame then
				local Frame = TrackedQuestFrame:FindFirstChild("Frame")

				if Frame then
					return TrackedQuestFrame.Enabled and Frame.Visible
				end
			end
		end

		local v304 = v296(...)

		return v304 ~= nil and v304.Visible == true
	end
	local function v305()
		local TrackedQuestFrame = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TrackedQuestFrame")

		if TrackedQuestFrame then
			local Frame = TrackedQuestFrame:FindFirstChild("Frame")

			if Frame and Frame.Visible then
				local header = Frame:FindFirstChild("header")
				local textLabel = header and header:FindFirstChild("textLabel")

				if textLabel and textLabel:IsA("TextLabel") then
					return tostring(textLabel.Text)
				end
			end
		end

		local Quest = v296("Quest", "Container", "QuestTitle", "Title")

		if Quest then
			return tostring(Quest.Text)
		end

		return ""
	end
	local function v311(p65)
		if not p65 then
			return false
		end

		if not v301("Quest") then
			return false
		end

		local v312 = v305()

		if v312 == "" then
			return false
		end

		return string.find(string.lower(v312), string.lower(p65), 1, true) ~= nil
	end
	local function v313(p66, p67, p68)
		if v311(p68) then
			return true
		end

		local CommF_ = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") and game:GetService("ReplicatedStorage").Remotes:FindFirstChild("CommF_")

		if not CommF_ then
			return false
		end

		local function v315()
			return CommF_:InvokeServer("StartQuest", p66, p67)
		end

		local ok = pcall(v315)

		if not ok then
			return false
		end

		local v318 = os.clock() + 3

		repeat
			if v311(p68) then
				return true
			end

			task.wait(0.25)
		until v318 <= os.clock()

		return v311(p68)
	end

	task.spawn(function()
		while task.wait(Sec) do
			if _G.Level then
				local exitTo

				repeat
					pcall(function()
						local Character = plr.Character or plr.CharacterAdded:Wait()
						local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

						if not HumanoidRootPart then
							return
						end

						local Value = plr.Data.Level.Value
						local v323 = v293()

						v301("Quest")
						v305()

						if World3 and Value >= 2600 and not (v323 or u287 or u286) then
							u287 = true

							local cFrame = CFrame.new(-16269.7041, 25.2288494, 1373.65955)
							local n2 = 0

							while true do
								task.wait(Sec)
								_tp(cFrame)
								n2 += 1

								if _G.Level then
									if (HumanoidRootPart.Position - cFrame.Position).Magnitude <= 8 or n2 > 20 then
										break
									end
								else
									break
								end
							end

							if not _G.Level then
								u287 = false

								return
							end

							task.wait(1)
							pcall(function()
								game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer(unpack({ "TravelToSubmergedIsland" }))
							end)

							local now = tick()

							while true do
								task.wait(0.5)

								local v327 = v293()
								local v328 = (HumanoidRootPart.Position - cFrame.Position).Magnitude > 50

								if v327 then
									break
								elseif v328 or not _G.Level or tick() - now > 15 then
									break
								end
							end

							task.wait(2)
							u286 = true
							u287 = false
						elseif v323 or Value < 2600 or not World3 then
							u286 = true
							u287 = false

							local v329 = QuestNeta()

							if not v329 or not v329[1] then
								task.wait(1)

								return
							end

							local Quest = v301("Quest")

							if Quest then
								Quest = v311(v329[5] or v329[1])
							end

							if v301("Quest") and not Quest then
								replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
								task.wait(0.2)

								return
							end

							if not Quest then
								local v331 = v329[6]

								if v331 then
									_tp(v331)
									task.wait(2)

									if (HumanoidRootPart.Position - v331.Position).Magnitude <= 10 then
										v313(v329[3], v329[2], v329[5] or v329[1])
									end
								else
									v313(v329[3], v329[2], v329[5] or v329[1])
								end

								return
							end

							local v332 = v329[1]
							local v333 = false
							local v334, v335, v336 = pairs(workspace.Enemies:GetChildren())
							local v337 = geniter(v334, v335, v336)
							local exitTo
							local v339

							while true do
								local v340 = table.pack(v337())

								if not v340[1] then
									break
								end

								v339 = v340[3]

								if string.find(v339.Name, v332) and t9.Alive(v339) then
									exitTo = 1

									break
								end
							end

							if exitTo == 1 then
								v333 = true

								while true do
									task.wait(Sec)
									_tp(v339.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
									t9.Kill(v339, _G.Level)

									if v301("Quest") then
										if not _G.Level or not v339.Parent or v339.Humanoid.Health <= 0 then
											break
										end
									else
										break
									end
								end
							end

							if not v333 then
								local v341, v342, v343 = pairs(replicated:GetChildren())
								local v344 = geniter(v341, v342, v343)

								while true do
									local v345 = table.pack(v344())

									if not v345[1] then
										break
									end

									local v346 = v345[3]

									if string.find(v346.Name, v332) then
										if t9.Alive(v346) then
											v333 = true
											_tp(v346.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))

											break
										end
									end
								end
							end

							if not v333 then
								local v347, v348, v349 = pairs(workspace._WorldOrigin.EnemySpawns:GetChildren())

								for _, v1 in v347, v348, v349 do
									if string.find(v1.Name, v332) then
										_tp(v1.CFrame * CFrame.new(0, 20, 0))

										break
									end
								end
							end
						end
					end)
					exitTo = nil

					while task.wait(Sec) do
						if _G.Level then
							exitTo = 1

							break
						end

						u287 = false
						u286 = false
					end
				until exitTo ~= 1

				return
			end

			u287 = false
			u286 = false
		end
	end)
end

ClosetMons = GRP_Main_Farming:AddToggle("Auto_Farm_Nearest", {
	Text = "Auto Farm Nearest",
	Default = false,
	Callback = function(p69)
		_G.AutoFarmNear = p69
	end
})
spawn(function()
	if wait() then
		repeat
			pcall(function()
				if _G.AutoFarmNear then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if (child:FindFirstChild("Humanoid") or child:FindFirstChild("HumanoidRootPart")) and child.Humanoid.Health > 0 then
							while true do
								wait()
								t9.Kill(child, _G.AutoFarmNear)

								if _G.AutoFarmNear then
									if not child.Parent or child.Humanoid.Health <= 0 then
										break
									end
								else
									break
								end
							end
						end
					end
				end
			end)
		until not wait()
	end
end)
FactoryRaids = GRP_Main_Farming:AddToggle("Auto_Factory_Raid", {
	Text = "Auto Factory Raid",
	Default = false,
	Callback = function(p70)
		_G.AutoFactory = p70
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.AutoFactory then
				local Core = GetConnectionEnemies("Core")

				if Core then
					while true do
						wait()
						EquipWeapon(_G.SelectWeapon)
						_tp(CFrame.new(448.46756, 199.356781, -441.389252))

						if Core.Humanoid.Health <= 0 then
							break
						elseif _G.AutoFactory == false then
							break
						end
					end
				else
					_tp(CFrame.new(448.46756, 199.356781, -441.389252))
				end
			end
		end)
	end
end)

do
	CastleRaids = GRP_Main_Farming:AddToggle("Auto_Pirate_Raid", {
		Text = "Auto Pirate Raid",
		Default = false,
		Callback = function(p71)
			_G.AutoRaidCastle = p71
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.AutoRaidCastle then
				pcall(function()
					local cFrame = CFrame.new(-5496.17432, 313.768921, -2841.53027, 0.924894512, 7.37058015e-09, 0.380223751, 3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, 0.924894512)

					if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - Root.Position).Magnitude <= 500 then
						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 and child.Name and (child.HumanoidRootPart.Position - Root.Position).Magnitude <= 2000 then
								while true do
									wait()
									t9.Kill(child, _G.AutoRaidCastle)

									if _G.AutoRaidCastle and child.Parent and not (child.Humanoid.Health <= 0) then
										if not workspace.Enemies:FindFirstChild(child.Name) then
											break
										end
									else
										break
									end
								end
							end
						end
					else
						local t16 = {
							"Galley Pirate",
							"Galley Captain",
							"Raider",
							"Mercenary",
							"Vampire",
							"Zombie",
							"Snow Trooper",
							"Winter Warrior",
							"Lab Subordinate",
							"Horned Warrior",
							"Magma Ninja",
							"Lava Pirate",
							"Ship Deckhand",
							"Ship Engineer",
							"Ship Steward",
							"Ship Officer",
							"Arctic Warrior",
							"Snow Lurker",
							"Sea Soldier",
							"Water Fighter"
						}

						for i = 1, #t16 do
							if replicated:FindFirstChild(t16[i]) then
								for _, child in pairs(replicated:GetChildren()) do
									if table.find(t16, child.Name) then
										_tp(cFrame)
									end
								end
							end
						end
					end
				end)
			end
		end
	end)
end

Ecto = GRP_Main_Farming:AddToggle("Auto_Farm_Ectoplasm", {
	Text = "Auto Farm Ectoplasm",
	Default = false,
	Callback = function(p72)
		_G.AutoEctoplasm = p72
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.AutoEctoplasm then
				local v362 = GetConnectionEnemies({
					"Ship Deckhand",
					"Ship Engineer",
					"Ship Steward",
					"Ship Officer",
					"Arctic Warrior"
				})

				if t9.Alive(v362) then
					while true do
						wait()
						t9.Kill(v362, _G.AutoEctoplasm)

						if _G.AutoEctoplasm then
							if not v362.Parent or v362.Humanoid.Health <= 0 then
								break
							end
						else
							break
						end
					end
				else
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			end
		end)
	end
end)
GRP_Main_Chest = t15.Main:AddLeftGroupbox("Chest")

do
	ChestTW = GRP_Main_Chest:AddToggle("Auto_Farm_Chest", {
		Text = "Auto Farm Chest",
		Default = false,
		Callback = function(p73)
			_G.AutoFarmChest = p73
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.AutoFarmChest then
			pcall(function()
				local CollectionService = game:GetService("CollectionService")
				local LocalPlayer = game:GetService("Players").LocalPlayer
				local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

				if not Character then
					return
				end

				local Position = Character:GetPivot().Position
				local tagged = CollectionService:GetTagged("_ChestTagged")
				local huge = math.huge
				local v369

				for i = 1, #tagged do
					local v371 = tagged[i]
					local Magnitude = (v371:GetPivot().Position - Position).Magnitude

					if (not SelectedIsland or v371:IsDescendantOf(SelectedIsland)) and not v371:GetAttribute("IsDisabled") and Magnitude < huge then
						huge = Magnitude
						v369 = v371
					end
				end

				if v369 then
					_tp(v369:GetPivot())
				end
			end)
		end
	end
end)

do
	ChestBP = GRP_Main_Chest:AddToggle("Auto_Chest_Bypass", {
		Text = "Auto Chest Bypass",
		Default = false,
		Callback = function(p74)
			_G.AutoChestBP = p74

			if p74 then
				local LocalPlayer = game:GetService("Players").LocalPlayer
				local u374 = false
				local t17 = {}
				local u376 = true

				local function v377()
					if not LocalPlayer.Character then
						LocalPlayer.CharacterAdded:Wait()
					end

					LocalPlayer.Character:WaitForChild("HumanoidRootPart")

					return LocalPlayer.Character
				end
				local function v378()
					if u376 then
						u376 = false

						for _, descendant in pairs(game:GetDescendants()) do
							if descendant.Name:find("Chest") and descendant.ClassName == "Part" then
								table.insert(t17, descendant)
							end
						end
					end

					local t18 = {}

					for _, v1 in pairs(t17) do
						if v1:FindFirstChild("TouchInterest") then
							table.insert(t18, v1)
						end
					end

					local LowerTorso = v377().LowerTorso

					table.sort(t18, function(p75, p76)
						return (LowerTorso.Position - p75.Position).Magnitude < (LowerTorso.Position - p76.Position).Magnitude
					end)

					return t18
				end
				local function v385()
					if u374 then
						return
					end

					u374 = true
					task.spawn(function()
						while _G.AutoChestBP do
							if not LocalPlayer.Character or not LocalPlayer.Character.Parent then
								break
							end

							local v386 = v378()

							if #v386 > 0 then
								v377().HumanoidRootPart.CFrame = v386[1].CFrame
							end

							task.wait(0.1)
						end

						u374 = false
					end)
				end

				LocalPlayer.CharacterAdded:Connect(function()
					v377()
					task.wait(0.5)

					if _G.AutoChestBP then
						v385()
					end
				end)
				v385()
			end
		end
	})
end

do
	StopI = GRP_Main_Chest:AddToggle("Stop_Items", {
		Text = "Stop Items",
		Default = true,
		Callback = function(p77)
			_G.StopWhenChalice = p77
		end
	})
end

do
	spawn(function()
		while wait(0.2) do
			if _G.StopWhenChalice and (_G.AutoFarmChest or _G.AutoChestBP) then
				local exitTo

				repeat
					pcall(function()
						if GetBP("God's Chalice") or GetBP("Sweet Chalice") then
							_G.AutoFarmChest = false
							_G.AutoChestBP = false
						elseif GetBP("Fist of Darkness") then
							_G.AutoFarmChest = false
							_G.AutoChestBP = false

							return
						end
					end)
					exitTo = nil

					while wait(0.2) do
						if _G.StopWhenChalice and (_G.AutoFarmChest or _G.AutoChestBP) then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

GRP_Main_Collect_Berry = t15.Main:AddLeftGroupbox("Collect Berry")
Berry = GRP_Main_Collect_Berry:AddToggle("Auto_Farm_Berry", {
	Text = "Auto Farm Berry",
	Default = false,
	Callback = function(p78)
		_G.AutoBerry = p78
	end
})
spawn(function()
	while wait(Sec) do
		if _G.AutoBerry then
			pcall(function()
				local CollectionService = game:GetService("CollectionService")
				local tagged = CollectionService:GetTagged("BerryBush")
				for _, bush in ipairs(tagged) do
					if not _G.AutoBerry then break end
					_tp(bush.Parent:GetPivot())
					task.wait(0.2)
					for _, child in pairs(bush:GetChildren()) do
						if child:FindFirstChild("ProximityPrompt") then
							pcall(function() fireproximityprompt(child.ProximityPrompt, math.huge) end)
						end
					end
					task.wait(0.3)
				end
			end)
		end
	end
end)
BerryH = GRP_Main_Collect_Berry:AddToggle("Auto_Farm_Berry_+_Hop", {
	Text = "Auto Farm Berry + Hop",
	Default = false,
	Callback = function(p79)
		_G.AutoBerryH = p79
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.AutoBerryH then
				local CollectionService = game:GetService("CollectionService")
				local LocalPlayer = game:GetService("Players").LocalPlayer
				local tagged = CollectionService:GetTagged("BerryBush")

				if #tagged == 0 then
					local TeleportService_ = game:GetService("TeleportService")
					local t19 = {}
					local ok = pcall(function()
						t19 = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
					end)

					if ok then
						if t19.data then
							for _, v1 in pairs(t19.data) do
								if v1.playing < v1.maxPlayers and v1.id ~= game.JobId then
									TeleportService_:TeleportToPlaceInstance(game.PlaceId, v1.id, LocalPlayer)

									break
								end
							end
						end
					end
				else
					for i = 1, #tagged do
						local v403 = tagged[i]

						for _, v1 in pairs(v403:GetAttributes()) do
							if not BerryArray or table.find(BerryArray, v1) then
								_tp(v403.Parent:GetPivot())

								for i2 = 1, #tagged do
									for _, child in pairs(tagged[i2]:GetChildren()) do
										if not BerryArray or table.find(BerryArray, child.Name) then
											_tp(child.WorldPivot)
											fireproximityprompt(child.ProximityPrompt, math.huge)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

GRP_Main_Farm_Mob = t15.Main:AddLeftGroupbox("Farm Mob")

do
	if World1 then
		GRP_Main_Farm_Mob:AddDropdown("Select_Mob", {
			Text = "Select Mob",
			Values = {
				"Bandit",
				"Monkey",
				"Gorilla",
				"Pirate",
				"Brute",
				"Desert Bandit",
				"Desert Officer",
				"Snow Bandit",
				"Snowman",
				"Chief Petty Officer",
				"Sky Bandit",
				"Dark Master",
				"Toga Warrior",
				"Gladiator",
				"Military Soldier",
				"Military Spy",
				"Fishman Warrior",
				"Fishman Commando",
				"God's Guard",
				"Shanda",
				"Royal Squad",
				"Royal Soldier",
				"Galley Pirate",
				"Galley Captain"
			},
			Default = 1,
			Callback = function(p80)
				getgenv().SelectMob = p80
			end
		})
	end
end

if World2 then
	GRP_Main_Farm_Mob:AddDropdown("Select_Mob", {
		Text = "Select Mob",
		Values = {
			"Raider",
			"Mercenary",
			"Swan Pirate",
			"Factory Staff",
			"Marine Lieutenant",
			"Marine Captain",
			"Zombie",
			"Vampire",
			"Snow Trooper",
			"Winter Warrior",
			"Lab Subordinate",
			"Horned Warrior",
			"Magma Ninja",
			"Lava Pirate",
			"Ship Deckhand",
			"Ship Engineer",
			"Ship Steward",
			"Ship Officer",
			"Arctic Warrior",
			"Snow Lurker",
			"Sea Soldier",
			"Water Fighter"
		},
		Default = 1,
		Callback = function(p81)
			getgenv().SelectMob = p81
		end
	})
end

do
	if World3 then
		GRP_Main_Farm_Mob:AddDropdown("Select_Mob", {
			Text = "Select Mob",
			Values = {
				"Pirate Millionaire",
				"Dragon Crew Warrior",
				"Dragon Crew Archer",
				"Female Islander",
				"Giant Islander",
				"Marine Commodore",
				"Marine Rear Admiral",
				"Fishman Raider",
				"Fishman Captain",
				"Forest Pirate",
				"Mythological Pirate",
				"Jungle Pirate",
				"Musketeer Pirate",
				"Reborn Skeleton",
				"Living Zombie",
				"Demonic Soul",
				"Posessed Mummy",
				"Peanut Scout",
				"Peanut President",
				"Ice Cream Chef",
				"Ice Cream Commander",
				"Cookie Crafter",
				"Cake Guard",
				"Baking Staff",
				"Head Baker",
				"Cocoa Warrior",
				"Chocolate Bar Battler",
				"Sweet Thief",
				"Candy Rebel",
				"Candy Pirate",
				"Snow Demon",
				"Isle Outlaw",
				"Island Boy",
				"Sun-kissed Warrior",
				"Isle Champion"
			},
			Default = 1,
			Callback = function(p82)
				getgenv().SelectMob = p82
			end
		})
	end
end

GRP_Main_Farm_Mob:AddToggle("Auto_Kill_Mob", {
	Text = "Auto Kill Mob",
	Default = false,
	Callback = function(p83)
		_G.AutoKillMob = p83
	end
})

do
	spawn(function()
		while wait() do
			if _G.AutoKillMob then
				pcall(function()
					if game:GetService("Workspace").Enemies:FindFirstChild(getgenv().SelectMob) then
						for _, child in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if child.Name == getgenv().SelectMob and child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") and child.Humanoid.Health > 0 then
								while true do
									game:GetService("RunService").Heartbeat:Wait()
									t9.Kill(child, _G.AutoKillMob)

									if _G.AutoKillMob then
										if not child.Parent or child.Humanoid.Health <= 0 then
											break
										end
									else
										break
									end
								end
							end
						end
					end
				end)
			end
		end
	end)
end

GRP_Main_Farm_All_Island = t15.Main:AddLeftGroupbox("Farm All Island")

do
	local t20 = {
		Pirates = {
			CFrame = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929),
			Mobs = { "Bandit" }
		},
		Marine = {
			CFrame = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929),
			Mobs = { "Trainee" }
		},
		Jungle = {
			CFrame = CFrame.new(-1600, 36, 150),
			Mobs = {
				"Monkey",
				"Gorilla"
			}
		},
		["Pirate Village"] = {
			CFrame = CFrame.new(-1100, 4, 3850),
			Mobs = {
				"Pirate",
				"Brute"
			}
		},
		Desert = {
			CFrame = CFrame.new(1090, 7, 4370),
			Mobs = {
				"Desert Bandit",
				"Desert Officer"
			}
		},
		["Frozen Village"] = {
			CFrame = CFrame.new(1200, 28, -1500),
			Mobs = {
				"Snow Bandit",
				"Snowman"
			}
		},
		["Marine Fortress"] = {
			CFrame = CFrame.new(-4500, 20, 4250),
			Mobs = { "Chief Petty Officer" }
		},
		["Skylands Lower"] = {
			CFrame = CFrame.new(-5000, 700, -2500),
			Mobs = {
				"Sky Bandit",
				"Dark Master"
			}
		},
		Prison = {
			CFrame = CFrame.new(4875, 6, 735),
			Mobs = {
				"Prisoner",
				"Dangerous Prisoner"
			}
		},
		Colosseum = {
			CFrame = CFrame.new(-1500, 60, -290),
			Mobs = {
				"Toga Warrior",
				"Gladiator"
			}
		},
		["Magma Village"] = {
			CFrame = CFrame.new(-5200, 8, 8400),
			Mobs = {
				"Military Soldier",
				"Military Spy"
			}
		},
		["Underwater City"] = {
			CFrame = CFrame.new(61160, 5, 1819),
			Mobs = {
				"Fishman Warrior",
				"Fishman Commando"
			}
		},
		["Skylands Upper"] = {
			CFrame = CFrame.new(-7880, 5545, -380),
			Mobs = {
				"Shanda",
				"Royal Squad",
				"Royal Soldier"
			}
		}
	}
	local t21 = {
		["Kingdom of Rose"] = {
			CFrame = CFrame.new(-321, 73, 297),
			Mobs = {
				"Raider",
				"Mercenary",
				"Swan Pirate",
				"Factory Staff"
			}
		},
		["Green Zone"] = {
			CFrame = CFrame.new(-2447, 73, -3211),
			Mobs = {
				"Marine Lieutenant",
				"Marine Captain"
			}
		},
		["Graveyard Island"] = {
			CFrame = CFrame.new(-9515, 142, 5536),
			Mobs = {
				"Zombie",
				"Vampire"
			}
		},
		["Snow Mountain"] = {
			CFrame = CFrame.new(561, 401, -5306),
			Mobs = {
				"Snow Trooper",
				"Winter Warrior"
			}
		},
		["Hot and Cold (Cold)"] = {
			CFrame = CFrame.new(-6026, 15, -5062),
			Mobs = {
				"Lab Subordinate",
				"Horned Warrior"
			}
		},
		["Hot and Cold (Hot)"] = {
			CFrame = CFrame.new(-5478, 15, -5240),
			Mobs = {
				"Magma Ninja",
				"Lava Pirate"
			}
		},
		["Cursed Ship"] = {
			CFrame = CFrame.new(902, 126, 33071),
			Mobs = {
				"Ship Deckhand",
				"Ship Engineer",
				"Ship Steward",
				"Ship Officer"
			}
		},
		["Ice Castle"] = {
			CFrame = CFrame.new(6137, 294, -6747),
			Mobs = {
				"Arctic Warrior",
				"Snow Lurker"
			}
		},
		["Forgotten Island"] = {
			CFrame = CFrame.new(-3043, 238, -10191),
			Mobs = {
				"Sea Soldier",
				"Water Fighter"
			}
		}
	}
	local t22 = {
		["Port Town"] = {
			CFrame = CFrame.new(-290, 44, 5450),
			Mobs = {
				"Pirate Millionaire",
				"Pistol Billionaire"
			}
		},
		["Hydra Island"] = {
			CFrame = CFrame.new(5228, 604, 345),
			Mobs = {
				"Dragon Crew Warrior",
				"Dragon Crew Archer",
				"Female Islander",
				"Giant Islander",
				"Training Dummy"
			}
		},
		["Great Tree"] = {
			CFrame = CFrame.new(2682, 1682, -7190),
			Mobs = {
				"Marine Commodore",
				"Marine Rear Admiral"
			}
		},
		["Floating Turtle"] = {
			CFrame = CFrame.new(-12000, 331, -8500),
			Mobs = {
				"Forest Pirate",
				"Mythological Pirate",
				"Jungle Pirate",
				"Musketeer Pirate",
				"Fishman Raider",
				"Fishman Captain"
			}
		},
		["Haunted Castle"] = {
			CFrame = CFrame.new(-9515, 142, 5536),
			Mobs = {
				"Reborn Skeleton",
				"Living Zombie",
				"Demonic Soul",
				"Posessed Mummy"
			}
		},
		["Sea of Treats"] = {
			CFrame = CFrame.new(-1145, 13, -14450),
			Mobs = {
				"Peanut Scout",
				"Peanut President",
				"Ice Cream Commander",
				"Cookie Crafter",
				"Cake Guard",
				"Baking Staff",
				"Head Baker",
				"Cocoa Warrior",
				"Chocolate Bar Battler",
				"Sweet Thief",
				"Candy Rebel"
			}
		},
		["Tiki Outpost"] = {
			CFrame = CFrame.new(-16200, 90, -17300),
			Mobs = {
				"Isle Outlaw",
				"Island Boy",
				"Sun-kissed Warrior",
				"Isle Champion"
			}
		},
		["Submerged Island"] = {
			CFrame = CFrame.new(-3200, -10, -10000),
			Mobs = {
				"Reef Bandit",
				"Coral Pirate",
				"Sea Chanter",
				"Ocean Prophet",
				"High Disciple",
				"Grand Devotee"
			}
		}
	}

	if World1 then
		GRP_Main_Farm_All_Island:AddDropdown("Select_Island", {
			Text = "Select Island",
			Values = {
				"Pirates",
				"Marine",
				"Jungle",
				"Pirate Village",
				"Desert",
				"Frozen Village",
				"Marine Fortress",
				"Skylands Lower",
				"Prison",
				"Colosseum",
				"Magma Village",
				"Underwater City",
				"Skylands Upper"
			},
			Default = 1,
			Callback = function(p84)
				_G.SelectIsland = p84
			end
		})
	end

	if World2 then
		GRP_Main_Farm_All_Island:AddDropdown("Select_Island", {
			Text = "Select Island",
			Values = {
				"Kingdom of Rose",
				"Green Zone",
				"Graveyard Island",
				"Snow Mountain",
				"Hot and Cold (Cold)",
				"Hot and Cold (Hot)",
				"Cursed Ship",
				"Ice Castle",
				"Forgotten Island"
			},
			Default = 1,
			Callback = function(p85)
				_G.SelectIsland = p85
			end
		})
	end

	if World3 then
		GRP_Main_Farm_All_Island:AddDropdown("Select_Island", {
			Text = "Select Island",
			Values = {
				"Port Town",
				"Hydra Island",
				"Great Tree",
				"Floating Turtle",
				"Haunted Castle",
				"Sea of Treats",
				"Tiki Outpost",
				"Submerged Island"
			},
			Default = 1,
			Callback = function(p86)
				_G.SelectIsland = p86
			end
		})
	end

	local v414

	if World1 then
		v414 = t20
	elseif World2 then
		v414 = t21
	elseif World3 then
		v414 = t22
	end

	GRP_Main_Farm_All_Island:AddToggle("Auto_Farm_All_Island", {
		Text = "Auto Farm All Island",
		Default = false,
		Callback = function(p87)
			_G.AutoFarmIsland = p87
		end
	})
	task.spawn(function()
		while task.wait(0.2) do
			if _G.AutoFarmIsland and _G.SelectIsland and v414 then
				local v415 = v414[_G.SelectIsland]

				if v415 then
					local CFrame_ = v415.CFrame
					local t23 = {}

					for _, mob in ipairs(v415.Mobs) do
						t23[mob] = true
					end

					local v420 = false

					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if t23[child.Name] then
							if child:FindFirstChild("Humanoid") then
								if child:FindFirstChild("HumanoidRootPart") and child.Humanoid.Health > 0 then
									v420 = true

									while true do
										task.wait()
										_tp(child.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
										t9.Kill(child, true)

										if not _G.AutoFarmIsland then
											break
										end

										if child.Parent then
											if not (child.Humanoid.Health <= 0) then
												continue
											end
										end

										break
									end
								end
							end
						end
					end

					if not v420 then
						_tp(CFrame_)
					end
				end
			end
		end
	end)
end

GRP_Main_Farm_Elite_Hunter = t15.Main:AddLeftGroupbox("Farm Elite Hunter")

do
	local v423 = GRP_Main_Farm_Elite_Hunter:AddLabel("Elite Progress : 0")

	spawn(function()
		while wait(Sec) do
			pcall(function()
				v423:SetText("Tiến độ Elite : " .. replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress"))
			end)
		end
	end)
end

do
	local v424 = GRP_Main_Farm_Elite_Hunter:AddLabel("Status: Not Found")

	spawn(function()
		local s12 = ""

		while wait(1) do
			local v426 = (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) and "✅" or "❌"
			local response = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress")

			if v426 ~= s12 then
				v424:SetText("Trạng thái: " .. v426 .. " | Killed: " .. tostring(response or 0))
				s12 = v426
			end
		end
	end)
end

do
	EliteQ = GRP_Main_Farm_Elite_Hunter:AddToggle("Auto_Farm_Elite", {
		Text = "Auto Farm Elite",
		Default = false,
		Callback = function(p88)
			_G.FarmEliteHunt = p88
		end
	})
end

do
	spawn(function()
		while wait(1) do
			pcall(function()
				if _G.FarmEliteHunt then
					local Quest = plr.PlayerGui.Main.Quest
					local Text = Quest.Container.QuestTitle.Title.Text

					if Quest.Visible then
						local v430
						local v431, v432, v433 = pairs({
							"Diablo",
							"Urban",
							"Deandre"
						})
						local v434 = geniter(v431, v432, v433)

						while true do
							local v435 = table.pack(v434())

							if not v435[1] then
								break
							end

							local v436 = v435[3]

							if string.find(Text, v436) then
								v430 = v436

								break
							end
						end

						if v430 then
							local v437
							local v438, v439, v440 = pairs(replicated:GetChildren())
							local v441 = geniter(v438, v439, v440)

							while true do
								local v442 = table.pack(v441())

								if not v442[1] then
									break
								end

								local v443 = v442[3]

								if v443.Name == v430 and v443:FindFirstChild("HumanoidRootPart") then
									v437 = v443

									break
								end
							end

							local v444, v445, v446 = pairs(Enemies:GetChildren())

							for _, v1 in v444, v445, v446 do
								if v1.Name == v430 and t9.Alive(v1) then
									v437 = v1

									break
								end
							end

							if v437 and v437:FindFirstChild("HumanoidRootPart") then
								_tp(v437.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

								while true do
									wait()
									t9.Kill(v437, _G.FarmEliteHunt)

									if _G.FarmEliteHunt then
										if not v437.Parent or v437.Humanoid.Health <= 0 or not Quest.Visible then
											break
										end
									else
										break
									end
								end
							else
								wait(5)
							end
						else
							replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
						end
					else
						local response = replicated.Remotes.CommF_:InvokeServer("EliteHunter")

						if response == nil or string.find(response, "Cooldown") then
							wait(10)

							return
						end

						task.wait(1)
					end
				end
			end)
		end
	end)
end

do
	EliteH = GRP_Main_Farm_Elite_Hunter:AddToggle("Auto_Farm_Elite_+_Hop", {
		Text = "Auto Farm Elite + Hop",
		Default = false,
		Callback = function(p89)
			_G.FarmEliteH = p89
		end
	})
end

do
	local function v450()
		local HttpService = game:GetService("HttpService")
		local TeleportService_ = game:GetService("TeleportService")
		local s13 = ""
		local v454 = false

		repeat
			local ok, result = pcall(function()
				return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. s13)
			end)

			if ok and result then
				local data = HttpService:JSONDecode(result)

				if data.data then
					for _, v1 in pairs(data.data) do
						if v1.playing < v1.maxPlayers and v1.id ~= game.JobId then
							v454 = true
							TeleportService_:TeleportToPlaceInstance(game.PlaceId, v1.id)

							break
						end
					end

					s13 = data.nextPageCursor or ""
				end
			end
		until not s13 or v454
	end

	spawn(function()
		if task.wait(1) then
			repeat
				pcall(function()
					if _G.FarmEliteH then
						local Quest = plr.PlayerGui.Main.Quest
						local Text = Quest.Container.QuestTitle.Title.Text

						if Quest.Visible then
							local v462
							local v463, v464, v465 = pairs({
								"Diablo",
								"Urban",
								"Deandre"
							})
							local v466 = geniter(v463, v464, v465)

							while true do
								local v467 = table.pack(v466())

								if not v467[1] then
									break
								end

								local v468 = v467[3]

								if string.find(Text, v468) then
									v462 = v468

									break
								end
							end

							if v462 then
								local v469
								local v470, v471, v472 = pairs(replicated:GetChildren())
								local v473 = geniter(v470, v471, v472)

								while true do
									local v474 = table.pack(v473())

									if not v474[1] then
										break
									end

									local v475 = v474[3]

									if v475.Name == v462 and v475:FindFirstChild("HumanoidRootPart") then
										v469 = v475

										break
									end
								end

								local v476, v477, v478 = pairs(workspace.Enemies:GetChildren())

								for _, v1 in v476, v477, v478 do
									if v1.Name == v462 and t9.Alive(v1) then
										v469 = v1

										break
									end
								end

								if v469 and v469:FindFirstChild("HumanoidRootPart") then
									_tp(v469.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

									while true do
										wait()
										t9.Kill(v469, _G.FarmEliteH)

										if _G.FarmEliteH then
											if not v469.Parent or v469.Humanoid.Health <= 0 or not Quest.Visible then
												break
											end
										else
											break
										end
									end
								else
									task.wait(5)
									v450()
								end
							else
								replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
								task.wait(1)
								v450()
							end
						else
							local response = replicated.Remotes.CommF_:InvokeServer("EliteHunter")

							if response == nil or string.find(response, "Cooldown") then
								v450()

								return
							end

							task.wait(1)
						end
					end
				end)
			until not task.wait(1)
		end
	end)
end

GRP_Main_Farm_Rip_Indra = t15.Main:AddLeftGroupbox("Farm Rip Indra")
GRP_Main_Farm_Rip_Indra:AddToggle("Auto_Attack_Rip_Indra", {
	Text = "Auto Attack Rip Indra",
	Default = false,
	Callback = function(p90)
		_G.AutoRipIngay = p90
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.AutoRipIngay then
					local ripIndra = GetConnectionEnemies("rip_indra")

					if GetWP("Dark Dagger") and (GetIn("Valkyrie") or not ripIndra) then
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, 0.914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
						wait(0.1)
						_tp(CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781))
					else
						while true do
							wait()
							t9.Kill(ripIndra, _G.AutoRipIngay)

							if _G.AutoRipIngay then
								if not ripIndra.Parent or ripIndra.Humanoid.Health <= 0 then
									break
								end
							else
								break
							end
						end
					end
				end
			end)
		end
	end)
end

GRP_Main_Farm_Rip_Indra:AddToggle("Auto_Unlocked_Haki", {
	Text = "Auto Unlocked Haki",
	Default = false,
	Callback = function(p91)
		_G.AutoUnHaki = p91
	end
})

do
	AuraSkin = function(p92)
		replicated:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/FruitCustomizerRF"):InvokeServer(unpack({ {
			StorageName = p92,
			Type = "AuraSkin",
			Context = "Equip"
		} }))
	end
end

VaildColor = function(p93)
	if p93 and p93.BrickColor then
		return tostring(p93.BrickColor) == "Lime green"
	end
end
HakiCalculate = function(p94)
	local t24 = {
		["Really red"] = "Pure Red",
		Oyster = "Snow White",
		["Hot pink"] = "Winter Sky"
	}

	if p94 and p94.BrickColor then
		return t24[tostring(p94.BrickColor)]
	end
end
spawn(function()
	while wait(Sec) do
		if _G.AutoUnHaki then
			pcall(function()
				local Summoner = workspace.Map["Boat Castle"]:FindFirstChild("Summoner")

				if Summoner and Summoner:FindFirstChild("Circle") then
					local v485, v486, v487 = pairs(Summoner:FindFirstChild("Circle"):GetChildren())
					local v488 = geniter(v485, v486, v487)
					local exitTo
					local v490, Part2

					while true do
						local v492 = table.pack(v488())

						if not v492[1] then
							break
						end

						v490 = v492[3]

						if v490.Name == "Part" then
							Part2 = v490:FindFirstChild("Part")

							if VaildColor(Part2) == false then
								exitTo = 1

								break
							end
						end
					end

					if exitTo == 1 then
						local exitTo2

						repeat
							AuraSkin(HakiCalculate(v490))

							while true do
								wait()
								_tp(v490.CFrame)

								if VaildColor(Part2) == true then
									break
								elseif not _G.AutoUnHaki then
									break
								end
							end

							exitTo2 = nil

							while true do
								local v494 = table.pack(v488())

								if not v494[1] then
									break
								end

								v490 = v494[3]

								if v490.Name == "Part" then
									Part2 = v490:FindFirstChild("Part")

									if VaildColor(Part2) == false then
										exitTo2 = 1

										break
									end
								end
							end
						until exitTo2 ~= 1
					end
				end
			end)
		end
	end
end)
GRP_Main_Farming_Cake = t15.Main:AddLeftGroupbox("Farming Cake")

do
	local v495 = GRP_Main_Farming_Cake:AddLabel("")

	spawn(function()
		while wait(0.2) do
			pcall(function()
				local v496 = string.match(replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner"), "%d+")

				if v496 then
					v495:SetText("Đã giết : " .. (500 - tonumber(v496) or 0))
				end
			end)
		end
	end)
end

Cake = GRP_Main_Farming_Cake:AddToggle("Auto_Farm_Cake_Prince", {
	Text = "Auto Farm Cake Prince",
	Default = false,
	Callback = function(p95)
		_G.Auto_Cake_Prince = p95
	end
})

do
	spawn(function()
		while task.wait() do
			if _G.Auto_Cake_Prince and not _G.AutoRaidCastle then
				local exitTo

				repeat
					pcall(function()
						local LocalPlayer = game.Players.LocalPlayer
						local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
						local CakeLoaf = workspace.Map:FindFirstChild("CakeLoaf")
						local BigMirror = CakeLoaf and CakeLoaf:FindFirstChild("BigMirror")

						if not HumanoidRootPart then
							return
						end

						if _G.AcceptQuestC and not _G.CheckQuestVisible(LocalPlayer) then
							local cFrame = CFrame.new(-1927.92, 37.8, -12842.54)

							_tp(cFrame)

							while (cFrame.Position - HumanoidRootPart.Position).Magnitude > 50 do
								task.wait(0.2)
							end

							local v503 = math.random(1, 4)
							local t25 = {
								{
									"StartQuest",
									"CakeQuest2",
									2
								},
								{
									"StartQuest",
									"CakeQuest2",
									1
								},
								{
									"StartQuest",
									"CakeQuest1",
									1
								},
								{
									"StartQuest",
									"CakeQuest1",
									2
								}
							}

							pcall(function()
								game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(t25[v503]))
							end)
						end

						if not CakeLoaf then
							_tp(CFrame.new(-2077, 252, -12373))
							task.wait(2)

							return
						end

						if BigMirror and (BigMirror.Other.Transparency == 0 or workspace.Enemies:FindFirstChild("Cake Prince")) then
							local v505 = GetConnectionEnemies("Cake Prince")

							if v505 then
								while true do
									task.wait()
									t9.Kill2(v505, _G.Auto_Cake_Prince)

									if _G.Auto_Cake_Prince then
										if not v505.Parent or v505.Humanoid.Health <= 0 then
											break
										end
									else
										break
									end
								end
							else
								_tp(CFrame.new(-2151.82, 149.32, -12404.91))
							end
						else
							local v506 = GetConnectionEnemies({
								"Cookie Crafter",
								"Cake Guard",
								"Baking Staff",
								"Head Baker"
							})

							if v506 then
								while true do
									task.wait()
									t9.Kill(v506, _G.Auto_Cake_Prince)

									if _G.Auto_Cake_Prince then
										if not v506.Parent or v506.Humanoid.Health <= 0 or BigMirror and BigMirror.Other.Transparency == 0 then
											break
										end
									else
										break
									end
								end
							else
								_tp(CFrame.new(-2077, 252, -12373))
							end
						end
					end)
					exitTo = nil

					while task.wait() do
						if _G.Auto_Cake_Prince and not _G.AutoRaidCastle then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

do
	CakeQ = GRP_Main_Farming_Cake:AddToggle("Accept_Quests", {
		Text = "Accept Quests",
		Default = false,
		Callback = function(p96)
			_G.AcceptQuestC = p96
		end
	})
end

do
	CakeSM = GRP_Main_Farming_Cake:AddToggle("Auto_Summon_Cake_Prince", {
		Text = "Auto Summon Cake Prince",
		Default = false,
		Callback = function(p97)
			_G.AutoSpawnCP = p97
		end
	})
end

spawn(function()
	while task.wait(2) do
		if _G.AutoSpawnCP then
			pcall(function()
				local CommF_ = game.ReplicatedStorage.Remotes.CommF_
				local BigMirror = workspace.Map.CakeLoaf:FindFirstChild("BigMirror")

				if not BigMirror then
					return
				end

				if workspace.Enemies:FindFirstChild("Cake Prince") then
					return
				end

				if BigMirror.Other.Transparency == 0 then
					return
				end

				CommF_:InvokeServer("CakePrinceSpawner", true)
			end)
		end
	end
end)
GRP_Main_Farming_Cake:AddToggle("Auto_Dough_King_[Fully]", {
	Text = "Auto Dough King [Fully]",
	Default = false,
	Callback = function(p98)
		_G.AutoDoughKing = p98
	end
})

do
	spawn(function()
		while wait() do
			if _G.AutoDoughKing then
				local exitTo

				repeat
					pcall(function()
						if workspace.Map.CakeLoaf:FindFirstChild("RedDoor") then
							if workspace.Map.CakeLoaf:FindFirstChild("RedDoor") then
								if GetBP("Red Key") then
									while true do
										task.wait()
										_tp(CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782))

										if getgenv().AutoDoughKing then
											if (plr.Character.HumanoidRootPart.CFrame - CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782)).Magnitude <= 5 then
												break
											end
										else
											break
										end
									end

									EquipWeapon("Red Key")
								end
							elseif GetConnectionEnemies("Dough King") then
								local v510 = GetConnectionEnemies("Dough King")

								if v510 then
									while true do
										task.wait()
										t9.Kill(v510, _G.AutoDoughKing)

										if _G.AutoDoughKing then
											if not v510.Parent or v510.Humanoid.Health <= 0 then
												break
											end
										else
											break
										end
									end
								else
									_tp(CFrame.new(-1943.676513671875, 251.50956726074219, -12337.880859375))
								end
							end
						elseif GetBP("Red Key") then
							replicated.Remotes.CommF_:InvokeServer("CakeScientist", "Check")
							replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Check")
						end

						if GetBP("Sweet Chalice") then
							replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
							_G.AutoAttackDoughKing = true
						else
							_G.AutoAttackDoughKing = false
						end

						if GetBP("God's Chalice") and GetM("Conjured Cocoa") >= 10 then
							replicated.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
						end

						local ok = not plr.Backpack:FindFirstChild("God's Chalice")

						if not ok then
							ok = not not plr.Character:FindFirstChild("God's Chalice")
						end

						if ok then
							_G.FarmEliteHunt = true
						else
							_G.FarmEliteHunt = false
						end

						if GetM("Conjured Cocoa") <= 10 then
							local v512 = GetConnectionEnemies({
								"Cocoa Warrior",
								"Chocolate Bar Battler"
							})

							if v512 then
								while true do
									task.wait()
									t9.Kill(v512, _G.AutoDoughKing)

									if _G.AutoDoughKing == false then
										break
									elseif not v512.Parent or v512.Humanoid.Health <= 0 then
										break
									end
								end
							else
								_tp(CFrame.new(402.71890258789062, 81.060501098632812, -12259.54296875))
							end
						end
					end)
					exitTo = nil

					while wait() do
						if _G.AutoDoughKing then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

GRP_Main_Farming_Cake:AddToggle("Auto_Farm_Dough_King", {
	Text = "Auto Farm Dough King",
	Default = false,
	Callback = function(p99)
		_G.AutoAttackDoughKing = p99
	end
})
spawn(function()
	while wait() do
		if _G.AutoAttackDoughKing then
			local exitTo

			repeat
				pcall(function()
					local v514 = GetConnectionEnemies("Dough King")

					if v514 then
						while true do
							task.wait()
							t9.Kill(v514, _G.AutoAttackDoughKing)

							if _G.AutoAttackDoughKing then
								if not v514.Parent or v514.Humanoid.Health <= 0 then
									break
								end
							else
								break
							end
						end
					else
						_tp(CFrame.new(-1943.6765, 251.5095, -12337.8809))
					end
				end)
				exitTo = nil

				while wait() do
					if _G.AutoAttackDoughKing then
						exitTo = 1

						break
					end
				end
			until exitTo ~= 1

			return
		end
	end
end)

do
	GRP_Main_Farming_Cake:AddToggle("Auto_Farm_Dough_King_+_Hop", {
		Text = "Auto Farm Dough King + Hop",
		Default = false,
		Callback = function(p100)
			_G.AutoHop_Dough = p100
		end
	})
end

do
	local function v515()
		pcall(function()
			local HttpService = game:GetService("HttpService")
			local t26 = {}
			local response = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")

			for _, v1 in pairs(HttpService:JSONDecode(response).data) do
				if v1.playing < v1.maxPlayers then
					table.insert(t26, v1.id)
				end
			end

			if #t26 > 0 then
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, t26[math.random(1, #t26)], game.Players.LocalPlayer)
			end
		end)
	end

	spawn(function()
		while task.wait() do
			if _G.AutoHop_Dough then
				local exitTo

				repeat
					pcall(function()
						local v522 = GetConnectionEnemies("Dough King")

						if v522 then
							while true do
								task.wait()
								t9.Kill(v522, _G.AutoHop_Dough)

								if _G.AutoHop_Dough then
									if not v522.Parent or v522.Humanoid.Health <= 0 then
										break
									end
								else
									break
								end
							end
						else
							_tp(CFrame.new(-1943.6765, 251.5095, -12337.8809))
							task.wait(2)

							if not GetConnectionEnemies("Dough King") and _G.AutoHop_Dough then
								v515()
							end
						end
					end)
					exitTo = nil

					while task.wait() do
						if _G.AutoHop_Dough then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

GRP_Main_Farming_Bone = t15.Main:AddLeftGroupbox("Farming Bone")

do
	local v523 = GRP_Main_Farming_Bone:AddLabel("")

	spawn(function()
		while wait(1) do
			local response = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check") or 0

			v523:SetText("Bạn có: " .. tostring(response) .. " Bones")
			v277:SetText("Bạn có: " .. tostring(response) .. " Bones")
		end
	end)
end

do
	GRP_Main_Farming_Bone:AddToggle("Auto_Farm_Bone", {
		Text = "Auto Farm Bone",
		Default = false,
		Callback = function(p101)
			_G.AutoFarm_Bone = p101
		end
	})
end

do
	spawn(function()
		local LocalPlayer = game.Players.LocalPlayer
		local t27 = {
			"Reborn Skeleton",
			"Living Zombie",
			"Demonic Soul",
			"Possessed Mummy"
		}

		while wait(0.5) do
			if _G.AutoFarm_Bone then
				local exitTo

				repeat
					pcall(function()
						local Character = LocalPlayer.Character
						local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

						if not HumanoidRootPart then
							return
						end

						if LocalPlayer.PlayerGui:FindFirstChild("Main") then
							LocalPlayer.PlayerGui.Main:FindFirstChild("Quest")
						end

						local v530 = GetConnectionEnemies(t27)

						if _G.AcceptQuestB then
							if not _G.CheckQuestVisible(LocalPlayer) then
								local cFrame = CFrame.new(-9516.99316, 172.01718, 6078.46533)

								_tp(cFrame)

								while true do
									wait(2)

									if _G.AutoFarm_Bone then
										if (cFrame.Position - HumanoidRootPart.Position).Magnitude <= 50 then
											break
										end
									else
										break
									end
								end

								if not _G.AutoFarm_Bone then
									return
								end

								local t28 = {
									{
										"StartQuest",
										"HauntedQuest2",
										2
									},
									{
										"StartQuest",
										"HauntedQuest2",
										1
									},
									{
										"StartQuest",
										"HauntedQuest1",
										1
									},
									{
										"StartQuest",
										"HauntedQuest1",
										2
									}
								}

								game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(t28[math.random(1, #t28)]))
							end
						end

						if v530 then
							while true do
								wait()
								t9.Kill(v530, true)

								if _G.AutoFarm_Bone then
									if not v530.Parent or v530.Humanoid.Health <= 0 then
										break
									end
								else
									break
								end
							end
						else
							_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
						end
					end)
					exitTo = nil

					while wait(0.5) do
						if _G.AutoFarm_Bone then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

do
	BoneQ = GRP_Main_Farming_Bone:AddToggle("Accept_Quests", {
		Text = "Accept Quests",
		Default = false,
		Callback = function(p102)
			_G.AcceptQuestB = p102
		end
	})
end

GRP_Main_Farming_Bone:AddToggle("Auto_Soul_Reaper", {
	Text = "Auto Soul Reaper",
	Default = false,
	Callback = function(p103)
		_G.AutoHytHallow = p103
	end
})
spawn(function()
	while wait(Sec) do
		if _G.AutoHytHallow then
			pcall(function()
				local v533 = GetConnectionEnemies("Soul Reaper")

				if v533 then
					while true do
						task.wait()
						t9.Kill(v533, _G.AutoHytHallow)

						if v533.Humanoid.Health <= 0 then
							break
						elseif _G.AutoHytHallow == false then
							break
						end
					end
				elseif GetBP("Hallow Essence") then
					while true do
						wait(0.1)
						_tp(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))

						if _G.AutoHytHallow == false then
							break
						elseif plr.Character.HumanoidRootPart.CFrame == CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125) then
							break
						end
					end

					EquipWeapon("Hallow Essence")
				else
					while true do
						task.wait(0.1)
						replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)

						if _G.AutoHytHallow == false then
							break
						elseif GetBP("Hallow Essence") then
							break
						end
					end
				end
			end)
		end
	end
end)
RanBone = GRP_Main_Farming_Bone:AddToggle("Auto_Random_Bones", {
	Text = "Auto Random Bones",
	Default = false,
	Callback = function(p104)
		_G.Auto_Random_Bone = p104
	end
})
spawn(function()
	if wait(Sec) then
		repeat
			pcall(function()
				if _G.Auto_Random_Bone then
					repeat
						task.wait()
						replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
					until not _G.Auto_Random_Bone
				end
			end)
		until not wait(Sec)
	end
end)

do
	Lucky = GRP_Main_Farming_Bone:AddToggle("Auto_Try_Luck_Gravestone", {
		Text = "Auto Try Luck Gravestone",
		Default = false,
		Callback = function(p105)
			_G.TryLucky = p105
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.TryLucky then
				local cFrame = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)

				if plr.Character.HumanoidRootPart.CFrame ~= cFrame then
					_tp(CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813))
				elseif plr.Character.HumanoidRootPart.CFrame == cFrame then
					replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 1)
				end
			end
		end
	end)
end

do
	Pray = GRP_Main_Farming_Bone:AddToggle("Auto_Pray_Gravestone", {
		Text = "Auto Pray Gravestone",
		Default = false,
		Callback = function(p106)
			_G.Praying = p106
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.Praying then
				local cFrame = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)

				if plr.Character.HumanoidRootPart.CFrame ~= cFrame then
					local exitTo

					repeat
						_tp(CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813))
						exitTo = nil

						while wait(Sec) do
							if _G.Praying then
								local cFrame2 = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)

								if plr.Character.HumanoidRootPart.CFrame ~= cFrame2 then
									exitTo = 1

									break
								elseif plr.Character.HumanoidRootPart.CFrame == cFrame2 then
									replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
								end
							end
						end
					until exitTo ~= 1

					return
				elseif plr.Character.HumanoidRootPart.CFrame == cFrame then
					replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
				end
			end
		end
	end)
end

GRP_Main_Tyrant_of_the_Skies = t15.Main:AddLeftGroupbox("Tyrant of the Skies")

do
	local v538 = GRP_Main_Tyrant_of_the_Skies:AddLabel("Tyrant of the Skies: ")

	spawn(function()
		pcall(function()
			while wait(1) do
				if workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
					v538:SetText("Tyrant of the Skies: ✅")
				else
					v538:SetText("Tyrant of the Skies: ❌")
				end
			end
		end)
	end)
end

do
	local v539 = GRP_Main_Tyrant_of_the_Skies:AddLabel("Eyes: 0/4")

	Check_Eye = function()
		local MapFolder = workspace:FindFirstChild("Map")
		local Outpost = MapFolder and MapFolder:FindFirstChild("TikiOutpost")
		local IslandModel = Outpost and Outpost:FindFirstChild("IslandModel")
		local n4 = 0

		if not IslandModel then
			return 0, false
		end

		local Chunks = IslandModel:FindFirstChild("IslandChunks")
		local ChunkE = Chunks and Chunks:FindFirstChild("E")
		local Eyes = {
			IslandModel:FindFirstChild("Eye1"),
			IslandModel:FindFirstChild("Eye2"),
			ChunkE and ChunkE:FindFirstChild("Eye3"),
			ChunkE and ChunkE:FindFirstChild("Eye4")
		}

		for i = 1, 4 do
			local v1 = Eyes[i]

			if v1 and v1.Transparency ~= 1 then
				n4 += 1
			end
		end

		return n4, n4 == 4
	end
	task.spawn(function()
		local v544 = false

		while task.wait(1) do
			local v545, v546 = Check_Eye()

			v539:SetText("Mắt: " .. v545 .. "/4")

			if v546 and not v544 then
				v544 = true
			elseif not v546 then
				v544 = false
			end
		end
	end)
end

do
	FarmTyrant = GRP_Main_Tyrant_of_the_Skies:AddToggle("Auto_Farm_Boss_TOTS", {
		Text = "Auto Farm Boss TOTS",
		Default = false,
		Callback = function(p107)
			_G.FarmTyrant = p107
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.FarmTyrant then
				pcall(function()
					if not plr.Character then
						return
					end

					local HumanoidRootPart = plr.Character:FindFirstChild("HumanoidRootPart")

					if not HumanoidRootPart then
						return
					end

					local vector3 = Vector3.new(-16268.287, 152.616, 1390.773)

					if (HumanoidRootPart.Position - vector3).Magnitude > 5 then
						_tp(CFrame.new(vector3))

						while true do
							wait()

							if _G.FarmTyrant then
								if plr.Character then
									if not plr.Character:FindFirstChild("HumanoidRootPart") or not ((plr.Character.HumanoidRootPart.Position - vector3).Magnitude <= 5) then
										continue
									end
								else
									continue
								end

								break
							end

							break
						end
					end

					local TyrantOfTheSkies = workspace.Enemies:FindFirstChild("Tyrant of the Skies")

					if TyrantOfTheSkies and TyrantOfTheSkies:FindFirstChild("Humanoid") and TyrantOfTheSkies.Humanoid.Health > 0 then
						while _G.FarmTyrant do
							if t9 and t9.Kill then
								t9.Kill(TyrantOfTheSkies, _G.FarmTyrant)
							end

							wait()

							if not _G.FarmTyrant or not TyrantOfTheSkies.Parent or TyrantOfTheSkies.Humanoid.Health <= 0 then
								break
							end
						end

						return
					end

					for _, v1 in ipairs({
						"Serpent Hunter",
						"Skull Slayer",
						"Isle Champion",
						"Sun-kissed Warrior"
					}) do
						if not _G.FarmTyrant then
							break
						end

						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if not _G.FarmTyrant then
								break
							end

							if child and child.Name == v1 and child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 then
								if (HumanoidRootPart.Position - child.HumanoidRootPart.Position).Magnitude > 5000 then
									_tp(child.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

									local now = tick()

									repeat
										wait()
										HumanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
									until not _G.FarmTyrant or not HumanoidRootPart or (HumanoidRootPart.Position - child.HumanoidRootPart.Position).Magnitude <= 6 or tick() - now > 8
								end

								while _G.FarmTyrant do
									if t9 and t9.Kill then
										t9.Kill(child, _G.FarmTyrant)
									end

									wait()

									if not _G.FarmTyrant or not child.Parent or child.Humanoid.Health <= 0 then
										break
									end
								end
							end
						end
					end
				end)
			end
		end
	end)
end

FarmPhaBinh = GRP_Main_Tyrant_of_the_Skies:AddToggle("Auto_Summon_Boss", {
	Text = "Auto Summon Boss",
	Default = false,
	Callback = function(p108)
		_G.FarmPhaBinh = p108
	end
})

do
	local function v555(p109)
		local VirtualInputManager = game:GetService("VirtualInputManager")

		VirtualInputManager:SendKeyEvent(true, p109, true, game)
		wait(0.05)
		VirtualInputManager:SendKeyEvent(false, p109, true, game)
	end
	local function v557(p110)
		if not plr.Character or not plr.Character:FindFirstChild("Humanoid") or not (plr.Character.Humanoid.Health > 0) then
			return
		end

		for _, child in pairs(plr.Backpack:GetChildren()) do
			if child:IsA("Tool") and child.ToolTip == p110 then
				child.Parent = plr.Character
				wait(0.12)

				for _, v1 in ipairs({
					"Z",
					"X",
					"C",
					"V",
					"F"
				}) do
					if not _G.FarmPhaBinh then
						break
					end

					pcall(function()
						v555(v1)
					end)
					wait(0.12)
				end

				child.Parent = plr.Backpack

				return
			end
		end
	end

	local t29 = {
		CFrame.new(-16332.5263671875, 158.07200622558594, 1440.324951171875),
		CFrame.new(-16288.609375, 158.16700744628906, 1470.3680419921875),
		CFrame.new(-16245.412109375, 158.43699645996094, 1463.365966796875),
		CFrame.new(-16212.46875, 158.16700744628906, 1466.343994140625),
		CFrame.new(-16211.9462890625, 158.07200622558594, 1322.39794921875),
		CFrame.new(-16260.921875, 154.92100524902344, 1323.615966796875),
		CFrame.new(-16297.0595703125, 159.322998046875, 1317.2239990234375),
		CFrame.new(-16335.0966796875, 159.33399963378906, 1324.885986328125)
	}

	spawn(function()
		while wait(Sec) do
			if _G.FarmPhaBinh then
				pcall(function()
					if plr and plr.Character then
						if plr.Character:FindFirstChild("HumanoidRootPart") then
							if plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
								for _, v1 in ipairs(t29) do
									if not _G.FarmPhaBinh then
										break
									end

									_tp(v1)

									local v565 = false
									local now = tick()

									while true do
										if tick() - now < 12 and _G.FarmPhaBinh then
											local HumanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

											if not HumanoidRootPart then
												break
											end

											if not ((HumanoidRootPart.Position - v1.Position).Magnitude <= 3) then
												wait(0.1)

												continue
											end

											v565 = true

											break
										end

										break
									end

									if _G.FarmPhaBinh and v565 then
										v557("Melee")
										v557("Sword")
										v557("Gun")
									end
								end

								return
							end
						end
					end
				end)
			end
		end
	end)
end

GRP_Main_Farm_Material = t15.Main:AddLeftGroupbox("Farm Material")

do
	Test = GRP_Main_Farm_Material:AddDropdown("Choose_Material", {
		Text = "Choose Material",
		Values = MaterialList,
		Default = 1,
		Callback = function(p111)
			getgenv().SelectMaterial = p111
		end
	})
end

Toggle = GRP_Main_Farm_Material:AddToggle("Auto_Farm_Materials", {
	Text = "Auto Farm Materials",
	Default = false,
	Callback = function(p112)
		getgenv().AutoMaterial = p112
	end
})
spawn(function()
	local function v568(p113, p114)
		if p113:FindFirstChild("Humanoid") and p113:FindFirstChild("HumanoidRootPart") and p113.Humanoid.Health > 0 then
			if p113.Name == p114 then
				while true do
					wait()
					t9.Kill(p113, getgenv().AutoMaterial)

					if getgenv().AutoMaterial then
						if not p113.Parent or p113.Humanoid.Health <= 0 then
							break
						end
					else
						break
					end
				end
			end
		end
	end
	local function v569()
		for _, child in pairs(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()) do
			for _, v1 in ipairs(MMon) do
				if string.find(child.Name, v1) and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - child.Position).Magnitude >= 10 then
					_tp(child.CFrame * CFrame.new(0, 20, 0))
				end
			end
		end
	end

	while wait() do
		if getgenv().AutoMaterial then
			pcall(function()
				if getgenv().SelectMaterial then
					MaterialMon(getgenv().SelectMaterial)
					_tp(MPos)
				end

				for _, v1 in ipairs(MMon) do
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						v568(child, v1)
					end
				end

				v569()
			end)
		end
	end
end)
GRP_Main_Farm_Boss = t15.Main:AddLeftGroupbox("Farm Boss")
BossDropdown = GRP_Main_Farm_Boss:AddDropdown("Select_Boss", {
	Text = "Select Boss",
	Values = BossList,
	Default = 1,
	Callback = function(p115)
		_G.FindBoss = p115
	end
})
FarmBoss = GRP_Main_Farm_Boss:AddToggle("Auto_Farm_Boss", {
	Text = "Auto Farm Boss",
	Default = false,
	Callback = function(p116)
		_G.FarmBoss = p116
		spawn(function()
			while wait(Sec) do
				if _G.FarmBoss then
					local exitTo

					repeat
						pcall(function()
							local v579 = QuestBeta()[2] ~= nil

							v579 = v579 and QuestBeta()[3] ~= nil

							local Text = plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text

							if _G.AcceptQuestBoss and v579 then
								if not string.find(Text, QuestBeta()[0]) then
									replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
								end

								if plr.PlayerGui.Main.Quest.Visible == false then
									_tp(QuestBeta()[5])

									if (Root.Position - QuestBeta()[5].Position).Magnitude <= 5 then
										replicated.Remotes.CommF_:InvokeServer("StartQuest", QuestBeta()[3], QuestBeta()[2])
									end
								elseif plr.PlayerGui.Main.Quest.Visible == true then
									if workspace.Enemies:FindFirstChild(QuestBeta()[1]) then
										for _, child in pairs(workspace.Enemies:GetChildren()) do
											if t9.Alive(child) and child.Name == QuestBeta()[1] then
												if string.find(Text, QuestBeta()[0]) then
													while true do
														wait()
														t9.Kill(child, _G.FarmBoss)

														if _G.FarmBoss then
															if child.Humanoid.Health <= 0 or not child.Parent or plr.PlayerGui.Main.Quest.Visible == false then
																break
															end
														else
															break
														end
													end
												else
													replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
												end
											end
										end
									else
										_tp(QuestBeta()[4])

										if replicated:FindFirstChild(QuestBeta()[1]) then
											_tp(replicated:FindFirstChild(QuestBeta()[1]).HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
										end
									end
								end
							elseif workspace.Enemies:FindFirstChild(QuestBeta()[1]) then
								for _, child in pairs(workspace.Enemies:GetChildren()) do
									if t9.Alive(child) and child.Name == QuestBeta()[1] then
										while true do
											wait()
											t9.Kill(child, _G.FarmBoss)

											if _G.FarmBoss then
												if child.Humanoid.Health <= 0 or not child.Parent then
													break
												end
											else
												break
											end
										end
									end
								end
							else
								_tp(QuestBeta()[4])

								if replicated:FindFirstChild(QuestBeta()[1]) then
									_tp(replicated:FindFirstChild(QuestBeta()[1]).HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
								end
							end
						end)
						exitTo = nil

						while wait(Sec) do
							if _G.FarmBoss then
								exitTo = 1

								break
							end
						end
					until exitTo ~= 1

					return
				end
			end
		end)
	end
})
BossQ = GRP_Main_Farm_Boss:AddToggle("Accept_Quests", {
	Text = "Accept Quests",
	Default = true,
	Callback = function(p117)
		_G.AcceptQuestBoss = p117
	end
})
FarmAllBoss = GRP_Main_Farm_Boss:AddToggle("Auto_Farm_All_Boss", {
	Text = "Auto Farm All Boss",
	Default = false,
	Callback = function(p118)
		_G.AutoFarmAllBoss = p118
	end
})
task.spawn(function()
	while task.wait(0.3) do
		if _G.AutoFarmAllBoss then
			pcall(function()
				local LocalPlayer = game.Players.LocalPlayer

				if LocalPlayer.Character then
					if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
						local v587
						local huge = math.huge

						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 and table.find(BossList, child.Name) then
								local Magnitude = (HumanoidRootPart.Position - child.HumanoidRootPart.Position).Magnitude

								if Magnitude < huge then
									v587 = child
									huge = Magnitude
								end
							end
						end

						if v587 and v587:FindFirstChild("HumanoidRootPart") then
							local HumanoidRootPart2 = v587.HumanoidRootPart
							local Humanoid = v587.Humanoid

							while true do
								task.wait(0.1)

								if _G.AutoFarmAllBoss then
									local v594 = HumanoidRootPart2.CFrame * CFrame.new(0, 5, 0)

									if (HumanoidRootPart.Position - v594.Position).Magnitude > 100 then
										LocalPlayer.Character:PivotTo(v594)
									else
										_tp(v594)
									end

									if t9 and typeof(t9.Kill) == "function" then
										t9.Kill(v587, true)
									end

									if not v587.Parent or Humanoid.Health <= 0 or not _G.AutoFarmAllBoss then
										break
									end
								else
									break
								end
							end
						end

						return
					end
				end
			end)
		end
	end
end)
_G.MasteryHealthPct = 70
_G.SelectedMasterySkills = {
	Z = true,
	X = true,
	C = true,
	V = true,
	F = true
}

do
	local v595 = t15.Main:AddLeftGroupbox("Farming Mastery")
	local s14 = "Cake"

	v595:AddDropdown("Choose_Island", {
		Text = "Choose Island",
		Values = {
			"Cake",
			"Bone"
		},
		Default = 1,
		Callback = function(p119)
			s14 = p119
		end
	})
	v595:AddSlider({
		Text = "NPC Health % Switch to Weapon",
		Min = 10,
		Max = 95,
		Default = 70,
		Rounding = 1,
		Callback = function(p120)
			_G.MasteryHealthPct = p120
		end
	})
	v595:AddDropdown("Select_Skills", {
		Text = "Select Skills to Use",
		Values = {
			"Z",
			"X",
			"C",
			"V",
			"F",
			"Y"
		},
		Multi = true,
		Default = {
			Z = true,
			X = true,
			C = true,
			V = true,
			F = true
		},
		Callback = function(p121, p122)
			if type(p121) == "table" then
				_G.SelectedMasterySkills = p121
			elseif type(p121) == "string" then
				if type(_G.SelectedMasterySkills) ~= "table" then
					_G.SelectedMasterySkills = {}
				end

				_G.SelectedMasterySkills[p121] = p122 and true or nil
			end
		end
	})
	v595:AddToggle("Auto_Mastery_Fruits", {
		Text = "Auto Mastery Fruits",
		Default = false,
		Callback = function(p123)
			_G.FarmMastery_Dev = p123
		end
	})
	spawn(function()
		RunSer.RenderStepped:Connect(function()
			pcall(function()
				if _G.FarmMastery_Dev or _G.FarmMastery_G or _G.FarmMastery_S then
					for _, child in pairs(plr.PlayerGui.Notifications:GetChildren()) do
						if child.Name == "NotificationTemplate" and string.find(child.Text, "Skill locked!") then
							child:Destroy()
						end
					end
				end
			end)
		end)
	end)
	spawn(function()
		while wait(Sec) do
			if _G.FarmMastery_Dev then
				pcall(function()
					if s14 == "Cake" then
						local v599 = GetConnectionEnemies(t5)

						if v599 then
							while true do
								wait()
								HealthM = v599.Humanoid.MaxHealth * (_G.MasteryHealthPct / 100)
								MousePos = v599.HumanoidRootPart.Position
								t9.Mas(v599, _G.FarmMastery_Dev)

								if _G.FarmMastery_Dev == false then
									break
								elseif v599.Humanoid.Health <= 0 or not v599.Parent then
									break
								end
							end
						else
							_tp(CFrame.new(-1943.676513671875, 251.50956726074219, -12337.880859375))
						end
					else
						if s14 ~= "Bone" then
							return
						end

						local v600 = GetConnectionEnemies(t6)

						if v600 then
							while true do
								wait()
								HealthM = v600.Humanoid.MaxHealth * (_G.MasteryHealthPct / 100)
								MousePos = v600.HumanoidRootPart.Position
								t9.Mas(v600, _G.FarmMastery_Dev)

								if _G.FarmMastery_Dev == false or v600.Humanoid.Health <= 0 then
									break
								elseif not v600.Parent then
									break
								end
							end

							return
						end

						_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
					end
				end)
			end
		end
	end)
	v595:AddToggle("Auto_Mastery_Gun", {
		Text = "Auto Mastery Gun",
		Default = false,
		Callback = function(p124)
			_G.FarmMastery_G = p124
		end
	})
	spawn(function()
		while wait(Sec) do
			if _G.FarmMastery_G then
				pcall(function()
					if s14 == "Cake" then
						local v601 = GetConnectionEnemies(t5)

						if v601 then
							HealthM = v601.Humanoid.MaxHealth * _G.MasteryHealthPct / 100

							repeat
								wait()
								MousePos = v601.HumanoidRootPart.Position
								t9.Masgun(v601, _G.FarmMastery_G)

								local REShootGunEvent = replicated:FindFirstChild("Modules"):FindFirstChild("Net"):FindFirstChild("RE/ShootGunEvent")

								if plr.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then
									return
								end

								local Character, Character2

								if plr.Character:FindFirstChildOfClass("Tool") then
									if plr.Character:FindFirstChildOfClass("Tool").Name == "Skull Guitar" then
										SoulGuitar = true
										plr.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)

										if _G.FarmMastery_G then
											vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
											wait(0.05)
											vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
											wait(0.05)
										end
									else
										Character = plr.Character

										if Character:FindFirstChildOfClass("Tool") then
											Character2 = plr.Character

											if Character2:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
												SoulGuitar = false
												REShootGunEvent:FireServer(MousePos, { v601.HumanoidRootPart })

												if _G.FarmMastery_G then
													vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
													wait(0.05)
													vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
													wait(0.05)
												end
											end
										end
									end
								else
									Character = plr.Character

									if Character:FindFirstChildOfClass("Tool") then
										Character2 = plr.Character

										if Character2:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
											SoulGuitar = false
											REShootGunEvent:FireServer(MousePos, { v601.HumanoidRootPart })

											if _G.FarmMastery_G then
												vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
												wait(0.05)
												vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
												wait(0.05)
											end
										end
									end

									if _G.FarmMastery_G == false or v601.Humanoid.Health <= 0 or not v601.Parent then
										break
									end
								end
							until _G.FarmMastery_G == false or v601.Humanoid.Health <= 0 or not v601.Parent

							SoulGuitar = false
						else
							_tp(CFrame.new(-1943.676513671875, 251.50956726074219, -12337.880859375))
						end
					elseif s14 == "Bone" then
						local v605 = GetConnectionEnemies(t6)

						if v605 then
							HealthM = v605.Humanoid.MaxHealth * _G.MasteryHealthPct / 100

							repeat
								wait()
								MousePos = v605.HumanoidRootPart.Position
								t9.Masgun(v605, _G.FarmMastery_G)

								local REShootGunEvent = replicated:FindFirstChild("Modules"):FindFirstChild("Net"):FindFirstChild("RE/ShootGunEvent")

								if plr.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then
									return
								end

								local Character, Character2

								if plr.Character:FindFirstChildOfClass("Tool") then
									if plr.Character:FindFirstChildOfClass("Tool").Name == "Skull Guitar" then
										SoulGuitar = true
										plr.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)

										if _G.FarmMastery_G then
											vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
											wait(0.05)
											vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
											wait(0.05)
										end
									else
										Character = plr.Character

										if Character:FindFirstChildOfClass("Tool") then
											Character2 = plr.Character

											if Character2:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
												SoulGuitar = false
												REShootGunEvent:FireServer(MousePos, { v605.HumanoidRootPart })

												if _G.FarmMastery_G then
													vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
													wait(0.05)
													vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
													wait(0.05)
												end
											end
										end
									end
								else
									Character = plr.Character

									if Character:FindFirstChildOfClass("Tool") then
										Character2 = plr.Character

										if Character2:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
											SoulGuitar = false
											REShootGunEvent:FireServer(MousePos, { v605.HumanoidRootPart })

											if _G.FarmMastery_G then
												vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
												wait(0.05)
												vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
												wait(0.05)
											end
										end
									end

									if _G.FarmMastery_G == false or v605.Humanoid.Health <= 0 or not v605.Parent then
										break
									end
								end
							until _G.FarmMastery_G == false or v605.Humanoid.Health <= 0 or not v605.Parent

							SoulGuitar = false
						else
							_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
						end
					end
				end)
			end
		end
	end)
	v595:AddToggle("Auto_Mastery_All_Sword", {
		Text = "Auto Mastery All Sword",
		Default = false,
		Callback = function(p125)
			_G.FarmMastery_S = p125
		end
	})
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if not _G.FarmMastery_S then
					return
				end

				if s14 == "Cake" then
					local next_ = next
					local response, v611 = replicated.Remotes.CommF_:InvokeServer("getInventory")
					local exitTo
					local v613

					for _, v1 in next_, response, v611 do
						if type(v1) == "table" and v1.Type == "Sword" then
							v613 = v1
							exitTo = 1

							break
						end
					end

					if exitTo == 1 then
						SwordName = v613.Name

						if tonumber(v613.Mastery) >= 1 or tonumber(v613.Mastery) <= 599 then
							local v616 = GetConnectionEnemies(t5)

							if not GetBP(SwordName) then
								replicated.Remotes.CommF_:InvokeServer("LoadItem", SwordName)

								return
							end

							if v616 then
								while true do
									wait()
									t9.Sword(v616, _G.FarmMastery_S)

									if _G.FarmMastery_S == false then
										break
									elseif not v616.Parent or v616.Humanoid.Health <= 0 then
										break
									end
								end
							else
								_tp(CFrame.new(-1943.676513671875, 251.50956726074219, -12337.880859375))
							end

							return
						elseif tonumber(v613.Mastery) >= 600 then
							if GetBP(SwordName) then
								return nil
							end

							replicated.Remotes.CommF_:InvokeServer("LoadItem", SwordName)
						end
					end
				else
					if s14 ~= "Bone" then
						return
					end

					local next_ = next
					local response, v619 = replicated.Remotes.CommF_:InvokeServer("getInventory")
					local exitTo2
					local v621

					for _, v1 in next_, response, v619 do
						if type(v1) == "table" and v1.Type == "Sword" then
							v621 = v1
							exitTo2 = 1

							break
						end
					end

					if exitTo2 == 1 then
						SwordName = v621.Name

						if tonumber(v621.Mastery) >= 1 or tonumber(v621.Mastery) <= 599 then
							local v624 = GetConnectionEnemies(t6)

							if not GetBP(SwordName) then
								replicated.Remotes.CommF_:InvokeServer("LoadItem", SwordName)

								return
							end

							if v624 then
								while true do
									wait()
									t9.Sword(v624, _G.FarmMastery_S)

									if _G.FarmMastery_S == false then
										break
									elseif not v624.Parent or v624.Humanoid.Health <= 0 then
										break
									end
								end

								return
							end

							_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))

							return
						end

						if tonumber(v621.Mastery) >= 600 then
							if GetBP(SwordName) then
								return nil
							end

							replicated.Remotes.CommF_:InvokeServer("LoadItem", SwordName)
						end
					end
				end
			end)
		end
	end)
end

do
	local MagnetEvent26 = require(game.ReplicatedStorage.EventConfig.MagnetEvent26)

	local function v626()
		local serverTimeNow = workspace:GetServerTimeNow()
		local _Value = MagnetEvent26.START_AT._Value

		return MagnetEvent26.ENABLED and serverTimeNow >= _Value and serverTimeNow < MagnetEvent26.NO_MORE_GAMEPLAY_AT._Value
	end
end

GRP_Main_Update_30_Magnet_Token = t15.Main:AddLeftGroupbox("Update 30 / Magnet Token")

do
	local v629 = GRP_Main_Update_30_Magnet_Token:AddLabel("Loading...")
	local Idle = GRP_Main_Update_30_Magnet_Token:AddLabel("Idle")

	local function v631(p126)
		Idle:SetText(p126)
	end

	task.spawn(function()
		while task.wait(1) do
			pcall(function()
				local now = os.time()
				local v633 = os.date("*t", now)
				local min = v633.min
				local sec = v633.sec
				local v636 = min >= 0 and min < 10
				local v637 = false

				for _, child in pairs(workspace.Enemies:GetChildren()) do
					if child:IsA("Model") and (child:GetAttribute("MagnetEnemy") == true or string.find(string.lower(child.Name), "magnetized")) then
						v637 = true

						break
					end
				end

				local s15 = "🔴"
				local v641

				if v637 then
					local s16 = "🟢"
					local v643 = (10 - min) * 60 - sec

					if v643 < 0 then
						v643 = 0
					end

					v641 = string.format("%s ACTIVE - Time Left: %02d:%02d (✅ Enemies Found)", s16, math.floor(v643 / 60), v643 % 60)
				elseif v636 then
					local s17 = "🟢"
					local v645 = (10 - min) * 60 - sec

					if v645 < 0 then
						v645 = 0
					end

					v641 = string.format("%s ACTIVE - Time Left: %02d:%02d", s17, math.floor(v645 / 60), v645 % 60)
				else
					local v646 = (60 - min) * 60 - sec

					if v646 <= 0 then
						v646 = 0
					end

					v641 = string.format("%s INACTIVE - Next Event: %02d:%02d", s15, math.floor(v646 / 60), v646 % 60)
				end

				v629:SetText(v641)
			end)
		end
	end)
	_G.MagnetEventSpawnIndex = _G.MagnetEventSpawnIndex or 1

	local t30 = {
		sky = true,
		skyarea2 = true,
		uppersky = true,
		["upper sky"] = true,
		["underwater city"] = true,
		["fishman island"] = true,
		sewers = true,
		["sewer gangs"] = true
	}
	local t31 = {}

	local function v649(p127)
		if not p127 then
			return
		end

		if p127:IsA("BasePart") then
			return p127.Position
		end

		local ok, result = pcall(function()
			return p127:GetPivot()
		end)
		local Position = ok and typeof(result) == "CFrame" and result.Position or nil

		return Position
	end
	local function v653(p128)
		local Locations = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Locations")

		if not Locations then
			return "unknown"
		end

		local Name
		local v656

		for _, child in ipairs(Locations:GetChildren()) do
			if child:IsA("BasePart") then
				local Magnitude = (child.Position - p128).Magnitude

				if not Name or Magnitude < v656 then
					Name = child.Name
					v656 = Magnitude
				end
			end
		end

		return Name and string.lower(Name) or "unknown"
	end
	local function v660(p129, p130)
		local v661 = string.lower(tostring(p130 or ""))
		local v662 = string.lower(tostring(p129.Name or ""))
		local v663 = string.lower(tostring(p129:GetAttribute("DisplayName") or ""))
		local v664 = v662 .. " " .. v663

		if t30[v661] or v661:find("fishman", 1, true) or v661:find("underwater", 1, true) or v661:find("sewer", 1, true) or v664:find("boss", 1, true) then
			return true
		end

		return t31[v662] or t31[v663]
	end
	local function v665()
		local t32 = {}
		local t33 = {}
		local _WorldOrigin = workspace:FindFirstChild("_WorldOrigin")
		local EnemySpawns = _WorldOrigin and _WorldOrigin:FindFirstChild("EnemySpawns")

		if not EnemySpawns then
			return t32
		end

		for _, child in ipairs(EnemySpawns:GetChildren()) do
			local v672 = v649(child)

			if v672 then
				local v673 = v653(v672)
				local v674 = tostring(child:GetAttribute("DisplayName") or child.Name or "")

				if v674 ~= "" and not v660(child, v673) then
					t33[v673] = t33[v673] or {}
					t33[v673][v674] = t33[v673][v674] or {}
					t33[v673][v674][#t33[v673][v674] + 1] = v672
				end
			end
		end

		local t34 = {}

		for k in pairs(t33) do
			t34[#t34 + 1] = k
		end

		table.sort(t34)

		for _, v1 in ipairs(t34) do
			local v679 = t33[v1]
			local t35 = {}
			local v681, v682, v683 = pairs(v679)

			for k in v681, v682, v683 do
				t35[#t35 + 1] = k
			end

			table.sort(t35)

			local Position
			local Locations = _WorldOrigin and _WorldOrigin:FindFirstChild("Locations")

			if Locations then
				local v687, v688, v689 = ipairs(Locations:GetChildren())
				local v690 = geniter(v687, v688, v689)

				while true do
					local v691 = table.pack(v690())

					if not v691[1] then
						break
					end

					local v692 = v691[3]

					if v692:IsA("BasePart") and string.lower(v692.Name) == v1 then
						Position = v692.Position

						break
					end
				end
			end

			local v693, v694, v695 = ipairs(t35)

			for _, v2 in v693, v694, v695 do
				local v698 = v679[v2][1]

				if #t35 > 1 then
					t32[#t32 + 1] = {
						Island = v1,
						Name = v2,
						CFrame = CFrame.new(v698 + Vector3.new(0, 40, 0))
					}
				else
					local vector3 = Vector3.new(1, 0, 0)

					if Position then
						local vector32 = Vector3.new(v698.X - Position.X, 0, v698.Z - Position.Z)

						if vector32.Magnitude > 0.01 then
							vector3 = vector32.Unit
						end
					end

					t32[#t32 + 1] = {
						Island = v1,
						Name = v2,
						CFrame = CFrame.new(v698 + vector3 * 60 + Vector3.new(0, 40, 0))
					}
					t32[#t32 + 1] = {
						Island = v1,
						Name = v2,
						CFrame = CFrame.new(v698 - vector3 * 60 + Vector3.new(0, 40, 0))
					}
				end
			end
		end

		return t32
	end
	local function v701()
		local Enemies_ = workspace:FindFirstChild("Enemies")

		if not Enemies_ then
			return
		end

		local Character = game.Players.LocalPlayer.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local v705
		local v706

		for _, child in ipairs(Enemies_:GetChildren()) do
			if child:IsA("Model") and (child:GetAttribute("MagnetEnemy") == true or string.find(string.lower(child.Name), "magnetized")) and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 and child:FindFirstChild("HumanoidRootPart") then
				local Magnitude = HumanoidRootPart and (child.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude or 0

				if not v705 or Magnitude < v706 then
					v705 = child
					v706 = Magnitude
				end
			end
		end

		return v705
	end
	local function v710(p131)
		if not p131 or typeof(p131.CFrame) ~= "CFrame" then
			return false
		end

		local LocalPlayer = game.Players.LocalPlayer
		local Character = LocalPlayer.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return false
		end

		v631("Patrolling - " .. tostring(p131.Island))
		pcall(function()
			_tp(p131.CFrame)
		end)

		local now = tick()
		local exitTo
		local v716

		while true do
			if not _G.AutoMagnetToken then
				exitTo = 1

				break
			end

			v716 = v701()

			if v716 then
				exitTo = 2

				break
			end

			local Character2 = LocalPlayer.Character
			local HumanoidRootPart2 = Character2 and Character2:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart2 then
				if not ((p131.CFrame.Position - HumanoidRootPart2.Position).Magnitude <= 15) and not (tick() - now > 10) then
					task.wait(0.1)

					continue
				end

				exitTo = 1

				break
			end

			break
		end

		if exitTo ~= 1 then
			if exitTo == 2 then
				return v716
			end

			return false
		end

		if not _G.AutoMagnetToken then
			return false
		end

		v631("Searching - " .. tostring(p131.Island))

		local now2 = tick()

		while _G.AutoMagnetToken and tick() - now2 < 1 do
			local v720 = v701()

			if v720 then
				return v720
			end

			task.wait(0.05)
		end

		local v721 = v701() or false

		return v721
	end

	GRP_Main_Update_30_Magnet_Token:AddToggle("Auto_Farm_Magnet_Token", {
		Text = "Auto Farm Magnet Token",
		Default = false,
		Callback = function(p132)
			_G.AutoMagnetToken = p132
			v631(p132 and "Starting..." or "Idle")

			if not p132 then
				_G.MagnetEventSpawnIndex = 1
			end
		end
	})
	task.spawn(function()
		local magnetEventSpawnRoute = {}
		local magnetEventSpawnIndex = 1
		local v724 = true

		while task.wait() do
			if _G.AutoMagnetToken then
				if v724 or #magnetEventSpawnRoute == 0 then
					magnetEventSpawnRoute = v665()

					if #magnetEventSpawnRoute == 0 then
						task.wait(5)

						continue
					end

					magnetEventSpawnIndex = _G.MagnetEventSpawnIndex or 1

					if magnetEventSpawnIndex > #magnetEventSpawnRoute then
						magnetEventSpawnIndex = 1
					end

					v724 = false
					_G.MagnetEventSpawnRoute = magnetEventSpawnRoute
				end

				local v725 = magnetEventSpawnRoute[magnetEventSpawnIndex]

				if not v725 then
					magnetEventSpawnIndex = 1
					v725 = magnetEventSpawnRoute[magnetEventSpawnIndex]
				end

				local v726 = v710(v725)

				if v726 then
					v631("Farming - " .. tostring(v726.Name))

					while true do
						task.wait(0.1)

						if v726.Parent and v726:FindFirstChild("HumanoidRootPart") then
							_tp(v726.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
							t9.Kill(v726, _G.AutoMagnetToken)

							if not _G.AutoMagnetToken or v726.Humanoid.Health <= 0 or not v726.Parent then
								break
							end
						else
							break
						end
					end

					magnetEventSpawnIndex += 1

					if magnetEventSpawnIndex > #magnetEventSpawnRoute then
						magnetEventSpawnIndex = 1
					end

					_G.MagnetEventSpawnIndex = magnetEventSpawnIndex
				else
					magnetEventSpawnIndex += 1

					if magnetEventSpawnIndex > #magnetEventSpawnRoute then
						magnetEventSpawnIndex = 1
					end

					_G.MagnetEventSpawnIndex = magnetEventSpawnIndex
					task.wait(0.2)
				end
			else
				v631("Idle")
				_G.MagnetEventSpawnIndex = magnetEventSpawnIndex
				task.wait(1)
			end
		end
	end)
end

GRP_Settings_Settings_Configure = t15.Settings:AddLeftGroupbox("Settings / Configure")

local GRP_Settings_Theme = t15.Settings:AddLeftGroupbox("UI Theme Color")
GRP_Settings_Theme:AddButton({Text = "Xanh Duong", Func = function() getgenv().SetThemeAccent(56, 132, 255) end})
GRP_Settings_Theme:AddButton({Text = "Hong", Func = function() getgenv().SetThemeAccent(255, 105, 180) end})
GRP_Settings_Theme:AddButton({Text = "Tim", Func = function() getgenv().SetThemeAccent(155, 89, 182) end})
GRP_Settings_Theme:AddButton({Text = "Do", Func = function() getgenv().SetThemeAccent(244, 67, 54) end})
GRP_Settings_Theme:AddButton({Text = "Cam", Func = function() getgenv().SetThemeAccent(255, 152, 0) end})
GRP_Settings_Theme:AddButton({Text = "Vang", Func = function() getgenv().SetThemeAccent(255, 215, 0) end})
GRP_Settings_Theme:AddButton({Text = "Xanh La", Func = function() getgenv().SetThemeAccent(76, 175, 80) end})
GRP_Settings_Theme:AddButton({Text = "Xanh Ngoc", Func = function() getgenv().SetThemeAccent(0, 191, 165) end})
GRP_Settings_Theme:AddButton({Text = "Trang", Func = function() getgenv().SetThemeAccent(235, 235, 235) end})
GRP_Settings_Theme:AddButton({Text = "Xam Den", Func = function() getgenv().SetThemeAccent(120, 120, 120) end})

do
	Initialize = GRP_Settings_Settings_Configure:AddToggle("Fast_Attack", {
		Text = "Fast Attack",
		Default = true,
		Callback = function(p133)
			_G.Seriality = p133
		end
	})
end

do
	Bringmob = GRP_Settings_Settings_Configure:AddToggle("Bring_Mobs", {
		Text = "Bring Mobs",
		Default = true,
		Callback = function(p134)
			_B = p134
		end
	})
end

do
	GRP_Settings_Settings_Configure:AddToggle("Auto_Hop_Server_with_time", {
		Text = "Auto Hop Server with time",
		Default = false,
		Callback = function(p135)
			_G.AutoHopServer = p135

			if not p135 then
				_G.HopTimer = nil
			end
		end
	})
end

do
	Spawn(function()
		while Wait(1) do
			if _G.AutoHopServer then
				pcall(function()
					if not _G.HopTimer then
						_G.HopTimer = tick()
					end

					if _G.HopDelay <= tick() - _G.HopTimer then
						_G.HopTimer = tick()

						-- v1.1.4: removed remote queue_on_teleport to prevent auto-loading external scripts

						game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
					end
				end)
			end
		end
	end)
end

do
	GRP_Settings_Settings_Configure:AddSlider({
		Text = "Hop Delay (Minutes)",
		Min = 5,
		Max = 120,
		Default = 30,
		Rounding = 0,
		Callback = function(p136)
			_G.HopDelay = p136 * 60
		end
	})
end

do
	GRP_Settings_Settings_Configure:AddToggle("Auto_Set_Spawn_Point", {
		Text = "Auto Set Spawn Point",
		Default = false,
		Callback = function(p137)
			getgenv().Set = p137

			if p137 then
				pcall(function()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
				end)
			end
		end
	})
end

BusuAura = GRP_Settings_Settings_Configure:AddToggle("Auto_Turn_on_Buso", {
	Text = "Auto Turn on Buso",
	Default = true,
	Callback = function(p138)
		Boud = p138
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if Boud then
					local t36 = {
						"HasBuso",
						"Buso"
					}

					if not plr.Character:FindFirstChild(t36[1]) then
						replicated.Remotes.CommF_:InvokeServer(t36[2])
					end
				end
			end)
		end
	end)
end

do
	GRP_Settings_Settings_Configure:AddToggle("Auto_Haki_Observation", {
		Text = "Auto Haki Observation",
		Default = false,
		Callback = function(p139)
			getgenv().Observation = p139
		end
	})
end

spawn(function()
	while wait() do
		if getgenv().Observation then
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)
			end)
		end
	end
end)
RaceV3Aura = GRP_Settings_Settings_Configure:AddToggle("AutoTurnonRaceV3", {
	Text = "Auto Turn on Race V3",
	Default = false,
	Callback = function(p140)
		_G.RaceClickAutov3 = p140
	end
})

do
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.RaceClickAutov3 then
					repeat
						replicated.Remotes.CommE:FireServer("ActivateAbility")
						wait(30)
					until not _G.RaceClickAutov3
				end
			end)
		end
	end)
end

do
	RaceV4Aura = GRP_Settings_Settings_Configure:AddToggle("Auto_Turn_on_Race_V4", {
		Text = "Auto Turn on Race V4",
		Default = false,
		Callback = function(p141)
			_G.RaceClickAutov4 = p141
		end
	})
end

spawn(function()
	while wait(0.2) do
		pcall(function()
			if _G.RaceClickAutov4 then
				if plr.Character:FindFirstChild("RaceEnergy") then
					if plr.Character:FindFirstChild("RaceEnergy").Value == 1 then
						Useskills("nil", "Y")
					end
				end
			end
		end)
	end
end)
RandomAround = GRP_Settings_Settings_Configure:AddToggle("Auto_Turn_on_Spin__xyz", {
	Text = "Auto Turn on Spin  xyz",
	Default = false,
	Callback = function(p142)
		RandomCFrame = p142
	end
})
SafeModes = GRP_Settings_Settings_Configure:AddToggle("Safe_Mode", {
	Text = "Safe Mode",
	Default = false,
	Callback = function(p143)
		_G.Safemode = p143
	end
})
spawn(function()
	while task.wait(Sec) do
		pcall(function()
			if _G.Safemode then
				if plr.Character.Humanoid.Health / plr.Character.Humanoid.MaxHealth * 100 < Num_self then
					shouldTween = true
					_tp(Root.CFrame * CFrame.new(0, 500, 0))
				else
					shouldTween = false
				end
			end
		end)
	end
end)

do
	DisableHitVFX = GRP_Settings_Settings_Configure:AddToggle("Remove_Hit_VFX", {
		Text = "Remove Hit VFX",
		Default = false,
		Callback = function(p144)
			_G.DestroyHit = p144
		end
	})
end

do
	local t37 = {
		"SlashHit",
		"CurvedRing",
		"SwordSlash",
		"SlashTail"
	}

	task.spawn(function()
		while task.wait(Sec) do
			if _G.DestroyHit then
				pcall(function()
					for _, child in pairs(workspace._WorldOrigin:GetChildren()) do
						if table.find(t37, child.Name) then
							child:Destroy()
						end
					end
				end)
			end
		end
	end)
end

RmvVFX = GRP_Settings_Settings_Configure:AddToggle("Remove_Death_&_Respawned_VFX", {
	Text = "Remove Death & Respawned VFX",
	Default = false,
	Callback = function(p145)
		RDeath = p145
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if RDeath then
					if replicated.Effect.Container:FindFirstChild("Death") then
						replicated.Effect.Container.Death:Destroy()
					end

					if replicated.Effect.Container:FindFirstChild("Respawn") then
						replicated.Effect.Container.Respawn:Destroy()
					end
				end
			end)
		end
	end)
end

DisblesNotify = GRP_Settings_Settings_Configure:AddToggle("Disable_Notify", {
	Text = "Disable Notify",
	Default = false,
	Callback = function(p146)
		RemoveDamage = p146
	end
})
spawn(function()
	if wait(Sec) then
		repeat
			pcall(function()
				if RemoveDamage then
					replicated.Assets.GUI.DamageCounter.Enabled = false
					plr.PlayerGui.Notifications.Enabled = false
				else
					replicated.Assets.GUI.DamageCounter.Enabled = true
					plr.PlayerGui.Notifications.Enabled = true
				end
			end)
		until not wait(Sec)
	end
end)
GRP_Settings_Settings_Configure:AddToggle("Anti_AFK", {
	Text = "Anti AFK",
	Default = true,
	Callback = function(p147)
		if p147 then
			local VirtualUser = game:GetService("VirtualUser")

			repeat
				wait()
			until game:IsLoaded()

			game:GetService("Players").LocalPlayer.Idled:Connect(function()
				VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				wait(1)
				VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			end)
		end
	end
})

do
	GRP_Settings_Settings_Configure:AddToggle("Auto_Anti_-_Admin_Join_Server", {
		Text = "Auto Anti - Admin Join Server",
		Default = true,
		Callback = function(p148)
			getgenv().HopServerAdmin = p148
		end
	})
end

spawn(function()
	while wait() do
		pcall(function()
			if getgenv().HopServerAdmin then
				for _, player in pairs(game.Players:GetPlayers()) do
					if table.find({
						"red_game43",
						"rip_indra",
						"Axiore",
						"Polkster",
						"wenlocktoad",
						"Daigrock",
						"toilamvidamme",
						"oofficialnoobie",
						"Uzoth",
						"Azarth",
						"arlthmetic",
						"Death_King",
						"Lunoven",
						"TheGreateAced",
						"rip_fud",
						"drip_mama",
						"layandikit12",
						"Hingoi"
					}, player.Name) then
						Hop()
					end
				end
			end
		end)
	end
end)

do
	GRP_Settings_Settings_Configure:AddToggle("No_Clip", {
		Text = "No Clip",
		Default = false,
		Callback = function(p149)
			getgenv().NoClip = p149
		end
	})
end

do
	spawn(function()
		pcall(function()
			game:GetService("RunService").Stepped:Connect(function()
				if getgenv().NoClip then
					for _, descendant in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
						if descendant:IsA("BasePart") or descendant:IsA("Part") then
							descendant.CanCollide = false
						end
					end
				end
			end)
		end)
	end)
end

GRP_Esp_Stats_Upgrade = t15.Esp:AddLeftGroupbox("Stats Upgrade")
StatusSelect = GRP_Esp_Stats_Upgrade:AddSlider({
	Text = "Stats Value",
	Min = 0,
	Max = 1000,
	Default = 10,
	Rounding = 0,
	Callback = function(p150)
		pSats = p150
	end
})
StatsUpg = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Melee", {
	Text = "Auto Melee",
	Default = false,
	Callback = function(p151)
		_G.Auto_Melee = p151
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Melee then
				statsSetings("Melee", pSats)
			end
		end)
	end
end)
StatsUpg = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Swords", {
	Text = "Auto Swords",
	Default = false,
	Callback = function(p152)
		_G.Auto_Sword = p152
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Sword then
				statsSetings("Sword", pSats)
			end
		end)
	end
end)

do
	StatsUpg = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Gun", {
		Text = "Auto Gun",
		Default = false,
		Callback = function(p153)
			_G.Auto_Gun = p153
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Gun then
					statsSetings("Gun", pSats)
				end
			end)
		end
	end)
end

do
	StatsUpg = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Blox_Fruit", {
		Text = "Auto Blox Fruit",
		Default = false,
		Callback = function(p154)
			_G.Auto_DevilFruit = p154
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_DevilFruit then
				statsSetings("Devil", pSats)
			end
		end)
	end
end)

do
	StatsUpg = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Defense", {
		Text = "Auto Defense",
		Default = false,
		Callback = function(p155)
			_G.Auto_Defense = p155
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Defense then
				statsSetings("Defense", pSats)
			end
		end)
	end
end)
GRP_Fish_Fishing = t15.Fish:AddLeftGroupbox("Fishing")
GRP_Fish_Fishing:AddDropdown("Select_Fishing_Rod", {
	Text = "Select Fishing Rod",
	Values = {
		"Fishing Rod",
		"Gold Rod",
		"Shark Rod",
		"Shell Rod",
		"Treasure Rod"
	},
	Default = "Fishing Rod",
	Callback = function(p156)
		_G.SelectedRod = p156
	end
})
BaitDropdown = GRP_Fish_Fishing:AddDropdown("Select_Bait", {
	Text = "Select Bait",
	Values = {
		"Basic Bait",
		"Kelp Bait",
		"Good Bait",
		"Abyssal Bait",
		"Frozen Bait",
		"Epic Bait",
		"Carnivore Bait"
	},
	Default = "Basic Bait",
	Callback = function(p157)
		_G.SelectedBait = p157

		if _G.AutoBuyBait then
			pcall(function()
				t8.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
			end)
		end
	end
})
BuyBaitToggle = GRP_Fish_Fishing:AddToggle("Auto_Buy_Bait", {
	Text = "Auto Buy Bait",
	Default = false,
	Callback = function(p158)
		_G.AutoBuyBait = p158

		if p158 then
			pcall(function()
				t8.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
			end)
		end
	end
})
task.spawn(function()
	while task.wait(2) do
		if _G.AutoBuyBait and _G.SelectedBait then
			local exitTo

			repeat
				pcall(function()
					t8.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
				end)
				exitTo = nil

				while task.wait(2) do
					if _G.AutoBuyBait and _G.SelectedBait then
						exitTo = 1

						break
					end
				end
			until exitTo ~= 1

			return
		end
	end
end)
FishingToggle = GRP_Fish_Fishing:AddToggle("Auto_Fishing", {
	Text = "Auto Fishing",
	Default = false,
	Callback = function(p159)
		_G.AutoFishing = p159
	end
})

local Players = game:GetService("Players")

do
	local LocalPlayer = Players.LocalPlayer
	local Workspace = game:GetService("Workspace")
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local FishReplicated = ReplicatedStorage2:WaitForChild("FishReplicated")
	local FishingRequest = FishReplicated:WaitForChild("FishingRequest")
	local Config = require(FishReplicated.FishingClient.Config)
	local GetWaterHeightAtLocation = require(ReplicatedStorage2.Util.GetWaterHeightAtLocation)
	local MaxLaunchDistance = Config.Rod.MaxLaunchDistance

	task.spawn(function()
		while task.wait(0.5) do
			if _G.AutoFishing then
				local exitTo

				repeat
					pcall(function()
						local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
						local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

						if not HumanoidRootPart then
							return
						end

						local Tool = Character:FindFirstChildOfClass("Tool")

						if _G.SelectedRod and (not Tool or Tool.Name ~= _G.SelectedRod) then
							local _GSelectedRod = LocalPlayer.Backpack:FindFirstChild(_G.SelectedRod)

							if _GSelectedRod then
								Character.Humanoid:EquipTool(_GSelectedRod)
								Tool = _GSelectedRod
							end
						end

						if Tool then
							local v751 = GetWaterHeightAtLocation(HumanoidRootPart.Position)
							local _, v753 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(Character.Head.Position, HumanoidRootPart.CFrame.LookVector * MaxLaunchDistance), {
								Character,
								Workspace.Characters,
								Workspace.Enemies
							})
							local vector3 = v753 and Vector3.new(v753.X, math.max(v753.Y, v751), v753.Z)
							local attribute = Tool:GetAttribute("State")
							local attribute2 = Tool:GetAttribute("ServerState")

							if vector3 and (attribute == "ReeledIn" or attribute2 == "ReeledIn") then
								FishingRequest:InvokeServer("StartCasting")
								task.wait()
								FishingRequest:InvokeServer("CastLineAtLocation", vector3, 100, true)
							elseif attribute2 == "Biting" then
								FishingRequest:InvokeServer("Catching", true)
								task.wait(0.1)
								FishingRequest:InvokeServer("Catch", 1)
							end
						end
					end)
					exitTo = nil

					while task.wait(0.5) do
						if _G.AutoFishing then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

do
	FishingQ = GRP_Fish_Fishing:AddToggle("Auto_Quest_Fishing", {
		Text = "Auto Quest Fishing",
		Default = false,
		Callback = function(p160)
			_G.AutoFishingQuest = p160
		end
	})
end

do
	local LocalPlayer = game:GetService("Players").LocalPlayer
	local RFJobsRemoteFunction = game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RF/JobsRemoteFunction")

	local function v759()
		local Quest = LocalPlayer.PlayerGui:FindFirstChild("Quest") or LocalPlayer.PlayerGui:FindFirstChild("QuestGui")

		if Quest and Quest:FindFirstChild("Container") then
			if Quest.Container:FindFirstChild("QuestTitle") then
				return true
			end
		end

		return false
	end

	task.spawn(function()
		while task.wait(1) do
			if _G.AutoFishingQuest then
				local exitTo

				repeat
					pcall(function()
						if not v759() then
							RFJobsRemoteFunction:InvokeServer("FishingNPC", "Angler", "AskQuest")
						end
					end)
					exitTo = nil

					while task.wait(1) do
						if _G.AutoFishingQuest then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

QuestToggle = GRP_Fish_Fishing:AddToggle("Auto_Complete_Quest", {
	Text = "Auto Complete Quest",
	Default = false,
	Callback = function(p161)
		_G.AutoQuestComplete = p161

		if p161 then
			pcall(function()
				t8.RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")
			end)
		end
	end
})

do
	task.spawn(function()
		while task.wait(5) do
			if _G.AutoQuestComplete then
				pcall(function()
					t8.RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")
				end)
			end
		end
	end)
end

SellFishToggle = GRP_Fish_Fishing:AddToggle("Auto_Sell_Fish", {
	Text = "Auto Sell Fish",
	Default = false,
	Callback = function(p162)
		_G.AutoSellFish = p162

		if p162 then
			pcall(function()
				t8.RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")
			end)
		end
	end
})

do
	task.spawn(function()
		while task.wait(5) do
			if _G.AutoSellFish then
				pcall(function()
					t8.RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")
				end)
			end
		end
	end)
end

SpamSkillZ = GRP_Fish_Fishing:AddToggle("Auto_Spam_Skill_Z", {
	Text = "Auto Spam Skill Z",
	Default = false,
	Callback = function(p163)
		_G.AutoSkillZ = p163
	end
})

do
	local RFJobToolAbilities = game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RF/JobToolAbilities")

	task.spawn(function()
		while task.wait(0.5) do
			if _G.AutoSkillZ then
				pcall(function()
					RFJobToolAbilities:InvokeServer("Z", true)
				end)
			end
		end
	end)
end

GRP_Quests_Auto_Quest_Sea_2 = t15.Quests:AddLeftGroupbox("Auto Quest Sea 2")

do
	TravelDress = GRP_Quests_Auto_Quest_Sea_2:AddToggle("Auto_Quest_Sea_2", {
		Text = "Auto Quest Sea 2",
		Default = false,
		Callback = function(p164)
			_G.TravelDres = p164
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.TravelDres then
				if plr.Data.Level.Value >= 700 then
					if workspace.Map.Ice.Door.CanCollide == true and workspace.Map.Ice.Door.Transparency == 0 then
						replicated.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
						EquipWeapon("Key")

						while true do
							wait()
							_tp(CFrame.new(1347.7124, 37.3751602, -1325.6488))

							if _G.TravelDres then
								if Root.Position == CFrame.new(1347.7124, 37.3751602, -1325.6488).Position then
									break
								end
							else
								break
							end
						end
					else
						if workspace.Map.Ice.Door.CanCollide ~= false then
							replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")

							return
						end

						if workspace.Map.Ice.Door.Transparency == 1 then
							if Enemies:FindFirstChild("Ice Admiral") then
								for _, child in pairs(Enemies:GetChildren()) do
									if child.Name == "Ice Admiral" and t9.Alive(child) then
										while true do
											task.wait()
											t9.Kill(child, _G.TravelDres)

											if _G.TravelDres == false then
												break
											elseif child.Humanoid.Health <= 0 then
												break
											end
										end

										replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
									end
								end
							else
								_tp(CFrame.new(1347.7124, 37.3751602, -1325.6488))
							end
						else
							replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
						end
					end
				end
			end
		end)
	end
end)
Zou = GRP_Quests_Auto_Quest_Sea_2:AddToggle("Auto_Quest_Sea_3", {
	Text = "Auto Quest Sea 3",
	Default = false,
	Callback = function(p165)
		_G.AutoZou = p165
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.AutoZou and plr.Data.Level.Value >= 1500 then
				if replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 then
					if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess ~= nil then
						replicated.Remotes.CommF_:InvokeServer("F_", "TravelZou")

						if replicated.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 0 then
							local ripIndra = GetConnectionEnemies("rip_indra")

							if ripIndra then
								while true do
									wait()
									t9.Kill(ripIndra, _G.AutoZou)

									if _G.AutoZou then
										if not ripIndra.Parent or ripIndra.Humanoid.Health <= 0 then
											break
										end
									else
										break
									end
								end

								Check = 2

								repeat
									wait()
									replicated.Remotes.CommF_:InvokeServer("F_", "TravelZou")
								until Check == 1
							else
								replicated.Remotes.CommF_:InvokeServer("F_", "ZQuestProgress", "Check")
								wait(0.1)
								replicated.Remotes.CommF_:InvokeServer("F_", "ZQuestProgress", "Begin")
							end
						elseif replicated.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 1 then
							replicated.Remotes.CommF_:InvokeServer("F_", "TravelZou")
						else
							local v766 = GetConnectionEnemies("Don Swan")

							if v766 then
								while true do
									wait()
									t9.Kill(v766, _G.AutoZou)

									if _G.AutoZou then
										if not v766.Parent or v766.Humanoid.Health <= 0 then
											break
										end
									else
										break
									end
								end
							else
								while true do
									wait()
									_tp(CFrame.new(2288.802, 15.1870775, 863.034607))

									if _G.AutoZou then
										if Root.Position == CFrame.new(2288.802, 15.1870775, 863.034607).Position then
											break
										end
									else
										break
									end
								end

								if Root.CFrame == CFrame.new(2288.802, 15.1870775, 863.034607) then
									notween(CFrame.new(2288.802, 15.1870775, 863.034607))
								end
							end
						end
					elseif replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
						TabelDevilFruitStore = {}
						TabelDevilFruitOpen = {}

						for _, v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventoryFruits")) do
							for k, v2 in pairs(v1) do
								if k == "Name" then
									table.insert(TabelDevilFruitStore, v2)
								end
							end
						end

						local next_ = next
						local response, v773 = game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits")

						for _, v1 in next_, response, v773 do
							if v1.Price >= 1000000 then
								table.insert(TabelDevilFruitOpen, v1.Name)
							end
						end

						for _, v1 in pairs(TabelDevilFruitOpen) do
							for _, v2 in pairs(TabelDevilFruitStore) do
								if v1 == v2 then
									if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
										if plr.Backpack:FindFirstChild(v2) then
											replicated.Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "1")
											replicated.Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "2")
											replicated.Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "3")
										else
											replicated.Remotes.CommF_:InvokeServer("F_", "LoadFruit", v2)
										end
									end
								end
							end
						end

						replicated.Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "1")
						replicated.Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "2")
						replicated.Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "3")
					end
				elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
					if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and plr.PlayerGui.Main.Quest.Visible == true then
						local v780 = GetConnectionEnemies("Swan Pirate")

						if v780 then
							pcall(function()
								while true do
									wait()
									t9.Kill(v780, _G.AutoZou)

									if v780.Parent then
										if v780.Humanoid.Health <= 0 or _G.AutoZou == false or plr.PlayerGui.Main.Quest.Visible == false then
											break
										end
									else
										break
									end
								end
							end)
						else
							_tp(CFrame.new(1057.92761, 137.614319, 1242.08069))
						end
					else
						_tp(CFrame.new(-456.28952, 73.0200958, 299.895966))
					end
				elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
					local Jeremy = GetConnectionEnemies("Jeremy")

					if Jeremy then
						while true do
							wait()
							t9.Kill(Jeremy, _G.AutoZou)

							if Jeremy.Parent then
								if Jeremy.Humanoid.Health <= 0 or _G.AutoZou == false then
									break
								end
							else
								break
							end
						end
					else
						_tp(CFrame.new(2099.88159, 448.931, 648.997375))
					end
				elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
					while true do
						wait()
						_tp(CFrame.new(-1836, 11, 1714))

						if _G.AutoZou then
							if Root.Position == CFrame.new(-1836, 11, 1714).Position then
								break
							end
						else
							break
						end
					end

					if Root.CFrame == CFrame.new(-1836, 11, 1714) then
						notween(CFrame.new(-1836, 11, 1714))
					end

					notween(CFrame.new(-1850.49329, 13.1789551, 1750.89685))
					wait(0.1)
					notween(CFrame.new(-1858.87305, 19.3777466, 1712.01807))
					wait(0.1)
					notween(CFrame.new(-1803.94324, 16.5789185, 1750.89685))
					wait(0.1)
					notween(CFrame.new(-1858.55835, 16.8604317, 1724.79541))
					wait(0.1)
					notween(CFrame.new(-1869.54224, 15.987854, 1681.00659))
					wait(0.1)
					notween(CFrame.new(-1800.0979, 16.4978027, 1684.52368))
					wait(0.1)
					notween(CFrame.new(-1819.26343, 14.795166, 1717.90625))
					wait(0.1)
					notween(CFrame.new(-1813.51843, 14.8604736, 1724.79541))
				end
			end
		end)
	end
end)
GRP_Quests_Tushita_Yama = t15.Quests:AddLeftGroupbox("Tushita + Yama")
Q = GRP_Quests_Tushita_Yama:AddToggle("Auto_Tushita_Sword", {
	Text = "Auto Tushita Sword",
	Default = false,
	Callback = function(p166)
		_G.Auto_Tushita = p166
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Tushita then
					if workspace.Map.Turtle:FindFirstChild("TushitaGate") then
						if GetBP("Holy Torch") then
							EquipWeapon("Holy Torch")
							task.wait(1)

							while true do
								task.wait()
								_tp(CFrame.new(-10752, 417, -9366))

								if _G.Auto_Tushita then
									if (CFrame.new(-10752, 417, -9366).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
										break
									end
								else
									break
								end
							end

							wait(0.7)

							while true do
								task.wait()
								_tp(CFrame.new(-11672, 334, -9474))

								if _G.Auto_Tushita then
									if (CFrame.new(-11672, 334, -9474).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
										break
									end
								else
									break
								end
							end

							wait(0.7)

							while true do
								task.wait()
								_tp(CFrame.new(-12132, 521, -10655))

								if _G.Auto_Tushita then
									if (CFrame.new(-12132, 521, -10655).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
										break
									end
								else
									break
								end
							end

							wait(0.7)

							while true do
								task.wait()
								_tp(CFrame.new(-13336, 486, -6985))

								if _G.Auto_Tushita then
									if (CFrame.new(-13336, 486, -6985).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
										break
									end
								else
									break
								end
							end

							wait(0.7)

							while true do
								task.wait()
								_tp(CFrame.new(-13489, 332, -7925))

								if _G.Auto_Tushita then
									if (CFrame.new(-13489, 332, -7925).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
										break
									end
								else
									break
								end
							end
						else
							_tp(CFrame.new(5148.03613, 162.352493, 910.548218))
							wait(0.7)
						end
					else
						local Longma = GetConnectionEnemies("Longma")

						if Longma then
							while true do
								task.wait()
								t9.Kill(Longma, _G.Auto_Tushita)

								if Longma.Humanoid.Health <= 0 then
									break
								elseif not _G.Auto_Tushita or not Longma.Parent then
									break
								end
							end
						elseif replicated:FindFirstChild("Longma") then
							_tp(replicated:FindFirstChild("Longma").HumanoidRootPart.CFrame * CFrame.new(0, 40, 0))
						end
					end
				end
			end)
		end
	end)
end

do
	Q = GRP_Quests_Tushita_Yama:AddToggle("Auto_Yama_Sword", {
		Text = "Auto Yama Sword",
		Default = false,
		Callback = function(p167)
			_G.Auto_Yama = p167
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Yama then
					if replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") < 30 then
						_G.FarmEliteHunt = true
					elseif replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") > 30 then
						_G.FarmEliteHunt = false

						if (workspace.Map.Waterfall.SealedKatana.Handle.Position - plr.Character.HumanoidRootPart.Position).Magnitude >= 20 then
							_tp(workspace.Map.Waterfall.SealedKatana.Handle.CFrame)

							local Ghost = GetConnectionEnemies("Ghost")

							if Ghost then
								while true do
									wait()
									t9.Kill(Ghost, _G.Auto_Yama)

									if Ghost.Humanoid.Health <= 0 then
										break
									elseif not Ghost.Parent or not _G.Auto_Yama then
										break
									end
								end

								fireclickdetector(workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
							end
						end
					end
				end
			end)
		end
	end)
end

GRP_Quests_Skull_Guitars_Misc = t15.Quests:AddLeftGroupbox("Skull Guitars / Misc")

do
	local v784 = GRP_Quests_Skull_Guitars_Misc:AddLabel("")

	spawn(function()
		while wait(0.2) do
			pcall(function()
				if Quest1 == true then
					v784:SetText("Quest Number : Quest1")
				elseif Quest2 == true then
					v784:SetText("Quest Number : Quest2")
				elseif Quest3 == true then
					v784:SetText("Quest Number : Quest3")
				elseif Quest4 == true then
					v784:SetText("Quest Number : Quest4")
				elseif GetWP("Skull Guitar") then
					v784:SetText("Quest Number : Collect!!")
				else
					v784:SetText("Quest Number : No Quest!!")
				end
			end)
		end
	end)
end

do
	GRP_Quests_Skull_Guitars_Misc:AddToggle("Auto_Skull_Guitar", {
		Text = "Auto Skull Guitar",
		Default = false,
		Callback = function(p168)
			_G.Auto_Soul_Guitar = p168
		end
	})
end

do
	task.spawn(function()
		while wait() do
			if _G.Auto_Soul_Guitar then
				pcall(function()
					local v785 = GetConnectionEnemies("Living Zombie")

					if v785 then
						v785.HumanoidRootPart.CFrame = CFrame.new(-10138.3974609375, 138.6524658203125, 5902.89208984375)
						v785.Head.CanCollide = false
						v785.Humanoid.Sit = false
						v785.HumanoidRootPart.CanCollide = false
						v785.Humanoid.JumpPower = 0
						v785.Humanoid.WalkSpeed = 0

						if v785.Humanoid:FindFirstChild("Animator") then
							v785.Humanoid:FindFirstChild("Animator"):Destroy()
						end
					end
				end)
			end
		end
	end)
end

do
	getT = function(p169)
		local Rotation

		if p169 == 1 then
			Rotation = workspace.Map["Haunted Castle"].Tablet.Segment1.Line.Rotation
		elseif p169 == 3 then
			Rotation = workspace.Map["Haunted Castle"].Tablet.Segment3.Line.Rotation
		elseif p169 == 4 then
			Rotation = workspace.Map["Haunted Castle"].Tablet.Segment4.Line.Rotation
		elseif p169 == 7 then
			Rotation = workspace.Map["Haunted Castle"].Tablet.Segment7.Line.Rotation
		elseif p169 == 10 then
			Rotation = workspace.Map["Haunted Castle"].Tablet.Segment10.Line.Rotation
		end

		if Rotation then
			return Rotation.Z
		end
	end
end

do
	getRT = function(p170)
		local Rotation

		for _, child in pairs(workspace.Map["Haunted Castle"].Trophies.Quest:GetChildren()) do
			if p170 == 1 and child.Name == "Trophy1" and child:FindFirstChild("Handle") then
				Rotation = child.Handle.Rotation
			elseif p170 == 2 and child.Name == "Trophy2" and child:FindFirstChild("Handle") then
				Rotation = child.Handle.Rotation
			elseif p170 == 3 and child.Name == "Trophy3" and child:FindFirstChild("Handle") then
				Rotation = child.Handle.Rotation
			elseif p170 == 4 and child.Name == "Trophy4" and child:FindFirstChild("Handle") then
				Rotation = child.Handle.Rotation
			elseif p170 == 5 and child.Name == "Trophy5" and child:FindFirstChild("Handle") then
				Rotation = child.Handle.Rotation
			end

			if Rotation then
				return Rotation.Z
			end
		end
	end
end

do
	GetFirePlacard = function(p171, p172)
		if tostring(workspace.Map["Haunted Castle"]["Placard" .. p171][p172].Indicator.BrickColor) ~= "Pearl" then
			fireclickdetector(workspace.Map["Haunted Castle"]["Placard" .. p171][p172].ClickDetector)
		end
	end
end

do
	spawn(function()
		repeat
			task.wait()
		until _G.Auto_Soul_Guitar

		while wait(Sec) do
			pcall(function()
				if _G.Auto_Soul_Guitar and World3 then
					replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
					replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)

					if replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check") == nil then
						_tp(CFrame.new(-8655.0166015625, 141.31669616699219, 6160.0224609375))
						replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
						replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
					elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Swamp == false then
						Quest1 = true
						Quest2 = false
						Quest3 = false
						Quest4 = false

						local v790 = GetConnectionEnemies("Living Zombie")

						if v790 then
							while true do
								task.wait()
								t9.Kill(v790, _G.Auto_Soul_Guitar)

								if _G.Auto_Soul_Guitar then
									if v790.Humanoid.Health <= 0 or not v790.Parent or workspace.Map["Haunted Castle"].SwampWater.Color ~= Color3.fromRGB(117, 0, 0) then
										break
									end
								else
									break
								end
							end
						else
							_tp(CFrame.new(-10170.7275390625, 138.6524658203125, 5934.26513671875))
						end
					elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Gravestones == false then
						Quest1 = false
						Quest2 = true
						Quest3 = false
						Quest4 = false
						GetFirePlacard("7", "Left")
						GetFirePlacard("6", "Left")
						GetFirePlacard("5", "Left")
						GetFirePlacard("4", "Right")
						GetFirePlacard("3", "Left")
						GetFirePlacard("2", "Right")
						GetFirePlacard("1", "Right")
					elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Ghost == false then
						replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost")
						replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost", true)
					elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Trophies == false then
						Quest1 = false
						Quest2 = false
						Quest3 = true
						Quest4 = false
						_tp(CFrame.new(-9532.8232421875, 6.4716677665710449, 6078.068359375))

						local v791, v792

						repeat
							wait()
							v792 = getRT(1)
							v791 = getT(1)

							if v792 and v791 then
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment1:FindFirstChild("ClickDetector"))
							end
						until v792 == v791

						local v793, v794

						repeat
							wait()
							v794 = getRT(2)
							v793 = getT(3)

							if v794 and v793 then
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment3:FindFirstChild("ClickDetector"))
							end
						until v794 == v793

						local v795, v796

						repeat
							wait()
							v796 = getRT(3)
							v795 = getT(4)

							if v796 and v795 then
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment4:FindFirstChild("ClickDetector"))
							end
						until v796 == v795

						local v797, v798

						repeat
							wait()
							v798 = getRT(4)
							v797 = getT(7)

							if v798 and v797 then
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment7:FindFirstChild("ClickDetector"))
							end
						until v798 == v797

						local v799, v800

						repeat
							wait()
							v800 = getRT(5)
							v799 = getT(10)

							if v800 and v799 then
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment10:FindFirstChild("ClickDetector"))
							end
						until v800 == v799

						while true do
							wait()
							fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment2:FindFirstChild("ClickDetector"))
							fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment5:FindFirstChild("ClickDetector"))
							fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment6:FindFirstChild("ClickDetector"))
							fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment8:FindFirstChild("ClickDetector"))
							fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment9:FindFirstChild("ClickDetector"))

							if workspace.Map["Haunted Castle"].Tablet.Segment2.Line.Rotation.Z == 0 then
								break
							elseif workspace.Map["Haunted Castle"].Tablet.Segment5.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment6.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment8.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment9.Line.Rotation.Z == 0 then
								break
							end
						end
					elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Pipes == false then
						Quest1 = false
						Quest2 = false
						Quest3 = false
						Quest4 = true
						_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.CFrame)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.ClickDetector)
						_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.CFrame)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
						_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.CFrame)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
						_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.CFrame)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.ClickDetector)
						_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.CFrame)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
					end
				end
			end)
		end
	end)
end

do
	GRP_Quests_Skull_Guitars_Misc:AddToggle("Auto_Farm_Material_Skull_Guitar", {
		Text = "Auto Farm Material Skull Guitar",
		Default = false,
		Callback = function(p173)
			_G.AutoMatSoul = p173
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.AutoMatSoul and GetWP("Skull Guitar") == false then
				if GetM("Bones") >= 500 and GetM("Ectoplasm") >= 250 and GetM("Dark Fragment") >= 1 then
					replicated.Remotes.CommF_:InvokeServer("soulGuitarBuy", true)
				elseif not (GetM("Ectoplasm") <= 250) then
					if GetM("Dark Fragment") < 1 then
						if _G.AutoMatSoul and World2 then
							local Darkbeard = GetConnectionEnemies("Darkbeard")

							if Darkbeard then
								while true do
									task.wait()
									t9.Kill(Darkbeard, _G.AutoMatSoul)

									if not _G.AutoMatSoul then
										break
									elseif Darkbeard.Humanoid.Health <= 0 then
										break
									end
								end
							else
								_tp(CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625))
							end
						else
							replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
						end

						if not GetConnectionEnemies("Darkbeard") then
							Hop()
						end
					elseif GetM("Bones") <= 500 then
						if _G.AutoMatSoul and World3 then
							local v802 = GetConnectionEnemies({
								"Reborn Skeleton",
								"Living Zombie",
								"Demonic Soul",
								"Posessed Mummy"
							})

							if v802 then
								while true do
									task.wait()
									t9.Kill(v802, _G.AutoMatSoul)

									if _G.AutoMatSoul then
										if v802.Humanoid.Health <= 0 or not v802.Parent or v802.Humanoid.Health <= 0 then
											break
										end
									else
										break
									end
								end
							else
								_tp(CFrame.new(-9504.8564453125, 172.14292907714844, 6057.259765625))
							end
						else
							replicated.Remotes.CommF_:InvokeServer("TravelZou")
						end
					end
				elseif _G.AutoMatSoul and World2 then
					local v803 = GetConnectionEnemies({
						"Ship Deckhand",
						"Ship Engineer",
						"Ship Steward",
						"Ship Officer",
						"Arctic Warrior"
					})

					if v803 then
						while true do
							task.wait()
							t9.Kill(v803, _G.AutoMatSoul)

							if _G.AutoMatSoul then
								if not v803.Parent or v803.Humanoid.Health <= 0 then
									break
								end
							else
								break
							end
						end
					else
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
					end
				else
					replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
				end
			end
		end)
	end
end)
GRP_Quests_Cursed_Dual_Katana = t15.Quests:AddLeftGroupbox("Cursed Dual Katana")

do
	local v804 = GRP_Quests_Cursed_Dual_Katana:AddLabel("Quest Numbers :")

	spawn(function()
		while wait(0.2) do
			if QuestYama_1 == true then
				v804:SetText("Quest Numbers : yama quest 1")
			elseif QuestYama_2 == true then
				v804:SetText("Quest Numbers : yama quest 2")
			elseif QuestYama_3 == true then
				v804:SetText("Quest Numbers : yama quest 3")
			elseif QuestTushita_1 == true then
				v804:SetText("Quest Numbers : tushita quest 1")
			elseif QuestTushita_2 == true then
				v804:SetText("Quest Numbers : tushita quest 2")
			elseif GetWP("Cursed Dual Katana") then
				v804:SetText("Quest Numbers : CDK done!!")
			end
		end
	end)
end

do
	Q = GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_Get_CDK_[_Last_Quest_]", {
		Text = "Auto Get CDK [ Last Quest ]",
		Default = false,
		Callback = function(p174)
			_G.CDK = p174
		end
	})
end

do
	spawn(function()
		if wait(Sec) then
			repeat
				pcall(function()
					if _G.CDK then
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Boss")

						local v805 = GetConnectionEnemies("Cursed Skeleton Boss")

						if v805 then
							repeat
								wait()

								if plr.Character:FindFirstChild("Yama") then
									EquipWeapon("Yama")
								else
									if plr.Backpack:FindFirstChild("Yama") then
										EquipWeapon("Yama")
										_tp(v805.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))

										if not _G.CDK or not v805.Parent or v805.Humanoid.Health <= 0 then
											break
										end
									end

									if plr.Character:FindFirstChild("Tushita") then
										EquipWeapon("Tushita")
									elseif plr.Backpack:FindFirstChild("Tushita") then
										EquipWeapon("Tushita")
										_tp(v805.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))

										if not _G.CDK or not v805.Parent or v805.Humanoid.Health <= 0 then
											break
										end
									end
								end

								_tp(v805.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
							until not _G.CDK or not v805.Parent or v805.Humanoid.Health <= 0
						else
							_tp(CFrame.new(-12318.193359375, 601.95184326171875, -6538.662109375))
							wait(0.5)
							_tp(workspace.Map.Turtle.Cursed.BossDoor.CFrame)
						end
					end
				end)
			until not wait(Sec)
		end
	end)
end

Q = GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_Yama_CDK", {
	Text = "Auto Yama CDK",
	Default = false,
	Callback = function(p175)
		_G.CDK_YM = p175
	end
})

do
	spawn(function()
		while wait() do
			pcall(function()
				if _G.CDK_YM then
					if tostring(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
					elseif replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Finished == nil then
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
					elseif replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Finished == false then
						if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == -3 then
							QuestYama_1 = true
							QuestYama_2 = false
							QuestYama_3 = false

							repeat
								task.wait()

								if workspace.Enemies:FindFirstChild("Forest Pirate") then
									if GetConnectionEnemies("Forest Pirate") then
										_tp(workspace.Enemies:FindFirstChild("Forest Pirate").HumanoidRootPart.CFrame)
									end
								else
									_tp(CFrame.new(-13223.521484375, 428.19381713867188, -7766.06787109375))
								end
							until not (tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 1 and _G.CDK_YM)
						elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == -4 then
							QuestYama_1 = false
							QuestYama_2 = true
							QuestYama_3 = false

							for _, child in pairs(game:GetService("Players").LocalPlayer.QuestHaze:GetChildren()) do
								for k, v1 in pairs(t7) do
									if string.find(k, child.Name) and child.Value > 0 then
										if (v1.Position - Root.Position).Magnitude <= 1000 then
											if workspace.Enemies:FindFirstChild(k) then
												for _, child2 in pairs(workspace.Enemies:GetChildren()) do
													if child2:FindFirstChild("HumanoidRootPart") and child2:FindFirstChild("Humanoid") and child2:FindFirstChild("Humanoid").Health > 0 and child2:FindFirstChild("HazeESP") then
														while true do
															wait()
															t9.Kill(child2, _G.CDK_YM)

															if _G.CDK_YM then
																if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 2 or not child2:FindFirstChild("HazeESP") or child2.Humanoid.Health <= 0 then
																	break
																end
															else
																break
															end
														end
													end
												end

												continue
											end
										end

										_tp(v1)
									end
								end
							end
						elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == -5 then
							QuestYama_1 = false
							QuestYama_2 = false
							QuestYama_3 = true

							if workspace.Map:FindFirstChild("HellDimension") and (Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 1000 then
								for k in pairs(workspace.Map.HellDimension.Exit:GetChildren()) do
									if tonumber(k) == 2 then
										while true do
											task.wait()
											Root.CFrame = workspace.Map.HellDimension.Exit.CFrame

											if _G.CDK_YM then
												if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 3 then
													break
												end
											else
												break
											end
										end
									end
								end

								EquipWeapon(_G.SelectWeapon)

								if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 3 then
									while true do
										task.wait()

										repeat
											task.wait()
											_tp(workspace.Map.HellDimension.Torch1.Particles.CFrame)

											for _, descendant in pairs(workspace.Map.HellDimension:GetDescendants()) do
												if descendant:IsA("ProximityPrompt") then
													fireproximityprompt(descendant)
												end
											end
										until (workspace.Map.HellDimension.Torch1.Particles.Position - Root.Position).Magnitude < 5

										wait(2)
										_G.T1Yama = true

										if _G.CDK_YM and not _G.T1Yama then
											if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 3 then
												continue
											end
										end

										break
									end

									while true do
										task.wait()

										repeat
											task.wait()
											_tp(workspace.Map.HellDimension.Torch2.Particles.CFrame)

											for _, descendant in pairs(workspace.Map.HellDimension:GetDescendants()) do
												if descendant:IsA("ProximityPrompt") then
													fireproximityprompt(descendant)
												end
											end
										until (workspace.Map.HellDimension.Torch2.Particles.Position - Root.Position).Magnitude < 5

										wait(2)
										_G.T2Yama = true

										if not (_G.T2Yama or _G.CDK_YM == false) then
											if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 3 then
												continue
											end
										end

										break
									end

									while true do
										wait()

										repeat
											task.wait()
											_tp(workspace.Map.HellDimension.Torch3.Particles.CFrame)

											for _, descendant in pairs(workspace.Map.HellDimension:GetDescendants()) do
												if descendant:IsA("ProximityPrompt") then
													fireproximityprompt(descendant)
												end
											end
										until (workspace.Map.HellDimension.Torch3.Particles.Position - Root.Position).Magnitude < 5

										wait(2)
										_G.T3Yama = true

										if not (_G.T3Yama or _G.CDK_YM == false) then
											if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 3 then
												continue
											end
										end

										break
									end
								end

								for _, child in pairs(workspace.Enemies:GetChildren()) do
									if (child:FindFirstChild("HumanoidRootPart").Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 300 then
										if child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child:FindFirstChild("Humanoid").Health > 0 then
											while true do
												task.wait()
												t9.Kill(child, _G.CDK_YM)

												if _G.CDK_YM and not (child.Humanoid.Health <= 0) and child.Parent then
													if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 3 then
														break
													end
												else
													break
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end)
		end
	end)
end

do
	spawn(function()
		while wait() do
			pcall(function()
				if _G.CDK_YM then
					if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == -5 then
						if not workspace.Map:FindFirstChild("HellDimension") or (Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude > 1000 then
							local v821 = GetConnectionEnemies("Soul Reaper")

							if v821 then
								while true do
									task.wait()
									_tp(v821.HumanoidRootPart.CFrame)

									if not (v821.Humanoid.Health <= 0) and _G.CDK_YM and v821.Parent then
										if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 3 then
											if not workspace.Map:FindFirstChild("HellDimension") or not ((Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 1000) then
												continue
											end
										end

										break
									end

									break
								end
							elseif plr.Backpack:FindFirstChild("Hallow Essence") then
								repeat
									_tp(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))
									task.wait()
								until (CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125).Position - Root.Position).Magnitude <= 8

								EquipWeapon("Hallow Essence")
							else
								if plr.Character:FindFirstChild("Hallow Essence") then
									repeat
										_tp(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))
										task.wait()
									until (CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125).Position - Root.Position).Magnitude <= 8

									EquipWeapon("Hallow Essence")

									return
								end

								local ok4 = not replicated:FindFirstChild("Soul Reaper")

								if not ok4 then
									ok4 = not (replicated:FindFirstChild("Soul Reaper").Humanoid.Health > 0)
								end

								if ok4 then
									if not (replicated.Remotes.CommF_:InvokeServer("Bones", "Check") < 50) then
										replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)

										return
									end

									if workspace.Enemies:FindFirstChild("Soul Reaper") then
										replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
									else
										if replicated:FindFirstChild("Soul Reaper") then
											replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)

											return
										end

										if workspace.Map:FindFirstChild("HellDimension") then
											replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)

											return
										end

										local ok = workspace.Enemies:FindFirstChild("Reborn Skeleton")

										if not ok then
											ok = workspace.Enemies:FindFirstChild("Living Zombie")
										end

										local ok2 = ok

										if not ok2 then
											ok2 = workspace.Enemies:FindFirstChild("Domenic Soul")
										end

										local ok3 = ok2

										if not ok3 then
											ok3 = not not workspace.Enemies:FindFirstChild("Posessed Mummy")
										end

										if ok3 then
											for _, child in pairs(workspace.Enemies:GetChildren()) do
												if (child.Name == "Reborn Skeleton" or child.Name == "Living Zombie" or child.Name == "Demonic Soul" or child.Name == "Posessed Mummy") and child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child:FindFirstChild("Humanoid").Health > 0 then
													while true do
														task.wait()
														t9.Kill(child, _G.CDK_YM)

														if _G.CDK_YM then
															if child.Humanoid.Health <= 0 or not child.Parent then
																break
															end
														else
															break
														end
													end
												end
											end
										else
											_tp(CFrame.new(-9515.2255859375, 164.0062255859375, 5785.38330078125))
										end
									end
								else
									_tp(replicated:FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame)
								end
							end
						end
					end
				end
			end)
		end
	end)
end

Q = GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_Tushita_CDK", {
	Text = "Auto Tushita CDK",
	Default = false,
	Callback = function(p176)
		_G.CDK_TS = p176
	end
})
spawn(function()
	while wait() do
		pcall(function()
			if _G.CDK_TS then
				if tostring(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then
					wait(0.7)
					replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")
					wait(0.3)
					replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
				elseif replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Finished == nil then
					replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
				elseif replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Finished == false then
					if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == -3 then
						QuestTushita_1 = true
						QuestTushita_2 = false
						QuestTushita_3 = false

						while true do
							wait()
							_tp(CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875))

							if not ((CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3) and _G.CDK_TS then
								if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 1 then
									break
								end
							else
								break
							end
						end

						if (CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							wait(0.7)
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check")
							wait(0.5)
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
						end

						wait(1)

						while true do
							wait()
							_tp(CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125))

							if not ((CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3) and _G.CDK_TS then
								if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 1 then
									break
								end
							else
								break
							end
						end

						if (CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							wait(0.7)
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check")
							wait(0.5)
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
						end

						wait(1)

						while true do
							wait()
							_tp(CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625))

							if not ((CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3) and _G.CDK_TS then
								if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 1 then
									break
								end
							else
								break
							end
						end

						if (CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							wait(0.7)
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check")
							wait(0.5)
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
						end

						wait(1)
					elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == -4 then
						QuestTushita_1 = false
						QuestTushita_2 = true
						QuestTushita_3 = false

						while true do
							wait()
							_G.AutoRaidCastle = true

							if _G.CDK_TS then
								if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 2 then
									break
								end
							else
								break
							end
						end

						_G.AutoRaidCastle = false
					elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == -5 then
						QuestTushita_1 = false
						QuestTushita_2 = false
						QuestTushita_3 = true

						if workspace.Enemies:FindFirstChild("Cake Queen") then
							for _, child in pairs(workspace.Enemies:GetChildren()) do
								if child.Name == "Cake Queen" and child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") and child.Humanoid.Health > 0 then
									while true do
										wait()
										t9.Kill(child, _G.CDK_TS)

										if _G.CDK_TS and child.Parent and not (child.Humanoid.Health <= 0) then
											if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 3 then
												break
											end
										else
											break
										end
									end
								end
							end
						else
							local ok = not replicated:FindFirstChild("Cake Queen")

							if not ok then
								ok = not (replicated:FindFirstChild("Cake Queen").Humanoid.Health > 0)
							end

							if ok then
								if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.HeavenlyDimension.Spawn.Position).Magnitude <= 1000 then
									for k in pairs(workspace.Map.HeavenlyDimension.Exit:GetChildren()) do
										Ex = k
									end

									if Ex == 2 then
										while true do
											wait()
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.HeavenlyDimension.Exit.CFrame

											if _G.CDK_TS then
												if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 3 then
													break
												end
											else
												break
											end
										end
									end

									repeat
										wait()

										repeat
											wait()
											_tp(CFrame.new(-22529.6171875, 5275.77392578125, 3873.5712890625))

											for _, descendant in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
												if descendant:IsA("ProximityPrompt") then
													fireproximityprompt(descendant)
												end
											end
										until (CFrame.new(-22529.6171875, 5275.77392578125, 3873.5712890625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5

										wait(2)
										_G.DoneT1 = true
									until not _G.CDK_TS or _G.DoneT1

									repeat
										wait()

										repeat
											wait()
											_tp(CFrame.new(-22637.291015625, 5281.365234375, 3749.28857421875))

											for _, descendant in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
												if descendant:IsA("ProximityPrompt") then
													fireproximityprompt(descendant)
												end
											end
										until (CFrame.new(-22637.291015625, 5281.365234375, 3749.28857421875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5

										wait(2)
										_G.DoneT2 = true
									until _G.DoneT2 or _G.CDK_TS == false

									repeat
										wait()

										repeat
											task.wait()
											_tp(CFrame.new(-22791.14453125, 5277.16552734375, 3764.570068359375))

											for _, descendant in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
												if descendant:IsA("ProximityPrompt") then
													fireproximityprompt(descendant)
												end
											end
										until (CFrame.new(-22791.14453125, 5277.16552734375, 3764.570068359375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5

										wait(2)
										_G.DoneT3 = true
									until _G.DoneT3 or _G.CDK_TS == false

									for _, child in pairs(workspace.Enemies:GetChildren()) do
										if (child:FindFirstChild("HumanoidRootPart").Position - CFrame.new(-22695.7012, 5270.93652, 3814.42847, 0.11794927, 3.32185834e-08, 0.99301964, -8.73070718e-08, 1, -2.30819008e-08, -0.99301964, -8.3975138e-08, 0.11794927).Position).Magnitude <= 300 and child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child:FindFirstChild("Humanoid").Health > 0 then
											while true do
												wait()
												t9.Kill(child, _G.CDK_TS)

												if _G.CDK_TS then
													if child.Humanoid.Health <= 0 or not child.Parent then
														break
													end
												else
													break
												end
											end
										end
									end
								end
							else
								_tp(replicated:FindFirstChild("Cake Queen").HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
							end
						end
					end
				end
			end
		end)
	end
end)
GRP_Quests_True_Triple_Katana_Sword = t15.Quests:AddLeftGroupbox("True Triple Katana Sword")

do
	GRP_Quests_True_Triple_Katana_Sword:AddButton({
		Text = "Buy Legendary Sword",
		Func = function()
			for i = 1, 3 do
				replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", tostring(i))
				task.wait(0.3)
			end
		end
	})
end

do
	GRP_Quests_True_Triple_Katana_Sword:AddButton({
		Text = "Buy True Triple Katana Sword",
		Func = function()
			replicated.Remotes.CommF_:InvokeServer("MysteriousMan", "2")
		end
	})
end

do
	Q = GRP_Quests_True_Triple_Katana_Sword:AddToggle("Tween_to_Legendary_Sword_Dealer", {
		Text = "Tween to Legendary Sword Dealer",
		Default = false,
		Callback = function(p177)
			_G.Tp_LgS = p177
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.Tp_LgS then
			pcall(function()
				for _, child in pairs(replicated.NPCs:GetChildren()) do
					if child.Name == "Legendary Sword Dealer " then
						_tp(child.HumanoidRootPart.CFrame)
					end
				end
			end)
		end
	end
end)
GRP_Quests_Pole_God_Enal_s = t15.Quests:AddLeftGroupbox("Pole / God Enal's")
Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Pole_V1", {
	Text = "Auto Pole V1",
	Default = false,
	Callback = function(p178)
		_G.AutoPole = p178
	end
})
spawn(function()
	while wait(Sec) do
		if _G.AutoPole then
			pcall(function()
				local v843 = GetConnectionEnemies("Thunder God")

				if v843 then
					while true do
						task.wait()
						t9.Kill(v843, _G.AutoPole)

						if _G.AutoPole then
							if not v843.Parent or v843.Humanoid.Health <= 0 then
								break
							end
						else
							break
						end
					end
				else
					_tp(CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188))
				end
			end)
		end
	end
end)
Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Pole_V2_[Beta]", {
	Text = "Auto Pole V2 [Beta]",
	Default = false,
	Callback = function(p179)
		_G.AutoPoleV2 = p179
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.AutoPoleV2 then
					if not GetBP("Pole (1st Form)") then
						replicated.Remotes.CommF_:InvokeServer("LoadItem", "Pole (1st Form)")
					end

					if not GetBP("Pole (2nd Form)") then
						replicated.Remotes.CommF_:InvokeServer("LoadItem", "Pole (2nd Form)")
					end

					if GetBP("Pole (1st Form)") and GetBP("Pole (1st Form)").Level.Value <= 179 then
						_G.Level = true
					elseif GetBP("Pole (1st Form)") and GetBP("Pole (1st Form)").Level.Value >= 180 then
						_G.Level = false
					end

					if not GetBP("Rumble Fruit") then
						return
					end

					local ok2 = not GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("Z")

					if not ok2 then
						ok2 = not GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("X")
					end

					local ok3 = ok2

					if not ok3 then
						ok3 = not GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("C")
					end

					local ok4 = ok3

					if not ok4 then
						ok4 = not GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("V")
					end

					local ok5 = ok4

					if not ok5 then
						ok5 = not GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("F")
					end

					if ok5 then
						local ok = replicated.Remotes.CommF_:InvokeServer("Awakener", "Check") == nil

						if not ok then
							ok = replicated.Remotes.CommF_:InvokeServer("Awakener", "Check") == 0
						end

						if ok then
							_G.SelectChip = "Rumble"

							local response = replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)

							if response then
								response:Stop()
							end

							_G.Raiding = true
							_G.Auto_Awakener = true
						end
					else
						_G.SelectChip = nil
						_G.Raiding = false
						_G.Auto_Awakener = false

						if plr.Data.Fragments.Value >= 5000 then
							replicated.Remotes.CommF_:InvokeServer("Thunder God", "Talk")
							wait(Sec)
							replicated.Remotes.CommF_:InvokeServer("Thunder God", "Sure")
						end
					end
				end
			end)
		end
	end)
end

GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Saw_Sword", {
	Text = "Auto Saw Sword",
	Default = false,
	Callback = function(p180)
		_G.AutoSaw = p180
	end
})
spawn(function()
	while wait(0.2) do
		pcall(function()
			if _G.AutoSaw then
				local v850 = GetConnectionEnemies("The Saw")

				if v850 then
					while true do
						task.wait()
						t9.Kill(v850, _G.AutoSaw)

						if _G.AutoSaw == false then
							break
						elseif v850.Humanoid.Health <= 0 then
							break
						end
					end
				else
					_tp(CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906))
				end
			end
		end)
	end
end)

do
	Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Saber_Sword", {
		Text = "Auto Saber Sword",
		Default = false,
		Callback = function(p181)
			_G.AutoSaber = p181
		end
	})
end

spawn(function()
	while wait(0.2) do
		pcall(function()
			if _G.AutoSaber and plr.Data.Level.Value >= 200 then
				if not plr.Backpack:FindFirstChild("Saber") then
					if not plr.Character:FindFirstChild("Saber") then
						if workspace.Map.Jungle.Final.Part.Transparency ~= 0 then
							local ok2 = workspace.Enemies:FindFirstChild("Saber Expert")

							if not ok2 then
								ok2 = not not replicated:FindFirstChild("Saber Expert")
							end

							if ok2 then
								for _, child in pairs(workspace.Enemies:GetChildren()) do
									if child.Name == "Saber Expert" and t9.Alive(child) then
										while true do
											task.wait()
											t9.Kill(child, _G.AutoSaber)

											if child.Humanoid.Health <= 0 then
												break
											elseif _G.AutoSaber == false then
												break
											end
										end

										if child.Humanoid.Health <= 0 then
											replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic")
										end
									end
								end
							else
								_tp(CFrame.new(-1401.85046, 29.9773273, 8.81916237, 0.85820812, 8.76083845e-08, 0.513301849, -8.55007443e-08, 1, -2.77243419e-08, -0.513301849, -2.00944328e-08, 0.85820812))
							end
						elseif workspace.Map.Jungle.QuestPlates.Door.Transparency == 0 then
							if (CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 100 then
								_tp(plr.Character.HumanoidRootPart.CFrame)
								wait(0.5)
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate1.Button.CFrame
								wait(0.5)
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate2.Button.CFrame
								wait(0.5)
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate3.Button.CFrame
								wait(0.5)
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate4.Button.CFrame
								wait(0.5)
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate5.Button.CFrame
								wait(0.5)
							else
								_tp(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279))
							end
						elseif workspace.Map.Desert.Burn.Part.Transparency == 0 then
							if plr.Backpack:FindFirstChild("Torch") then
								EquipWeapon("Torch")
								firetouchinterest(plr.Character.Torch.Handle, workspace.Map.Desert.Burn.Fire, 0)
								firetouchinterest(plr.Character.Torch.Handle, workspace.Map.Desert.Burn.Fire, 1)
								_tp(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-09, 0.761243105, -5.70652914e-10, 1, 1.20584542e-09, -0.761243105, 3.47544882e-10, -0.648466587))
							else
								if plr.Character:FindFirstChild("Torch") then
									EquipWeapon("Torch")
									firetouchinterest(plr.Character.Torch.Handle, workspace.Map.Desert.Burn.Fire, 0)
									firetouchinterest(plr.Character.Torch.Handle, workspace.Map.Desert.Burn.Fire, 1)
									_tp(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-09, 0.761243105, -5.70652914e-10, 1, 1.20584542e-09, -0.761243105, 3.47544882e-10, -0.648466587))

									return
								end

								_tp(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408))
							end
						elseif replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan") ~= 0 then
							replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "GetCup")
							wait(0.5)
							EquipWeapon("Cup")
							wait(0.5)
							replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "FillCup", plr.Character.Cup)
							wait(Sec)
							replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan")
						elseif replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == nil then
							replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
						elseif replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 0 then
							local ok = workspace.Enemies:FindFirstChild("Mob Leader")

							if not ok then
								ok = not not replicated:FindFirstChild("Mob Leader")
							end

							if ok then
								_tp(CFrame.new(-2967.59521, -4.91089821, 5328.70703, 0.342208564, -0.0227849055, 0.939347804, 0.0251603816, 0.999569714, 0.0150796166, -0.939287126, 0.0184739735, 0.342634559))

								for _, child in pairs(workspace.Enemies:GetChildren()) do
									if child.Name == "Mob Leader" and t9.Alive(child) then
										while true do
											task.wait()
											t9.Kill(child, _G.AutoSaber)

											if child.Humanoid.Health <= 0 then
												break
											elseif _G.AutoSaber == false then
												break
											end
										end
									end
								end
							end
						elseif replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
							replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
							EquipWeapon("Relic")
							_tp(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-09, 0.481375456, 2.53851997e-08, 1, -5.79995607e-08, -0.481375456, 6.30572643e-08, 0.876514494))
						end
					end
				end
			end
		end)
	end
end)
Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Cybrog", {
	Text = "Auto Cybrog",
	Default = false,
	Callback = function(p182)
		_G.AutoColShad = p182
	end
})

do
	spawn(function()
		while wait(0.2) do
			if _G.AutoColShad then
				pcall(function()
					local Cyborg = GetConnectionEnemies("Cyborg")

					if Cyborg then
						while true do
							task.wait()
							t9.Kill(Cyborg, _G.AutoColShad)

							if _G.AutoColShad == false then
								break
							elseif not Cyborg.Parent or Cyborg.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813))
					end
				end)
			end
		end
	end)
end

do
	Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Usoap's_Hat", {
		Text = "Auto Usoap's Hat",
		Default = false,
		Callback = function(p183)
			_G.AutoGetUsoap = p183
		end
	})
end

do
	spawn(function()
		while task.wait(Sec) do
			pcall(function()
				if _G.AutoGetUsoap then
					for _, child in pairs(workspace.Characters:GetChildren()) do
						if child.Name ~= plr.Name and child.Humanoid.Health > 0 and child:FindFirstChild("HumanoidRootPart") and child.Parent and (Root.Position - child.HumanoidRootPart.Position).Magnitude <= 230 then
							while true do
								task.wait()
								EquipWeapon(_G.SelectWeapon)
								_tp(child.HumanoidRootPart.CFrame * CFrame.new(1, 1, 2))

								if _G.AutoGetUsoap == false then
									break
								elseif child.Humanoid.Health <= 0 or not child.Parent or not child:FindFirstChild("HumanoidRootPart") or not child:FindFirstChild("Humanoid") then
									break
								end
							end
						end
					end
				end
			end)
		end
	end)
end

Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Bisento_V2", {
	Text = "Auto Bisento V2",
	Default = false,
	Callback = function(p184)
		_G.Greybeard = p184
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.Greybeard then
				pcall(function()
					if GetWP("Bisento") then
						if GetWP("Bisento") then
							replicated.Remotes.CommF_:InvokeServer("LoadItem", "Bisento")

							local Greybeard = GetConnectionEnemies("Greybeard")

							if Greybeard then
								while true do
									wait()
									t9.Kill(Greybeard, _G.Greybeard)

									if _G.Greybeard == false then
										break
									elseif not Greybeard.Parent or Greybeard.Humanoid.Health <= 0 then
										break
									end
								end
							else
								_tp(CFrame.new(-5023.38330078125, 28.652032852172852, 4332.3818359375))
							end
						end
					else
						replicated.Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
					end
				end)
			end
		end
	end)
end

Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Warden_Sword", {
	Text = "Auto Warden Sword",
	Default = false,
	Callback = function(p185)
		_G.WardenBoss = p185
	end
})

do
	spawn(function()
		while wait(0.1) do
			if _G.WardenBoss then
				pcall(function()
					local v861 = GetConnectionEnemies("Chief Warden")

					if v861 then
						while true do
							wait()
							t9.Kill(v861, _G.WardenBoss)

							if _G.WardenBoss == false then
								break
							elseif not v861.Parent or v861.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939))
					end
				end)
			end
		end
	end)
end

do
	Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Marine_Coat", {
		Text = "Auto Marine Coat",
		Default = false,
		Callback = function(p186)
			_G.MarinesCoat = p186
		end
	})
end

do
	spawn(function()
		while wait(0.1) do
			if _G.MarinesCoat then
				pcall(function()
					local v862 = GetConnectionEnemies("Vice Admiral")

					if v862 then
						while true do
							wait()
							t9.Kill(v862, _G.MarinesCoat)

							if _G.MarinesCoat == false then
								break
							elseif not v862.Parent or v862.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375))
					end
				end)
			end
		end
	end)
end

Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Swan_Coat", {
	Text = "Auto Swan Coat",
	Default = false,
	Callback = function(p187)
		_G.SwanCoat = p187
	end
})

do
	spawn(function()
		while wait(0.1) do
			if _G.SwanCoat then
				pcall(function()
					local Swan = GetConnectionEnemies("Swan")

					if Swan then
						while true do
							wait()
							t9.Kill(Swan, _G.SwanCoat)

							if _G.SwanCoat == false then
								break
							elseif not Swan.Parent or Swan.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812))
					end
				end)
			end
		end
	end)
end

GRP_Quests_Rengoku_Sword = t15.Quests:AddLeftGroupbox("Rengoku Sword")
Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Rengoku_Sword", {
	Text = "Auto Rengoku Sword",
	Default = false,
	Callback = function(p188)
		_G.IceBossRen = p188
	end
})

do
	spawn(function()
		pcall(function()
			while wait(0.1) do
				if _G.IceBossRen then
					local v864 = GetConnectionEnemies("Awakened Ice Admiral")

					if v864 then
						while true do
							task.wait()
							t9.Kill(v864, _G.IceBossRen)

							if _G.IceBossRen == false then
								break
							elseif not v864.Parent or v864.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813))
					end
				end
			end
		end)
	end)
end

do
	Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Key_Rengoku", {
		Text = "Auto Key Rengoku",
		Default = false,
		Callback = function(p189)
			_G.KeysRen = p189
		end
	})
end

spawn(function()
	while wait(0.1) do
		pcall(function()
			if _G.KeysRen then
				if plr.Backpack:FindFirstChild(t1[3]) then
					EquipWeapon(t1[3])
					wait(0.1)
					_tp(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))
				else
					if plr.Character:FindFirstChild(t1[3]) then
						EquipWeapon(t1[3])
						wait(0.1)
						_tp(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))

						return
					end

					local v865 = GetConnectionEnemies(t1)

					if v865 then
						while true do
							task.wait()
							t9.Kill(v865, _G.KeysRen)

							if plr.Backpack:FindFirstChild(t1[3]) then
								break
							elseif _G.KeysRen == false or not v865.Parent or v865.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(5439.716796875, 84.420944213867, -6715.1635742188))
					end
				end
			end
		end)
	end
end)

do
	Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Dragon_Trident", {
		Text = "Auto Dragon Trident",
		Default = false,
		Callback = function(p190)
			_G.AutoTridentW2 = p190
		end
	})
end

spawn(function()
	while wait(0.1) do
		pcall(function()
			if _G.AutoTridentW2 then
				local v866 = GetConnectionEnemies("Tide Keeper")

				if v866 then
					while true do
						task.wait()
						t9.Kill(v866, _G.AutoTridentW2)

						if _G.AutoTridentW2 == false then
							break
						elseif not v866.Parent or v866.Humanoid.Health <= 0 then
							break
						end
					end
				else
					_tp(CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188))
				end
			end
		end)
	end
end)
Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Long_Sword", {
	Text = "Auto Long Sword",
	Default = false,
	Callback = function(p191)
		_G.LongsWord = p191
	end
})
spawn(function()
	while wait(0.1) do
		pcall(function()
			if _G.LongsWord then
				local Diamond = GetConnectionEnemies("Diamond")

				if Diamond then
					while true do
						task.wait()
						t9.Kill(Diamond, _G.LongsWord)

						if _G.LongsWord == false then
							break
						elseif not Diamond.Parent or Diamond.Humanoid.Health <= 0 then
							break
						end
					end
				else
					_tp(CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407))
				end
			end
		end)
	end
end)
Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Black_Spikey", {
	Text = "Auto Black Spikey",
	Default = false,
	Callback = function(p192)
		_G.BlackSpikey = p192
	end
})
spawn(function()
	while wait(0.1) do
		if _G.BlackSpikey then
			pcall(function()
				local Jeremy = GetConnectionEnemies("Jeremy")

				if Jeremy then
					while true do
						wait()
						t9.Kill(Jeremy, _G.BlackSpikey)

						if _G.BlackSpikey == false then
							break
						elseif not Jeremy.Parent or Jeremy.Humanoid.Health <= 0 then
							break
						end
					end
				else
					_tp(CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109))
				end
			end)
		end
	end
end)

do
	Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Dark_Blade_V3", {
		Text = "Auto Dark Blade V3",
		Default = false,
		Callback = function(p193)
			_G.DarkBladev3 = p193
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.DarkBladev3 and World2 then
				if not GetBP("Dark Blade") then
					replicated.Remotes.CommF_:InvokeServer("LoadItem", "Dark Blade")
				end

				if not (GetBP("Fist of Darkness") > 1) then
					_G.AutoFarmChest = true
				elseif not workspace.Enemies:FindFirstChild("Darkbeard") then
					_tp(CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531))
				elseif GetConnectionEnemies("Darkbeard") then
					if GetBP("Fist of Darkness") >= 1 then
						while true do
							wait()
							_tp(CFrame.new(-5719.36376953125, 48.505905151367188, -782.9759521484375))

							if _G.DarkBladev3 then
								if Root.Position == CFrame.new(-5719.36376953125, 48.505905151367188, -782.9759521484375).Position then
									break
								end
							else
								break
							end
						end

						fireclickdetector(workspace.Map.GraveIsland.Mountain.Rocks.Button.ClickDetector)
					end
				end
			end
		end)
	end
end)
Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Midnight_Blade", {
	Text = "Auto Midnight Blade",
	Default = false,
	Callback = function(p194)
		_G.AutoEcBoss = p194
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.AutoEcBoss then
				if GetM("Ectoplasm") >= 99 then
					replicated.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 3)
				elseif GetM("Ectoplasm") <= 99 then
					local v869 = GetConnectionEnemies("Cursed Captain")

					if v869 then
						while true do
							wait()
							t9.Kill(v869, _G.AutoEcBoss)

							if _G.AutoEcBoss then
								if not v869.Parent or v869.Humanoid.Health <= 0 then
									break
								end
							else
								break
							end
						end
					else
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
						wait(0.5)
						_tp(CFrame.new(916.928589, 181.092773, 33422))
					end
				end
			end
		end)
	end
end)
Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Darkbeard", {
	Text = "Auto Darkbeard",
	Default = false,
	Callback = function(p195)
		_G.Auto_Def_DarkCoat = p195
	end
})

do
	spawn(function()
		while wait(0.1) do
			if _G.Auto_Def_DarkCoat then
				pcall(function()
					local ok = not GetBP("Fist of Darkness")

					if not ok then
						ok = workspace.Enemies:FindFirstChild("Darkbeard")
					end

					if not ok then
						_tp(CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531))
					elseif GetConnectionEnemies("Darkbeard") then
						local Darkbeard = GetConnectionEnemies("Darkbeard")

						if Darkbeard then
							while true do
								wait()
								t9.Kill(Darkbeard, _G.Auto_Def_DarkCoat)

								if _G.Auto_Def_DarkCoat == false then
									break
								elseif not Darkbeard.Parent or Darkbeard.Humanoid.Helath <= 0 then
									break
								end
							end
						end
					elseif not (GetBP("Fist of Darkness") or GetConnectionEnemies("Darkbeard")) then
						while true do
							wait(0.1)
							_G.AutoFarmChest = true

							if _G.Auto_Def_DarkCoat then
								if GetBP("Fist of Darkness") or GetConnectionEnemies("Darkbeard") then
									break
								end
							else
								break
							end
						end

						_G.AutoFarmChest = false
					end
				end)
			end
		end
	end)
end

do
	Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Unlocked_DonSwan", {
		Text = "Auto Unlocked DonSwan",
		Default = false,
		Callback = function(p196)
			_G.Auto_DonAcces = p196
		end
	})
end

spawn(function()
	while wait(0.1) do
		if _G.Auto_DonAcces then
			pcall(function()
				if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil and plr.Data.Level.Value >= 1500 then
					FruitPrice = {}
					FruitStore = {}

					local next_ = next
					local response, v874 = replicated:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits")

					for _, v1 in next_, response, v874 do
						if v1.Price >= 1000000 then
							table.insert(FruitPrice, v1.Name)
						end
					end

					for _, v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventoryFruits")) do
						for k, v2 in pairs(v1) do
							if k == "Name" then
								table.insert(FruitStore, v2)
							end
						end

						replicated.Remotes.CommF_:InvokeServer("Cousin", "Buy")

						for _, v2 in pairs(FruitPrice) do
							for _, v3 in pairs(FruitStore) do
								if v2 == v3 then
									if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
										_G.StoreF = false

										if plr.Backpack:FindFirstChild(FruitStore) then
											replicated.Remotes.CommF_:InvokeServer("TalkTrevor", "1")
											replicated.Remotes.CommF_:InvokeServer("TalkTrevor", "2")
											replicated.Remotes.CommF_:InvokeServer("TalkTrevor", "3")
										else
											replicated.Remotes.CommF_:InvokeServer("LoadFruit", tostring(v2))
										end
									end
								end
							end
						end

						if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess ~= nil then
							_G.StoreF = true
							_G.Auto_DonAcces = false
						end
					end
				end
			end)
		end
	end
end)

do
	Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Swan_Glasses", {
		Text = "Auto Swan Glasses",
		Default = false,
		Callback = function(p197)
			_G.Auto_SwanGG = p197
		end
	})
end

do
	spawn(function()
		while wait(0.2) do
			if _G.Auto_SwanGG then
				pcall(function()
					local v885 = GetConnectionEnemies("Don Swan")

					if v885 then
						while true do
							wait()
							t9.Kill(v885, _G.Auto_SwanGG)

							if _G.Auto_SwanGG == false then
								break
							elseif not v885.Parent or v885.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875))
					end
				end)
			end
		end
	end)
end

GRP_Quests_Cavender_Twin_Hooks_Bigmom = t15.Quests:AddLeftGroupbox("Cavender + Twin Hooks + Bigmom")

do
	Q = GRP_Quests_Cavender_Twin_Hooks_Bigmom:AddToggle("Auto_Bigmom", {
		Text = "Auto Bigmom",
		Default = false,
		Callback = function(p198)
			_G.AutoBigmom = p198
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.AutoBigmom then
				pcall(function()
					local v886 = GetConnectionEnemies("Cake Queen")

					if v886 then
						while true do
							task.wait()
							t9.Kill(v886, _G.AutoBigmom)

							if _G.AutoBigmom then
								if not v886.Parent or v886.Humanoid.Health <= 0 then
									break
								end
							else
								break
							end
						end
					else
						_tp(CFrame.new(-709.31329345703125, 381.6005859375, -11011.396484375))
					end
				end)
			end
		end
	end)
end

do
	Q = GRP_Quests_Cavender_Twin_Hooks_Bigmom:AddToggle("Auto_Canvendish_Sword", {
		Text = "Auto Canvendish Sword",
		Default = false,
		Callback = function(p199)
			_G.Auto_Cavender = p199
			ender = v
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Cavender then
				local v887 = GetConnectionEnemies("Beautiful Pirate")

				if v887 then
					while true do
						wait()
						t9.Kill(v887, _G.Auto_Cavender)

						if _G.Auto_Cavender then
							if v887.Humanoid.Health <= 0 then
								break
							end
						else
							break
						end
					end
				else
					_tp(CFrame.new(5283.609375, 22.56223487854, -110.78285217285))
				end
			end
		end)
	end
end)

do
	Q = GRP_Quests_Cavender_Twin_Hooks_Bigmom:AddToggle("Auto_Twin_Hooks", {
		Text = "Auto Twin Hooks",
		Default = false,
		Callback = function(p200)
			_G.TwinHook = p200
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.TwinHook then
					local v888 = GetConnectionEnemies("Captain Elephant")

					if v888 then
						while true do
							wait()
							t9.Kill(v888, _G.TwinHook)

							if _G.TwinHook then
								if v888.Humanoid.Health <= 0 then
									break
								end
							else
								break
							end
						end
					else
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
						wait(0.2)
						_tp(CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125))
					end
				end
			end)
		end
	end)
end

Q = GRP_Quests_Cavender_Twin_Hooks_Bigmom:AddToggle("Auto_Serpent_Bow", {
	Text = "Auto Serpent Bow",
	Default = false,
	Callback = function(p201)
		_G.AutoSerpentBow = p201
	end
})
spawn(function()
	while wait(Sec) do
		if _G.AutoSerpentBow then
			local v889 = GetConnectionEnemies("Hydra Leader")

			if v889 then
				while true do
					wait()
					t9.Kill(v889, _G.AutoSerpentBow)

					if _G.AutoSerpentBow then
						if not v889.Parent or v889.Humanoid.Health <= 0 then
							break
						end
					else
						break
					end
				end
			else
				_tp(CFrame.new(5821.89794921875, 1019.0950927734375, -73.719230651855469))
			end
		end
	end
end)

do
	Q = GRP_Quests_Cavender_Twin_Hooks_Bigmom:AddToggle("Auto_Lei_Accessory", {
		Text = "Auto Lei Accessory",
		Default = false,
		Callback = function(p202)
			_G.AutoKilo = p202
		end
	})
end

spawn(function()
	while wait(0.2) do
		if _G.AutoKilo then
			pcall(function()
				local v890 = GetConnectionEnemies("Kilo Admiral")

				if v890 then
					while true do
						task.wait()
						t9.Kill(v890, _G.AutoKilo)

						if _G.AutoKilo then
							if not v890.Parent or v890.Humanoid.Health <= 0 then
								break
							end
						else
							break
						end
					end
				else
					_tp(CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125))
				end
			end)
		end
	end
end)
GRP_Quests_Buso_Aura_Colours = t15.Quests:AddLeftGroupbox("Buso/Aura Colours")
Q = GRP_Quests_Buso_Aura_Colours:AddToggle("Auto_Teleport_Barista_Cousin", {
	Text = "Auto Teleport Barista Cousin",
	Default = false,
	Callback = function(p203)
		_G.Tp_MasterA = p203
	end
})

do
	spawn(function()
		while wait() do
			if _G.Tp_MasterA then
				pcall(function()
					for _, child in pairs(replicated.NPCs:GetChildren()) do
						if child.Name == "Barista Cousin" then
							_tp(child.HumanoidRootPart.CFrame)
						end
					end
				end)
			end
		end
	end)
end

do
	GRP_Quests_Buso_Aura_Colours:AddButton({
		Text = "Buy Buso Colors",
		Func = function()
			replicated.Remotes.CommF_:InvokeServer("ColorsDealer", "2")
		end
	})
end

Q = GRP_Quests_Buso_Aura_Colours:AddToggle("Auto_Rainbow_Colors", {
	Text = "Auto Rainbow Colors",
	Default = false,
	Callback = function(p204)
		_G.Auto_Rainbow_Haki = p204
	end
})
spawn(function()
	pcall(function()
		while wait(Sec) do
			if _G.Auto_Rainbow_Haki then
				if plr.PlayerGui.Main.Quest.Visible == false then
					if _G.GetQFast then
						if plr.PlayerGui.Main.Quest.Visible == false then
							replicated.Remotes.CommF_:InvokeServer("HornedMan", "Bet")
						end
					else
						Rainbow1 = CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875)

						if plr.Character.HumanoidRootPart.CFrame ~= Rainbow1 then
							_tp(Rainbow1)
						elseif plr.Character.HumanoidRootPart.CFrame == Rainbow1 then
							wait(1)
							replicated.Remotes.CommF_:InvokeServer("HornedMan", "Bet")
						end
					end
				elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
					local Stone = GetConnectionEnemies("Stone")

					if Stone then
						while true do
							wait()
							t9.Kill(Stone, _G.Auto_Rainbow_Haki)

							if _G.Auto_Rainbow_Haki == false then
								break
							elseif Stone.Humanoid.Health <= 0 or not Stone.Parent or plr.PlayerGui.Main.Quest.Visible == false then
								break
							end
						end
					else
						_tp(CFrame.new(-1086.11621, 38.8425903, 6768.71436, 0.0231462717, -0.592676699, 0.805107772, 2.03251839e-05, 0.805323839, 0.592835128, -0.999732077, -0.0137055516, 0.0186523199))
					end
				elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Hydra Leader") then
					local v894 = GetConnectionEnemies("Hydra Leader")

					if v894 then
						while true do
							task.wait()
							t9.Kill(v894, _G.Auto_Rainbow_Haki)

							if _G.Auto_Rainbow_Haki == false then
								break
							elseif v894.Humanoid.Health <= 0 or not v894.Parent or plr.PlayerGui.Main.Quest.Visible == false then
								break
							end
						end
					else
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625))

						local vector3 = Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625)
						local cFrame = CFrame.new(5821.89794921875, 1019.0950927734375, -73.719230651855469)

						if plr.Character.HumanoidRootPart.CFrame.Position == vector3 then
							_tp(cFrame)
						end
					end
				elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
					local v897 = GetConnectionEnemies("Kilo Admiral")

					if v897 then
						while true do
							task.wait()
							t9.Kill(v897, _G.Auto_Rainbow_Haki)

							if _G.Auto_Rainbow_Haki == false then
								break
							elseif v897.Humanoid.Health <= 0 or not v897.Parent or plr.PlayerGui.Main.Quest.Visible == false then
								break
							end
						end
					else
						_tp(CFrame.new(2877.61743, 423.558685, -7207.31006, -0.989591599, -0, -0.143904909, -0, 1.00000012, -0, 0.143904924, 0, -0.989591479))
					end
				elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
					local v898 = GetConnectionEnemies("Captain Elephant")

					if v898 then
						while true do
							task.wait()
							t9.Kill(v898, _G.Auto_Rainbow_Haki)

							if _G.Auto_Rainbow_Haki == false then
								break
							elseif v898.Humanoid.Health <= 0 or not v898.Parent or plr.PlayerGui.Main.Quest.Visible == false then
								break
							end
						end
					else
						local vector3 = Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375)
						local cFrame = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)

						if plr.Character.HumanoidRootPart.CFrame.Position ~= vector3 then
							replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
						elseif plr.Character.HumanoidRootPart.CFrame.Position == vector3 then
							_tp(cFrame)
						end
					end
				elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
					local v901 = GetConnectionEnemies("Captain Elephant")

					if v901 then
						while true do
							task.wait()
							t9.Kill(v901, _G.Auto_Rainbow_Haki)

							if _G.Auto_Rainbow_Haki == false then
								break
							elseif v901.Humanoid.Health <= 0 or not v901.Parent or plr.PlayerGui.Main.Quest.Visible == false then
								break
							end
						end
					else
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5314.54638671875, 22.562219619750977, -127.06755065917969))
					end
				end
			end
		end
	end)
end)

do
	Q = GRP_Quests_Buso_Aura_Colours:AddToggle("Accept_Rainbow_Quest_Faster", {
		Text = "Accept Rainbow Quest Faster",
		Default = false,
		Callback = function(p205)
			_G.GetQFast = p205
		end
	})
end

GRP_Quests_Instinct_Observation = t15.Quests:AddLeftGroupbox("Instinct / Observation")

do
	Q = GRP_Quests_Instinct_Observation:AddToggle("Auto_Farm_Observation", {
		Text = "Auto Farm Observation",
		Default = false,
		Callback = function(p206)
			_G.obsFarm = p206
		end
	})
end

spawn(function()
	while wait(0.2) do
		pcall(function()
			if _G.obsFarm then
				replicated.Remotes.CommE:FireServer("Ken", true)

				if plr:GetAttribute("KenDodgesLeft") == 0 then
					KenTest = false
				elseif plr:GetAttribute("KenDodgesLeft") > 0 then
					replicated.Remotes.CommE:FireServer("Ken", true)
					KenTest = true
				end
			end
		end)
	end
end)

do
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.obsFarm then
					if World1 then
						if workspace.Enemies:FindFirstChild("Galley Captain") then
							if KenTest then
								while true do
									wait()
									plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)

									if _G.obsFarm == false then
										break
									elseif KenTest == false then
										break
									end
								end
							else
								while true do
									wait()
									plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)

									if _G.obsFarm == false then
										break
									elseif KenTest then
										break
									end
								end
							end
						else
							_tp(CFrame.new(5533.29785, 88.1079102, 4852.3916))
						end
					elseif World2 then
						if workspace.Enemies:FindFirstChild("Lava Pirate") then
							if KenTest then
								while true do
									wait()
									plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)

									if _G.obsFarm == false then
										break
									elseif KenTest == false then
										break
									end
								end
							else
								while true do
									wait()
									plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)

									if _G.obsFarm == false then
										break
									elseif KenTest then
										break
									end
								end
							end
						else
							_tp(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
						end
					elseif World3 then
						if workspace.Enemies:FindFirstChild("Venomous Assailant") then
							if KenTest then
								while true do
									wait()
									_tp(workspace.Enemies:FindFirstChild("Venomous Assailant").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0))

									if _G.obsFarm == false then
										break
									elseif KenTest == false then
										break
									end
								end
							else
								while true do
									wait()
									_tp(workspace.Enemies:FindFirstChild("Venomous Assailant").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))

									if _G.obsFarm == false then
										break
									elseif KenTest then
										break
									end
								end
							end
						else
							_tp(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789))
						end
					end
				end
			end)
		end
	end)
end

Q = GRP_Quests_Instinct_Observation:AddToggle("Auto_Observation_V2", {
	Text = "Auto Observation V2",
	Default = false,
	Callback = function(p207)
		_G.AutoKenVTWO = p207
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.AutoKenVTWO then
				pcall(function()
					local cFrame = CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625)
					local cFrame2 = CFrame.new(-10920.125, 624.20275878906, -10266.995117188)
					local cFrame3 = CFrame.new(-13277.568359375, 370.34185791016, -7821.1572265625)
					local cFrame4 = CFrame.new(-13493.12890625, 318.89553833008, -8373.7919921875)

					if plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat 50 Forest Pirates") then
						local v906 = GetConnectionEnemies("Forest Pirate")

						if v906 then
							while true do
								wait()
								t9.Kill(v906, _G.AutoKenVTWO)

								if _G.AutoKenVTWO then
									if v906.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false then
										break
									end
								else
									break
								end
							end
						else
							_tp(cFrame3)
						end
					elseif plr.PlayerGui.Main.Quest.Visible == true then
						local v907 = GetConnectionEnemies("Captain Elephant")

						if v907 then
							while true do
								wait()
								t9.Kill(v907, _G.AutoKenVTWO)

								if _G.AutoKenVTWO then
									if v907.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false then
										break
									end
								else
									break
								end
							end
						else
							_tp(cFrame4)
						end
					elseif plr.PlayerGui.Main.Quest.Visible == false then
						replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
						wait(0.1)
						replicated.Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
					end

					if replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
						_tp(CFrame.new(-12513.51953125, 340.11373901367188, -9873.048828125))
					end

					local ok5 = not plr.Backpack:FindFirstChild("Fruit Bowl")

					if not ok5 then
						ok5 = not plr.Character:FindFirstChild("Fruit Bowl")
					end

					if ok5 then
						if not GetBP("Fruit Bowl") then
							if not GetBP("Apple") then
								replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))

								for _, descendant in pairs(workspace:GetDescendants()) do
									if descendant.Name == "Apple" then
										descendant.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
										wait()
										firetouchinterest(plr.Character.HumanoidRootPart, descendant.Handle, 0)
										wait()
									end
								end
							elseif GetBP("Banana") then
								if not GetBP("Pineapple") then
									_tp(CFrame.new(-712.8272705078125, 98.577049255371094, 5711.9541015625))

									for _, descendant in pairs(workspace:GetDescendants()) do
										if descendant.Name == "Pineapple" then
											descendant.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
											wait()
											firetouchinterest(plr.Character.HumanoidRootPart, descendant.Handle, 0)
											wait()
										end
									end
								end
							else
								_tp(CFrame.new(2286.0078125, 73.133918762207031, -7159.80908203125))

								for _, descendant in pairs(workspace:GetDescendants()) do
									if descendant.Name == "Banana" then
										descendant.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
										wait()
										firetouchinterest(plr.Character.HumanoidRootPart, descendant.Handle, 0)
										wait()
									end
								end
							end
						end

						local ok2 = not plr.Backpack:FindFirstChild("Banana")

						if not ok2 then
							ok2 = not plr.Backpack:FindFirstChild("Apple")
						end

						local ok3 = ok2

						if not ok3 then
							ok3 = not plr.Backpack:FindFirstChild("Pineapple")
						end

						local ok

						if not ok3 then
							repeat
								wait()
								_tp(cFrame)
								ok = _G.AutoKenVTWO

								if not ok then
									ok = plr.Character.HumanoidRootPart.CFrame == cFrame

									if ok then
										break
									end
								end
							until ok
							-- (could not be recovered)
						end

						if plr:FindFirstChild("Banana") then
							if plr:FindFirstChild("Apple") then
								if plr:FindFirstChild("Pineapple") then
									repeat
										wait()
										_tp(cFrame)
										ok = _G.AutoKenVTWO or plr.Character.HumanoidRootPart.CFrame == cFrame
									until ok

									replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
								end
							end
						end

						local ok4 = plr.Backpack:FindFirstChild("Fruit Bowl")

						if not ok4 then
							ok4 = not not plr.Character:FindFirstChild("Fruit Bowl")
						end

						if ok4 then
							if plr.Character.HumanoidRootPart.CFrame ~= cFrame2 then
								_tp(cFrame2)
							elseif plr.Character.HumanoidRootPart.CFrame == cFrame2 then
								replicated.Remotes.CommF_:InvokeServer("KenTalk2", "Start")
								wait(0.1)
								replicated.Remotes.CommF_:InvokeServer("KenTalk2", "Buy")
							end
						end
					end
				end)
			end
		end
	end)
end

Bartilo = GRP_Quests_Instinct_Observation:AddToggle("Auto_Done_Bartilo_Quest", {
	Text = "Auto Done Bartilo Quest",
	Default = false,
	Callback = function(p208)
		_G.Bartilo_Quest = p208
	end
})

do
	spawn(function()
		while wait(0.1) do
			pcall(function()
				if _G.Bartilo_Quest and Lv >= 850 then
					local Quest = plr.PlayerGui.Main.Quest

					if replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
						_G.Level = false

						if Quest.Visible == true then
							if GetConnectionEnemies("Swan Pirate") then
								local v920 = GetConnectionEnemies(t3)

								if v920 then
									repeat
										task.wait()

										if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirate") then
											t9.Kill(v920, _G.Bartilo_Quest)
										else
											replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
										end
									until _G.Bartilo_Quest == false or not v920.Parent or v920.Humanoid.Health <= 0 or Quest.Visible == false or not v920:FindFirstChild("HumanoidRootPart")
								end
							else
								_tp(CFrame.nee(970.369446, 142.653198, 1217.3667, 0.162079468, -4.85452638e-08, -0.986777723, 1.03357589e-08, 1, -4.74980872e-08, 0.986777723, -2.50063148e-09, 0.162079468))
							end
						else
							while true do
								wait()
								_tp(CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312))

								if (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 20 then
									break
								elseif _G.Bartilo_Quest == false then
									break
								end
							end

							if (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 1 then
								replicated.Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest", 1)
							end
						end
					elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
						_G.Level = false

						local Jeremy = GetConnectionEnemies("Jeremy")

						if Jeremy then
							while true do
								task.wait()
								t9.Kill(Jeremy, _G.Bartilo_Quest)

								if _G.Bartilo_Quest == false then
									break
								elseif not Jeremy.Parent or Jeremy.Humanoid.Health <= 0 or Quest.Visible == false or not Jeremy:FindFirstChild("HumanoidRootPart") then
									break
								end
							end
						else
							_tp(CFrame.new(2158.97412, 449.056244, 705.411682, -0.754199564, -4.17389057e-09, -0.656645238, -4.47752875e-08, 1, 4.50709301e-08, 0.656645238, 6.3393955e-08, -0.754199564))
						end
					elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
						while true do
							wait()
							_tp(CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456))

							if (CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 1 then
								break
							elseif _G.Bartilo_Quest == false then
								break
							end
						end

						wait(0.5)
						plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate1.CFrame
						wait(0.5)
						plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate2.CFrame
						wait(0.5)
						plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate3.CFrame
						wait(0.5)
						plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate4.CFrame
						wait(0.5)
						plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate5.CFrame
						wait(0.5)
						plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate6.CFrame
						wait(0.5)
						plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate7.CFrame
						wait(0.5)
						plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate8.CFrame
						wait(2.5)
					end
				end
			end)
		end
	end)
end

CitizenQ = GRP_Quests_Instinct_Observation:AddToggle("Auto_Done_Citizen_Quest", {
	Text = "Auto Done Citizen Quest",
	Default = false,
	Callback = function(p209)
		_G.CitizenQuest = p209
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.CitizenQuest then
				local ok2 = not (Lv >= 1800)

				if not ok2 then
					ok2 = replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits ~= false
				end

				if ok2 then
					local ok = not (Lv >= 1800)

					if not ok then
						ok = replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss ~= false
					end

					if not ok then
						local v924 = GetConnectionEnemies("Captain Elephant")

						if plr.PlayerGui.Main.Quest.Visible and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and plr.PlayerGui.Main.Quest.Visible == true then
							if v924 then
								while true do
									task.wait()
									t9.Kill(v924, _G.CitizenQuest)

									if _G.CitizenQuest == false then
										break
									elseif v924.Humanoid.Health <= 0 or not v924.Parent or plr.PlayerGui.Main.Quest.Visible == false then
										break
									end
								end
							else
								_tp(CFrame.new(-13374.889648438, 421.27752685547, -8225.208984375))
							end
						else
							_tp(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))

							if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 4 then
								wait(1.5)
								replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
							end
						end
					elseif Lv >= 1800 then
						if replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
							_tp(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))
						end
					end
				elseif string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and plr.PlayerGui.Main.Quest.Visible == true then
					local v925 = GetConnectionEnemies("Forest Pirate")

					if v925 then
						while true do
							task.wait()
							t9.Kill(v925, _G.CitizenQuest)

							if _G.CitizenQuest == false then
								break
							elseif not v925.Parent or v925.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false then
								break
							end
						end
					else
						_tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
					end
				else
					_tp(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))

					if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125) - plr.Character.HumanoidRootPart.Position).Magnitude <= 30 then
						wait(1.5)
						replicated.Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
					end
				end
			end
		end)
	end
end)
Q = GRP_Quests_Instinct_Observation:AddToggle("Auto_Training_Dummy", {
	Text = "Auto Training Dummy",
	Default = false,
	Callback = function(p210)
		_G.DummyMan = p210
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.DummyMan then
				pcall(function()
					if plr.PlayerGui.Main.Quest.Visible == false then
						replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack({ "ArenaTrainer" }))
					else
						local v926 = GetConnectionEnemies("Training Dummy")

						if v926 then
							while true do
								wait()
								t9.Kill(v926, _G.DummyMan)

								if _G.DummyMan then
									if not v926.Parent or v926.Humanoid.Health <= 0 then
										break
									end
								else
									break
								end
							end
						else
							_tp(CFrame.new(3688.005126953125, 12.746943473815918, 170.20953369140625))
						end
					end
				end)
			end
		end
	end)
end

GRP_Quests_Fighting_Melee_Styles = t15.Quests:AddLeftGroupbox("Fighting Melee Styles")
SuperHuman = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_Superhuman", {
	Text = "Auto Superhuman",
	Default = false,
	Callback = function(p211)
		_G.Auto_SuperHuman = p211
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_SuperHuman then
					local Value = plr.Data.Beli.Value
					local Value2 = plr.Data.Fragments.Value

					if plr:FindFirstChild("WeaponAssetCache") and not GetBP("Superhuman") then
						if GetBP("Black Leg") then
							if GetBP("Black Leg") and GetBP("Black Leg").Level.Value < 299 then
								_G.Level = true
							elseif GetBP("Black Leg") and GetBP("Black Leg").Level.Value >= 300 then
								_G.Level = false
							end
						elseif Value >= 150000 then
							replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg")
						end

						if GetBP("Electro") then
							if GetBP("Electro") and GetBP("Electro").Level.Value < 299 then
								_G.Level = true
							elseif GetBP("Electro") and GetBP("Electro").Level.Value >= 300 then
								_G.Level = false
							end
						elseif Value >= 500000 then
							replicated.Remotes.CommF_:InvokeServer("BuyElectro")
						end

						if GetBP("Fishman Karate") then
							if GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value < 299 then
								_G.Level = true
							elseif GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value >= 300 then
								_G.Level = false
							end
						elseif Value >= 750000 then
							replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
						end

						if GetBP("Dragon Claw") then
							if GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value < 299 then
								_G.Level = true
							elseif GetBP("Dragon Claw") then
								if GetBP("Dragon Claw").Level.Value >= 300 then
									_G.Level = false
								end
							end
						elseif Value2 >= 1500 then
							replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
						end

						replicated.Remotes.CommF_:InvokeServer("BuySuperhuman")
					end
				end
			end)
		end
	end)
end

do
	DeathStep = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_DeathStep", {
		Text = "Auto DeathStep",
		Default = false,
		Callback = function(p212)
			_G.AutoDeathStep = p212
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.AutoDeathStep then
				pcall(function()
					if plr:FindFirstChild("WeaponAssetCache") and not GetBP("Death Step") then
						if not GetBP("Black Leg") then
							replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg")
						end

						if GetBP("Black Leg") and GetBP("Black Leg").Level.Value >= 400 then
							replicated.Remotes.CommF_:InvokeServer("BuyDeathStep")
							_G.Level = false
						elseif GetBP("Black Leg") and GetBP("Black Leg").Level.Value < 399 then
							_G.Level = true
						end

						if (GetBP("Black Leg") or GetBP("Black Leg").Level.Value >= 400) and workspace.Map.IceCastle.Hall.LibraryDoor.PhoeyuDoor.Transparency == 0 then
							if GetBP("Library Key") then
								while true do
									wait()
									_tp(CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375))

									if _G.AutoDeathStep then
										if Root.Position == CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375).Position then
											break
										end
									else
										break
									end
								end

								if Root.CFrame == CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375) then
									replicated.Remotes.CommF_:InvokeServer("BuyDeathStep")
								end
							elseif not GetBP("Library Key") then
								local v929 = GetConnectionEnemies("Awakened Ice Admiral")

								if v929 then
									while true do
										wait()
										t9.Kill(v929, _G.AutoDeathStep)

										if v929.Parent then
											if v929.Humanoid.Health <= 0 or _G.AutoDeathStep == false or GetBP("Library Key") or GetBP("Death Step") then
												break
											end
										else
											break
										end
									end
								else
									_tp(CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813))
								end
							end
						end
					end
				end)
			end
		end
	end)
end

SharkManV2 = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_Sharkman_Karate", {
	Text = "Auto Sharkman Karate",
	Default = false,
	Callback = function(p213)
		_G.Auto_SharkMan_Karate = p213
	end
})
spawn(function()
	while wait(Sec) do
		if _G.Auto_SharkMan_Karate then
			pcall(function()
				if plr:FindFirstChild("WeaponAssetCache") and not GetBP("Sharkman Karate") then
					if not GetBP("Fishman Karate") then
						replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
					end

					if GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value >= 400 then
						replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
						_G.Level = false
					elseif GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value < 399 then
						_G.Level = true
					end

					if GetBP("Fishman Karate") or GetBP("Fishman Karate").Level.Value >= 400 then
						if GetBP("Water Key") then
							if string.find(replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate"), "keys") and GetBP("Water Key") then
								while true do
									wait()
									_tp(CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365))

									if _G.Auto_SharkMan_Karate then
										if Root.Position == CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365).Position then
											break
										end
									else
										break
									end
								end

								replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
							end
						elseif not GetBP("Water Key") then
							local v930 = GetConnectionEnemies("Tide Keeper")

							if v930 then
								while true do
									wait()
									t9.Kill(v930, _G.Auto_SharkMan_Karate)

									if v930.Parent then
										if v930.Humanoid.Health <= 0 or _G.Auto_SharkMan_Karate == false or GetBP("Water Key") or GetBP("Sharkman Karate") then
											break
										end
									else
										break
									end
								end
							else
								_tp(CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625))
							end
						end
					end
				end
			end)
		end
	end
end)
ElectricClaw = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_ElectricClaw", {
	Text = "Auto ElectricClaw",
	Default = false,
	Callback = function(p214)
		_G.Auto_Electric_Claw = p214
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.Auto_Electric_Claw then
				pcall(function()
					if plr:FindFirstChild("WeaponAssetCache") then
						if not GetBP("Electro") then
							replicated.Remotes.CommF_:InvokeServer("BuyElectro")
						end

						if GetBP("Electro") and GetBP("Electro").Level.Value >= 400 then
							if replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start") == nil then
								notween(CFrame.new(-12548, 337, -7481))
							end

							replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw")
						elseif GetBP("Electro") and GetBP("Electro").Level.Value < 400 then
							while true do
								_G.AutoFarm_Bone = true
								wait()

								if _G.Auto_Electric_Claw then
									if GetBP("Electric Claw") then
										break
									end
								else
									break
								end
							end

							_G.AutoFarm_Bone = false
						end
					end
				end)
			end
		end
	end)
end

DragonTalon = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_DragonTalon", {
	Text = "Auto DragonTalon",
	Default = false,
	Callback = function(p215)
		_G.AutoDragonTalon = p215
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.AutoDragonTalon then
				pcall(function()
					if plr:FindFirstChild("WeaponAssetCache") then
						if not GetBP("Dragon Claw") then
							replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
						end

						if GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value >= 400 then
							replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
							replicated.Remotes.CommF_:InvokeServer("BuyDragonTalon")
						elseif GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value < 400 then
							while true do
								_G.AutoFarm_Bone = true
								wait()

								if _G.AutoDragonTalon then
									if GetBP("Dragon Talon") then
										break
									end
								else
									break
								end
							end

							_G.AutoFarm_Bone = false
						end
					end
				end)
			end
		end
	end)
end

do
	Godhuman = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_Godhuman", {
		Text = "Auto Godhuman",
		Default = false,
		Callback = function(p216)
			_G.Auto_God_Human = p216
		end
	})
end

spawn(function()
	while wait() do
		pcall(function()
			if _G.Auto_God_Human then
				if replicated.Remotes.CommF_:InvokeServer("BuyGodhuman", true) ~= "Bring me 20 Fish Tails, 20 Magma Ore, 10 Dragon Scales and 10 Mystic Droplets." then
					if replicated.Remotes.CommF_:InvokeServer("BuyGodhuman", true) == 3 then
						return nil
					end

					replicated.Remotes.CommF_:InvokeServer("BuyGodhuman")
				elseif GetM("Dragon Scale") ~= false and not (GetM("Dragon Scale") < 10) then
					if GetM("Fish Tail") ~= false and not (GetM("Fish Tail") < 20) then
						if GetM("Mystic Droplet") ~= false and not (GetM("Mystic Droplet") < 10) then
							if GetM("Magma Ore") == false or GetM("Magma Ore") < 20 then
								if World2 then
									Lv = 1175
									_G.Level = true
								else
									replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
								end
							end
						elseif World2 then
							Lv = 1425
							_G.Level = true
						else
							replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
						end
					elseif World3 then
						Lv = 1775
						_G.Level = true
					else
						replicated.Remotes.CommF_:InvokeServer("TravelZou")
					end
				elseif World3 then
					Lv = 1575
					_G.Level = true
				else
					replicated.Remotes.CommF_:InvokeServer("TravelZou")
				end
			end
		end)
	end
end)

do
	SanguineArt = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_SanguineArt", {
		Text = "Auto SanguineArt",
		Default = false,
		Callback = function(p217)
			_G.Snaguine = p217
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.Snaguine then
				pcall(function()
					if not GetBP("Sanguine Art") then
						replicated.Remotes.CommF_:InvokeServer("Sanguine Art")
					end

					if GetBP("Sanguine Art") then
						replicated.Remotes.CommF_:InvokeServer("BuySanguineArt")
					else
						if GetM("Leviathan Heart") >= 1 then
							print("Completed!!")
						elseif World3 then
							_G.DangerSc = "Lv Infinite"
							_G.SailBoats = true
						else
							_G.SailBoats = false
						end

						if GetM("Vampire Fang") <= 19 then
							if World2 then
								local Vampire = GetConnectionEnemies("Vampire")

								if Vampire then
									while true do
										task.wait()
										t9.Kill(Vampire, _G.Snaguine)

										if _G.Snaguine then
											if Vampire.Humanoid.Health <= 0 or not Vampire.Parent then
												break
											end
										else
											break
										end
									end
								else
									_tp(CFrame.new(-6041.29248046875, 6.4027109146118164, -1304.63330078125))
								end
							else
								replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
							end
						end

						if GetM("Vampire Fang") >= 20 and GetM("Demonic Wisp") <= 19 then
							if World3 then
								local v932 = GetConnectionEnemies("Demonic Soul")

								if v932 then
									while true do
										task.wait()
										t9.Kill(v932, _G.Snaguine)

										if _G.Snaguine then
											if v932.Humanoid.Health <= 0 or not v932.Parent then
												break
											end
										else
											break
										end
									end
								else
									_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
								end
							else
								replicated.Remotes.CommF_:InvokeServer("TravelZou")
							end
						end

						if GetM("Vampire Fang") >= 20 and GetM("Demonic Wisp") >= 20 and GetM("Dark Fragment") <= 1 then
							if World2 then
								if GetConnectionEnemies("Darkbeard") then
									while true do
										task.wait()
										t9.Kill(black, _G.Snaguine)

										if _G.Snaguine then
											break
										elseif black.Humanoid.Health <= 0 or not black.Parent then
											break
										end
									end
								else
									_tp(CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625))
								end
							else
								replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
							end
						end
					end
				end)
			end
		end
	end)
end

GRP_Race_Mystic_Island_Full_Moon = t15.Race:AddLeftGroupbox("Mystic Island / Full Moon")

do
	local v933 = GRP_Race_Mystic_Island_Full_Moon:AddLabel("")
	local v934 = GRP_Race_Mystic_Island_Full_Moon:AddLabel("")

	spawn(function()
		while wait(0.2) do
			if not workspace.Map:FindFirstChild("MysticIsland") then
				if not workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
					v934:SetText("Mirage Island : False")

					continue
				end
			end

			v934:SetText("Mirage Island : True")
		end
	end)
	spawn(function()
		while wait(0.2) do
			pcall(function()
				local v935 = Getmoon()

				if v935 == "http://www.roblox.com/asset/?id=9709135895" then
					v933:SetText("Moon : 0 / 8")
				elseif v935 == "http://www.roblox.com/asset/?id=9709139597" then
					v933:SetText("Moon : 1 / 8")
				elseif v935 == "http://www.roblox.com/asset/?id=9709143733" then
					v933:SetText("Moon : 2 / 8")
				elseif v935 == "http://www.roblox.com/asset/?id=9709149052" then
					v933:SetText("Moon : 3 / 8 [ Next Night ]")
				elseif v935 == "http://www.roblox.com/asset/?id=9709149431" then
					v933:SetText("Moon : 4 / 8 [ Full Moon ]")
				elseif v935 == "http://www.roblox.com/asset/?id=9709149680" then
					v933:SetText("Moon : 5 / 8 [ Last Night ]")
				elseif v935 == "http://www.roblox.com/asset/?id=9709150086" then
					v933:SetText("Moon : 6 / 8")
				elseif v935 == "http://www.roblox.com/asset/?id=9709150401" then
					v933:SetText("Moon : 7 / 8")
				end
			end)
		end
	end)
end

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Find_Mirage_Island", {
	Text = "Auto Find Mirage Island",
	Default = false,
	Callback = function(p218)
		_G.FindMirage = p218
	end
})
spawn(function()
	while wait() do
		if _G.FindMirage then
			pcall(function()
				if workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island", true) then
					_tp(workspace.Map:FindFirstChild("MysticIsland").Center.CFrame * CFrame.new(0, 300, 0))
				else
					local v936 = CheckBoat()

					if v936 then
						if plr.Character.Humanoid.Sit == false then
							_tp(v936.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
						else
							while true do
								wait()

								local cFrame = CFrame.new(-10000000, 31, 37016.25)

								if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
									_tp(CFrame.new(-10000000, 150, 37016.25))
								else
									_tp(CFrame.new(-10000000, 31, 37016.25))
								end

								if _G.FindMirage and not ((cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10) then
									if not (workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") or plr.Character.Humanoid.Sit == false) then
										continue
									end
								end

								break
							end

							plr.Character.Humanoid.Sit = false
						end
					else
						local cFrame = CFrame.new(-16927.451, 9.086, 433.864)

						TeleportToTarget(cFrame)

						if (cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
						end
					end
				end
			end)
		end
	end
end)
GRP_Race_Mystic_Island_Full_Moon:AddToggle("Esp_Mirage_Island", {
	Text = "Esp Mirage Island",
	Default = false,
	Callback = function(p219)
		MirageIslandESP = p219

		if MirageIslandESP then
			task.spawn(function()
				while MirageIslandESP do
					UpdateIslandMirageESP()
					task.wait(1)
				end
			end)
		else
			UpdateIslandMirageESP()
		end
	end
})

do
	GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Tween_To_Mirage_Island", {
		Text = "Auto Tween To Mirage Island",
		Default = false,
		Callback = function(p220)
			_G.AutoMysticIsland = p220
		end
	})
end

spawn(function()
	while task.wait(0.1) do
		pcall(function()
			if _G.AutoMysticIsland then
				for _, child in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
					if child.Name == "Mirage Island" then
						topos(child.CFrame * CFrame.new(0, 333, 0))
					end
				end
			end
		end)
	end
end)
GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Tween_To_Highest_Point", {
	Text = "Auto Tween To Highest Point",
	Default = false,
	Callback = function(p221)
		_G.HighestMirage = p221
	end
})
spawn(function()
	while wait(Sec) do
		if _G.HighestMirage then
			pcall(function()
				if workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island", true) then
					_tp(workspace.Map:FindFirstChild("MysticIsland").Center.CFrame * CFrame.new(0, 400, 0))
				end
			end)
		end
	end
end)
GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Collect_Gear", {
	Text = "Auto Collect Gear",
	Default = false,
	Callback = function(p222)
		_G.TPGEAR = p222
	end
})
spawn(function()
	pcall(function()
		while wait(0.1) do
			if _G.TPGEAR then
				local pairs_ = pairs
				local MysticIsland = workspace.Map:FindFirstChild("MysticIsland")

				for _, child in pairs_(MysticIsland:GetChildren()) do
					if child.Name == "Part" and child.ClassName == "MeshPart" then
						_tp(child.CFrame)
					end
				end
			end
		end
	end)
end)

do
	GRP_Race_Mystic_Island_Full_Moon:AddToggle("Change_Transparency_can_see", {
		Text = "Change Transparency can see",
		Default = false,
		Callback = function(p223)
			_G.can = p223
		end
	})
end

spawn(function()
	pcall(function()
		while wait(Sec) do
			if _G.can then
				local pairs_ = pairs
				local MysticIsland = workspace.Map:FindFirstChild("MysticIsland")

				for _, child in pairs_(MysticIsland:GetChildren()) do
					if child.Name == "Part" then
						if child.ClassName == "MeshPart" then
							child.Transparency = 0
						else
							child.Transparency = 1
						end
					end
				end
			end
		end
	end)
end)

do
	GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Tween_Advanced_Fruit_Dealer", {
		Text = "Auto Tween Advanced Fruit Dealer",
		Default = false,
		Callback = function(p224)
			_G.Addealer = p224
		end
	})
end

do
	spawn(function()
		while wait() do
			if _G.Addealer then
				pcall(function()
					for _, child in pairs(replicated.NPCs:GetChildren()) do
						if child.Name == "Advanced Fruit Dealer" then
							_tp(child.HumanoidRootPart.CFrame)
						end
					end
				end)
			end
		end
	end)
end

do
	GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Collect_Mirage_Chest", {
		Text = "Auto Collect Mirage Chest",
		Default = false,
		Callback = function(p225)
			_G.FarmChestM = p225
		end
	})
end

do
	spawn(function()
		while wait(0.2) do
			if _G.FarmChestM then
				pcall(function()
					local ok2 = workspace.Map:FindFirstChild("MysticIsland").Chests:FindFirstChild("DiamondChest")

					if not ok2 then
						ok2 = not not workspace.Map:FindFirstChild("MysticIsland").Chests:FindFirstChild("FragChest")
					end

					if ok2 then
						local CollectionService = game:GetService("CollectionService")
						local LocalPlayer = game:GetService("Players").LocalPlayer
						local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

						if not Character then
							return
						end

						local Position = Character:GetPivot().Position
						local tagged = CollectionService:GetTagged("_ChestTagged")
						local huge = math.huge
						local v958
						local n5 = 1
						local v960 = #tagged
						local v961, exitTo, v963, v964, Magnitude

						if true then
							if n5 <= v960 then
								repeat
									v963 = n5
									exitTo = nil

									while true do
										v964 = tagged[v963]
										Magnitude = (v964:GetPivot().Position - Position).Magnitude

										if (not SelectedIsland or v964:IsDescendantOf(SelectedIsland)) and not v964:GetAttribute("IsDisabled") and Magnitude < huge then
											huge = Magnitude
											v958 = v964
										end

										v961 += nil

										if not (nil <= 0) then
											exitTo = 1

											break
										elseif v961 >= nil then
											v963 = n5

											continue
										end

										break
									end
								until exitTo ~= 1 or not (v961 <= nil)

								if v958 then
									_tp(v958:GetPivot())
								end
							end
						else
							if not (n5 >= v960) then
								return
							end

							local exitTo2

							while true do
								v963 = n5
								v964 = tagged[v963]
								Magnitude = (v964:GetPivot().Position - Position).Magnitude

								if (not SelectedIsland or v964:IsDescendantOf(SelectedIsland)) and not v964:GetAttribute("IsDisabled") and Magnitude < huge then
									huge = Magnitude
									v958 = v964
								end

								v961 += nil

								if not (nil <= 0) then
									exitTo2 = 1

									break
								elseif v961 >= nil then
									continue
								end

								break
							end

							if exitTo2 == 1 and v961 <= nil then
								repeat
									v963 = n5
									exitTo = nil

									while true do
										v964 = tagged[v963]
										Magnitude = (v964:GetPivot().Position - Position).Magnitude

										if (not SelectedIsland or v964:IsDescendantOf(SelectedIsland)) and not v964:GetAttribute("IsDisabled") and Magnitude < huge then
											huge = Magnitude
											v958 = v964
										end

										v961 += nil

										if not (nil <= 0) then
											exitTo = 1

											break
										elseif v961 >= nil then
											v963 = n5

											continue
										end

										break
									end
								until exitTo ~= 1 or not (v961 <= nil)

								if v958 then
									_tp(v958:GetPivot())
								end
							elseif v958 then
								_tp(v958:GetPivot())
							end
						end
					end
				end)
			end
		end
	end)
end

GRP_Race_Mystic_Island_Full_Moon:AddButton({
	Text = "Talk With Stone",
	Func = function()
		local CommF_ = replicated:WaitForChild("Remotes"):WaitForChild("CommF_")

		CommF_:InvokeServer("RaceV4Progress", "Begin")
		CommF_:InvokeServer("RaceV4Progress", "Check")
		CommF_:InvokeServer("RaceV4Progress", "Teleport")
	end
})
GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Look_At_Moon", {
	Text = "Auto Look At Moon",
	Default = false,
	Callback = function(p226)
		_G.Auto_Mink = p226
	end
})
MoveCamtoMoon = function()
	workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, Lighting:GetMoonDirection() + workspace.CurrentCamera.CFrame.Position)
	plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, Lighting:GetMoonDirection() + plr.Character.HumanoidRootPart.CFrame.Position)
end

do
	task.spawn(function()
		while task.wait() do
			if LookM then
				MoveCamtoMoon()
				wait(0.1)
				replicated.Remotes.CommE:FireServer("ActivateAbility")
			end
		end
	end)
end

do
	GRP_Race_Mystic_Island_Full_Moon:AddToggle("Look_Moon_+_Auto_V3", {
		Text = "Look Moon + Auto V3",
		Default = false,
		Callback = function(p227)
			LookMV3 = p227
		end
	})
end

MoveCamtoMoon = function()
	local moonDirection = Lighting:GetMoonDirection()

	workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + moonDirection)
	plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, plr.Character.HumanoidRootPart.Position + moonDirection)
end
task.spawn(function()
	while task.wait(0.1) do
		if LookMV3 then
			MoveCamtoMoon()
			replicated.Remotes.CommE:FireServer("ActivateAbility")
			UIS:SendKeyEvent(true, "T", true, game)
			wait(0.5)
			UIS:SendKeyEvent(false, "T", true, game)
		end
	end
end)
GRP_Race_Upgrade_Races_V2_And_V3 = t15.Race:AddLeftGroupbox("Upgrade Races V2 And V3")

do
	RaceMink = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_Mink", {
		Text = "Auto Upgrade Mink",
		Default = false,
		Callback = function(p228)
			_G.Auto_Mink = p228
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Mink then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") ~= 2 then
						if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "2")
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
							local ok2 = plr.Backpack:FindFirstChild("Flower 1")

							if not ok2 then
								ok2 = plr.Character:FindFirstChild("Flower 1")
							end

							if ok2 then
								local ok = plr.Backpack:FindFirstChild("Flower 2")

								if not ok then
									ok = plr.Character:FindFirstChild("Flower 2")
								end

								if not ok then
									_tp(workspace.Flower2.CFrame)
								elseif not plr.Backpack:FindFirstChild("Flower 3") then
									if not plr.Character:FindFirstChild("Flower 3") then
										local v971 = GetConnectionEnemies("Swan Pirate")

										if v971 then
											while true do
												wait()
												t9.Kill(v971, _G.Auto_Mink)

												if GetBP("Flower 3") then
													break
												elseif not v971.Parent or v971.Humanoid.Health <= 0 or _G.Auto_Mink == false then
													break
												end
											end
										else
											_tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
										end
									end
								end
							else
								_tp(workspace.Flower1.CFrame)
							end
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "3")
						end
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
						_G.AutoFarmChest = true
					else
						_G.AutoFarmChest = false
					end
				end
			end)
		end
	end)
end

RaceHuman = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_Human", {
	Text = "Auto Upgrade Human",
	Default = false,
	Callback = function(p229)
		_G.Auto_Human = p229
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Human then
				if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") ~= -2 then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Alchemist", "2")
					elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
						local ok2 = plr.Backpack:FindFirstChild("Flower 1")

						if not ok2 then
							ok2 = plr.Character:FindFirstChild("Flower 1")
						end

						if ok2 then
							local ok = plr.Backpack:FindFirstChild("Flower 2")

							if not ok then
								ok = plr.Character:FindFirstChild("Flower 2")
							end

							if not ok then
								_tp(workspace.Flower2.CFrame)
							elseif not plr.Backpack:FindFirstChild("Flower 3") then
								if not plr.Character:FindFirstChild("Flower 3") then
									local v974 = GetConnectionEnemies("Swan Pirate")

									if v974 then
										while true do
											wait()
											t9.Kill(v974, _G.Auto_Human)

											if plr.Backpack:FindFirstChild("Flower 3") then
												break
											elseif not v974.Parent or v974.Humanoid.Health <= 0 or _G.Auto_Human == false then
												break
											end
										end
									else
										_tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
									end
								end
							end
						else
							_tp(workspace.Flower1.CFrame)
						end
					elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
						replicated.Remotes.CommF_:InvokeServer("Alchemist", "3")
					end
				elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
					replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
				elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
					local v975 = GetConnectionEnemies(t4[1])
					local v976

					if v975 then
						while true do
							wait()
							t9.Kill(v975, _G.Auto_Human)

							if v975.Humanoid.Health <= 0 then
								break
							elseif not v975.Parent or not _G.Auto_Human then
								break
							end
						end

						v976 = GetConnectionEnemies(t4[2])

						if v976 then
							while true do
								wait()
								t9.Kill(v976, _G.Auto_Human)

								if v976.Humanoid.Health <= 0 then
									break
								elseif not v976.Parent or not _G.Auto_Human then
									break
								end
							end
						else
							_tp(CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109))
						end
					else
						_tp(CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625))
						v976 = GetConnectionEnemies(t4[2])

						if v976 then
							while true do
								wait()
								t9.Kill(v976, _G.Auto_Human)

								if v976.Humanoid.Health <= 0 then
									break
								elseif not v976.Parent or not _G.Auto_Human then
									break
								end
							end
						else
							_tp(CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109))
						end
					end

					local v977 = GetConnectionEnemies(t4[3])

					if v977 then
						while true do
							wait()
							t9.Kill(v977, _G.Auto_Human)

							if v977.Humanoid.Health <= 0 then
								break
							elseif not v977.Parent or not _G.Auto_Human then
								break
							end
						end
					else
						_tp(CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407))
					end
				end
			end
		end)
	end
end)
RaceSky = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_Angel", {
	Text = "Auto Upgrade Angel",
	Default = false,
	Callback = function(p230)
		_G.Auto_Skypiea = p230
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Skypiea then
				if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") ~= -2 then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Alchemist", "2")
					elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
						local ok2 = plr.Backpack:FindFirstChild("Flower 1")

						if not ok2 then
							ok2 = plr.Character:FindFirstChild("Flower 1")
						end

						if ok2 then
							local ok = plr.Backpack:FindFirstChild("Flower 2")

							if not ok then
								ok = plr.Character:FindFirstChild("Flower 2")
							end

							if not ok then
								_tp(workspace.Flower2.CFrame)
							elseif not plr.Backpack:FindFirstChild("Flower 3") then
								if not plr.Character:FindFirstChild("Flower 3") then
									local v980 = GetConnectionEnemies("Swan Pirate")

									if v980 then
										while true do
											wait()
											t9.Kill(v980, _G.Auto_Skypiea)

											if plr.Backpack:FindFirstChild("Flower 3") then
												break
											elseif not v980.Parent or v980.Humanoid.Health <= 0 or _G.Auto_Skypiea == false then
												break
											end
										end
									else
										_tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
									end
								end
							end
						else
							_tp(workspace.Flower1.CFrame)
						end
					elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
						replicated.Remotes.CommF_:InvokeServer("Alchemist", "3")
					end
				elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
					replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
				elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
					for _, child in pairs(game.Players:GetChildren()) do
						if child.Name ~= plr.Name and tostring(child.Data.Race.Value) == "Skypiea" then
							while true do
								task.wait()
								_tp(child.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(math.rad(-45), 0, 0))

								if child.Humanoid.Health <= 0 then
									break
								elseif _G.Auto_Skypiea == false then
									break
								end
							end
						end
					end
				end
			end
		end)
	end
end)

do
	RaceFish = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_FishMan", {
		Text = "Auto Upgrade FishMan",
		Default = false,
		Callback = function(p231)
			_G.Auto_Fish = p231
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Fish then
				if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") ~= -2 then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Alchemist", "2")
					elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
						local ok2 = plr.Backpack:FindFirstChild("Flower 1")

						if not ok2 then
							ok2 = plr.Character:FindFirstChild("Flower 1")
						end

						if ok2 then
							local ok = plr.Backpack:FindFirstChild("Flower 2")

							if not ok then
								ok = plr.Character:FindFirstChild("Flower 2")
							end

							if not ok then
								_tp(workspace.Flower2.CFrame)
							elseif not plr.Backpack:FindFirstChild("Flower 3") then
								if not plr.Character:FindFirstChild("Flower 3") then
									local v985 = GetConnectionEnemies("Swan Pirate")

									if v985 then
										while true do
											wait()
											t9.Kill(v985, _G.Auto_Fish)

											if plr.Backpack:FindFirstChild("Flower 3") then
												break
											elseif not v985.Parent or v985.Humanoid.Health <= 0 or _G.Auto_Fish == false then
												break
											end
										end
									else
										_tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
									end
								end
							end
						else
							_tp(workspace.Flower1.CFrame)
						end
					elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
						replicated.Remotes.CommF_:InvokeServer("Alchemist", "3")
					end
				elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
					replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
				elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
					warn("Sea Beast Soon")
				end
			end
		end)
	end
end)
GRP_Race_Trials_Quest_V4 = t15.Race:AddLeftGroupbox("Trials Quest V4")

do
	local v986 = GRP_Race_Trials_Quest_V4:AddLabel("")

	spawn(function()
		pcall(function()
			while wait(0.2) do
				v986:SetText("Cấp - V4 : " .. " " .. plr.Data.Race.C.Value)
			end
		end)
	end)
end

do
	PullLv = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Pull_Lever", {
		Text = "Auto Pull Lever",
		Default = false,
		Callback = function(p232)
			_G.Lver = p232
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.Lver then
			pcall(function()
				for _, descendant in pairs(workspace.Map["Temple of Time"]:GetDescendants()) do
					if descendant.Name == "ProximityPrompt" then
						fireproximityprompt(descendant, math.huge)
					end
				end
			end)
		end
	end
end)

do
	Train = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Train_V4", {
		Text = "Auto Train V4",
		Default = false,
		Callback = function(p233)
			_G.AcientOne = p233
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.AcientOne then
					local t38 = {
						"Reborn Skeleton",
						"Living Zombie",
						"Demonic Soul",
						"Posessed Mummy"
					}
					local v990 = #t38
					local n6 = 1
					local v992 = v990 + 0
					local v993 = 1 - n6
					local exitTo

					for i = 1, v990 do
						if plr.Character:FindFirstChild("RaceEnergy").Value ~= 1 then
							if plr.Character:FindFirstChild("RaceTransformed").Value == false then
								local v996 = GetConnectionEnemies(t38)

								if not v996 then
									_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))

									continue
								end

								while true do
									wait()
									t9.Kill(v996, _G.AcientOne)

									if _G.AcientOne == false then
										break
									elseif v996.Humanoid.Health <= 0 or not v996.Parent then
										break
									end
								end
							end

							continue
						end

						repeat
							vim1:SendKeyEvent(true, "Y", true, game)
							replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
							vim1:SendKeyEvent(false, "Y", true, game)
							_tp(CFrame.new(-8987.041015625, 215.862060546875, 5886.71044921875))
							exitTo = nil

							local exitTo2
							local Character, Character2, v1000

							while true do
								v993 += n6

								if not (n6 <= 0) then
									exitTo2 = 1

									break
								end

								if not (v993 >= v992) then
									break
								end

								Character = plr.Character

								if Character:FindFirstChild("RaceEnergy").Value == 1 then
									exitTo2 = 2

									break
								end

								Character2 = plr.Character

								if Character2:FindFirstChild("RaceTransformed").Value ~= false then
									continue
								end

								v1000 = GetConnectionEnemies(t38)

								if not v1000 then
									exitTo2 = 3

									break
								end

								while true do
									wait()
									t9.Kill(v1000, _G.AcientOne)

									if _G.AcientOne == false then
										break
									elseif v1000.Humanoid.Health <= 0 or not v1000.Parent then
										break
									end
								end
							end

							if exitTo2 == 1 then
								if v993 <= v992 then
									while true do
										Character = plr.Character

										if Character:FindFirstChild("RaceEnergy").Value == 1 then
											exitTo = 1

											break
										end

										Character2 = plr.Character

										if Character2:FindFirstChild("RaceTransformed").Value == false then
											v1000 = GetConnectionEnemies(t38)

											if not v1000 then
												exitTo = 2

												break
											end

											local exitTo3

											while true do
												wait()
												t9.Kill(v1000, _G.AcientOne)

												if _G.AcientOne == false then
													break
												elseif v1000.Humanoid.Health <= 0 or not v1000.Parent then
													exitTo3 = 1

													break
												end
											end

											if exitTo3 == 1 then
												local exitTo4

												while true do
													v993 += n6

													if not (n6 <= 0) then
														exitTo4 = 1

														break
													end

													if not (v993 >= v992) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo4 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value ~= false then
														continue
													end

													v1000 = GetConnectionEnemies(t38)

													if not v1000 then
														exitTo4 = 3

														break
													end

													while true do
														wait()
														t9.Kill(v1000, _G.AcientOne)

														if _G.AcientOne == false then
															break
														elseif v1000.Humanoid.Health <= 0 or not v1000.Parent then
															break
														end
													end
												end

												if exitTo4 == 1 then
													if v993 <= v992 then
														continue
													end
												else
													if exitTo4 == 2 then
														exitTo = 1
													elseif exitTo4 == 3 then
														exitTo = 2
													end

													break
												end
											else
												local exitTo5

												while true do
													v993 += n6

													if not (n6 <= 0) then
														exitTo5 = 1

														break
													end

													if not (v993 >= v992) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo5 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value ~= false then
														continue
													end

													v1000 = GetConnectionEnemies(t38)

													if not v1000 then
														exitTo5 = 3

														break
													end

													while true do
														wait()
														t9.Kill(v1000, _G.AcientOne)

														if _G.AcientOne == false then
															break
														elseif v1000.Humanoid.Health <= 0 or not v1000.Parent then
															break
														end
													end
												end

												if exitTo5 == 1 then
													if v993 <= v992 then
														continue
													end
												else
													if exitTo5 == 2 then
														exitTo = 1
													elseif exitTo5 == 3 then
														exitTo = 2
													end

													break
												end
											end
										else
											local exitTo6

											while true do
												v993 += n6

												if not (n6 <= 0) then
													exitTo6 = 1

													break
												end

												if not (v993 >= v992) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo6 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value ~= false then
													continue
												end

												v1000 = GetConnectionEnemies(t38)

												if not v1000 then
													exitTo6 = 3

													break
												end

												while true do
													wait()
													t9.Kill(v1000, _G.AcientOne)

													if _G.AcientOne == false then
														break
													elseif v1000.Humanoid.Health <= 0 or not v1000.Parent then
														break
													end
												end
											end

											if exitTo6 == 1 then
												if v993 <= v992 then
													continue
												end
											else
												if exitTo6 == 2 then
													exitTo = 1
												elseif exitTo6 == 3 then
													exitTo = 2
												end

												break
											end
										end

										break
									end
								end
							elseif exitTo2 == 2 then
								exitTo = 1
							elseif exitTo2 == 3 then
								exitTo = 2
							end
						until exitTo ~= 1

						if exitTo == 2 then
							_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))

							continue
						end

						break
					end
				end
			end)
		end
	end)
end

do
	GRP_Race_Trials_Quest_V4:AddButton({
		Text = "Teleport to Temple of Time",
		Func = function()
			if plr.Character then
				if plr.Character:FindFirstChild("HumanoidRootPart") then
					local cFrame = CFrame.new(-7754.033203125, 2998.953857421875, -404.75357055664062)

					_tp(cFrame)
				end
			end
		end
	})
end

GRP_Race_Trials_Quest_V4:AddButton({
	Text = "Teleport to Ancient One",
	Func = function()
		if plr.Character then
			if plr.Character:FindFirstChild("HumanoidRootPart") then
				local cFrame = CFrame.new(-5071.541015625, 314.5412902832, -3151.1098632812)

				_tp(cFrame)
			end
		end
	end
})

do
	GRP_Race_Trials_Quest_V4:AddButton({
		Text = "Teleport to Ancient Clock",
		Func = function()
			if plr.Character then
				if plr.Character:FindFirstChild("HumanoidRootPart") then
					local cFrame = CFrame.new(-12471.169921875, 374.94024658203, -7551.677734375)

					_tp(cFrame)
				end
			end
		end
	})
end

do
	Doors = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Teleport_to_Race_Doors", {
		Text = "Auto Teleport to Race Doors",
		Default = false,
		Callback = function(p234)
			_G.TPDoor = p234
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.TPDoor then
					if tostring(plr.Data.Race.Value) == "Mink" then
						_tp(CFrame.new(29020.66015625, 14889.4267578125, -379.26828002929688))
					elseif tostring(plr.Data.Race.Value) == "Fishman" then
						_tp(CFrame.new(28224.056640625, 14889.4267578125, -210.58720397949219))
					elseif tostring(plr.Data.Race.Value) == "Cyborg" then
						_tp(CFrame.new(28492.4140625, 14894.4267578125, -422.11001586914062))
					elseif tostring(plr.Data.Race.Value) == "Skypiea" then
						_tp(CFrame.new(28967.408203125, 14918.0751953125, 234.31198120117188))
					elseif tostring(plr.Data.Race.Value) == "Ghoul" then
						_tp(CFrame.new(28672.720703125, 14889.1279296875, 454.59616088867188))
					elseif tostring(plr.Data.Race.Value) == "Human" then
						_tp(CFrame.new(29237.294921875, 14889.4267578125, -206.94955444335938))
					end
				end
			end)
		end
	end)
end

Trials = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Complete_Trial_Race", {
	Text = "Auto Complete Trial Race",
	Default = false,
	Callback = function(p235)
		_G.Complete_Trials = p235
	end
})
GetSeaBeastTrial = function()
	if not workspace.Map:FindFirstChild("FishmanTrial") then
		return nil
	end

	if workspace._WorldOrigin.Locations:FindFirstChild("Trial of Water") then
		FishmanTrial = workspace._WorldOrigin.Locations:FindFirstChild("Trial of Water")
	end

	if FishmanTrial then
		local next_ = next
		local children, v1010 = workspace.SeaBeasts:GetChildren()

		for _, v1 in next_, children, v1010 do
			if v1:FindFirstChild("HumanoidRootPart") and (v1.HumanoidRootPart.Position - FishmanTrial.Position).Magnitude <= 1500 and v1.Health.Value > 0 then
				return v1
			end
		end
	end
end
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Complete_Trials and tostring(plr.Data.Race.Value) == "Mink" then
				notween(workspace.Map.MinkTrial.Ceiling.CFrame * CFrame.new(0, -20, 0))
			end
		end)
	end
end)

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Complete_Trials and tostring(plr.Data.Race.Value) == "Fishman" and GetSeaBeastTrial() then
					while true do
						task.wait()
						spawn(function()
							_tp(CFrame.new(GetSeaBeastTrial().HumanoidRootPart.Position.X, game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 300, GetSeaBeastTrial().HumanoidRootPart.Position.Z))
						end)
						MousePos = GetSeaBeastTrial().HumanoidRootPart.Position
						Useskills("Melee", "Z")
						Useskills("Melee", "X")
						Useskills("Melee", "C")
						wait(0.1)
						Useskills("Sword", "Z")
						Useskills("Sword", "X")
						wait(0.1)
						Useskills("Blox Fruit", "Z")
						Useskills("Blox Fruit", "X")
						Useskills("Blox Fruit", "C")
						wait(0.1)
						Useskills("Gun", "Z")
						Useskills("Gun", "X")

						if _G.Complete_Trials == false then
							break
						elseif not GetSeaBeastTrial() then
							break
						end
					end
				end
			end)
		end
	end)
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Complete_Trials and tostring(plr.Data.Race.Value) == "Cyborg" then
				_tp(workspace.Map.CyborgTrial.Floor.CFrame * CFrame.new(0, 500, 0))
			end
		end)
	end
end)

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Complete_Trials and tostring(plr.Data.Race.Value) == "Skypiea" then
					notween(workspace.Map.SkyTrial.Model.FinishPart.CFrame)
				end
			end)
		end
	end)
end

spawn(function()
	while wait(0.1) do
		pcall(function()
			if _G.Complete_Trials and (tostring(plr.Data.Race.Value) == "Human" or tostring(plr.Data.Race.Value) == "Ghoul") then
				local v1013 = GetConnectionEnemies({
					"Ancient Vampire",
					"Ancient Zombie"
				})

				if v1013 then
					while true do
						wait()
						t9.Kill(v1013, _G.Complete_Trials)

						if _G.Complete_Trials == false then
							break
						elseif not v1013.Parent or v1013.Humanoid.Health <= 0 then
							break
						end
					end
				end
			end
		end)
	end
end)

do
	AutoKill = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Kill_Player_After_Trial", {
		Text = "Auto Kill Player After Trial",
		Default = false,
		Callback = function(p236)
			_G.Defeating = p236
		end
	})
end

do
	spawn(function()
		while task.wait(Sec) do
			pcall(function()
				if _G.Defeating then
					for _, child in pairs(workspace.Characters:GetChildren()) do
						if child.Name ~= plr.Name and child.Humanoid.Health > 0 and child:FindFirstChild("HumanoidRootPart") and child.Parent and (Root.Position - child.HumanoidRootPart.Position).Magnitude <= 250 then
							while true do
								task.wait()
								EquipWeapon(_G.SelectWeapon)
								_tp(child.HumanoidRootPart.CFrame * CFrame.new(0, 0, 15))
								sethiddenproperty(plr, "SimulationRadius", math.huge)

								if _G.Defeating == false then
									break
								elseif child.Humanoid.Health <= 0 or not child.Parent or not child:FindFirstChild("HumanoidRootPart") or not child:FindFirstChild("Humanoid") then
									break
								end
							end
						end
					end
				end
			end)
		end
	end)
end

GRP_Prehistoric_Dojo_Quest = t15.Prehistoric:AddLeftGroupbox("Dojo Quest")

do
	GRP_Prehistoric_Dojo_Quest:AddButton({
		Text = "Dojo Quest",
		Func = function()
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, -334.96499633789062))
			_tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
		end
	})
end

do
	DojoQ = GRP_Prehistoric_Dojo_Quest:AddToggle("Auto_Dojo_Trainer", {
		Text = "Auto Dojo Trainer",
		Default = false,
		Callback = function()
		end
	})
end

do
	printBeltName = function(p237)
		if type(p237) == "table" and p237.Quest.BeltName then
			return p237.Quest.BeltName
		end
	end
end

spawn(function()
	while wait(Sec) do
		if _G.Dojoo then
			pcall(function()
				local response = replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
					NPC = "Dojo Trainer",
					Command = "RequestQuest"
				} }))
				local v1017 = printBeltName(response)

				if debug == false and not (response or v1017) then
					_tp(CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875))
					debug = true
				elseif debug == true and (CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 50 then
					if v1017 == "White" then
						local v1018 = GetConnectionEnemies("Skull Slayer")

						if v1018 then
							while true do
								task.wait()
								t9.Kill(v1018, _G.Dojoo)

								if response then
									if not _G.Dojoo or not t9.Alive(v1018) then
										break
									end
								else
									break
								end
							end
						else
							_tp(CFrame.new(-16759.58984375, 71.283767700195312, 1595.3399658203125))
						end
					elseif v1017 == "Yellow" then
						while true do
							task.wait()
							_G.SeaBeast1 = true
							_G.TerrorShark = true
							_G.Shark = true
							_G.Piranha = true
							_G.MobCrew = true
							_G.FishBoat = true
							_G.SailBoats = true

							if _G.Dojoo then
								if not response then
									break
								end
							else
								break
							end
						end

						_G.SeaBeast1 = false
						_G.TerrorShark = false
						_G.Shark = false
						_G.Piranha = false
						_G.MobCrew = false
						_G.FishBoat = false
						_G.SailBoats = false
					elseif v1017 == "Green" then
						while true do
							task.wait()
							_G.SailBoats = true

							if _G.Dojoo then
								if not response then
									break
								end
							else
								break
							end
						end

						_G.SailBoats = false
					elseif v1017 == "Purple" then
						while true do
							task.wait()
							_G.FarmEliteHunt = true

							if _G.Dojoo then
								if not response then
									break
								end
							else
								break
							end
						end

						_G.FarmEliteHunt = false
					elseif v1017 == "Red" then
						while true do
							task.wait()
							_G.SailBoats = true
							_G.FishBoat = true

							if _G.Dojoo then
								if not response then
									break
								end
							else
								break
							end
						end

						_G.SailBoats = false
						_G.FishBoat = false
					elseif v1017 == "Black" then
						repeat
							task.wait()

							local ActivationPrompt

							if workspace.Map:FindFirstChild("PrehistoricIsland") then
								_G.Prehis_Find = true
								ActivationPrompt = workspace.Map.PrehistoricIsland.Core.ActivationPrompt

								if ActivationPrompt:FindFirstChild("ProximityPrompt", true) then
									_G.Prehis_Skills = false
									_G.Prehis_Find = true
								else
									_G.Prehis_Skills = true
									_G.Prehis_Find = false
								end
							elseif workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
								_G.Prehis_Find = true
								ActivationPrompt = workspace.Map.PrehistoricIsland.Core.ActivationPrompt

								if ActivationPrompt:FindFirstChild("ProximityPrompt", true) then
									_G.Prehis_Skills = false
									_G.Prehis_Find = true
								else
									_G.Prehis_Skills = true
									_G.Prehis_Find = false
								end

								if not _G.Dojoo or not response then
									break
								end
							else
								_G.Prehis_Find = true
								_G.Prehis_Skills = false
							end
						until not _G.Dojoo or not response

						_G.Prehis_Find = false
						_G.Prehis_Skills = false
					elseif v1017 == "Orange" or v1017 == "Blue" then
						return nil
					end
				end

				if not response then
					debug = false
					replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
						NPC = "Dojo Trainer",
						Command = "ClaimQuest"
					} }))
				end
			end)
		end
	end
end)

do
	BlazeEM = GRP_Prehistoric_Dojo_Quest:AddToggle("Auto_Dragon_Hunter", {
		Text = "Auto Dragon Hunter",
		Default = false,
		Callback = function(p238)
			_G.FarmBlazeEM = p238
		end
	})
end

do
	checkQuesta = function()
		local t39 = { {
			Context = "Check"
		} }
		local response

		pcall(function()
			game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({ {
				Context = "RequestQuest"
			} }))
		end)

		local _ = pcall(function()
			response = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack(t39))
		end)
		local v1024 = false
		local v1025
		local v1026
		local n7

		if response and response.Text then
			v1024 = true

			local Text = response.Text

			if string.find(tostring(Text), "Defeat") then
				n7 = 1

				local v1029 = string.sub(tostring(Text), 8, 9)

				v1025 = tonumber(v1029)

				for _, v1 in pairs({
					"Hydra Enforcer",
					"Venomous Assailant"
				}) do
					if string.find(Text, v1) then
						v1026 = v1

						break
					end
				end
			elseif string.find(tostring(Text), "Destroy") then
				v1025 = 10
				n7 = 2
				v1026 = nil
			end
		end

		return v1024, v1026, v1025, n7
	end
end

BackTODoJo = function()
	for _, child in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren()) do
		if child.Name == "NotificationTemplate" and string.find(child.Text, "Head back to the Dojo to complete more tasks") then
			return true
		end
	end

	return false
end
DragonMobClear = function(p239, p240, p241)
	if workspace.Enemies:FindFirstChild(p240) then
		for _, child in pairs(workspace.Enemies:GetChildren()) do
			if child.Name == p240 and t9.Alive(child) and p239 then
				t9.Kill(child, p239)
			end
		end
	else
		_tp(p241)
	end
end

do
	spawn(function()
		while wait() do
			if _G.FarmBlazeEM then
				pcall(function()
					local v1036, v1037, _, v1039 = checkQuesta()

					if v1036 ~= true or BackTODoJo() then
						_tp(CFrame.new(5813, 1208, 884))
						DragonMobClear(false, nil, nil)
					elseif v1039 == 1 then
						if v1037 == "Hydra Enforcer" or v1037 == "Venomous Assailant" then
							while true do
								wait()
								DragonMobClear(true, v1037, CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))

								if _G.FarmBlazeEM then
									if BackTODoJo() then
										break
									end
								else
									break
								end
							end
						end
					elseif v1039 == 2 then
						if workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true) then
							repeat
								wait()
								spawn(function()
									_tp(workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).CFrame * CFrame.new(4, 0, 0))
								end)

								if (workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).Position - Root.Position).Magnitude <= 200 then
									MousePos = workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).Position
									Useskills("Melee", "Z")
									Useskills("Melee", "X")
									Useskills("Melee", "C")
									wait(0.5)
									Useskills("Sword", "Z")
									Useskills("Sword", "X")
									wait(0.5)
									Useskills("Blox Fruit", "Z")
									Useskills("Blox Fruit", "X")
									Useskills("Blox Fruit", "C")
									wait(0.5)
									Useskills("Gun", "Z")
									Useskills("Gun", "X")
								end
							until not _G.FarmBlazeEM or BackTODoJo()
						end
					end
				end)
			end
		end
	end)
end

spawn(function()
	while wait(0.1) do
		if _G.FarmBlazeEM then
			pcall(function()
				if workspace.EmberTemplate:FindFirstChild("Part") then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.EmberTemplate.Part.CFrame
				end
			end)
		end
	end
end)
GRP_Prehistoric_Drago_Trial = t15.Prehistoric:AddLeftGroupbox("Drago Trial")

do
	GetQuestDracoLevel = function()
		return replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
			NPC = "Dragon Wizard",
			Command = "Upgrade"
		} }))
	end
end

Toggle = GRP_Prehistoric_Drago_Trial:AddToggle("Tween_To_Upgrade_Droco_Trial", {
	Text = "Tween To Upgrade Droco Trial",
	Default = false,
	Callback = function(p242)
		_G.UPGDrago = p242
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.UPGDrago then
					if GetQuestDracoLevel() == false then
						return nil
					end

					if GetQuestDracoLevel() == true then
						if (CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375).Position - Root.Position).Magnitude >= 300 then
							_tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
						else
							_tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
							replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
								NPC = "Dragon Wizard",
								Command = "Upgrade"
							} }))
						end
					end
				end
			end)
		end
	end)
end

do
	Toggle = GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Drago_(V1)", {
		Text = "Auto Drago (V1)",
		Default = false,
		Callback = function(p243)
			_G.DragoV1 = p243
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.DragoV1 and GetM("Dragon Egg") <= 0 then
					while true do
						wait()
						_G.Prehis_Find = true
						_G.Prehis_Skills = true
						_G.Prehis_DE = true

						if _G.DragoV1 then
							if GetM("Dragon Egg") >= 1 then
								break
							end
						else
							break
						end
					end

					_G.Prehis_Find = false
					_G.Prehis_Skills = false
					_G.Prehis_DE = false
				end
			end)
		end
	end)
end

do
	fireflower = GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Drago_(V2)", {
		Text = "Auto Drago (V2)",
		Default = false,
		Callback = function(p244)
			_G.AutoFireFlowers = p244
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.AutoFireFlowers then
				local FireFlowers = workspace:FindFirstChild("FireFlowers")
				local v1041 = GetConnectionEnemies("Forest Pirate")

				if v1041 then
					while true do
						wait()
						t9.Kill(v1041, _G.AutoFireFlowers)

						if _G.AutoFireFlowers then
							if not v1041.Parent or v1041.Humanoid.Health <= 0 or FireFlowers then
								break
							end
						else
							break
						end
					end
				else
					_tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
				end

				if FireFlowers then
					for _, child in pairs(FireFlowers:GetChildren()) do
						if child:IsA("Model") and child.PrimaryPart then
							local Position = child.PrimaryPart.Position

							if (Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
								vim1:SendKeyEvent(true, "E", true, game)
								wait(1.5)
								vim1:SendKeyEvent(false, "E", true, game)
							else
								_tp(CFrame.new(Position))
							end
						end
					end
				end
			end
		end
	end)
end

Toggle = GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Drago_(V3)", {
	Text = "Auto Drago (V3)",
	Default = false,
	Callback = function(p245)
		_G.DragoV3 = p245
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.DragoV3 then
					repeat
						wait()
						_G.DangerSc = "Lv Infinite"
						_G.SailBoats = true
						_G.TerrorShark = true
					until not _G.DragoV3

					_G.DangerSc = "Lv 1"
					_G.SailBoats = false
					_G.TerrorShark = false
				end
			end)
		end
	end)
end

do
	Toggle = GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Relic_Drago_Trial_[Beta]", {
		Text = "Auto Relic Drago Trial [Beta]",
		Default = false,
		Callback = function(p246)
			_G.Relic123 = p246
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.Relic123 then
				pcall(function()
					if workspace.Map:FindFirstChild("DracoTrial") then
						replicated.Remotes.DracoTrial:InvokeServer()
						wait(0.5)

						while true do
							wait()
							_tp(CFrame.new(-39934.9765625, 10685.359375, 22999.34375))

							if _G.Relic123 then
								if Root.Position == CFrame.new(-39934.9765625, 10685.359375, 22999.34375).Position then
									break
								end
							else
								break
							end
						end

						while true do
							wait()
							_tp(CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625))

							if _G.Relic123 then
								if Root.Position == CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625).Position then
									break
								end
							else
								break
							end
						end

						wait(2.5)

						while true do
							wait()
							_tp(CFrame.new(-39914.65625, 10685.384765625, 23000.177734375))

							if _G.Relic123 then
								if Root.Position == CFrame.new(-39914.65625, 10685.384765625, 23000.177734375).Position then
									break
								end
							else
								break
							end
						end

						while true do
							wait()
							_tp(CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375))

							if _G.Relic123 then
								if Root.Position == CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375).Position then
									break
								end
							else
								break
							end
						end

						wait(2.5)

						while true do
							wait()
							_tp(CFrame.new(-39908.5, 10685.4052734375, 22990.04296875))

							if _G.Relic123 then
								if Root.Position == CFrame.new(-39908.5, 10685.4052734375, 22990.04296875).Position then
									break
								end
							else
								break
							end
						end

						while true do
							wait()
							_tp(CFrame.new(-39609.5, 9376.400390625, 23472.94335975))

							if _G.Relic123 then
								if Root.Position == CFrame.new(-39609.5, 9376.400390625, 23472.94335975).Position then
									break
								end
							else
								break
							end
						end
					else
						local TrialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")

						if TrialTeleport then
							if TrialTeleport:IsA("Part") then
								_tp(CFrame.new(TrialTeleport.Position))
							end
						end
					end
				end)
			end
		end
	end)
end

Toggle = GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Train_Drago_v4", {
	Text = "Auto Train Drago v4",
	Default = false,
	Callback = function(p247)
		_G.TrainDrago = p247
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.TrainDrago then
					local t40 = {
						"Venomous Assailant",
						"Hydra Enforcer"
					}
					local v1047 = #t40
					local n8 = 1
					local v1049 = v1047 + 0
					local v1050 = 1 - n8
					local exitTo

					for i = 1, v1047 do
						if plr.Character:FindFirstChild("RaceEnergy").Value == 1 then
							exitTo = 1

							break
						end

						if plr.Character:FindFirstChild("RaceTransformed").Value == false then
							local v1053 = GetConnectionEnemies(t40)

							if not v1053 then
								exitTo = 2

								break
							end

							while true do
								wait()
								t9.Kill(v1053, _G.TrainDrago)

								if _G.TrainDrago == false then
									break
								elseif v1053.Humanoid.Health <= 0 or not v1053.Parent then
									break
								end
							end
						end
					end

					local exitTo2, exitTo5, Character, Character2, v1058, exitTo6, exitTo7, exitTo8, exitTo9, exitTo10, exitTo19

					if exitTo == 1 then
						vim1:SendKeyEvent(true, "Y", true, game)
						replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
						vim1:SendKeyEvent(false, "Y", true, game)
						_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
						exitTo2 = nil
						exitTo5 = nil

						while true do
							v1050 += n8

							if not (n8 <= 0) then
								exitTo5 = 1

								break
							end

							if not (v1050 >= v1049) then
								break
							end

							Character = plr.Character

							if Character:FindFirstChild("RaceEnergy").Value == 1 then
								exitTo5 = 2

								break
							end

							Character2 = plr.Character

							if Character2:FindFirstChild("RaceTransformed").Value == false then
								v1058 = GetConnectionEnemies(t40)

								if v1058 then
									while true do
										wait()
										t9.Kill(v1058, _G.TrainDrago)

										if _G.TrainDrago == false then
											break
										elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
											break
										end
									end
								else
									_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
								end
							end
						end

						if exitTo5 == 1 then
							if v1050 <= v1049 then
								local exitTo18

								while true do
									Character = plr.Character

									if Character:FindFirstChild("RaceEnergy").Value == 1 then
										exitTo18 = 1

										break
									end

									Character2 = plr.Character

									if Character2:FindFirstChild("RaceTransformed").Value == false then
										v1058 = GetConnectionEnemies(t40)

										if v1058 then
											exitTo6 = nil

											while true do
												wait()
												t9.Kill(v1058, _G.TrainDrago)

												if _G.TrainDrago == false then
													break
												elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
													exitTo6 = 1

													break
												end
											end

											if exitTo6 == 1 then
												exitTo7 = nil

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo7 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo7 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	break
																end
															end
														else
															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														end
													end
												end

												if exitTo7 == 1 then
													if v1050 <= v1049 then
														continue
													end

													exitTo18 = 8

													break
												end

												exitTo18 = 7

												break
											end

											exitTo8 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo8 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo8 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo8 == 1 then
												if v1050 <= v1049 then
													continue
												end

												exitTo18 = 6

												break
											end

											exitTo18 = 5

											break
										end

										_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
										exitTo9 = nil

										while true do
											v1050 += n8

											if not (n8 <= 0) then
												exitTo9 = 1

												break
											end

											if not (v1050 >= v1049) then
												break
											end

											Character = plr.Character

											if Character:FindFirstChild("RaceEnergy").Value == 1 then
												exitTo9 = 2

												break
											end

											Character2 = plr.Character

											if Character2:FindFirstChild("RaceTransformed").Value == false then
												v1058 = GetConnectionEnemies(t40)

												if v1058 then
													while true do
														wait()
														t9.Kill(v1058, _G.TrainDrago)

														if _G.TrainDrago == false then
															break
														elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
															break
														end
													end
												else
													_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
												end
											end
										end

										if exitTo9 == 1 then
											if v1050 <= v1049 then
												continue
											end

											exitTo18 = 4

											break
										end

										exitTo18 = 3

										break
									end

									exitTo10 = nil

									while true do
										v1050 += n8

										if not (n8 <= 0) then
											exitTo10 = 1

											break
										end

										if not (v1050 >= v1049) then
											break
										end

										Character = plr.Character

										if Character:FindFirstChild("RaceEnergy").Value == 1 then
											exitTo10 = 2

											break
										end

										Character2 = plr.Character

										if Character2:FindFirstChild("RaceTransformed").Value == false then
											v1058 = GetConnectionEnemies(t40)

											if v1058 then
												while true do
													wait()
													t9.Kill(v1058, _G.TrainDrago)

													if _G.TrainDrago == false then
														break
													elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
														break
													end
												end
											else
												_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											end
										end
									end

									if exitTo10 == 1 then
										if v1050 <= v1049 then
											continue
										end

										exitTo18 = 2

										break
									end

									break
								end

								if exitTo18 == 1 then
									exitTo2 = 1

									if exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo18 == 2 then
									if exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo18 == 3 then
									if exitTo9 == 2 then
										exitTo2 = 1

										if exitTo2 == 1 then
											while true do
												vim1:SendKeyEvent(true, "Y", true, game)
												replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
												vim1:SendKeyEvent(false, "Y", true, game)
												_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
												exitTo2 = nil
												exitTo5 = nil

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo5 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo5 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	break
																end
															end
														else
															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														end
													end
												end

												if exitTo5 == 1 then
													if v1050 <= v1049 then
														exitTo19 = nil

														while true do
															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo19 = 1

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	exitTo6 = nil

																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			exitTo6 = 1

																			break
																		end
																	end

																	if exitTo6 == 1 then
																		exitTo7 = nil

																		while true do
																			v1050 += n8

																			if not (n8 <= 0) then
																				exitTo7 = 1

																				break
																			end

																			if not (v1050 >= v1049) then
																				break
																			end

																			Character = plr.Character

																			if Character:FindFirstChild("RaceEnergy").Value == 1 then
																				exitTo7 = 2

																				break
																			end

																			Character2 = plr.Character

																			if Character2:FindFirstChild("RaceTransformed").Value == false then
																				v1058 = GetConnectionEnemies(t40)

																				if v1058 then
																					while true do
																						wait()
																						t9.Kill(v1058, _G.TrainDrago)

																						if _G.TrainDrago == false then
																							break
																						elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																							break
																						end
																					end
																				else
																					_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																				end
																			end
																		end

																		if exitTo7 == 1 then
																			if v1050 <= v1049 then
																				continue
																			end

																			exitTo19 = 8

																			break
																		end

																		exitTo19 = 7

																		break
																	end

																	exitTo8 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo8 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo8 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo8 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 6

																		break
																	end

																	exitTo19 = 5

																	break
																end

																_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																exitTo9 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo9 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo9 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo9 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 4

																	break
																end

																exitTo19 = 3

																break
															end

															exitTo10 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo10 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo10 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo10 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 2

																break
															end

															break
														end

														if exitTo19 == 1 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 2 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 3 then
															if exitTo9 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 4 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 5 then
															if exitTo8 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 6 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 7 then
															if exitTo7 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 8 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo10 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo5 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end

												break
											end
										end
									elseif exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo18 == 4 then
									if exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo18 == 5 then
									if exitTo8 == 2 then
										exitTo2 = 1

										if exitTo2 == 1 then
											while true do
												vim1:SendKeyEvent(true, "Y", true, game)
												replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
												vim1:SendKeyEvent(false, "Y", true, game)
												_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
												exitTo2 = nil
												exitTo5 = nil

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo5 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo5 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	break
																end
															end
														else
															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														end
													end
												end

												if exitTo5 == 1 then
													if v1050 <= v1049 then
														exitTo19 = nil

														while true do
															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo19 = 1

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	exitTo6 = nil

																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			exitTo6 = 1

																			break
																		end
																	end

																	if exitTo6 == 1 then
																		exitTo7 = nil

																		while true do
																			v1050 += n8

																			if not (n8 <= 0) then
																				exitTo7 = 1

																				break
																			end

																			if not (v1050 >= v1049) then
																				break
																			end

																			Character = plr.Character

																			if Character:FindFirstChild("RaceEnergy").Value == 1 then
																				exitTo7 = 2

																				break
																			end

																			Character2 = plr.Character

																			if Character2:FindFirstChild("RaceTransformed").Value == false then
																				v1058 = GetConnectionEnemies(t40)

																				if v1058 then
																					while true do
																						wait()
																						t9.Kill(v1058, _G.TrainDrago)

																						if _G.TrainDrago == false then
																							break
																						elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																							break
																						end
																					end
																				else
																					_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																				end
																			end
																		end

																		if exitTo7 == 1 then
																			if v1050 <= v1049 then
																				continue
																			end

																			exitTo19 = 8

																			break
																		end

																		exitTo19 = 7

																		break
																	end

																	exitTo8 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo8 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo8 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo8 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 6

																		break
																	end

																	exitTo19 = 5

																	break
																end

																_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																exitTo9 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo9 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo9 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo9 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 4

																	break
																end

																exitTo19 = 3

																break
															end

															exitTo10 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo10 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo10 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo10 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 2

																break
															end

															break
														end

														if exitTo19 == 1 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 2 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 3 then
															if exitTo9 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 4 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 5 then
															if exitTo8 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 6 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 7 then
															if exitTo7 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 8 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo10 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo5 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end

												break
											end
										end
									elseif exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo18 == 6 then
									if exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo18 == 7 then
									if exitTo7 == 2 then
										exitTo2 = 1

										if exitTo2 == 1 then
											while true do
												vim1:SendKeyEvent(true, "Y", true, game)
												replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
												vim1:SendKeyEvent(false, "Y", true, game)
												_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
												exitTo2 = nil
												exitTo5 = nil

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo5 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo5 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	break
																end
															end
														else
															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														end
													end
												end

												if exitTo5 == 1 then
													if v1050 <= v1049 then
														exitTo19 = nil

														while true do
															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo19 = 1

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	exitTo6 = nil

																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			exitTo6 = 1

																			break
																		end
																	end

																	if exitTo6 == 1 then
																		exitTo7 = nil

																		while true do
																			v1050 += n8

																			if not (n8 <= 0) then
																				exitTo7 = 1

																				break
																			end

																			if not (v1050 >= v1049) then
																				break
																			end

																			Character = plr.Character

																			if Character:FindFirstChild("RaceEnergy").Value == 1 then
																				exitTo7 = 2

																				break
																			end

																			Character2 = plr.Character

																			if Character2:FindFirstChild("RaceTransformed").Value == false then
																				v1058 = GetConnectionEnemies(t40)

																				if v1058 then
																					while true do
																						wait()
																						t9.Kill(v1058, _G.TrainDrago)

																						if _G.TrainDrago == false then
																							break
																						elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																							break
																						end
																					end
																				else
																					_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																				end
																			end
																		end

																		if exitTo7 == 1 then
																			if v1050 <= v1049 then
																				continue
																			end

																			exitTo19 = 8

																			break
																		end

																		exitTo19 = 7

																		break
																	end

																	exitTo8 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo8 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo8 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo8 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 6

																		break
																	end

																	exitTo19 = 5

																	break
																end

																_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																exitTo9 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo9 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo9 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo9 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 4

																	break
																end

																exitTo19 = 3

																break
															end

															exitTo10 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo10 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo10 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo10 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 2

																break
															end

															break
														end

														if exitTo19 == 1 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 2 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 3 then
															if exitTo9 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 4 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 5 then
															if exitTo8 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 6 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 7 then
															if exitTo7 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 8 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo10 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo5 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end

												break
											end
										end
									elseif exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo18 == 8 then
									if exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo10 == 2 then
									exitTo2 = 1

									if exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo2 == 1 then
									while true do
										vim1:SendKeyEvent(true, "Y", true, game)
										replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
										vim1:SendKeyEvent(false, "Y", true, game)
										_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
										exitTo2 = nil
										exitTo5 = nil

										while true do
											v1050 += n8

											if not (n8 <= 0) then
												exitTo5 = 1

												break
											end

											if not (v1050 >= v1049) then
												break
											end

											Character = plr.Character

											if Character:FindFirstChild("RaceEnergy").Value == 1 then
												exitTo5 = 2

												break
											end

											Character2 = plr.Character

											if Character2:FindFirstChild("RaceTransformed").Value == false then
												v1058 = GetConnectionEnemies(t40)

												if v1058 then
													while true do
														wait()
														t9.Kill(v1058, _G.TrainDrago)

														if _G.TrainDrago == false then
															break
														elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
															break
														end
													end
												else
													_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
												end
											end
										end

										if exitTo5 == 1 then
											if v1050 <= v1049 then
												exitTo19 = nil

												while true do
													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo19 = 1

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															exitTo6 = nil

															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	exitTo6 = 1

																	break
																end
															end

															if exitTo6 == 1 then
																exitTo7 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo7 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo7 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo7 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 8

																	break
																end

																exitTo19 = 7

																break
															end

															exitTo8 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo8 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo8 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo8 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 6

																break
															end

															exitTo19 = 5

															break
														end

														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														exitTo9 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo9 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo9 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo9 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 4

															break
														end

														exitTo19 = 3

														break
													end

													exitTo10 = nil

													while true do
														v1050 += n8

														if not (n8 <= 0) then
															exitTo10 = 1

															break
														end

														if not (v1050 >= v1049) then
															break
														end

														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo10 = 2

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		break
																	end
																end
															else
																_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															end
														end
													end

													if exitTo10 == 1 then
														if v1050 <= v1049 then
															continue
														end

														exitTo19 = 2

														break
													end

													break
												end

												if exitTo19 == 1 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 2 then
													if exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 3 then
													if exitTo9 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 4 then
													if exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 5 then
													if exitTo8 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 6 then
													if exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 7 then
													if exitTo7 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 8 then
													if exitTo2 == 1 then
														continue
													end
												elseif exitTo10 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end
										elseif exitTo5 == 2 then
											exitTo2 = 1

											if exitTo2 == 1 then
												continue
											end
										elseif exitTo2 == 1 then
											continue
										end

										break
									end
								end
							elseif exitTo2 == 1 then
								while true do
									vim1:SendKeyEvent(true, "Y", true, game)
									replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
									vim1:SendKeyEvent(false, "Y", true, game)
									_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
									exitTo2 = nil
									exitTo5 = nil

									while true do
										v1050 += n8

										if not (n8 <= 0) then
											exitTo5 = 1

											break
										end

										if not (v1050 >= v1049) then
											break
										end

										Character = plr.Character

										if Character:FindFirstChild("RaceEnergy").Value == 1 then
											exitTo5 = 2

											break
										end

										Character2 = plr.Character

										if Character2:FindFirstChild("RaceTransformed").Value == false then
											v1058 = GetConnectionEnemies(t40)

											if v1058 then
												while true do
													wait()
													t9.Kill(v1058, _G.TrainDrago)

													if _G.TrainDrago == false then
														break
													elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
														break
													end
												end
											else
												_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											end
										end
									end

									if exitTo5 == 1 then
										if v1050 <= v1049 then
											exitTo19 = nil

											while true do
												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo19 = 1

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														exitTo6 = nil

														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																exitTo6 = 1

																break
															end
														end

														if exitTo6 == 1 then
															exitTo7 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo7 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo7 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo7 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 8

																break
															end

															exitTo19 = 7

															break
														end

														exitTo8 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo8 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo8 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo8 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 6

															break
														end

														exitTo19 = 5

														break
													end

													_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													exitTo9 = nil

													while true do
														v1050 += n8

														if not (n8 <= 0) then
															exitTo9 = 1

															break
														end

														if not (v1050 >= v1049) then
															break
														end

														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo9 = 2

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		break
																	end
																end
															else
																_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															end
														end
													end

													if exitTo9 == 1 then
														if v1050 <= v1049 then
															continue
														end

														exitTo19 = 4

														break
													end

													exitTo19 = 3

													break
												end

												exitTo10 = nil

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo10 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo10 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	break
																end
															end
														else
															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														end
													end
												end

												if exitTo10 == 1 then
													if v1050 <= v1049 then
														continue
													end

													exitTo19 = 2

													break
												end

												break
											end

											if exitTo19 == 1 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 2 then
												if exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 3 then
												if exitTo9 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 4 then
												if exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 5 then
												if exitTo8 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 6 then
												if exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 7 then
												if exitTo7 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 8 then
												if exitTo2 == 1 then
													continue
												end
											elseif exitTo10 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end
										elseif exitTo2 == 1 then
											continue
										end
									elseif exitTo5 == 2 then
										exitTo2 = 1

										if exitTo2 == 1 then
											continue
										end
									elseif exitTo2 == 1 then
										continue
									end

									break
								end
							end
						elseif exitTo5 == 2 then
							exitTo2 = 1

							if exitTo2 == 1 then
								while true do
									vim1:SendKeyEvent(true, "Y", true, game)
									replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
									vim1:SendKeyEvent(false, "Y", true, game)
									_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
									exitTo2 = nil
									exitTo5 = nil

									while true do
										v1050 += n8

										if not (n8 <= 0) then
											exitTo5 = 1

											break
										end

										if not (v1050 >= v1049) then
											break
										end

										Character = plr.Character

										if Character:FindFirstChild("RaceEnergy").Value == 1 then
											exitTo5 = 2

											break
										end

										Character2 = plr.Character

										if Character2:FindFirstChild("RaceTransformed").Value == false then
											v1058 = GetConnectionEnemies(t40)

											if v1058 then
												while true do
													wait()
													t9.Kill(v1058, _G.TrainDrago)

													if _G.TrainDrago == false then
														break
													elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
														break
													end
												end
											else
												_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											end
										end
									end

									if exitTo5 == 1 then
										if v1050 <= v1049 then
											exitTo19 = nil

											while true do
												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo19 = 1

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														exitTo6 = nil

														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																exitTo6 = 1

																break
															end
														end

														if exitTo6 == 1 then
															exitTo7 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo7 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo7 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo7 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 8

																break
															end

															exitTo19 = 7

															break
														end

														exitTo8 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo8 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo8 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo8 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 6

															break
														end

														exitTo19 = 5

														break
													end

													_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													exitTo9 = nil

													while true do
														v1050 += n8

														if not (n8 <= 0) then
															exitTo9 = 1

															break
														end

														if not (v1050 >= v1049) then
															break
														end

														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo9 = 2

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		break
																	end
																end
															else
																_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															end
														end
													end

													if exitTo9 == 1 then
														if v1050 <= v1049 then
															continue
														end

														exitTo19 = 4

														break
													end

													exitTo19 = 3

													break
												end

												exitTo10 = nil

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo10 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo10 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	break
																end
															end
														else
															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														end
													end
												end

												if exitTo10 == 1 then
													if v1050 <= v1049 then
														continue
													end

													exitTo19 = 2

													break
												end

												break
											end

											if exitTo19 == 1 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 2 then
												if exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 3 then
												if exitTo9 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 4 then
												if exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 5 then
												if exitTo8 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 6 then
												if exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 7 then
												if exitTo7 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo19 == 8 then
												if exitTo2 == 1 then
													continue
												end
											elseif exitTo10 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end
										elseif exitTo2 == 1 then
											continue
										end
									elseif exitTo5 == 2 then
										exitTo2 = 1

										if exitTo2 == 1 then
											continue
										end
									elseif exitTo2 == 1 then
										continue
									end

									break
								end
							end
						elseif exitTo2 == 1 then
							while true do
								vim1:SendKeyEvent(true, "Y", true, game)
								replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
								vim1:SendKeyEvent(false, "Y", true, game)
								_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
								exitTo2 = nil
								exitTo5 = nil

								while true do
									v1050 += n8

									if not (n8 <= 0) then
										exitTo5 = 1

										break
									end

									if not (v1050 >= v1049) then
										break
									end

									Character = plr.Character

									if Character:FindFirstChild("RaceEnergy").Value == 1 then
										exitTo5 = 2

										break
									end

									Character2 = plr.Character

									if Character2:FindFirstChild("RaceTransformed").Value == false then
										v1058 = GetConnectionEnemies(t40)

										if v1058 then
											while true do
												wait()
												t9.Kill(v1058, _G.TrainDrago)

												if _G.TrainDrago == false then
													break
												elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
													break
												end
											end
										else
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
										end
									end
								end

								if exitTo5 == 1 then
									if v1050 <= v1049 then
										exitTo19 = nil

										while true do
											Character = plr.Character

											if Character:FindFirstChild("RaceEnergy").Value == 1 then
												exitTo19 = 1

												break
											end

											Character2 = plr.Character

											if Character2:FindFirstChild("RaceTransformed").Value == false then
												v1058 = GetConnectionEnemies(t40)

												if v1058 then
													exitTo6 = nil

													while true do
														wait()
														t9.Kill(v1058, _G.TrainDrago)

														if _G.TrainDrago == false then
															break
														elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
															exitTo6 = 1

															break
														end
													end

													if exitTo6 == 1 then
														exitTo7 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo7 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo7 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo7 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 8

															break
														end

														exitTo19 = 7

														break
													end

													exitTo8 = nil

													while true do
														v1050 += n8

														if not (n8 <= 0) then
															exitTo8 = 1

															break
														end

														if not (v1050 >= v1049) then
															break
														end

														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo8 = 2

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		break
																	end
																end
															else
																_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															end
														end
													end

													if exitTo8 == 1 then
														if v1050 <= v1049 then
															continue
														end

														exitTo19 = 6

														break
													end

													exitTo19 = 5

													break
												end

												_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
												exitTo9 = nil

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo9 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo9 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	break
																end
															end
														else
															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														end
													end
												end

												if exitTo9 == 1 then
													if v1050 <= v1049 then
														continue
													end

													exitTo19 = 4

													break
												end

												exitTo19 = 3

												break
											end

											exitTo10 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo10 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo10 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo10 == 1 then
												if v1050 <= v1049 then
													continue
												end

												exitTo19 = 2

												break
											end

											break
										end

										if exitTo19 == 1 then
											exitTo2 = 1

											if exitTo2 == 1 then
												continue
											end
										elseif exitTo19 == 2 then
											if exitTo2 == 1 then
												continue
											end
										elseif exitTo19 == 3 then
											if exitTo9 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end
										elseif exitTo19 == 4 then
											if exitTo2 == 1 then
												continue
											end
										elseif exitTo19 == 5 then
											if exitTo8 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end
										elseif exitTo19 == 6 then
											if exitTo2 == 1 then
												continue
											end
										elseif exitTo19 == 7 then
											if exitTo7 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end
										elseif exitTo19 == 8 then
											if exitTo2 == 1 then
												continue
											end
										elseif exitTo10 == 2 then
											exitTo2 = 1

											if exitTo2 == 1 then
												continue
											end
										elseif exitTo2 == 1 then
											continue
										end
									elseif exitTo2 == 1 then
										continue
									end
								elseif exitTo5 == 2 then
									exitTo2 = 1

									if exitTo2 == 1 then
										continue
									end
								elseif exitTo2 == 1 then
									continue
								end

								break
							end
						end
					elseif exitTo == 2 then
						local exitTo4

						while true do
							_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))

							local exitTo3
							local exitTo11

							while true do
								v1050 += n8

								if not (n8 <= 0) then
									exitTo11 = 1

									break
								end

								if not (v1050 >= v1049) then
									break
								end

								Character = plr.Character

								if Character:FindFirstChild("RaceEnergy").Value == 1 then
									exitTo11 = 2

									break
								end

								Character2 = plr.Character

								if Character2:FindFirstChild("RaceTransformed").Value ~= false then
									continue
								end

								v1058 = GetConnectionEnemies(t40)

								if not v1058 then
									exitTo11 = 3

									break
								end

								while true do
									wait()
									t9.Kill(v1058, _G.TrainDrago)

									if _G.TrainDrago == false then
										break
									elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
										break
									end
								end
							end

							if exitTo11 == 1 then
								if v1050 <= v1049 then
									while true do
										Character = plr.Character

										if Character:FindFirstChild("RaceEnergy").Value == 1 then
											exitTo3 = 1

											break
										end

										Character2 = plr.Character

										if Character2:FindFirstChild("RaceTransformed").Value == false then
											v1058 = GetConnectionEnemies(t40)

											if not v1058 then
												exitTo3 = 2

												break
											end

											local exitTo12

											while true do
												wait()
												t9.Kill(v1058, _G.TrainDrago)

												if _G.TrainDrago == false then
													break
												elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
													exitTo12 = 1

													break
												end
											end

											if exitTo12 == 1 then
												local exitTo13

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo13 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo13 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value ~= false then
														continue
													end

													v1058 = GetConnectionEnemies(t40)

													if not v1058 then
														exitTo13 = 3

														break
													end

													while true do
														wait()
														t9.Kill(v1058, _G.TrainDrago)

														if _G.TrainDrago == false then
															break
														elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
															break
														end
													end
												end

												if exitTo13 == 1 then
													if v1050 <= v1049 then
														continue
													end
												else
													if exitTo13 == 2 then
														exitTo3 = 1
													elseif exitTo13 == 3 then
														exitTo3 = 2
													end

													break
												end
											else
												local exitTo14

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo14 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo14 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value ~= false then
														continue
													end

													v1058 = GetConnectionEnemies(t40)

													if not v1058 then
														exitTo14 = 3

														break
													end

													while true do
														wait()
														t9.Kill(v1058, _G.TrainDrago)

														if _G.TrainDrago == false then
															break
														elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
															break
														end
													end
												end

												if exitTo14 == 1 then
													if v1050 <= v1049 then
														continue
													end
												else
													if exitTo14 == 2 then
														exitTo3 = 1
													elseif exitTo14 == 3 then
														exitTo3 = 2
													end

													break
												end
											end
										else
											local exitTo15

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo15 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo15 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value ~= false then
													continue
												end

												v1058 = GetConnectionEnemies(t40)

												if not v1058 then
													exitTo15 = 3

													break
												end

												while true do
													wait()
													t9.Kill(v1058, _G.TrainDrago)

													if _G.TrainDrago == false then
														break
													elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
														break
													end
												end
											end

											if exitTo15 == 1 then
												if v1050 <= v1049 then
													continue
												end
											else
												if exitTo15 == 2 then
													exitTo3 = 1
												elseif exitTo15 == 3 then
													exitTo3 = 2
												end

												break
											end
										end

										break
									end
								end
							elseif exitTo11 == 2 then
								exitTo3 = 1
							elseif exitTo11 == 3 then
								exitTo3 = 2
							end

							if exitTo3 == 1 then
								exitTo4 = 1

								break
							elseif exitTo3 == 2 then
								continue
							end

							break
						end

						if exitTo4 == 1 then
							local exitTo17

							while true do
								vim1:SendKeyEvent(true, "Y", true, game)
								replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
								vim1:SendKeyEvent(false, "Y", true, game)
								_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
								exitTo2 = nil

								local exitTo16

								while true do
									v1050 += n8

									if not (n8 <= 0) then
										exitTo16 = 1

										break
									end

									if not (v1050 >= v1049) then
										break
									end

									Character = plr.Character

									if Character:FindFirstChild("RaceEnergy").Value == 1 then
										exitTo16 = 2

										break
									end

									Character2 = plr.Character

									if Character2:FindFirstChild("RaceTransformed").Value == false then
										v1058 = GetConnectionEnemies(t40)

										if v1058 then
											while true do
												wait()
												t9.Kill(v1058, _G.TrainDrago)

												if _G.TrainDrago == false then
													break
												elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
													break
												end
											end
										else
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
										end
									end
								end

								if exitTo16 ~= 1 then
									if exitTo16 == 2 then
										exitTo2 = 1
									end

									if exitTo2 ~= 1 then
										break
									end
								elseif v1050 <= v1049 then
									exitTo17 = 1

									break
								elseif exitTo2 == 1 then
									continue
								end

								break
							end

							if exitTo17 == 1 then
								local exitTo20

								while true do
									Character = plr.Character

									if Character:FindFirstChild("RaceEnergy").Value == 1 then
										exitTo20 = 1

										break
									end

									Character2 = plr.Character

									if Character2:FindFirstChild("RaceTransformed").Value == false then
										v1058 = GetConnectionEnemies(t40)

										if v1058 then
											exitTo6 = nil

											while true do
												wait()
												t9.Kill(v1058, _G.TrainDrago)

												if _G.TrainDrago == false then
													break
												elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
													exitTo6 = 1

													break
												end
											end

											if exitTo6 == 1 then
												exitTo7 = nil

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo7 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo7 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	break
																end
															end
														else
															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														end
													end
												end

												if exitTo7 == 1 then
													if v1050 <= v1049 then
														continue
													end

													exitTo20 = 8

													break
												end

												exitTo20 = 7

												break
											end

											exitTo8 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo8 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo8 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo8 == 1 then
												if v1050 <= v1049 then
													continue
												end

												exitTo20 = 6

												break
											end

											exitTo20 = 5

											break
										end

										_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
										exitTo9 = nil

										while true do
											v1050 += n8

											if not (n8 <= 0) then
												exitTo9 = 1

												break
											end

											if not (v1050 >= v1049) then
												break
											end

											Character = plr.Character

											if Character:FindFirstChild("RaceEnergy").Value == 1 then
												exitTo9 = 2

												break
											end

											Character2 = plr.Character

											if Character2:FindFirstChild("RaceTransformed").Value == false then
												v1058 = GetConnectionEnemies(t40)

												if v1058 then
													while true do
														wait()
														t9.Kill(v1058, _G.TrainDrago)

														if _G.TrainDrago == false then
															break
														elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
															break
														end
													end
												else
													_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
												end
											end
										end

										if exitTo9 == 1 then
											if v1050 <= v1049 then
												continue
											end

											exitTo20 = 4

											break
										end

										exitTo20 = 3

										break
									end

									exitTo10 = nil

									while true do
										v1050 += n8

										if not (n8 <= 0) then
											exitTo10 = 1

											break
										end

										if not (v1050 >= v1049) then
											break
										end

										Character = plr.Character

										if Character:FindFirstChild("RaceEnergy").Value == 1 then
											exitTo10 = 2

											break
										end

										Character2 = plr.Character

										if Character2:FindFirstChild("RaceTransformed").Value == false then
											v1058 = GetConnectionEnemies(t40)

											if v1058 then
												while true do
													wait()
													t9.Kill(v1058, _G.TrainDrago)

													if _G.TrainDrago == false then
														break
													elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
														break
													end
												end
											else
												_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											end
										end
									end

									if exitTo10 == 1 then
										if v1050 <= v1049 then
											continue
										end

										exitTo20 = 2

										break
									end

									break
								end

								if exitTo20 == 1 then
									exitTo2 = 1

									if exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo20 == 2 then
									if exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo20 == 3 then
									if exitTo9 == 2 then
										exitTo2 = 1

										if exitTo2 == 1 then
											while true do
												vim1:SendKeyEvent(true, "Y", true, game)
												replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
												vim1:SendKeyEvent(false, "Y", true, game)
												_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
												exitTo2 = nil
												exitTo5 = nil

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo5 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo5 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	break
																end
															end
														else
															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														end
													end
												end

												if exitTo5 == 1 then
													if v1050 <= v1049 then
														exitTo19 = nil

														while true do
															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo19 = 1

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	exitTo6 = nil

																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			exitTo6 = 1

																			break
																		end
																	end

																	if exitTo6 == 1 then
																		exitTo7 = nil

																		while true do
																			v1050 += n8

																			if not (n8 <= 0) then
																				exitTo7 = 1

																				break
																			end

																			if not (v1050 >= v1049) then
																				break
																			end

																			Character = plr.Character

																			if Character:FindFirstChild("RaceEnergy").Value == 1 then
																				exitTo7 = 2

																				break
																			end

																			Character2 = plr.Character

																			if Character2:FindFirstChild("RaceTransformed").Value == false then
																				v1058 = GetConnectionEnemies(t40)

																				if v1058 then
																					while true do
																						wait()
																						t9.Kill(v1058, _G.TrainDrago)

																						if _G.TrainDrago == false then
																							break
																						elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																							break
																						end
																					end
																				else
																					_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																				end
																			end
																		end

																		if exitTo7 == 1 then
																			if v1050 <= v1049 then
																				continue
																			end

																			exitTo19 = 8

																			break
																		end

																		exitTo19 = 7

																		break
																	end

																	exitTo8 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo8 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo8 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo8 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 6

																		break
																	end

																	exitTo19 = 5

																	break
																end

																_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																exitTo9 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo9 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo9 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo9 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 4

																	break
																end

																exitTo19 = 3

																break
															end

															exitTo10 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo10 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo10 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo10 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 2

																break
															end

															break
														end

														if exitTo19 == 1 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 2 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 3 then
															if exitTo9 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 4 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 5 then
															if exitTo8 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 6 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 7 then
															if exitTo7 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 8 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo10 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo5 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end

												break
											end
										end
									elseif exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo20 == 4 then
									if exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo20 == 5 then
									if exitTo8 == 2 then
										exitTo2 = 1

										if exitTo2 == 1 then
											while true do
												vim1:SendKeyEvent(true, "Y", true, game)
												replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
												vim1:SendKeyEvent(false, "Y", true, game)
												_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
												exitTo2 = nil
												exitTo5 = nil

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo5 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo5 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	break
																end
															end
														else
															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														end
													end
												end

												if exitTo5 == 1 then
													if v1050 <= v1049 then
														exitTo19 = nil

														while true do
															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo19 = 1

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	exitTo6 = nil

																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			exitTo6 = 1

																			break
																		end
																	end

																	if exitTo6 == 1 then
																		exitTo7 = nil

																		while true do
																			v1050 += n8

																			if not (n8 <= 0) then
																				exitTo7 = 1

																				break
																			end

																			if not (v1050 >= v1049) then
																				break
																			end

																			Character = plr.Character

																			if Character:FindFirstChild("RaceEnergy").Value == 1 then
																				exitTo7 = 2

																				break
																			end

																			Character2 = plr.Character

																			if Character2:FindFirstChild("RaceTransformed").Value == false then
																				v1058 = GetConnectionEnemies(t40)

																				if v1058 then
																					while true do
																						wait()
																						t9.Kill(v1058, _G.TrainDrago)

																						if _G.TrainDrago == false then
																							break
																						elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																							break
																						end
																					end
																				else
																					_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																				end
																			end
																		end

																		if exitTo7 == 1 then
																			if v1050 <= v1049 then
																				continue
																			end

																			exitTo19 = 8

																			break
																		end

																		exitTo19 = 7

																		break
																	end

																	exitTo8 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo8 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo8 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo8 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 6

																		break
																	end

																	exitTo19 = 5

																	break
																end

																_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																exitTo9 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo9 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo9 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo9 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 4

																	break
																end

																exitTo19 = 3

																break
															end

															exitTo10 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo10 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo10 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo10 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 2

																break
															end

															break
														end

														if exitTo19 == 1 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 2 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 3 then
															if exitTo9 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 4 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 5 then
															if exitTo8 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 6 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 7 then
															if exitTo7 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 8 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo10 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo5 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end

												break
											end
										end
									elseif exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo20 == 6 then
									if exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo20 == 7 then
									if exitTo7 == 2 then
										exitTo2 = 1

										if exitTo2 == 1 then
											while true do
												vim1:SendKeyEvent(true, "Y", true, game)
												replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
												vim1:SendKeyEvent(false, "Y", true, game)
												_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
												exitTo2 = nil
												exitTo5 = nil

												while true do
													v1050 += n8

													if not (n8 <= 0) then
														exitTo5 = 1

														break
													end

													if not (v1050 >= v1049) then
														break
													end

													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo5 = 2

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	break
																end
															end
														else
															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														end
													end
												end

												if exitTo5 == 1 then
													if v1050 <= v1049 then
														exitTo19 = nil

														while true do
															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo19 = 1

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	exitTo6 = nil

																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			exitTo6 = 1

																			break
																		end
																	end

																	if exitTo6 == 1 then
																		exitTo7 = nil

																		while true do
																			v1050 += n8

																			if not (n8 <= 0) then
																				exitTo7 = 1

																				break
																			end

																			if not (v1050 >= v1049) then
																				break
																			end

																			Character = plr.Character

																			if Character:FindFirstChild("RaceEnergy").Value == 1 then
																				exitTo7 = 2

																				break
																			end

																			Character2 = plr.Character

																			if Character2:FindFirstChild("RaceTransformed").Value == false then
																				v1058 = GetConnectionEnemies(t40)

																				if v1058 then
																					while true do
																						wait()
																						t9.Kill(v1058, _G.TrainDrago)

																						if _G.TrainDrago == false then
																							break
																						elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																							break
																						end
																					end
																				else
																					_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																				end
																			end
																		end

																		if exitTo7 == 1 then
																			if v1050 <= v1049 then
																				continue
																			end

																			exitTo19 = 8

																			break
																		end

																		exitTo19 = 7

																		break
																	end

																	exitTo8 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo8 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo8 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo8 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 6

																		break
																	end

																	exitTo19 = 5

																	break
																end

																_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																exitTo9 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo9 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo9 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo9 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 4

																	break
																end

																exitTo19 = 3

																break
															end

															exitTo10 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo10 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo10 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo10 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 2

																break
															end

															break
														end

														if exitTo19 == 1 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 2 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 3 then
															if exitTo9 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 4 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 5 then
															if exitTo8 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 6 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 7 then
															if exitTo7 == 2 then
																exitTo2 = 1

																if exitTo2 == 1 then
																	continue
																end
															elseif exitTo2 == 1 then
																continue
															end
														elseif exitTo19 == 8 then
															if exitTo2 == 1 then
																continue
															end
														elseif exitTo10 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo5 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end

												break
											end
										end
									elseif exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo20 == 8 then
									if exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo10 == 2 then
									exitTo2 = 1

									if exitTo2 == 1 then
										while true do
											vim1:SendKeyEvent(true, "Y", true, game)
											replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
											vim1:SendKeyEvent(false, "Y", true, game)
											_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
											exitTo2 = nil
											exitTo5 = nil

											while true do
												v1050 += n8

												if not (n8 <= 0) then
													exitTo5 = 1

													break
												end

												if not (v1050 >= v1049) then
													break
												end

												Character = plr.Character

												if Character:FindFirstChild("RaceEnergy").Value == 1 then
													exitTo5 = 2

													break
												end

												Character2 = plr.Character

												if Character2:FindFirstChild("RaceTransformed").Value == false then
													v1058 = GetConnectionEnemies(t40)

													if v1058 then
														while true do
															wait()
															t9.Kill(v1058, _G.TrainDrago)

															if _G.TrainDrago == false then
																break
															elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																break
															end
														end
													else
														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
													end
												end
											end

											if exitTo5 == 1 then
												if v1050 <= v1049 then
													exitTo19 = nil

													while true do
														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo19 = 1

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																exitTo6 = nil

																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		exitTo6 = 1

																		break
																	end
																end

																if exitTo6 == 1 then
																	exitTo7 = nil

																	while true do
																		v1050 += n8

																		if not (n8 <= 0) then
																			exitTo7 = 1

																			break
																		end

																		if not (v1050 >= v1049) then
																			break
																		end

																		Character = plr.Character

																		if Character:FindFirstChild("RaceEnergy").Value == 1 then
																			exitTo7 = 2

																			break
																		end

																		Character2 = plr.Character

																		if Character2:FindFirstChild("RaceTransformed").Value == false then
																			v1058 = GetConnectionEnemies(t40)

																			if v1058 then
																				while true do
																					wait()
																					t9.Kill(v1058, _G.TrainDrago)

																					if _G.TrainDrago == false then
																						break
																					elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																						break
																					end
																				end
																			else
																				_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																			end
																		end
																	end

																	if exitTo7 == 1 then
																		if v1050 <= v1049 then
																			continue
																		end

																		exitTo19 = 8

																		break
																	end

																	exitTo19 = 7

																	break
																end

																exitTo8 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo8 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo8 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo8 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 6

																	break
																end

																exitTo19 = 5

																break
															end

															_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															exitTo9 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo9 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo9 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo9 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 4

																break
															end

															exitTo19 = 3

															break
														end

														exitTo10 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo10 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo10 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo10 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 2

															break
														end

														break
													end

													if exitTo19 == 1 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 2 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 3 then
														if exitTo9 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 4 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 5 then
														if exitTo8 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 6 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 7 then
														if exitTo7 == 2 then
															exitTo2 = 1

															if exitTo2 == 1 then
																continue
															end
														elseif exitTo2 == 1 then
															continue
														end
													elseif exitTo19 == 8 then
														if exitTo2 == 1 then
															continue
														end
													elseif exitTo10 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo5 == 2 then
												exitTo2 = 1

												if exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end

											break
										end
									end
								elseif exitTo2 == 1 then
									while true do
										vim1:SendKeyEvent(true, "Y", true, game)
										replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
										vim1:SendKeyEvent(false, "Y", true, game)
										_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
										exitTo2 = nil
										exitTo5 = nil

										while true do
											v1050 += n8

											if not (n8 <= 0) then
												exitTo5 = 1

												break
											end

											if not (v1050 >= v1049) then
												break
											end

											Character = plr.Character

											if Character:FindFirstChild("RaceEnergy").Value == 1 then
												exitTo5 = 2

												break
											end

											Character2 = plr.Character

											if Character2:FindFirstChild("RaceTransformed").Value == false then
												v1058 = GetConnectionEnemies(t40)

												if v1058 then
													while true do
														wait()
														t9.Kill(v1058, _G.TrainDrago)

														if _G.TrainDrago == false then
															break
														elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
															break
														end
													end
												else
													_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
												end
											end
										end

										if exitTo5 == 1 then
											if v1050 <= v1049 then
												exitTo19 = nil

												while true do
													Character = plr.Character

													if Character:FindFirstChild("RaceEnergy").Value == 1 then
														exitTo19 = 1

														break
													end

													Character2 = plr.Character

													if Character2:FindFirstChild("RaceTransformed").Value == false then
														v1058 = GetConnectionEnemies(t40)

														if v1058 then
															exitTo6 = nil

															while true do
																wait()
																t9.Kill(v1058, _G.TrainDrago)

																if _G.TrainDrago == false then
																	break
																elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																	exitTo6 = 1

																	break
																end
															end

															if exitTo6 == 1 then
																exitTo7 = nil

																while true do
																	v1050 += n8

																	if not (n8 <= 0) then
																		exitTo7 = 1

																		break
																	end

																	if not (v1050 >= v1049) then
																		break
																	end

																	Character = plr.Character

																	if Character:FindFirstChild("RaceEnergy").Value == 1 then
																		exitTo7 = 2

																		break
																	end

																	Character2 = plr.Character

																	if Character2:FindFirstChild("RaceTransformed").Value == false then
																		v1058 = GetConnectionEnemies(t40)

																		if v1058 then
																			while true do
																				wait()
																				t9.Kill(v1058, _G.TrainDrago)

																				if _G.TrainDrago == false then
																					break
																				elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																					break
																				end
																			end
																		else
																			_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																		end
																	end
																end

																if exitTo7 == 1 then
																	if v1050 <= v1049 then
																		continue
																	end

																	exitTo19 = 8

																	break
																end

																exitTo19 = 7

																break
															end

															exitTo8 = nil

															while true do
																v1050 += n8

																if not (n8 <= 0) then
																	exitTo8 = 1

																	break
																end

																if not (v1050 >= v1049) then
																	break
																end

																Character = plr.Character

																if Character:FindFirstChild("RaceEnergy").Value == 1 then
																	exitTo8 = 2

																	break
																end

																Character2 = plr.Character

																if Character2:FindFirstChild("RaceTransformed").Value == false then
																	v1058 = GetConnectionEnemies(t40)

																	if v1058 then
																		while true do
																			wait()
																			t9.Kill(v1058, _G.TrainDrago)

																			if _G.TrainDrago == false then
																				break
																			elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																				break
																			end
																		end
																	else
																		_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																	end
																end
															end

															if exitTo8 == 1 then
																if v1050 <= v1049 then
																	continue
																end

																exitTo19 = 6

																break
															end

															exitTo19 = 5

															break
														end

														_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
														exitTo9 = nil

														while true do
															v1050 += n8

															if not (n8 <= 0) then
																exitTo9 = 1

																break
															end

															if not (v1050 >= v1049) then
																break
															end

															Character = plr.Character

															if Character:FindFirstChild("RaceEnergy").Value == 1 then
																exitTo9 = 2

																break
															end

															Character2 = plr.Character

															if Character2:FindFirstChild("RaceTransformed").Value == false then
																v1058 = GetConnectionEnemies(t40)

																if v1058 then
																	while true do
																		wait()
																		t9.Kill(v1058, _G.TrainDrago)

																		if _G.TrainDrago == false then
																			break
																		elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																			break
																		end
																	end
																else
																	_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
																end
															end
														end

														if exitTo9 == 1 then
															if v1050 <= v1049 then
																continue
															end

															exitTo19 = 4

															break
														end

														exitTo19 = 3

														break
													end

													exitTo10 = nil

													while true do
														v1050 += n8

														if not (n8 <= 0) then
															exitTo10 = 1

															break
														end

														if not (v1050 >= v1049) then
															break
														end

														Character = plr.Character

														if Character:FindFirstChild("RaceEnergy").Value == 1 then
															exitTo10 = 2

															break
														end

														Character2 = plr.Character

														if Character2:FindFirstChild("RaceTransformed").Value == false then
															v1058 = GetConnectionEnemies(t40)

															if v1058 then
																while true do
																	wait()
																	t9.Kill(v1058, _G.TrainDrago)

																	if _G.TrainDrago == false then
																		break
																	elseif v1058.Humanoid.Health <= 0 or not v1058.Parent then
																		break
																	end
																end
															else
																_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
															end
														end
													end

													if exitTo10 == 1 then
														if v1050 <= v1049 then
															continue
														end

														exitTo19 = 2

														break
													end

													break
												end

												if exitTo19 == 1 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 2 then
													if exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 3 then
													if exitTo9 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 4 then
													if exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 5 then
													if exitTo8 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 6 then
													if exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 7 then
													if exitTo7 == 2 then
														exitTo2 = 1

														if exitTo2 == 1 then
															continue
														end
													elseif exitTo2 == 1 then
														continue
													end
												elseif exitTo19 == 8 then
													if exitTo2 == 1 then
														continue
													end
												elseif exitTo10 == 2 then
													exitTo2 = 1

													if exitTo2 == 1 then
														continue
													end
												elseif exitTo2 == 1 then
													continue
												end
											elseif exitTo2 == 1 then
												continue
											end
										elseif exitTo5 == 2 then
											exitTo2 = 1

											if exitTo2 == 1 then
												continue
											end
										elseif exitTo2 == 1 then
											continue
										end

										break
									end
								end
							end
						end
					end
				end
			end)
		end
	end)
end

dragoTpVolcano = GRP_Prehistoric_Drago_Trial:AddToggle("Tween_to_Drago_Trials", {
	Text = "Tween to Drago Trials",
	Default = false,
	Callback = function(p248)
		_G.TpDrago_Prehis = p248
	end
})
spawn(function()
	while wait(Sec) do
		if _G.TpDrago_Prehis then
			local TrialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")

			if TrialTeleport and TrialTeleport:IsA("Part") then
				local exitTo

				repeat
					_tp(CFrame.new(TrialTeleport.Position))
					exitTo = nil

					while wait(Sec) do
						if _G.TpDrago_Prehis then
							TrialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")

							if TrialTeleport and TrialTeleport:IsA("Part") then
								exitTo = 1

								break
							end
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end
end)

do
	bdrago = GRP_Prehistoric_Drago_Trial:AddToggle("Swap_Drago_Race", {
		Text = "Swap Drago Race",
		Default = false,
		Callback = function(p249)
			_G.BuyDrago = p249
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.BuyDrago then
				pcall(function()
					if (CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375).Position - Root.Position).Magnitude >= 300 then
						_tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
					else
						_tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
						replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
							NPC = "Dragon Wizard",
							Command = "DragonRace"
						} }))
					end
				end)
			end
		end
	end)
end

do
	UpTalon = GRP_Prehistoric_Drago_Trial:AddToggle("Upgrade_Dragon_Talon_With_Uzoth", {
		Text = "Upgrade Dragon Talon With Uzoth",
		Default = false,
		Callback = function(p250)
			_G.DT_Uzoth = p250
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.DT_Uzoth then
				local cFrame = CFrame.new(5661.89014, 1211.31909, 864.836731, 0.811413169, -1.36805838e-08, -0.584473014, 4.75227395e-08, 1, 4.25682458e-08, 0.584473014, -6.23161966e-08, 0.811413169)

				_tp(cFrame)

				if (cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 25 then
					replicated.Modules.Net["RF/InteractDragonQuest"]:InvokeServer({
						NPC = "Uzoth",
						Command = "Upgrade"
					})
				end
			end
		end
	end)
end

GRP_Prehistoric_Volcanic_Crafting = t15.Prehistoric:AddLeftGroupbox("Volcanic Crafting")
GRP_Prehistoric_Volcanic_Crafting:AddButton({
	Text = "Craft Dragonheart",
	Func = function()
		replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Dragonheart")
	end
})

do
	GRP_Prehistoric_Volcanic_Crafting:AddButton({
		Text = "Craft Dragonstorm",
		Func = function()
			replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Dragonstorm")
		end
	})
end

GRP_Prehistoric_Volcanic_Crafting:AddButton({
	Text = "Craft Dino Hood",
	Func = function()
		replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "DinoHood")
	end
})

do
	GRP_Prehistoric_Volcanic_Crafting:AddButton({
		Text = "Craft T-Rex Skull",
		Func = function()
			replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "TRexSkull")
		end
	})
end

GRP_Prehistoric_Prehistoric_Island = t15.Prehistoric:AddLeftGroupbox("Prehistoric Island")

do
	local v1079 = GRP_Prehistoric_Prehistoric_Island:AddLabel("")

	spawn(function()
		while wait(0.2) do
			if not workspace.Map:FindFirstChild("PrehistoricIsland") then
				if not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
					v1079:SetText("Prehistoric Island : False")

					continue
				end
			end

			v1079:SetText("Prehistoric Island : True")
		end
	end)
end

do
	GRP_Prehistoric_Prehistoric_Island:AddButton({
		Text = "Craft Volcanic Magnet",
		Func = function()
			replicated.Modules.Net["RF/Craft"]:InvokeServer("PossibleHardcode", "Volcanic Magnet")
		end
	})
end

do
	GRP_Prehistoric_Prehistoric_Island:AddToggle("Craft_Volcanic_Magnet", {
		Text = "Craft Volcanic Magnet",
		Default = false,
		Callback = function(p251)
			_G.Prehis_Find = p251
		end
	})
end

do
	task.spawn(function()
		local rfCraft = game:GetService("ReplicatedStorage").Modules.Net["RF/Craft"]

		while task.wait(0.3) do
			if getgenv().AutoCraftVolcanic then
				pcall(function()
					rfCraft:InvokeServer("PossibleHardcode", "Volcanic Magnet")
				end)
				getgenv().AutoCraftVolcanic = false
			end
		end
	end)
end

GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Find_Prehistoric_Island", {
	Text = "Auto Find Prehistoric Island",
	Default = false,
	Callback = function(p252)
		_G.Prehis_Find = p252
	end
})

do
	local u1081

	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Prehis_Find then
					local Character = plr.Character

					if not Character then
						return
					end

					local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
					local Humanoid = Character:FindFirstChild("Humanoid")

					if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then
						return
					end

					local PrehistoricIsland = workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island", true)

					if PrehistoricIsland then
						local HeadTeleport = PrehistoricIsland:FindFirstChild("HeadTeleport", true) or PrehistoricIsland:FindFirstChild("Teleport_Head", true) or PrehistoricIsland:FindFirstChild("Head", true)

						if HeadTeleport then
							local CFrame_ = HeadTeleport.CFrame
							local v1088 = CFrame_.Position - CFrame_.LookVector * 40 + Vector3.new(0, 20, 0)

							if (v1088 - HumanoidRootPart.Position).Magnitude > 30 then
								_tp(CFrame.new(v1088))
							end
						else
							local Position = PrehistoricIsland.CFrame.Position

							_tp(CFrame.new(Position - (Position - HumanoidRootPart.Position).Unit * 250 + Vector3.new(0, 60, 0)))
						end
					else
						local v1090 = CheckBoat()

						if not v1090 then
							local cFrame = CFrame.new(-16927.451, 9.086, 433.864)

							TeleportToTarget(cFrame)

							if (cFrame.Position - HumanoidRootPart.Position).Magnitude <= 10 then
								replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat or "Guardian")
							end

							return
						end

						if Humanoid.Sit == false then
							_tp(v1090.VehicleSeat.CFrame * CFrame.new(0, 1, 0))

							return
						end

						local cFrame = CFrame.new(-10000000, 31, 37016.25)

						u1081 = cFrame

						if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
							_tp(CFrame.new(-10000000, 150, 37016.25))
						else
							_tp(cFrame)
						end
					end
				end
			end)
		end
	end)
end

do
	GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Start_Prehistoric_Event", {
		Text = "Auto Start Prehistoric Event",
		Default = false,
		Callback = function(p253)
			_G.AutoStartPrehistoric = p253
		end
	})
end

do
	spawn(function()
		while wait() do
			if _G.AutoStartPrehistoric then
				pcall(function()
					if workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island", true) then
						if workspace.Map:FindFirstChild("PrehistoricIsland", true) then
							local ActivationPrompt = workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt", true)

							if ActivationPrompt and ActivationPrompt:FindFirstChild("ProximityPrompt") then
								if plr:DistanceFromCharacter(ActivationPrompt.CFrame.Position) <= 150 then
									fireproximityprompt(ActivationPrompt.ProximityPrompt, math.huge)
									vim1:SendKeyEvent(true, "E", true, game)
									wait(1.5)
									vim1:SendKeyEvent(false, "E", true, game)
								end

								_tp(ActivationPrompt.CFrame)
							end
						end
					end
				end)
			end
		end
	end)
end

do
	GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Patch_Prehistoric_Event", {
		Text = "Auto Patch Prehistoric Event",
		Default = false,
		Callback = function(p254)
			_G.Prehis_Skills = p254
		end
	})
end

spawn(function()
	while wait(0.3) do
		if _G.Prehis_Skills then
			pcall(function()
				local PrehistoricIsland = workspace.Map:FindFirstChild("PrehistoricIsland")

				if not PrehistoricIsland then
					return
				end

				for _, descendant in pairs(PrehistoricIsland:GetDescendants()) do
					if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
						if descendant.Name:lower():find("lava") then
							descendant:Destroy()
						end
					end
				end

				local Core = PrehistoricIsland:FindFirstChild("Core")

				if Core then
					local InteriorLava = Core:FindFirstChild("InteriorLava")

					if InteriorLava then
						InteriorLava:Destroy()
					end
				end

				local TrialTeleport = PrehistoricIsland:FindFirstChild("TrialTeleport")

				for _, descendant in pairs(PrehistoricIsland:GetDescendants()) do
					if descendant.Name == "TouchInterest" and (not TrialTeleport or not descendant:IsDescendantOf(TrialTeleport)) then
						descendant.Parent:Destroy()
					end
				end
			end)
		end
	end
end)
spawn(function()
	while wait(Sec) do
		if _G.Prehis_Skills then
			pcall(function()
				local v1102 = GetConnectionEnemies("Lava Golem")

				if v1102 and v1102:FindFirstChild("Humanoid") then
					while true do
						wait(0.1)
						t9.Kill(v1102, true)
						v1102.Humanoid:ChangeState(15)

						if _G.Prehis_Skills then
							if not v1102.Parent or v1102.Humanoid.Health <= 0 then
								break
							end
						else
							break
						end
					end
				end
			end)
		end
	end
end)

do
	spawn(function()
		while wait(Sec) do
			if _G.Prehis_Skills then
				pcall(function()
					local PrehistoricIsland = workspace.Map:FindFirstChild("PrehistoricIsland")

					if not PrehistoricIsland then
						return
					end

					local Core = PrehistoricIsland:FindFirstChild("Core")

					if not Core then
						return
					end

					local VolcanoRocks = Core:FindFirstChild("VolcanoRocks")

					if not VolcanoRocks then
						return
					end

					for _, child in pairs(VolcanoRocks:GetChildren()) do
						local VFXLayer = child:FindFirstChild("VFXLayer")
						local At0 = VFXLayer and VFXLayer:FindFirstChild("At0")
						local Glow = At0 and At0:FindFirstChild("Glow")

						if Glow and Glow.Enabled then
							repeat
								wait(0.1)
								_tp(VFXLayer.CFrame)

								if plr:DistanceFromCharacter(VFXLayer.CFrame.Position) <= 150 then
									MousePos = VFXLayer.CFrame.Position
									Useskills("Melee", "Z")
									wait(0.4)
									Useskills("Melee", "X")
									wait(0.4)
									Useskills("Melee", "C")
									wait(0.4)
									Useskills("Blox Fruit", "Z")
									wait(0.4)
									Useskills("Blox Fruit", "X")
									wait(0.4)
									Useskills("Blox Fruit", "C")
								end
							until not _G.Prehis_Skills or not Glow.Enabled
						end
					end
				end)
			end
		end
	end)
end

Kaura = GRP_Prehistoric_Prehistoric_Island:AddToggle("Kill_Aura", {
	Text = "Kill Aura",
	Default = false,
	Callback = function(p255)
		_G.KillAuraFull = p255
	end
})
spawn(function()
	while task.wait(2) do
		if _G.KillAuraFull then
			local exitTo

			repeat
				pcall(function()
					local LocalPlayer = game.Players.LocalPlayer
					local Character = LocalPlayer.Character
					local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

					if not HumanoidRootPart then
						return
					end

					sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)

					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") and (child.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 500 and child.Humanoid.Health > 0 then
							child.Humanoid.Health = 0
							child.HumanoidRootPart.CanCollide = false
							child:BreakJoints()
						end
					end
				end)
				exitTo = nil

				while task.wait(2) do
					if _G.KillAuraFull then
						exitTo = 1

						break
					end
				end
			until exitTo ~= 1

			return
		end
	end
end)
Vocan = GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Collect_Dino_Bones", {
	Text = "Auto Collect Dino Bones",
	Default = false,
	Callback = function(p256)
		_G.Prehis_DB = p256
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Prehis_DB then
				if workspace:FindFirstChild("DinoBone") then
					for _, child in pairs(workspace:GetChildren()) do
						if child.Name == "DinoBone" then
							_tp(child.CFrame)
						end
					end
				end
			end
		end)
	end
end)

do
	Vocan = GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Collect_Dragon_Eggs", {
		Text = "Auto Collect Dragon Eggs",
		Default = false,
		Callback = function(p257)
			_G.Prehis_DE = p257
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Prehis_DE then
				if workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg") then
					_tp(workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg").Molten.CFrame)
					fireproximityprompt(workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs.DragonEgg.Molten.ProximityPrompt, 30)
				end
			end
		end)
	end
end)

do
	Toggle = GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Reset_When_Complete_Volcano", {
		Text = "Auto Reset When Complete Volcano",
		Default = false,
		Callback = function(p258)
			_G.ResetPH = p258
		end
	})
end

spawn(function()
	if wait(Sec) then
		repeat
			pcall(function()
				if _G.ResetPH then
					local TrialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")

					if TrialTeleport and TrialTeleport:FindFirstChild("TouchInterest") then
						plr.Character.Humanoid.Health = 0
					elseif workspace:FindFirstChild("DinoBone") then
						for _, child in pairs(workspace:GetChildren()) do
							if child.Name == "DinoBone" then
								_tp(child.CFrame)
							end
						end
					end
				end
			end)
		until not wait(Sec)
	end
end)
GRP_SeaEvent_Sea_Event_Setting_Sail = t15.SeaEvent:AddLeftGroupbox("Sea Event / Setting Sail")
getgenv().SetSpeedBoat = 300
spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		if getgenv().SpeedBoat then
			local LocalPlayer = game:GetService("Players").LocalPlayer

			if LocalPlayer.Character then
				if LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Sit then
					for _, child in pairs(game:GetService("Workspace").Boats:GetChildren()) do
						local VehicleSeat = child:FindFirstChildWhichIsA("VehicleSeat")

						if VehicleSeat then
							VehicleSeat.MaxSpeed = getgenv().SetSpeedBoat
						end
					end
				end
			end
		end
	end)
end)
GRP_SeaEvent_Sea_Event_Setting_Sail:AddButton({
	Text = "Remove Lighting Effect",
	Func = function()
		pcall(function()
			game.Lighting.BaseAtmosphere:Destroy()
		end)
	end
})

do
	GRP_SeaEvent_Sea_Event_Setting_Sail:AddToggle("Ship_Speed_Modifier", {
		Text = "Ship Speed Modifier",
		Default = false,
		Callback = function(p259)
			getgenv().SpeedBoat = p259
		end
	})
end

GRP_SeaEvent_Sea_Event_Setting_Sail:AddSlider({
	Text = "Ship Speed",
	Min = 0,
	Max = 1000,
	Default = 300,
	Rounding = 0,
	Callback = function(p260)
		getgenv().SetSpeedBoat = p260
	end
})

do
	GRP_SeaEvent_Sea_Event_Setting_Sail:AddToggle("Auto_Press_W", {
		Text = "Auto Press W",
		Default = false,
		Callback = function(p261)
			getgenv().AutoPressW = p261
		end
	})
end

do
	spawn(function()
		while wait() do
			pcall(function()
				if getgenv().AutoPressW then
					if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
						game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", true, game)
						task.wait(0.1)
						game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", true, game)
					end
				end
			end)
		end
	end)
end

do
	GRP_SeaEvent_Sea_Event_Setting_Sail:AddToggle("No_Clip_Ship", {
		Text = "No Clip Ship",
		Default = false,
		Callback = function(p262)
			getgenv().NoClipShip = p262
		end
	})
end

do
	spawn(function()
		while wait() do
			pcall(function()
				for _, child in pairs(game:GetService("Workspace").Boats:GetChildren()) do
					for _, descendant in pairs(child:GetDescendants()) do
						if descendant:IsA("BasePart") then
							if getgenv().NoClipShip or getgenv().FindPrehistoric then
								descendant.CanCollide = false
							else
								descendant.CanCollide = true
							end
						end
					end
				end
			end)
		end
	end)
end

GRP_SeaEvent_Crafting_Items = t15.SeaEvent:AddLeftGroupbox("Crafting Items")

do
	GRP_SeaEvent_Crafting_Items:AddButton({
		Text = "Craft SharkTooth",
		Func = function()
			replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "SharkTooth")
		end
	})
end

GRP_SeaEvent_Crafting_Items:AddButton({
	Text = "Craft TerrorJaw",
	Func = function()
		replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "TerrorJaw")
	end
})

do
	GRP_SeaEvent_Crafting_Items:AddButton({
		Text = "Craft SharkAnchor",
		Func = function()
			replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "SharkAnchor")
		end
	})
end

GRP_SeaEvent_Crafting_Items:AddButton({
	Text = "Craft LeviathanCrown",
	Func = function()
		replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanCrown")
	end
})
GRP_SeaEvent_Crafting_Items:AddButton({
	Text = "Craft LeviathanShield",
	Func = function()
		replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanShield")
	end
})

do
	GRP_SeaEvent_Crafting_Items:AddButton({
		Text = "Craft LeviathanBoat",
		Func = function()
			replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanBoat")
		end
	})
end

GRP_SeaEvent_Crafting_Items:AddButton({
	Text = "Craft LegendaryScroll",
	Func = function()
		replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LegendaryScroll")
	end
})

do
	GRP_SeaEvent_Crafting_Items:AddButton({
		Text = "Craft MythicalScroll",
		Func = function()
			replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "MythicalScroll")
		end
	})
end

GRP_SeaEvent_Choose_Sea_Event = t15.SeaEvent:AddLeftGroupbox("Choose Sea Event")

do
	Q = GRP_SeaEvent_Choose_Sea_Event:AddDropdown("Select_Boats", {
		Text = "Select Boats",
		Values = {
			"Guardian",
			"PirateGrandBrigade",
			"MarineGrandBrigade",
			"PirateBrigade",
			"MarineBrigade",
			"PirateSloop",
			"MarineSloop",
			"Beast Hunter"
		},
		Default = 1,
		Callback = function(p263)
			_G.SelectedBoat = p263
		end
	})
end

GRP_SeaEvent_Choose_Sea_Event:AddButton({
	Text = "Buy Boats",
	Func = function()
		replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
	end
})
Q = GRP_SeaEvent_Choose_Sea_Event:AddDropdown("Select_Sea_Level", {
	Text = "Select Sea Level",
	Values = {
		"Lv 1",
		"Lv 2",
		"Lv 3",
		"Lv 4",
		"Lv 5",
		"Lv 6",
		"Lv Infinite"
	},
	Default = 1,
	Callback = function(p264)
		_G.DangerSc = p264
	end
})
Q = GRP_SeaEvent_Choose_Sea_Event:AddToggle("Auto_Sail_Boat", {
	Text = "Auto Sail Boat",
	Default = false,
	Callback = function(p265)
		_G.SailBoats = p265
	end
})

do
	spawn(function()
		while wait() do
			if _G.SailBoats then
				pcall(function()
					local v1130 = CheckBoat()

					if v1130 then
						if (not CheckShark() or not _G.Shark) and (not CheckTerrorShark() or not _G.TerrorShark) and (not CheckFishCrew() or not _G.MobCrew) then
							if (not CheckPiranha() or not _G.Piranha) and (not CheckEnemiesBoat() or not _G.FishBoat) and (not CheckSeaBeast() or not _G.SeaBeast1) and (not _G.PGB or not CheckPirateGrandBrigade()) and (not _G.HCM or not CheckHauntedCrew()) and (not _G.Leviathan1 or not CheckLeviathan()) then
								if plr.Character.Humanoid.Sit == false then
									_tp(v1130.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
								else
									if _G.DangerSc == "Lv 1" then
										CFrameSelectedZone = CFrame.new(-21998.375, 30.0006084, -682.309143)
									elseif _G.DangerSc == "Lv 2" then
										CFrameSelectedZone = CFrame.new(-26779.5215, 30.0005474, -822.858032)
									elseif _G.DangerSc == "Lv 3" then
										CFrameSelectedZone = CFrame.new(-31171.957, 30.0001011, -2256.93774)
									elseif _G.DangerSc == "Lv 4" then
										CFrameSelectedZone = CFrame.new(-34054.6875, 30.2187767, -2560.12012)
									elseif _G.DangerSc == "Lv 5" then
										CFrameSelectedZone = CFrame.new(-38887.5547, 30.0004578, -2162.99023)
									elseif _G.DangerSc == "Lv 6" then
										CFrameSelectedZone = CFrame.new(-44541.7617, 30.0003204, -1244.8584)
									elseif _G.DangerSc == "Lv Infinite" then
										CFrameSelectedZone = CFrame.new(-10000000, 31, 37016.25)
									end

									while true do
										wait()

										if (_G.FishBoat or not CheckEnemiesBoat()) and (_G.PGB or not CheckPirateGrandBrigade()) and (_G.TerrorShark or not CheckTerrorShark()) then
											_tp(CFrameSelectedZone)
										else
											_tp(CFrameSelectedZone * CFrame.new(0, 150, 0))
										end

										if _G.SailBoats ~= false and (not CheckShark() or not _G.Shark) and (not CheckTerrorShark() or not _G.TerrorShark) and (not CheckFishCrew() or not _G.MobCrew) and (not CheckPiranha() or not _G.Piranha) and (not CheckSeaBeast() or not _G.SeaBeast1) and (not CheckEnemiesBoat() or not _G.FishBoat) and (not _G.Leviathan1 or not CheckLeviathan()) and (not _G.HCM or not CheckHauntedCrew()) and (not _G.PGB or not CheckPirateGrandBrigade()) then
											if plr.Character:WaitForChild("Humanoid").Sit ~= false then
												continue
											end
										end

										break
									end

									plr.Character.Humanoid.Sit = false
								end
							end
						end
					elseif (not CheckShark() or not _G.Shark) and (not CheckTerrorShark() or not _G.TerrorShark) and (not CheckFishCrew() or not _G.MobCrew) and (not CheckPiranha() or not _G.Piranha) and (not CheckEnemiesBoat() or not _G.FishBoat) and (not CheckSeaBeast() or not _G.SeaBeast1) and (not _G.PGB or not CheckPirateGrandBrigade()) and (not _G.HCM or not CheckHauntedCrew()) and (not _G.Leviathan1 or not CheckLeviathan()) then
						local cFrame = CFrame.new(-16927.451, 9.086, 433.864)

						TeleportToTarget(cFrame)

						if (cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
						end
					end
				end)
			end
		end
	end)
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			for _, child in pairs(workspace.Boats:GetChildren()) do
				for _, descendant in pairs(child:GetDescendants()) do
					if descendant:IsA("BasePart") then
						if _G.SailBoats or _G.Prehis_Find or _G.FindMirage or _G.SailBoat_Hydra or _G.AutofindKitIs then
							descendant.CanCollide = false
						else
							descendant.CanCollide = true
						end
					end
				end
			end
		end)
	end
end)
GRP_SeaEvent_Entity_Sea_Event = t15.SeaEvent:AddLeftGroupbox("Entity Sea Event")
GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Shark", {
	Text = "Auto Shark",
	Default = false,
	Callback = function(p266)
		_G.Shark = p266
	end
})
GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Piranha", {
	Text = "Auto Piranha",
	Default = false,
	Callback = function(p267)
		_G.Piranha = p267
	end
})
GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Terror_Shark", {
	Text = "Auto Terror Shark",
	Default = false,
	Callback = function(p268)
		_G.TerrorShark = p268
	end
})
GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Fish_Crew_Member", {
	Text = "Auto Fish Crew Member",
	Default = false,
	Callback = function(p269)
		_G.MobCrew = p269
	end
})

do
	GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Haunted_Crew_Member", {
		Text = "Auto Haunted Crew Member",
		Default = false,
		Callback = function(p270)
			_G.HCM = p270
		end
	})
end

do
	GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Attack_PirateGrandBrigade", {
		Text = "Auto Attack PirateGrandBrigade",
		Default = false,
		Callback = function(p271)
			_G.PGB = p271
		end
	})
end

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Attack_Fish_Boat", {
	Text = "Auto Attack Fish Boat",
	Default = false,
	Callback = function(p272)
		_G.FishBoat = p272
	end
})

do
	GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Attack_Sea_Beast", {
		Text = "Auto Attack Sea Beast",
		Default = false,
		Callback = function(p273)
			_G.SeaBeast1 = p273
		end
	})
end

spawn(function()
	while wait() do
		pcall(function()
			if _G.Shark then
				local t41 = { "Shark" }

				if CheckShark() then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if table.find(t41, child.Name) and t9.Alive(child) then
							while true do
								task.wait()
								t9.Kill(child, _G.Shark)

								if _G.Shark == false then
									break
								elseif not child.Parent or child.Humanoid.Health <= 0 then
									break
								end
							end
						end
					end
				end
			end

			if _G.TerrorShark then
				local t42 = { "Terrorshark" }

				if CheckTerrorShark() then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if table.find(t42, child.Name) and t9.Alive(child) then
							while true do
								task.wait()
								t9.KillSea(child, _G.TerrorShark)

								if _G.TerrorShark == false then
									break
								elseif not child.Parent or child.Humanoid.Health <= 0 then
									break
								end
							end
						end
					end
				end
			end

			if _G.Piranha then
				local t43 = { "Piranha" }

				if CheckPiranha() then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if table.find(t43, child.Name) and t9.Alive(child) then
							while true do
								task.wait()
								t9.Kill(child, _G.Piranha)

								if _G.Piranha == false then
									break
								elseif not child.Parent or child.Humanoid.Health <= 0 then
									break
								end
							end
						end
					end
				end
			end

			if _G.MobCrew then
				local t44 = { "Fish Crew Member" }

				if CheckFishCrew() then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if table.find(t44, child.Name) and t9.Alive(child) then
							while true do
								task.wait()
								t9.Kill(child, _G.MobCrew)

								if _G.MobCrew == false then
									break
								elseif not child.Parent or child.Humanoid.Health <= 0 then
									break
								end
							end
						end
					end
				end
			end

			if _G.HCM then
				local t45 = { "Haunted Crew Member" }

				if CheckHauntedCrew() then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if table.find(t45, child.Name) and t9.Alive(child) then
							while true do
								task.wait()
								t9.Kill(child, _G.HCM)

								if _G.HCM == false then
									break
								elseif not child.Parent or child.Humanoid.Health <= 0 then
									break
								end
							end
						end
					end
				end
			end

			if _G.SeaBeast1 then
				if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
					for _, child in pairs(workspace.SeaBeasts:GetChildren()) do
						if child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Health") and child.Health.Value > 0 then
							repeat
								task.wait()
								spawn(function()
									_tp(CFrame.new(child.HumanoidRootPart.Position.X, game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 200, child.HumanoidRootPart.Position.Z))
								end)

								if plr:DistanceFromCharacter(child.HumanoidRootPart.CFrame.Position) <= 500 then
									AitSeaSkill_Custom = child.HumanoidRootPart.CFrame
									MousePos = AitSeaSkill_Custom.Position

									if CheckF() then
										weaponSc("Blox Fruit")
										Useskills("Blox Fruit", "Z")
										Useskills("Blox Fruit", "X")
										Useskills("Blox Fruit", "C")
									else
										Useskills("Melee", "Z")
										Useskills("Melee", "X")
										Useskills("Melee", "C")
										wait(0.1)
										Useskills("Sword", "Z")
										Useskills("Sword", "X")
										wait(0.1)
										Useskills("Blox Fruit", "Z")
										Useskills("Blox Fruit", "X")
										Useskills("Blox Fruit", "C")
										wait(0.1)
										Useskills("Gun", "Z")
										Useskills("Gun", "X")
									end
								end
							until _G.SeaBeast1 == false or not child:FindFirstChild("HumanoidRootPart") or not child.Parent or child.Health.Value <= 0
						end
					end
				end
			end

			if _G.Leviathan1 then
				if workspace.SeaBeasts:FindFirstChild("Leviathan") then
					for _, child in pairs(workspace.SeaBeasts:GetChildren()) do
						if child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Leviathan Segment") and child:FindFirstChild("Health") and child.Health.Value > 0 then
							repeat
								task.wait()
								spawn(function()
									_tp(CFrame.new(child.HumanoidRootPart.Position.X, game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 200, child.HumanoidRootPart.Position.Z))
								end)

								if plr:DistanceFromCharacter(child.HumanoidRootPart.CFrame.Position) <= 500 then
									MousePos = child:FindFirstChild("Leviathan Segment").Position

									if CheckF() then
										weaponSc("Blox Fruit")
										Useskills("Blox Fruit", "Z")
										Useskills("Blox Fruit", "X")
										Useskills("Blox Fruit", "C")
									else
										Useskills("Melee", "Z")
										Useskills("Melee", "X")
										Useskills("Melee", "C")
										wait(0.1)
										Useskills("Sword", "Z")
										Useskills("Sword", "X")
										wait(0.1)
										Useskills("Blox Fruit", "Z")
										Useskills("Blox Fruit", "X")
										Useskills("Blox Fruit", "C")
										wait(0.1)
										Useskills("Gun", "Z")
										Useskills("Gun", "X")
									end
								end
							until _G.Leviathan1 == false or not child:FindFirstChild("HumanoidRootPart") or not child.Parent or child.Health.Value <= 0
						end
					end
				end
			end

			if _G.FishBoat and CheckEnemiesBoat() then
				for _, child in pairs(workspace.Enemies:GetChildren()) do
					if child:FindFirstChild("Health") and child.Health.Value > 0 and child:FindFirstChild("VehicleSeat") then
						repeat
							task.wait()
							spawn(function()
								if child.Name == "FishBoat" then
									_tp(child.Engine.CFrame * CFrame.new(0, -50, -25))
								end
							end)

							if plr:DistanceFromCharacter(child.Engine.CFrame.Position) <= 150 then
								AitSeaSkill_Custom = child.Engine.CFrame
								MousePos = AitSeaSkill_Custom.Position

								if CheckF() then
									weaponSc("Blox Fruit")
									Useskills("Blox Fruit", "Z")
									Useskills("Blox Fruit", "X")
									Useskills("Blox Fruit", "C")
								else
									Useskills("Melee", "Z")
									Useskills("Melee", "X")
									Useskills("Melee", "C")
									wait(0.1)
									Useskills("Sword", "Z")
									Useskills("Sword", "X")
									wait(0.1)
									Useskills("Blox Fruit", "Z")
									Useskills("Blox Fruit", "X")
									Useskills("Blox Fruit", "C")
									wait(0.1)
									Useskills("Gun", "Z")
									Useskills("Gun", "X")
								end
							end
						until _G.FishBoat == false or not child:FindFirstChild("VehicleSeat") or child.Health.Value <= 0
					end
				end
			end

			if _G.PGB and CheckPirateGrandBrigade() then
				for _, child in pairs(workspace.Enemies:GetChildren()) do
					if child:FindFirstChild("Health") and child.Health.Value > 0 and child:FindFirstChild("VehicleSeat") then
						repeat
							task.wait()
							spawn(function()
								if child.Name == "PirateBrigade" then
									_tp(child.Engine.CFrame * CFrame.new(0, -30, -10))
								elseif child.Name == "PirateGrandBrigade" then
									_tp(child.Engine.CFrame * CFrame.new(0, -50, -50))
								end
							end)

							if plr:DistanceFromCharacter(child.Engine.CFrame.Position) <= 150 then
								AitSeaSkill_Custom = child.Engine.CFrame
								MousePos = AitSeaSkill_Custom.Position

								if CheckF() then
									weaponSc("Blox Fruit")
									Useskills("Blox Fruit", "Z")
									Useskills("Blox Fruit", "X")
									Useskills("Blox Fruit", "C")
								else
									Useskills("Melee", "Z")
									Useskills("Melee", "X")
									Useskills("Melee", "C")
									wait(0.1)
									Useskills("Sword", "Z")
									Useskills("Sword", "X")
									wait(0.1)
									Useskills("Blox Fruit", "Z")
									Useskills("Blox Fruit", "X")
									Useskills("Blox Fruit", "C")
									wait(0.1)
									Useskills("Gun", "Z")
									Useskills("Gun", "X")
								end
							end
						until _G.PGB == false or not child:FindFirstChild("VehicleSeat") or child.Health.Value <= 0
					end
				end
			end
		end)
	end
end)
GRP_SeaEvent_Kitsune_Island_Event = t15.SeaEvent:AddLeftGroupbox("Kitsune Island / Event")

do
	local v1159 = GRP_SeaEvent_Kitsune_Island_Event:AddLabel("")

	spawn(function()
		while wait(0.2) do
			if not workspace.Map:FindFirstChild("KitsuneIsland") then
				if not workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
					v1159:SetText("Kitsune Island : False")

					continue
				end
			end

			v1159:SetText("Kitsune Island : True")
		end
	end)
end

GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Find_Kitsune_Island", {
	Text = "Auto Find Kitsune Island",
	Default = false,
	Callback = function(p274)
		_G.AutofindKitIs = p274
	end
})
spawn(function()
	while wait() do
		if _G.AutofindKitIs then
			pcall(function()
				if workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island", true) then
					_tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0, 500, 0))
				else
					local v1160 = CheckBoat()

					if v1160 then
						if plr.Character.Humanoid.Sit == false then
							_tp(v1160.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
						else
							local cFrame = CFrame.new(-10000000, 31, 37016.25)

							while true do
								wait()

								if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
									_tp(CFrame.new(-10000000, 150, 37016.25))
								else
									_tp(CFrame.new(-10000000, 31, 37016.25))
								end

								if _G.AutofindKitIs and not ((cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10) then
									if not (workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") or plr.Character.Humanoid.Sit == false) then
										continue
									end
								end

								break
							end

							plr.Character.Humanoid.Sit = false
						end
					else
						local cFrame = CFrame.new(-16927.451, 9.086, 433.864)

						TeleportToTarget(cFrame)

						if (cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
						end
					end
				end
			end)
		end
	end
end)

do
	GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Teleport_to_Shrine_Actived", {
		Text = "Auto Teleport to Shrine Actived",
		Default = false,
		Callback = function(p275)
			_G.tweenShrine = p275
		end
	})
end

do
	spawn(function()
		while wait(0.1) do
			if _G.tweenShrine then
				pcall(function()
					local KitsuneIsland = workspace.Map:FindFirstChild("KitsuneIsland") or game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island")
					local ShrineActive = KitsuneIsland:FindFirstChild("ShrineActive")

					if ShrineActive then
						local next_ = next
						local descendants, v1167 = ShrineActive:GetDescendants()

						for _, v1 in next_, descendants, v1167 do
							if v1:IsA("BasePart") then
								if v1.Name:find("NeonShrinePart") then
									replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()

									while true do
										wait()
										_tp(v1.CFrame * CFrame.new(0, 2, 0))

										if _G.tweenShrine == false then
											break
										elseif not KitsuneIsland then
											break
										end
									end
								end
							end
						end
					else
						_tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0, 500, 0))
					end
				end)
			end
		end
	end)
end

do
	GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Collect_Azure_Ember", {
		Text = "Auto Collect Azure Ember",
		Default = false,
		Callback = function(p276)
			_G.Collect_Ember = p276
		end
	})
end

spawn(function()
	while wait(0.1) do
		if _G.Collect_Ember then
			pcall(function()
				if workspace:WaitForChild("AttachedAzureEmber") then
					notween(workspace:WaitForChild("EmberTemplate"):FindFirstChild("Part").CFrame)
				else
					if workspace:WaitForChild("EmberTemplate") then
						notween(workspace:WaitForChild("EmberTemplate"):FindFirstChild("Part").CFrame)

						return
					end

					_tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0, 500, 0))
					replicated.Modules.Net["RF/KitsuneStatuePray"]:InvokeServer()
				end
			end)
		end
	end
end)

do
	GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Trade_Azure_Ember", {
		Text = "Auto Trade Azure Ember",
		Default = false,
		Callback = function(p277)
			_G.Trade_Ember = p277
		end
	})
end

do
	spawn(function()
		while wait(0.1) do
			if _G.Trade_Ember then
				pcall(function()
					if workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island", true) then
						replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
					end
				end)
			end
		end
	end)
end

GRP_SeaEvent_Kitsune_Island_Event:AddButton({
	Text = "Trade Items Azure",
	Func = function()
		if replicated.Modules and replicated.Modules.Net then
			local RFKitsuneStatuePray = replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray")

			if RFKitsuneStatuePray then
				RFKitsuneStatuePray:InvokeServer()
			end
		end
	end
})

do
	GRP_SeaEvent_Kitsune_Island_Event:AddButton({
		Text = "Talk with kitsune statue",
		Func = function()
			if replicated.Modules and replicated.Modules.Net then
				local RETouchKitsuneStatue = replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue")

				if RETouchKitsuneStatue then
					RETouchKitsuneStatue:FireServer()
				end
			end
		end
	})
end

GRP_SeaEvent_Frozen_Dimension_Event = t15.SeaEvent:AddLeftGroupbox("Frozen Dimension Event")

do
	local v1172 = GRP_SeaEvent_Frozen_Dimension_Event:AddLabel("")

	spawn(function()
		pcall(function()
			while wait(0.2) do
				if workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
					v1172:SetText("Frozen Dimension : True")
				else
					v1172:SetText("Frozen Dimension : False")
				end
			end
		end)
	end)
end

do
	local v1173 = GRP_SeaEvent_Frozen_Dimension_Event:AddLabel("")

	spawn(function()
		while wait(0.2) do
			pcall(function()
				local v1174 = string.match(replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "1"), "%d+")

				if v1174 then
					v1173:SetText("Giám sát Leviathan : " .. tostring(v1174))

					if tonumber(v1174) == 5 then
						v1173:SetText("Spy Leviathan : Already Done!!")
					end
				end
			end)
		end
	end)
end

GRP_SeaEvent_Frozen_Dimension_Event:AddButton({
	Text = "Buy Spy",
	Func = function()
		replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
	end
})
GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Teleport_Frozen_Dimension", {
	Text = "Auto Teleport Frozen Dimension",
	Default = false,
	Callback = function(p278)
		_G.FrozenTP = p278
	end
})
spawn(function()
	while wait(0.1) do
		if _G.FrozenTP then
			pcall(function()
				if workspace.Map:FindFirstChild("LeviathanGate") then
					_tp(workspace.Map.LeviathanGate.CFrame)
					replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("OpenLeviathanGate")
				end
			end)
		end
	end
end)

do
	GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Drive_To_Hydra_Island", {
		Text = "Auto Drive To Hydra Island",
		Default = false,
		Callback = function(p279)
			_G.SailBoat_Hydra = p279
		end
	})
end

spawn(function()
	while wait() do
		if _G.SailBoat_Hydra then
			pcall(function()
				local v1175 = CheckBoat()

				if v1175 then
					if plr.Character.Humanoid.Sit == false then
						_tp(v1175.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
					else
						while true do
							wait()

							if CheckEnemiesBoat() or CheckPirateGrandBrigade() or CheckTerrorShark() then
								_tp(CFrame.new(5433, 150, 290))
							else
								_tp(CFrame.new(5433, 35, 290))
							end

							if _G.SailBoat_Hydra ~= false then
								if plr.Character:WaitForChild("Humanoid").Sit ~= false then
									continue
								end
							end

							break
						end

						plr.Character.Humanoid.Sit = false
					end
				else
					local cFrame = CFrame.new(-16927.451, 9.086, 433.864)

					TeleportToTarget(cFrame)

					if (cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
						replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
					end
				end
			end)
		end
	end
end)

do
	GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Attack_Leviathan", {
		Text = "Auto Attack Leviathan",
		Default = false,
		Callback = function(p280)
			_G.Leviathan1 = p280
		end
	})
end

GRP_Esp_Esp = t15.Esp:AddLeftGroupbox("Esp")

do
	isnil = function(p281)
		return p281 == nil
	end
end

local function v1177(p282)
	return math.floor(tonumber(p282) + 0.5)
end

Number = math.random(1, 1000000)

local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
local Team = LocalPlayer.Team

EspPly = function()
	local children, v1182 = game.Players:GetChildren()

	for _, v1 in next, children, v1182 do
		pcall(function()
			if not isnil(v1.Character) then
				if PlayerEsp then
					local ok = isnil(v1.Character.Head)

					if not ok then
						ok = v1.Character.Head:FindFirstChild("NameEsp" .. Number)
					end

					if ok then
						if v1.Character.Head:FindFirstChild("NameEsp" .. Number) then
							v1.Character.Head["NameEsp" .. Number].TextLabel.Text = v1.Name .. " | " .. v1177((LocalPlayer.Character.Head.Position - v1.Character.Head.Position).Magnitude / 3) .. " M\nHealth : " .. v1177(v1.Character.Humanoid.Health * 100 / v1.Character.Humanoid.MaxHealth) .. "%"
						end
					else
						local BillboardGui = Instance.new("BillboardGui", v1.Character.Head)

						BillboardGui.Name = "NameEsp" .. Number
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = v1.Character.Head
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = Enum.Font.Code
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Text = v1.Name .. " \n" .. v1177((LocalPlayer.Character.Head.Position - v1.Character.Head.Position).Magnitude / 3) .. " M"
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5

						if v1.Team == Team then
							TextLabel.TextColor3 = Color3.new(0, 0, 254)
						else
							TextLabel.TextColor3 = Color3.new(255, 0, 0)
						end
					end
				elseif v1.Character.Head:FindFirstChild("NameEsp" .. Number) then
					v1.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
				end
			end
		end)
	end
end
LocationEsp = function()
	local children, v1189 = workspace._WorldOrigin.Locations:GetChildren()

	for _, v1 in next, children, v1189 do
		pcall(function()
			if IslandESP then
				if v1.Name ~= "Sea" then
					if v1:FindFirstChild("NameEsp") then
						v1.NameEsp.TextLabel.Text = v1.Name .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - v1.Position).Magnitude / 3) .. " M"
					else
						local BillboardGui = Instance.new("BillboardGui", v1)

						BillboardGui.Name = "NameEsp"
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = v1
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = Enum.Font.Code
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(98, 252, 252)
						TextLabel.Text = v1.Name .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - v1.Position).Magnitude / 3) .. " M"
					end
				end
			elseif v1:FindFirstChild("NameEsp") then
				v1:FindFirstChild("NameEsp"):Destroy()
			end
		end)
	end
end
DevEsp = function()
	local children, v1195 = workspace:GetChildren()

	for _, v1 in next, children, v1195 do
		pcall(function()
			if DevilFruitESP then
				if string.find(v1.Name, "Fruit") then
					if v1.Handle:FindFirstChild("NameEsp" .. Number) then
						v1.Handle["NameEsp" .. Number].TextLabel.Text = "[" .. v1.Name .. "]" .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - v1.Handle.Position).Magnitude / 3) .. " M"
					else
						local BillboardGui = Instance.new("BillboardGui", v1.Handle)

						BillboardGui.Name = "NameEsp" .. Number
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = v1.Handle
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = Enum.Font.Code
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
						TextLabel.Text = v1.Name .. " \n" .. v1177((LocalPlayer.Character.Head.Position - v1.Handle.Position).Magnitude / 3) .. " M"
					end
				end
			elseif v1:FindFirstChild("Handle") then
				if v1.Handle:FindFirstChild("NameEsp" .. Number) then
					v1.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
				end
			end
		end)
	end
end
flowerEsp = function()
	for _, child in pairs(workspace:GetChildren()) do
		pcall(function()
			if child.Name == "Flower2" or child.Name == "Flower1" then
				if FlowerESP then
					if child:FindFirstChild("NameEsp" .. Number) then
						child["NameEsp" .. Number].TextLabel.Text = child.Name .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - child.Position).Magnitude / 3) .. " M"
					else
						local BillboardGui = Instance.new("BillboardGui", child)

						BillboardGui.Name = "NameEsp" .. Number
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = child
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = Enum.Font.Code
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(88, 214, 252)

						if child.Name == "Flower1" then
							TextLabel.Text = "Blue Flower" .. " \n" .. v1177((LocalPlayer.Character.Head.Position - child.Position).Magnitude / 3) .. " M"
						elseif child.Name == "Flower2" then
							TextLabel.Text = "Red Flower" .. " \n" .. v1177((LocalPlayer.Character.Head.Position - child.Position).Magnitude / 3) .. " M"
						end
					end
				elseif child:FindFirstChild("NameEsp" .. Number) then
					child:FindFirstChild("NameEsp" .. Number):Destroy()
				end
			end
		end)
	end
end
EventIslandEsp = function()
	for _, child in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
		pcall(function()
			if EspEventIsland then
				if child.Name == "Mirage Island" or child.Name == "Prehistoric Island" or child.Name == "Kitsune Island" then
					if child:FindFirstChild("NameEsp") then
						child.NameEsp.TextLabel.Text = child.Name .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - child.Position).Magnitude / 3) .. " M"
					else
						local BillboardGui = Instance.new("BillboardGui", child)

						BillboardGui.Name = "NameEsp"
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = child
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = "Code"
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						TextLabel.Text = child.Name .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - child.Position).Magnitude / 3) .. " M"
					end
				end
			elseif child:FindFirstChild("NameEsp") then
				child:FindFirstChild("NameEsp"):Destroy()
			end
		end)
	end
end
gearEsp = function()
	local MysticIsland = workspace.Map:FindFirstChild("MysticIsland")

	for _, descendant in pairs(MysticIsland:GetDescendants()) do
		pcall(function()
			if ESPGear then
				if descendant.Name == "Part" and descendant.Material == Enum.Material.Neon then
					if descendant:FindFirstChild("NameEsp") then
						descendant.NameEsp.TextLabel.Text = "Gear" .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - descendant.Position).Magnitude / 3) .. " M"
					else
						local BillboardGui = Instance.new("BillboardGui", descendant)

						BillboardGui.Name = "NameEsp"
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = descendant
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = "Code"
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						TextLabel.Text = "Gear" .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - descendant.Position).Magnitude / 3) .. " M"
					end
				end
			elseif descendant:FindFirstChild("NameEsp") then
				descendant:FindFirstChild("NameEsp"):Destroy()
			end
		end)
	end
end
AdvanFruitEsp = function()
	if advanEsp then
		for _, child in pairs(ReplicatedStorage2.NPCs:GetChildren()) do
			if child.Name == "Advanced Fruit Dealer" then
				if not workspace:FindFirstChild("Adv") then
					Adv = Instance.new("Part")
					Adv.Name = "Adv"
					Adv.Transparency = 1
					Adv.Size = Vector3.new(1, 1, 1)
					Adv.Anchored = true
					Adv.CanCollide = false
					Adv.Parent = workspace
					Adv.CFrame = child.HumanoidRootPart.CFrame
				elseif workspace:FindFirstChild("Adv") then
					if Adv:FindFirstChild("NameEsp") then
						Adv.NameEsp.TextLabel.Text = child.Name .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - child.HumanoidRootPart.Position).Magnitude / 3) .. " M"
					else
						local BillboardGui = Instance.new("BillboardGui", Adv)

						BillboardGui.Name = "NameEsp"
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = Adv
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = "Code"
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						TextLabel.Text = child.Name .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - child.HumanoidRootPart.Position).Magnitude / 3) .. " M"
					end
				end
			end
		end
	elseif workspace:FindFirstChild("Adv") then
		workspace:FindFirstChild("Adv"):Destroy()
	end
end
HakiClorEsp = function()
	if ColorEsp then
		for _, child in pairs(ReplicatedStorage2.NPCs:GetChildren()) do
			if child.Name == "Barista Cousin" then
				if not workspace:FindFirstChild("Gay") then
					Gay = Instance.new("Part")
					Gay.Name = "Gay"
					Gay.Transparency = 1
					Gay.Size = Vector3.new(1, 1, 1)
					Gay.Anchored = true
					Gay.CanCollide = false
					Gay.Parent = workspace
					Gay.CFrame = child.HumanoidRootPart.CFrame
				elseif workspace:FindFirstChild("Gay") then
					if Gay:FindFirstChild("NameEsp") then
						Gay.NameEsp.TextLabel.Text = child.Name .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - child.HumanoidRootPart.Position).Magnitude / 3) .. " M"
					else
						local BillboardGui = Instance.new("BillboardGui", Gay)

						BillboardGui.Name = "NameEsp"
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = Gay
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = "Code"
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						TextLabel.Text = child.Name .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - child.HumanoidRootPart.Position).Magnitude / 3) .. " M"
					end
				end
			end
		end
	elseif workspace:FindFirstChild("Gay") then
		workspace:FindFirstChild("Gay"):Destroy()
	end
end
LegenSword = function()
	if LegenS then
		for _, child in pairs(ReplicatedStorage2.NPCs:GetChildren()) do
			if child.Name == "Legendary Sword Dealer" then
				if not workspace:FindFirstChild("Lgd") then
					Lgd = Instance.new("Part")
					Lgd.Name = "Lgd"
					Lgd.Transparency = 1
					Lgd.Size = Vector3.new(1, 1, 1)
					Lgd.Anchored = true
					Lgd.CanCollide = false
					Lgd.Parent = workspace
					Lgd.CFrame = child.HumanoidRootPart.CFrame
				elseif workspace:FindFirstChild("Lgd") then
					if Lgd:FindFirstChild("NameEsp") then
						Lgd.NameEsp.TextLabel.Text = child.Name .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - child.HumanoidRootPart.Position).Magnitude / 3) .. " M"
					else
						local BillboardGui = Instance.new("BillboardGui", Lgd)

						BillboardGui.Name = "NameEsp"
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = Lgd
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = "Code"
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						TextLabel.Text = child.Name .. "   \n" .. v1177((LocalPlayer.Character.Head.Position - child.HumanoidRootPart.Position).Magnitude / 3) .. " M"
					end
				end
			end
		end
	elseif workspace:FindFirstChild("Lgd") then
		workspace:FindFirstChild("Lgd"):Destroy()
	end
end

do
	ChestEsp = function()
		if ChestESP then
			local tagged = game:GetService("CollectionService"):GetTagged("_ChestTagged")

			for _, v1 in ipairs(tagged) do
				pcall(function()
					local Magnitude = (v1:GetPivot().Position - LocalPlayer.Character.Head.Position).Magnitude

					v1:GetFullName():gsub("[^%w_]", "_")

					local ChestEspAttachment = v1:FindFirstChild("ChestEspAttachment")

					if not ChestEspAttachment then
						local Attachment = Instance.new("Attachment")

						Attachment.Name = "ChestEspAttachment"
						Attachment.Parent = v1
						Attachment.Position = Vector3.new(0, 3, 0)

						local BillboardGui = Instance.new("BillboardGui")

						BillboardGui.Name = "NameEsp"
						BillboardGui.Size = UDim2.new(0, 200, 0, 30)
						BillboardGui.Adornee = Attachment
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.AlwaysOnTop = true
						BillboardGui.Parent = Attachment

						local TextLabel = Instance.new("TextLabel")

						TextLabel.Font = Enum.Font.Code
						TextLabel.TextSize = 14
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = Enum.TextYAlignment.Top
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						TextLabel.Parent = BillboardGui
					end

					local NameEsp = ChestEspAttachment and ChestEspAttachment:FindFirstChild("NameEsp")

					if NameEsp then
						local v1234 = math.floor(Magnitude / 3)

						NameEsp.TextLabel.Text = string.format("[%s] %d M", v1.Name:gsub("Label", ""), v1234)
					end
				end)
			end
		else
			for _, v1 in ipairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
				local ChestEspAttachment = v1:FindFirstChild("ChestEspAttachment")

				if ChestEspAttachment then
					ChestEspAttachment:Destroy()
				end
			end
		end
	end
end

berriesEsp = function()
	if BerryEsp then
		local tagged = game:GetService("CollectionService"):GetTagged("BerryBush")

		for _, v1 in ipairs(tagged) do
			pcall(function()
				local Position = v1.Parent:GetPivot().Position

				for _, v2 in pairs(v1:GetAttributes()) do
					if v2 then
						local name = "BerryEspPart_" .. v2 .. "_" .. tostring(Position)
						local Part2 = workspace:FindFirstChild(name)

						if not Part2 then
							Part2 = Instance.new("Part")
							Part2.Name = name
							Part2.Transparency = 1
							Part2.Size = Vector3.new(1, 1, 1)
							Part2.Anchored = true
							Part2.CanCollide = false
							Part2.Parent = workspace
							Part2.CFrame = CFrame.new(Position)
						end

						if not Part2:FindFirstChild("NameEsp") then
							local BillboardGui = Instance.new("BillboardGui", Part2)

							BillboardGui.Name = "NameEsp"
							BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
							BillboardGui.Size = UDim2.new(0, 200, 0, 30)
							BillboardGui.Adornee = Part2
							BillboardGui.AlwaysOnTop = true

							local TextLabel = Instance.new("TextLabel", BillboardGui)

							TextLabel.Font = Enum.Font.Code
							TextLabel.TextSize = 14
							TextLabel.TextWrapped = true
							TextLabel.Size = UDim2.new(1, 0, 1, 0)
							TextLabel.TextYAlignment = Enum.TextYAlignment.Top
							TextLabel.BackgroundTransparency = 1
							TextLabel.TextStrokeTransparency = 0.5
							TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						end

						local NameEsp = Part2:FindFirstChild("NameEsp")
						local v1249 = (LocalPlayer.Character.Head.Position - Position).Magnitude / 3

						if NameEsp then
							NameEsp.TextLabel.Text = "[" .. v2 .. "]" .. " " .. math.round(v1249) .. " M"
						end
					end
				end
			end)
		end
	else
		for _, child in ipairs(workspace:GetChildren()) do
			if child:IsA("Part") then
				if child.Name:match("BerryEspPart_.*") then
					child:Destroy()
				end
			end
		end
	end
end

do
	GRP_Esp_Esp:AddToggle("Esp_Berry", {
		Text = "Esp Berry",
		Default = false,
		Callback = function(p283)
			BerryEsp = p283

			if p283 then
				task.spawn(function()
					while BerryEsp do
						berriesEsp()
						task.wait()
					end
				end)
			else
				for _, child in ipairs(workspace:GetChildren()) do
					if child:IsA("Part") then
						if child.Name:match("BerryEspPart_.*") then
							child:Destroy()
						end
					end
				end
			end
		end
	})
end

GRP_Esp_Esp:AddToggle("Esp_Player", {
	Text = "Esp Player",
	Default = false,
	Callback = function(p284)
		PlayerEsp = p284

		if p284 then
			task.spawn(function()
				while PlayerEsp do
					EspPly()
					task.wait()
				end
			end)
		else
			local next_ = next
			local children, v1256 = game.Players:GetChildren()

			for _, v1 in next_, children, v1256 do
				pcall(function()
					if not (isnil(v1.Character) or isnil(v1.Character.Head)) then
						if v1.Character.Head:FindFirstChild("NameEsp" .. Number) then
							v1.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
						end
					end
				end)
			end
		end
	end
})
GRP_Esp_Esp:AddToggle("Esp_Chest", {
	Text = "Esp Chest",
	Default = false,
	Callback = function(p285)
		ChestESP = p285

		if p285 then
			task.spawn(function()
				while ChestESP do
					ChestEsp()
					task.wait()
				end
			end)
		else
			for _, v1 in ipairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
				local ChestEspAttachment = v1:FindFirstChild("ChestEspAttachment")

				if ChestEspAttachment then
					ChestEspAttachment:Destroy()
				end
			end
		end
	end
})
GRP_Esp_Esp:AddToggle("Esp_Fruit", {
	Text = "Esp Fruit",
	Default = false,
	Callback = function(p286)
		DevilFruitESP = p286

		if p286 then
			task.spawn(function()
				while DevilFruitESP do
					DevEsp()
					task.wait()
				end
			end)
		else
			local next_ = next
			local children, v1264 = workspace:GetChildren()

			for _, v1 in next_, children, v1264 do
				pcall(function()
					if v1:FindFirstChild("Handle") then
						if v1.Handle:FindFirstChild("NameEsp" .. Number) then
							v1.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
						end
					end
				end)
			end
		end
	end
})
GRP_Esp_Esp:AddToggle("Esp_Island", {
	Text = "Esp Island",
	Default = false,
	Callback = function(p287)
		IslandESP = p287

		if p287 then
			task.spawn(function()
				while IslandESP do
					LocationEsp()
					task.wait()
				end
			end)
		else
			local next_ = next
			local children, v1269 = workspace._WorldOrigin.Locations:GetChildren()

			for _, v1 in next_, children, v1269 do
				pcall(function()
					if v1:FindFirstChild("NameEsp") then
						v1:FindFirstChild("NameEsp"):Destroy()
					end
				end)
			end
		end
	end
})

do
	GRP_Esp_Esp:AddToggle("Esp_Flower", {
		Text = "Esp Flower",
		Default = false,
		Callback = function(p288)
			FlowerESP = p288

			if p288 then
				task.spawn(function()
					while FlowerESP do
						flowerEsp()
						task.wait()
					end
				end)
			else
				for _, child in pairs(workspace:GetChildren()) do
					pcall(function()
						if (child.Name == "Flower2" or child.Name == "Flower1") and child:FindFirstChild("NameEsp" .. Number) then
							child:FindFirstChild("NameEsp" .. Number):Destroy()
						end
					end)
				end
			end
		end
	})
end

do
	GRP_Esp_Esp:AddToggle("Esp_Legendary_Sword", {
		Text = "Esp Legendary Sword",
		Default = false,
		Callback = function(p289)
			LegenS = p289

			if p289 then
				task.spawn(function()
					while LegenS do
						LegenSword()
						task.wait()
					end
				end)
			elseif workspace:FindFirstChild("Lgd") then
				workspace:FindFirstChild("Lgd"):Destroy()
			end
		end
	})
end

do
	GRP_Esp_Esp:AddToggle("Esp_Haki_Color", {
		Text = "Esp Haki Color",
		Default = false,
		Callback = function(p290)
			ColorEsp = p290

			if p290 then
				task.spawn(function()
					while ColorEsp do
						HakiClorEsp()
						task.wait()
					end
				end)
			elseif workspace:FindFirstChild("Gay") then
				workspace:FindFirstChild("Gay"):Destroy()
			end
		end
	})
end

GRP_Esp_Esp:AddToggle("Esp_Gear", {
	Text = "Esp Gear",
	Default = false,
	Callback = function(p291)
		ESPGear = p291

		if p291 then
			task.spawn(function()
				while ESPGear do
					gearEsp()
					task.wait()
				end
			end)
		else
			local pairs_ = pairs
			local MysticIsland = workspace.Map:FindFirstChild("MysticIsland")

			for _, descendant in pairs_(MysticIsland:GetDescendants()) do
				pcall(function()
					if descendant:FindFirstChild("NameEsp") then
						descendant:FindFirstChild("NameEsp"):Destroy()
					end
				end)
			end
		end
	end
})

do
	GRP_Esp_Esp:AddToggle("Esp_SeaEvent_Island", {
		Text = "Esp SeaEvent Island",
		Default = false,
		Callback = function(p292)
			EspEventIsland = p292

			if p292 then
				task.spawn(function()
					while EspEventIsland do
						EventIslandEsp()
						task.wait()
					end
				end)
			else
				for _, child in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
					pcall(function()
						if child:FindFirstChild("NameEsp") then
							child:FindFirstChild("NameEsp"):Destroy()
						end
					end)
				end
			end
		end
	})
end

do
	GRP_Esp_Esp:AddToggle("Esp_Advanced_Dealer", {
		Text = "Esp Advanced Dealer",
		Default = false,
		Callback = function(p293)
			advanEsp = p293

			if p293 then
				task.spawn(function()
					while advanEsp do
						AdvanFruitEsp()
						task.wait()
					end
				end)
			elseif workspace:FindFirstChild("Adv") then
				workspace:FindFirstChild("Adv"):Destroy()
			end
		end
	})
end

GRP_Raids_Fruits_Options = t15.Raids:AddLeftGroupbox("Fruits Options")

do
	local function v1280(p294)
		local v1281 = tostring(p294)
		local v1282

		repeat
			v1281, v1282 = v1281:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
		until v1282 == 0

		return v1281
	end
	local function v1283()
		local s18 = "Advance Fruit Stock\n"
		local ok, result = pcall(function()
			return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", true)
		end)

		if ok and result then
			local v1287 = false

			for _, v1 in pairs(result) do
				if v1.OnSale then
					v1287 = true
					s18 ..= v1.Name .. " - $" .. v1280(v1.Price) .. "\n"
				end
			end

			if not v1287 then
				s18 ..= "- No fruit.\n"
			end
		else
			s18 ..= "- Error while retrieving data.\n"
		end

		local v1290 = s18 .. "\nNormal Fruit Stock\n"
		local ok2, result2 = pcall(function()
			return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
		end)

		if ok2 and result2 then
			local v1293 = false

			for _, v1 in pairs(result2) do
				if v1.OnSale then
					v1293 = true
					v1290 ..= v1.Name .. " - $" .. v1280(v1.Price) .. "\n"
				end
			end

			if not v1293 then
				v1290 ..= "- No fruit.\n"
			end
		else
			v1290 ..= "- Error while retrieving data.\n"
		end

		return v1290
	end

	local v1296 = GRP_Raids_Fruits_Options:AddLabel("Loading...")

	task.spawn(function()
		while task.wait(60) do
			pcall(function()
				v1296:SetText(v1283())
			end)
		end
	end)
	pcall(function()
		v1296:SetText(v1283())
	end)
end

do
	RandomFF = GRP_Raids_Fruits_Options:AddToggle("Auto_Random_Fruit", {
		Text = "Auto Random Fruit",
		Default = false,
		Callback = function(p295)
			_G.Random_Auto = p295
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Random_Auto then
				ReplicatedStorage2.Remotes.CommF_:InvokeServer("Cousin", "Buy")
				if _G.StoreF then pcall(UpdStFruit) end
			end
		end)
	end
end)

do
	DropF = GRP_Raids_Fruits_Options:AddToggle("Auto_Drop_Fruit", {
		Text = "Auto Drop Fruit",
		Default = false,
		Callback = function(p296)
			_G.DropFruit = p296
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.DropFruit then
				pcall(function()
					DropFruits()
				end)
			end
		end
	end)
end

StoredF = GRP_Raids_Fruits_Options:AddToggle("Auto_Store_Fruit", {
	Text = "Auto Store Fruit",
	Default = false,
	Callback = function(p297)
		_G.StoreF = p297
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.StoreF then
				pcall(function()
					UpdStFruit()
				end)
			end
		end
	end)
end

TwF = GRP_Raids_Fruits_Options:AddToggle("Auto_Tween_to_Fruit", {
	Text = "Auto Tween to Fruit",
	Default = false,
	Callback = function(p298)
		_G.TwFruits = p298
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.TwFruits then
				pcall(function()
					for _, child in pairs(workspace:GetChildren()) do
						if string.find(child.Name, "Fruit") then
							_tp(child.Handle.CFrame)
						end
					end
				end)
			end
		end
	end)
end

do
	BringF = GRP_Raids_Fruits_Options:AddToggle("Auto_Collect_Fruit", {
		Text = "Auto Collect Fruit",
		Default = false,
		Callback = function(p299)
			_G.InstanceF = p299
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.InstanceF then
			pcall(function()
				collectFruits(_G.InstanceF)
			end)
		end
	end
end)

do
	GRP_Raids_Fruits_Options:AddDropdown("Select_Fruit_Shop", {
		Text = "Select Fruit Shop",
		Values = {
			"Rocket-Rocket",
			"Spin-Spin",
			"Blade-Blade",
			"Spring-Spring",
			"Bomb-Bomb",
			"Smoke-Smoke",
			"Spike-Spike",
			"Flame-Flame",
			"Ice-Ice",
			"Sand-Sand",
			"Dark-Dark",
			"Eagle-Eagle",
			"Diamond-Diamond",
			"Light-Light",
			"Rubber-Rubber",
			"Ghost-Ghost",
			"Magma-Magma",
			"Quake-Quake",
			"Buddha-Buddha",
			"Love-Love",
			"Creation-Creation",
			"Spider-Spider",
			"Sound-Sound",
			"Phoenix-Phoenix",
			"Portal-Portal",
			"Lightning-Lightning",
			"Pain-Pain",
			"Blizzard-Blizzard",
			"Gravity-Gravity",
			"T-Rex-T-Rex",
			"Mammoth-Mammoth",
			"Dough-Dough",
			"Shadow-Shadow",
			"Venom-Venom",
			"Gas-Gas",
			"Control-Control",
			"Spirit-Spirit",
			"Leopard-Leopard",
			"Yeti-Yeti",
			"Kitsune-Kitsune",
			"Dragon-Dragon"
		},
		Default = 1,
		Callback = function(p300)
			getgenv().SelectFruit = p300
		end
	})
end

GRP_Raids_Fruits_Options:AddToggle("Auto_Buy_Fruit_Shop", {
	Text = "Auto Buy Fruit Shop",
	Default = false,
	Callback = function(p301)
		getgenv().AutoBuyFruitSniper = p301
	end
})

do
	spawn(function()
		pcall(function()
			while wait() do
				if getgenv().AutoBuyFruitSniper then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", getgenv().SelectFruit)
				end
			end
		end)
	end)
end

GRP_Raids_Dungeon_Event_Raiding = t15.Raids:AddLeftGroupbox("Dungeon Event / Raiding")

do
	Q = GRP_Raids_Dungeon_Event_Raiding:AddDropdown("Select_Chip", {
		Text = "Select Chip",
		Values = {
			"Flame",
			"Ice",
			"Quake",
			"Light",
			"Dark",
			"String",
			"Rumble",
			"Magma",
			"Human: Buddha",
			"Sand",
			"Bird: Phoenix",
			"Dough"
		},
		Default = 1,
		Callback = function(p302)
			_G.SelectChip = p302
		end
	})
end

Q = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Select_Dungeon_Chip", {
	Text = "Auto Select Dungeon Chip",
	Default = false,
	Callback = function(p303)
		_G.AutoSelectDungeon = p303
	end
})
GRP_Raids_Dungeon_Event_Raiding:AddToggle("Get_Fruit_In_Inventory_Below_1M", {
	Text = "Get Fruit In Inventory Below 1M",
	Default = false,
	Callback = function(p304)
		getgenv().AutoGetFruit = p304
	end
})

do
	spawn(function()
		while wait() do
			pcall(function()
				if getgenv().AutoGetFruit then
					for _, v1 in ipairs({
						"Rocket-Rocket",
						"Spin-Spin",
						"Chop-Chop",
						"Spring-Spring",
						"Bomb-Bomb",
						"Smoke-Smoke",
						"Spike-Spike",
						"Flame-Flame",
						"Falcon-Falcon",
						"Ice-Ice",
						"Sand-Sand",
						"Dark-Dark",
						"Ghost-Ghost",
						"Diamond-Diamond",
						"Light-Light",
						"Rubber-Rubber",
						"Barrier-Barrier"
					}) do
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
							"LoadFruit",
							v1
						}))
					end
				end
			end)
		end
	end)
end

GRP_Raids_Dungeon_Event_Raiding:AddButton({
	Text = "Buy Dungeon Chips [Beli]",
	Func = function()
	end
})
GRP_Raids_Dungeon_Event_Raiding:AddButton({
	Text = "Buy Dungeon Chips [Devil Fruit]",
	Func = function()
	end
})

do
	AutoChipBeli = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Buy_Chip_[Beli]", {
		Text = "Auto Buy Chip [Beli]",
		Default = false,
		Callback = function()
		end
	})
end

do
	task.spawn(function()
		while task.wait(1) do
			if _G.AutoChipBeli then
				pcall(function()
					if not GetBP("Special Microchip") then
						ReplicatedStorage2.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
					end
				end)
			end
		end
	end)
end

AutoChipFruit = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Buy_Chip_[Devil_Fruit]", {
	Text = "Auto Buy Chip [Devil Fruit]",
	Default = false,
	Callback = function(p305)
		_G.AutoChipFruit = p305
	end
})
task.spawn(function()
	while task.wait(1) do
		if _G.AutoChipFruit then
			pcall(function()
				if not GetBP("Special Microchip") then
					local response = ReplicatedStorage2.Remotes.CommF_:InvokeServer("GetFruits")
					local Name

					for _, v1 in pairs(response) do
						if v1.Price <= 490000 then
							Name = v1.Name

							break
						end
					end

					if Name then
						ReplicatedStorage2.Remotes.CommF_:InvokeServer("LoadFruit", tostring(Name))
						ReplicatedStorage2.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
					end
				end
			end)
		end
	end
end)

do
	StartR = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Start_Raid", {
		Text = "Auto Start Raid",
		Default = false,
		Callback = function(p306)
			_G.Auto_StartRaid = p306
		end
	})
end

do
	task.spawn(function()
		while task.wait(Sec) do
			if _G.Auto_StartRaid and LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible == false then
				if GetBP("Special Microchip") then
					if World2 then
						_tp(CFrame.new(-6438.73535, 250.645355, -4501.50684))
						fireclickdetector(workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
					elseif World3 then
						_tp(CFrame.new(-5046, 314, -2960))
						task.wait(1.5)
						pcall(function()
							local Main = workspace.Map["Boat Castle"].RaidSummon2.Button.Main

							if Main and Main:FindFirstChild("ClickDetector") then
								fireclickdetector(Main.ClickDetector)
							end
						end)
					end
				end
			end
		end
	end)
end

Raiding = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Raid_+_Next_Island", {
	Text = "Auto Raid + Next Island",
	Default = false,
	Callback = function(p307)
		_G.Raiding = p307
	end
})
spawn(function()
	local Locations = workspace._WorldOrigin.Locations
	local t46 = {
		"Island 1",
		"Island 2",
		"Island 3",
		"Island 4",
		"Island 5"
	}
	local v1308

	while task.wait(0.3) do
		if _G.Raiding and LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
			local Character = LocalPlayer.Character

			if Character then
				local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
				local Humanoid = Character:FindFirstChildOfClass("Humanoid")

				if HumanoidRootPart and Humanoid and not (Humanoid.Health <= 0) and not (Humanoid.Sit or Humanoid.PlatformStand or not not HumanoidRootPart.Anchored) then
					local n9 = 999999

					for _, v1 in ipairs(t46) do
						local v1315 = Locations:FindFirstChild(v1)

						if v1315 then
							local Magnitude = (HumanoidRootPart.Position - v1315.Position).Magnitude

							if Magnitude < n9 then
								n9 = Magnitude
								v1308 = v1
							end
						end
					end

					if v1308 then
						local v1317 = Locations:FindFirstChild(v1308)

						if v1317 then
							local v1318 = false

							for _, child in ipairs(workspace.Enemies:GetChildren()) do
								local Humanoid2 = child:FindFirstChild("Humanoid")
								local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart")

								if Humanoid2 and HumanoidRootPart2 and Humanoid2.Health > 0 and (HumanoidRootPart2.Position - v1317.Position).Magnitude < 450 then
									v1318 = true

									while true do
										task.wait()
										t9.Kill(child, _G.Raiding)

										if _G.Raiding then
											if not child.Parent or Humanoid2.Health <= 0 then
												break
											end
										else
											break
										end
									end
								end
							end

							if not v1318 then
								local v1323 = table.find(t46, v1308)

								if v1323 and t46[v1323 + 1] then
									local v1324 = Locations:FindFirstChild(t46[v1323 + 1])

									if v1324 then
										_tp(v1324.CFrame * CFrame.new(0, 45, 120))
									end

									v1308 = t46[v1323 + 1]
									task.wait(1)
								end
							end
						end
					end
				end
			end
		end
	end
end)
GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Awakening", {
	Text = "Auto Awakening",
	Default = false,
	Callback = function(p308)
		_G.Auto_Awakener = p308
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Awakener then
				ReplicatedStorage2.Remotes.CommF_:InvokeServer("Awakener", "Check")
				ReplicatedStorage2.Remotes.CommF_:InvokeServer("Awakener", "Awaken")
			end
		end)
	end
end)
GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Teleport_To_Lab", {
	Text = "Auto Teleport To Lab",
	Default = false,
	Callback = function(p309)
		_G.TpLab = p309

		while _G.TpLab do
			wait()

			if _G.TpLab then
				if World2 and _G.TpLab then
					_tp(CFrame.new(-6438.73535, 250.645355, -4501.50684))
				elseif World3 and _G.TpLab then
					_tp(CFrame.lookAt(Vector3.new(-5046, 314, -2960), Vector3.new(-5055, 314, -2957)))
				end
			end
		end
	end
})
GRP_Raids_Items_Law_Order_Sword = t15.Raids:AddLeftGroupbox("Items Law/Order Sword")
GRP_Raids_Items_Law_Order_Sword:AddButton({
	Text = "Buy Microchip Law",
	Func = function()
	end
})

do
	GRP_Raids_Items_Law_Order_Sword:AddButton({
		Text = "Start Law Raids",
		Func = function()
		end
	})
end

GRP_Raids_Items_Law_Order_Sword:AddToggle("Auto_Buy_Microchip_Law", {
	Text = "Auto Buy Microchip Law",
	Default = false,
	Callback = function(p310)
		_G.AutoLawKak = p310
	end
})

do
	spawn(function()
		while task.wait(1) do
			if getgenv().AutoBuyMicrochipLaw then
				pcall(function()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
				end)
			end
		end
	end)
end

GRP_Raids_Items_Law_Order_Sword:AddToggle("Auto_Start_Law_Raids", {
	Text = "Auto Start Law Raids",
	Default = false,
	Callback = function(p311)
		getgenv().AutoStartLawRaids = p311
	end
})

do
	spawn(function()
		while task.wait(1) do
			if getgenv().AutoStartLawRaids then
				pcall(function()
					fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
				end)
			end
		end
	end)
end

GRP_Raids_Items_Law_Order_Sword:AddToggle("Auto_Kill_Law", {
	Text = "Auto Kill Law",
	Default = false,
	Callback = function(p312)
		_G.AutoLawKak = p312
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.AutoLawKak then
				pcall(function()
					local Order = GetConnectionEnemies("Order")

					if Order then
						while true do
							task.wait()
							t9.Kill(Order, _G.AutoLawKak)

							if _G.AutoLawKak == false then
								break
							elseif not Order.Parent or Order.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875))
					end
				end)
			end
		end
	end)
end

GRP_Raids_Raids_Dungeons = t15.Raids:AddLeftGroupbox("Raids Dungeons")

local LocalPlayer2 = game.Players.LocalPlayer

do
	local function v1327()
		local Character = LocalPlayer2.Character

		return Character and Character:FindFirstChild("HumanoidRootPart")
	end

	GRP_Raids_Raids_Dungeons:AddToggle("Auto_Farm_Dungeon", {
		Text = "Auto Farm Dungeon",
		Default = false,
		Callback = function(p313)
			_G.AutoFarmDungeon = p313
		end
	})
	spawn(function()
		while task.wait(0.15) do
			if _G.AutoFarmDungeon then
				pcall(function()
					local Character = game.Players.LocalPlayer.Character
					local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
					local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

					if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then
						return
					end

					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if not _G.AutoFarmDungeon then
							break
						end

						local Humanoid2 = child:FindFirstChild("Humanoid")
						local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart")

						if Humanoid2 and HumanoidRootPart2 and Humanoid2.Health > 0 and (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude <= 5000 then
							while true do
								task.wait()
								t9.Kill(child, true)

								if _G.AutoFarmDungeon then
									if not child.Parent or Humanoid2.Health <= 0 then
										break
									end
								else
									break
								end
							end
						end
					end
				end)
			end
		end
	end)
	GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(1)", {
		Text = "TP Exit (1)",
		Default = false,
		Callback = function(p314)
			_G.TPFloor1 = p314
		end
	})

	local u1336 = false

	local function v1337()
		local v1338 = v1327()

		if not v1338 then
			return
		end

		for _, child in pairs(workspace.Map.Dungeon:GetChildren()) do
			local ExitTeleporter = child:FindFirstChild("ExitTeleporter")

			if ExitTeleporter and ExitTeleporter:FindFirstChild("Root") and (v1338.Position - ExitTeleporter.Root.Position).Magnitude < 200 then
				return ExitTeleporter.Root
			end
		end
	end

	task.spawn(function()
		while task.wait(0.3) do
			if _G.TPFloor1 then
				if not u1336 then
					local v1342 = v1337()

					if v1342 then
						local cFrame = v1342.CFrame * CFrame.new(0, 3, 0)

						v1327().CFrame = cFrame
						u1336 = true
					end
				end
			else
				u1336 = false
			end
		end
	end)
	GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(2)", {
		Text = "TP Exit (2)",
		Default = false,
		Callback = function(p315)
			_G.TPFloor2 = p315
		end
	})

	local u1344 = false

	task.spawn(function()
		while task.wait(0.3) do
			if _G.TPFloor2 then
				if not u1344 then
					local v1345 = v1327()

					if v1345 then
						for _, child in pairs(workspace.Map.Dungeon:GetChildren()) do
							local EntranceTeleporter = child:FindFirstChild("EntranceTeleporter")
							local ExitTeleporter = child:FindFirstChild("ExitTeleporter")

							if EntranceTeleporter and ExitTeleporter and EntranceTeleporter:FindFirstChild("Root") and ExitTeleporter:FindFirstChild("Root") and (v1345.Position - EntranceTeleporter.Root.Position).Magnitude < 100 then
								v1345.CFrame = ExitTeleporter.Root.CFrame * CFrame.new(0, 3, 0)
								u1344 = true

								break
							end
						end
					end
				end
			else
				u1344 = false
			end
		end
	end)
	GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(3)", {
		Text = "TP Exit (3)",
		Default = false,
		Callback = function(p316)
			_G.TPFloor3 = p316
		end
	})

	local u1350 = false

	local function v1351()
		local v1352

		for _, child in pairs(workspace.Map.Dungeon:GetChildren()) do
			local v1355 = tonumber(child.Name)

			if v1355 and (not v1352 or tonumber(v1352.Name) < v1355) then
				v1352 = child
			end
		end

		return v1352
	end

	task.spawn(function()
		while task.wait(0.3) do
			if _G.TPFloor3 then
				if not u1350 then
					local v1356 = v1351()

					if v1356 and v1356:FindFirstChild("ExitTeleporter") then
						if v1356.ExitTeleporter:FindFirstChild("Root") then
							v1327().CFrame = v1356.ExitTeleporter.Root.CFrame * CFrame.new(0, 3, 0)
							u1350 = true
						end
					end
				end
			else
				u1350 = false
			end
		end
	end)
	GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(4)", {
		Text = "TP Exit (4)",
		Default = false,
		Callback = function(p317)
			_G.TPFloor4 = p317
		end
	})

	local u1357 = false

	local function v1358()
		local v1359 = v1327()

		if not v1359 then
			return
		end

		local Root_
		local huge = math.huge

		for _, child in pairs(workspace.Map.Dungeon:GetChildren()) do
			local ExitTeleporter = child:FindFirstChild("ExitTeleporter")

			if ExitTeleporter and ExitTeleporter:FindFirstChild("Root") then
				local Magnitude = (v1359.Position - ExitTeleporter.Root.Position).Magnitude

				if Magnitude < huge then
					huge = Magnitude
					Root_ = ExitTeleporter.Root
				end
			end
		end

		return Root_
	end

	task.spawn(function()
		while task.wait(0.3) do
			if _G.TPFloor4 then
				if not u1357 then
					local v1366 = v1358()

					if v1366 then
						v1327().CFrame = v1366.CFrame * CFrame.new(0, 3, 0)
						u1357 = true
					end
				end
			else
				u1357 = false
			end
		end
	end)
end

GRP_Combat_Combat_AimBot = t15.Combat:AddLeftGroupbox("Combat / AimBot")

do
	local v1367 = GRP_Combat_Combat_AimBot:AddLabel("")

	spawn(function()
		while wait(Sec) do
			pcall(function()
				local v1368 = #game:GetService("Players"):GetPlayers()

				if v1368 == 12 then
					v1367:SetText("Tất cả người chơi : " .. v1368 .. " / 12 [Max]")
				else
					v1367:SetText("Tất cả người chơi : " .. v1368 .. " / 12")
				end
			end)
		end
	end)
end

do
	local v1369 = GRP_Combat_Combat_AimBot:AddLabel("")

	Checking_AimStatus = function()
		if _G.AimCam then
			return "Aimbot Camera"
		end

		if _G.AimbotGun then
			return "Aimbot Guns"
		end

		return ""
	end
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.AimMethod then
					if _G.AimCam or _G.AimbotGun then
						v1369:SetText("Aimbot - " .. Checking_AimStatus() .. " : True")
					else
						v1369:SetText("Aimbot - Skills : True")
					end
				else
					v1369:SetText("Aimbot - Skills : False")
				end
			end)
		end
	end)
end

do
	local t47 = {}
	local Players2 = game:GetService("Players")

	for _, child in pairs(Players2:GetChildren()) do
		table.insert(t47, child.Name)
	end

	GRP_Combat_Combat_AimBot:AddDropdown("Select_Players", {
		Text = "Select Players",
		Values = t47,
		Default = 1,
		Callback = function(p318)
			_G.PlayersList = p318
		end
	})
end

GRP_Combat_Combat_AimBot:AddToggle("Teleport_To_Select_Players", {
	Text = "Teleport To Select Players",
	Default = false,
	Callback = function(p319)
		_G.TpPly = p319
		spawn(function()
			pcall(function()
				while _G.TpPly do
					wait()
					_tp(game:GetService("Players")[_G.PlayersList].Character.HumanoidRootPart.CFrame)
				end
			end)
		end)
	end
})
GRP_Combat_Combat_AimBot:AddToggle("Spectate_Select_Players", {
	Text = "Spectate Select Players",
	Default = false,
	Callback = function(p320)
		SpectatePlys = p320
		spawn(function()
			repeat
				task.wait(0.1)

				if _G.PlayersList then
					if game:GetService("Players"):FindFirstChild(_G.PlayersList) then
						workspace.Camera.CameraSubject = game:GetService("Players"):FindFirstChild(_G.PlayersList).Character.Humanoid
					end
				end
			until not SpectatePlys

			workspace.Camera.CameraSubject = LocalPlayer2.Character.Humanoid
		end)
	end
})

do
	GRP_Combat_Combat_AimBot:AddDropdown("Select_Aim_Method", {
		Text = "Select Aim Method",
		Values = {
			"Aim Player",
			"Nearest Aim"
		},
		Default = 1,
		Callback = function(p321)
			ABmethod = p321
		end
	})
end

GRP_Combat_Combat_AimBot:AddToggle("Aimbot_Method_Skills", {
	Text = "Aimbot Method Skills",
	Default = false,
	Callback = function(p322)
		_G.AimMethod = p322
	end
})
spawn(function()
	while wait() do
		pcall(function()
			if _G.AimMethod and ABmethod == "Aim Player" then
				local v1374 = Players:FindFirstChild(getgenv().PlayersList)

				if v1374 and v1374.Character then
					if v1374.Character:FindFirstChild("HumanoidRootPart") and v1374.Team ~= LocalPlayer2.Team then
						MousePos = v1374.Character.HumanoidRootPart.Position
					end
				end
			end
		end)
	end
end)

do
	spawn(function()
		while wait() do
			pcall(function()
				if _G.AimMethod and ABmethod == "Nearest Aim" then
					local huge = math.huge

					for _, player in pairs(Players:GetPlayers()) do
						if player ~= LocalPlayer2 and player.Team ~= LocalPlayer2.Team and player.Character then
							if player.Character:FindFirstChild("HumanoidRootPart") then
								local Magnitude = (player.Character.HumanoidRootPart.Position - LocalPlayer2.Character.HumanoidRootPart.Position).Magnitude

								if Magnitude < huge then
									huge = Magnitude
									MousePos = player.Character.HumanoidRootPart.Position
								end
							end
						end
					end
				end
			end)
		end
	end)
end

do
	GRP_Combat_Combat_AimBot:AddToggle("Aimbot_Camera_Closet_Players", {
		Text = "Aimbot Camera Closet Players",
		Default = false,
		Callback = function(p323)
			_G.AimCam = p323
		end
	})
end

task.spawn(function()
	while task.wait(Sec) do
		pcall(function()
			if _G.AimCam then
				local CurrentCamera = workspace.CurrentCamera

				closestplayer = function()
					local huge = math.huge
					local v1381
					local players, v1383 = ply:GetPlayers()

					for _, v1 in next, players, v1383 do
						if v1 ~= LocalPlayer2 and v1.Character then
							if v1.Character:FindFirstChild("Head") and _G.AimCam and v1.Character.Humanoid.Health > 0 then
								local Magnitude = (v1.Character.Head.Position - LocalPlayer2.Character.Head.Position).Magnitude

								if Magnitude < huge then
									huge = Magnitude
									v1381 = v1
								end
							end
						end
					end

					return v1381
				end

				while true do
					task.wait()
					CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, closestplayer().Character.HumanoidRootPart.Position)

					if _G.AimCam == false then
						break
					elseif dist < Mag then
						break
					end
				end
			end
		end)
	end
end)
GRP_Combat_Quests_Players = t15.Combat:AddLeftGroupbox("Quests Players")

do
	GRP_Combat_Quests_Players:AddButton({
		Text = "Get player quests",
		Func = function()
		end
	})
end

do
	GRP_Combat_Quests_Players:AddToggle("Auto_Get_PlayerQuest", {
		Text = "Auto Get PlayerQuest",
		Default = false,
		Callback = function(p324)
			_G.AutoReceivePlayerQuest = p324
		end
	})
end

spawn(function()
	while task.wait(1) do
		if _G.AutoReceivePlayerQuest then
			local exitTo

			repeat
				pcall(function()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
				end)
				exitTo = nil

				while task.wait(1) do
					if _G.AutoReceivePlayerQuest then
						exitTo = 1

						break
					end
				end
			until exitTo ~= 1

			return
		end
	end
end)

do
	GRP_Combat_Quests_Players:AddToggle("Auto_Kill_Player_Quest", {
		Text = "Auto Kill Player Quest",
		Default = false,
		Callback = function(p325)
			_G.AutoPlayerHunter = p325
		end
	})
end

spawn(function()
	while task.wait() do
		if _G.AutoPlayerHunter then
			if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
				task.wait(0.5)
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
			else
				for _, child in pairs(game:GetService("Workspace").Characters:GetChildren()) do
					if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, child.Name) then
						repeat
							task.wait()

							if AutoHaki then
								AutoHaki()
							end

							if EquipWeapon then
								EquipWeapon(_G.SelectWeapon)
							end

							Useskill = true
							_tp(child.HumanoidRootPart.CFrame * CFrame.new(1, 7, 3))
							child.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
							game:GetService("VirtualUser"):CaptureController()
							game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
						until _G.AutoPlayerHunter == false or child.Humanoid.Health <= 0

						Useskill = false
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
					end
				end
			end
		end
	end
end)

do
	GRP_Combat_Quests_Players:AddToggle("Auto_Enable_PvP", {
		Text = "Auto Enable PvP",
		Default = false,
		Callback = function(p326)
			_G.AutoPvP = p326
		end
	})
end

spawn(function()
	while task.wait(0.5) do
		if _G.AutoPvP then
			local PlayerGui = game.Players.LocalPlayer.PlayerGui

			if PlayerGui and PlayerGui.Main then
				if PlayerGui.Main:FindFirstChild("PvpDisabled") and PlayerGui.Main.PvpDisabled.Visible then
					pcall(function()
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
					end)
				end
			end
		end
	end
end)

do
	GRP_Combat_Quests_Players:AddToggle("Auto_Safe_Mode", {
		Text = "Auto Safe Mode",
		Default = false,
		Callback = function(p327)
			_G.SafeMode = p327
		end
	})
end

spawn(function()
	while task.wait(0.1) do
		if _G.SafeMode then
			local Character = game.Players.LocalPlayer.Character

			if Character then
				local exitTo2

				repeat
					local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

					exitTo2 = nil

					while true do
						if HumanoidRootPart then
							_tp(HumanoidRootPart.CFrame * CFrame.new(0, 1000, 0))
						end

						local exitTo

						while task.wait(0.1) do
							if _G.SafeMode then
								exitTo = 1

								break
							end
						end

						if exitTo ~= 1 then
							break
						end

						Character = game.Players.LocalPlayer.Character
						HumanoidRootPart = Character

						if HumanoidRootPart then
							exitTo2 = 1

							break
						end
					end
				until exitTo2 ~= 1

				return
			end
		end
	end
end)
GRP_Combat_LocalPlayer_Settings = t15.Combat:AddLeftGroupbox("LocalPlayer Settings")

do
	local Players2 = game:GetService("Players")

	game:GetService("UserInputService")

	local RunService = game:GetService("RunService")
	local LocalPlayer3 = Players2.LocalPlayer
	local u1398 = false
	local n10 = 50
	local connection
	local t48 = {
		f = 0,
		b = 0,
		l = 0,
		r = 0
	}
	local BodyGyro
	local BodyVelocity

	local function v1404()
		local function v1405()
			local Character = LocalPlayer3.Character

			if not Character then
				return
			end

			local Humanoid = Character:FindFirstChildOfClass("Humanoid")

			if not Humanoid then
				return
			end

			local MoveDirection = Humanoid.MoveDirection

			t48.f = 0
			t48.b = 0
			t48.l = 0
			t48.r = 0

			if MoveDirection.Z < -0.1 then
				t48.f = 1
			elseif MoveDirection.Z > 0.1 then
				t48.b = 1
			end

			if MoveDirection.X < -0.1 then
				t48.l = 1
			elseif MoveDirection.X > 0.1 then
				t48.r = 1
			end
		end

		local connection2

		connection2 = RunService.Heartbeat:Connect(function()
			if u1398 then
				v1405()
			elseif connection2 then
				connection2:Disconnect()
			end
		end)
	end
	local function v1410(p328)
		u1398 = p328

		if u1398 then
			if not LocalPlayer3.Character then
				return
			end

			local Humanoid = LocalPlayer3.Character:FindFirstChildOfClass("Humanoid")
			local Torso

			if LocalPlayer3.Character:FindFirstChild("Torso") then
				Torso = LocalPlayer3.Character.Torso
			else
				Torso = LocalPlayer3.Character.UpperTorso
			end

			if not Humanoid or not Torso then
				return
			end

			for _, descendant in ipairs(LocalPlayer3.Character:GetDescendants()) do
				if descendant:IsA("BasePart") then
					descendant.CanCollide = false
					descendant.Massless = true
				end
			end

			LocalPlayer3.Character.DescendantAdded:Connect(function(descendant)
				if u1398 and descendant:IsA("BasePart") then
					descendant.CanCollide = false
					descendant.Massless = true
				end
			end)
			BodyGyro = Instance.new("BodyGyro", Torso)
			BodyGyro.P = 90000
			BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			BodyGyro.cframe = Torso.CFrame
			BodyVelocity = Instance.new("BodyVelocity", Torso)
			BodyVelocity.velocity = Vector3.new(0, 0, 0)
			BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
			Humanoid.PlatformStand = true
			v1404()
			connection = RunService.Heartbeat:Connect(function()
				if not u1398 or not LocalPlayer3.Character then
					return
				end

				for _, descendant in ipairs(LocalPlayer3.Character:GetDescendants()) do
					if descendant:IsA("BasePart") and descendant.CanCollide then
						descendant.CanCollide = false
					end
				end

				if t48.l + t48.r == 0 and t48.f + t48.b == 0 then
					BodyVelocity.velocity = Vector3.new(0, 0, 0)
				else
					BodyVelocity.velocity = (workspace.CurrentCamera.CoordinateFrame.lookVector * (t48.f + t48.b) + (workspace.CurrentCamera.CoordinateFrame * CFrame.new(t48.l + t48.r, (t48.f + t48.b) * 0.2, 0).p - workspace.CurrentCamera.CoordinateFrame.p)) * n10
				end

				BodyGyro.cframe = workspace.CurrentCamera.CoordinateFrame
			end)
		else
			if connection then
				connection:Disconnect()
				connection = nil
			end

			if LocalPlayer3.Character then
				local Humanoid = LocalPlayer3.Character:FindFirstChildOfClass("Humanoid")

				if Humanoid then
					Humanoid.PlatformStand = false
				end

				for _, descendant in ipairs(LocalPlayer3.Character:GetDescendants()) do
					if descendant:IsA("BasePart") then
						descendant.CanCollide = true
						descendant.Massless = false
					end
				end

				if BodyGyro then
					BodyGyro:Destroy()
				end

				if BodyVelocity then
					BodyVelocity:Destroy()
				end
			end

			t48 = {
				f = 0,
				b = 0,
				l = 0,
				r = 0
			}
		end
	end
	local function v1420(p329)
		n10 = p329
	end

	GRP_Combat_LocalPlayer_Settings:AddToggle("Enable_Fly", {
		Text = "Enable Fly",
		Default = false,
		Callback = function(p330)
			v1410(p330)
		end
	})
	GRP_Combat_LocalPlayer_Settings:AddSlider({
		Text = "Speed Fly Mode",
		Min = 10,
		Max = 200,
		Default = 50,
		Rounding = 0,
		Callback = function(p331)
			v1420(p331)
		end
	})
end

GRP_Combat_LocalPlayer_Settings:AddToggle("Dash_No_Cooldown", {
	Text = "Dash No Cooldown",
	Default = false,
	Callback = function(p332)
		getgenv().DodgeNoCD = p332
	end
})

do
	local function v1421()
		local Dodge = game.Players.LocalPlayer.Character:WaitForChild("Dodge")
		local v1423, v1424 = getgc()

		for _, v1 in next, v1423, v1424 do
			if typeof(v1) == "function" and getfenv(v1).script == Dodge then
				local next_ = next
				local v1428, v1429 = getupvalues(v1)

				for k, v2 in next_, v1428, v1429 do
					if tostring(v2) == "0.4" then
						setupvalue(v1, k, 0)
					end
				end
			end
		end
	end
end

do
	GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Mink_V3_[_INF_]", {
		Text = "Instance Mink V3 [ INF ]",
		Default = false,
		Callback = function(p333)
			InfAblities = p333
		end
	})
end

spawn(function()
	while wait(0.2) do
		pcall(function()
			if InfAblities then
				if not LocalPlayer2.Character.HumanoidRootPart:FindFirstChild("Agility") then
					local clone = ReplicatedStorage2.FX.Agility:Clone()

					clone.Name = "Agility"
					clone.Parent = LocalPlayer2.Character.HumanoidRootPart
				end
			else
				LocalPlayer2.Character.HumanoidRootPart.Agility:Destroy()
			end
		end)
	end
end)

do
	GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Energy_[_INF_]", {
		Text = "Instance Energy [ INF ]",
		Default = false,
		Callback = function(p334)
			infEnergy = p334

			if p334 then
				getInfinity_Ability("Energy", infEnergy)
			end
		end
	})
end

GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Soru_[_INF_]", {
	Text = "Instance Soru [ INF ]",
	Default = false,
	Callback = function(p335)
		_G.InfSoru = p335

		if p335 then
			getInfinity_Ability("Soru", _G.InfSoru)
		end
	end
})

do
	GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Observation_Range_[_INF_]", {
		Text = "Instance Observation Range [ INF ]",
		Default = false,
		Callback = function(p336)
			_G.InfiniteObRange = p336

			if p336 then
				getInfinity_Ability("Observation", _G.InfiniteObRange)
			end
		end
	})
end

GRP_Combat_LocalPlayer_Settings:AddToggle("Ignore_Same_Teams", {
	Text = "Ignore Same Teams",
	Default = false,
	Callback = function(p337)
		_G.NoAimTeam = p337
	end
})

do
	GRP_Combat_LocalPlayer_Settings:AddToggle("Accept_Allies", {
		Text = "Accept Allies",
		Default = false,
		Callback = function(p338)
			_G.AcceptAlly = p338
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.AcceptAlly then
			pcall(function()
				for _, child in pairs(ply:GetChildren()) do
					if child.Name ~= LocalPlayer2.Name and child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") then
						ReplicatedStorage2:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("AcceptAlly", child.Name)
					end
				end
			end)
		end
	end
end)
GRP_Travel_Travel_Worlds = t15.Travel:AddLeftGroupbox("Travel - Worlds")

do
	GRP_Travel_Travel_Worlds:AddButton({
		Text = "Travel East Blue (World 1)",
		Func = function()
		end
	})
end

do
	GRP_Travel_Travel_Worlds:AddButton({
		Text = "Travel Dressrosa (World 2)",
		Func = function()
		end
	})
end

do
	GRP_Travel_Travel_Worlds:AddButton({
		Text = "Travel Zou (World 3)",
		Func = function()
		end
	})
end

GRP_Travel_Travel_Island = t15.Travel:AddLeftGroupbox("Travel - Island")
Location = {}

for _, child in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
	table.insert(Location, child.Name)
end

do
	Travelllll = GRP_Travel_Travel_Island:AddDropdown("Select_Travelling", {
		Text = "Select Travelling",
		Values = Location,
		Default = 1,
		Callback = function(p339)
			_G.Island = p339
		end
	})
end

do
	GoIsland = GRP_Travel_Travel_Island:AddToggle("Auto_Travel", {
		Text = "Auto Travel",
		Default = false,
		Callback = function(p340)
			_G.Teleport = p340

			if p340 then
				for _, child in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
					if child.Name == _G.Island then
						while true do
							wait()
							_tp(child.CFrame * CFrame.new(0, 30, 0))

							if _G.Teleport then
								if Root.CFrame == child.CFrame then
									break
								end
							else
								break
							end
						end
					end
				end
			end
		end
	})
end

GRP_Travel_Travel_Portal = t15.Travel:AddLeftGroupbox("Travel - Portal")

if World1 then
	Location_Portal = {
		"Sky",
		"UnderWater"
	}
elseif World2 then
	Location_Portal = {
		"SwanRoom",
		"Cursed Ship"
	}
elseif World3 then
	Location_Portal = {
		"Castle On The Sea",
		"Mansion Cafe",
		"Hydra Teleport",
		"Canvendish Room",
		"Temple of Time"
	}
end

PortalTP = GRP_Travel_Travel_Portal:AddDropdown("Select_Portal", {
	Text = "Select Portal",
	Values = Location_Portal,
	Default = 1,
	Callback = function(p341)
		_G.Island_PT = p341
	end
})

do
	GRP_Travel_Travel_Portal:AddButton({
		Text = "requestEntrance",
		Func = function()
		end
	})
end

GRP_Travel_Travel_NPCs = t15.Travel:AddLeftGroupbox("Travel - NPCs")

for _, child in pairs(ReplicatedStorage2.NPCs:GetChildren()) do
	table.insert(NPCList, child.Name)
end

do
	NPCsPos = GRP_Travel_Travel_NPCs:AddDropdown("Select_NPCs", {
		Text = "Select NPCs",
		Values = NPCList,
		Default = 1,
		Callback = function(p342)
			_G.TPNpc = p342
		end
	})
end

do
	GoNPCs = GRP_Travel_Travel_NPCs:AddToggle("Auto_Tween_to_NPC", {
		Text = "Auto Tween to NPC",
		Default = false,
		Callback = function(p343)
			_G.TPNpc = p343
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.TPNpc then
			pcall(function()
				for _, child in pairs(ReplicatedStorage2.NPCs:GetChildren()) do
					if child.Name == NPClist then
						_tp(child.HumanoidRootPart.CFrame)
					end
				end
			end)
		end
	end
end)
GRP_Shop_Shop_Options = t15.Shop:AddLeftGroupbox("Shop Options")
GRP_Shop_Shop_Options:AddButton({
	Text = "Buy Buso",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
	end
})

do
	GRP_Shop_Shop_Options:AddButton({
		Text = "Buy Geppo",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
		end
	})
end

GRP_Shop_Shop_Options:AddButton({
	Text = "Buy Soru",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
	end
})
GRP_Shop_Shop_Options:AddButton({
	Text = "Buy Ken",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("KenTalk", "Buy")
	end
})
GRP_Shop_Fighting_Style = t15.Shop:AddLeftGroupbox("Fighting - Style")

do
	GRP_Shop_Fighting_Style:AddButton({
		Text = "Buy Black Leg",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyBlackLeg")
		end
	})
end

GRP_Shop_Fighting_Style:AddButton({
	Text = "Buy Electro",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyElectro")
	end
})
GRP_Shop_Fighting_Style:AddButton({
	Text = "Buy Fishman Karate",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
	end
})

do
	GRP_Shop_Fighting_Style:AddButton({
		Text = "Buy DragonClaw",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
		end
	})
end

do
	GRP_Shop_Fighting_Style:AddButton({
		Text = "Buy Superhuman",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuySuperhuman")
		end
	})
end

GRP_Shop_Fighting_Style:AddButton({
	Text = "Buy Death Step",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyDeathStep")
	end
})

do
	GRP_Shop_Fighting_Style:AddButton({
		Text = "Buy Sharkman Karate",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
		end
	})
end

do
	GRP_Shop_Fighting_Style:AddButton({
		Text = "Buy ElectricClaw",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyElectricClaw")
		end
	})
end

GRP_Shop_Fighting_Style:AddButton({
	Text = "Buy DragonTalon",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyDragonTalon")
	end
})
GRP_Shop_Fighting_Style:AddButton({
	Text = "Buy Godhuman",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyGodhuman")
	end
})
GRP_Shop_Fighting_Style:AddButton({
	Text = "Buy SanguineArt",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuySanguineArt")
	end
})
GRP_Shop_Accessory = t15.Shop:AddLeftGroupbox("Accessory")

do
	GRP_Shop_Accessory:AddButton({
		Text = "Buy Tomoe Ring",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Tomoe Ring")
		end
	})
end

GRP_Shop_Accessory:AddButton({
	Text = "Buy Black Cape",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Black Cape")
	end
})

do
	GRP_Shop_Accessory:AddButton({
		Text = "Buy Swordsman Hat",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Swordsman Hat")
		end
	})
end

GRP_Shop_Accessory:AddButton({
	Text = "Buy Bizarre Rifle",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 1)
	end
})

do
	GRP_Shop_Accessory:AddButton({
		Text = "Buy Ghoul Mask",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 2)
		end
	})
end

GRP_Shop_Weapon_World1 = t15.Shop:AddLeftGroupbox("Weapon World1")

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Cutlass",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Cutlass")
		end
	})
end

GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Katana",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Katana")
	end
})

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Iron Mace",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace")
		end
	})
end

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Duel Katana",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana")
		end
	})
end

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Triple Katana",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana")
		end
	})
end

GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Pipe",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Pipe")
	end
})

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Dual-Headed Blade",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade")
		end
	})
end

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Bisento",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
		end
	})
end

GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Soul Cane",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane")
	end
})

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Slingshot",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Slingshot")
		end
	})
end

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Musket",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Musket")
		end
	})
end

GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Dual Flintlock",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Dual Flintlock")
	end
})

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Flintlock",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Flintlock")
		end
	})
end

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Refined Flintlock",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock")
		end
	})
end

GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Cannon",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Cannon")
	end
})
GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Kabucha",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2")
	end
})
GRP_Shop_Fragments_shop = t15.Shop:AddLeftGroupbox("Fragments shop")
GRP_Shop_Fragments_shop:AddButton({
	Text = "Buy Refund Stats",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
	end
})

do
	GRP_Shop_Fragments_shop:AddButton({
		Text = "Buy Reroll Race",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
		end
	})
end

GRP_Shop_Fragments_shop:AddButton({
	Text = "Buy Ghoul Race",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("Ectoplasm", " Change", 4)
	end
})
GRP_Shop_Fragments_shop:AddButton({
	Text = "Buy Cyborg Race (2.5k)",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("CyborgTrainer", " Buy")
	end
})
GRP_Shop_Fragments_shop:AddButton({
	Text = "Buy Draco Race",
	Func = function()
		task.spawn(function()
			_tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))

			local vector3 = Vector3.new(5814.42724609375, 1208.3267822265625, 884.57855224609375)

			while true do
				task.wait()

				if not LocalPlayer2.Character then
					continue
				end

				if LocalPlayer2.Character.HumanoidRootPart and (LocalPlayer2.Character.HumanoidRootPart.Position - vector3).Magnitude < 1 then
					break
				end
			end

			ReplicatedStorage2.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
				NPC = "Dragon Wizard",
				Command = "DragonRace"
			} }))
		end)
	end
})
GRP_Misc_Server_Function = t15.Misc:AddLeftGroupbox("Server - Function")
GRP_Misc_Server_Function:AddButton({
	Text = "Redeem All Codes",
	Func = function()
		local t49 = {
			"BANEXPLOIT", "NOMOREHACK", "WildDares", "BossBuild", "GetPranked",
			"EARN_FRUITS", "FIGHT4FRUIT", "NOEXPLOITER", "NOOB2ADMIN", "CODESLIDE",
			"ADMINHACKED", "ADMINDARES", "KITT_RESET", "Sub2CaptainMaui", "KITTGAMING",
			"Sub2Fer999", "Enyu_is_Pro", "Magicbus", "JCWK", "Starcodeheo", "Bluxxy",
			"fudd10_v2", "FUDD10", "Bignews", "TheGreatAce", "Sub2OfficialNoobie",
			"StrawHatMaine", "TantaiGaming", "Axiore", "Sub2Daigrock",
			"Sub2UncleKizaru", "Sub2NoobMaster123", "SUB2GAMERROBOT_EXP1"
		}
		local Redeem = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("Redeem")

		if not Redeem then
			return
		end

		for _, v1 in ipairs(t49) do
			task.wait(0.15)
			pcall(function()
				if Redeem.InvokeServer then
					Redeem:InvokeServer(v1)
				else
					Redeem:FireServer(v1)
				end
			end)
		end
	end
})
GRP_Misc_Server_Function:AddButton({
	Text = "Rejoin Server",
	Func = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
	end
})
GRP_Misc_Server_Function:AddButton({
	Text = "Hop Server",
	Func = function()
		task.spawn(function()
			local HttpService = game:GetService("HttpService")
			local TeleportService_ = game:GetService("TeleportService")
			local Players2 = game:GetService("Players")
			local ok, result = pcall(function()
				local response = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")

				return HttpService:JSONDecode(response).data
			end)

			if ok and result then
				local id

				for _, v1 in pairs(result) do
					if v1.playing < v1.maxPlayers then
						id = v1.id
					end
				end

				if id then
					pcall(function()
						TeleportService_:TeleportToPlaceInstance(game.PlaceId, id, Players2.LocalPlayer)
					end)
				end
			end
		end)
	end
})
GRP_Misc_Server_Function:AddButton({
	Text = "Hop to Lowest Players",
	Func = function()
		local HttpService = game:GetService("HttpService")
		local TeleportService_ = game:GetService("TeleportService")
		local v1459 = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"

		local function v1460(p344)
			local response = game:HttpGet(v1459 .. (p344 and "&cursor=" .. p344 or ""))

			return HttpService:JSONDecode(response)
		end

		local nextPageCursor
		local v1463

		repeat
			local v1464 = v1460(nextPageCursor)

			v1463 = v1464.data[1]
			nextPageCursor = v1464.nextPageCursor
		until v1463

		TeleportService_:TeleportToPlaceInstance(game.PlaceId, v1463.id, LocalPlayer2)
	end
})

local ReplicatedStorage3 = game:GetService("ReplicatedStorage")

GRP_Misc_Server_Function:AddButton({
	Text = "Hop to Lowest Pings Server",
	Func = function()
		local HttpService = game:GetService("HttpService")
		local TeleportService_ = game:GetService("TeleportService")
		local Stats_ = game:GetService("Stats")

		local function v1469(p345, p346)
			local v1470 = string.format("https://games.roblox.com/v1/games/%d/servers/Public?limit=%d", p345, p346)
			local ok, result = pcall(function()
				return HttpService:JSONDecode(game:HttpGet(v1470))
			end)

			if ok and result and result.data then
				return result.data
			end

			return nil
		end

		local v1473 = v1469(game.PlaceId, 100)

		if not v1473 then
			return
		end

		local v1474 = v1473[1]

		for _, v1 in pairs(v1473) do
			if v1.ping < v1474.ping and v1.playing < v1.maxPlayers then
				v1474 = v1
			end
		end

		if tonumber(Stats_.Network.ServerStatsItem["Data Ping"]:GetValueString():match("(%d+)")) >= 100 then
			TeleportService_:TeleportToPlaceInstance(game.PlaceId, v1474.id)
		end
	end
})

do
	GRP_Misc_Server_Function:AddInput("Input_Job_Id", {
		Text = "Input Job Id",
		Default = "",
		Placeholder = "ID máy chủ",
		Callback = function(p347)
			_G.Rechat = p347
		end
	})
end

GRP_Misc_Server_Function:AddButton({
	Text = "Teleport [Job ID]",
	Func = function()
		if _G.Rechat and _G.Rechat ~= "" then
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, _G.Rechat, LocalPlayer2)
		end
	end
})

do
	GRP_Misc_Server_Function:AddButton({
		Text = "Copy JobID",
		Func = function()
			setclipboard(tostring(game.JobId))
		end
	})
end

GRP_Misc_Player_Gui_Others = t15.Misc:AddLeftGroupbox("Player Gui / Others")
GRP_Misc_Player_Gui_Others:AddButton({
	Text = "Open Awakenings Expert",
	Func = function()
		LocalPlayer2.PlayerGui.Main.AwakeningToggler.Visible = true
	end
})
GRP_Misc_Player_Gui_Others:AddButton({
	Text = "Open Title Selection",
	Func = function()
		ReplicatedStorage3.Remotes.CommF_:InvokeServer("getTitles", true)
		LocalPlayer2.PlayerGui.Main.Titles.Visible = true
	end
})
DisbleChat = GRP_Misc_Player_Gui_Others:AddToggle("Disable_Chat_GUI", {
	Text = "Disable Chat GUI",
	Default = false,
	Callback = function(p348)
		_G.Rechat = p348

		if _G.Rechat == true then
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
		elseif _G.Rechat == false then
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
		end
	end
})

do
	DisbleLeaderB = GRP_Misc_Player_Gui_Others:AddToggle("Disable_Leader_Board_GUI", {
		Text = "Disable Leader Board GUI",
		Default = false,
		Callback = function(p349)
			ReLeader = p349

			if ReLeader == true then
				game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
			elseif ReLeader == false then
				game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
			end
		end
	})
end

GRP_Misc_Player_Gui_Others:AddButton({
	Text = "Set Pirate Team",
	Func = function()
		ReplicatedStorage3.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
	end
})

do
	GRP_Misc_Player_Gui_Others:AddButton({
		Text = "Set Marine Team",
		Func = function()
			ReplicatedStorage3.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
		end
	})
end

UnPortal = GRP_Misc_Player_Gui_Others:AddToggle("Unlock_All_Portals", {
	Text = "Unlock All Portals",
	Default = false,
	Callback = function(p350)
		_G.PortalUnLock = p350
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.PortalUnLock then
				if t9.Pos(CstlePos_Miti, 8) then
					ReplicatedStorage3.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
				elseif t9.Pos(Man3Pos_Miti, 8) then
					ReplicatedStorage3.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5072.08984375, 314.5412902832, -3151.1098632812))
				elseif t9.Pos(HydraPos_Miti, 8) then
					ReplicatedStorage3.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5748.7587890625, 610.44982910156, -267.81704711914))
				elseif t9.Pos(HydratoCastle, 8) then
					ReplicatedStorage3.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5072.08984375, 314.5412902832, -3151.1098632812))
				end
			end
		end)
	end
end)
GRP_Misc_Graphics_Haki_Stats = t15.Misc:AddLeftGroupbox("Graphics / Haki Stats")
HakiSt = {
	"State 0",
	"State 1",
	"State 2",
	"State 3",
	"State 4",
	"State 5"
}
HakiStat = GRP_Misc_Graphics_Haki_Stats:AddDropdown("Select_Haki_States", {
	Text = "Select Haki States",
	Values = HakiSt,
	Default = 1,
	Callback = function(p351)
		_G.SelectStateHaki = p351
	end
})

do
	GRP_Misc_Graphics_Haki_Stats:AddButton({
		Text = "ChangeBusoStage",
		Func = function()
			if _G.SelectStateHaki == "State 0" then
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("ChangeBusoStage", 0)
			elseif _G.SelectStateHaki == "State 1" then
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("ChangeBusoStage", 1)
			elseif _G.SelectStateHaki == "State 2" then
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("ChangeBusoStage", 2)
			elseif _G.SelectStateHaki == "State 3" then
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("ChangeBusoStage", 3)
			elseif _G.SelectStateHaki == "State 4" then
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("ChangeBusoStage", 4)
			elseif _G.SelectStateHaki == "State 5" then
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("ChangeBusoStage", 5)
			end
		end
	})
end

do
	rtxM = GRP_Misc_Graphics_Haki_Stats:AddToggle("Turn_on_RTX_Mode", {
		Text = "Turn on RTX Mode",
		Default = false,
		Callback = function(p352)
			_G.RTXMode = p352

			for _, child in pairs(game.Lighting:GetChildren()) do
				if child.Name == "RTXColorCorrection" or child.Name == "RTXTint" then
					child:Destroy()
				end
			end

			if _G.RTXMode then
				local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game.Lighting)

				ColorCorrectionEffect.Name = "RTXColorCorrection"

				local ColorCorrectionEffect2 = Instance.new("ColorCorrectionEffect", game.Lighting)

				ColorCorrectionEffect2.Name = "RTXTint"
				OldAmbient = game.Lighting.Ambient
				OldBrightness = game.Lighting.Brightness
				OldColorShift_Top = game.Lighting.ColorShift_Top
				OldBrightnessc = ColorCorrectionEffect.Brightness
				OldContrastc = ColorCorrectionEffect.Contrast
				OldTintColorc = ColorCorrectionEffect.TintColor
				OldTintColore = ColorCorrectionEffect2.TintColor
				ColorCorrectionEffect.Brightness = 0.176
				ColorCorrectionEffect.Contrast = 0.39
				ColorCorrectionEffect.TintColor = Color3.fromRGB(217, 145, 57)
				ColorCorrectionEffect2.TintColor = Color3.fromRGB(217, 145, 57)
				game.Lighting.FogEnd = 999
				spawn(function()
					while _G.RTXMode do
						wait()
						game.Lighting.Ambient = Color3.fromRGB(33, 33, 33)
						game.Lighting.Brightness = 0.3

						if not _G.RTXMode then
							break
						end

						if LocalPlayer2.Character then
							if LocalPlayer2.Character:FindFirstChild("HumanoidRootPart") then
								if not LocalPlayer2.Character.HumanoidRootPart:FindFirstChild("RTXPointLight") then
									local PointLight = Instance.new("PointLight")

									PointLight.Name = "RTXPointLight"
									PointLight.Parent = LocalPlayer2.Character.HumanoidRootPart
									PointLight.Range = 15
									PointLight.Color = Color3.fromRGB(217, 145, 57)
								end
							end
						end
					end
				end)
			else
				pcall(function()
					if OldAmbient then
						game.Lighting.Ambient = OldAmbient
					end

					if OldBrightness then
						game.Lighting.Brightness = OldBrightness
					end

					if OldColorShift_Top then
						game.Lighting.ColorShift_Top = OldColorShift_Top
					end

					game.Lighting.FogEnd = 2500
				end)

				for _, child in pairs(game.Lighting:GetChildren()) do
					if child.Name == "RTXColorCorrection" or child.Name == "RTXTint" then
						child:Destroy()
					end
				end

				if LocalPlayer2.Character then
					if LocalPlayer2.Character:FindFirstChild("HumanoidRootPart") then
						local RTXPointLight = LocalPlayer2.Character.HumanoidRootPart:FindFirstChild("RTXPointLight")

						if RTXPointLight then
							RTXPointLight:Destroy()
						end
					end
				end
			end
		end
	})
end

GRP_Misc_Graphics_Haki_Stats:AddButton({
	Text = "Turn on Fast Mode",
	Func = function()
		local descendants, v1486 = workspace:GetDescendants()

		for _, v1 in next, descendants, v1486 do
			if table.find(t2, v1.ClassName) then
				v1.Material = "Plastic"
			end
		end
	end
})
GRP_Misc_Graphics_Haki_Stats:AddButton({
	Text = "Turn on Low CPU",
	Func = function()
		LowCpu()
	end
})

do
	GRP_Misc_Graphics_Haki_Stats:AddButton({
		Text = "Turn on increase Boats",
		Func = function()
			for _, child in pairs(workspace.Boats:GetChildren()) do
				if tostring(child.Owner.Value) == tostring(LocalPlayer2.Name) then
					for _, descendant in pairs(child:GetDescendants()) do
						if descendant:IsA("VehicleSeat") then
							descendant.MaxSpeed = 350
							descendant.Torque = 0.2
							descendant.TurnSpeed = 5
							descendant.HeadsUpDisplay = true
						end
					end
				end
			end
		end
	})
end

GRP_Misc_Graphics_Haki_Stats:AddButton({
	Text = "Remove Sky Fog",
	Func = function()
		for _, child in pairs(game.Lighting:GetChildren()) do
			if child.Name == "Sky" or child.Name == "LightingLayers" or child.Name == "SeaTerrorCC" or child.Name == "FantasySky" then
				child:Destroy()
			end
		end
	end
})
GRP_Misc_Configure_God = t15.Misc:AddLeftGroupbox("Configure - God")
GRP_Misc_Configure_God:AddButton({
	Text = "Rain Fruits (Client)",
	Func = function()
		if ReplicatedStorage3:FindFirstChild("Assets") then
			if ReplicatedStorage3.Assets:FindFirstChild("Models") then
				local children = ReplicatedStorage3.Assets.Models:GetChildren()

				for _, child in pairs(children) do
					if child:IsA("Model") and child.Name ~= "IceSpikes4" then
						local clone = child:Clone()

						clone.Parent = workspace

						if clone:FindFirstChild("Float") then
							clone.Float:Destroy()
						end

						clone:SetPrimaryPartCFrame(CFrame.new(LocalPlayer2.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50))))
					end
				end
			end
		end
	end
})
briggt1 = GRP_Misc_Configure_God:AddToggle("Turn_on_Full_Bright", {
	Text = "Turn on Full Bright",
	Default = false,
	Callback = function(p353)
		_G.SelectDN = p353
	end
})
DayN = GRP_Misc_Configure_God:AddDropdown("Select_Time", {
	Text = "Select Time",
	Values = {
		"Day",
		"Night"
	},
	Default = 1,
	Callback = function(p354)
		_G.SelectDN = p354
	end
})
dayornight = GRP_Misc_Configure_God:AddToggle("Turn_on_Time", {
	Text = "Turn on Time",
	Default = false,
	Callback = function(p355)
		_G.daylightN = p355
	end
})

do
	task.spawn(function()
		while task.wait() do
			if _G.daylightN then
				if _G.SelectDN == "Day" then
					Lighting.ClockTime = 12
				elseif _G.SelectDN == "Night" then
					Lighting.ClockTime = 0
				end
			end
		end
	end)
end

walkWater = GRP_Misc_Configure_God:AddToggle("Turn_on_Walk_on_Water", {
	Text = "Turn on Walk on Water",
	Default = true,
	Callback = function(p356)
		_G.WalkWater_Part = p356

		if _G.WalkWater_Part then
			game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
		else
			game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
		end
	end
})

do
	iceWalk = GRP_Misc_Configure_God:AddToggle("Turn_on_Ice_Walk", {
		Text = "Turn on Ice Walk",
		Default = false,
		Callback = function(p357)
			_G.WalkWater = p357
		end
	})
end

do
	spawn(function()
		while task.wait() do
			if _G.WalkWater then
				pcall(function()
					if LocalPlayer2.Character then
						if LocalPlayer2.Character:FindFirstChild("LeftFoot") then
							local clone = ReplicatedStorage3.Assets.Models.IceSpikes4:Clone()

							clone.Parent = workspace
							clone.Size = Vector3.new(3 + math.random(10, 12), 1.7, 3 + math.random(10, 12))
							clone.Color = Color3.fromRGB(128, 187, 219)
							clone.CFrame = CFrame.new(LocalPlayer2.Character.Head.Position.X, -3.8, LocalPlayer2.Character.Head.Position.Z) * CFrame.Angles((math.random() - 0.5) * 0.06, math.random() * 7, (math.random() - 0.5) * 0.07)

							local t50 = {
								Size = Vector3.new(0, 0.3, 0)
							}
							local tween = TW:Create(clone, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), t50)

							tween.Completed:Connect(function()
								clone:Destroy()
							end)
							tween:Play()
						end
					end
				end)
			end
		end
	end)
end

do
	local LocalPlayer3 = game.Players.LocalPlayer

	local function v1503(p358)
		if not p358 then
			return false
		end

		local Humanoid = p358:FindFirstChild("Humanoid")

		return Humanoid and Humanoid.Health > 0
	end
	local function v1505(p359, p360)
		local children = game:GetService("Workspace").Enemies:GetChildren()
		local players = game:GetService("Players"):GetPlayers()
		local t51 = {}
		local Position = p359:GetPivot().Position

		for _, child in ipairs(children) do
			local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart and v1503(child) and (HumanoidRootPart.Position - Position).Magnitude <= p360 then
				table.insert(t51, child)
			end
		end

		for _, player in ipairs(players) do
			if player ~= LocalPlayer3 and player.Character then
				local HumanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")

				if HumanoidRootPart and v1503(player.Character) and (HumanoidRootPart.Position - Position).Magnitude <= p360 then
					table.insert(t51, player.Character)
				end
			end
		end

		return t51
	end

	AttackNoCoolDown = function()
		local LocalPlayer4 = game:GetService("Players").LocalPlayer
		local Character = LocalPlayer4.Character

		if not Character then
			return
		end

		local v1518
		local v1519, v1520, v1521 = ipairs(Character:GetChildren())
		local v1522 = geniter(v1519, v1520, v1521)

		while true do
			local v1523 = table.pack(v1522())

			if not v1523[1] then
				break
			end

			local v1524 = v1523[3]

			if v1524:IsA("Tool") then
				v1518 = v1524

				break
			end
		end

		if not v1518 then
			return
		end

		local v1525 = v1505(Character, 60)

		if #v1525 == 0 then
			return
		end

		local ReplicatedStorage4 = game:GetService("ReplicatedStorage")
		local Modules = ReplicatedStorage4:FindFirstChild("Modules")

		if not Modules then
			return
		end

		local RERegisterAttack = ReplicatedStorage4:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
		local RERegisterHit = ReplicatedStorage4:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")

		if not RERegisterAttack or not RERegisterHit then
			return
		end

		local t52 = {}
		local v1531
		local v1532, v1533, v1534 = ipairs(v1525)

		for _, v1 in v1532, v1533, v1534 do
			if not v1:GetAttribute("IsBoat") then
				local t53 = {
					"RightLowerArm",
					"RightUpperArm",
					"LeftLowerArm",
					"LeftUpperArm",
					"RightHand",
					"LeftHand"
				}
				local PrimaryPart = v1:FindFirstChild(t53[math.random(#t53)]) or v1.PrimaryPart

				if PrimaryPart then
					table.insert(t52, {
						v1,
						PrimaryPart
					})
					v1531 = PrimaryPart
				end
			end
		end

		if not v1531 then
			return
		end

		RERegisterAttack:FireServer(0)

		local PlayerScripts = LocalPlayer4:FindFirstChild("PlayerScripts")

		if not PlayerScripts then
			return
		end

		local LocalScript = PlayerScripts:FindFirstChildOfClass("LocalScript")

		while not LocalScript do
			PlayerScripts.ChildAdded:Wait()
			LocalScript = PlayerScripts:FindFirstChildOfClass("LocalScript")
		end

		local SendHitsToServer

		if getsenv then
			local ok, result = pcall(getsenv, LocalScript)

			if ok and result then
				SendHitsToServer = result._G.SendHitsToServer
			end
		end

		local ok, result = pcall(function()
			return require(Modules.Flags).COMBAT_REMOTE_THREAD or false
		end)

		if ok and result and SendHitsToServer then
			SendHitsToServer(v1531, t52)
		elseif ok and not result then
			RERegisterHit:FireServer(v1531, t52)
		end
	end
end

CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
CameraShakerR:Stop()

do
	get_Monster = function()
		for _, child in pairs(workspace.Enemies:GetChildren()) do
			local UpperTorso = child:FindFirstChild("UpperTorso") or child:FindFirstChild("Head")

			if child:FindFirstChild("HumanoidRootPart", true) and UpperTorso and (child.Head.Position - LocalPlayer2.Character.HumanoidRootPart.Position).Magnitude <= 50 then
				return true, UpperTorso.Position
			end
		end

		for _, child in pairs(workspace.SeaBeasts:GetChildren()) do
			if child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Health") and child.Health.Value > 0 then
				return true, child.HumanoidRootPart.Position
			end
		end

		for _, child in pairs(workspace.Enemies:GetChildren()) do
			if child:FindFirstChild("Health") and child.Health.Value > 0 and child:FindFirstChild("VehicleSeat") then
				return true, child.Engine.Position
			end
		end
	end
end

do
	Actived = function()
		local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
		local v1554, v1555 = getconnections(Tool.Activated)

		for _, v1 in next, v1554, v1555 do
			if typeof(v1.Function) == "function" then
				getupvalues(v1.Function)
			end
		end
	end
end

do
	task.spawn(function()
		RunSer.Heartbeat:Connect(function()
			pcall(function()
				if not _G.Seriality then
					return
				end

				AttackNoCoolDown()

				local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
				local ToolTip = Tool.ToolTip
				local v1560 = get_Monster()

				if ToolTip == "Blox Fruit" and v1560 then
					local LeftClickRemote = Tool:FindFirstChild("LeftClickRemote")

					if LeftClickRemote then
						Actived()
						LeftClickRemote:FireServer(Vector3.new(0.01, -500, 0.01), 1, true)
						LeftClickRemote:FireServer(false)
					end
				end
			end)
		end)
	end)
end

local Players2 = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage4 = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer3 = Players2.LocalPlayer

if not LocalPlayer3.Character then
	LocalPlayer3.CharacterAdded:Wait()
end

local function v1570(p361, p362)
	local _, result = pcall(function()
		return p361:WaitForChild(p362)
	end)

	return result
end

local enemies = v1570(Workspace, "Enemies")
local characters = v1570(Workspace, "Characters")
local modules = v1570(ReplicatedStorage4, "Modules")
local net = v1570(modules, "Net")
local t54 = {
	Rate = 2e-09,
	Enabled = true,
	IsAlive = function(p363)
		local Humanoid = p363:FindFirstChild("Humanoid")

		if Humanoid and Humanoid.Health > 0 then
			return true
		end

		return false
	end,
	GetNearbyTargets = function(p364, p365)
		local Position = p364:GetPivot().Position
		local t56 = {}
		local children = p365:GetChildren()

		for i = 1, #children do
			local v1582 = children[i]
			local Humanoid = v1582:FindFirstChild("Humanoid")
			local HumanoidRootPart = v1582:FindFirstChild("HumanoidRootPart")

			if Humanoid and HumanoidRootPart and Humanoid.Health > 0 and (HumanoidRootPart.Position - Position).Magnitude <= 60 then
				table.insert(t56, v1582)
			end
		end

		return t56
	end
}

local function getTargetParts(p366)
	local t57 = {}

	for i = 1, #p366 do
		local v1588 = p366[i]
		local Head = v1588:FindFirstChild("Head") or v1588.PrimaryPart

		if Head then
			table.insert(t57, {
				v1588,
				Head
			})
		end
	end

	return t57
end

t54.GetTargetParts = getTargetParts
t54.GetAllTargets = function(p367)
	local v1590 = t54.GetNearbyTargets(p367, enemies)
	local v1591 = t54.GetNearbyTargets(p367, characters)
	local t58 = {}

	for i = 1, #v1590 do
		table.insert(t58, v1590[i])
	end

	for i = 1, #v1591 do
		table.insert(t58, v1591[i])
	end

	return t58
end
t54.ExecuteFastAttack = function()
	local Character = LocalPlayer3.Character

	if not Character then
		return
	end

	if not Character:FindFirstChildOfClass("Tool") then
		return
	end

	local v1596 = t54.GetAllTargets(Character)

	if #v1596 < 1 then
		return
	end

	local v1597 = t54.GetTargetParts(v1596)

	if #v1597 < 1 then
		return
	end

	local reRegisterHit = net["RE/RegisterHit"]

	net["RE/RegisterAttack"]:FireServer(t54.Rate)
	reRegisterHit:FireServer(v1597[1][2], v1597)
end

local u1599
local attribute

local function v1601()
	for _, v1 in ipairs({
		ReplicatedStorage4.Util,
		ReplicatedStorage4.Common,
		ReplicatedStorage4.Remotes,
		ReplicatedStorage4.Assets,
		ReplicatedStorage4.FX
	}) do
		local children = v1:GetChildren()

		for _, child in ipairs(children) do
			if child:IsA("RemoteEvent") and child:GetAttribute("Id") then
				u1599 = child
				attribute = child:GetAttribute("Id")
			end
		end

		v1.ChildAdded:Connect(function(child)
			if child:IsA("RemoteEvent") and child:GetAttribute("Id") then
				u1599 = child
				attribute = child:GetAttribute("Id")
			end
		end)
	end
end

v1601()

local t55 = {
	Execute = function()
		local Character = LocalPlayer3.Character

		if not Character then
			return
		end

		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return
		end

		local t59 = {}

		local function v1610(p368)
			local children = p368:GetChildren()

			for i = 1, #children do
				local v1613 = children[i]
				local Humanoid = v1613:FindFirstChild("Humanoid")
				local HumanoidRootPart2 = v1613:FindFirstChild("HumanoidRootPart")

				if Humanoid and HumanoidRootPart2 and Humanoid.Health > 0 and v1613 ~= Character and (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude <= 60 then
					local children2 = v1613:GetChildren()

					for _, v1 in ipairs(children2) do
						if v1:IsA("BasePart") then
							table.insert(t59, {
								v1613,
								v1
							})
						end
					end
				end
			end
		end

		v1610(enemies)
		v1610(characters)

		local Tool = Character:FindFirstChildOfClass("Tool")

		if #t59 > 0 and Tool and (Tool:GetAttribute("WeaponType") == "Melee" or Tool:GetAttribute("WeaponType") == "Sword") then
			local response = modules.Net.seed:InvokeServer()
			local reRegisterHit = net["RE/RegisterHit"]

			net["RE/RegisterAttack"]:FireServer()

			local Head = t59[1][1]:FindFirstChild("Head")

			if not Head then
				return
			end

			reRegisterHit:FireServer(Head, t59, {})

			if u1599 then
				local v1623 = math.floor(Workspace:GetServerTimeNow() / 10 % 10) + 1
				local RegisterHit = string.gsub("RE/RegisterHit", ".", function(p369)
					return string.char(bit32.bxor(string.byte(p369), v1623))
				end)
				local v1625 = bit32.bxor(attribute + 909090, response * 2)

				cloneref(u1599):FireServer(RegisterHit, v1625, Head, t59)
			end
		end
	end
}

local function v1626()
	require(ReplicatedStorage4.Util.CameraShaker):Stop()
end

do
	local function v1627()
		task.spawn(function()
			while task.wait(t54.Rate) do
				t54.ExecuteFastAttack()
			end
		end)
		RunService.Heartbeat:Connect(function()
			pcall(t55.Execute)
		end)
	end

	v1627()
end

lib:Notify({
	Title = "Meizu Hub",
	Description = "Đã tải Meizu Hub v1.1.0",
	Icon = "rbxassetid://5009915795",
	Duration = 5
})

-- UI FIX: Removed the appended replacement-shell block that hid Main and reparented
-- Concacmain into a second window. The original library UI is left intact.
