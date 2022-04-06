/*
 * Copyright (c) 2022 Ozymandias81
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
*/

class UWWeapAxe : AvatarWeapon
{
	Default
	{
		+BLOODSPLATTER
		+WEAPON.MELEEWEAPON
		Obituary "$OB_UWAXE";
		Tag "$TAG_UWAXE";
		Weapon.SelectionOrder 3000;
	}

	States
	{
	Select:
		RAXE A 1 A_Raise;
		Loop;
	Deselect:
		RAXE A 1 A_Lower;
		Loop;
	Ready:
		RAXE A 1 A_WeaponReady;
		Loop;
	Fire:
		RAXE B 8 Offset (5, 40);
		RAXE C 7 Offset (5, 40);
		RAXE D 7 Offset (5, 40) A_UWPunchAttack;
		RAXE C 7 Offset (5, 40);
		RAXE B 8 Offset (5, 40) A_ReFire;
		Goto Ready;
	Fire2:
		RAXE DE 7 Offset (5, 40);
		RAXE E 1 Offset (15, 50);
		RAXE E 2 Offset (25, 60);
		RAXE E 1 Offset (35, 70);
		RAXE E 2 Offset (45, 80);
		RAXE E 1 Offset (55, 90);
		RAXE E 2 Offset (65, 100);
		RAXE E 10 Offset (0, 150);
		Goto Ready;
	}
	
	//============================================================================
	//
	// TryPunch
	//
	// Returns true if an actor was punched, false if not.
	//
	//============================================================================

	private action bool TryPunch(double angle, int damage, int power)
	{
		Class<Actor> pufftype;
		FTranslatedLineTarget t;

		double slope = AimLineAttack (angle, 2*DEFMELEERANGE, t, 0., ALF_CHECK3D);
		if (t.linetarget != null)
		{
			if (++weaponspecial >= 3)
			{
				damage <<= 1;
				power *= 3;
				pufftype = "HammerPuff";
			}
			else
			{
				pufftype = "PunchPuff";
			}
			LineAttack (angle, 2*DEFMELEERANGE, slope, damage, 'Melee', pufftype, true, t);
			if (t.linetarget != null)
			{
				// The mass threshold has been changed to CommanderKeen's value which has been used most often for 'unmovable' stuff.
				if (t.linetarget.player != null || 
					(t.linetarget.Mass < 10000000 && (t.linetarget.bIsMonster)))
				{
					if (!t.linetarget.bDontThrust)
						t.linetarget.Thrust(power, t.attackAngleFromSource);
				}
				AdjustPlayerAngle(t);
				return true;
			}
		}
		return false;
	}

	//============================================================================
	//
	// A_FPunchAttack
	//
	//============================================================================

	action void A_UWPunchAttack()
	{
		if (player == null)
		{
			return;
		}

		int damage = random[FighterAtk](40, 55);
		for (int i = 0; i < 16; i++)
		{
			if (TryPunch(angle + i*(45./16), damage, 2) ||
				TryPunch(angle - i*(45./16), damage, 2))
			{ // hit something
				if (weaponspecial >= 3)
				{
					weaponspecial = 0;
					player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("Fire2"));
					A_StartSound ("*fistgrunt", CHAN_VOICE);
				}
				return;
			}
		}
		// didn't find any creatures, so try to strike any walls
		weaponspecial = 0;

		double slope = AimLineAttack (angle, DEFMELEERANGE, null, 0., ALF_CHECK3D);
		LineAttack (angle, DEFMELEERANGE, slope, damage, 'Melee', "PunchPuff", true);
	}
	
}