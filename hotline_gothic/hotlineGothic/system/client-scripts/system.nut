const PI = 3.14159265;
local path = CameraPath();
local gameArea;
local shouldCameraFollowNpcHero = false;
local isPlayerReadyAfterSpawn = false;
local isGameStarted = false;
local moveDirection = 0;
local shouldMove = false;
local isWPressed = false;
local isSPressed = false;
local isAPressed = false;
local isDPressed = false;
local defaultCursorSizeX;
local defaultCursorSizeY;
local isOnCooldownAfterShoot = false;
local isPlayerDead = false;
local bulletsVobs = [];
local spawnsVobs = [];
local shootEffectFx;
local deadEffectFx;
local actualMapClass = null;
local aliveNpcs = [];
local allNpcs = [];
local score = 0;
local highScore = 0;
local timerToStartSprintMode = null;
local sprintMode = false;


local headModels = [
	"Hum_Head_Thief",
	"Hum_Head_Fighter",
	"Hum_Head_Pony",
	"Hum_Head_Bald",
	"Hum_Head_Psionic"
];

npcHero <- null;

local infoDrawDontExitArea = GUI.Draw({
	positionPx = {x = Resolution.x/2 - 350, y = Resolution.y/2 - 400}
	text = "Nie wychodŸ poza strefê gry!"
	font = "FONT_OLD_20_WHITE_HI.TGA"
})

local infoDrawSprintMode = GUI.Draw({
	positionPx = {x = Resolution.x/2 - 200, y = Resolution.y/2 - 400}
	text = "SPRINT MODE!"
	font = "FONT_OLD_20_WHITE_HI.TGA"
})

local infoESCButtonToExit = GUI.Draw({
	position = {x = 10, y = 10}
	text = "Wciœnij ESC aby wróciæ do menu"
})

local infoYouDied = GUI.Draw({
	positionPx = {x = Resolution.x/2 - 400, y = Resolution.y/2 - 500}
	text = "Nie ¿yjesz!"
	font = "FONT_OLD_20_WHITE_HI.TGA"
})
infoYouDied.setScale(3,3);

local infoScore = GUI.Draw({
	position = {x = 10, y = 200}
	text = "Wynik: 0"
})
infoScore.setScale(2,2);

local infoHighScore = GUI.Draw({
	position = {x = 10, y = 600}
	text = "Najlepszy wynik: 0"
})

path.createPoint({position = [8115, 620, -5910], rotation = [2, 334, 0], lerpSpeed = 100});
path.createPoint({position = [5866, 565, -2137], rotation = [3, 334, 0], lerpSpeed = 100});
path.createPoint({position = [6050, 1681, -85], rotation = [23, 23, 0], lerpSpeed = 100});
path.createPoint({position = [8744, 1794, 3836], rotation = [26, 40, 0], lerpSpeed = 100});

addEventHandler("onInit", function()
{
	clearMultiplayerMessages();
	setHudMode(HUD_ALL, HUD_MODE_HIDDEN);
	enable_DamageAnims(false);
    enable_NicknameId(false);
	disableMusicSystem(true);
	ShowMainMenu();
	
	npcHero = createNpc("Hero");
	spawnNpc(npcHero, "PC_HERO");
	local cursorSize = getCursorSizePx();
	defaultCursorSizeX = cursorSize.x;
	defaultCursorSizeY = cursorSize.y;
	
	GetHighScoreFromLocalStorage();
});

function ShowMainMenu()
{
	setFreeze(true);
	setCursorVisible(true);
	
	Camera.movementEnabled = false;
	Camera.modeChangeEnabled = false;

	Camera.setPosition(path.points[0].position.x, path.points[0].position.y, path.points[0].position.z);
	Camera.setRotation(path.points[0].rotation.x, path.points[0].rotation.y, path.points[0].rotation.z);

	disableControls(true);

    path.start();
	
	ShowMainMenuGUI();
}

function onEnterArea()
{
}

