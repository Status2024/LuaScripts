local GuiColor = {
	Base_	= Color3.new(0.184314,0.105882,0.4431373),
	Red_	= Color3.new(1,0.8,0.8),
	Green_	= Color3.new(0.8,1,0.8),
	Blue_	= Color3.new(0.8,0.8,1),
	
	Text_LWhite_= Color3.new(0.7,0.7,0.7),
	Text_LBlack_= Color3.new(0.3,0.3,0.3),
	Text_White_	= Color3.new(1,1,1),
	Text_Black_	= Color3.new(0,0,0),
	Text_Red_	= Color3.new(1,0.7,0.7),
	Text_Green_	= Color3.new(0.7,1,0.7),
	Text_Blue_	= Color3.new(0.7,0.7,1),
	
	On_Color_G	= Color3.new(0, 1, 0),
	On_Color_B	= Color3.new(0, 1, 1),
	On_Color_Y	= Color3.new(1, 1, 0)}

local CreateObject = {
	CreateInstance = function(class,properties)
		local instance_ = Instance.new(class)
		for i,v in pairs(properties) do
			instance_[i] = v
		end
		return instance_
	end,
	
	CreateCorner = function(object,r)
		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, r)
		Corner.Parent = object
		return object
	end}

local function createButton(properties)
	local button_ = CreateObject.CreateInstance("TextButton",{BackgroundColor3=GuiColor.Base_,BackgroundTransparency=0.4,BorderSizePixel=3,
		AutoButtonColor=true,TextColor3=GuiColor.Text_White_,Font=Enum.Font.GothamBold,TextSize=12,TextTransparency=0,TextWrapped=false})
	for i,v in pairs(properties) do
		button_[i] = v
	end
	CreateObject.CreateCorner(button_,2)
	return button_
end

local ButtonState = {

	Forms = function(button,row,column,segment)
		button.Row = row
		button.Column = column
		button.Segment = segment
	end,
	
	Position = function(buTTon)
		local X = buTTon.Column * buTTon.GapX + (buTTon.Column - 1) * buTTon.SizeX
		local Y = (buTTon.Row + buTTon.Segment - 1) * buTTon.GapY + (buTTon.Row - 1) * buTTon.SizeY
		return UDim2.new(0, X, 0, Y)
	end,

	Size = function(buTTon)
		return UDim2.new(0, buTTon.SizeX, 0, buTTon.SizeY)
	end,

	On = function(button)
		button.BackgroundColor3 = GuiColor.On_Color_G
		print(button.Name, "on")
	end,

	Off = function(button)
		button.AutoButtonColor = false
		button.BackgroundColor3 = GuiColor.Text_LBlack_
		print(button.Name, "off")
	end,

	OnOff = function(button)
		if	button.BackgroundColor3 == GuiColor.Base_ then
			button.BackgroundColor3 = GuiColor.On_Color_G
			print(button.Name, "on")--On(button)
			return true
		else
			button.AutoButtonColor = false
			button.BackgroundColor3 = GuiColor.Text_LBlack_
			print(button.Name, "off")--Off(button)
			return false
		end
	end,

	Activation = function (button)
		button.AutoButtonColor = true
		button.BackgroundColor3 = GuiColor.Base_
		print(button.Name, "actived")
	end,

	LaunchPeriod = function (button, second)
		for i = 1, math.floor(second) do
			if	not button.AutoButtonColor then
				return false
			end
			wait(1)
		end
		return true
	end}

local KonOvalGUI = CreateObject.CreateInstance("ScreenGui",{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,
	Name="[KonOvalGUI]MainGUI"})

local Dark_Frame = CreateObject.CreateInstance("Frame",{Active=false, Selectable=false, Draggable=false,
	BackgroundColor3=GuiColor.Text_Black_,Transparency=1,BorderSizePixel=0,
	Size=UDim2.new(0, 1, 0, 1),Position=UDim2.new(0, 0, 0, -36),Name="Dark_Frame",Parent=KonOvalGUI})

local Start_Frame = CreateObject.CreateInstance("Frame",{Active=true, Selectable=true, Draggable=true,
	BackgroundColor3=GuiColor.Text_Black_,Transparency=1,BorderSizePixel=0,
	Size=UDim2.new(0, 230, 0, 65),Position=UDim2.new(0.01, 0, 0.18, 0),Name="Start_Frame",Parent=KonOvalGUI})	
local Main_Frame = CreateObject.CreateInstance("Frame",{Active=true, Selectable=true,
	BackgroundColor3=GuiColor.Base_,Transparency=0.8,BorderSizePixel=0,
	Size=UDim2.new(0, 220, 0, 55),Position=UDim2.new(0, 5, 0, 5),Name="Main_Frame",Parent=Start_Frame})
local Menu_Frame = CreateObject.CreateInstance("Frame",{Active=true, Selectable=true,
	BackgroundColor3=GuiColor.Base_,Transparency=1,BorderSizePixel=0,Visible=false,
	Size=UDim2.new(0, 1, 0, 1),Position=UDim2.new(0, 5, 0, 65),Name="Menu_Frame",Parent=Start_Frame})
local Field_Frame = CreateObject.CreateInstance("Frame",{Active=true, Selectable=true,
	BackgroundColor3=GuiColor.Base_,Transparency=1,BorderSizePixel=0,Visible=false,
	Size=UDim2.new(0, 1, 0, 1),Position=UDim2.new(0, 80, 0, 0),Name="Field_Frame",Parent=Menu_Frame})	
local Actions_Frame = CreateObject.CreateInstance("Frame",{Active=true, Selectable=true,
	BackgroundColor3=GuiColor.Base_,Transparency=1,BorderSizePixel=0,Visible=false,
	Size=UDim2.new(0, 1, 0, 1),Position=UDim2.new(0, 80, 0, 0),Name="Actions_Frame",Parent=Menu_Frame})	
local Settings_Frame = CreateObject.CreateInstance("Frame",{Active=true, Selectable=true,
	BackgroundColor3=GuiColor.Base_,Transparency=1,BorderSizePixel=0,Visible=false,
	Size=UDim2.new(0, 1, 0, 1),Position=UDim2.new(0, 80, 0, 0),Name="Settings_Frame",Parent=Menu_Frame})

------------------Main_Frame------------------
local TPTopButton = createButton({Size=UDim2.new(0, 15, 0, 10),Position=UDim2.new(0, 1, 0, 1),
	Text=" ",Name="TPTopButton",Parent=Main_Frame})
local TPPepButton = createButton({Size=UDim2.new(0, 15, 0, 10),Position=UDim2.new(0, 1, 0, 15),
	Text=" ",Name="TPPepButton",Parent=Main_Frame})
local ViciousTPBotton = createButton({Size=UDim2.new(0, 25, 0, 10),Position=UDim2.new(0, 160, 0, 1),
	Text="Vicious",Name="ViciousTPBotton",Parent=Main_Frame,TextSize = 4,Transparency = 1})
local WindyTPBotton = createButton({Size=UDim2.new(0, 25, 0, 10),Position=UDim2.new(0, 160, 0, 15),
	Text="Windy",Name="WindyTPBotton",Parent=Main_Frame,TextSize = 4,Transparency = 1})
local MushroomPoint = createButton({Size=UDim2.new(0, 25, 0, 20),Position=UDim2.new(0, 160, 0, 30),
	Text="0",Name="MushroomPoint",Parent=Main_Frame,TextSize = 16,Transparency = 1})
local TextView = CreateObject.CreateInstance("TextLabel",{Size=UDim2.new(0, 140, 0, 20),Position=UDim2.new(0, 20, 0, 5),
	BackgroundColor3=GuiColor.Base_,BackgroundTransparency=1,BorderSizePixel=0,TextTransparency=0,
	TextColor3=GuiColor.Text_White_,Font=Enum.Font.GothamBold,TextSize=14,TextWrapped=false,
	Text = "Stump Field",Name="TextView",Parent=Main_Frame})
local MenuBotton = createButton({Size=UDim2.new(0, 30, 0, 20),Position=UDim2.new(0, 5, 0, 30),
	Text=">>",Name="MenuBotton",Parent=Main_Frame,TextSize = 14})

local ButtonSet = {Row=1;Column=1;Segment=1;GapX=4;GapY=4;SizeX=90;SizeY=16}
ButtonState.Forms(ButtonSet,1,3,1)
local AutoMushrooms = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="AMush",Name="AutoMushrooms",Parent=Settings_Frame,TextSize = 10})
ButtonState.Forms(ButtonSet,4,2,1)
local AutoVicious = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="AVicious",Name="AutoVicious",Parent=Settings_Frame,TextSize = 10})
ButtonState.Forms(ButtonSet,5,2,1)
local AutoWindy = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="AWindy",Name="AutoWindy",Parent=Settings_Frame,TextSize = 10})
ButtonState.Forms(ButtonSet,6,2,1)
local AutoStickBug = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="AStickBug",Name="AutoStickBug",Parent=Settings_Frame,TextSize = 10})

KonOvalGUI.Parent = game.CoreGui

spawn(function()
	fieldPosition = workspace.FlowerZones[TextView.Text].Position
	humanoidRootPart = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
	humanoid = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid")
	spawnPosHumanoid = game.Players.LocalPlayer.SpawnPos.Value
	fieldCFrame = CFrame.new(workspace.FlowerZones[TextView.Text].Position)
	game.Players.LocalPlayer.CameraMaxZoomDistance = 777
	workspace.Gravity = 170

	SizeField = {distanceToBoard=5,min_X=0,max_X=0,min_Z=0,max_Z=0}
function setMaxMinSizeField(distance)
	local sizeField = workspace.FlowerZones[TextView.Text].Size
	SizeField.min_X = fieldPosition.x - (sizeField.x / 2) + distance
	SizeField.max_X = fieldPosition.x + (sizeField.x / 2) - distance
	SizeField.min_Z = fieldPosition.z - (sizeField.z / 2) + distance
	SizeField.max_Z = fieldPosition.z + (sizeField.z / 2) - distance
	wait(.5)
end
	setMaxMinSizeField(SizeField.distanceToBoard)
end)

local ConnectionKey = {ConnectionT,ConnectionV,ConnectionRXC,VirtualUserActive}
local HumanoidState = {Speed=0,TmpSpeed=0,MaskEquipped=0}
local HumanoidAction = {AllStarting=true,Farm=false,FarmToSp=false,Pause=false,CapacityUnloading=false}
local AutoFlags = {
	DigBottonDown=false,
	MobsBottonDown=false,
	ViciousBottonDown=false,
	WindyBottonDown=false,
	MondoBottonDown=false,
	StickBugBottonDown=false,
	DispenserBottonDown=false,
	BoostBottonDown=false,
	TornadoBottonDown=false,
	MushroomsBottonDown=false,
	ChristmasBottonDown=false,
	DisableFoldingBotton=false}
local ActionFlags = {
	BalloonBottonDown=false,
	BalloonTrackingStarted=false,
	BalloonTrackingStarted_=false,
	StateBalloonBotton=0,
	CapasityBalloon=0,
	TimeAfterBalloonUnloading=0,
	SnailTimeBottonDown=0,
	MushroomLvl=0,
	MushroomClass=0,
	MushroomCFrame=CFrame.new(-100,-100,-100)}

local function hideFrames()
	for _,k in pairs(Menu_Frame:GetChildren()) do
		if	k:IsA("Frame") then
			k.Visible = false
		elseif k:IsA("TextButton") then
			k.BackgroundColor3 = GuiColor.Base_
		end
	end
end

local function displayFrame(button, frame)
	if	frame.Visible then
		frame.Visible = false
		button.BackgroundColor3 = GuiColor.Base_
	else
		hideFrames()
		frame.Visible = true
		button.BackgroundColor3 = GuiColor.On_Color_B
	end
end

local function MenubottonDown()
if not Menu_Frame.Visible then
	MenuBotton.BackgroundColor3 = GuiColor.On_Color_G
	Menu_Frame.Visible = true
else
	MenuBotton.BackgroundColor3 = GuiColor.Base_
	Menu_Frame.Visible = false
end
end

local function SpeedBottonFunction()
local SpeedBottonFunctionIn = coroutine.wrap(function()
while HumanoidState.Speed > 30 do
	humanoid.WalkSpeed = HumanoidState.Speed
	wait(.2)
end
end)

SpeedBottonFunctionIn()
end

local lutCollection = false
local timeLutCollection = 3
local function TimeLutCollection()
local TimeLutCollectionIn = coroutine.wrap(function()
	lutCollection = true
	wait(timeLutCollection)
	lutCollection = false
end)

TimeLutCollectionIn()
end

local function SplinkerInstalling()
	wait(.2)
	local A_1 = {["Name"] = "Sprinkler Builder"}
	game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer(A_1)
	wait(.2)
