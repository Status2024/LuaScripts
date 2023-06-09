--[[for _,v in pairs(game.CoreGui:GetChildren()) do
	if	v.Name == "[SubsidiaryGUI]MainGUI" then
		print("----------- Closed "..v.Name.." -----------")
		v:Destroy()
	end
end]]

local GuiColor = {
	Base_	= Color3.new(0.184314,0.105882,0.4431373),
	Red_	= Color3.new(0.7,0.3,0.3),
	Green_	= Color3.new(0.3,0.7,0.3),
	Blue_	= Color3.new(0.3,0.3,0.7),
	
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

local ObjectsPositions = {
	StartFrame_Pos1 = UDim2.new(0, -50, 0.17, 0),
	StartFrame_Pos2 = UDim2.new(0, 0, 0.17, 0),
	MenuFrame_Pos1 = UDim2.new(0, -95, 0, 15),
	MenuFrame_Pos2 = UDim2.new(0, 5, 0, 15)}

local CreateObject = {}; do
	CreateInstance = function(class,properties)
		local instance_ = Instance.new(class)
		for i,v in pairs(properties) do
			instance_[i] = v
		end
		return instance_
	end
	
	CreateCorner = function(object,r)
		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, r)
		Corner.Parent = object
		return object
	end

	CreateButton = function(properties)
		local button_ = CreateInstance("TextButton",{BackgroundColor3=GuiColor.Base_,BackgroundTransparency=0.4,BorderSizePixel=3,
			AutoButtonColor=true,TextColor3=GuiColor.Text_White_,Font=Enum.Font.GothamBold,TextSize=11,TextTransparency=0,TextWrapped=false})
		for i,v in pairs(properties) do
			button_[i] = v
		end
		CreateCorner(button_,4)
		return button_
	end
	
	CreateTextLabel = function(properties)
		local textLabel_ = CreateInstance(
			"TextLabel",{BackgroundColor3=GuiColor.Base_,BackgroundTransparency=1,BorderSizePixel=0,
			TextColor3=GuiColor.Text_White_,Font=Enum.Font.GothamBold,TextSize=10,TextTransparency=0,TextWrapped=false})
		for i,v in pairs(properties) do
			textLabel_[i] = v
		end
		CreateCorner(textLabel_,4)
		return textLabel_
	end
end

local ButtonState = {}; do
	ButtonState.Forms = function(buTTon,row,column,segment)
		buTTon.Row = row
		buTTon.Column = column
		buTTon.Segment = segment
	end
	
	ButtonState.Position = function(buTTon)
		local X = buTTon.Column * buTTon.GapX + (buTTon.Column - 1) * buTTon.SizeX
		local Y = (buTTon.Row + buTTon.Segment - 1) * buTTon.GapY + (buTTon.Row - 1) * buTTon.SizeY
		return UDim2.new(0, X, 0, Y)
	end
	
	ButtonState.Size = function(buTTon)
		return UDim2.new(0, buTTon.SizeX, 0, buTTon.SizeY)
	end

	ButtonState.On = function(button)
		button.BackgroundColor3 = GuiColor.On_Color_G
		print(button.Name, "on")
	end

	ButtonState.Off = function(button)
		button.AutoButtonColor = false
		button.Active = false
		button.BackgroundColor3 = GuiColor.Text_LBlack_
		print(button.Name, "off")
	end

	ButtonState.OnOff = function(button)
		if	button.BackgroundColor3 == GuiColor.Base_ then
			ButtonState.On(button)
			return true
		else
			ButtonState.Off(button)
			return false
		end
	end
	
	ButtonState.Activation = function (button)
		button.AutoButtonColor = true
		button.Active = true
		button.BackgroundColor3 = GuiColor.Base_
		print(button.Name, "actived")
	end
	
	ButtonState.LaunchPeriod = function (button, second)
		for i = 1, math.floor(second) do
			if not button.AutoButtonColor or allStop then
				return false
			end
			wait(1)
		end
		return true
	end
end

local MenuButtonSet = {Row=1;Column=1;Segment=1;GapX=0;GapY=5;SizeX=25;SizeY=18}
local ButtonSet = {Row=1;Column=1;Segment=1;GapX=0;GapY=4;SizeX=90;SizeY=18}
local TimeSet = {Row=1;Column=1;Segment=1;GapX=10;GapY=4;SizeX=60;SizeY=18}

