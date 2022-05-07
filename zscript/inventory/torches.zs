/*
 * Copyright (c) 2018-2020 AFADoomer ; 2022 Sir Robin, Ozymandias81
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

//===========================================================================
//
// Base Classes
//
//===========================================================================

class PoweredInventory : Inventory
{
	bool active;
	Class<Inventory> fuelclass;
	int fuelgiveamt;
	string IconActive;
	string IconInactive;

	Property Fuel:fuelclass;
	Property FuelGiveAmt:fuelgiveamt;
	Property IconActive:IconActive;
	Property IconInactive:IconInactive;
	
	int ticcount;

	override void Tick()
	{
		if (IsFrozen()) { return; }

		if (owner && active)
		{
			if (owner.FindInventory(fuelclass)) { owner.TakeInventory(fuelclass, 1); }
			else { MakeInactive(); }
		}
	}

	override bool Use (bool pickup)
	{
		if (!owner) { return false; }
		if (active) { MakeInactive(); } else { MakeActive(); }
		if (active && !owner.FindInventory(fuelclass)) { MakeInactive(); }
		return false;
	}

	void MakeActive()
	{
		active=true;
		Icon=TexMan.CheckForTexture(IconActive,TexMan.TYPE_Any);
	}

	void MakeInactive()
	{
		active=false;
		Icon=TexMan.CheckForTexture(IconInactive,TexMan.TYPE_Any);
	}

	// This only gets called after you've picked up the item once...  
	// On first pickup, the Inventory class HandlePickup returns true and this is never called.
	override bool HandlePickup(Inventory item)
	{
		if (item.GetClass() == GetClass())
		{
			// If the player already has the item, but isn't at max fuel, add fuel here (and pick up the item)
			let fuel = owner.FindInventory(fuelclass);
			if (!fuel) { fuel = owner.GiveInventoryType(fuelclass); fuel.Amount = 0; }

			if (fuel && fuel.Amount < fuel.MaxAmount)
			{
				fuel.Amount += fuelgiveamt;

				if (fuel.Amount > fuel.MaxAmount && !sv_unlimited_pickup)
				{
					fuel.Amount = fuel.MaxAmount;
				}

				item.bPickupGood = true;
			}

			return true;
		}
		return false;
	}

	override bool TryPickup(in out Actor toucher)
	{
		// If this is the first pickup of the item, also add fuel to the player's inventory
		if (!toucher.FindInventory(GetClass())) { toucher.A_GiveInventory(fuelclass, fuelgiveamt); }
		return Super.TryPickup(toucher);
	}
}

//===========================================================================
//
// Torch & Candle
//
//===========================================================================

class UWFlammable : Inventory
{
	Default
	{
		Inventory.Amount 1;
		Inventory.MaxAmount 12000; //Near 5 mins maximum - ozy81
	}
}

class UWFlammable2 : UWFlammable
{
	Default
	{
		Inventory.Amount 1;
		Inventory.MaxAmount 6000; //Near 2,5 mins maximum - ozy81
	}
}

class UWFlammable3 : UWFlammable
{
	Default
	{
		Inventory.Amount 1;
		Inventory.MaxAmount 8000; //Near 3 mins maximum - ozy81
	}
}

class HUW_TorchPickup : PoweredInventory
{
	Default
	{
		//$Category HexedUW/Inventory
		//$Title Useable Torch
		//$Color 6
		Scale 0.45;
		Tag "$UWTAGTORC";
		Inventory.Icon "UWTOA0";
		PoweredInventory.IconActive "UWTOB0";
		PoweredInventory.IconInactive "UWTOA0";
		Inventory.PickupMessage "$UWTORPICK";
		Inventory.MaxAmount 1;
		Inventory.PickupSound "misc/gadget_pickup";
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		PoweredInventory.Fuel "UWFlammable";
		PoweredInventory.FuelGiveAmt 1000;
	}

	States
	{
		Spawn:
			UWTO A -1;
			Stop;
	}

	override void Tick()
	{
		if (owner)
		{
			if (active)
			{
				if (owner.waterlevel >= 3) // Extinguish if the player goes underwater
				{
					A_StartSound("flames/steam", CHAN_AUTO, 0, Random(10, 25));
					MakeInactive();
				}
				else
				{
					if (ticcount > 4) { owner.A_AttachLightDef("TorchFlicker", "LANT04"); }
					else if (ticcount > 0) { owner.A_AttachLightDef("TorchFlicker", "LANT05"); }
					else { owner.A_AttachLightDef("TorchFlicker", "LANT06"); }
					if (ticcount) { ticcount = max(0, ticcount - 1); }
				}
			}
			else
			{
				owner.A_RemoveLight("TorchFlicker");
			}
		}

		if (IsFrozen()) { return; }

		Super.Tick();
	}

	override bool Use(bool pickup)
	{
		bool ret = Super.Use(pickup);
		if (active) { ticcount = 8; }
		return ret;
	}
}

class HUW_Candle1Pickup : PoweredInventory
{
	Default
	{
		//$Category HexedUW/Inventory
		//$Title Useable Candle
		//$Color 6
		Scale 0.45;
		Tag "$UWTAGCAND";
		Inventory.Icon "UWCNA0";
		PoweredInventory.IconActive "UWCNB0";
		PoweredInventory.IconInactive "UWCNA0";
		Inventory.PickupMessage "$UWCANPICK";
		Inventory.MaxAmount 1;
		Inventory.PickupSound "misc/gadget_pickup";
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		PoweredInventory.Fuel "UWFlammable2";
		PoweredInventory.FuelGiveAmt 1000;
	}

	States
	{
		Spawn:
			UWCN A -1;
			Stop;
	}

	override void Tick()
	{
		if (owner)
		{
			if (active)
			{
				if (owner.waterlevel >= 3) // Extinguish if the player goes underwater
				{
					A_StartSound("flames/steam", CHAN_AUTO, 0, Random(10, 15));
					MakeInactive();
				}
				else
				{
					if (ticcount > 4) { owner.A_AttachLightDef("CandleFlicker", "LANT07"); }
					else if (ticcount > 0) { owner.A_AttachLightDef("CandleFlicker", "LANT08"); }
					else { owner.A_AttachLightDef("CandleFlicker", "LANT09"); }
					if (ticcount) { ticcount = max(0, ticcount - 1); }
				}
			}
			else
			{
				owner.A_RemoveLight("CandleFlicker");
			}
		}

		if (IsFrozen()) { return; }

		Super.Tick();
	}

	override bool Use(bool pickup)
	{
		bool ret = Super.Use(pickup);
		if (active) { ticcount = 8; }
		return ret;
	}
}

class HUW_Candle2Pickup : PoweredInventory
{
	Default
	{
		//$Category HexedUW/Inventory
		//$Title Useable Taper
		//$Color 6
		Scale 0.45;
		Tag "$UWTAGCAND";
		Inventory.Icon "UWCNC0";
		PoweredInventory.IconActive "UWCND0";
		PoweredInventory.IconInactive "UWCNC0";
		Inventory.PickupMessage "$UWCANPICK";
		Inventory.MaxAmount 1;
		Inventory.PickupSound "misc/gadget_pickup";
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		PoweredInventory.Fuel "UWFlammable3";
		PoweredInventory.FuelGiveAmt 1000;
	}

	States
	{
		Spawn:
			UWCN C -1;
			Stop;
	}

	override void Tick()
	{
		if (owner)
		{
			if (active)
			{
				if (owner.waterlevel >= 3) // Extinguish if the player goes underwater
				{
					A_StartSound("flames/steam", CHAN_AUTO, 0, Random(10, 15));
					MakeInactive();
				}
				else
				{
					if (ticcount > 4) { owner.A_AttachLightDef("BigCandleFlicker", "LANT06"); }
					else if (ticcount > 0) { owner.A_AttachLightDef("BigCandleFlicker", "LANT07"); }
					else { owner.A_AttachLightDef("BigCandleFlicker", "LANT08"); }
					if (ticcount) { ticcount = max(0, ticcount - 1); }
				}
			}
			else
			{
				owner.A_RemoveLight("BigCandleFlicker");
			}
		}

		if (IsFrozen()) { return; }

		Super.Tick();
	}

	override bool Use(bool pickup)
	{
		bool ret = Super.Use(pickup);
		if (active) { ticcount = 8; }
		return ret;
	}
}

//===========================================================================
//
// Lantern
//
//===========================================================================

class UWLanternOil : Inventory
{
	Default
	{
		Inventory.Amount 1;
		Inventory.MaxAmount 24000; //Near 10 mins maximum - ozy81
	}
}

class HUW_OilPickup : CustomInventory
{
	Default
	{
		//$Category HexedUW/Inventory
		//$Title Lantern Oil
		Tag "$UWTAGOILT";
		Scale 0.35;
		-INVENTORY.INVBAR
		Inventory.MaxAmount 24; //1000x24=24000
		Inventory.PickupMessage "$UWOILPICK";
		Inventory.PickupSound "misc/ammo_pkup";
	}
	
	States
	{
		Spawn:
			UWLT C -1;
			Loop;
		Pickup:
			TNT1 A 0 A_GiveInventory("UWLanternOil", 1000);
			Stop;
	}
}

class HUW_LanternPickup : PoweredInventory
{
	Default
	{
		//$Category HexedUW/Inventory
		//$Title Useable Lantern (requires Oil)
		//$Color 6
		Scale 0.45;
		Tag "$UWTAGLANT";
		Inventory.Icon "UWLTA0";
		PoweredInventory.IconActive "UWLTB0";
		PoweredInventory.IconInactive "UWLTA0";
		Inventory.PickupMessage "$UWLANPICK";
		Inventory.MaxAmount 1;
		Inventory.PickupSound "misc/gadget_pickup";
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		PoweredInventory.Fuel "UWLanternOil";
		PoweredInventory.FuelGiveAmt 1000;
	}

	States
	{
		Spawn:
			UWLT A -1;
			Stop;
	}

	override void Tick()
	{
		if (owner)
		{
			if (active)
			{
				if (owner.waterlevel >= 3) // Extinguish if the player goes underwater
				{
					A_StartSound("flames/steam", CHAN_AUTO, 0, Random(15, 45));
					MakeInactive();
				}
				else
				{
					if (ticcount > 4) { owner.A_AttachLightDef("LanternFlicker", "LANT01"); }
					else if (ticcount > 0) { owner.A_AttachLightDef("LanternFlicker", "LANT02"); }
					else { owner.A_AttachLightDef("LanternFlicker", "LANT03"); }
					if (ticcount) { ticcount = max(0, ticcount - 1); }
				}
			}
			else
			{
				owner.A_RemoveLight("LanternFlicker");
			}
		}

		if (IsFrozen()) { return; }

		Super.Tick();
	}

	override bool Use(bool pickup)
	{
		bool ret = Super.Use(pickup);
		if (active) { ticcount = 8; }
		return ret;
	}
}