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

// 15,a_fist,unarmed,0,0,255,15,90,140,4,2,3

class HUW_WeapFist : AvatarWeapon
{
	Default
	{
		+BLOODSPLATTER
		+WEAPON.MELEEWEAPON
		Obituary "$OB_UWFIST";
		Tag "$TAG_UWFIST";
		Weapon.SelectionOrder 3400;
	}

	States
	{
	Select:
		RPCH E 1 A_Raise;
		Loop;
	Deselect:
		RPCH E 1 A_Lower;
		Loop;
	Ready:
		RPCH E 1 A_WeaponReady;
		Loop;
	Fire:
		RPCH D 8 Offset (5, 40);
		RPCH C 7 Offset (5, 40);
		RPCH B 7 Offset (5, 40) A_UWPunchAttack;
		RPCH C 7 Offset (5, 40);
		RPCH D 8 Offset (5, 40) A_ReFire;
		Goto Ready;
	Fire.Powered:
		RPCH DE 7 Offset (5, 40);
		RPCH E 1 Offset (15, 50);
		RPCH E 2 Offset (25, 60);
		RPCH E 1 Offset (35, 70);
		RPCH E 2 Offset (45, 80);
		RPCH E 1 Offset (55, 90);
		RPCH E 2 Offset (65, 100);
		RPCH E 10 Offset (0, 150);
		Goto Ready;
	}

	//============================================================================
	//
	// From A_FPunchAttack
	//
	//============================================================================

	action void A_UWPunchAttack()
	{
		if (player == null)
		{
			return;
		}

		int damage = random[AvatarAtk](2, 4);
		for (int i = 0; i < 16; i++)
		{
			if (UWPunch(angle + i*(45./16), damage, 2) ||
				UWPunch(angle - i*(45./16), damage, 2))
			{ // hit something
				if (weaponspecial >= 3)
				{
					weaponspecial = 0;
					player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("Fire.Powered"));
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