createGui = function()-----createGui-----
	local  subsidiaryMainGUI = CreateInstance("ScreenGui",{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,
		Name="[SubsidiaryGUI]MainGUI",})

	local startFrame = CreateInstance("Frame",{Active=true, Selectable=true, Draggable=true,
		BackgroundColor3=GuiColor.Text_LBlack_,Transparency=1,BorderSizePixel=0,
		Size=UDim2.new(0, 40, 0, 15),Position=ObjectsPositions.StartFrame_Pos1,Name="startFrame",Parent=subsidiaryMainGUI})
	local headingFrame = CreateInstance("Frame",{BackgroundColor3=GuiColor.Base_,Transparency=1,BorderSizePixel=1,
		Size=UDim2.new(0, 40, 0, 15),Position=UDim2.new(0, 0, 0, 0),Name="headingFrame",Parent=startFrame})
		CreateCorner(headingFrame,2)
	local hideMenuButton = CreateButton({Size=UDim2.new(0, 30, 0, 15),Position=UDim2.new(0, 0, 0, 0),
		Text=">>>",Name="hideMenuButton",Parent=headingFrame,TextSize=10})
	local spawnButton = CreateButton({Size=UDim2.new(0, 95, 0, 15),Position=UDim2.new(0, 35, 0, 0),
		Text="< 0 >",Name="spawnButton",Parent=headingFrame,TextSize=10,Visible=false})
	local menuFrame = CreateInstance("Frame",{BackgroundColor3=GuiColor.Base_,Transparency=1,BorderSizePixel=0,
		Size=UDim2.new(0, 1, 0, 1),Position=ObjectsPositions.MenuFrame_Pos1,Name="menuFrame",Parent=startFrame,Visible=false})
	local tp_1Frame = CreateInstance("Frame",{BackgroundColor3=GuiColor.Base_,Transparency=1,BorderSizePixel=0,
		Size=UDim2.new(0, 1, 0, 1),Position=UDim2.new(0, 0, 0, 0),Name="tp_1Frame",Parent=menuFrame,Visible=false})
	local tp_2Frame = CreateInstance("Frame",{BackgroundColor3=GuiColor.Base_,Transparency=1,BorderSizePixel=0,
		Size=UDim2.new(0, 1, 0, 1),Position=UDim2.new(0, 0, 0, 0),Name="tp_2Frame",Parent=menuFrame,Visible=false})
	local tp_3Frame = CreateInstance("Frame",{BackgroundColor3=GuiColor.Base_,Transparency=1,BorderSizePixel=0,
		Size=UDim2.new(0, 1, 0, 1),Position=UDim2.new(0, 0, 0, 0),Name="tp_3Frame",Parent=menuFrame,Visible=false})
	local bearFrame = CreateInstance("Frame",{BackgroundColor3=GuiColor.Base_,Transparency=1,BorderSizePixel=0,
		Size=UDim2.new(0, 1, 0, 1),Position=UDim2.new(0, 0, 0, 0),Name="bearFrame",Parent=menuFrame,Visible=false})
	local matchFrame = CreateInstance("Frame",{BackgroundColor3=GuiColor.Base_,Transparency=1,BorderSizePixel=0,
		Size=UDim2.new(0, 1, 0, 1),Position=UDim2.new(0, 0, 0, 0),Name="matchFrame",Parent=menuFrame,Visible=false})
	local useFrame = CreateInstance("Frame",{BackgroundColor3=GuiColor.Base_,Transparency=1,BorderSizePixel=0,
		Size=UDim2.new(0, 1, 0, 1),Position=UDim2.new(0, 0, 0, 0),Name="useFrame",Parent=menuFrame,Visible=false})
	local timeFrame = CreateInstance("Frame",{BackgroundColor3=GuiColor.Base_,Transparency=.6,BorderSizePixel=0,
		Size=UDim2.new(0, 80, 0, 145),Position=UDim2.new(0, 5, 0, 5),Name="timeFrame",Parent=menuFrame,Visible=false})
		CreateCorner(timeFrame,5)

	return subsidiaryMainGUI
end

local S_U_B_S_I_D_I_A_R_Y_Gui = createGui()
local startFrame = S_U_B_S_I_D_I_A_R_Y_Gui:WaitForChild("startFrame")
local headingFrame = startFrame:WaitForChild("headingFrame")
local hideMenuButton = headingFrame:WaitForChild("hideMenuButton")
local menuFrame = startFrame:WaitForChild("menuFrame")
local tp_1Frame = menuFrame:WaitForChild("tp_1Frame")
local tp_2Frame = menuFrame:WaitForChild("tp_2Frame")
local tp_3Frame = menuFrame:WaitForChild("tp_3Frame")
local bearFrame = menuFrame:WaitForChild("bearFrame")
local matchFrame = menuFrame:WaitForChild("matchFrame")
local useFrame = menuFrame:WaitForChild("useFrame")
local timeFrame = menuFrame:WaitForChild("timeFrame")

S_U_B_S_I_D_I_A_R_Y_Gui.Parent = game.CoreGui

spawn(function()
	humanoidRootPart = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
	allStop = false
	print("----------- Start "..S_U_B_S_I_D_I_A_R_Y_Gui.Name.." BEE SWARM -----------")
	startFrame:TweenPosition(ObjectsPositions.StartFrame_Pos2,
		Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .5, true)
	
	local function humanoidReboot()
		while not allStop do
			humanoidRootPart = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
			wait(120)
		end
	end
	coroutine.wrap(humanoidReboot)()
end)