end

local function GoToSpawnPosition()
	humanoidRootPart.CFrame = game.Players.LocalPlayer.SpawnPos.Value
	wait(1)
	game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
end

local function CheckBalloon()
local capasityBalloonText_ = ""
for _,v in pairs(game.workspace.Balloons.HiveBalloons:GetChildren()) do
	if string.find(v.Name,"HiveBalloonInstance") then
		for _,k in pairs(v:GetChildren()) do
			if k.Name == "BalloonBody" then
				local distance_ =((k.Position.x - spawnPosHumanoid.x)^2 + 
					(k.Position.y - spawnPosHumanoid.y)^2 + 
					(k.Position.z - spawnPosHumanoid.z)^2)^0.5
				if distance_ < 20 then
					for _, descendant in pairs(k:GetDescendants()) do
						if (descendant.Name == "Bar") then
							for _,i in pairs(descendant:GetChildren()) do
								if (i.Name == "TextLabel") then
									capasityBalloonText_ = string.gsub(i.Text, ",", "")
									if capasityBalloonText_ == "" then
										ActionFlags.CapasityBalloon = 0
									else
										ActionFlags.CapasityBalloon = tonumber(capasityBalloonText_)
									end
									return
								end
							end
						end
					end
				end
			end
		end
	end
end
ActionFlags.CapasityBalloon = 0
end

local function CapacitySpawnPositionChecking()
local CapacitySpawnPositionCheckingIn = coroutine.wrap(function()
local tmpPollen_ = game.Players.LocalPlayer.CoreStats.Pollen.Value
wait(40)
while HumanoidAction.CapacityUnloading do
	if not HumanoidAction.Farm then break end
	if ((Vector3.new(spawnPosHumanoid.x, spawnPosHumanoid.y, spawnPosHumanoid.z) -
		humanoidRootPart.Position).magnitude >= 7) or	
		(tmpPollen_ <= game.Players.LocalPlayer.CoreStats.Pollen.Value) then
		wait(.1)
		GoToSpawnPosition()
	end
	tmpPollen_ = game.Players.LocalPlayer.CoreStats.Pollen.Value
	wait(10)
	if game.Players.LocalPlayer.CoreStats.Pollen.Value == 0 then break end
end
end)
CapacitySpawnPositionCheckingIn()
end

local function BalloonSpawnPositionChecking()
local BalloonSpawnPositionCheckingIn = coroutine.wrap(function()
CheckBalloon()
tmpPollen_ = ActionFlags.CapasityBalloon
wait(10)
while HumanoidAction.CapacityUnloading do
	if not HumanoidAction.Farm then break end
	CheckBalloon()
	if ActionFlags.CapasityBalloon == 0 then break end
	if ((Vector3.new(spawnPosHumanoid.x, spawnPosHumanoid.y, spawnPosHumanoid.z) -
		humanoidRootPart.Position).magnitude >= 7) or	
		(tmpPollen_ <= ActionFlags.CapasityBalloon) then
		wait(.1)
		GoToSpawnPosition()
	end
	tmpPollen_ = ActionFlags.CapasityBalloon
	wait(10)
end
end)
BalloonSpawnPositionCheckingIn()
end

local moveToPointFlag = false
local function MoveToPoint(targetPoint)
	moveToPointFlag = false
	local connection_
	connection_ = humanoid.MoveToFinished:Connect(function(reached)
		moveToPointFlag = true
		connection_:Disconnect()
		connection_ = nil
	end)
	humanoid:MoveTo(targetPoint)
	while not moveToPointFlag do
		if not AutoFlags.MobsBottonDown then break end
		if not (humanoid and humanoid.Parent) then break end
		if humanoid.WalkToPoint ~= targetPoint then	break end
		humanoid:MoveTo(targetPoint)
		wait(1)
	end
end

local function MoveToToken(targetPoint)
	moveToPointFlag = false	
	local connection_
	connection_ = humanoid.MoveToFinished:Connect(function(reached)
		moveToPointFlag = true
		connection_:Disconnect()
		connection_ = nil
	end)
	humanoid:MoveTo(targetPoint)
	while not moveToPointFlag do
		if not HumanoidAction.Farm or HumanoidAction.Pause then break end
		if not (humanoid and humanoid.Parent) then break end
		if humanoid.WalkToPoint ~= targetPoint then	break end
		humanoid:MoveTo(targetPoint)
		wait(.01)
	end
end

local function tpToField()
	local function NoVisibleMenuPage(int)
		if (not AutoFlags.DisableFoldingBotton) and (int == 2) then
			MenuBotton.BackgroundColor3 = GuiColor.Base_
			Menu_Frame.Visible = false
		end
	end
	
	fieldPosition = workspace.FlowerZones[TextView.Text].Position	
	humanoidRootPart.CFrame = CFrame.new(fieldPosition.x, fieldPosition.y + 1, fieldPosition.z)
	NoVisibleMenuPage(2)
end

local function GoToFieldAndSplinker()
if HumanoidAction.Farm then
	tpToField()
	wait(1)
	SplinkerInstalling()
	wait(1)
end
end

local function GoToFieldOrSpawn()
	if HumanoidAction.Farm then tpToField()
	else GoToSpawnPosition() end
end

local function TimeAfterBalloonUnloading()
	ActionFlags.TimeAfterBalloonUnloading = time()
end

local function BackpackBalloonCheckingUnloading()
	if game.Players.LocalPlayer.CoreStats.Capacity.Value <=	game.Players.LocalPlayer.CoreStats.Pollen.Value then
		if not HumanoidAction.Farm then return end
		while HumanoidAction.Pause do
			wait(1)
			if not HumanoidAction.Farm then return end
		end
		HumanoidAction.CapacityUnloading = true
		wait(.5)
		GoToSpawnPosition()
		wait(4)
		CapacitySpawnPositionChecking()
		repeat
			if not HumanoidAction.Farm then break end
			wait(.5)
		until game.Players.LocalPlayer.CoreStats.Pollen.Value == 0
	print("Capacity unloaded")
		if ActionFlags.BalloonBottonDown then
			BalloonSpawnPositionChecking()
			wait(.2)
			while ActionFlags.CapasityBalloon > 0 do
				if not HumanoidAction.Farm or HumanoidAction.Pause then break end
				wait(1)
				CheckBalloon()
			end
			if ActionFlags.CapasityBalloon == 0 then
				TimeAfterBalloonUnloading()
				print("Balloon unloaded")
			end
		end
		wait(4)
		HumanoidAction.CapacityUnloading = false
		GoToFieldAndSplinker()
	end
end

local function BackpackBalloonUnloading()
if HumanoidAction.CapacityUnloading then return end
if not HumanoidAction.Farm then return end
while HumanoidAction.Pause do
	wait(1)
	if not HumanoidAction.Farm then return end
end
HumanoidAction.CapacityUnloading = true
wait(5)
GoToSpawnPosition()
wait(4)
CapacitySpawnPositionChecking()
repeat
	if not HumanoidAction.Farm then break end
	wait(.5)
until game.Players.LocalPlayer.CoreStats.Pollen.Value == 0
if ActionFlags.BalloonBottonDown then
	BalloonSpawnPositionChecking()
	wait(.2)
	while ActionFlags.CapasityBalloon > 0 do
		if not HumanoidAction.Farm then break end
		CheckBalloon()
		wait(1)
	end
	if ActionFlags.CapasityBalloon == 0 then
		TimeAfterBalloonUnloading()
		print("Balloon unloaded afte 45 min")
	end
end
wait(4)
HumanoidAction.CapacityUnloading = false
GoToFieldAndSplinker()
end

local function BackpackUnloadingMushroom(positionMushroom_)
	if game.Players.LocalPlayer.CoreStats.Capacity.Value <=	game.Players.LocalPlayer.CoreStats.Pollen.Value then
		if not AutoFlags.MushroomsBottonDown then return end
		HumanoidAction.CapacityUnloading = true
		wait(.5)
		GoToSpawnPosition()
		wait(4)
		CapacitySpawnPositionChecking()
		repeat
			if not AutoFlags.MushroomsBottonDown then break end
			wait(.5)
		until game.Players.LocalPlayer.CoreStats.Pollen.Value == 0
		print("Capacity unloaded befo Mushrooms")
		wait(4)
		humanoidRootPart.CFrame = CFrame.new(positionMushroom_)
		HumanoidAction.CapacityUnloading = false
	end
end

local function SearchFlowerZone(position)

local field_Position = workspace.FlowerZones["Dandelion Field"].Position
local TmpSizeField = {
	min_X =  0,
	max_X =  0,
	min_Z =  0,
	max_Z =  0,}
	
local function MinMaxField(field)
	field_Position = workspace.FlowerZones[field].Position
	TmpSizeField.max_Z = field_Position.z + (workspace.FlowerZones[field].Size.z / 2)
	TmpSizeField.min_Z = field_Position.z - (workspace.FlowerZones[field].Size.z / 2)
	TmpSizeField.max_X = field_Position.x + (workspace.FlowerZones[field].Size.x / 2)
	TmpSizeField.min_X = field_Position.x - (workspace.FlowerZones[field].Size.x / 2)
	wait(.05)
	if TmpSizeField.max_Z > position.z and TmpSizeField.min_Z < position.z and
		TmpSizeField.max_X > position.x and TmpSizeField.min_X < position.x then
		return true
	else
		return false
	end
end

	if position.z > 56 then
		if workspace.FlowerZones["Dandelion Field"].Position.z +
			(workspace.FlowerZones["Dandelion Field"].Size.z / 2)
			> position.z then
			if MinMaxField("Dandelion Field") then return 1
			elseif MinMaxField("Sunflower Field") then return 1
			elseif MinMaxField("Blue Flower Field") then return 2
			elseif MinMaxField("Mushroom Field") then return 3
			elseif MinMaxField("Rose Field") then return 3
			elseif MinMaxField("Clover Field") then return 0 end
		else
			if MinMaxField("Coconut Field") then return 1
			elseif MinMaxField("Pepper Patch") then return 3 end
		end
	else
		if workspace.FlowerZones["Strawberry Field"].Position.z -
			(workspace.FlowerZones["Strawberry Field"].Size.z / 2)
			< position.z then
			if MinMaxField("Strawberry Field") then return 3
			elseif MinMaxField("Spider Field") then return 1
			elseif MinMaxField("Bamboo Field") then return 2 end
		else
			if MinMaxField("Pineapple Patch") then return 1
			elseif MinMaxField("Pumpkin Patch") then return 1
			elseif MinMaxField("Pine Tree Forest") then return 2
			elseif MinMaxField("Cactus Field") then return 0
			elseif MinMaxField("Mountain Top Field") then return 0
			elseif MinMaxField("Stump Field") then return 2 end
		end
	end
	return 0
end

local function MaskEquiping(position)
local MaskEquipingIn = coroutine.wrap(function()
	if HumanoidState.MaskEquipped == 0 then
		return
	end
	local maskEquiping_
	if position == nil then
		if ActionFlags.SnailTimeBottonDown > 0 then
			maskEquiping_ = 3
		else
			maskEquiping_ = HumanoidState.MaskEquipped
		end
	else
		maskEquiping_ = SearchFlowerZone(position)
		if maskEquiping_ == 0 then
			maskEquiping_ = HumanoidState.MaskEquipped
		end
	end
	local mask_
	if maskEquiping_ == 1 then
		mask_ = "Gummy Mask"
		TPPepButton.BackgroundColor3 = Color3.new(1, 1, 1)
	elseif maskEquiping_ == 2 then
		mask_ = "Diamond Mask"
		TPPepButton.BackgroundColor3 = Color3.new(0.32, 0.4, 1)
	elseif maskEquiping_ == 3 then
		mask_ = "Demon Mask"
		TPPepButton.BackgroundColor3 = Color3.new(1, 0.2, 0,06)
	else return
	end	
	game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer("Equip",
	{["Mute"] = true, ["Type"] = mask_, ["Category"] = "Accessory"})
	wait(.2)
end)

MaskEquipingIn()	
end

local function MushroomSearch()
if ActionFlags.MushroomLvl > 0 then
	for _,v in pairs(game.workspace.Happenings.Puffshrooms:GetChildren()) do
		if string.find(v.Name,"PuffballMushroom") then
			local descendants_ = v:GetDescendants()
			for _, descendant in pairs(descendants_) do
				if descendant.Name == "TextLabel" then
					if (ActionFlags.MushroomClass == 1) or
						(ActionFlags.MushroomClass == 2 and string.find(descendant.Text, "Rare")) or
						(ActionFlags.MushroomClass == 3 and string.find(descendant.Text, "Epic")) or
						(ActionFlags.MushroomClass == 4 and string.find(descendant.Text, "Legendary")) or
						(ActionFlags.MushroomClass == 5 and string.find(descendant.Text, "Mythic")) then
						if ActionFlags.MushroomLvl == tonumber(string.match(descendant.Text, "%d+")) then
							for _, k in pairs(descendants_) do
								if k:IsA("BasePart") then
									if ActionFlags.MushroomCFrame.Y == k.CFrame.Y then
										return v
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
end

