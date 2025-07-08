IsGameActive <- false;

local window = GUI.Window({
	positionPx = {x = Resolution.x/2 - 250, y = Resolution.y/2 - 250}
	sizePx = {width = 500, height = 500}
	file = Config["MenuWindowTexture"]
})

local logo = GUI.Button({
	positionPx = {x = Resolution.x/2 - 241, y = Resolution.y/2 - 400}
	sizePx = {width = 482, height = 182}
	file = Config["MenuLogoTexture"]
	collection = window
})

local controlsInfo = GUI.Button({
	positionPx = {x = 10, y = 10}
	sizePx = {width = 300, height = 151}
	file = Config["ControlsInfoTexture"]
	collection = window
})

local msg = GUI.Draw({
	relativePositionPx = {x = 155, y = 80}
	text = "Wybierz mapê"
	collection = window
})

local map1 = GUI.Button({
	relativePositionPx = {x = 50, y = 120}
	sizePx = {width = 400, height = 25}
	file = Config["MenuButtonTexture"]
	draw = {text = "Farma Lobarta"}
	collection = window
})

local map2 = GUI.Button({
	relativePositionPx = {x = 50, y = 160}
	sizePx = {width = 400, height = 25}
	file = Config["MenuButtonTexture"]
	draw = {text = "Klasztor"}
	collection = window
})

local map3 = GUI.Button({
	relativePositionPx = {x = 50, y = 200}
	sizePx = {width = 400, height = 25}
	file = Config["MenuButtonTexture"]
	draw = {text = "Le¿e czarnego trolla"}
	collection = window
})

local exitButton = GUI.Button({
	relativePositionPx = {x = 150, y = 400}
	sizePx = {width = 200, height = 25}
	file = Config["MenuButtonTexture"]
	draw = {text = "Wyjœcie"}
	collection = window
})

map1.bind(EventType.Click, function(self) {
    StartGame(LobartFarmClass());
});

map2.bind(EventType.Click, function(self) {
    StartGame(MonasteryClass());
});

map3.bind(EventType.Click, function(self) {
    StartGame(BlackTrollClass());
});


exitButton.bind(EventType.Click, function(self) {
    exitGame();
});

addEventHandler("GUI.onMouseIn", function(self)
{
	if (!(self instanceof GUI.Button))
		return
		
	if(self.file != "INV_SLOT_FOCUS.TGA")
		return

	self.setColor({r = 255, g = 0, b = 0})
})

addEventHandler("GUI.onMouseOut", function(self)
{
	if (!(self instanceof GUI.Button))
		return
		
	if(self.file != "INV_SLOT_FOCUS.TGA")
		return

	self.setColor({r = 255, g = 255, b = 255})
})

function ShowMainMenuGUI()
{
	window.setVisible(true);
	IsGameActive = false;
}

function HideMainMenuGUI()
{
	window.setVisible(false);
	IsGameActive = true;
}