spawn(function()-----menuFrame, headingFrame-----
	ButtonState.Forms(MenuButtonSet,1,5,1)
	local destroyButton = CreateButton({Size=ButtonState.Size(MenuButtonSet),Position=ButtonState.Position(MenuButtonSet),
		Text="X",Name="destroyButton",Parent=menuFrame,TextSize=16,BackgroundColor3=GuiColor.Red_})
	ButtonState.Forms(MenuButtonSet,2,5,1)
	local tpMenuButton = CreateButton({Size=ButtonState.Size(MenuButtonSet),Position=ButtonState.Position(MenuButtonSet),
		Text="SHOP",Name="tpMenuButton",Parent=menuFrame,TextSize=8})
	ButtonState.Forms(MenuButtonSet,3,5,1)
	local tpMenuButton2 = CreateButton({Size=ButtonState.Size(MenuButtonSet),Position=ButtonState.Position(MenuButtonSet),
		Text="DISP",Name="tpMenuButton2",Parent=menuFrame,TextSize=8})
	ButtonState.Forms(MenuButtonSet,4,5,1)
	local tpMenuButton3 = CreateButton({Size=ButtonState.Size(MenuButtonSet),Position=ButtonState.Position(MenuButtonSet),
		Text="DRIVE",Name="tpMenuButton3",Parent=menuFrame,TextSize=7})
	ButtonState.Forms(MenuButtonSet,5,5,1)
	local tpBearButton = CreateButton({Size=ButtonState.Size(MenuButtonSet),Position=ButtonState.Position(MenuButtonSet),
		Text="BEAR",Name="tpBearButton",Parent=menuFrame,TextSize=8})
	ButtonState.Forms(MenuButtonSet,6,5,1)
	local tpMatchButton = CreateButton({Size=ButtonState.Size(MenuButtonSet),Position=ButtonState.Position(MenuButtonSet),
		Text="MATCH",Name="tpMatchButton",Parent=menuFrame,TextSize=7})
	ButtonState.Forms(MenuButtonSet,7,5,1)
	local useMenuButton = CreateButton({Size=ButtonState.Size(MenuButtonSet),Position=ButtonState.Position(MenuButtonSet),
		Text="Use",Name="useMenuButton",Parent=menuFrame,TextSize=10})
	ButtonState.Forms(MenuButtonSet,8,5,1)
	local timeMenuButton = CreateButton({Size=ButtonState.Size(MenuButtonSet),Position=ButtonState.Position(MenuButtonSet),
		Text="Time",Name="timeMenuButton",Parent=menuFrame,TextSize=10})

	local spawnButton = headingFrame:WaitForChild("spawnButton")

	local function hideMenu()
		if hideMenuButton.Text == ">>>" then
			hideMenuButton.Text = "<<<"
			menuFrame.Visible = true
			spawnButton.Visible = true
			startFrame.Size=UDim2.new(0, 135, 0, 15)
			headingFrame.Size=UDim2.new(0, 135, 0, 15)
		else
			hideMenuButton.Text = ">>>"
			menuFrame.Visible = false
			spawnButton.Visible = false
			startFrame.Size=UDim2.new(0, 40, 0, 15)
			headingFrame.Size=UDim2.new(0, 40, 0, 15)
		end
	end

	hideMenuButton.MouseButton1Up:connect(function()hideMenu()end)

	spawnButton.MouseButton1Up:connect(function()
		humanoidRootPart = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
		humanoidRootPart.CFrame = game.Players.LocalPlayer.SpawnPos.Value
		wait(1)
		game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
	end)

	local function hideFrames()
		for _,k in pairs(menuFrame:GetChildren()) do
			if k:IsA("Frame") then
				k.Visible = false
			elseif k:IsA("TextButton") then
				k.BackgroundColor3 = GuiColor.Base_
			end
		end
	end

	local function displayFrame(button, frame)
		if frame.Visible then
			frame.Visible = false
			button.BackgroundColor3 = GuiColor.Base_
			menuFrame:TweenPosition(ObjectsPositions.MenuFrame_Pos1,
				Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .2, true)
		else
			hideFrames()
				destroyButton.BackgroundColor3=GuiColor.Red_
			frame.Visible = true
			button.BackgroundColor3 = GuiColor.On_Color_B
			menuFrame:TweenPosition(ObjectsPositions.MenuFrame_Pos2,
				Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .2, true)
		end
	end

	tpMenuButton.MouseButton1Up:Connect(function()displayFrame(tpMenuButton,tp_1Frame)end)
	tpMenuButton2.MouseButton1Up:Connect(function()displayFrame(tpMenuButton2,tp_2Frame)end)
	tpMenuButton3.MouseButton1Up:Connect(function()displayFrame(tpMenuButton3,tp_3Frame)end)
	tpBearButton.MouseButton1Up:Connect(function()displayFrame(tpBearButton,bearFrame)end)
	tpMatchButton.MouseButton1Up:Connect(function()displayFrame(tpMatchButton,matchFrame)end)
	useMenuButton.MouseButton1Up:Connect(function()displayFrame(useMenuButton,useFrame)end)
	timeMenuButton.MouseButton1Up:Connect(function()displayFrame(timeMenuButton,timeFrame)end)

	local function toggleFrameVisibility(input, gameProcessed)
		if not allStop and input.KeyCode == Enum.KeyCode.B then
			hideMenu()
		end
	end

	local connection = game:GetService("UserInputService").InputEnded:Connect(toggleFrameVisibility)

	destroyButton.MouseButton1Up:connect(function()
		allStop = true
		print("----------- Closed "..S_U_B_S_I_D_I_A_R_Y_Gui.Name.." BEE SWARM -----------")
		connection:Disconnect()
		S_U_B_S_I_D_I_A_R_Y_Gui:Destroy()
	end)
end)