local function GoToMushroom()
if ActionFlags.MushroomLvl > 0 then
	local mushroom_ = MushroomSearch()
	for _, k in pairs(mushroom_:GetDescendants()) do
		if k:IsA("BasePart") then
			humanoidRootPart.CFrame = k.CFrame
			SplinkerInstalling()
			return
		end
	end
end
end

local function RemoteQuest()
local RemoteQuestIn = coroutine.wrap(function()
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Brown Bear")
wait(.1)
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Polar Bear")
wait(.1)
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Brown Bear 2")
wait(.1)
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Black Bear 2")
wait(.1)
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Bucko Bee")
wait(.1)
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Riley Bee")
wait(.5)
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Brown Bear")
wait(.1)
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Polar Bear")
wait(.1)
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Brown Bear 2")
wait(.1)
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Black Bear 2")
wait(.1)
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Bucko Bee")
wait(.1)
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Riley Bee")
wait(.1)
end)

RemoteQuestIn()
end

local function AutoMobsKillFunction()
local function Collect_Dist30()
	for _,v in pairs(workspace.Collectibles:GetChildren()) do
	if (v.Position - humanoidRootPart.Position).magnitude <= 30 then
	if ((v.Position.y > humanoidRootPart.Position.y - 5) and (v.Position.y < humanoidRootPart.Position.y + 15)) then
	if AutoFlags.MobsBottonDown then
		humanoid:MoveTo(Vector3.new(v.Position.x, humanoidRootPart.Position.y, v.Position.z), nil)
		wait(.2)
	else
		break
	end
	end
	end
	end
end

local AutoMobsKill = coroutine.wrap(function()
while AutoFlags.MobsBottonDown do
	RemoteQuest()
	while HumanoidAction.Pause or HumanoidAction.CapacityUnloading do
		wait(25)
	end
	HumanoidAction.Pause = true
	wait(2)
	humanoidRootPart.CFrame = Waypoints["Star Room"]
	wait(10)
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(104, 66, 282))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(151, 34, 197))
		wait(5)
		for count = 1, 5 do	Collect_Dist30() end
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(120, 4, 104))
		wait(5)
		for count = 1, 5 do	Collect_Dist30() end
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(105, 4, 87))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(39, 4, 140))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-5, 4, 174))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-85, 4, 120))		
		wait(5)
		for count = 1, 5 do	Collect_Dist30() end
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-85, 4, 120))	
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-13, 4, 171))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(0, 20, 50))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-33, 20, -2))
		wait(5)
		for count = 1, 5 do	Collect_Dist30() end
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-120, 20, 13))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-180, 20, -3))
		wait(5)
		for count = 1, 5 do	Collect_Dist30() end
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-137, 20, 59))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-239, 35, 56))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-245, 68, -81))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-328, 68, -181))
		wait(9)
		for count = 1, 9 do	Collect_Dist30() end
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-336, 68, -77))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-332, 20, 130))
		wait(9)
		for count = 1, 9 do	Collect_Dist30() end
	MoveToPoint(Vector3.new(-332, 20, 130))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-266, 20, 177))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-215, 4, 206))--
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-208, 4, 140))--
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-90, 4, 214))--
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(0, 4, 225))--
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(-13, 4, 171))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(0, 20, 50))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(150, 20, -28))
		wait(7)
		for count = 1, 5 do	Collect_Dist30() end
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(205, 20, -24))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(204, 42, 56))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(227, 42, 56))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(232, 68, -86))
		if not AutoFlags.MobsBottonDown	then break end
	MoveToPoint(Vector3.new(253, 68, -205))
		wait(5)
		for count = 1, 5 do	Collect_Dist30() end
	wait(1)
	if not AutoFlags.MobsBottonDown then HumanoidAction.Pause = false break end	
	if HumanoidAction.Farm then tpToField()
	else GoToSpawnPosition() end
	wait(5)
	HumanoidAction.Pause = false
	for mi = 1, 20 do
	for delta = 1, 3 do
		if not AutoFlags.MobsBottonDown then break end
		wait(20)
	end
	end	
end
HumanoidAction.Pause = false
end)

AutoMobsKill()
end

local function AutoDiging()
local AutoDigIn = coroutine.wrap(function()
while AutoFlags.DigBottonDown do
	wait(0.3)           
	for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			v.ClickEvent:FireServer()
		end
	end
end
end)

AutoDigIn()
end

local function checkKilled(timeDelay)
	humanoidRootPart = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
	if (Vector3.new(spawnPosHumanoid.x, spawnPosHumanoid.y, spawnPosHumanoid.z) -
		humanoidRootPart.Position).magnitude < 10 then
		HumanoidState.Speed = 0
		AutoFlags.DigBottonDown = false	
		wait(timeDelay)
		HumanoidState.Speed = HumanoidState.TmpSpeed
		SpeedBottonFunction()
		AutoFlags.DigBottonDown = true
		AutoDiging()
		if not HumanoidAction.Pause then
			GoToFieldAndSplinker()
		end
		wait(.05)
		return true
	end
	wait(.05)
	return false	
end

local function trackingFunction()

local function TrackingMonsters()
	local trackingMonsters_ = 0
	local trackingMonstersVicious_ = 0
	for _,v in pairs(game.workspace.NPCBees:GetChildren()) do
		if string.find(v.Name,"Windy") then
			trackingMonsters_ = 2
		end
	end
	for _,v in pairs(game.workspace.Monsters:GetChildren()) do
		if string.find(v.Name,"Windy") then
			trackingMonsters_ = 2
		end
		if string.find(v.Name,"Vici") then
			trackingMonstersVicious_ = 1
		end
		if string.find(v.Name,"Stick Bug") then
			AutoStickBug.TextColor3 = Color3.new(0.3, 1, 0.3)
		else
			AutoStickBug.TextColor3 = Color3.new(1, 1, 1)
		end
	end
	if trackingMonstersVicious_ == 0 then
		ViciousTPBotton.BackgroundColor3 = Color3.new(1, 1, 1)
		ViciousTPBotton.Transparency = 1
		AutoVicious.TextColor3 = Color3.new(1, 1, 1)
		TextView.TextColor3 = Color3.new(1, 1, 1)
	elseif trackingMonstersVicious_ == 1 then
		ViciousTPBotton.BackgroundColor3 = Color3.new(1, 0.3, 0.3)
		ViciousTPBotton.Transparency = 0.5
		AutoVicious.TextColor3 = Color3.new(1, 0.3, 0.3)
		TextView.TextColor3 = Color3.new(1, 0.3, 0.3)
	end
	if trackingMonsters_ == 0 then
		WindyTPBotton.BackgroundColor3 = Color3.new(1, 1, 1)
		WindyTPBotton.Transparency = 1
		AutoWindy.TextColor3 = Color3.new(1, 1, 1)
	elseif trackingMonsters_ == 2 then
		WindyTPBotton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
		WindyTPBotton.Transparency = 0.5
		AutoWindy.TextColor3 = Color3.new(0.3, 0.3, 0.3)
		TextView.TextColor3 = Color3.new(0.3, 0.3, 0.3)
	end
end

local function SearchMushroomCFrame(mushroom)
for _, k in pairs(mushroom:GetDescendants()) do
	if k:IsA("BasePart") then
		ActionFlags.MushroomCFrame = k.CFrame
		break
	end
end
end

local function SearchMushroomMaxCFrame(mushroom)
for _, k in pairs(mushroom:GetDescendants()) do
	if k:IsA("BasePart") then
		if ActionFlags.MushroomCFrame.Y <
			k.CFrame.Y then
			ActionFlags.MushroomCFrame = k.CFrame
			break
		end
	end
end
end

local function MushroomDetect()
local detectClassMushroom_ = 0
local detectMaxClassMushroom_ = 0
local detectLvlMushroom_ = 0
local detectMaxLvlMushroom_ = 0
for _,v in pairs(game.workspace.Happenings.Puffshrooms:GetChildren()) do
	if string.find(v.Name,"PuffballMushroom") then
		local descendants_ = v:GetDescendants()
		for _, descendant in pairs(descendants_) do
			if descendant.Name == "TextLabel" then
				if string.find(descendant.Text, "Rare") then
					detectClassMushroom_ = 2
				elseif string.find(descendant.Text, "Epic") then
					detectClassMushroom_ = 3
				elseif string.find(descendant.Text, "Legendary") then
					detectClassMushroom_ = 4
				elseif string.find(descendant.Text, "Mythic") then
					detectClassMushroom_ = 5
				else
					detectClassMushroom_ = 1
				end
				if detectMaxClassMushroom_ < detectClassMushroom_ then
					detectMaxClassMushroom_ = detectClassMushroom_
					detectMaxLvlMushroom_ = tonumber(string.match(descendant.Text, "%d+"))
					SearchMushroomCFrame(v)
				elseif detectMaxClassMushroom_ == detectClassMushroom_ then
					detectLvlMushroom_ = tonumber(string.match(descendant.Text, "%d+"))
					if detectMaxLvlMushroom_ < detectLvlMushroom_ then
						detectMaxLvlMushroom_ = detectLvlMushroom_
						SearchMushroomCFrame(v)
					elseif detectMaxLvlMushroom_ == detectLvlMushroom_ then
						SearchMushroomMaxCFrame(v)
					end
				end
				ActionFlags.MushroomClass = detectMaxClassMushroom_
				ActionFlags.MushroomLvl = detectMaxLvlMushroom_
			end
		end
	end
end
if detectMaxClassMushroom_ == 0 then
	MushroomPoint.BackgroundColor3 = GuiColor.Base_
	if not AutoFlags.MushroomsBottonDown then
		AutoMushrooms.BackgroundColor3 = GuiColor.Base_ end
elseif detectMaxClassMushroom_ == 1 then
	MushroomPoint.BackgroundColor3 = Color3.new(0.5, 0.25, 0.25)
	if not AutoFlags.MushroomsBottonDown then
		AutoMushrooms.BackgroundColor3 = Color3.new(0.5, 0.25, 0.25) end
elseif detectMaxClassMushroom_ == 2 then
	MushroomPoint.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
	if not AutoFlags.MushroomsBottonDown then
		AutoMushrooms.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75) end
elseif detectMaxClassMushroom_ == 3 then
	MushroomPoint.BackgroundColor3 = Color3.new(1, 1, 0)
	if not AutoFlags.MushroomsBottonDown then
		AutoMushrooms.BackgroundColor3 = Color3.new(1, 1, 0) end
elseif detectMaxClassMushroom_ == 4 then
	MushroomPoint.BackgroundColor3 = Color3.new(0, 1, 1)
	if not AutoFlags.MushroomsBottonDown then
		AutoMushrooms.BackgroundColor3 = Color3.new(0, 1, 1) end
elseif detectMaxClassMushroom_ == 5 then
	MushroomPoint.BackgroundColor3 = Color3.new(0.5, 0, 1)
	if not AutoFlags.MushroomsBottonDown then
		AutoMushrooms.BackgroundColor3 = Color3.new(0.5, 0, 1) end
end
if detectMaxLvlMushroom_ > 0 then
	MushroomPoint.Text = tostring(detectMaxLvlMushroom_)
	MushroomPoint.Transparency = 0.5
	AutoMushrooms.Text = "AMush "..tostring(detectMaxLvlMushroom_)
else
	MushroomPoint.Text = "0"
	MushroomPoint.Transparency = 1
	AutoMushrooms.Text = "AMush"
end
end

	while HumanoidAction.AllStarting do
		TrackingMonsters()
		wait(.01)
		MushroomDetect()
		wait(.3)
	end
end
coroutine.wrap(trackingFunction)()

local function autoDigRebut()
	while HumanoidAction.AllStarting do
		if AutoFlags.DigBottonDown then
			AutoFlags.DigBottonDown = false
			wait(.5)
			AutoFlags.DigBottonDown = true
			wait(.2)
			AutoDiging()
		end
		wait(600)
	end
end
coroutine.wrap(autoDigRebut)()

local function humanoidReboot()
	while HumanoidAction.AllStarting do
		humanoidRootPart = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
		humanoid = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid")
		wait(10)
	end
end
coroutine.wrap(humanoidReboot)()

