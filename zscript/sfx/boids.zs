/*
 * Copyright (c) 2022-2023 4Page, Enjay
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

Class BoidArrayHandler : EventHandler
{
	// do a thing every 10 seconds
	int seconds;// = 10;
	Array<actor> Boids;
	override void WorldThingSpawned (WorldEvent e)
	{
		if(e.thing && e.thing is "BOID_Boid")
		{
			Boids.Push(e.thing);
		}
	}
	override void WorldTick()
	{
		if (Level.maptime % (Thinker.TICRATE * 10) == 0) 
		{
			Boids.clear();
			let BoidFinder = ThinkerIterator.Create("BOID_Boid");
			BOID_Boid boid;
			while (true)
			{
				boid = BOID_Boid(BoidFinder.next());
				if (boid == NULL) { break; }
				Boids.Push(boid);
			}
		}
	}
}

Struct BOID_BoidArray
{
	Vector3 RandomMove[15];
	Array<int> FindNew;
}

//This class has a lot of functions that you can use outside of the BoidFlight function
//BoidFlight has to be used every tick for best results so tick override is recommended.

Class BOID_Boid : Actor
{
	Double VelocityMax;
	BOID_BoidArray BoidArray;
	Vector3 Beacon;
	int8 BeaconCounter;
	Bool CloseToMaster;
	Bool CloseToTarget;
	Int CanSeeTarget;
	Int CloseToGround;
	Bool ByGround;
	
	Class<Actor> BoidActor;
	double MaxVelocity;
	double VelocityAcceleration;
	double WallDetectionDistance;
	double DistanceFromMaster;
	double DistanceFromTarget;
	double MinDistanceToBoid;
	double MaxDistanceToBoid;
	double BoidCohesion;
	double MinDistanceBeacon;
	double MaxDistanceBeacon;
	double MaxAngleBeacon;
	double MaxRandomMoveAngle;
	double HorizonNormalizer;
	double VectorTurn;
	Bool PreferTarget;
	uint8 FlockID;
	
	Property BoidActor : BoidActor;
	Property MaxVelocity : MaxVelocity;
	Property VelocityAcceleration : VelocityAcceleration;
	Property WallDetectionDistance : WallDetectionDistance;
	Property DistanceFromMaster : DistanceFromMaster;
	Property DistanceFromTarget : DistanceFromTarget;
	Property MinDistanceToBoid : MinDistanceToBoid;
	Property MaxDistanceToBoid : MaxDistanceToBoid;
	Property BoidCohesion : BoidCohesion;
	Property MinDistanceBeacon : MinDistanceBeacon;
	Property MaxDistanceBeacon : MaxDistanceBeacon;
	Property MaxAngleBeacon : MaxAngleBeacon;
	Property MaxRandomMoveAngle : MaxRandomMoveAngle;
	Property HorizonNormalizer  : HorizonNormalizer;
	Property PreferTarget : PreferTarget;
	Property VectorTurn : VectorTurn;
	Property FlockID : FlockID;
	Default
	{
		Health 30;
		-COUNTKILL;
		+THRUSPECIES;
		+NOGRAVITY;
		+NOBLOCKMONST;
		+NOFRICTION;
		Speed 0.1;
		Radius 10;
		BOID_Boid.BoidActor "BOID_Boid";
		BOID_Boid.MaxVelocity 20;
		BOID_Boid.VelocityAcceleration .2;
		BOID_Boid.WallDetectionDistance 6;
		BOID_Boid.DistanceFromMaster 400;
		BOID_Boid.DistanceFromTarget 400;
		BOID_Boid.MinDistanceToBoid 150;
		BOID_Boid.MaxDistanceToBoid 900;
		BOID_Boid.BoidCohesion 3;
		BOID_Boid.MinDistanceBeacon 100;
		BOID_Boid.MaxDistanceBeacon 300;
		BOID_Boid.MaxAngleBeacon 100;
		BOID_Boid.MaxRandomMoveAngle 120;
		BOID_Boid.HorizonNormalizer  1;
		BOID_Boid.PreferTarget;
		BOID_Boid.VectorTurn .6;
		BOID_Boid.FlockID 0;
	}
	
	States //to be removed
	{
	Spawn:
		SBAT ABCB 3;
		Loop;
	Death:
		FAXB FGHIJK 2;
		Stop;
	}

////////////////////////////////////////////////////////////////////////////////
//I found this black magic online, so don't ask me how it works. It just does.//
////////////////////////////////////////////////////////////////////////////////

	// Utility function that puts all
	// non-positive (0 and negative)
	// numbers on left side of arr[]
	// and return count of such numbers
	int segregate(out BOID_BoidArray BoidArray, int size)
	{
		int j = 0;
		int i;
		for (i = 0; i < size; i++) 
		{
			if (BoidArray.FindNew[i] <= 0) 
			{
				int temp;
				temp = BoidArray.FindNew[i];
				BoidArray.FindNew[i] = BoidArray.FindNew[j];
				BoidArray.FindNew[j] = temp;
  
				// increment count of non-positive
				// integers
				j++;
			}
		}
  
		return j;
	}
		  
	// Find the smallest positive missing
	// number in an array that contains
	// all positive integers
	int findMissingPositive(out BOID_BoidArray BoidArray, int size, int Start)
	{
		int i = Start;
		// Mark arr[i] as visited by making
		// arr[arr[i] - 1] negative. Note that
		// 1 is subtracted as index start from
		// 0 and positive numbers start from 1
		for (i; i < size; i++) 
		{
			if (Abs(BoidArray.FindNew[i]) - 1 < size && BoidArray.FindNew[ Abs(BoidArray.FindNew[i]) - 1] > 0)
			{
				BoidArray.FindNew[ Abs(BoidArray.FindNew[i]) - 1] = -BoidArray.FindNew[ Abs(BoidArray.FindNew[i]) - 1];
			}
		}
  
		// Return the first index value at
		// which is positive
		for (i = 0; i < size; i++)
		{
			if (BoidArray.FindNew[i] > 0)
			{
				return i + 1;
			}
		}
		return size + 1;
	}
	
////////////////////////////////////////////////////////////////////////////////
//								END OF BLACK MAGIC							  //
////////////////////////////////////////////////////////////////////////////////

	void NewFlockID()	//Really only useful for spawners.  Will give itself a new unused FlockID.
	{	
		let BoidFinder = ThinkerIterator.Create("BOID_Boid", STAT_DEFAULT);
		BOID_Boid boid;
		while (true)
		{
			boid = BOID_Boid(BoidFinder.next());
			if (boid == NULL || boid == self) { break; }
			Bool InArray;
			for(int i=0; i<BoidArray.FindNew.size(); i++)
			{
				if(boid.FlockID == BoidArray.FindNew[i])
				{
					InArray = TRUE;
					break;
				}
			}
			if(!InArray)
			{
				BoidArray.FindNew.Push(boid.FlockID);
			}
		}
		int size = BoidArray.FindNew.size();
		int shift = segregate(BoidArray, size);
		FlockID = findMissingPositive(BoidArray, size, Shift);
		BoidArray.FindNew.Clear();
		Return;
	}
	
	
	//Use this when a spawner spawns boids.  Call from the spawned actor.
	void GetMasterFlockID()	//Will get its master's FlockID.
	{
		if(!master || !(master is "BOID_Boid"))
		{
			Return;
		}
		else
		{
			FlockID = BOID_boid(master).FlockID;
		}
	}
	
//	You can put whatever you want in here that you want to happen only once as soon as it spawns.  Great for setting values.
	Override void PostBeginPlay()
	{	
		Super.PostBeginPlay();
	}
	
//	This function turns a vector to be relative to the actor's own coordinate system where X is its velocity vector
	Action Vector3 RelativeLocalCoords(vector3 RelVec)
	{
		Vector3 RelLocal;
		Vector3 UnitVel;
		if(vel.length() > 0) 
		{
			UnitVel = vel.unit();
		}
		else	//If it's not moving it uses its angle and pitch instead.
		{
			UnitVel = (Cos(angle)*Cos(pitch),Sin(angle)*Cos(pitch), -Sin(pitch));
		}
		Double VelPitch = ASin(UnitVel.z);	//The pitch of the velocity vector
		Double VelAngle = ATan2(UnitVel.Y,UnitVel.X);	//The angle of the velocity vector
		Vector3 RelYCoord = (Cos(VelAngle-90),Sin(VelAngle-90),0);	//A vector pointing to the actor's side
		Vector3 RelZCoord = (Cos(VelPitch+90)*Cos(VelAngle),Cos(VelPitch+90)*Sin(VelAngle),Sin(VelPitch+90)); //A vector pointing to the actor's 'up'
		RelLocal = Unitvel*RelVec.x + RelYCoord*RelVec.y + RelZCoord*RelVec.z;
		Return RelLocal;
	}
	
// 	This function creates a vector from two given angles.  
//	Pivot is the angle from the X vector toward the Y vector.
//	Roll is the angle from the Y vector to the Z vector.  
//	So use this to make a cone with an angle equal to Pivot.  Best used in conjunction with RelativeLocalCoords()
	Action Vector3 PivotRoll(Double Pivot, double Roll)
	{
		Vector3 PRVec = (Cos(Pivot), Sin(Pivot)*Cos(Roll), Sin(Roll)*Sin(Pivot));
		Return PRVec.unit();
	}
	
//	This moves elements of an array from a BOID_BoidArray struct down one position, and adds a value to the beginning
	Action void ShiftArray(Vector3 AddTo, out BOID_BoidArray BoidArray)
	{
		for(int i=BoidArray.RandomMove.Size()-1; i>0; i--)
		{
			BoidArray.RandomMove[i] = BoidArray.RandomMove[i-1];
		}
		BoidArray.RandomMove[0] = AddTo;
	}
	
//	This makes making a sphere a lot easier and will space the points out more evenly.
//	Returns a unit vector of a point CurrentPoint on a sphere from 0 to TotalPoints, where 0 is positive on the X axis and Total Points is directly negative on the X axis
//	and all points in between are evenly spaced on a sphere.  Runs it through RelativeLocalCoords() at the end, so point 0 is along the actors velocity vector.
	Action vector3 FibSphereDirection(int CurrentPoint = 0, int TotalPoints = 100)
	{
		double GoldenAngle = 137.5077640500;	//the golden angle
		double Theta = asin(-1.0 + 2.0 * (CurrentPoint%TotalPoints) / (TotalPoints+1));
		double Phi = GoldenAngle * CurrentPoint;
		Vector3 Thing = (Sin(-Theta), cos(-Theta)*sin(Phi), Cos(-Theta)*Cos(Phi));
		Thing = Thing.unit();
		Return RelativeLocalCoords(Thing);
	}
	
//	Returns the angle between two vectors.  Not the GZDoom world angle, which is the angle rotating around the Z axis, 
//	but rather the absolute angle between the vectors.
	Action double VecAngleToVec(Vector3 FirstVec, Vector3 SecondVec)
	{
		if(FirstVec.length() == 0 || SecondVec.length() == 0)
		{
			Return 0;
		}
		double VecAngle = Acos(min(FirstVec.unit() dot SecondVec.unit(), .99999999999));
		Return VecAngle;
	}
	
//	Will rotate a vector toward another vector by a given angle.  If the given angle is greater than the angle between the vectors
//	then it will rotate past the vector.  A negative angle will rotate it away.
	Action Vector3 TurnTowardVec(Vector3 FromVec, Vector3 ToVec, double TurnAngle = 0)
	{
		if(FromVec.Length() == 0 || ToVec.Length() == 0)
		{
			Return FromVec;
		}
		vector3 crossprod = ToVec.unit() cross FromVec.unit();
		vector3 right = crossprod.unit() cross FromVec.unit();
		vector3 RotatedVec = right*sin(-TurnAngle) + FromVec.unit()*cos(-TurnAngle);
		FromVec = FromVec.length() * RotatedVec.unit();
		Return FromVec;
	}
	
//	The main function.  You can run this function with changed arguments according to your need.  
//	The properties will be used if the default arguments aren't changed unless UsePropertyValues is FALSE.
	Action Void BoidFlight(
		Class<Actor> BoidActor = "BOID_Boid",	//This is the class type that boid will follow and try to match velocities with
		double MaxVelocity = 20,				//This is the max speed that it will go
		double VelocityAcceleration = .2,		//This is how fast the increases its speed
		double WallDetectionDistance = 6,		//How far away the Boid will detect walls.  WallDetectionDistance * velocity, so the distance increases the faster it goes
		Bool CloseToMaster = FALSE,				//Will remain near master pointer if TRUE
		double DistanceFromMaster = 400,		//Max distance from master pointer
		Bool CloseToTarget = FALSE,				//Will remain near target pointer if TRUE.  Overrides Close to master.
		double DistanceFromTarget = 400,		
		double MinDistanceToBoid = 150,			//Will try to move away from boids within this distance
		double MaxDistanceToBoid = 900,			//Will try to move toward boids if further than this distance
		double BoidCohesion = 3,				//How hard the boid will try to remain with other boids and match their velocities
		double MinDistanceBeacon = 100,			//Creates a beacon to move toward at least this far away
		double MaxDistanceBeacon = 300,			//Creates a beacon to move toward at most this far away
		double MaxAngleBeacon = 100,			//Creates a beacon at an angle at most this far from its current velocity
		double MaxRandomMoveAngle = 120,		//The max angle that the boid will randomly create a vector to move toward
		double HorizonNormalizer = 1,			//Adjusts all vectors in the array to turn toward the horizon.  Higher than 1 moves them to horizontal faster, less than 1 lessens the effect
		double VectorTurn = .6,
		double WallVelMod = .9,
		Bool UsePropertyValues = TRUE			//If this is true and the default arguments have not changed, then the arguments will use the values of the actor's properties.
												//Otherwise will force the use of the given argument values.
		)
	{
		if(UsePropertyValues)
		{
			BoidActor = BoidActor is "BOID_Boid" ? invoker.BoidActor : BoidActor;
			MaxVelocity = MaxVelocity == 20 ? invoker.MaxVelocity : MaxVelocity;
			VelocityAcceleration = VelocityAcceleration == .2 ? invoker.VelocityAcceleration : VelocityAcceleration;
			WallDetectionDistance = WallDetectionDistance == 6 ? invoker.WallDetectionDistance : WallDetectionDistance;
			DistanceFromMaster = DistanceFromMaster == 400 ? invoker.DistanceFromMaster : DistanceFromMaster;
			DistanceFromTarget = DistanceFromTarget == 400 ? invoker.DistanceFromTarget : DistanceFromTarget;

			MinDistanceToBoid = MinDistanceToBoid == 150 ? invoker.MinDistanceToBoid : MinDistanceToBoid;
			MaxDistanceToBoid = MaxDistanceToBoid == 900 ? invoker.MaxDistanceToBoid : MaxDistanceToBoid;
			BoidCohesion = BoidCohesion == 3 ? invoker.BoidCohesion : BoidCohesion;

			MinDistanceBeacon = MinDistanceBeacon == 100 ? invoker.MinDistanceBeacon : MinDistanceBeacon;
			MaxDistanceBeacon = MaxDistanceBeacon == 300 ? invoker.MaxDistanceBeacon : MaxDistanceBeacon;
			MaxAngleBeacon = MaxAngleBeacon == 100 ? invoker.MaxAngleBeacon : MaxAngleBeacon;

			MaxRandomMoveAngle = MaxRandomMoveAngle == 120 ? invoker.MaxRandomMoveAngle : MaxRandomMoveAngle;
			HorizonNormalizer = HorizonNormalizer == 1 ? invoker.HorizonNormalizer : HorizonNormalizer;
			VectorTurn = VectorTurn == .6 ? invoker.VectorTurn : VectorTurn;
			CloseToMaster = invoker.CloseToMaster ? invoker.CloseToMaster : CloseToMaster;
			CloseToTarget = invoker.CloseToTarget ? invoker.CloseToTarget : CloseToTarget;
		}
		
		
		vector3 unitvel;
		if(vel.length() > 0)
		{
			unitvel = Vel.unit();
		}
		double VelP = -Asin(Unitvel.z);		//Stores the angle and pitch of the velocity vector
		double VelA = Atan2(vel.y,vel.x);
		//If the current value of the speed modifier is less than the given maximum it will increase by the given acceleration
		if(invoker.VelocityMax < MaxVelocity)	
		{
			invoker.VelocityMax += VelocityAcceleration;
		}
		else if(invoker.VelocityMax > MaxVelocity)
		{
			invoker.VelocityMax -= VelocityAcceleration;
		}
		
		/////////////////////////////
		////Detect walls to avoid////
		/////////////////////////////
		
		bool InFront;
		bool AtSide;
		for(int i=0; i<10; i++)//for(int i=0; i<10; i++)
		{
			vector3 FibVec = FibSphereDirection(i, 25); //Checks half a sphere centered on its velocity vector
			if(LineTrace(Atan2(FibVec.y,FibVec.x),invoker.VelocityMax*WallDetectionDistance + radius,-Asin(FibVec.z),TRF_THRUACTORS | TRF_BLOCKSELF, height/2))
			{
				if(i<4)
				{
					InFront = TRUE;
				}
				else
				{
					AtSide = TRUE;
				}
				Break;
			}
		}
///////////////////////////////////////////////////////////////////////////////////////////////////////////
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////				
		if(InFront || AtSide)
		{
			Vector3 AVGvec;
			int AverageVectorNumbers;
			int breaker;
			While(AVGvec.length() == 0)
			{
				breaker++;
				if(breaker > 10)//So it doesn't get stuck in a permanent loop
				{
					break;
				}
// 				vector3 tempvel = vel;
// 				vel = FibSphereDirection(random(0,40),2500);
				for(int i=0; i<60; i++)
				{
					vector3 FibVec = FibSphereDirection(i, 60);//Checks in a full sphere
					double FibAngle = Atan2(FibVec.y,FibVec.x);
					double FibPitch = -Asin(FibVec.z);
					if(!LineTrace(FibAngle,invoker.VelocityMax*WallDetectionDistance+radius,FibPitch,TRF_THRUACTORS | TRF_BLOCKSELF, height/2,0,0))
					{
						AVGvec += FibVec;	//adds a vector to the average if it's not toward a wall
						AverageVectorNumbers++;
					}
					else if(AtSide)	//if it's not directly in front finds the first vector toward a wall, and moves slightly away from it.
					{
						double angletotracer = vecangletovec(FibVec, unitvel);
						vector3 AwayFromWall = vel;
						if(angletotracer < 70 && angletotracer > 4)
						{
							AwayFromWall = TurnTowardVec(AwayFromWall, FibVec, angletotracer - 90);
							AVGvec = AwayFromWall;
							AverageVectorNumbers = 1;
							break;
						}
					}
				}
// 				vel = tempvel;
				invoker.VelocityMax *= WallVelMod;	//Slows it down a bit near walls
			}
			AVGvec /= AverageVectorNumbers;
			AVGvec = AVGvec.unit();
			if((bNOCLIP || bNOINTERACTION) && !levellocals.ispointinlevel(pos))
			{
				AVGvec.xy *= -1;
			}
			ShiftArray(AVGvec*(max(2,invoker.VelocityMax*.2)+InFront*max(4,invoker.VelocityMax*.4)), invoker.BoidArray);
		}
		//////////////////////////
		////Find Master/Target////
		//////////////////////////
		
		if(CloseToMaster  && !(Target && invoker.PreferTarget) && Master && distance3d(Master) > DistanceFromMaster && GetAge()%3==0)
		{
			vector3 ToMaster = vec3to(Master);
			if(ToMaster.length() > 0)	//vector to master is stronger the further outside of range the boid is
			{
				ToMaster /= DistanceFromMaster*2;
				ShiftArray(ToMaster,invoker.BoidArray);
			}
		}
		else if(CloseToTarget && Target && distance3d(Target) > DistanceFromTarget && GetAge()%3==0)
		{
			vector3 TempToTarget = vec3to(target);
			vector3 ToTarget = vec3to(Target) + (0,0,Target.height/2);
			double angtotarg = VectorAngle(ToTarget.x,ToTarget.y);
			double pitchtotarg;
			if(ToTarget.length() > 1)
			{
				pitchtotarg = -Asin(ToTarget.z/ToTarget.length());
			}
			else
			{
				pitchtotarg = 0;
			}
			if(ToTarget.length() > 0)
			{
				ToTarget /= DistanceFromTarget*2;
				ShiftArray(ToTarget,invoker.BoidArray);
			}
			//if it can't see its target for too long it will lose the target
			if(LineTrace(angtotarg,distance3d(target), pitchtotarg, TRF_THRUSPECIES | TRF_THRUACTORS | TRF_THRUHITSCAN))
			{
				invoker.CanSeeTarget++;
			}
			else
			{
				invoker.CanSeeTarget = 0;
			}
			if(invoker.CanSeeTarget > 175)
			{
				Target = null;
				invoker.CanSeeTarget = 0;
			}
		}
		
		//////////////////////////
		////Detect other Boids////
		//////////////////////////
		
		BOID_BoidArray BoidFinderArray;
		BOID_BoidArray BoidVelArray;
		vector3 BoidFinderAverage;
		vector3 BoidVelAverage;
		int BoidFinderAverageCounter;
		int BreakCounter;
		
		//Will only find boids that you specify by class name.  Also looks at ancestry.
		Bool Found;
		BOID_Boid boid;
		
		let event = BoidArrayHandler(EventHandler.find("BoidArrayHandler"));
		for(int i=0; i<event.Boids.size(); i++)
		{
			boid = BOID_Boid(event.Boids[i]);
			if (boid == NULL || BreakCounter >= 20) { break; }
			Vector3 vec = vec3to(Boid);
			//Only looks at boids in front of itself, and boids with the same FlockID
			if(Boid == self || Boid.FlockID != invoker.FlockID || vecangletovec(vel,Vec) > 90 || !checksight(Boid))
			{
				Continue;
			}
			Found = TRUE;
			Double BoidDistance = Distance3d(Boid);
			if(BoidDistance > MaxDistanceToBoid)
			{
				Continue;
			}
			Vector3 UnitBoidVec = vec;
			if(BoidDistance > 0)
			{
				UnitBoidVec = vec.unit();
			}
			if(BoidDistance < MinDistanceToBoid)	//if it's too close
			{
				vector3 AwayVec = UnitBoidVec * ((MinDistanceToBoid*2)-BoidDistance)/MinDistanceToBoid;
				ShiftArray(-AwayVec,BoidFinderArray);
			}
			if(BoidDistance < MaxDistanceToBoid && BoidDistance > 80)	//if it's too far away
			{
				vector3 TowardVec = vec / (MaxDistanceToBoid/2);
				ShiftArray(TowardVec,BoidFinderArray);
			}
			if(BoidDistance < (2*MaxDistanceToBoid/3))	//matches velocities if it's close enough
			{
				Vector3 BVel= Boid.vel;
				if(BoidDistance > 0 && Boid.vel.length() > 0)
				{
					BVel = Boid.vel.Unit();
				}
				ShiftArray(BVel,BoidVelArray);
			}
			BreakCounter++;
		}
		
		/* let BoidFinder = ThinkerIterator.Create(BoidActor, STAT_DEFAULT);
		
		while (true)
		{
			boid = BOID_Boid(BoidFinder.next());
			if (boid == NULL || BreakCounter >= 20) { break; }
			Vector3 vec = vec3to(Boid);
			//Only looks at boids in front of itself, and boids with the same FlockID
			if(Boid == self || Boid.FlockID != invoker.FlockID || vecangletovec(vel,Vec) > 90)
			{
				Continue;
			}
			Found = TRUE;
			Double BoidDistance = Distance3d(Boid);
			Vector3 UnitBoidVec = vec;
			if(BoidDistance > 0)
			{
				UnitBoidVec = vec.unit();
			}
			if(BoidDistance < MinDistanceToBoid)	//if it's too close
			{
				vector3 AwayVec = UnitBoidVec * ((MinDistanceToBoid*2)-BoidDistance)/MinDistanceToBoid;
				ShiftArray(-AwayVec,BoidFinderArray);
			}
			if(BoidDistance < MaxDistanceToBoid && BoidDistance > 80)	//if it's too far away
			{
				vector3 TowardVec = vec / (MaxDistanceToBoid/2);
				ShiftArray(TowardVec,BoidFinderArray);
			}
			if(BoidDistance < (2*MaxDistanceToBoid/3))	//matches velocities if it's close enough
			{
				Vector3 BVel= Boid.vel;
				if(BoidDistance > 0 && Boid.vel.length() > 0)
				{
					BVel = Boid.vel.Unit();
				}
				ShiftArray(BVel,BoidVelArray);
			}
			BreakCounter++;
		} */
		if(Found)
		{
			//adds vectors to a separate array to find an average vector to/away from other boids
			for(int i=0; i<BoidFinderArray.RandomMove.Size(); i++)
			{
				if(BoidFinderArray.RandomMove[i].Length() == 0 || BoidVelArray.RandomMove[i].length() == 0)
				{
					Continue;
				}
				BoidFinderAverage += BoidFinderArray.RandomMove[i];
				BoidVelAverage += BoidVelArray.RandomMove[i];
				BoidFinderAverageCounter++;
			}
			if(BoidFinderAverage.length() > 0)
			{
				BoidFinderAverage /= BoidFinderAverageCounter;
				double AverageModifier = BoidCohesion;
				if(InFront || AtSide)
				{
					AverageModifier *= .3;
				}
				ShiftArray(BoidFinderAverage*AverageModifier, invoker.BoidArray);
			}
			if(BoidVelAverage.length() > 0)
			{
				BoidVelAverage /= BoidFinderAverageCounter;
				double AverageModifier = BoidCohesion;
				if(InFront || AtSide)
				{
					AverageModifier *= .3;
				}
				ShiftArray(BoidVelAverage*AverageModifier, invoker.BoidArray);
			}
		}
		else	//If it doesn't see any other boids it will create a random point to move towards
		{
			double BeaconDistance = invoker.Beacon.length();
			if(BeaconDistance == 0 && random(0,90) == 0)
			{
				invoker.Beacon = pos + (PivotRoll(frandom(0,MaxAngleBeacon), frandom(-180,180))*frandom(MinDistanceBeacon,MaxDistanceBeacon));
				int Breaker;
				While(!levellocals.IsPointInLevel(invoker.Beacon))
				{
					invoker.Beacon = pos + (PivotRoll(frandom(0,MaxAngleBeacon), frandom(-180,180))*frandom(MinDistanceBeacon,MaxDistanceBeacon));
					Breaker++;
					if(Breaker > 100)
					{
						invoker.Beacon = (0,0,0);
						break;
					}
				}
			}
			else if(BeaconDistance != 0)
			{
				vector3 Beaconlength = invoker.Beacon - pos;
				if(Beaconlength.length() < 100 || invoker.BeaconCounter >= 50)
				{	
					invoker.BeaconCounter = 0;
					invoker.Beacon = (0,0,0);
				}
				else if(GetAge()%2 == 0)
				{	
					invoker.BeaconCounter++;
					ShiftArray(Beaconlength.unit(), invoker.BoidArray);
				}
			}
		}
		
		
		//////////////////////////////
		////Random Wander Movement////
		//////////////////////////////
		
		
		if(!InFront && !AtSide)	//If there's no walls nearby it will add a random vector to the average array
		{
			double pivot = frandom(-MaxRandomMoveAngle,MaxRandomMoveAngle);
			double PRoll = frandom(-180,180);
			vector3 RPivRoll = PivotRoll(pivot, PRoll);
			RPivRoll = RelativeLocalCoords(RPivRoll);
			ShiftArray(RPivRoll*2,invoker.BoidArray);
		}
		
		
		///////////////////////////
		//Finalize average vector//
		///////////////////////////
		vector3 AverageVector;	//Finds the average vector of the array of vectors
		for(int i=0; i<invoker.BoidArray.RandomMove.Size(); i++)
		{
			AverageVector += invoker.BoidArray.RandomMove[i];
		}
		AverageVector /= invoker.BoidArray.RandomMove.Size();
		if(GetAge() > 5)
		{	
			//Rotates the velocity vector toward the average vector
			Vel = TurnTowardVec(Vel, AverageVector, vecangletovec(Vel,AverageVector)*VectorTurn);
			A_FaceMovementDirection();
		}
		for(int i=0; i<invoker.BoidArray.RandomMove.Size(); i++)
		{
			//This normalizes all the vectors in the array toward horizontal
			if(!invoker.BoidArray.RandomMove[i].x || !invoker.BoidArray.RandomMove[i].y || !invoker.BoidArray.RandomMove[i].z)
			{
				Continue;
			}
			vector3 Horizon = (cos(atan2(invoker.BoidArray.RandomMove[i].y,invoker.BoidArray.RandomMove[i].x)),sin(atan2(invoker.BoidArray.RandomMove[i].y,invoker.BoidArray.RandomMove[i].x)),0);
			invoker.BoidArray.RandomMove[i] = TurnTowardVec(invoker.BoidArray.RandomMove[i], Horizon, vecangletovec(invoker.BoidArray.RandomMove[i],Horizon) * .001*HorizonNormalizer);
			
		}
		if(vel.length() > 0)
		{
			//Adjusts its speed by the current VelocityMax
			Vel = vel.unit()*invoker.VelocityMax;
		}
		else
		{
			Vel = (Cos(angle)*Cos(pitch),Sin(angle)*Cos(pitch), -Sin(pitch))*invoker.VelocityMax;
		}
		Return;
	}
	
	//This function is so you can use it to find enemies.  Isn't used in the main BoidMovement function so feel free to ignore or use if you want.
	action Actor BOID_FINDER(double maxDistance = 512, Bool RandomTargets = TRUE, 
	Bool ThroughActors = TRUE, Bool Throughwalls = FALSE)
	{
		Array<Actor> Targets;
		Array<Actor> CloseToScreen;
		bool Setter = FALSE;
		
		for (let i = BlockThingsIterator.Create(self, maxDistance); i.Next();)
		{
			Actor other = i.thing;
			double distance = Distance3D(other);
			if(!other.bISMONSTER || !other.bSHOOTABLE || other.bDORMANT)
			{
				continue;
			}
			if(other.bCORPSE == TRUE)
			{
				other.bSHOOTABLE = FALSE;
				continue;
			}
			if (other == self)
			{
				continue;
			}
			if(bFRIENDLY && (other is "PlayerPawn" || other.bFRIENDLY))
			{
				Continue;
			}
			else if(!bFRIENDLY && !(other is "PlayerPawn"))
			{
				Continue;
			}
			if(distance < maxDistance)
			{
				Setter = TRUE;
			}
			if(!ThroughWalls)
			{
				FLineTraceData h;
				vector3 Temp = (vec3to(other)+(0,0,other.height/2)).unit();
				double APitch = -asin(Temp.z);
				float AngleDiff = angleto(other);
				LineTrace(AngleDiff, distance, APitch, Data: h);
				if(bFRIENDLY && h.hitactor is "PlayerPawn")
				{
					actor Temp = h.hitactor;
					Temp.bSHOOTABLE = FALSE;
					LineTrace(AngleDiff, distance, APitch, Data: h);
					Temp.bSHOOTABLE = TRUE;
				}
				if(ThroughActors)
				{
					Array<Actor> UnActors;
					while(h.hitactor && h.hitactor != other && h.hittype == TRACE_HitActor)
					{
						let k = h.hitactor;
						if(k.bSHOOTABLE)
						{
							UnActors.Push(k);
							k.bSHOOTABLE = FALSE;
						}
						LineTrace(AngleDiff, distance, APitch, Data: h);
					}
					for(int ReActors = 0; ReActors < UnActors.Size(); ReActors++)
					{
						UnActors[ReActors].bSHOOTABLE = TRUE;
					}
				}
				else if(h.hitactor && h.hitactor != other)
				{
					continue;
				}
				if(h.hittype != TRACE_HitActor)
				{
					continue;
				}
			}
			Targets.Push(i.thing);
		}
		if(Targets.Size() > 0 && Setter)
		{
			int Selected = 0;
			if(RandomTargets)
	 		{
				Selected = random(0,Targets.Size()-1);
			}
			else
			{
				for(int i = 0; i < Targets.Size(); i++)
				{
					if(Distance3d(Targets[i]) < target.Distance3d(Targets[Selected]))
					{
						Selected = i;
			}	}	}
			Return Targets[Selected];
		}
		Return null;
	}
}