spawn(function()-----tp_1Frame-----
	ButtonState.Forms(ButtonSet,1,1,1)
	local noobShopButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Noob Shop",Name="noobShopButton",Parent=tp_1Frame})
	ButtonState.Forms(ButtonSet,2,1,1)
	local proShopButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Pro Shop",Name="proShopButton",Parent=tp_1Frame})
	ButtonState.Forms(ButtonSet,3,1,1)
	local topShopButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Top Shop",Name="topShopButton",Parent=tp_1Frame})
	ButtonState.Forms(ButtonSet,4,1,1)
	local mentalShopButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Mental Shop",Name="mentalShopButton",Parent=tp_1Frame,TextColor3=GuiColor.Text_LWhite_})
	ButtonState.Forms(ButtonSet,5,1,1)
	local beeShopButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Bee Shop",Name="beeShopButton",Parent=tp_1Frame})
	ButtonState.Forms(ButtonSet,6,1,1)
	local treatShopButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Treat Shop",Name="treatShopButton",Parent=tp_1Frame})
	ButtonState.Forms(ButtonSet,7,1,1)
	local ticketShopButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Ticket Shop",Name="ticketShopButton",Parent=tp_1Frame})
	ButtonState.Forms(ButtonSet,8,1,1)
	local royalJellyShopButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="RoyalJelly Shop",Name="royalJellyShopButton",Parent=tp_1Frame})
	ButtonState.Forms(ButtonSet,9,1,1)
	local ticketRoyalJellyButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Ticket RoyalJelly",Name="ticketRoyalJellyButton",Parent=tp_1Frame})
	ButtonState.Forms(ButtonSet,10,1,1)
	local planterShopButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Planter Shop",Name="planterShopButton",Parent=tp_1Frame,TextColor3=GuiColor.Text_Green_})

	noobShopButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Tool Shop"] end)
	proShopButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Tool Shop 2"] end)
	topShopButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["MountainTop Shop"] end)
	mentalShopButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Mental Shop"] end)
	beeShopButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Bee Shop"] end)
	treatShopButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Treat Shop"] end)
	ticketShopButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Ticket Shop"] end)
	royalJellyShopButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["RoyalJelly Shop"] end)
	ticketRoyalJellyButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Ticket RoyalJelly Shop"] end)
	planterShopButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Planter Shop"] end)
end)

spawn(function()-----tp_2Frame-----
	ButtonState.Forms(ButtonSet,1,1,1)
	local honeyStormButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Honey Storm",Name="honeyStormButton",Parent=tp_2Frame})
	ButtonState.Forms(ButtonSet,2,1,1)
	local strawberryDispenserButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Strawberry Disp",Name="strawberryDispenserButton",Parent=tp_2Frame,TextColor3=GuiColor.Text_Red_})
	ButtonState.Forms(ButtonSet,3,1,1)
	local blueberryDispenserButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Blueberry Disp",Name="blueberryDispenserButton",Parent=tp_2Frame,TextColor3=GuiColor.Text_Blue_})
	ButtonState.Forms(ButtonSet,4,1,1)
	local glueDispenserButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Glue Dispenser",Name="glueDispenserButton",Parent=tp_2Frame,TextColor3=GuiColor.Text_LWhite_})
	ButtonState.Forms(ButtonSet,5,1,1)
	local sproutButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Sprout",Name="sproutButton",Parent=tp_2Frame,TextColor3=GuiColor.Text_Green_})
	ButtonState.Forms(ButtonSet,6,1,1)
	local gumdropDispenserButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Gumdrop Disp",Name="gumdropDispenserButton",Parent=tp_2Frame})
	ButtonState.Forms(ButtonSet,7,1,1)
	local treatDispenserButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Treat Dispenser",Name="treatDispenserButton",Parent=tp_2Frame})
	ButtonState.Forms(ButtonSet,8,1,1)
	local redClubhouseButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Red Clubhouse",Name="redClubhouseButton",Parent=tp_2Frame,TextColor3=GuiColor.Text_Red_})
	ButtonState.Forms(ButtonSet,9,1,1)
	local blueClubhouseButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Blue Clubhouse",Name="blueClubhouseButton",Parent=tp_2Frame,TextColor3=GuiColor.Text_Blue_})
	ButtonState.Forms(ButtonSet,10,1,1)
	local clubHoneyButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Club Honey",Name="clubHoneyButton",Parent=tp_2Frame})

	honeyStormButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Honeystorm Dispensor"] end)
	strawberryDispenserButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Strawberry Dispenser"] end)
	blueberryDispenserButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Blueberry Dispenser"] end)
	glueDispenserButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Glue Dispenser"] end)
	sproutButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Sprout Dispenser"] end)
	gumdropDispenserButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Gumdrop Dispenser"] end)
	treatDispenserButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Treat Dispenser"] end)
	redClubhouseButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Red Clubhouse"] end)
	blueClubhouseButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Blue Clubhouse"] end)
	clubHoneyButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Club Honey"] end)
end)

