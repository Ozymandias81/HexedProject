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

//===========================================================================
//
// Silver Sapling
//
//===========================================================================

class HUW_SilverSapling : CustomInventory
{
	Default
	{
		//$Category HexedUW/Inventory
		//$Title Silver Sapling
		//$Color 6
		Scale 0.45;
		Tag "$UWTAGSAPL";
		Inventory.PickupMessage "$UWSSEED";
		Inventory.MaxAmount 1;
		Inventory.PickupSound "misc/gadget_pickup";
		-INVENTORY.INVBAR
		+INVENTORY.ALWAYSPICKUP
	}

	States
	{
		Spawn:
			SAPL ABCDD 8;
			Loop;
		Pickup:
			TNT1 A 0 A_GiveInventory("HUW_SilverSeed", 1);
			Stop;
	}

}

//===========================================================================
//
// Silver Seed
//
//===========================================================================

class HUW_SilverSeed : ArtiTeleport
{
	Default
	{
		Tag "$UWTAGSEED";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.Icon "SAPLE0";
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
	}
	
	States
	{
	Spawn:
		SAPL E -1;
		Loop;
	//Add some Use custom state here, related to placeable seed --ozy81
	}
}