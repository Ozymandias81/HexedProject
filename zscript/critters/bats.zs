/*
 * Copyright (c) 2017-2020 AFADoomer ; 2022 Ozymandias81
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
**/

class HUW_BatBase : Actor
{
	Actor roostgoal;
	int countdown;
	int maxchase;

	Property MaxChaseTime:maxchase;

	Default
	{
		-CANPUSHWALLS
		-CANUSEWALLS
		-MTHRUSPECIES
		+FLOAT
		+NOGRAVITY
		+NOINFIGHTING
		+THRUSPECIES
		SeeSound "batfam/idle";
		PainSound "batfam/pain";
		DeathSound "batfam/death";
		ActiveSound "batfam/idle";
		HUW_BatBase.MaxChaseTime 48;
	}

	States
	{
		Roost:
			"####" K Random(35, 350); // 'Sleep' on roost for 1-10 seconds
		RoostLoop:
			"####" K 5 {
				if (!bDormant) { A_Look(); }
			}
			Loop;
	}

	override void PostBeginPlay()
	{
		Super.PostBeginPlay();

		ResetCountDown();
		SpawnRoost();

		if (bDormant)
		{
			if (roostgoal)
			{
				A_SetSize(-1, Default.height / 2);
				SetOrigin(roostgoal.pos, true);
				SetStateLabel("Roost");
			}
		}
	}

	override void Tick()
	{
		if (IsFrozen()) { return; }

		if (bShootable && health > 0)
		{
			if (target)
			{
				if (target != goal && height < Default.Height) { A_SetSize(-1, Default.Height, true); }
				countdown--;

				if (CheckMeleeRange() && countdown > 0) { countdown = 0; }
			}

			if (!roostgoal) { SpawnRoost(); } // Keep trying to spawn a roost if the actors spawned under open sky

			// Positive values on countdown timer are how long remaining in active attack mode
			// Negative values on countdown timer are how long bat has been trying to run away or get back to roost
				//if (countdown == 0 || reactiontime > 0) // When countdown hits zero, run away from the player, SHOULD BE REPLACED WITH LOWHEALTH
				//{
				//	bFrightened = true;
				//}
			else if (countdown < -35 && roostgoal) // After one second of running away, stop running and go back to roost
			{
				bFrightened = false;
				goal = roostgoal;
				target = goal;
				bJustAttacked = True;
				bChaseGoal = True;

				if (roostgoal)
				{
					double dist = Distance2D(roostgoal);
					if (dist < radius && roostgoal.pos.z <= pos.z + height / 2) // At roost, roost.
					{
						SetOrigin(roostgoal.pos, true);
						vel *= 0; // Make sure to remove any externally-applied velocity, or you can (rarely) end up with sliding roosted bats
						SetStateLabel("Roost");

						ResetCountDown();
						A_ClearTarget();
					}
					else if (dist < radius * 3)
					{
						A_SetSize(-1, Default.height / 2); // Make the bat shorter so that the sprite can move closer to the ceiling to roost more smoothly
					}
				}
			}

			if (countdown < 0 && abs(countdown) % 35 == 0)
			{
				if (target)
				{
					NewChaseDir();
				}
				else
				{
					RandomChaseDir();
				}
				FaceMovementDirection();
			}

			if (roostgoal && countdown == 35 * -10) // If you've been trying to get back to your roost for 10 seconds, give up and try to spawn a new roost here
			{
				countdown = -35;

				SpawnRoost();
			}
		}

		Super.Tick();
	}

	void ResetCountdown()
	{
		countdown = int(35 * Random(175, maxchase) * max(1.0, (pos.z - floorz) / 256.0)); // Actively chase player for 5-10 seconds - or more, if the ceiling is high
	}

	void SpawnRoost()
	{
		if (ceilingpic != skyflatnum) // No roosting on sky ceiling
		{
			if (roostgoal) { roostgoal.Destroy(); } // If this gets called twice, destroy the old roost

			roostgoal = Spawn("MapSpot", (pos.xy, ceilingz - Default.height / 2)); // Convenient actor re-use
			roostgoal.bShootable = true; // Must be set so that A_Chase will keep the map spot as a target
		}
	}

	override void Activate (Actor activator)
	{
		if (bDormant) { A_Look(); }

		Super.Activate(activator);
	}

	override int DamageMobj(Actor inflictor, Actor source, int damage, Name mod, int flags, double angle)
	{
		if (bDormant && source && source.player) { bDormant = false; } // Wake up dormant bats that are shot by a player

		return Super.DamageMobj(inflictor, source, damage, mod, flags, angle);
	}
}

//Bats - black, brown and red
class HUW_Bat1 : HUW_BatBase
{
	Default
	{
		//$Category HexedUW/Critters
		//$Title Bat (Black)
		//$Color 4
		Health 100;
		Radius 16;
		Height 32;
		FloatSpeed 2.33333333;
		Speed 3.33333334;
		PainChance 200;
		Monster;
		Tag "$T_UWBAT1";
		HitObituary "$HB_UWBAT1";
		HUW_BatBase.MaxChaseTime 350;
	}