spawn(function()-----tp_3Frame-----
	ButtonState.Forms(ButtonSet,1,1,1)
	local starRoomButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Star Room",Name="starRoomButton",Parent=tp_3Frame})
	ButtonState.Forms(ButtonSet,2,1,1)
	local wealthClockButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Wealth Clock",Name="wealthClockButton",Parent=tp_3Frame})
	ButtonState.Forms(ButtonSet,3,1,1)
	local blenderButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Blender",Name="blenderButton",Parent=tp_3Frame,TextColor3=GuiColor.Text_Green_})
	ButtonState.Forms(ButtonSet,4,1,1)
	local moonButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Moon",Name="moonButton",Parent=tp_3Frame,TextColor3=GuiColor.Text_LWhite_})
	ButtonState.Forms(ButtonSet,5,1,1)
	local antButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Ant",Name="antButton",Parent=tp_3Frame})
	ButtonState.Forms(ButtonSet,6,1,1)
	local onettButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Onett",Name="onettButton",Parent=tp_3Frame})
	ButtonState.Forms(ButtonSet,7,1,1)
	local topTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text=" ",Name="topTPButton",Parent=tp_3Frame})
	ButtonState.Forms(ButtonSet,8,1,1)
	local gummyMaskButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Gummy Mask",Name="gummyMaskButton",Parent=tp_3Frame})
	ButtonState.Forms(ButtonSet,9,1,1)
	local demonmMaskButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Demonm Mask",Name="demonmMaskButton",Parent=tp_3Frame,TextColor3=GuiColor.Text_Red_})
	ButtonState.Forms(ButtonSet,10,1,1)
	local diamondMaskButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Diamond Mask",Name="diamondMaskButton",Parent=tp_3Frame,TextColor3=GuiColor.Text_Blue_})

	starRoomButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Star Room"] end)
	wealthClockButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Wealth Clock"] end)
	blenderButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Blender"] end)
	moonButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Moon"] end)
	antButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Ant"] end)
	onettButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Onett"] end)
	topTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Top"] end)
	gummyMaskButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Gummy Mask"] end)
	diamondMaskButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Diamond Mask"] end)
	demonmMaskButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Demonm Mask"] end)
end)

spawn(function()-----bearFrame-----
	ButtonState.Forms(ButtonSet,1,1,1)
	local polarBearTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Polar Bear",Name="polarBearTPButton",Parent=bearFrame})
	ButtonState.Forms(ButtonSet,2,1,1)
	local blackBearTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Black Bear",Name="blackBearTPButton",Parent=bearFrame,TextColor3=GuiColor.Text_LBlack_})
	ButtonState.Forms(ButtonSet,3,1,1)
	local brownBearTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Brown Bear",Name="brownBearTPButton",Parent=bearFrame,TextColor3=GuiColor.Text_Green_})
	ButtonState.Forms(ButtonSet,4,1,1)
	local rileyBeeTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Riley Bee",Name="rileyBeeTPButton",Parent=bearFrame,TextColor3=GuiColor.Text_Red_})
	ButtonState.Forms(ButtonSet,5,1,1)
	local buckoBeeTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Bucko Bee",Name="buckoBeeTPButton",Parent=bearFrame,TextColor3=GuiColor.Text_Blue_})
	ButtonState.Forms(ButtonSet,6,1,1)
	local stickBugTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Stick Bug",Name="stickBugTPButton",Parent=bearFrame})
	ButtonState.Forms(ButtonSet,7,1,1)
	local windyShrinelTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Windy Shrinel",Name="windyShrinelTPButton",Parent=bearFrame,TextColor3=GuiColor.Text_LWhite_})
	ButtonState.Forms(ButtonSet,8,1,1)
	local kingBeetleTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="King Beetle",Name="kingBeetleTPButton",Parent=bearFrame})
	ButtonState.Forms(ButtonSet,9,1,1)
	local tunnelBearTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Tunnel Bear",Name="tunnelBearTPButton",Parent=bearFrame})
	ButtonState.Forms(ButtonSet,10,1,1)
	local snailTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Snail",Name="snailTPButton",Parent=bearFrame})
	ButtonState.Forms(ButtonSet,11,1,1)
	local comandorTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Comandor",Name="comandorTPButton",Parent=bearFrame})
	ButtonState.Forms(ButtonSet,12,1,1)
	local roboBearButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Robo Bear",Name="roboBearButton",Parent=bearFrame})

	polarBearTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Polar Bear"] end)
	blackBearTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Black Bear"] end)
	brownBearTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Brown Bear"] end)
	rileyBeeTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Riley Bee"] end)
	buckoBeeTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Bucko Bee"] end)
	stickBugTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Stick Bug"] end)
	windyShrinelTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Windy Shrine"] end)
	kingBeetleTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["King Beetle"] end)
	tunnelBearTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Tunnel Bear"] end)
	snailTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Snail"] end)
	comandorTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Comandor"] end)
	roboBearButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Robo Bear"] end)