//ENJAY STUFF//

//An example of the use of BoidsLib.pk3 by 4page
//See https://forum.zdoom.org/viewtopic.php?f=105&t=74521
//Example by Enjay
//Crow Sprites by neoworm
//Flappy brown bird from Xenogears
//LilBirb from To the Moon
//Sprite edits by Enjay

Class NJ_FlockBoidCrow : BOID_Boid //to be removed
{
        Override void PostBeginPlay()
        {
            if(master)
            {
                FlockID = Boid_Boid(master).FlockID;
            }
        }
        
    	Override Void Tick()
    	{
    	    BoidFlight(MaxVelocity: 12, CloseToMaster: TRUE, DistanceFromMaster: 400);
    	    Super.tick();
    	}

	Default
	{
		+NOINTERACTION;
		-BRIGHT
		Boid_Boid.BoidActor "NJ_FlockBoidCrow";
		Boid_Boid.HorizonNormalizer 40;
	}
		
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_SetScale (frandom(0.8,1.2));
			TNT1 A random (4, 8);
		Spawn2:	
			BIR1 AB 2;
			BIR1 DCD 3;
			BIR1 D 0 A_Jump (64, "Glide");
			Loop;
		Glide:
			BIR1 EE random (8, 24);
			Goto Spawn2;
		
		XDeath:
		Death:
			TNT1 A 1;
			Stop;
	}	
}