local FarmKillFunction = coroutine.wrap(function()

local function Collect_Dist40ToPos10sec(position)
	TimeLutCollection()
	local positionPoint_ = position
	wait(.2)
	for count = 1, 1000 do
		for _,v in pairs(workspace.Collectibles:GetChildren()) do
		if (v.Position - positionPoint_).magnitude <= 40 then
		if ((v.Position.y > humanoidRootPart.Position.y - 5) and (v.Position.y < humanoidRootPart.Position.y + 15)) then
		if AutoFlags.MushroomsBottonDown then
			if lutCollection then
				humanoid:MoveTo(Vector3.new(v.Position.x, humanoidRootPart.Position.y, v.Position.z), nil)
				wait(.25)
			else
				return
			end
		else
			break
		end
		end
		end
		end
		wait(.03)
	end
end

local function AddWahhh(mushroom_)
	for _, descendant in pairs(mushroom_:GetDescendants()) do
		if descendant.Name == "TextLabel" then
			descendant.Text = descendant.Text.."     Wahhh"
			return
		end
	end
end

local function SubWahhh(mushroom_)
	for _, descendant in pairs(mushroom_:GetDescendants()) do
		if descendant.Name == "TextLabel" then
			descendant.Text = string.gsub(descendant.Text, "     Wahhh", "")
			return true
		end
	end
	return false
end

local function SearchWahhh()
if ActionFlags.MushroomLvl > 0 then
	for _,v in pairs(game.workspace.Happenings.Puffshrooms:GetChildren()) do
		if string.find(v.Name,"PuffballMushroom") then
			for _, descendant in pairs(v:GetDescendants()) do
				if descendant.Name == "TextLabel" then
				if string.find(descendant.Text, "     Wahhh") then
					if (ActionFlags.MushroomClass == 1) or
						(ActionFlags.MushroomClass == 2 and string.find(descendant.Text, "Rare")) or
						(ActionFlags.MushroomClass == 3 and string.find(descendant.Text, "Epic")) or
						(ActionFlags.MushroomClass == 4 and string.find(descendant.Text, "Legendary")) or
						(ActionFlags.MushroomClass == 5 and string.find(descendant.Text, "Mythic")) then
						if (ActionFlags.MushroomLvl - 3) < tonumber(string.match(descendant.Text, "%d+")) then
							return true
						end
					end
				end
				end
			end
		end
	end
	return false
end
end

local function AutoFarmMushrooms()
RemoteQuest()
while HumanoidAction.Pause or HumanoidAction.CapacityUnloading do
	wait(4)
end
HumanoidAction.Pause = true
local positionMushroom_ = Vector3.new(999, 999, 999)
while AutoFlags.MushroomsBottonDown and MushroomPoint.Transparency == 0.5 do
	local mushroom_ = MushroomSearch()
	timeLutCollection = 3 + ActionFlags.MushroomLvl / 3 + ActionFlags.MushroomClass * 2
	if mushroom_ == nil then break end
	AddWahhh(mushroom_)
	
	for _, descendant in pairs(mushroom_:GetDescendants()) do
		if descendant:IsA("BasePart") then
			if (positionMushroom_ - descendant.Position).magnitude > 10 then
				positionMushroom_ = descendant.Position
				humanoidRootPart.CFrame = descendant.CFrame
				SplinkerInstalling()
				MaskEquiping(positionMushroom_)
			else
				positionMushroom_ = descendant.Position
				humanoidRootPart.CFrame = descendant.CFrame
				wait(.2)
			end
			
			repeat
			for count = 1, 20 do
				if not AutoFlags.MushroomsBottonDown then HumanoidAction.Pause = false return end
				humanoid:MoveTo(Vector3.new(positionMushroom_.x + math.random(-20, 20),
					humanoidRootPart.Position.y, positionMushroom_.z + math.random(-20, 20)), nil)
				if (positionMushroom_.y - humanoidRootPart.Position.y) > 7 or
					(positionMushroom_ - humanoidRootPart.Position).magnitude > 40 then 
					humanoidRootPart.CFrame = CFrame.new(positionMushroom_)
				end
				checkKilled(5)
				BackpackUnloadingMushroom(positionMushroom_)
			end
			until not SearchWahhh()
			
			if not SubWahhh(mushroom_) then
				wait(.05)
				Collect_Dist40ToPos10sec(positionMushroom_)
			end
			break
		end
	end
end
GoToFieldAndSplinker()
MaskEquiping()
HumanoidAction.Pause = false
end

local function AutoKillVicious()
if ViciousTPBotton.BackgroundColor3 == Color3.new(1, 0.3, 0.3) then
	while HumanoidAction.Pause or HumanoidAction.CapacityUnloading do
		wait(5)
	end
	HumanoidAction.Pause = true
	wait()
	for _,v in pairs(game.workspace.Monsters:GetChildren()) do
	if string.find(v.Name,"Vici") or string.find(v.Name,"Gifted") then
		humanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
		wait(.3)
		while true do
			local human = v:FindFirstChildOfClass("Humanoid")
			if human then
				humanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.CFrame.X,
					v.HumanoidRootPart.CFrame.Y + 20,
					v.HumanoidRootPart.CFrame.Z)
				wait(.01)
				if not AutoFlags.ViciousBottonDown then break end
			else
				break
			end
		end
		break
	end
	end
	wait(0.2)
	GoToFieldOrSpawn()
	HumanoidAction.Pause = false
end
end

local function AutoKillWindy()
if WindyTPBotton.BackgroundColor3 == Color3.new(0.3, 0.3, 0.3) then
	while HumanoidAction.Pause or HumanoidAction.CapacityUnloading do
		wait(4)
	end
	HumanoidAction.Pause = true
	wait(.1)
	for _,v in pairs(game.workspace.NPCBees:GetChildren()) do
		if string.find(v.Name,"Windy") then
			humanoidRootPart.CFrame = v.CFrame * CFrame.new(0,5,0)
		end
	end
	wait(.3)
	for _,r in pairs(game.workspace.Monsters:GetChildren()) do
	if string.find(r.Name,"Windy") then
		humanoidRootPart.CFrame = r.HumanoidRootPart.CFrame * CFrame.new(0,30,0)
		while true do
			local human = r:FindFirstChildOfClass("Humanoid")
			if human then
				humanoidRootPart.CFrame = CFrame.new(r.HumanoidRootPart.CFrame.X,
					r.HumanoidRootPart.CFrame.Y + 30,
					r.HumanoidRootPart.CFrame.Z)
				wait(.01)
				if not AutoFlags.WindyBottonDown then break end
			else
				break
			end

			if humanoid.Health > 40 then
			for _,v in pairs(workspace.Collectibles:GetChildren()) do
			if (v.Position - humanoidRootPart.Position).magnitude < 150 then
				local descendants_ = v:GetDescendants()
				for index, descendant in pairs(descendants_) do
					if descendant.Name == "FrontDecal" then
						if tostring(descendant.Texture) == "rbxassetid://1629547638" then
							humanoidRootPart.CFrame = CFrame.new(descendant.Parent.Position)
							wait(.15)
						end
					end
				end
			end
			end
			end
		end
		wait()
	end
	end
	wait(0.2)
	GoToFieldOrSpawn()
	HumanoidAction.Pause = false
end
	for _,v in pairs(workspace.Collectibles:GetChildren()) do
	if (v.Position - humanoidRootPart.Position).magnitude <= 30 then
	if ((v.Position.y > humanoidRootPart.Position.y - 5) and (v.Position.y < humanoidRootPart.Position.y + 15)) then
	if AutoFlags.MobsBottonDown then
		humanoid:MoveTo(Vector3.new(v.Position.x, humanoidRootPart.Position.y, v.Position.z), nil)
		wait(.2)
	else
		break
	end
	end
	end
	end
end

local function AutoKillStickBug()
if AutoStickBug.TextColor3 == Color3.new(0.3, 1, 0.3) then
	while HumanoidAction.Pause or HumanoidAction.CapacityUnloading do
		wait(4)
	end
	HumanoidAction.Pause = true
	workspace.Gravity = 80
	wait(.1)
	for _,r in pairs(game.workspace.Monsters:GetChildren()) do
		if string.find(r.Name,"Stick Bug") then
			while true do
				local human = r:FindFirstChildOfClass("Humanoid")
				if human then
					humanoidRootPart.CFrame = CFrame.new(r.HumanoidRootPart.CFrame.X,
						r.HumanoidRootPart.CFrame.Y + 40,
						r.HumanoidRootPart.CFrame.Z + 20)
					wait(.01)
					if not AutoFlags.StickBugBottonDown then break end
				else
					break
				end
			end
			break
		end
	end
	wait(0.1)
	workspace.Gravity = 170
	GoToFieldOrSpawn()
	HumanoidAction.Pause = false
end
end

local function AutoKillMondo()
	for _,v in pairs(game.workspace.Monsters:GetChildren()) do
		if string.find(v.Name,"Mondo") then
			while HumanoidAction.Pause or HumanoidAction.CapacityUnloading do
				wait(4)
			end
			HumanoidAction.Pause = true
			print("AutoKillMondo Start")
			game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer("Equip",
			{["Mute"] = true, ["Type"] = "Demon Mask", ["Category"] = "Accessory"})
			TPPepButton.BackgroundColor3 = Color3.new(1, 0.2, 0,06)
			local basePoint = CFrame.new(20,177,-165)
			humanoidRootPart.CFrame = basePoint
			wait(3)
			local safeDistanceToMondo = 40
			local relativePosition = 0
			while true do
				local human = v:FindFirstChildOfClass("Humanoid")
				if human and AutoFlags.MondoBottonDown then
					relativePosition = safeDistanceToMondo / ((v.HumanoidRootPart.CFrame.X-basePoint.X)^2+(v.HumanoidRootPart.CFrame.Z-basePoint.Z)^2)^0.5
					if relativePosition < 1 then
						humanoid:MoveTo(Vector3.new(v.HumanoidRootPart.CFrame.X+(basePoint.X-v.HumanoidRootPart.CFrame.X)*relativePosition,
							humanoidRootPart.Position.y, v.HumanoidRootPart.CFrame.Z+(basePoint.Z-v.HumanoidRootPart.CFrame.Z)*relativePosition))
					else
						humanoid:MoveTo(Vector3.new(basePoint.x, humanoidRootPart.Position.y, basePoint.z))
					end
					wait(.04)
					if checkKilled(30) then humanoidRootPart.CFrame = basePoint end
				else
					break
				end
				wait(.1)
			end
			print("AutoKillMondo Stop")
			wait(0.1)
			MaskEquiping()
			GoToFieldOrSpawn()
			HumanoidAction.Pause = false
			break
		end
	end
end

while HumanoidAction.AllStarting do
	while HumanoidAction.Pause or HumanoidAction.CapacityUnloading do
		wait(2)
	end
	wait(.1)
	if AutoFlags.MondoBottonDown then AutoKillMondo() end
	wait(.1)
	if AutoFlags.StickBugBottonDown then AutoKillStickBug() end
	wait(.1)
	if AutoFlags.MushroomsBottonDown and MushroomPoint.Transparency == 0.5 then
		AutoFarmMushrooms()
	end
	wait(.1)-
	if AutoFlags.WindyBottonDown then
		while WindyTPBotton.Transparency do
			if not AutoFlags.WindyBottonDown then break end
			AutoKillWindy()
			wait(.01)
		end
	end
	wait(.1)
	if AutoFlags.ViciousBottonDown then AutoKillVicious() end
	wait(2)
end
end)
FarmKillFunction()

local function FarmBottonDown()

local FiedlChecking = coroutine.wrap(function()
while HumanoidAction.Farm do
	wait(5)
	while HumanoidAction.Pause or HumanoidAction.CapacityUnloading do
		wait(1)
		if not HumanoidAction.Farm then return end
	end
	if not HumanoidAction.Farm then return end
	checkKilled(20)
	if (humanoidRootPart.Position.y - fieldPosition.y) < 1 then
		tpToField()
		wait(.1)
	end
	if (SizeField.min_X - 30) > humanoidRootPart.Position.x or humanoidRootPart.Position.x > (SizeField.max_X + 30) or
		(SizeField.min_Z - 30) > humanoidRootPart.Position.z or humanoidRootPart.Position.z > (SizeField.max_Z + 30) then
		tpToField()
		wait(.1)
	end
end
end)

local function UpdateChecking()
if tmpField_ ~= TextView.Text then
	humanoidRootPart = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
	humanoid = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid")
	fieldCFrame = CFrame.new(workspace.FlowerZones[TextView.Text].Position)
	fieldPosition = workspace.FlowerZones[TextView.Text].Position
	sizeField = workspace.FlowerZones[TextView.Text].Size
	SizeField.min_X = fieldPosition.x - (sizeField.x / 2) + SizeField.distanceToBoard
	SizeField.max_X = fieldPosition.x + (sizeField.x / 2) - SizeField.distanceToBoard
	SizeField.min_Z = fieldPosition.z - (sizeField.z / 2) + SizeField.distanceToBoard
	SizeField.max_Z = fieldPosition.z + (sizeField.z / 2) - SizeField.distanceToBoard
	tmpField_ = TextView.Text