end)

spawn(function()-----matchFrame-----
	ButtonState.Forms(ButtonSet,1,1,1)
	local extremeMatchTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="ExtremeMatch",Name="extremeMatchTPButton",Parent=matchFrame})
	ButtonState.Forms(ButtonSet,2,1,1)
	local nightMatchTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="NightMatch",Name="nightMatchTPButton",Parent=matchFrame})
	ButtonState.Forms(ButtonSet,3,1,1)
	local megaMatchTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="MegaMatch",Name="megaMatchTPButton",Parent=matchFrame})
	ButtonState.Forms(ButtonSet,4,1,1)
	local memoryMatchTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="MemoryMatch",Name="memoryMatchTPButton",Parent=matchFrame})
	ButtonState.Forms(ButtonSet,5,1,1)
	local honeyConvertor1TPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Convertor1",Name="honeyConvertor1TPButton",Parent=matchFrame,TextColor3=GuiColor.Text_LWhite_})
	ButtonState.Forms(ButtonSet,6,1,1)
	local honeyConvertor2TPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Convertor2",Name="honeyConvertor2TPButton",Parent=matchFrame,TextColor3=GuiColor.Text_LWhite_})
	ButtonState.Forms(ButtonSet,7,1,1)
	local honeyConvertor3TPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Convertor3",Name="honeyConvertor3TPButton",Parent=matchFrame,TextColor3=GuiColor.Text_LWhite_})
	ButtonState.Forms(ButtonSet,8,1,1)
	local coconutDispenserTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Coconut Disp",Name="coconutDispenserTPButton",Parent=matchFrame})
	ButtonState.Forms(ButtonSet,9,1,1)
	local redFieldBoostTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Red Boost",Name="redFieldBoostTPButton",Parent=matchFrame,TextColor3=GuiColor.Text_Red_})
	ButtonState.Forms(ButtonSet,10,1,1)
	local blueFieldBoostTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Blue Boost",Name="blueFieldBoostTPButton",Parent=matchFrame,TextColor3=GuiColor.Text_Blue_})
	ButtonState.Forms(ButtonSet,11,1,1)
	local mountainTopBoostTPButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="White Boost",Name="mountainTopBoostTPButton",Parent=matchFrame})

	extremeMatchTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Extreme Match"] end)
	nightMatchTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Night Match"] end)
	megaMatchTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Mega Match"] end)
	memoryMatchTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Memory Match"] end)
	honeyConvertor1TPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Honey Convertor 1"] end)
	honeyConvertor2TPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Honey Convertor 2"] end)
	honeyConvertor3TPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Honey Convertor 3"] end)
	coconutDispenserTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Coconut Dispenser"] end)
	redFieldBoostTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Redfield Boost"] end)
	blueFieldBoostTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["Bluefield Boost"] end)
	mountainTopBoostTPButton.MouseButton1Up:Connect(function() humanoidRootPart.CFrame = Waypoints["MountainTop Boost"] end)
end)

Waypoints = {-----Waypoints-----
	["Tool Shop"] = CFrame.new(86, 4.6, 294),
	["Tool Shop 2"] = CFrame.new(165, 69, -161),
	["MountainTop Shop"] = CFrame.new(-18, 176, -137),
	["Mental Shop"] = CFrame.new(-497.8, 51.7, 469),
	["Bee Shop"] = CFrame.new(-136.8, 4.6, 243.4),
	["Treat Shop"] = CFrame.new(-233.3, 5.5, 89),
	["Ticket Shop"] = CFrame.new(-12.8, 184, -222.2),
	["RoyalJelly Shop"] = CFrame.new(-297, 53, 68),
	["Ticket RoyalJelly Shop"] = CFrame.new(81, 18, 240),
	["Planter Shop"] = CFrame.new(520.7, 138.2, -325.7),

	["Honeystorm Dispensor"] = CFrame.new(238.4, 33.3, 165.6),
	["Blueberry Dispenser"] = CFrame.new(308.3, 4.8, 136.6),
	["Strawberry Dispenser"] = CFrame.new(-320.5, 46, 272.5),
	["Glue Dispenser"] = CFrame.new(271.7, 25257.2, -720.6),
	["Sprout Dispenser"] = CFrame.new(-269.26, 26.56, 267.31),
	["Gumdrop Dispenser"] = CFrame.new(66, 21.5, 26.4),
	["Treat Dispenser"] = CFrame.new(193.9, 68, -123),
	["Red Clubhouse"] = CFrame.new(-334, 21, 216),
	["Blue Clubhouse"] = CFrame.new(292, 4, 98),
	["Club Honey"] = CFrame.new(44.8, 5, 319.6),

	["Star Room"] = CFrame.new(135.9, 64.6, 322.1),
	["Wealth Clock"] = CFrame.new(333, 48.7, 190),
	["Blender"] = CFrame.new(-426,70,38),
	["Moon"] = CFrame.new(21,88,-54),
	["Ant"] = CFrame.new(93,34,502),
	["Onett"] = CFrame.new(-8.4, 234, -517.9),
	["Top"] = CFrame.new(37.4, 429, -258),
	["Diamond Mask"] = CFrame.new(-336,133,-387),
	["Gummy Mask"] = CFrame.new(272,25268,-773),
	["Demonm Mask"] = CFrame.new(291,28,271),

	["Night Match"] = CFrame.new(-17.2, 312.7, -270.1),
	["Extreme Match"] = CFrame.new(-405,112,545),
	["Mega Match"] = CFrame.new(-429, 69.8, -54),
	["Memory Match"] = CFrame.new(135.9, 68.7, -96),
	["Honey Convertor 1"] = CFrame.new(-146.7, 4.6, 194.6),
	["Honey Convertor 2"] = CFrame.new(140.4, 182.2, -217.2),
	["Honey Convertor 3"] = CFrame.new(282.3, 68.5, -64.3),
	["Coconut Dispenser"] = CFrame.new(-176, 73.2, 534),
	["Redfield Boost"] = CFrame.new(-318, 21, 242),
	["Bluefield Boost"] = CFrame.new(272, 58.4, 85.4),
	["MountainTop Boost"] = CFrame.new(-40, 176, -191.7),

	["Polar Bear"] = CFrame.new(-109, 119.6, -78),
	["Black Bear"] = CFrame.new(-255, 5.5, 295),
	["Brown Bear"] = CFrame.new(280, 46.1, 238),
	["Riley Bee"] = CFrame.new(-360, 73.8, 214),
	["Bucko Bee"] = CFrame.new(304, 62, 105),
	["Stick Bug"] = CFrame.new(-128,50,147),
	["Windy Shrine"] = CFrame.new(-486,142,410),
	["King Beetle"] = CFrame.new(218, 3, 140),
	["Tunnel Bear"] = CFrame.new(507.3, 5.7, -45.7),
	["Snail"] = CFrame.new(420, 117,-178),
	["Comandor"] = CFrame.new(520.7, 47, 162),
	["Robo Bear"] = CFrame.new(-440, 42, 111),
}

