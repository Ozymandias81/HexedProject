//Bats - black, red and brown
class HUW_Bat1 : Actor
{
	Default
	{
		//$Category HexedUW/Critters
		//$Title Bat (Black)
		//$Color 4
		Health 4;
		Radius 16;
		Height 32;
		FloatSpeed 2.33333333;
		Speed 3.33333334;
		PainChance 200;
		Monster;
		-CANPUSHWALLS
		-CANUSEWALLS
		-COUNTKILL
		-MTHRUSPECIES
		-THRUSPECIES
		+FLOAT
		+NOGRAVITY
		+NOINFIGHTING
		SeeSound "batfam/idle";
		PainSound "batfam/pain";
		DeathSound "batfam/death";
		ActiveSound "batfam/idle";
		HitObituary "$BAT";
		//HUWBatBase.MaxChaseTime 7;
	}

	States
	{
		Spawn:
			BFAM ABCB 3 A_Look(); //ThroughDisguise();
			Loop;
		See:
			"####" A 1 A_Chase;
			"####" AA 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			"####" B 1 A_Chase;
			"####" BB 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			"####" C 1 A_Chase;
			"####" CC 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			"####" D 1 A_Chase;
			"####" DD 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			Loop;
		Melee:
			"####" A 3 A_FaceTarget;
			"####" A 0 A_Jump(64,"Missed");
			"####" B 3 A_CustomMeleeAttack(Random(1, 4), "batfam/idle", "", "Pest");
			"####" CB 3 A_FaceTarget;
			Goto See;
		Missed: //here in order to avoid looping attacks, so the critter is less threatening
			"####" B 3;
			"####" CB 3 A_FaceTarget;
			Goto See;
		Pain:
			"####" A 2;
			"####" A 2 A_Pain;
			Goto See;
		Death:
			"####" D 5 A_ScreamAndUnblock;
			"####" EFD 5 {bMThruSpecies = TRUE; bThruSpecies = TRUE; bNoGravity = FALSE;}
			Goto Death+1;
		Crash:
			"####" G 6 A_ScreamAndUnblock;
			"####" H 7;
			"####" I 8;
			"####" J -1 {bMThruSpecies = TRUE; bThruSpecies = TRUE; bNoGravity = FALSE;}
			Stop;
	}
}