end
end

local GoToToken = coroutine.wrap(function()
if not HumanoidAction.Pause then tpToField() end
wait(.5)
local tmpField_ = ""
FiedlChecking()
repeat
	while HumanoidAction.Pause or HumanoidAction.CapacityUnloading do
		wait(1)
		if not HumanoidAction.Farm then return end
	end
	humanoid:MoveTo(Vector3.new(fieldPosition.x, humanoidRootPart.Position.y, fieldPosition.z), nil)
	wait(.01)
	for k,v in pairs(workspace.Collectibles:GetChildren()) do
	if (v.Position.x > SizeField.min_X) and (v.Position.x < SizeField.max_X) and (v.Position.z > SizeField.min_Z) and (v.Position.z < SizeField.max_Z) then
	if ((v.Position.y > fieldPosition.y - 3) and (v.Position.y < fieldPosition.y + 5)) then
		if not HumanoidAction.Farm or HumanoidAction.Pause then break end	
		MoveToToken(Vector3.new(v.Position.x, humanoidRootPart.Position.y, v.Position.z))
		BackpackBalloonCheckingUnloading()		
	end
	end
	end
	for k,v in pairs(workspace.Particles:GetChildren()) do
	if string.find(v.Name,"Bubble") then
	if (v.Position.x > SizeField.min_X) and (v.Position.x < SizeField.max_X) and (v.Position.z > SizeField.min_Z) and (v.Position.z < SizeField.max_Z) then
	if ((v.Position.y > fieldPosition.y - 5) and (v.Position.y < fieldPosition.y + 5)) then
		if not HumanoidAction.Farm or HumanoidAction.Pause then break end
		MoveToToken(Vector3.new(v.Position.x, humanoidRootPart.Position.y, v.Position.z))
		BackpackBalloonCheckingUnloading()	
	end
	end
	end
	end
until HumanoidAction.Farm == false
tmpField_ = ""
end)

local GoToPoint = coroutine.wrap(function()
if not HumanoidAction.Pause then tpToField() end
wait(.5)
local tmpField_ = ""
FiedlChecking()
repeat
	while HumanoidAction.Pause or HumanoidAction.CapacityUnloading do
		wait(1)
		if not HumanoidAction.Farm then return end
	end
	humanoid:MoveTo(Vector3.new(fieldPosition.x, humanoidRootPart.Position.y, fieldPosition.z), nil)
	wait(.01)
	for i = 1, 2 do
	for k,v in pairs(workspace.Collectibles:GetChildren()) do
	if (v.Position.x > SizeField.min_X) and (v.Position.x < SizeField.max_X) and (v.Position.z > SizeField.min_Z) and (v.Position.z < SizeField.max_Z) then
	if ((v.Position.y > fieldPosition.y - 3) and (v.Position.y < fieldPosition.y + 5)) then
		if not HumanoidAction.Farm or HumanoidAction.Pause then break end	
		humanoid:MoveTo(Vector3.new(v.Position.x, humanoidRootPart.Position.y, v.Position.z), nil)
		wait(.25)
		BackpackBalloonCheckingUnloading()		
	end
	end
	end
	end
	for i = 1, 1 do
	for k,v in pairs(workspace.Particles:GetChildren()) do
	if string.find(v.Name,"Bubble") then
	if (v.Position.x > SizeField.min_X) and (v.Position.x < SizeField.max_X) and (v.Position.z > SizeField.min_Z) and (v.Position.z < SizeField.max_Z) then
	if ((v.Position.y > fieldPosition.y - 5) and (v.Position.y < fieldPosition.y + 5)) then
		if not HumanoidAction.Farm or HumanoidAction.Pause then break end
		humanoid:MoveTo(Vector3.new(v.Position.x, humanoidRootPart.Position.y, v.Position.z), nil)
		wait(.2)
		BackpackBalloonCheckingUnloading()
	end
	end
	end
	end
	end
until HumanoidAction.Farm == false
tmpField_ = ""
end)

	if HumanoidAction.FarmToSp then
		GoToPoint()
	else
		GoToToken()
	end
end

Start_Frame:TweenPosition(UDim2.new(1, -360, 0.09, 0),
		Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .5, true)

local function toggleKeyRXC(input, gameProcessed)
	if HumanoidAction.AllStarting then
		if input.KeyCode == Enum.KeyCode.R then
			if HumanoidAction.Farm then
				FarmBotton.BackgroundColor3 = GuiColor.Base_
				HumanoidAction.Farm = false
				FarmToBotton.BackgroundColor3 = GuiColor.Base_
				HumanoidAction.FarmToSp = false
			else
				FarmBotton.BackgroundColor3 = Color3.new(0, 1, 0)
				HumanoidAction.Farm = true
				FarmBottonDown()
			end
		end
		if input.KeyCode == Enum.KeyCode.X then
			if Dark_Frame.Transparency == 1 then
				Dark_Frame.Transparency = 0
				Start_Frame.Visible = false
				Dark_Frame.Size = UDim2.new(1, 0, 1.2, 0)
			else
				Dark_Frame.Transparency = 1
				Start_Frame.Visible = true
				Dark_Frame.Size = UDim2.new(0, 1, 0, 1)
			end
		end
		if input.KeyCode == Enum.KeyCode.F8 then
			Start_Frame.Visible = not Start_Frame.Visible
		end
		if input.KeyCode == Enum.KeyCode.C then
			MenubottonDown()
		end
	end
end
ConnectionKey.ConnectionRXC = game:GetService("UserInputService").InputEnded:Connect(toggleKeyRXC)

ConnectionKey.VirtualUserActive = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
	ConnectionKey.VirtualUserActive:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	ConnectionKey.VirtualUserActive:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)


spawn(function()

local DestroyButton = createButton({Size=UDim2.new(0, 25, 0, 25),Position=UDim2.new(0, 190, 0, 0),
	Text="X",Name="DestroyButton",Parent=Main_Frame,TextSize=18,BackgroundColor3=GuiColor.Red_})
local TPBotton = createButton({Size=UDim2.new(0, 43, 0, 20),Position=UDim2.new(0, 40, 0, 30),
	Text="Seg",Name="TPBotton",Parent=Main_Frame,TextSize = 14})
local DisableFoldingBotton = createButton({Size=UDim2.new(0, 10, 0, 20),Position=UDim2.new(0, 85, 0, 30),
	Text="",Name="DisableFoldingBotton",Parent=Main_Frame})
local FarmBotton = createButton({Size=UDim2.new(0, 38, 0, 20),Position=UDim2.new(0, 100, 0, 30),
	Text="Start",Name="FarmBotton",Parent=Main_Frame})
local FarmToBotton = createButton({Size=UDim2.new(0, 15, 0, 20),Position=UDim2.new(0, 140, 0, 30),
	Text="St",Name="FarmToBotton",Parent=Main_Frame,TextSize = 6})
local HomePoint = createButton({Size=UDim2.new(0, 25, 0, 20),Position=UDim2.new(0, 190, 0, 30),
	Text="(0)",Name="HomePoint",Parent=Main_Frame,TextSize = 14})

DestroyButton.MouseButton1Down:Connect(function()
AutoFlags.DigBottonDown = false
AutoFlags.MobsBottonDown = false
AutoFlags.ViciousBottonDown = false
AutoFlags.WindyBottonDown = false
AutoFlags.StickBugBottonDown = false
AutoFlags.MondoBottonDown = false
AutoFlags.DispenserBottonDown = false
AutoFlags.BoostBottonDown = false
AutoFlags.TornadoBottonDown = false
AutoFlags.MushroomsBottonDown = false
AutoFlags.ChristmasBottonDown = false
HumanoidState.Speed = 0
ActionFlags.BalloonBottonDown = false
ActionFlags.StateBalloonBotton = 0
SizeField.distanceToBoard = 5
HumanoidAction.Farm = false
HumanoidAction.Pause = false
ConnectionKey.ConnectionT:Disconnect()
ConnectionKey.ConnectionV:Disconnect()
ConnectionKey.ConnectionRXC:Disconnect()
HumanoidAction.AllStarting = false
wait(2)
HumanoidAction.AllStarting = nil
KonOvalGUI:Destroy()
wait(1)
return
end)

TPTopButton.MouseButton1Down:Connect(function()
	humanoidRootPart.CFrame = CFrame.new(-20, 232, -120)
end)

TPPepButton.MouseButton1Down:Connect(function()
	humanoidRootPart.CFrame = CFrame.new(-486, 124, 517)
end)

ViciousTPBotton.MouseButton1Down:Connect(function()
for _,v in pairs(game.workspace.Monsters:GetChildren()) do
	if string.find(v.Name,"Vici") or string.find(v.Name,"Gifted") then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
	end
end
end)

WindyTPBotton.MouseButton1Down:Connect(function()
	for _,r in pairs(game.workspace.Monsters:GetChildren()) do
		if string.find(r.Name,"Windy") then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = r.HumanoidRootPart.CFrame
		end
	end
	for _,v in pairs(game.workspace.NPCBees:GetChildren()) do
		if string.find(v.Name,"Windy") then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame 
		end
	end
end)

MushroomPoint.MouseButton1Down:Connect(function()
	GoToMushroom()
end)

MenuBotton.MouseButton1Down:Connect(function()
	MenubottonDown()
end)

TPBotton.MouseButton1Down:Connect(function()
	tpToField()
end)

DisableFoldingBotton.MouseButton1Down:Connect(function()
if not AutoFlags.DisableFoldingBotton then
	DisableFoldingBotton.BackgroundColor3 = Color3.new(0, 1, 1)
	AutoFlags.DisableFoldingBotton = true
else
	DisableFoldingBotton.BackgroundColor3 = GuiColor.Base_
	AutoFlags.DisableFoldingBotton = false
end
end)

FarmBotton.MouseButton1Down:Connect(function()
if not HumanoidAction.FarmToSp then
	if HumanoidAction.Farm then
		FarmBotton.BackgroundColor3 = GuiColor.Base_
		HumanoidAction.Farm = false
	else
		FarmBotton.BackgroundColor3 = Color3.new(0, 1, 0)
		HumanoidAction.Farm = true
		FarmBottonDown()
	end
end
end)

FarmToBotton.MouseButton1Down:Connect(function()
if not farmBottonDown then
	if HumanoidAction.FarmToSp then
		FarmToBotton.BackgroundColor3 = GuiColor.Base_
		HumanoidAction.FarmToSp = false
		HumanoidAction.Farm = false
	else
		FarmToBotton.BackgroundColor3 = Color3.new(0, 1, 1)
		HumanoidAction.FarmToSp = true
		HumanoidAction.Farm = true
		FarmBottonDown()
	end
end
end)

HomePoint.MouseButton1Down:Connect(function()
	GoToSpawnPosition()	
end)

end)

spawn(function()

local MenuSet = {Row=1;Column=1;Segment=1;GapX=5;GapY=5;SizeX=70;SizeY=20}
ButtonState.Forms(MenuSet,1,1,1)
local FieldBotton = createButton({Size=ButtonState.Size(MenuSet),Position=ButtonState.Position(MenuSet),
	Text="Field",Name="FieldBotton",Parent=Menu_Frame,TextSize = 14})
ButtonState.Forms(MenuSet,2,1,1)
local ActionsBotton = createButton({Size=ButtonState.Size(MenuSet),Position=ButtonState.Position(MenuSet),
	Text="Actions",Name="ActionsBotton",Parent=Menu_Frame,TextSize = 14})
ButtonState.Forms(MenuSet,3,1,1)
local SettingsBotton = createButton({Size=ButtonState.Size(MenuSet),Position=ButtonState.Position(MenuSet),
	Text="Settings",Name="SettingsBotton",Parent=Menu_Frame,TextSize = 14})

FieldBotton.MouseButton1Down:Connect(function()displayFrame(FieldBotton,Field_Frame)end)
ActionsBotton.MouseButton1Down:Connect(function()displayFrame(ActionsBotton,Actions_Frame)end)
SettingsBotton.MouseButton1Down:Connect(function()displayFrame(SettingsBotton,Settings_Frame)end)

local function toggleVisibleSettings_Frame(input, gameProcessed)
	if HumanoidAction.AllStarting and input.KeyCode == Enum.KeyCode.V then
		if not Settings_Frame.Visible then
			displayFrame(SettingsBotton,Settings_Frame)
			MenuBotton.BackgroundColor3 = GuiColor.On_Color_G
			Menu_Frame.Visible = true
		else
			if not Menu_Frame.Visible then
				MenuBotton.BackgroundColor3 = GuiColor.On_Color_G
				Menu_Frame.Visible = true
			else
				MenuBotton.BackgroundColor3 = GuiColor.Base_
				Menu_Frame.Visible = false
			end
		end
	end
end
ConnectionKey.ConnectionV = game:GetService("UserInputService").InputEnded:Connect(toggleVisibleSettings_Frame)

end)

