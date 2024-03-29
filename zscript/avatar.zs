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

//Specifical counters

//Interactives
class FountainCounter : Inventory { Default { Inventory.MaxAmount 1; } }

//Armors
class ShieldParry: Inventory { Default { Inventory.MaxAmount 30; } }

class AvatarPlayer : PlayerPawn //Consider to include modified "melee" based variants of Hexen classes as 2-3-4 choice, should replace MagePlayer
{
	Default
	{
		Health 100;
		ReactionTime 0;
		PainChance 255;
		Radius 16;
		Height 64;
		Speed 1;
		Scale 0.65;
		+NOSKIN
		+NODAMAGETHRUST
		+PLAYERPAWN.NOTHRUSTWHENINVUL
		PainSound "PlayerMagePain";
		RadiusDamageFactor 0.25;
		Player.JumpZ 9;
		Player.Viewheight 48;
		Player.SpawnClass "Avatar";
		Player.DisplayName "Avatar";
		Player.SoundClass "mage";
		Player.ScoreIcon "MAGEFACE";
		Player.InvulnerabilityMode "Reflective";
		Player.HealRadiusType "Mana";
		Player.Hexenarmor 5, 5, 15, 10, 25;
		Player.StartItem "HUW_WeapFist";
		Player.ForwardMove 0.88, 0.92;
		Player.SideMove 0.875, 0.925;
		Player.Portrait "P_MWALK1";
		//Ranged weapons should work like ProximityGrenades in BoA, instant damage as they hit targets - no conditions for weaps probably
		Player.WeaponSlot 1, "HUW_WeapFist"; 			//Fists & Rocks
		Player.WeaponSlot 2, "HUW_WeapAxe"; 			//Axes & Slings
		Player.WeaponSlot 3, "HUW_WeapMace";			//Maces & Bows
		Player.WeaponSlot 4, "HUW_WeapSword"; 			//Swords (D/S) & Wands
		Player.FlechetteType "ArtiPoisonBag2";			//?
		Player.ColorRange 146, 163;
		Player.Colorset		0, "$TXT_COLOR_BLUE",		146, 163,    161;
		Player.ColorsetFile 1, "$TXT_COLOR_RED",		"TRANTBL7",  0xB3;
		Player.ColorsetFile 2, "$TXT_COLOR_GOLD",		"TRANTBL8",  0x8C;
		Player.ColorsetFile 3, "$TXT_COLOR_DULLGREEN",	"TRANTBL9",  0x41;
		Player.ColorsetFile 4, "$TXT_COLOR_GREEN",		"TRANTBLA",  0xC9;
		Player.ColorsetFile 5, "$TXT_COLOR_GRAY",		"TRANTBLB",  0x30;
		Player.ColorsetFile 6, "$TXT_COLOR_BROWN",		"TRANTBLC",  0x72;
		Player.ColorsetFile 7, "$TXT_COLOR_PURPLE",		"TRANTBLD",  0xEE;
	}

	States
	{
	Spawn:
		MAF3 H -1;
		Stop;
	See:
		MAF3 ABCD 4;
		Loop;
	Missile:
	Melee:
		MAF3 MO 8;
		Goto Spawn;
	Pain:
		MAF3 J 4;
		MAF3 J 4 A_Pain;
		Goto Spawn;
	Death:
		MAF3 J 6;
		MAF3 K 6 A_PlayerScream;
		MAF3 LM 6;
		MAGE N 6 A_NoBlocking;
		MAF3 Q 6;
		MAF3 R -1;
		Stop;		
	XDeath:
		MAGE O 5 A_PlayerScream;
		MAGE P 5;
		MAGE R 5 A_NoBlocking;
		MAGE STUVW 5;
		MAGE X -1;
		Stop;
	Ice:
		MAGE Y 5 A_FreezeDeath;
		MAGE Y 1 A_FreezeDeathChunks;
		Wait;
	Burn:
		FDTH E 5 BRIGHT A_StartSound("*burndeath");
		FDTH F 4 BRIGHT;
		FDTH G 5 BRIGHT;
		FDTH H 4 BRIGHT A_PlayerScream;
		FDTH I 5 BRIGHT;
		FDTH J 4 BRIGHT;
		FDTH K 5 BRIGHT;
		FDTH L 4 BRIGHT;
		FDTH M 5 BRIGHT;
		FDTH N 4 BRIGHT;
		FDTH O 5 BRIGHT;
		FDTH P 4 BRIGHT;
		FDTH Q 5 BRIGHT;
		FDTH R 4 BRIGHT;
		FDTH S 5 BRIGHT A_NoBlocking;
		FDTH T 4 BRIGHT;
		FDTH U 5 BRIGHT;
		FDTH V 4 BRIGHT;
		ACLO E 35 A_CheckPlayerDone;
		Wait;
		ACLO E 8;
		Stop;
	}
	/*
	static void DoShield(Actor mo)
	{
		//if (mo.player && mo.player.ReadyWeapon && AvatarWeapon(mo.player.ReadyWeapon) && mo.player.playerstate == PST_LIVE && !mo.player.FindPSprite(-10))
		//{
			AvatarWeapon wpn = AvatarWeapon(mo.player.ReadyWeapon);

			//if (!wpn) { return; }

			if (wpn) //implement condition later
			{
				if (mo.FindInventory("PowerStrength")) { wpn.modifier = 3.0; } // Strength increases damage by 3 and range by 10
				else { wpn.modifier = 1.0; }

				mo.player.SetPsprite(-10, wpn.FindState("ShieldRaise"), true);
			}
		//}
	}
	*/
}
