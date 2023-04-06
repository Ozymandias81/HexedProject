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

//Dummy Item for hiding the HUD
Class CutsceneEnabled : Inventory
{
	States
	{
	Spawn:
		TNT1 A -1;
		Stop;
	}
}

class FountainCounter : Inventory { Default { Inventory.MaxAmount 1; } }

//Defining standalone weapons for Avatar
class AvatarWeapon : Weapon
{
	double modifier;

	Default
	{
		//$Category HexedUW/Weapons
		Weapon.Kickback 150;
		Scale 0.45;
	}
	
	States
	{
		ShieldRaise: //needs to be adjusted for proper behavior yet
			RPCH F 1 Offset(84, 68);
			RPCH F 1 Offset(72, 56);
			RPCH F 1 Offset(56, 40);
			RPCH F 1 Offset(40, 24);
			RPCH F 1 Offset(24, 7);
			RPCH F 1 Offset(6, 2) A_StartSound("knife/swing",CHAN_WEAPON);
			RPCH F 2 Offset(4, 0) A_CustomPunch(int(8 * invoker.modifier), TRUE, CPF_NOTURN, "PunchPuff", invoker.modifier ? 80 : 70);
			RPCH F 1 Offset(6, 2) { bDontBlast = true; }
			RPCH F 1 Offset(24, 7) { bDontBlast = false; }
			RPCH F 1 Offset(36, 20);
			RPCH F 1 Offset(44, 28);
			RPCH F 1 Offset(52, 36);
			RPCH F 1 Offset(60, 44);
			RPCH F 1 Offset(68, 52);
			RPCH F 1 Offset(76, 60);
			RPCH F 1 Offset(82, 66);
			Stop;
	}
	
	//============================================================================
	//
	// From Hexen's Fighter TryPunch
	//
	// Returns true if an actor was punched, false if not, adapt it for HUW
	//
	//============================================================================

	action bool A_UWPunchInit()
	{
		if((GetPlayerInput(INPUT_BUTTONS) & BT_MOVELEFT)) //to be replaced with shield and altattack usage
		{
			player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("Fire.Left"));
			A_StartSound ("*fistgrunt", CHAN_VOICE);
			return true;
		}
		else if((GetPlayerInput(INPUT_BUTTONS) & BT_ATTACK))
		{
			player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("Fire.Right"));
			A_StartSound ("*fistgrunt", CHAN_VOICE);
			return true;
		}
		return false;
	}
	
	action bool A_UWWeapInit()
	{
		if((GetPlayerInput(INPUT_BUTTONS) & BT_MOVELEFT))
		{
			player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("Fire.Left"));
			A_StartSound ("*fistgrunt", CHAN_VOICE);
			return true;
		}
		else if((GetPlayerInput(INPUT_BUTTONS) & BT_MOVERIGHT))
		{
			player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("Fire.Right"));
			A_StartSound ("*fistgrunt", CHAN_VOICE);
			return true;
		}
		else if((GetPlayerInput(INPUT_BUTTONS) & BT_BACK))
		{
			player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("Fire.BBWD"));
			A_StartSound ("*fistgrunt", CHAN_VOICE);
			return true;
		}
		else if((GetPlayerInput(INPUT_BUTTONS) & BT_FORWARD))
		{
			player.SetPsprite(PSP_WEAPON, player.ReadyWeapon.FindState("Fire.FFWD"));
			A_StartSound ("*fistgrunt", CHAN_VOICE);
			return true;
		}
		return false;
	}

	action bool UWPunch(double angle, int damage, int power)
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
	
	action bool UWAxe(double angle, int damage, int power)
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
	
	action bool UWMace(double angle, int damage, int power)
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
	
	action bool UWSword(double angle, int damage, int power)
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
}