function onExitArea()
{
	setPlayerPosition(npcHero, actualMapClass.playerSpawnPoint.x, actualMapClass.playerSpawnPoint.y, actualMapClass.playerSpawnPoint.z);
	infoDrawDontExitArea.setVisible(true);
	
	setTimer(function() {
        infoDrawDontExitArea.setVisible(false);
    }, 2000, 1);
}

function StartGame(mapClass)
{
	isGameStarted = true;
	HideMainMenuGUI();
	path.stop();
	setPlayerPosition(npcHero, mapClass.playerSpawnPoint.x, mapClass.playerSpawnPoint.y, mapClass.playerSpawnPoint.z);
	setPlayerAngle(npcHero, 0, false);
	infoESCButtonToExit.setVisible(true);
	infoScore.setVisible(true);
	infoHighScore.setVisible(true);
	UpdateInfoHighScore();
	
	gameArea = Area({
		points = mapClass.areaPositions,
		world = "NEWWORLD\\NEWWORLD.ZEN"
	})

	AreaManager.add(gameArea, onEnterArea, onExitArea);

	Camera.movementEnabled = false;
	Camera.modeChangeEnabled = false;
	Camera.setPosition(mapClass.playerSpawnPoint.x, mapClass.playerSpawnPoint.y + Config["CameraHeight"], mapClass.playerSpawnPoint.z);
	Camera.setRotation(90, 0, 0);
	setFreeze(false);
	giveItem(npcHero, "ITRW_BOLT", 1000);
	setPlayerStrength(npcHero, 200);
	giveItem(npcHero, mapClass.playerArmor, 1);
	giveItem(npcHero, mapClass.playerWeapon, 1);
	equipItem(npcHero, mapClass.playerArmor, -1);
	equipItem(npcHero, mapClass.playerWeapon, -1);
	setPlayerSkillWeapon(npcHero, WEAPON_CBOW, 45);
	setCursorTxt(Config["CursorTextureInGame"]);
	setCursorSizePx(defaultCursorSizeX * Config["CursorTextureMultipler"], defaultCursorSizeY * Config["CursorTextureMultipler"]);
	HideMusicPlayer();
	actualMapClass = mapClass;
	
	isWPressed = false;
	isSPressed = false;
	isAPressed = false;
	isDPressed = false;
	
	//fcking weapon mode is retarded as fck in G2, so we have to do it twice to be sure
	setTimer(function() {
		setPlayerWeaponMode(npcHero, WEAPONMODE_CBOW);
    }, 100, 1);
	
	setTimer(function() {
		if(getPlayerWeaponMode(npcHero) == WEAPONMODE_CBOW) {
			isPlayerReadyAfterSpawn = true;
		}
    }, 500, 1);
	
	setTimer(function() {
		if(getPlayerWeaponMode(npcHero) != WEAPONMODE_CBOW) {
			setPlayerWeaponMode(npcHero, WEAPONMODE_CBOW);
		}
    }, 1000, 1);
	
	setTimer(function() {
		if(isGameStarted)
		{
			isPlayerReadyAfterSpawn = true;
		}
    }, 1500, 1);
	//
	
	shouldCameraFollowNpcHero = true;
	
	foreach (npcSpawnPoint in mapClass.npcSpawnPoints) {
		local vob = Vob(Config["NpcSpawnLocationModel"]);
		vob.addToWorld();
		vob.setPosition(npcSpawnPoint.x, npcSpawnPoint.y - 100, npcSpawnPoint.z);
		vob.cdDynamic = false;
		vob.cdStatic = false;
		spawnsVobs.push(vob);
	}
	
	timerToStartSprintMode = setTimer(function() {
		if(IsGameActive && isPlayerReadyAfterSpawn)
		{
			sprintMode = true;
			infoDrawSprintMode.setVisible(true);
	
			setTimer(function() {
				infoDrawSprintMode.setVisible(false);
			}, 2000, 1);
		}
    }, 30000, 1);
}

local toRemove = [];