Class NJ_FlockSpawnerCrow : BOID_Boid //to be removed
{

        Override void PostBeginPlay()
        {
            FlockID = random(0,255);
        }

    	Default
    	{
    	     +NOINTERACTION
    	     +NOGRAVITY;
    	}
	
	States
	{
	Spawn:
	Active:
	TNT1 A 0;
	TNT1 A 0 A_JumpIf(args[0] == 0, "BoidsIsNull");
	//
	SpawnBoids:
	TNT1 A 0 Bright A_SetArg(4, args[0]);
	SpawnBoids2:
	TNT1 A 1 Bright A_JumpIf(args[4] == 0, "NoMoreBoids");
	TNT1 A 0 Bright A_SpawnItemEx("NJ_FlockBoidCrow",20,0,40,0,0,0,0,SXF_SETMASTER|SXF_NOCHECKPOSITION);
	TNT1 A 0 Bright A_SetArg(4, args[4] - 1);
	Goto SpawnBoids2;
	
	BoidsIsNull:
 	TNT1 A 1 A_SetArg(0, 8);
 	goto SpawnBoids;


	NoMoreBoids:
	TNT1 A -1;
	Stop;
	
	Inactive:
	TNT1 A 0 A_RemoveChildren (TRUE, RMVF_EVERYTHING);
	TNT1 A -1;
	Stop;
	
	XDeath:
	Death:
	TNT1 A 1;
	Stop;
	}
}

