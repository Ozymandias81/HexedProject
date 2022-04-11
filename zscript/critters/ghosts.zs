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

class HUWGhostBase : Actor
{
	int countdown;
	int maxchase;

	Property MaxChaseTime:maxchase;

	Default
	{
		//$Category HexedUW/Critters
		//$Color 4
		-CANPUSHWALLS
		-CANUSEWALLS
		-MTHRUSPECIES
		+FLOAT
		+NOGRAVITY
		+NOINFIGHTING
		+THRUACTORS //ghosts
		+VISIBILITYPULSE
		Monster;
		Alpha 0.75;
		RenderStyle "Translucent";
		SeeSound "ghost/idle";
		PainSound "ghost/pain";
		DeathSound "ghost/death";
		ActiveSound "ghost/idle";
		HUWGhostBase.MaxChaseTime 48;
	}

	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		ResetCountDown();
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

		}

		Super.Tick();
	}

	void ResetCountdown()
	{
		countdown = int(35 * Random(175, maxchase) * max(1.0, (pos.z - floorz) / 256.0)); // Actively chase player for 5-10 seconds - or more, if the ceiling is high
	}

	override void Activate (Actor activator)
	{
		if (bDormant) { A_Look(); }

		Super.Activate(activator);
	}

	override int DamageMobj(Actor inflictor, Actor source, int damage, Name mod, int flags, double angle)
	{
		if (bDormant && source && source.player) { bDormant = false; } // Wake up dormant ghosts that are shot by a player

		return Super.DamageMobj(inflictor, source, damage, mod, flags, angle);
	}
}

//Ghosts - cyan, red, white and purple
class HUW_Ghost1 : HUWGhostBase
{
	Default
	{
		//$Title Ghost (Cyan)
		Health 300;
		Radius 16;
		Height 32;
		FloatSpeed 3;
		Speed 2;
		PainChance 64;
		HitObituary "$UWGHOST1";
	}

	States
	{
		Spawn:
			UWGC ABCDC 4 A_Look();
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
			"####" EF 3 A_FaceTarget;
			"####" G 3 A_CustomMeleeAttack(Random(1, 4), "ghost/idle", "", "");
			"####" HF 3 A_FaceTarget;
			Goto See;
		Pain:
			"####" E 2;
			"####" EEE 1 A_Fadeout(0.2);
			"####" F 2 A_Pain;
			Goto See;
		Death:
			"####" G 3 A_ScreamAndUnblock;
			"####" H 3 A_SetTranslucent(0.5);
			"####" IJK 5;
			"####" L 3;
			Stop;
	}
}

class HUW_Ghost2 : HUW_Ghost1
{
	Default
	{
		//$Title Ghost (Purple)
		Health 350;
		HitObituary "$UWGHOST2";
	}

	States
	{
		Spawn:
			UWGP ABCDC 4 A_Look();
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
			"####" EF 3 A_FaceTarget;
			"####" G 3 A_CustomMeleeAttack(Random(1, 4), "ghost/idle", "", "");
			"####" HF 3 A_FaceTarget;
			Goto See;
		Pain:
			"####" E 2;
			"####" EEE 1 A_Fadeout(0.2);
			"####" F 2 A_Pain;
			Goto See;
		Death:
			"####" G 3 A_ScreamAndUnblock;
			"####" H 3 A_SetTranslucent(0.5);
			"####" IJK 5;
			"####" L 3;
			Stop;
	}
}

class HUW_Ghost3 : HUW_Ghost1
{
	Default
	{
		//$Title Ghost (Red)
		Health 300;
		FloatSpeed 4;
		Speed 3;
		HitObituary "$UWGHOST3";
	}

	States
	{
		Spawn:
			UWGR ABCDC 4 A_Look();
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
			"####" EF 3 A_FaceTarget;
			"####" G 3 A_CustomMeleeAttack(Random(1, 4), "ghost/idle", "", "");
			"####" HF 3 A_FaceTarget;
			Goto See;
		Pain:
			"####" E 2;
			"####" EEE 1 A_Fadeout(0.2);
			"####" F 2 A_Pain;
			Goto See;
		Death:
			"####" G 3 A_ScreamAndUnblock;
			"####" H 3 A_SetTranslucent(0.5);
			"####" IJK 5;
			"####" L 3;
			Stop;
	}
}

class HUW_Ghost4 : HUW_Ghost1
{
	Default
	{
		//$Title Ghost (White)
		Health 350;
		FloatSpeed 4;
		Speed 3;
		HitObituary "$UWGHOST4";
	}

	States
	{
		Spawn:
			UWGW ABCDC 4 A_Look();
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
			"####" EF 3 A_FaceTarget;
			"####" G 3 A_CustomMeleeAttack(Random(1, 4), "ghost/idle", "", "");
			"####" HF 3 A_FaceTarget;
			Goto See;
		Pain:
			"####" E 2;
			"####" EEE 1 A_Fadeout(0.2);
			"####" F 2 A_Pain;
			Goto See;
		Death:
			"####" G 3 A_ScreamAndUnblock;
			"####" H 3 A_SetTranslucent(0.5);
			"####" IJK 5;
			"####" L 3;
			Stop;
	}
}