spawn(function()-----useFrame-----
	ButtonState.Forms(ButtonSet,1,1,1)
	local autoCloudButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Cloud 10",Name="autoCloudButton",Parent=useFrame})
	ButtonState.Forms(ButtonSet,2,1,1)
	local autoJellyBeansButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Jelly Beans 19",Name="autoJellyBeansButton",Parent=useFrame})
	ButtonState.Forms(ButtonSet,3,1,1)
	local autoMagicBeanButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="MagicBean 10",Name="autoMagicBeanButton",Parent=useFrame,TextColor3=GuiColor.Text_Green_})
	ButtonState.Forms(ButtonSet,4,1,1)
	local autoStingerButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Stinger 30",Name="autoStingerButton",Parent=useFrame,TextColor3=GuiColor.Text_LWhite_})
	
	ButtonState.Forms(ButtonSet,5,1,3)
	local autoSnowflakeButton = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Snowflake 300",Name="autoSnowflakeButton",Parent=useFrame,TextSize=9})
	ButtonState.Forms(ButtonSet,6,1,3)
	local autoRoboParty = CreateButton({Size=ButtonState.Size(ButtonSet),Position=ButtonState.Position(ButtonSet),
		Text="Robo Party",Name="autoRoboParty",Parent=useFrame,TextSize=9})
	--Coconut Gumdrops 

	local function triggeringEvent(button,comand,count,delay)
		if not ButtonState.OnOff(button) then return end
		local text = button.Text
		local A_1 = {["Name"] = comand}
		local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
		Event:FireServer(A_1)
		print(button.Name, "fire")
		for i = 1, count-1 do
			button.Text = text..": "..i
			if not ButtonState.LaunchPeriod(button, delay) then break end
			Event:FireServer(A_1)
			print(button.Name, "fire")
		end
		button.Text = text
		ButtonState.Activation(button)
	end
	
	local Counter={RoboPartyCake=0,RBCText="Robo Party"}
	local function triggeringToyEvent(button,comand,delay)
		local function startRBC(button,comand,delay)
			ButtonState.On(button)
			Counter.RoboPartyCake = 1
			button.Text = Counter.RBCText..": "..Counter.RoboPartyCake
			wait(3)
			local A_1 = comand
			local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
			Event:FireServer(A_1)
			print(button.Name, "fire")
			while Counter.RoboPartyCake > 1 do
				Counter.RoboPartyCake = Counter.RoboPartyCake - 1
				button.Text = Counter.RBCText..": "..Counter.RoboPartyCake
				if not ButtonState.LaunchPeriod(button, delay) then break end
				Event:FireServer(A_1)
				print(button.Name, "fire")
			end
			Counter.RoboPartyCake = 0
			button.Text = Counter.RBCText
			ButtonState.Activation(button)
			return
		end
	
		if button.BackgroundColor3 == GuiColor.Base_ then
			startRBC(button,comand,delay)
		elseif Counter.RoboPartyCake > 5 then
			ButtonState.Off(button)
		elseif button.BackgroundColor3 == GuiColor.On_Color_G then
			Counter.RoboPartyCake = Counter.RoboPartyCake + 1
			button.Text = Counter.RBCText..": "..Counter.RoboPartyCake
		end
	end

	autoCloudButton.MouseButton1Up:Connect(function()
		triggeringEvent(autoCloudButton,"Cloud Vial",10,90)end)
	autoJellyBeansButton.MouseButton1Up:Connect(function()
		triggeringEvent(autoJellyBeansButton,"Jelly Beans",19,50)end)
	autoMagicBeanButton.MouseButton1Up:Connect(function()
		triggeringEvent(autoMagicBeanButton,"Magic Bean",10,10)end)
	autoStingerButton.MouseButton1Up:Connect(function()
		triggeringEvent(autoStingerButton,"Stinger",30,30)end)

	autoSnowflakeButton.MouseButton1Up:Connect(function()
		triggeringEvent(autoSnowflakeButton,"Snowflake",300,10)end)
	autoRoboParty.MouseButton1Up:Connect(function()
		triggeringToyEvent(autoRoboParty,"Robo Party Cake",10400)end)