spawn(function()

local FieldButtonSet = {Row=1;Column=1;Segment=1;GapX=4;GapY=4;SizeX=110;SizeY=16}
ButtonState.Forms(FieldButtonSet,1,1,1)
local SunflowerBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Sunflower Field",Name="SunflowerBotton",Parent=Field_Frame})
ButtonState.Forms(FieldButtonSet,2,1,1)
local DandelionBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Dandelion Field",Name="DandelionBotton",Parent=Field_Frame})
ButtonState.Forms(FieldButtonSet,3,1,1)
local MushroomBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Mushroom Field",Name="MushroomBotton",Parent=Field_Frame,TextColor3=GuiColor.Red_})
ButtonState.Forms(FieldButtonSet,4,1,1)
local BlueBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Blue Flower Field",Name="BlueBotton",Parent=Field_Frame,TextColor3=GuiColor.Blue_})
ButtonState.Forms(FieldButtonSet,5,1,1)
local CloverBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Clover Field",Name="CloverBotton",Parent=Field_Frame})
ButtonState.Forms(FieldButtonSet,6,1,2)
local SpiderBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Spider Field",Name="SpiderBotton",Parent=Field_Frame})
ButtonState.Forms(FieldButtonSet,7,1,2)
local StrawBerryBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Strawberry Field",Name="StrawBerryBotton",Parent=Field_Frame,TextColor3=GuiColor.Red_})
ButtonState.Forms(FieldButtonSet,8,1,2)
local BamBooBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Bamboo Field",Name="BamBooBotton",Parent=Field_Frame,TextColor3=GuiColor.Blue_})
ButtonState.Forms(FieldButtonSet,9,1,2)
local PineappleBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Pineapple Patch",Name="PineappleBotton",Parent=Field_Frame})
ButtonState.Forms(FieldButtonSet,10,1,2)
local StumpBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Stump Field",Name="StumpBotton",Parent=Field_Frame,TextColor3=GuiColor.Blue_})

ButtonState.Forms(FieldButtonSet,1,2,1)
local RoseBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Rose Field",Name="RoseBotton",Parent=Field_Frame,TextColor3=GuiColor.Red_})
ButtonState.Forms(FieldButtonSet,2,2,1)
local PineTreeBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Pine Tree Forest",Name="PineTreeBotton",Parent=Field_Frame,TextColor3=GuiColor.Blue_})
ButtonState.Forms(FieldButtonSet,3,2,1)
local CactusBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Cactus Field",Name="CactusBotton",Parent=Field_Frame})
ButtonState.Forms(FieldButtonSet,4,2,1)
local PumpkinBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Pumpkin Patch",Name="PumpkinBotton",Parent=Field_Frame})
ButtonState.Forms(FieldButtonSet,5,2,1)
local MountainTopBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Mountain Top Field",Name="MountainTopBotton",Parent=Field_Frame,TextSize = 11})
ButtonState.Forms(FieldButtonSet,6,2,2)
local CoconutBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Coconut Field",Name="CoconutBotton",Parent=Field_Frame})
ButtonState.Forms(FieldButtonSet,7,2,2)
local PepperBotton = createButton({Size=ButtonState.Size(FieldButtonSet),Position=ButtonState.Position(FieldButtonSet),
	Text="Pepper Patch",Name="PepperBotton",Parent=Field_Frame,TextColor3=GuiColor.Red_})

local function segToField(field)
	TextView.Text = field
	tpToField()
	setMaxMinSizeField(SizeField.distanceToBoard)
end

SunflowerBotton.MouseButton1Down:Connect(function()segToField("Sunflower Field")end)
DandelionBotton.MouseButton1Down:Connect(function()segToField("Dandelion Field")end)
MushroomBotton.MouseButton1Down:Connect(function()segToField("Mushroom Field")end)
BlueBotton.MouseButton1Down:Connect(function()segToField("Blue Flower Field")end)
CloverBotton.MouseButton1Down:Connect(function()segToField("Clover Field")end)
SpiderBotton.MouseButton1Down:Connect(function()segToField("Spider Field")end)
StrawBerryBotton.MouseButton1Down:Connect(function()segToField("Strawberry Field")end)
BamBooBotton.MouseButton1Down:Connect(function()segToField("Bamboo Field")end)
PineappleBotton.MouseButton1Down:Connect(function()segToField("Pineapple Patch")end)
StumpBotton.MouseButton1Down:Connect(function()segToField("Stump Field")end)
RoseBotton.MouseButton1Down:Connect(function()segToField("Rose Field")end)
PineTreeBotton.MouseButton1Down:Connect(function()segToField("Pine Tree Forest")end)
CactusBotton.MouseButton1Down:Connect(function()segToField("Cactus Field")end)
PumpkinBotton.MouseButton1Down:Connect(function()segToField("Pumpkin Patch")end)
MountainTopBotton.MouseButton1Down:Connect(function()segToField("Mountain Top Field")end)
CoconutBotton.MouseButton1Down:Connect(function()segToField("Coconut Field")end)
PepperBotton.MouseButton1Down:Connect(function()segToField("Pepper Patch")end)
end)

spawn(function()

local xyz = CFrame.new(0, 0, 0)
ButtonState.Forms(ButtonSet,1,1,1)
local TestXYZBotton = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Position XYZ",Name="TestXYZBotton",Parent=Actions_Frame})
ButtonState.Forms(ButtonSet,2,1,1)
local TextTestX = CreateObject.CreateInstance("TextBox",{Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Font = Enum.Font.GothamBold,TextColor3=GuiColor.Text_White_,TextSize = 12,
	MultiLine = true,TextWrapped = true,ClearTextOnFocus = false,TextEditable = false,
	BackgroundColor3=GuiColor.Base_,BackgroundTransparency = 0.8,BorderSizePixel=0,
	Text = "X",Name="TextTestX",Parent=Actions_Frame})
ButtonState.Forms(ButtonSet,3,1,1)
local TextTestY = CreateObject.CreateInstance("TextBox",{Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Font = Enum.Font.GothamBold,TextColor3=GuiColor.Text_White_,TextSize = 12,
	MultiLine = true,TextWrapped = true,ClearTextOnFocus = false,TextEditable = false,
	BackgroundColor3=GuiColor.Base_,BackgroundTransparency = 0.8,BorderSizePixel=0,
	Text = "Y",Name="TextTestY",Parent=Actions_Frame})
ButtonState.Forms(ButtonSet,4,1,1)
local TextTestZ = CreateObject.CreateInstance("TextBox",{Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Font = Enum.Font.GothamBold,TextColor3=GuiColor.Text_White_,TextSize = 12,
	MultiLine = true,TextWrapped = true,ClearTextOnFocus = false,TextEditable = false,
	BackgroundColor3=GuiColor.Base_,BackgroundTransparency = 0.8,BorderSizePixel=0,
	Text = "Z",Name="TextTestZ",Parent=Actions_Frame})
ButtonState.Forms(ButtonSet,5,1,1)
local TPToBotton = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Seg To",Name="TPToBotton",Parent=Actions_Frame})
ButtonState.Forms(ButtonSet,6,1,1)
local KeyText = CreateObject.CreateInstance("TextBox",{Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Font = Enum.Font.GothamBold,TextColor3=GuiColor.Text_White_,TextSize = 12,
	MultiLine = true,TextWrapped = false,ClearTextOnFocus = false,TextEditable = false,
	BackgroundColor3=GuiColor.Base_,BackgroundTransparency = 0.8,BorderSizePixel=0,
	Text = "F8, X, C, V, R.",Name="KeyText",Parent=Actions_Frame})

ButtonState.Forms(ButtonSet,1,2,1)
local FieldDecosDelBotton = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="DecosDel",Name="FieldDecosDelBotton",Parent=Actions_Frame})
ButtonState.Forms(ButtonSet,2,2,1)
local TPMenuLoadBotton = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="TPMenu",Name="TPMenuLoadBotton",Parent=Actions_Frame})
ButtonState.Forms(ButtonSet,3,2,1)
local ResetBotton = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Reset",Name="ResetBotton",Parent=Actions_Frame})
ButtonState.Forms(ButtonSet,4,2,1)
local FindBotton = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Find",Name="FindBotton",Parent=Actions_Frame})
ButtonState.Forms(ButtonSet,5,2,1)
local CDestroyBotton = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="CDestroy",Name="CDestroyBotton",Parent=Actions_Frame})

TestXYZBotton.MouseButton1Down:Connect(function()
	xyz = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart.CFrame
	TextTestX.Text = xyz.X
	TextTestY.Text = xyz.Y
	TextTestZ.Text = xyz.Z
end)

TPToBotton.MouseButton1Down:Connect(function()
	if	xyz.Y ~= 0 then
		humanoidRootPart.CFrame = xyz
	end
end)

FieldDecosDelBotton.MouseButton1Down:Connect(function()
if	FieldDecosDelBotton.AutoButtonColor then
	for _,v in pairs(workspace.FieldDecos:GetChildren()) do
		v:Destroy()
	end
	for _,v in pairs(workspace.Decorations.Misc:GetChildren()) do
		v:Destroy()
	end
	ButtonState.Off(FieldDecosDelBotton)
end
end)

CDestroyBotton.MouseButton1Down:Connect(function()
	for _,v in pairs(workspace.Collectibles:GetChildren()) do
		v:Destroy()
	end
end)

TPMenuLoadBotton.MouseButton1Down:Connect(function()
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/Status2024/LuaScripts/main/_BSS%20%E2%80%94%20Subsidiary.lua'),true))()
end)

ResetBotton.MouseButton1Down:Connect(function()
	humanoidRootPart = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
	humanoid = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid")
	HumanoidAction.Pause = false
	HumanoidAction.CapacityUnloading = false
end)

FindBotton.MouseButton1Down:Connect(function()
ButtonState.Off(FindBotton)
for _,v in pairs(workspace.Collectibles:GetChildren()) do
	for _, descendant in pairs(v:GetDescendants()) do
		if descendant.Name == "FrontDecal" then
			if descendant.Texture == "rbxassetid://8277780065" or
				descendant.Texture == "rbxassetid://8277778300 " or
				descendant.Texture == "rbxassetid://1674871631" or
				descendant.Texture == "rbxassetid://2504978518" or
				descendant.Texture == "rbxassetid://2542899798" or
				descendant.Texture == "rbxassetid://2584584968" or
				descendant.Texture == "rbxassetid://6087969886" or
				descendant.Texture == "rbxassetid://3036899811" or
				descendant.Texture == "rbxassetid://1838129169" or
				descendant.Texture == "rbxassetid://8277901755" or
				descendant.Texture == "rbxassetid://8054996680" or
				descendant.Texture == "rbxassetid://8055428094" or
				descendant.Texture == "rbxassetid://2319943273" or
				descendant.Texture == "rbxassetid://1471882621" or
				descendant.Texture == "rbxassetid://2060626811" or
				descendant.Texture == "rbxassetid://3012679515" or
				descendant.Texture == "rbxassetid://3080740120" or
				descendant.Texture == "rbxassetid://3030569073" or
				descendant.Texture == "rbxassetid://2863122826" or
				descendant.Texture == "rbxassetid://1471850677" or
				descendant.Texture == "rbxassetid://1471849394" then
				wait(.1)
				if descendant.Parent.Transparency == not nil then 
					if descendant.Parent.Transparency == 0 then
						humanoidRootPart.CFrame = descendant.Parent.CFrame
						wait(.5)
						return
					else
						descendant.Parent:Destroy()
					end
				end
			end
		end
	end
end
ButtonState.Activation(FindBotton)
end)

end)

