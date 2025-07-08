class LobartFarmClass {
	playerSpawnPoint = null;
	playerArmor = null;
	playerWeapon = null;
	npcSpawnPoints = null;
	npcArmors = null;
	npcWeapons = null;
	areaPositions = null;

	constructor() {
		this.areaPositions = [
			{x = 14307, z = -16427},
			{x = 15650, z = -15638},
			{x = 15070, z = -14529},
			{x = 14268, z = -14446},
			{x = 14322, z = -14035},
			{x = 13700, z = -13961},
			{x = 13808, z = -13148},
			{x = 13720, z = -11331},
			{x = 11209, z = -9969},
			{x = 9952, z = -12242},
			{x = 9034, z = -12616},
			{x = 8837, z = -14669},
			{x = 12096, z = -16823},
			
		];
		this.playerSpawnPoint = {x = 12765, y = 1493,z = -13460};
		this.npcSpawnPoints = [
			{x = 11197, y = 1364, z = -10338},
			{x = 12327, y = 1500, z = -11184},
			{x = 13382, y = 1627, z = -11940},
			{x = 14269, y = 1701, z = -12735},
			{x = 13560, y = 1686, z = -13360},
			{x = 14917, y = 1766, z = -15233},
			{x = 13443, y = 1774, z = -17738},
			{x = 11547, y = 1466, z = -15365},
			{x = 9476, y = 1348, z = -13607},
		];
		this.playerArmor = "ITAR_MIL_L";
		this.playerWeapon = "ITRW_CROSSBOW_L_02"; //always crossbow
		this.npcArmors = [
			"ITAR_BAU_L",
			"ITAR_BAU_M",
		];
		this.npcWeapons = [ //only 1h
			"ItMw_1H_Bau_Axe",
			"ItMw_1H_Vlk_Dagger",
			"ItMw_1H_Mace_L_01",
		];
	}
}