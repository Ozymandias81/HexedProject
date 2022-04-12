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

class UWWeapMace : AvatarWeapon
{
	Default
	{
		+BLOODSPLATTER
		+WEAPON.MELEEWEAPON
		Obituary "$OB_UWMACE";
		Tag "$TAG_UWMACE";
		Weapon.SelectionOrder 2600;
	}

	States
	{
	Select:
		RMAC A 1 A_Raise;
		Loop;
	Deselect:
		RMAC A 1 A_Lower;
		Loop;
	Ready:
		RMAC A 1 A_WeaponReady;
		Loop;
	Fire:
		RMAC A 0 {
					if((GetPlayerInput(INPUT_BUTTONS) & BT_MOVELEFT))
					{
						player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("Fire.Left"));
						A_StartSound ("*fistgrunt", CHAN_VOICE);
					}
					else if((GetPlayerInput(INPUT_BUTTONS) & BT_MOVERIGHT))
					{
						player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("Fire.Right"));
						A_StartSound ("*fistgrunt", CHAN_VOICE);
					}
					else if((GetPlayerInput(INPUT_BUTTONS) & BT_BACK))
					{
						player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("Fire.BBWD"));
						A_StartSound ("*fistgrunt", CHAN_VOICE);
					}
					else if((GetPlayerInput(INPUT_BUTTONS) & BT_FORWARD))
					{
						player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("Fire.FFWD"));
						A_StartSound ("*fistgrunt", CHAN_VOICE);
					}
					return;
				}
		Goto Ready;
	Fire.Left:
		LMAC B 6 Offset (5, 40);
		LMAC C 5 Offset (5, 40);
		LMAC D 4 Offset (5, 40);
		LMAC E 3 Offset (5, 40);
		LMAC F 3 Offset (5, 40);
		LMAC G 3 Offset (5, 40) A_UWMaceAttack;
		LMAC H 3 Offset (5, 40);
		LMAC H 6 Offset (5, 80) A_ReFire;
		Goto Ready;
	Fire.Right:
		RMAC B 6 Offset (5, 40);
		RMAC C 5 Offset (5, 40);
		RMAC D 4 Offset (5, 40);
		RMAC E 3 Offset (5, 40);
		RMAC F 3 Offset (5, 40);
		RMAC G 3 Offset (5, 40) A_UWMaceAttack;
		RMAC H 3 Offset (5, 40);
		RMAC H 6 Offset (5, 80) A_ReFire;
		Goto Ready;
	Fire.FFWD:
		RMAC L 6 Offset (5, 40);
		RMAC M 5 Offset (5, 40);
		RMAC N 4 Offset (5, 40);
		RMAC O 3 Offset (5, 40);
		RMAC P 3 Offset (5, 40);
		RMAC Q 3 Offset (5, 40) A_UWMaceAttack;
		RMAC R 3 Offset (5, 40);
		RMAC R 6 Offset (5, 80) A_ReFire;
		Goto Ready;
	Fire.BBWD:
		RMAC T 6 Offset (5, 40);
		RMAC U 5 Offset (5, 40);
		RMAC V 4 Offset (5, 40);
		RMAC W 3 Offset (5, 40);
		RMAC X 3 Offset (5, 40);
		RMAC Y 3 Offset (5, 40) A_UWMaceAttack;
		RMAC Z 3 Offset (5, 40);
		RMAC Z 6 Offset (5, 80) A_ReFire;
		Goto Ready;
	Fire2:
		RMAC CB 5 Offset (5, 40);
		RMAC A 1 Offset (15, 50);
		RMAC A 2 Offset (25, 60);
		RMAC A 1 Offset (35, 70);
		RMAC A 2 Offset (45, 80);
		RMAC A 1 Offset (55, 90);
		RMAC A 2 Offset (65, 100);
		RMAC A 8 Offset (0, 150);
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
	// A_FMaceAttack
	//
	//============================================================================

	action void A_UWMaceAttack()
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