Class NJ_FlockBoidFlappy : NJ_FlockBoidCrow //to be removed
{
	Default
	{
		+NOINTERACTION;
		-BRIGHT
		Boid_Boid.BoidActor "NJ_FlockBoidFlappy";
		Boid_Boid.HorizonNormalizer  40;
		Boid_Boid.MinDistanceToBoid 192;
		Boid_Boid.BoidCohesion 1;
		Boid_Boid.VelocityAcceleration .1;
		Boid_Boid.MaxRandomMoveAngle 60;
	}

	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_SetScale (frandom(0.8,1.2));
			TNT1 A random (0, 8);
		Spawn2:	
			BIR2 A 0 A_Jump (96, "Glide");
			BIR2 AABBCCDD 2;
			Loop;
		Glide:
			BIR2 EE random (16, 24);
			Goto Spawn2;
		
		Death:
			TNT1 A 1;
			Stop;
	}	
}

Class NJ_FlockSpawnerFlappy : NJ_FlockSpawnerCrow //to be removed
{

	States
	{
	Spawn:
	Active:
	TNT1 A 0;
	TNT1 A 0 A_JumpIf(args[0] == 0, "BoidsIsNull");
	//
	SpawnBoids:
	TNT1 A 0 Bright A_SetArg(4, args[0]);
	SpawnBoids2:
	TNT1 A 1 Bright A_JumpIf(args[4] == 0, "NoMoreBoids");
	TNT1 A 0 Bright A_SpawnItemEx("NJ_FlockBoidFlappy",20,0,40,0,0,0,0,SXF_SETMASTER|SXF_NOCHECKPOSITION);
	TNT1 A 0 Bright A_SetArg(4, args[4] - 1);
	Goto SpawnBoids2;
	
	BoidsIsNull:
 	TNT1 A 1 A_SetArg(0, 8);
 	goto SpawnBoids;


	NoMoreBoids:
	TNT1 A -1;
	Stop;
	
	Inactive:
	TNT1 A 0 A_RemoveChildren (TRUE, RMVF_EVERYTHING);
	TNT1 A -1;
	Stop;
	
	XDeath:
	Death:
	TNT1 A 1;
	Stop;
	}
}

