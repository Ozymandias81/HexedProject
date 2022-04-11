class HUW_Imp : HereticImp
{
	//bool extremecrash;

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
		Tag "$FN_HERETICIMP";
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
		UWIG F 6 A_CustomMeleeAttack(random[ImpMeAttack](5,12), "himp/attack", "himp/attack");
		UWIG L 4 A_FaceTarget;
		Goto See;
	Missile:
		UWIG M 10 A_FaceTarget;
		UWIG EFGH 6 A_ImpMsAttack;
		UWIG M 6;
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
	
}
/*
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
		
// Heretic imp chunk 1 ------------------------------------------------------

class HereticImpChunk1 : Actor
{
	Default
	{
		Mass 5;
		Radius 4;
		+NOBLOCKMAP
		+MOVEWITHSECTOR
	}
	States
	{
	Spawn:
		IMPX M 5;
		IMPX NO 700;
		Stop;
	}
}

// Heretic imp chunk 2 ------------------------------------------------------

class HereticImpChunk2 : Actor
{
	Default
	{
		Mass 5;
		Radius 4;
		+NOBLOCKMAP
		+MOVEWITHSECTOR
	}
	States
	{
	Spawn:
		IMPX P 5;
		IMPX QR 700;
		Stop;
	}
}

// Heretic imp ball ---------------------------------------------------------

class HereticImpBall : Actor
{
	Default
	{
		Radius 8;
		Height 8;
		Speed 10;
		FastSpeed 20;
		Damage 1;
		Projectile;
		SeeSound "himp/leaderattack";
		+SPAWNSOUNDSOURCE
		-ACTIVATEPCROSS
		-ACTIVATEIMPACT
		+ZDOOMTRANS
		RenderStyle "Add";
	}
	States
	{
	Spawn:
		FX10 ABC 6 Bright;
		Loop;
	Death:
		FX10 DEFG 5 Bright;
		Stop;
	}
}
*/

