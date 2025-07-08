class MonasteryClass {
	playerSpawnPoint = null;
	playerArmor = null;
	playerWeapon = null;
	npcSpawnPoints = null;
	npcArmors = null;
	npcWeapons = null;
	areaPositions = null;

	constructor() {
		this.areaPositions = [
			{x = 46540, z = 20317},
			{x = 46984, z = 19548},
			{x = 46750, z = 19413},
			{x = 47594, z = 18059},
			{x = 47811, z = 18182},
			{x = 48282, z = 17415},
			{x = 50686, z = 18868},
			{x = 50168, z = 19736},
			{x = 51295, z = 20412},
			{x = 50524, z = 21639},
			{x = 49394, z = 21010},
			{x = 48938, z = 21763},
		];
		this.playerSpawnPoint = {x = 48279, y = 4990,z = 19397};
		this.npcSpawnPoints = [
			{x = 50480, y = 5090,z = 20262},
			{x = 50094, y = 5090,z = 20940},
			{x = 47227, y = 4990,z = 18752},
			{x = 46897, y = 5090,z = 20379},
			{x = 47535, y = 5090,z = 20741},
			{x = 49085, y = 4990,z = 21198},
			{x = 48439, y = 5090,z = 17706},
			{x = 49156, y = 5090,z = 18114},
			{x = 49961, y = 4990,z = 19076},
		];
		this.playerArmor = "ItAr_Dementor";
		this.playerWeapon = "ItRw_Crossbow_H_02"; //always crossbow
		this.npcArmors = [
			"ItAr_Nov_L",
			"ItAr_KdF_L",
			"ItAr_KdF_H",
		];
		this.npcWeapons = [ //only 1h
			"ItMw_1H_Mace_L_03",
			"ItMw_Kriegskeule",
			"ItMw_1H_Mace_L_01",
		];
	}
}