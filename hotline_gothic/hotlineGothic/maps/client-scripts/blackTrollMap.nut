class BlackTrollClass {
	playerSpawnPoint = null;
	playerArmor = null;
	playerWeapon = null;
	npcSpawnPoints = null;
	npcArmors = null;
	npcWeapons = null;
	areaPositions = null;

	constructor() {
		this.areaPositions = [
			{x = 53634, z = 36145},
			{x = 52241, z = 37876},
			{x = 50619, z = 37758},
			{x = 50223, z = 38756},
			{x = 48726, z = 40489},
			{x = 46949, z = 39330},
			{x = 49430, z = 31160},
			{x = 52752, z = 32805},
			{x = 52974, z = 33295},
			{x = 54509, z = 34012},
		];
		this.playerSpawnPoint = {x = 51719, y = 8022,z = 36053};
		this.npcSpawnPoints = [
			{x = 53671, y = 7911, z = 36133},
			{x = 51035, y = 7891, z = 37269},
			{x = 49777, y = 7962, z = 38620},
			{x = 48098, y = 8019, z = 39638},
			{x = 50179, y = 7915, z = 35501},
			{x = 50953, y = 7778, z = 32756},
			{x = 52138, y = 7840, z = 32717},
			{x = 54059, y = 7933, z = 34529},
		];
		this.playerArmor = "ItAr_Sld_H";
		this.playerWeapon = "ItRw_Crossbow_M_02"; //always crossbow
		this.npcArmors = [
			"ItAr_Bdt_M",
			"ItAr_Bdt_H",
		];
		this.npcWeapons = [ //only 1h
			"ItMw_Addon_BanditTrader",
			"ItMw_Addon_Betty",
			"ItMw_Addon_Hacker_1H_01",
		];
	}
}