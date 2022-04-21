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

/*

7,a_cudgel,mace,16,15,2,20,95,145,6,3,2
8,a_light mace,mace,24,55,15,15,85,175,10,6,4
9,a_mace,mace,32,90,25,9,75,190,16,8,5
14,a_jeweled mace,mace,28,250,255,6,65,220,17,9,5

*/

class UWWeapMace : AvatarWeapon
{
	Default
	{
		//$Title Mace
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
		RMAC I 6 Offset (5, 40);
		RMAC J 5 Offset (5, 40);
		RMAC K 4 Offset (5, 40);
		RMAC L 3 Offset (5, 40);
		RMAC M 3 Offset (5, 40);
		RMAC N 3 Offset (5, 40) A_UWMaceAttack;
		RMAC O 3 Offset (5, 40);
		RMAC O 6 Offset (5, 80) A_ReFire;
		Goto Ready;
	Fire.BBWD:
		RMAC P 6 Offset (5, 40);
		RMAC Q 5 Offset (5, 40);
		RMAC R 4 Offset (5, 40);
		RMAC S 3 Offset (5, 40);
		RMAC T 3 Offset (5, 40);
		RMAC U 3 Offset (5, 40) A_UWMaceAttack;
		RMAC V 3 Offset (5, 40);
		RMAC W 6 Offset (5, 80) A_ReFire;
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
	Spawn:
		UWMC A -1;
		Stop;
	}

	//============================================================================
	//
	// From A_FPunchAttack
	//
	//============================================================================

	action void A_UWMaceAttack()
	{
		if (player == null)
		{
			return;
		}

		int damage = random[AvatarAtk](3, 6); //cudgel base
		for (int i = 0; i < 16; i++)
		{
			if (UWMace(angle + i*(45./16), damage, 2) ||
				UWMace(angle - i*(45./16), damage, 2))
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