spawn(function()
ButtonState.Forms(ButtonSet,1,1,1)
local AutoDig = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Auto Dig",Name="AutoDig",Parent=Settings_Frame})
ButtonState.Forms(ButtonSet,2,1,1)
local AutoDispenser = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Auto Dispenser",Name="AutoDispenser",Parent=Settings_Frame,TextSize = 10})
ButtonState.Forms(ButtonSet,3,1,1)
local SpeedBotton = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Speed: ",Name="SpeedBotton",Parent=Settings_Frame})
ButtonState.Forms(ButtonSet,4,1,1)
local BalloonBotton = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Balloon",Name="BalloonBotton",Parent=Settings_Frame})
ButtonState.Forms(ButtonSet,5,1,1)
local AutoChristmas = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Auto Christmas",Name="AutoChristmas",Parent=Settings_Frame,TextSize = 10,Visible = true})
ButtonState.Forms(ButtonSet,6,1,1)
local DistanceBotton = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Dist to board: ",Name="DistanceBotton",Parent=Settings_Frame,TextSize = 10})

ButtonState.Forms(ButtonSet,1,2,1)
local AutoBoost = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="ABoost",Name="AutoBoost",Parent=Settings_Frame,TextSize = 10})
ButtonState.Forms(ButtonSet,2,2,1)
local AutoMondo = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="AMondo",Name="AutoMondo",Parent=Settings_Frame})
ButtonState.Forms(ButtonSet,3,2,1)
local AutoMobs = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="AMobs",Name="AutoMobs",Parent=Settings_Frame,TextSize = 10})

ButtonState.Forms(ButtonSet,2,3,1)
local AutoTornado = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="ATornado",Name="AutoTornado",Parent=Settings_Frame,TextSize = 10})
ButtonState.Forms(ButtonSet,3,3,1)
local BalloonAndStart = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Balloon&Start",Name="BalloonAndStart",Parent=Settings_Frame,TextSize = 10})
ButtonState.Forms(ButtonSet,4,3,1)
local SnailTime = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="SnailTime",Name="SnailTime",Parent=Settings_Frame,TextSize = 10})

ButtonState.Forms(ButtonSet,6,3,2)
local DiamondMaskEquip = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Diamond Mask",Name="DiamondMaskEquip",Parent=Settings_Frame,TextSize = 10,--TextColor3=GuiColor.Text_Blue_,
	BackgroundColor3=GuiColor.Blue_})
ButtonState.Forms(ButtonSet,7,3,2)
local GummyMaskEquip = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Gummy Mask",Name="GummyMaskEquip",Parent=Settings_Frame,TextSize = 10,
	BackgroundColor3=GuiColor.Text_LBlack_})
ButtonState.Forms(ButtonSet,8,3,2)
local DemonMaskEquip = createButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
	Text="Demon Mask",Name="DemonMaskEquip",Parent=Settings_Frame,TextSize = 10,--TextColor3=GuiColor.Text_Red_,
	BackgroundColor3=GuiColor.Red_})

AutoDig.MouseButton1Down:Connect(function()
	if AutoFlags.DigBottonDown == false then
		AutoFlags.DigBottonDown = true
		AutoDig.BackgroundColor3 = Color3.new(0, 1, 0)
		AutoDiging()
	else
		AutoFlags.DigBottonDown = false
		AutoDig.BackgroundColor3 = GuiColor.Base_
	end
end)

AutoDispenser.MouseButton1Down:Connect(function()
	if AutoFlags.DispenserBottonDown == false then
		AutoFlags.DispenserBottonDown = true
		AutoDispenser.BackgroundColor3 = Color3.new(0, 1, 0)
		while AutoFlags.DispenserBottonDown do
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Glue Dispenser")
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Wealth Clock")
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Strawberry Dispenser")
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Blueberry Dispenser")
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Treat Dispenser")
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Free Ant Pass Dispenser")
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Honey Dispenser")
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Free Royal Jelly Dispenser")
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Gingerbread House")
			wait(30)
		end
	else
		AutoFlags.DispenserBottonDown = false
		AutoDispenser.BackgroundColor3 = GuiColor.Base_
	end
end)

SpeedBotton.MouseButton1Down:Connect(function()
	if HumanoidState.Speed == 0 then
		HumanoidState.Speed = 50
		SpeedBotton.Text = "Speed: 50"
		SpeedBotton.BackgroundColor3 = Color3.new(0, 1, 0)
		SpeedBottonFunction()
	elseif HumanoidState.Speed == 50 then		
		HumanoidState.Speed = 75
		SpeedBotton.Text = "Speed: 75"
		SpeedBotton.BackgroundColor3 = Color3.new(1, 1, 0)
	elseif HumanoidState.Speed == 75 then		
		HumanoidState.Speed = 98
		SpeedBotton.Text = "Speed: 98"
		SpeedBotton.BackgroundColor3 = Color3.new(1, 0, 0)
	elseif HumanoidState.Speed == 98 then			
		HumanoidState.Speed = 0
		SpeedBotton.Text = "Speed: "
		SpeedBotton.BackgroundColor3 = GuiColor.Base_
	end
	HumanoidState.TmpSpeed = HumanoidState.Speed
end)

BalloonBotton.MouseButton1Down:Connect(function()

local balloonTracking_ = coroutine.wrap(function()
if not ActionFlags.BalloonTrackingStarted_ then
	ActionFlags.BalloonTrackingStarted_ = true
	while ActionFlags.StateBalloonBotton == 1 do
		local tmpTimeBalloonBotton_ = math.floor(time() - ActionFlags.TimeAfterBalloonUnloading)
		if tmpTimeBalloonBotton_ >= 1500 then
			BackpackBalloonUnloading()
			wait(.05)
		end
		wait(10)
	end
	ActionFlags.BalloonTrackingStarted_ = false
end
end)

local balloonTracking = coroutine.wrap(function()
if not ActionFlags.BalloonTrackingStarted then
	ActionFlags.BalloonTrackingStarted = true
	print("Balloon tracking started")
	while ActionFlags.StateBalloonBotton == 2 do
		local tmpTimeBalloonBotton_ = math.floor(time() - ActionFlags.TimeAfterBalloonUnloading)
		if tmpTimeBalloonBotton_ <= 1800  then
			ActionFlags.BalloonBottonDown = false
		elseif tmpTimeBalloonBotton_ > 1800 and
			tmpTimeBalloonBotton_ < 2700 then
			ActionFlags.BalloonBottonDown = true
		elseif tmpTimeBalloonBotton_ >= 2700 then
			ActionFlags.BalloonBottonDown = true
			BackpackBalloonUnloading()
			wait(.05)
			ActionFlags.BalloonBottonDown = false
		end
		wait(10)
	end
	print("Balloon tracking stoped")
	ActionFlags.BalloonTrackingStarted = false
end
end)

	if ActionFlags.StateBalloonBotton == 0 then
		ActionFlags.BalloonBottonDown = true
		BalloonBotton.BackgroundColor3 = Color3.new(0, 1, 0)
		ActionFlags.StateBalloonBotton = 1	
		TimeAfterBalloonUnloading()
		balloonTracking_()
	elseif ActionFlags.StateBalloonBotton == 1 then
		ActionFlags.BalloonBottonDown = false
		BalloonBotton.Text = "Balloon:30-45"
		BalloonBotton.TextSize = 10
		BalloonBotton.BackgroundColor3 = Color3.new(1, 1, 0)
		ActionFlags.StateBalloonBotton = 2
		TimeAfterBalloonUnloading()
		balloonTracking()
	elseif ActionFlags.StateBalloonBotton == 2 then
		ActionFlags.BalloonBottonDown = false
		BalloonBotton.BackgroundColor3 = GuiColor.Base_
		BalloonBotton.Text = "Balloon"
		BalloonBotton.TextSize = 12
		ActionFlags.StateBalloonBotton = 0
	end
end)

DistanceBotton.MouseButton1Down:Connect(function()
	if SizeField.distanceToBoard == 5 then
		SizeField.distanceToBoard = 30
		DistanceBotton.Text = "Dist to board: 30"
		DistanceBotton.BackgroundColor3 = Color3.new(0, 1, 0)
	else			
		SizeField.distanceToBoard = 5
		DistanceBotton.Text = "Dista to board: "
		DistanceBotton.BackgroundColor3 = GuiColor.Base_
	end
	setMaxMinSizeField(SizeField.distanceToBoard)
end)

AutoBoost.MouseButton1Down:Connect(function()
	if AutoFlags.BoostBottonDown == false then
		AutoFlags.BoostBottonDown = true
		AutoBoost.BackgroundColor3 = Color3.new(0, 1, 0)
		while AutoFlags.BoostBottonDown do	
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Red Field Booster")
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Blue Field Booster")
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Field Booster")
			game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Coconut Dispenser")
			wait(120)
		end
	else
		AutoFlags.BoostBottonDown = false
		AutoBoost.BackgroundColor3 = GuiColor.Base_
	end
end)

AutoMobs.MouseButton1Down:Connect(function()
	if not AutoFlags.MobsBottonDown then
		AutoFlags.MobsBottonDown = true
		AutoMobs.BackgroundColor3 = Color3.new(0, 1, 0)
		AutoMobsKillFunction()
	else
		AutoFlags.MobsBottonDown = false
		AutoMobs.BackgroundColor3 = GuiColor.Base_
	end
end)

AutoVicious.MouseButton1Down:Connect(function()
	if not AutoFlags.ViciousBottonDown then
		AutoFlags.ViciousBottonDown = true
		AutoVicious.BackgroundColor3 = Color3.new(0, 1, 0)
	else
		AutoFlags.ViciousBottonDown = false
		AutoVicious.BackgroundColor3 = GuiColor.Base_
	end
end)

AutoWindy.MouseButton1Down:Connect(function()
	if not AutoFlags.WindyBottonDown then
		AutoFlags.WindyBottonDown = true
		AutoWindy.BackgroundColor3 = Color3.new(0, 1, 0)
	else
		AutoFlags.WindyBottonDown = false
		AutoWindy.BackgroundColor3 = GuiColor.Base_
	end
end)

AutoStickBug.MouseButton1Down:Connect(function()
	if not AutoFlags.StickBugBottonDown then
		AutoFlags.StickBugBottonDown = true
		AutoStickBug.BackgroundColor3 = Color3.new(0, 1, 0)
	else
		AutoFlags.StickBugBottonDown = false
		AutoStickBug.BackgroundColor3 = GuiColor.Base_
	end
end)

AutoMondo.MouseButton1Down:Connect(function()
	if not AutoFlags.MondoBottonDown then
		AutoFlags.MondoBottonDown = true
		AutoMondo.BackgroundColor3 = Color3.new(0, 1, 0)
	else
		AutoFlags.MondoBottonDown = false
		AutoMondo.BackgroundColor3 = GuiColor.Base_
	end
end)

AutoTornado.MouseButton1Down:Connect(function()
local TornadoControl = coroutine.wrap(function()
	local tweenservice_ = game:GetService("TweenService")
	local item_ = {}
	while AutoFlags.TornadoBottonDown do
		while HumanoidAction.Pause or HumanoidAction.CapacityUnloading or not HumanoidAction.Farm do
			wait(1)
		end
		for _,tornado_ in pairs(game.workspace.Particles:GetDescendants()) do
			if tornado_.Name == "Root" or tornado_.Name == "Plane" then
				if SizeField.min_X < tornado_.Position.x and tornado_.Position.x < SizeField.max_X
					and SizeField.min_Z < tornado_.Position.z and tornado_.Position.z < SizeField.max_Z then
					if (v.Position.x > SizeField.min_X) and (v.Position.x < SizeField.max_X) and (v.Position.z > SizeField.min_Z) and (v.Position.z < SizeField.max_Z) then
					if ((v.Position.y > fieldPosition.y - 3) and (v.Position.y < fieldPosition.y + 5)) then
						if not AutoFlags.TornadoBottonDown then return end
						item_.CFrame = CFrame.new(v.Position.x, tornado_.Position.y, v.Position.z)
						local Tween = tweenservice_:Create(tornado_, info_, item_)
						Tween:Play()
						wait(.1)
					end
					end
					end
				end
			end
		end
		wait(.2)
	end
end)

if AutoFlags.TornadoBottonDown == false then
	AutoFlags.TornadoBottonDown = true
	AutoTornado.BackgroundColor3 = Color3.new(0, 1, 0)
	TornadoControl()
else
	AutoFlags.TornadoBottonDown = false
	AutoTornado.BackgroundColor3 = GuiColor.Base_
end
end)

AutoMushrooms.MouseButton1Down:Connect(function()
	if AutoFlags.MushroomsBottonDown == false then
		AutoFlags.MushroomsBottonDown = true
		AutoMushrooms.BackgroundColor3 = Color3.new(0, 1, 0)
	else
		AutoFlags.MushroomsBottonDown = false
		AutoMushrooms.BackgroundColor3 = GuiColor.Base_
	end
end)

DiamondMaskEquip.MouseButton1Down:Connect(function()
	game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer("Equip",
		{["Mute"] = true, ["Type"] = "Diamond Mask", ["Category"] = "Accessory"})
	TPTopButton.BackgroundColor3 = Color3.new(0.32, 0.4, 1)
	TPPepButton.BackgroundColor3 = Color3.new(0.32, 0.4, 1)
	HumanoidState.MaskEquipped = 2
end)

