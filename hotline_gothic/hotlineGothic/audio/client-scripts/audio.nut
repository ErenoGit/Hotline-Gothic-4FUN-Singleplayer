local stream = null;
local streamShoot = null;
local streamMelee = null;
local volume = 3000;
local musicIndex = 0;

local window = GUI.Window({
	positionPx = {x = Resolution.x - 310, y = 10}
	sizePx = {width = 300, height = 136}
	file = Config["MediaPlayerBackground"]
})

local prev = GUI.Button({
	relativePositionPx = {x = 10, y = 75}
	sizePx = {width = 40, height = 40}
	file = Config["MediaPlayerPrev"]
	collection = window
})

local vol_down = GUI.Button({
	relativePositionPx = {x = 70, y = 75}
	sizePx = {width = 40, height = 40}
	file = Config["MediaPlayerVolDown"]
	collection = window
})

local pause = GUI.Button({
	relativePositionPx = {x = 130, y = 75}
	sizePx = {width = 40, height = 40}
	file = Config["MediaPlayerPause"]
	collection = window
})

local play = GUI.Button({
	relativePositionPx = {x = 130, y = 75}
	sizePx = {width = 40, height = 40}
	file = Config["MediaPlayerPlay"]
	collection = window
})

local vol_up = GUI.Button({
	relativePositionPx = {x = 190, y = 75}
	sizePx = {width = 40, height = 40}
	file = Config["MediaPlayerVolUp"]
	collection = window
})

local next = GUI.Button({
	relativePositionPx = {x = 250, y = 75}
	sizePx = {width = 40, height = 40}
	file = Config["MediaPlayerNext"]
	collection = window
})

local musicPlayerTextures = [
	Config["MediaPlayerBackground"],
	Config["MediaPlayerPlay"],
	Config["MediaPlayerPause"],
	Config["MediaPlayerNext"],
	Config["MediaPlayerPrev"],
	Config["MediaPlayerVolDown"],
	Config["MediaPlayerVolUp"]
];

function IsItMusicPlayerButton(file)
{
	return musicPlayerTextures.find(file) != null;
}

addEventHandler("GUI.onMouseIn", function(self)
{
	if (!(self instanceof GUI.Button))
		return
		
	if(!IsItMusicPlayerButton(self.file))
		return

	self.setColor({r = 120, g = 120, b = 120})
})

addEventHandler("GUI.onMouseOut", function(self)
{
	if (!(self instanceof GUI.Button))
		return
		
	if(!IsItMusicPlayerButton(self.file))
		return

	self.setColor({r = 255, g = 255, b = 255})
})

addEventHandler("onInit", function()
{
    BASS_Init(-1, 44000, 0); // Initialize BASS

    stream = BASS_StreamCreateFile(Config["SoundtrackFilesNames"][musicIndex], 0); // Create the stream to a .mp3 file

    BASS_ChannelPlay(stream, false);
	
	BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, volume); //0-10000
	
	window.setVisible(true);
	play.setVisible(false);
	
	streamShoot = BASS_StreamCreateFile(Config["ShotgunAttackSoundFileName"], 0); // Create the stream to a .mp3 file
	streamMelee = BASS_StreamCreateFile(Config["MeleeAttackSoundFileName"], 0); // Create the stream to a .mp3 file
});

function ShowMusicPlayer()
{
	window.setVisible(true);
	if(BASS_ChannelIsActive(stream) == 1) {
		play.setVisible(false);
	} else {
		pause.setVisible(false);
	}
}

function HideMusicPlayer()
{
	window.setVisible(false);
}


prev.bind(EventType.Click, function(self) {
    BASS_StreamFree(stream);
	musicIndex = musicIndex - 1;
	if(musicIndex < 0)
		musicIndex = Config["SoundtrackFilesNames"].len() - 1;
		
	stream = BASS_StreamCreateFile(Config["SoundtrackFilesNames"][musicIndex], 0); // Create the stream to a .mp3 file
	BASS_ChannelPlay(stream, false); //play music, loop it
});

next.bind(EventType.Click, function(self) {
    BASS_StreamFree(stream);
	musicIndex = musicIndex + 1;
	if(musicIndex > Config["SoundtrackFilesNames"].len() - 1)
		musicIndex = 0;
		
	stream = BASS_StreamCreateFile(Config["SoundtrackFilesNames"][musicIndex], 0); // Create the stream to a .mp3 file
	BASS_ChannelPlay(stream, false); //play music, loop it
});

vol_down.bind(EventType.Click, function(self) {
    volume = volume - 500;
	if(volume < 500)
		volume = 500;
		
	BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, volume) //0-10000
});

vol_up.bind(EventType.Click, function(self) {
    volume = volume + 500;
	if(volume > 10000)
		volume = 10000;
		
	BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, volume) //0-10000
});

pause.bind(EventType.Click, function(self) {
	BASS_ChannelPause(stream);
	pause.setVisible(false);
	play.setVisible(true);
});

play.bind(EventType.Click, function(self) {
	BASS_ChannelPlay(stream, false);
	pause.setVisible(true);
	play.setVisible(false);
});

function PlayShootSound()
{
	if(BASS_ChannelIsActive(streamShoot) == 1)
	{
		BASS_ChannelSetPosition(streamShoot, 0, 0);
	}
	else
	{
		BASS_ChannelPlay(streamShoot, false);
	}
}

function PlayMeleeSound()
{
	BASS_ChannelPlay(streamMelee, false);
}