end)

spawn(function()-----timeFrame-----
	ButtonState.Forms(TimeSet,1,1,1)
	local textHoney = CreateTextLabel({Size=ButtonState.Size(TimeSet),Position=ButtonState.Position(TimeSet),
		Text = "Honey:",Name="textHoney",Parent=timeFrame})
	ButtonState.Forms(TimeSet,2,1,1)
	local textTime = CreateTextLabel({Size=ButtonState.Size(TimeSet),Position=ButtonState.Position(TimeSet),
		Text = "Time:",Name="textTime",Parent=timeFrame})
	ButtonState.Forms(TimeSet,3,1,1)
	local textHour = CreateTextLabel({Size=ButtonState.Size(TimeSet),Position=ButtonState.Position(TimeSet),
		Text = "Pollen: in hout",Name="textHour",Parent=timeFrame})
	ButtonState.Forms(TimeSet,4,1,1)
	local textDay = CreateTextLabel({Size=ButtonState.Size(TimeSet),Position=ButtonState.Position(TimeSet),
		Text = "Pollen: in day",Name="textDay",Parent=timeFrame})

	ButtonState.Forms(TimeSet,5,1,3)
	local startStopButton = CreateButton({Size=ButtonState.Size(TimeSet),Position=ButtonState.Position(TimeSet),
		Text="Start",Name="startStopButton",Parent=timeFrame})
	ButtonState.Forms(TimeSet,6,1,3)
	local resetButton = CreateButton({Size=ButtonState.Size(TimeSet),Position=ButtonState.Position(TimeSet),
		Text="Reset",Name="resetButton",Parent=timeFrame})

	startStopButton.MouseButton1Up:Connect(function()
		local function formatNumber(number)
			local power = 0
			local letter = ""
			if	number > 1000000000000000000 then--E 18
				power = 18
				letter = "E"
			elseif	number > 1000000000000000 then--P 15
				power = 15
				letter = "P"
			elseif number > 1000000000000 then--T 12
				power = 12
				letter = "T"
			elseif number > 1000000000 then--B 9
				power = 9
				letter = "B"
			elseif number > 1000000 then--M 6
				power = 6
				letter = "M"
			elseif number > 1000 then--k 3
				power = 3
				letter = "k"
			else
				return tostring(number)
			end
			number = math.round(number/(10^(power-2)))
			number = number/100
			return tostring(number)..letter
		end
	
		if not ButtonState.OnOff(startStopButton) then return end
		local timeStart_ = os.time()
		local timeZone = os.date("%z")
		local hoursOffset = tonumber(timeZone:sub(1,3))
		local timeDelta_ = 0
		local honeyStart_ = game.Players.LocalPlayer.CoreStats.Honey.Value
		local honeyDelta_ = 0
		startStopButton.Text = "Stop"
		startStopButton.BackgroundColor3 = GuiColor.On_Color_Y
		while startStopButton.AutoButtonColor do
			textHoney.Text = formatNumber(honeyDelta_)
			textTime.Text = ((os.date("%H",timeDelta_)-hoursOffset)..":"..os.date("%M",timeDelta_)..":"..os.date("%S",timeDelta_))
			textHour.Text = formatNumber((honeyDelta_*3600)/timeDelta_).." in hout"
			textDay.Text = formatNumber((honeyDelta_*3600*24)/timeDelta_).." in day"
			repeat
				if allStop then return end
				wait(1)
			until menuFrame.Visible and timeFrame.Visible
			timeDelta_ = os.time() - timeStart_
			honeyDelta_ = game.Players.LocalPlayer.CoreStats.Honey.Value - honeyStart_
		end
		startStopButton.Text = "Start"
		ButtonState.Activation(startStopButton)
	end)

	resetButton.MouseButton1Up:Connect(function()
		if resetButton.AutoButtonColor then
			ButtonState.Off(resetButton)
			humanoidRootPart = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
			textHoney.Text = "Honey:"
			textTime.Text = "Time:"
			textHour.Text = "Pollen: in hout"
			textDay.Text = "Pollen: in day"
			wait(30)
			ButtonState.Activation(resetButton)
			print(resetButton.Name, "use")
		end
	end)

end)
