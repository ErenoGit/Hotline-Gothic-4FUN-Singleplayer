Resolution <- getResolution();

Config <- {};

Config["CameraHeight"] <- 1000;

Config["SoundtrackFilesNames"] <- [ //.mp3 music files names from _work/data/music
	"Carpenter_Brut_Le_Perv.mp3",
	"MOON_paris.mp3",
    "Kill_Streak_Original_Mix.mp3",
    "MOON_hydrogen.mp3",
    "Voyager_Original_Mix.mp3",
];

Config["MeleeAttackSoundFileName"] <- "melee.mp3"; //.mp3 file from _work/data/sound
Config["ShotgunAttackSoundFileName"] <- "shotgun.mp3"; //.mp3 file from _work/data/sound

Config["MenuLogoTexture"] <- "HOTLINE_GOTHIC_LOGO.TGA"; //.tga file from _work/data/textures, 482x182 px
Config["MenuButtonTexture"] <- "INV_SLOT_FOCUS.TGA";
Config["MenuWindowTexture"] <- "MENU_INGAME.TGA";


//Music player textures
Config["MediaPlayerBackground"] <- "MUSIC_PLAYER_BACKGROUND.TGA"; //.tga file from _work/data/textures
Config["MediaPlayerPlay"] <- "MUSIC_PLAYER_PLAY.TGA"; //.tga file from _work/data/textures
Config["MediaPlayerPause"] <- "MUSIC_PLAYER_PAUSE.TGA"; //.tga file from _work/data/textures
Config["MediaPlayerNext"] <- "MUSIC_PLAYER_NEXT.TGA"; //.tga file from _work/data/textures
Config["MediaPlayerPrev"] <- "MUSIC_PLAYER_PREV.TGA"; //.tga file from _work/data/textures
Config["MediaPlayerVolDown"] <- "MUSIC_PLAYER_VOL_DOWN.TGA"; //.tga file from _work/data/textures
Config["MediaPlayerVolUp"] <- "MUSIC_PLAYER_VOL_UP.TGA"; //.tga file from _work/data/textures

Config["ControlsInfoTexture"] <- "CONTROLS_INFO.TGA"; //.tga file from _work/data/textures, 600x302 px

Config["CursorTextureInGame"] <- "GUN_SIGHT_CURSOR_V2.TGA"; //.tga file from _work/data/textures, 64x64 px
Config["CursorTextureMultipler"] <- 4;

Config["AmmoModel"] <- "itmi_whitepearl_01.3DS";
Config["AmmoOnShootQuantity"] <- 5;

Config["NpcSpawnLocationModel"] <- "nw_nature_woodpiece_01.3ds";

enum Maps
{
    LobartFarm,
	KhorinisTown,
	OnarFarm,
}