addEventHandler("onRender",function()
{
	if(shouldCameraFollowNpcHero)
	{
		local pos = getPlayerPosition(npcHero);
        Camera.setPosition(pos.x, pos.y + Config["CameraHeight"], pos.z);
	}
	
	if(IsGameActive && isPlayerReadyAfterSpawn)
	{
		for (local i = bulletsVobs.len() - 1; i >= 0; i--) {
			local entry = bulletsVobs[i];
			local vob = entry.vobObject;
			local vobPos = vob.getPosition();

			local directionRad = (entry.direction - 90.0) * PI / 180.0;
			local speed = 2.0;

			local deltaX = cos(directionRad) * speed;
			local deltaZ = -sin(directionRad) * speed;

			vob.setPosition(vobPos.x + deltaX, vobPos.y, vobPos.z + deltaZ);
			
			if(getDistance2d(vobPos.x, vobPos.z, entry.shootX, entry.shootZ) > 2000) {
				bulletsVobs.remove(i);
			}
		}
	}
})

function StopGame()
{
	isGameStarted = false;
	isPlayerReadyAfterSpawn = false;
	setPlayerWeaponMode(npcHero, WEAPONMODE_NONE);
	setFreeze(true);
	shouldCameraFollowNpcHero = false;
	AreaManager.remove(gameArea);
	infoESCButtonToExit.setVisible(false);
	setCursorTxt("LO.TGA"); //default cursor texture
	setCursorSizePx(defaultCursorSizeX, defaultCursorSizeY);
	ShowMusicPlayer();
	actualMapClass = null;
	
	foreach (npc in aliveNpcs) {
		destroyNpc(npc);
	}
	aliveNpcs.clear();
	foreach (npc in allNpcs) {
		destroyNpc(npc);
	}
	allNpcs.clear();
	spawnsVobs.clear();
	
	infoYouDied.setVisible(false);
	isPlayerDead = false;
	infoScore.setVisible(false);
	infoHighScore.setVisible(false);
	
	CheckIsScoreBetterAndUpdateIfNeed();
	score = 0;
	infoScore.setText("Wynik: 0");
	if(timerToStartSprintMode != null) {
		killTimer(timerToStartSprintMode);
	}
	timerToStartSprintMode = null;
	sprintMode = false;
	infoDrawDontExitArea.setVisible(false);
	infoDrawSprintMode.setVisible(false);
}


local function onKeyDownHandler(key)
{
	if(isPlayerDead)
	{
		if(key == KEY_ESCAPE)
		{
			StopGame();
			ShowMainMenu();
			return;
		}
	}
	else if(IsGameActive && isPlayerReadyAfterSpawn)
	{
		if(key == KEY_ESCAPE)
		{
			StopGame();
			ShowMainMenu();
			return;
		}
		
		if(key == KEY_W)
		{
			isWPressed = true;
		}
		else if(key == KEY_S)
		{
			isSPressed = true;
		}
		else if(key == KEY_A)
		{
			isAPressed = true;
		}
		else if(key == KEY_D)
		{
			isDPressed = true;
		}
	}
}
addEventHandler("onKeyDown", onKeyDownHandler)

local function onKeyUpHandler(key)
{
	if(IsGameActive && isPlayerReadyAfterSpawn)
	{
		if(key == KEY_W)
		{
			isWPressed = false;
		}
		else if(key == KEY_S)
		{
			isSPressed = false;
		}
		else if(key == KEY_A)
		{
			isAPressed = false;
		}
		else if(key == KEY_D)
		{
			isDPressed = false;
		}
	}
}
addEventHandler("onKeyUp", onKeyUpHandler)


setTimer(function() { //move loop
	if(isGameStarted)
	{
		shouldMove = false;
		
		if(isWPressed && isAPressed) {
			moveDirection = 315;
			shouldMove = true;
		}
		else if(isWPressed && isDPressed) {
			moveDirection = 45;
			shouldMove = true;
		}
		else if(isSPressed && isAPressed) {
			moveDirection = 225;
			shouldMove = true;
		}
		else if(isSPressed && isDPressed) {
			moveDirection = 135;
			shouldMove = true;
		}
		else if(isWPressed) {
			moveDirection = 0;
			shouldMove = true;
		}
		else if(isSPressed) {
			moveDirection = 180;
			shouldMove = true;
		}
		else if(isAPressed) {
			moveDirection = 270;
			shouldMove = true;
		}
		else if(isDPressed) {
			moveDirection = 90;
			shouldMove = true;
		}
	
		if(shouldMove)
		{
			setPlayerAngle(npcHero, moveDirection, false);
			if(getPlayerAni(npcHero) != "S_CBOWRUNL") {
				playAni(npcHero, "S_CBOWRUNL");
			}
		}
		else
		{
			if(getPlayerAni(npcHero) != "S_RUN") {
				playAni(npcHero, "S_RUN");
			}
		}
	}
}, 50, 0);