Class NJ_FlockBoidLilBirb : NJ_FlockBoidCrow //to be removed
{
	Default
	{
		-BRIGHT
		+NOINTERACTION;
		Boid_Boid.BoidActor "NJ_FlockBoidLilBirb";
		Boid_Boid.HorizonNormalizer  40;
		Boid_Boid.VelocityAcceleration .6;
		Boid_Boid.WallDetectionDistance 6;
		Boid_Boid.MinDistanceToBoid 96;
		Boid_Boid.MaxDistanceToBoid 512;
		Boid_Boid.BoidCohesion 4;
		Boid_Boid.MaxRandomMoveAngle 240;
	}

	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_SetScale (frandom(0.8,1.2));
			TNT1 A random (0, 8);
		Spawn2:	
			BIR3 A 0 A_Jump (32, "Glide");
			BIR3 ABCDABCD 2;
			Loop;
		Glide:
			BIR3 EE random (8, 16);
			Goto Spawn2;
		
		Death:
			TNT1 A 1;
			Stop;
	}	
}

Class NJ_FlockSpawnerLilBirb : NJ_FlockSpawnerCrow //to be removed
{

	States
	{
	Spawn:
	Active:
	TNT1 A 0;
	TNT1 A 0 A_JumpIf(args[0] == 0, "BoidsIsNull");
	//
	SpawnBoids:
	TNT1 A 0 Bright A_SetArg(4, args[0]);
	SpawnBoids2:
	TNT1 A 1 Bright A_JumpIf(args[4] == 0, "NoMoreBoids");
	TNT1 A 0 Bright A_SpawnItemEx("NJ_FlockBoidLilBirb",20,0,40,0,0,0,0,SXF_SETMASTER|SXF_NOCHECKPOSITION);
	TNT1 A 0 Bright A_SetArg(4, args[4] - 1);
	Goto SpawnBoids2;
	
	BoidsIsNull:
 	TNT1 A 1 A_SetArg(0, 8);
 	goto SpawnBoids;


	NoMoreBoids:
	TNT1 A -1;
	Stop;
	
	Inactive:
	TNT1 A 0 A_RemoveChildren (TRUE, RMVF_EVERYTHING);
	TNT1 A -1;
	Stop;
	
	XDeath:
	Death:
	TNT1 A 1;
	Stop;
	}
}