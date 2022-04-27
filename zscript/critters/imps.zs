class HUW_Imp : HereticImp
{
	bool extremecrash;
	int missilecount;

	Default
	{
		//$Category HexedUW/Critters
		//$Title Imp
		//$Color 4
		Health 40;
		Radius 16;
		Height 36;
		Mass 50;
		Speed 10;
		Painchance 200;
		Monster;
		+FLOAT
		+NOGRAVITY
		+SPAWNFLOAT
		+DONTOVERLAP
		+MISSILEMORE
		SeeSound "himp/sight";
		AttackSound "himp/attack";
		PainSound "himp/pain";
		DeathSound "himp/death";
		ActiveSound "himp/active";
		Obituary "$OB_HUWIMP";
		HitObituary "$HB_HUWIMP";
		Tag "Flying Imp";
	}
	
	States
	{
	Spawn:
		UWIG ABCD 10 A_Look;
		Loop;
	See:
		UWIG AABBCCDD 3 A_Chase;
		Loop;
	Melee:
		UWIG IJ 6 A_FaceTarget;
		UWIG F 6 A_CustomMeleeAttack(random[ImpMsAttack](5,12), "himp/attack", "himp/attack");
		UWIG L 4 A_FaceTarget;
		Goto See;
	Missile:
		UWIG M 10 A_FaceTarget;
		UWIG EF 6;
		UWIG G 6 A_ImpMsAttack;
		UWIG HM 6;
		Goto Missile+2;
	Pain:
		UWIG M 3;
		UWIG M 3 A_Pain;
		Goto See;
	Death:
		UWIG G 4 A_ImpDeath;
		UWIG H 5;
		Wait;
	XDeath:
		UWIG N 5 A_ImpXDeath1;
		UWIG O 5;
		UWIG P 5 A_Gravity;
		UWIG Q 5;
		Wait;
	Crash:
		UWIG N 7 A_ImpExplode;
		UWIG O 7 A_Scream;
		UWIG P 7;
		UWIG Q 3;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	XCrash:
		UWIG N 7;
		UWIG O 7;
		UWIG Z 1;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	}

	//----------------------------------------------------------------------------
	//
	// PROC A_ImpMsAttack
	//
	//----------------------------------------------------------------------------

	void A_ImpMsAttack()
	{
		if (!target || random[ImpMSAtk]() > 64)
		{
			SetState (SeeState);
			return;
		}
		A_SkullAttack(12);
	}

	//----------------------------------------------------------------------------
	//
	// PROC A_ImpExplode
	//
	//----------------------------------------------------------------------------

	void A_ImpExplode()
	{
		Actor chunk;

		bNoGravity = false;

		chunk = Spawn("HereticImpChunk1", pos, ALLOW_REPLACE);
		if (chunk != null)
		{
			chunk.vel.x = random2[ImpExplode]() / 64.;
			chunk.vel.y = random2[ImpExplode]() / 64.;
			chunk.vel.z = 9;
		}

		chunk = Spawn("HereticImpChunk2", pos, ALLOW_REPLACE);
		if (chunk != null)
		{
			chunk.vel.x = random2[ImpExplode]() / 64.;
			chunk.vel.y = random2[ImpExplode]() / 64.;
			chunk.vel.z = 9;
		}
		
		if (extremecrash)
		{
			SetStateLabel ("XCrash");
		}
	}

	//----------------------------------------------------------------------------
	//
	// PROC A_ImpDeath
	//
	//----------------------------------------------------------------------------

	void A_ImpDeath()
	{
		bSolid = false;
		bFloorClip = true;
	}

	//----------------------------------------------------------------------------
	//
	// PROC A_ImpXDeath1
	//
	//----------------------------------------------------------------------------

	void A_ImpXDeath1()
	{
		bSolid = false;
		bFloorClip = true;
		bNoGravity = true;
		extremecrash = true;
	}
}

class HUW_Imp2 : HUW_Imp
{
	Default
	{
		//$Title Mongbat
		Speed 12;
		Painchance 144;
		Obituary "$OB_HUWMON";
		HitObituary "$HB_HUWMON";
		Tag "Flying Mongbat";
	}
	
	States
	{
	Spawn:
		UWIB ABCD 10 A_Look;
		Loop;
	See:
		UWIB AABBCCDD 3 A_Chase;
		Loop;
	Melee:
		UWIB IJ 6 A_FaceTarget;
		UWIB F 6 A_CustomMeleeAttack(random[ImpMsAttack](5,12), "himp/attack", "himp/attack");
		UWIB L 4 A_FaceTarget;
		Goto See;
	Missile:
		UWIB M 10 A_FaceTarget;
		UWIB EF 6;
		UWIB G 3 Bright A_SpawnProjectile("MongbatFX", 45, 0, 0, CMF_AIMOFFSET);
		UWIB HM 6;
		Goto See;
	Pain:
		UWIB M 3;
		UWIB M 3 A_Pain;
		Goto See;
	Death:
		UWIB G 4 A_ImpDeath;
		UWIB H 5;
		Wait;
	XDeath:
		UWIB N 5 A_ImpXDeath1;
		UWIB O 5;
		UWIB P 5 A_Gravity;
		UWIB Q 5;
		Wait;
	Crash:
		UWIB N 7 A_ImpExplode;
		UWIB O 7 A_Scream;
		UWIB P 7;
		UWIB Q 3;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	XCrash:
		UWIB N 7;
		UWIB O 7;
		UWIB Z 1;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	}
}

class MongbatFX : Actor //from CentaurFX, needs to be tweaked
{
	Default
	{
		Speed 20;
		Damage 4;
		Projectile;
		Scale 0.65;
		+BRIGHT
		+SPAWNSOUNDSOURCE
		+ZDOOMTRANS
		RenderStyle "Add";
		SeeSound "CentaurLeaderAttack";
		DeathSound "CentaurMissileExplode";
	}
	
	States
	{
	Spawn:
		CTFX A -1;
		Stop;
	Death:
		MHIT A 4;
		MHIT B 3;
		MHIT C 4;
		MHIT D 3;
		Stop;
	}
}