local function onMouseDownHandler(button)
{
	if(IsGameActive && isPlayerReadyAfterSpawn && !isOnCooldownAfterShoot && !isPlayerDead)
	{
		if(button == MOUSE_BUTTONLEFT)
		{
			local cursorPos = getCursorPosition(); // in virtuals, 0 is 0%, 8192 is 100%
			local cursorSize = getCursorSize();
			local screenResolution = getResolution();

			local cursorCenterX = cursorPos.x + (cursorSize.x / 2);
			local cursorCenterY = cursorPos.y + (cursorSize.y / 2);

			local realX = cursorCenterX * screenResolution.x / 8192;
			local realY = cursorCenterY * screenResolution.y / 8192;

			local centerRealX = 4096 * screenResolution.x / 8192;
			local centerRealY = 4096 * screenResolution.y / 8192;

			local dx = realX - centerRealX;

			local dy = (centerRealY - realY) * (screenResolution.x / screenResolution.y);

			local angleRad = atan2(dx, dy);
			local angleDeg = angleRad * (180.0 / PI);
			if (angleDeg < 0) angleDeg += 360;

			playAni(npcHero, "S_RUN");
			setPlayerAngle(npcHero, angleDeg, false);
			
			PlayShootSound();
			
			local playerPos = getPlayerPosition(npcHero);

			for (local i = 0; i < Config["AmmoOnShootQuantity"]; i++) {
				local vob = Vob(Config["AmmoModel"]);
				vob.addToWorld();
				vob.setPosition(playerPos.x, playerPos.y + 10, playerPos.z);
				
				local randomOffset = RandomFloat(-3.0, 3.0);

				local entry = {
					vobObject = vob,
					direction = angleDeg + randomOffset,
					shootX = playerPos.x,
					shootZ = playerPos.z
				};

				bulletsVobs.push(entry);
			}
			
			local playerPtr = getPlayerPtr(npcHero);
			shootEffectFx = VisualFX.createAndPlay("SPELLFX_DEATHBALL_COLLIDE", playerPtr);
			setTimer(function() {
				shootEffectFx.kill();
			}, 500, 1);
			
			isOnCooldownAfterShoot = true;
			setTimer(function() {
				isOnCooldownAfterShoot = false;
			}, 500, 1);
		}
	}
}
addEventHandler("onMouseDown", onMouseDownHandler)

function RandomFloat(min, max) {
	return min + ((max - min) * rand().tofloat() / RAND_MAX.tofloat());
}

function SpawnNewNpc(spawnPoint)
{
	local newNpc = createNpc("NPC");
	spawnNpc(newNpc);
	
	local randomHeadTxt = 1 + (rand() % 30);
	setPlayerVisual(newNpc, "HUM_BODY_NAKED0", 1, GetRandomHeadModel(), randomHeadTxt);
	setPlayerStrength(newNpc, 200);
	local randomArmorIndex = rand() % actualMapClass.npcArmors.len();
	local randomWeaponIndex = rand() % actualMapClass.npcWeapons.len();
	giveItem(newNpc, actualMapClass.npcArmors[randomArmorIndex], 1);
	giveItem(newNpc, actualMapClass.npcWeapons[randomWeaponIndex], 1);
	equipItem(newNpc, actualMapClass.npcArmors[randomArmorIndex], -1);
	equipItem(newNpc, actualMapClass.npcWeapons[randomWeaponIndex], -1);
	setPlayerSkillWeapon(newNpc, WEAPON_1H, 45);
	setPlayerPosition(newNpc, spawnPoint.x, spawnPoint.y, spawnPoint.z);
	drawWeaponQueued(newNpc, WEAPONMODE_1HS);
	
	if(sprintMode) {
		applyPlayerOverlay(newNpc, "HumanS_Sprint.mds");
	}
	
	aliveNpcs.push(newNpc);
	allNpcs.push(newNpc);
}

