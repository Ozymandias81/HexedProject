/*
 * Copyright (c) 2018-2020 AFADoomer ; 2022 Ozymandias81
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
// Torch
//
//===========================================================================

class UWLanternOil : Inventory
{
	Default
	{
		Inventory.Amount 1;
		Inventory.MaxAmount 12000; //Near 5 mins maximum - ozy81
	}
}

class UWOilPickup : CustomInventory
{
	Default
	{
		//$Category HexedUW/Inventory
		//$Title Lantern Oil
		Scale 0.35;
		-INVENTORY.INVBAR
		Inventory.MaxAmount 12; //1000x12=12000
		Inventory.PickupMessage "$OILPICK";
		Inventory.PickupSound "misc/ammo_pkup";
	}
	States
	{
	Spawn:
		LANT C -1;
		Loop;
	Pickup:
		TNT1 A 0 A_GiveInventory("UWLanternOil", 1000);
		Stop;
	}
}

class PoweredInventory : Inventory
{
	bool active;
	Class<Inventory> fuelclass;
	int fuelgiveamt;

	Property Fuel:fuelclass;
	Property FuelGiveAmt:fuelgiveamt;

	override void Tick()
	{
		if (IsFrozen()) { return; }

		if (owner && active)
		{
			if (owner.FindInventory(fuelclass)) { owner.TakeInventory(fuelclass, 1); }
			else { active = false; }
		}
	}

	override bool Use (bool pickup)
	{
		if (!owner) { return false; }

		active = !active;

		if (active && !owner.FindInventory(fuelclass)) { active = false; }

		return false;
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

class UWLanternPickup : PoweredInventory
{
	int ticcount;

	Default
	{
		//$Category HexedUW/Inventory
		//$Title Useable Lantern (requires Oil)
		//$Color 6
		Scale 0.45;
		Tag "$TAGLANTR";
		Inventory.Icon "LANTB0";
		Inventory.PickupMessage "$LANTERN";
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
			LANT A -1;
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
					A_StartSound("flamer/steam", CHAN_AUTO, 0, Random(15, 45));
					active = false;
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