	States
	{
		Spawn:
			UWB1 ABCB 3 A_Look();
			Loop;
		See:
			"####" A 1 A_Chase;
			"####" AA 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			"####" B 1 A_Chase;
			"####" BB 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			"####" C 1 A_Chase;
			"####" CC 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			Loop;
		Melee:
			"####" D 3 A_FaceTarget;
			"####" D 0 A_Jump(64,"Missed");
			"####" E 3 A_CustomMeleeAttack(Random(1, 4), "batfam/idle", "", "");
			"####" FE 3 A_FaceTarget;
			Goto See;
		Missed: //here in order to avoid looping attacks, so the critter is less threatening
			"####" E 3;
			"####" DE 3 A_FaceTarget;
			Goto See;
		Pain:
			"####" D 2;
			"####" D 2 A_Pain;
			Goto See;
		Death:
			"####" D 5 A_ScreamAndUnblock;
			"####" EFD 5 {bMThruSpecies = TRUE; bThruSpecies = TRUE; bNoGravity = FALSE;}
			Goto Death+1;
		Crash:
			"####" G 6 A_ScreamAndUnblock;
			"####" H 7;
			"####" I 8;
			"####" J 4;
			UWDT G -1 {A_SetScale(0.45); bMThruSpecies = TRUE; bThruSpecies = TRUE; bNoGravity = FALSE;}
			Stop;
	}
}
class HUW_Bat2 : HUW_Bat1
{
	Default
	{
		//$Title Bat (Brown)
		Health 150;
		FloatSpeed 3.33333333;
		Speed 4.33333334;
		Tag "$T_UWBAT2";
		HitObituary "$HB_UWBAT2";
		HUW_BatBase.MaxChaseTime 700;
	}

	States
	{
		Spawn:
			UWB2 ABCB 3 A_Look();
			Loop;
		See:
			"####" A 1 A_Chase;
			"####" AA 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			"####" B 1 A_Chase;
			"####" BB 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			"####" C 1 A_Chase;
			"####" CC 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			Loop;
		Melee:
			"####" D 3 A_FaceTarget;
			"####" D 0 A_Jump(64,"Missed");
			"####" E 3 A_CustomMeleeAttack(Random(1, 4), "batfam/idle", "", "");
			"####" FE 3 A_FaceTarget;
			Goto See;
		Missed: //here in order to avoid looping attacks, so the critter is less threatening
			"####" E 3;
			"####" DE 3 A_FaceTarget;
			Goto See;
		Pain:
			"####" D 2;
			"####" D 2 A_Pain;
			Goto See;
		Death:
			"####" D 5 A_ScreamAndUnblock;
			"####" EFD 5 {bMThruSpecies = TRUE; bThruSpecies = TRUE; bNoGravity = FALSE;}
			Goto Death+1;
		Crash:
			"####" G 6 A_ScreamAndUnblock;
			"####" H 7;
			"####" I 8;
			"####" J 4;
			UWDT G -1 {A_SetScale(0.45); bMThruSpecies = TRUE; bThruSpecies = TRUE; bNoGravity = FALSE;}
			Stop;
	}
}
class HUW_Bat3 : HUW_Bat1
{
	Default
	{
		//$Title Bat (Red)
		Health 200;
		FloatSpeed 4.33333333;
		Speed 5.33333334;
		PainChance 200;
		Monster;
		Tag "$T_UWBAT3";
		HitObituary "$HB_UWBAT3";
		HUW_BatBase.MaxChaseTime 1050;
	}

	States
	{
		Spawn:
			UWB3 ABCB 3 A_Look();
			Loop;
		See:
			"####" A 1 A_Chase;
			"####" AA 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			"####" B 1 A_Chase;
			"####" BB 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			"####" C 1 A_Chase;
			"####" CC 1 A_Chase(null,null,CHF_NOPLAYACTIVE);
			Loop;
		Melee:
			"####" D 3 A_FaceTarget;
			"####" D 0 A_Jump(64,"Missed");
			"####" E 3 A_CustomMeleeAttack(Random(1, 4), "batfam/idle", "", "");
			"####" FE 3 A_FaceTarget;
			Goto See;
		Missed: //here in order to avoid looping attacks, so the critter is less threatening
			"####" E 3;
			"####" DE 3 A_FaceTarget;
			Goto See;
		Pain:
			"####" D 2;
			"####" D 2 A_Pain;
			Goto See;
		Death:
			"####" D 5 A_ScreamAndUnblock;
			"####" EFD 5 {bMThruSpecies = TRUE; bThruSpecies = TRUE; bNoGravity = FALSE;}
			Goto Death+1;
		Crash:
			"####" G 6 A_ScreamAndUnblock;
			"####" H 7;
			"####" I 8;
			"####" J 4;
			UWDT G -1 {A_SetScale(0.45); bMThruSpecies = TRUE; bThruSpecies = TRUE; bNoGravity = FALSE;}
			Stop;
	}
}