setTimer(function() { //spawn npc loop
	if(IsGameActive && isPlayerReadyAfterSpawn && !isPlayerDead) {
		local randomIndex = rand() % actualMapClass.npcSpawnPoints.len();
		local randomSpawnPoint = actualMapClass.npcSpawnPoints[randomIndex];
		SpawnNewNpc(randomSpawnPoint);
	}
}, 1000, 0);

setTimer(function() { //AI loop
	if(IsGameActive && isPlayerReadyAfterSpawn) {
		foreach (npc in aliveNpcs) {
			if(!isPlayerDead)
			{
				local playerPos = getPlayerPosition(npcHero);
				local npcPos = getPlayerPosition(npc);
				setPlayerAngle(npc, getVectorAngle(npcPos.x, npcPos.z, playerPos.x, playerPos.z), false);
				
				if(getDistance2d(npcPos.x, npcPos.z, playerPos.x, playerPos.z) < 100)
				{
					playAni(npc, "S_1HATTACK");
					
					PlayMeleeSound();
					
					local playerPtr = getPlayerPtr(npcHero);
					deadEffectFx = VisualFX.createAndPlay("TRANSFORM_NOPLACEFX", playerPtr);
					setTimer(function() {
						deadEffectFx.kill();
					}, 500, 1);
					
					setTimer(function() {
						PlayerWasKilled();
					}, 200, 1);
				}
				else
				{
					playAni(npc, "S_1HRUNL");
				}
			}
		}
	}
}, 200, 0);

function GetRandomHeadModel()
{
	local headModelIndex = rand() % headModels.len();
	return headModels[headModelIndex];
}

function PlayerWasKilled()
{
	infoYouDied.setVisible(true);
	isPlayerDead = true;
	isGameStarted = false;
	
	playAni(npcHero, "S_DEAD");
	
	foreach (npc in aliveNpcs) {
		playAni(npc, "S_1HRUN");
		removeWeaponQueued(npc);
	}
	
	CheckIsScoreBetterAndUpdateIfNeed();
}


setTimer(function() { //check is bullet hit npc loop
	if(IsGameActive && isPlayerReadyAfterSpawn) {
		foreach (vob in bulletsVobs) {
			for (local i = aliveNpcs.len() - 1; i >= 0; i--) {
				local npcVob = Vob(getPlayerPtr(aliveNpcs[i]));
				if(vob.vobObject.bbox3dWorld.intersecting(npcVob.bbox3dWorld)) {
					local npcId = allNpcs.find(aliveNpcs[i]);
					local npcObject = allNpcs[npcId];
					
					setTimer(function() {
						if(IsGameActive && isPlayerReadyAfterSpawn) {
							local allNpcId = allNpcs.find(npcObject);
							if(allNpcId != null) 
							{
								destroyNpc(allNpcs[allNpcId]);
								allNpcs.remove(allNpcId);
							}
						}
					}, 5000, 1);
					
					playAni(aliveNpcs[i], "S_DEAD");
					aliveNpcs.remove(i);
					
					UpdateInfoScore();
				}
			}
		}
	}
}, 50, 0);


function UpdateInfoScore()
{
	score++;
	infoScore.setText("Wynik: " + score);
}

function CheckIsScoreBetterAndUpdateIfNeed()
{
	if(score > highScore)
	{
		highScore = score;
		LocalStorage.setItem("highScore", highScore);
		UpdateInfoHighScore();
	}
}

function UpdateInfoHighScore()
{
	infoHighScore.setText("Najlepszy wynik: " + highScore);
}

function GetHighScoreFromLocalStorage()
{
	try {
		local highScoreLS = LocalStorage.getItem("highScore");
		if(highScoreLS != null) {
			highScore = highScoreLS.tointeger();
		}
	}
	catch(error) {}
}