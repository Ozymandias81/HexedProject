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

class UWWeapSword : AvatarWeapon
{
	Default
	{
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
		RSWR A 1 A_WeaponReady; //UWSwordInit;
		Loop;
	Fire:
		"####" "#" 0 {
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
		LSWR B 6 Offset (5, 40);
		LSWR C 5 Offset (5, 40);
		LSWR D 4 Offset (5, 40);
		LSWR E 3 Offset (5, 40);
		LSWR F 3 Offset (5, 40);
		LSWR G 3 Offset (5, 40) A_UWSwordAttack;
		LSWR H 3 Offset (5, 40);
		LSWR H 6 Offset (5, 80) A_ReFire;
		Goto Ready;
	Fire.Right:
		RSWR B 6 Offset (5, 40);
		RSWR C 5 Offset (5, 40);
		RSWR D 4 Offset (5, 40);
		RSWR E 3 Offset (5, 40);
		RSWR F 3 Offset (5, 40);
		RSWR G 3 Offset (5, 40) A_UWSwordAttack;
		RSWR H 3 Offset (5, 40);
		RSWR H 6 Offset (5, 80) A_ReFire;
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
	// UWSwordInit
	//
	// Check if players uses any kind of attack with distinct states
	//
	//============================================================================
	
	action void A_UWSwordInit() //int flags = 0
	{
		//int buttons = GetPlayerInput(-1, MODINPUT_BUTTONS);
		
		if (!player) return;
		
		//DoReadyWeaponToSwitch(player, !(flags & WRF_NoSwitch));
		//if ((flags & WRF_NoFire) != WRF_NoFire) DoReadyWeaponToFire(player.mo, !(flags & WRF_NoPrimary), !(flags & WRF_NoSecondary));
		//if (!(flags & WRF_NoBob)) DoReadyWeaponToBob(player);

		//player.WeaponState |= GetButtonStateFlags(flags);														
		//DoReadyWeaponDisableSwitch(player, flags & WRF_DisableSwitch);
		
		if (player.cmd.buttons & BT_FORWARD)
		{
			player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("FireFFWD"));
			A_StartSound ("*fistgrunt", CHAN_VOICE);
		}
		
		else if (player.cmd.buttons & BT_MOVELEFT)
		{
			player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("FireLeft"));
			A_StartSound ("*fistgrunt", CHAN_VOICE);
		}
		
		A_WeaponReady();
		
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

		int damage = random[FighterAtk](40, 55);
		for (int i = 0; i < 16; i++)
		{
			if (UWPunch(angle + i*(45./16), damage, 2) ||
				UWPunch(angle - i*(45./16), damage, 2))
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