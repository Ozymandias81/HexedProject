version "4.7.1"

/*
	Shader controller base class

	This allows mappers to control shaders using the GiveInventory/TakeInventory
	ACS functions.

	Do not use this directly! Instead, make an actor class that inherits from
	ShaderControl. Set the ShaderControl.Shader property to the name of the
	shader to control. The shader must be defined in GLDEFS.

	To enable a shader, give 2 of the ShaderControl subclass item to the player.
	For example:

	GiveInventory("ShakeShaderControl", 2);

	To disable a shader, take 1 of the shader control item away so that the
	player only has 1 of said item. For example:

	TakeInventory("ShakeShaderControl", 1);
	or
	SetInventory("ShakeShaderControl", 1);

	Note that the latter requires you to define the SetInventory function in
	your ACS code.
*/

class ShaderControl : Inventory
{
	string ShaderToControl;
	property Shader: ShaderToControl;
	Default
	{
		Inventory.MaxAmount 0x7fffffff;
	}

	virtual ui void SetUniforms(PlayerInfo p, RenderEvent e) {}
}

// Actor that does the bare minumum of ticking
// Use for static, non-interactive actors
//
// Derived from bits and pieces of p_mobj.cpp
class SimpleActor : Actor
{
	Vector2 floorxy;
	Vector3 oldpos;

	override void Tick()
	{
		if (IsFrozen()) { return; }

		Vector2 curfloorxy = (curSector.GetXOffset(sector.floor), curSector.GetYOffset(sector.floor)); // Hacky scroll check because MF8_INSCROLLSEC not externalized to ZScript?
		bool dotick = (curfloorxy != floorxy) || curSector.flags & sector.SECF_PUSH || (pos != oldpos);

		if (dotick) // Only run a full Tick once; or if we are on a carrying floor, pushers are enabled in the sector (wind), or if we moved by some external force
		{
			oldpos = pos;
			Super.Tick();
			floorxy = curfloorxy;
			return;
		}

		if (vel != (0, 0, 0)) // Apply velocity as required
		{
			SetXYZ(Vec3Offset(vel.X, vel.Y, vel.Z)); // Vec3Offset is portal-aware; use instead of just pos + vel, which is not
		}

		// Tick through actor states as normal
		if (tics == -1) { return; }
		else if (--tics <= 0)
		{
			SetState(CurState.NextState);
		}
	}
}

//MAIN
//#include "zscript/base.zs"				//core
#include "zscript/avatar.zs"			//player
#include "zscript/models.zs"

//SCENERY
//#include "zscript/flora.zs"
//#include "zscript/fauna.zs"
#include "zscript/props.zs"

//SFX
#include "zscript/sfx/boids.zs"
#include "zscript/sfx/fisheye.zs"
#include "zscript/sfx/heateffect.zs"
#include "zscript/sfx/smoke.zs"
#include "zscript/sfx/splashes.zs"
#include "zscript/sfx/underwater.zs"

//INTERACTIVES
#include "zscript/interactive/crystal.zs"
#include "zscript/interactive/fountain.zs"

//INVENTORY
#include "zscript/inventory/runes.zs"
#include "zscript/inventory/sapling.zs"
#include "zscript/inventory/torches.zs"

//WEAPONS
#include "zscript/weapons/main.zs"				//actions
#include "zscript/weapons/fists.zs"
#include "zscript/weapons/maces.zs"
#include "zscript/weapons/axes.zs"
#include "zscript/weapons/swords.zs"
//#include "zscript/weapons/others.zs"

//FOES
#include "zscript/critters/easters.zs"
#include "zscript/critters/bats.zs"
#include "zscript/critters/dwarves.zs"
#include "zscript/critters/ghosts.zs"
#include "zscript/critters/imps.zs"
#include "zscript/critters/females_f.zs"
#include "zscript/critters/males_f.zs"
#include "zscript/critters/skeleton.zs"

/*
#include "zscript/critters/demon.zs"
#include "zscript/critters/elementals.zs"
#include "zscript/critters/females_w.zs"
#include "zscript/critters/gazer.zs"
#include "zscript/critters/ghouls.zs"
#include "zscript/critters/golem.zs"
#include "zscript/critters/graygobs.zs"
#include "zscript/critters/grengobs.zs"
#include "zscript/critters/headless.zs"
#include "zscript/critters/lizardmen.zs"
#include "zscript/critters/lurker.zs"
#include "zscript/critters/male_w.zs"
#include "zscript/critters/rats.zs"
#include "zscript/critters/reaper.zs"
#include "zscript/critters/rotworms.zs"
#include "zscript/critters/shadows.zs"
#include "zscript/critters/slugs.zs"
#include "zscript/critters/spiders.zs"
#include "zscript/critters/staff_w.zs"
#include "zscript/critters/trolls.zs"
#include "zscript/critters/tybal.zs"
#include "zscript/critters/wisp.zs"
*/