GummyMaskEquip.MouseButton1Down:Connect(function()
	game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer("Equip",
		{["Mute"] = true, ["Type"] = "Gummy Mask", ["Category"] = "Accessory"})
	TPTopButton.BackgroundColor3 = Color3.new(1, 1, 1)
	TPPepButton.BackgroundColor3 = Color3.new(1, 1, 1)
	HumanoidState.MaskEquipped = 1
end)

DemonMaskEquip.MouseButton1Down:Connect(function()
	game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer("Equip",
		{["Mute"] = true, ["Type"] = "Demon Mask", ["Category"] = "Accessory"})
	TPTopButton.BackgroundColor3 = Color3.new(1, 0.2, 0,06)
	TPPepButton.BackgroundColor3 = Color3.new(1, 0.2, 0,06)
	HumanoidState.MaskEquipped = 3
end)

SnailTime.MouseButton1Down:Connect(function()

local function snailTimeDecrease()
	print("Snail Time Decrease Started")
	while ActionFlags.SnailTimeBottonDown >= 1 do
		ActionFlags.SnailTimeBottonDown = ActionFlags.SnailTimeBottonDown - 1	
		SnailTime.Text = "SnailTime "..ActionFlags.SnailTimeBottonDown
		for count = 1, 60 do
			if ActionFlags.SnailTimeBottonDown == 0 then break end
			wait(1)
		end
		for _,v in pairs(game.workspace.Monsters:GetChildren()) do
			if not string.find(v.Name,"Snail") and
				(humanoidRootPart.Position - fieldPosition).magnitude < 50 then
				ActionFlags.SnailTimeBottonDown = 0
			end			
		end
	end
	if ActionFlags.SnailTimeBottonDown < 0 then ActionFlags.SnailTimeBottonDown = 0 end
	SnailTime.Text = "SnailTime"
	SnailTime.BackgroundColor3 = GuiColor.Base_
	
	game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer("Equip",
		{["Mute"] = true, ["Type"] = "Diamond Mask", ["Category"] = "Accessory"})
	TPPepButton.BackgroundColor3 = Color3.new(0.32, 0.4, 1)
	DistanceBotton.BackgroundColor3 = GuiColor.Base_
	setMaxMinSizeField(5)
	print("Snail Time Decrease Stoped")
end

	if ActionFlags.SnailTimeBottonDown == 0 then
		ActionFlags.SnailTimeBottonDown = 30
		SnailTime.Text = "SnailTime "..ActionFlags.SnailTimeBottonDown
		SnailTime.BackgroundColor3 = Color3.new(0, 1, 0)
		
		game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer("Equip",
			{["Mute"] = true, ["Type"] = "Demon Mask", ["Category"] = "Accessory"})
		TPPepButton.BackgroundColor3 = Color3.new(1, 0.2, 0,06)
		DistanceBotton.BackgroundColor3 = Color3.new(0, 1, 0)
		setMaxMinSizeField(30)
		snailTimeDecrease()
	elseif ActionFlags.SnailTimeBottonDown <= 450 then
		ActionFlags.SnailTimeBottonDown = ActionFlags.SnailTimeBottonDown + 30
		SnailTime.Text = "SnailTime "..ActionFlags.SnailTimeBottonDown
	else
		ActionFlags.SnailTimeBottonDown = 0
	end
end)

BalloonAndStart.MouseButton1Down:Connect(function()
	BalloonAndStart.BackgroundColor3 = Color3.new(1, 1, 0)
	FarmBotton.BackgroundColor3 = Color3.new(1, 0, 0)
	HumanoidAction.Farm = true
	
	ActionFlags.BalloonBottonDown = true
	BackpackBalloonUnloading()
	wait(.5)
	if ActionFlags.StateBalloonBotton == 2 or ActionFlags.StateBalloonBotton == 0 then ActionFlags.BalloonBottonDown = false end
	
	FarmBotton.BackgroundColor3 = Color3.new(0, 1, 0)
	FarmBottonDown()
	BalloonAndStart.BackgroundColor3 = GuiColor.Base_
end)

AutoChristmas.MouseButton1Down:Connect(function()

local function Collect_Dist20()
	local humanoid = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid")
	for k,v in pairs(workspace.Collectibles:GetChildren()) do
	if tostring(v) == tostring(game.Players.LocalPlayer.Name) or tostring(v) == "C" then
	if (v.Position - humanoidRootPart.Position).magnitude <= 20 then
	if ((v.Position.y > humanoidRootPart.Position.y - 5) and (v.Position.y < humanoidRootPart.Position.y + 15)) then
	if AutoFlags.ChristmasBottonDown	then
		humanoid:MoveTo(Vector3.new(v.Position.x, humanoidRootPart.Position.y, v.Position.z), nil)
		wait(.5)
	else
		break
	end
	end
	end
	end
	end
end

local CollectionChristmas = coroutine.wrap(function()
while AutoFlags.ChristmasBottonDown do
	while HumanoidAction.Pause or HumanoidAction.CapacityUnloading do
		wait(10)
	end
	print("Collection Christmas STARTing")
	HumanoidAction.Pause = true
	wait(7)
	humanoidRootPart.CFrame = CFrame.new(-403.2, 48, 280.2)
	wait(1)
	game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Honeyday Candles")
	wait(7)
	humanoidRootPart.CFrame = CFrame.new(421, 132, -333)
	wait(1)
	game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Samovar")
	wait(9)
	for count = 1, 11 do wait(.3) Collect_Dist20() end
	if not AutoFlags.ChristmasBottonDown then HumanoidAction.Pause = false break end
	wait(1)
	humanoidRootPart.CFrame = CFrame.new(36, 236, -512)
	wait(1)
	game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Onett's Lid Art")
	wait(7)
	for count = 1, 3 do	Collect_Dist20()	end
	if not AutoFlags.ChristmasBottonDown then HumanoidAction.Pause = false break end	
	wait(1)
	humanoidRootPart.CFrame = CFrame.new(-105, 129, -114)
	wait(1)
	game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Beesmas Feast")
	wait(5)
	for count = 1, 3 do	Collect_Dist20()	end
	wait(1)
	if not AutoFlags.ChristmasBottonDown then HumanoidAction.Pause = false break end	
	if HumanoidAction.Farm == true then tpToField()
		else GoToSpawnPosition() end
	wait(5)
	HumanoidAction.Pause = false
	for ho = 1, 2 do
		for mi = 1, 60 do
			for delta = 1, 3 do
				wait(20)
				if not AutoFlags.ChristmasBottonDown then break end
			end
		end
		print("Collection Christmas 1 h")
	end	
end
	print("Collection Christmas STOPed")
end)

	if AutoFlags.ChristmasBottonDown == false then
		AutoFlags.ChristmasBottonDown = true
		AutoChristmas.BackgroundColor3 = Color3.new(0, 1, 0)
		CollectionChristmas()
	else
		AutoFlags.ChristmasBottonDown = false
		AutoChristmas.BackgroundColor3 = GuiColor.Base_
	end
end)

end)

Waypoints = { 
["Sunflower Field"] = CFrame.new(-208, 4, 185),
["Dandelion Field"] = CFrame.new(-30, 4, 225),
["Mushroom Field"] = CFrame.new(-94, 5, 116),
["Blue Flower Field"] = CFrame.new(113.7, 4, 101.5),
["Clover Field"] = CFrame.new(174, 34, 189),
["Spider Field"] = CFrame.new(-57.2, 20, -5.3),
["Strawberry Field"] = CFrame.new(-169.3, 20, -3.2),
["Bamboo Field"] = CFrame.new(93, 20, -25),
["Pineapple Patch"] = CFrame.new(262, 68, -201),
["Stump Field"] = CFrame.new(420,97,-178),
["Rose Field"] = CFrame.new(-322, 20, 124),
["Pine Tree Forest"] = CFrame.new(-318, 68, -195),
["Cactus Field"] = CFrame.new(-194, 68, -107),
["Pumpkin Patch"] = CFrame.new(-194, 68, -182),
["Mountain Top Field"] = CFrame.new(76, 176, -181),
["Coconut Field"] = CFrame.new(-255, 72, 459),
["Pepper Patch"] = CFrame.new(-486, 124, 517),
--["AntField"]
["Tool Shop"] = CFrame.new(86, 4.6, 294),
["Tool Shop 2"] = CFrame.new(165, 69, -161),
["MountainTop Shop"] = CFrame.new(-18, 176, -137),
["Mental Shop"] = CFrame.new(-497.8, 51.7, 469),
["Bee Shop"] = CFrame.new(-136.8, 4.6, 243.4),
["Treat Shop"] = CFrame.new(-233.3, 5.5, 89),
["Ticket Shop"] = CFrame.new(-12.8, 184, -222.2),
["RoyalJelly Shop"] = CFrame.new(-297, 53, 68),
["Ticket RoyalJelly Shop"] = CFrame.new(81, 18, 240),

["Honey Convertor 1"] = CFrame.new(-146.7, 4.6, 194.6),
["Honey Convertor 2"] = CFrame.new(140.4, 182.2, -217.2),
["Honey Convertor 3"] = CFrame.new(282.3, 68.5, -64.3),

["Diamond Mask"] = CFrame.new(-336,133,-387),
["Gummy Mask"] = CFrame.new(272,25268,-773),
["Demonm Mask"] = CFrame.new(291,28,271),

["Honeystorm Dispensor"] = CFrame.new(238.4, 33.3, 165.6),
["Blueberry Dispenser"] = CFrame.new(308.3, 4.8, 136.6),
["Strawberry Dispenser"] = CFrame.new(-320.5, 46, 272.5),
["Glue Dispenser"] = CFrame.new(271.7, 25257.2, -720.6),
["Sprout Dispenser"] = CFrame.new(-269.26, 26.56, 267.31),
["Gumdrop Dispenser"] = CFrame.new(66, 21.5, 26.4),
["Treat Dispenser"] = CFrame.new(193.9, 68, -123),
["Coconut Dispenser"] = CFrame.new(-176, 73.2, 534),

["Redfield Boost"] = CFrame.new(-318, 21, 242),
["Bluefield Boost"] = CFrame.new(272, 58.4, 85.4),
["MountainTop Boost"] = CFrame.new(-40, 176, -191.7),

["Night Match"] = CFrame.new(-17.2, 312.7, -270.1),
["Extreme Match"] = CFrame.new(-405,112,545),
["Mega Match"] = CFrame.new(-429, 69.8, -54),
["Memory Match"] = CFrame.new(135.9, 68.7, -96),

["King Beetle"] = CFrame.new(218, 3, 140),
["Tunnel Bear"] = CFrame.new(507.3, 5.7, -45.7),
["Snail"] = CFrame.new(420, 117,-178),
["Comandor"] = CFrame.new(520.7, 47, 162),

["Star Room"] = CFrame.new(135.9, 64.6, 322.1),
["Wealth Clock"] = CFrame.new(333, 48.7, 190),
["Blender"] = CFrame.new(-426,70,38),
["Moon"] = CFrame.new(21,88,-54),
["Ant"] = CFrame.new(93,34,502),

["Red Clubhouse"] = CFrame.new(-334, 21, 216),
["Blue Clubhouse"] = CFrame.new(292, 4, 98),
["Club Honey"] = CFrame.new(44.8, 5, 319.6),
["Onett"] = CFrame.new(-8.4, 234, -517.9),
["Planter Shop"] = CFrame.new(520.7, 138.2, -325.7),
["Top"] = CFrame.new(37.4, 429, -258),

["Polar Bear"] = CFrame.new(-109, 119.6, -78),
["Black Bear"] = CFrame.new(-255, 5.5, 295),
["Brown Bear"] = CFrame.new(280, 46.1, 238),
["Riley Bee"] = CFrame.new(-360, 73.8, 214),
["Bucko Bee"] = CFrame.new(304, 62, 105),
["Stick Bug"] = CFrame.new(-128,50,147),
["Windy Shrine"] = CFrame.new(-486,142,410),

["Home 1"] = CFrame.new(-185, 4.4, 331),
["Home 2"] = CFrame.new(-151.5, 4.4, 331),
["Home 3"] = CFrame.new(-118, 4.4, 331),
["Home 4"] = CFrame.new(-84.5, 4.4, 331),
["Home 5"] = CFrame.new(-51, 4.4, 331),
["Home 6"] = CFrame.new(-17.5, 4.4, 331),
}	

game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer("Equip",
{["Mute"] = true, ["Type"] = "Diamond Mask", ["Category"] = "Accessory"})
TPTopButton.BackgroundColor3 = Color3.new(0.32, 0.4, 1)
TPPepButton.BackgroundColor3 = Color3.new(0.32, 0.4, 1)
HumanoidState.MaskEquipped = 2
vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
	vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)