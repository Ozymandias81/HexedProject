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

3,a_dagger,sword,8,20,5,30,100,145,2,4,5
4,a_shortsword,sword,16,50,18,20,90,170,3,6,6
5,a_longsword,sword,24,80,28,15,80,190,4,10,8
6,a_broadsword,sword,32,100,34,9,70,205,6,13,10
10,a_shiny sword,sword,34,0,255,11,70,190,7,14,11
12,a_black sword,sword,36,200,255,5,60,200,7,15,12
13,a_jeweled sword,sword,28,250,255,11,70,190,7,14,11

*/

class HUW_WeapSword : AvatarWeapon
{
	Default
	{
		//$Title Sword
		+BLOODSPLATTER
		+WEAPON.MELEEWEAPON
		Obituary "$OB_UWSWORD";
		Tag "$TAG_UWSWORD";
		Weapon.SelectionOrder 2200;
	}

	States
	{
	Select:
		RSWR A 1 A_Raise;
		Loop;
	Deselect:
		RSWR A 1 A_Lower;
		Loop;
	Ready:
		RSWR A 1 A_WeaponReady;
		Loop;
	Fire:
		"####" "#" 0 A_UWWeapInit;
		Goto Ready;
	Fire.Left:
		LSWR B 6 Offset (5, 40);
		LSWR C 5 Offset (5, 40);
		LSWR D 4 Offset (5, 40);
		LSWR E 3 Offset (5, 40);
		LSWR F 3 Offset (5, 40);
		LSWR G 3 Offset (5, 40) A_UWSwordAttack;
		LSWR H 3 Offset (5, 40);
		LSWR H 4 Offset (-25, 80) A_ReFire;
		Goto Ready;
	Fire.Right:
		RSWR B 6 Offset (5, 40);
		RSWR C 5 Offset (5, 40);
		RSWR D 4 Offset (5, 40);
		RSWR E 3 Offset (5, 40);
		RSWR F 3 Offset (5, 40);
		RSWR G 3 Offset (5, 40) A_UWSwordAttack;
		RSWR H 3 Offset (5, 40);
		RSWR H 4 Offset (25, 80) A_ReFire;
		Goto Ready;
	Fire.FFWD:
		RSWR I 6 Offset (5, 40);
		RSWR J 5 Offset (5, 40);
		RSWR K 4 Offset (5, 40);
		RSWR L 3 Offset (5, 40);
		RSWR M 3 Offset (5, 40);
		RSWR N 3 Offset (5, 40) A_UWSwordAttack;
		RSWR O 3 Offset (5, 40);
		RSWR O 6 Offset (5, 80) A_ReFire;
		Goto Ready;
	Fire.BBWD:
		RSWR P 6 Offset (5, 40);
		RSWR Q 5 Offset (5, 40);
		RSWR R 4 Offset (5, 40);
		RSWR S 3 Offset (5, 40);
		RSWR T 3 Offset (5, 40);
		RSWR U 3 Offset (5, 40) A_UWSwordAttack;
		RSWR V 3 Offset (5, 40);
		RSWR W 6 Offset (5, 80) A_ReFire;
		Goto Ready;
	Fire2:
		RSWR CB 5 Offset (5, 40);
		RSWR A 1 Offset (15, 50);
		RSWR A 2 Offset (25, 60);
		RSWR A 1 Offset (35, 70);
		RSWR A 2 Offset (45, 80);
		RSWR A 1 Offset (55, 90);
		RSWR A 2 Offset (65, 100);
		RSWR A 8 Offset (0, 150);
		Goto Ready;
	Spawn:
		UWSW A -1;
		Stop;
	}

	//============================================================================
	//
	// From A_FPunchAttack
	//
	//============================================================================

	action void A_UWSwordAttack()
	{
		if (player == null)
		{
			return;
		}

		int damage = random[AvatarAtk](4, 10); //longsword base
		for (int i = 0; i < 16; i++)
		{
			if (UWSword(angle + i*(45./16), damage, 2) ||
				UWSword(angle - i*(45./16), damage, 2))
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