package {
	// Imports some things into the movie.
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.KeyboardEvent;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;

	public class PlatformExample extends Sprite {

		public function Box2d() {

			addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);

			var worldAABB:b2AABB = new b2AABB();//Creates a new world
			worldAABB.lowerBound.Set(-100.0, -100.0);//Sets the lower bloundaries of the world (If a shape goes outside this it will freez)
			worldAABB.upperBound.Set(100.0, 100.0);//Sets the upper bloundaries of the world (If a shape goes outside this it will freez)

			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);//Sets gravity. First number is Y and second is x
			var doSleep:Boolean = true;//If the shapes are allowed to sleep. (Stop simulating)
			m_world = new b2World(worldAABB, gravity, doSleep);//Sets everything together to make a Box2d World


			CreateBox(275, 375, 600, 50, true, new Ground());//Ground

			CreateCircle(250, 100, 50, false, new Circle());//Ball

			CreateHero(200, 300);//Player

			CreateBox(500, 302, 200, 100, true, new Ground());//Static Box on right side




			/* following code makes some stacks of blocks*/
			for (var x:int = 1; x<4; x++) {
				for (var i:int = 1; i<11; i++) {
					CreateBox(((300+(20*x))-(.25*i)), (365-(20*i)), 20, 20, false, new Box());
				}
			}
		}
		/*
		          I personaly think its MUCh easier to put the code into functions,
		         because then you dont need to type it again, and again, and again. And it works just fine with function like createCircle and createBox.
		          And when its time to start making levels, you will have a lot less typing to do when you can just type in the function.
		          */





		/* 
		      Following Function Creates the Hero 
		      CreateHero(X Posision, Y Posision, Width of Hero, Height of Hero)
		      */
		public function CreateHero(x:Number, y:Number, width:Number = 20, height:Number = 20) {
			bodyDef = new b2BodyDef();
			bodyDef.position.x = (x)/physScale;
			bodyDef.position.y = (y)/physScale;
			boxDef = new b2PolygonDef();
			boxDef.SetAsBox(GetRealWH(20), GetRealWH(20));
			boxDef.density = 1.0;//Because the density is at higher then 0 it moves.
			boxDef.friction = 0.3;
			boxDef.restitution = 0.2;
			bodyDef.userData = new PlayerBox();
			bodyDef.userData.name = "Player";
			bodyDef.userData.width = physScale * 2 * GetRealWH(width);
			bodyDef.userData.height = physScale * 2 * GetRealWH(height);
			body = m_world.CreateBody(bodyDef);
			body.SetBullet(true);//Tells flash to treat it like a bullet (Continuous collision detection.)
			body.CreateShape(boxDef);
			body.SetMassFromShapes();
			bodyDef.userData.body = body;//This is the only way I know that u can get a specific body from the World.
			//If you have a better idea, tell me!
			addChild(bodyDef.userData);

		}
		/* 
		      Following function Creates a Circle 
		      CreateCircle(X posision, Y Posision, Width/Height of ball, Is the ball static (Inmoveable), The movieclip you want to be shown as the circle (Example: new Circle())
		      */
		public function CreateCircle(x:Number, y:Number, width:Number, static:Boolean, Cover) {
			/* Following Code creates a circle */
			bodyDef = new b2BodyDef();
			bodyDef.position.x = x/physScale;
			bodyDef.position.y = y/physScale;
			circleDef = new b2CircleDef();//Defines circleDef as a new b2CircleDef
			circleDef.radius = GetRealWH(width);//Sets the radius of the ball
			circleDef.density = 1.0;
			circleDef.friction = 0.3;
			circleDef.restitution = 0.2;
			bodyDef.userData = Cover;//sets userData to a new Circle (See Library)
			bodyDef.userData.width = 30 * 2 * GetRealWH(width);//Sets width and height. Third Number is the same as the radius.
			bodyDef.userData.height = 30 * 2 * GetRealWH(width);
			trace(bodyDef.userData.height);
			body = m_world.CreateBody(bodyDef);
			body.CreateShape(circleDef);
			body.SetMassFromShapes();
			addChild(bodyDef.userData);

		}
		/*
		      Following function creates a box 
		      CreateBox(X posision, Y Posision, Width, Height, Is the box static (Inmoveable), The movieclip you want to be shown as the box (Example: new Box())
		      */
		public function CreateBox(x:Number, y:Number, width:Number, height:Number, static:Boolean, Cover) {
			/* Creates the static box on the right side of the screen*/
			bodyDef = new b2BodyDef();
			bodyDef.position.x = (x)/physScale;
			bodyDef.position.y = (y)/physScale;
			boxDef = new b2PolygonDef();
			boxDef.SetAsBox(GetRealWH(width), GetRealWH(height));
			if (static) {
				boxDef.density = 0.0;
			}
			else {
				boxDef.density = 1.0;
			}
			boxDef.friction = 0.3;
			boxDef.restitution = 0.4;
			bodyDef.userData = Cover;
			bodyDef.userData.width = physScale * 2 * GetRealWH(width);
			bodyDef.userData.height = physScale * 2 * GetRealWH(height);
			bodyDef.isBullet = true;//This tells flash to treat all boxes like bullets. This is CPU consuming with a lot of boxes.
			//But the hit test is WAY better when you use this.
			body = m_world.CreateBody(bodyDef);
			body.CreateShape(boxDef);
			body.SetMassFromShapes();
			addChild(bodyDef.userData);

		}
		/*
		      I hade to make this function because I noticed that
		      the width and height of the shapes were 2 times to large 
		      even to I divided it by physScale.
		      This is because Box2d when doing width and height only takes from the center out.
		      For Example: if I use this SetAsBox(100/physScale, 100/physScale)
		      I will get a box that is 200x200 because the 100/physScale is the distance from the
		      center of the box to the top  or the sides.
		      
		      I made this function because I like using the numbers I usualy use in flash 
		      when making games.
		      */
		public function GetRealWH(Num:Number) {
			return Num / physScale / 2;
		}
		/*
		      Following functions a controls when any aroow key is pressed.
		      */
		public var Left:Boolean = false;
		public var Right:Boolean = false;
		public var Up:Boolean = false;
		public function KeyDown(e:KeyboardEvent) {
			trace(e.keyCode);
			var TheChild = getChildByName("Player");
			var Body = TheChild.body;
			switch (e.keyCode) {
				case 37 ://Left
					Left = true;
					break;
				case 38 ://Up
					Up = true;
					break;
				case 39 ://Right
					Right = true;
					break;

			}
		}
		public function KeyUp(e:KeyboardEvent) {
			trace(e.keyCode);
			var TheChild = getChildByName("Player");
			var Body = TheChild.body;
			switch (e.keyCode) {
				case 37 ://Left
					Left = false;
					break;
				case 38 ://Up
					Up = false;
					break;
				case 39 ://Right
					Right = false;
					break;

			}
		}
		/* Following function gets the body from a cordinate (x, y)*/
		public function GetBodyAtPoint(px:Number, py:Number, includeStatic:Boolean = false) {
			// Make a small box.
			var px2 = px/physScale;
			var py2 = py/physScale;
			var PointVec:b2Vec2 = new b2Vec2();
			PointVec.Set(px2, py2);
			var aabb:b2AABB = new b2AABB();
			aabb.lowerBound.Set(px2 - 0.001, py2 - 0.001);
			aabb.upperBound.Set(px2 + 0.001, py2 + 0.001);

			// Query the world for overlapping shapes.
			var k_maxCount:int = 10;
			var shapes:Array = new Array();
			var count:int = m_world.Query(aabb, shapes, k_maxCount);
			var body:b2Body = null;
			for (var i:int = 0; i < count; ++i) {
				if (shapes[i].m_body.IsStatic() == false || includeStatic) {
					var tShape:b2Shape = shapes[i] as b2Shape;
					var inside:Boolean = tShape.TestPoint(tShape.m_body.GetXForm(), PointVec);
					if (inside) {
						body = tShape.m_body;
						break;
					}
				}
			}
			return body;
		}
		public function Update(e:Event):void {
			/*Following code down to line 252 Makes the Player move left, right and jump*/
			var TheChild = getChildByName("Player");//Getts a child named Box
			var Body = TheChild.body;//Get the var body from the child.
			if (Left) {//If Left Arrow is down
				Body.WakeUp();//Wakes the body up if its sleeping
				Body.m_linearVelocity.x = -3;//Adds to the linearVelocity of the box.
			}
			if (Right) {//If right arrow is down
				Body.WakeUp();//Wakes the body up if its sleeping
				Body.m_linearVelocity.x = 3;//Adds to the linearVelocity of the box.
			}
			if (Up) {
				if (Body.GetLinearVelocity().y > -1) {//Stops player from sometimes jumpping higher then suppose to
					/*
					               I have made 3 hit points.
					               */
					var Hit = GetBodyAtPoint(TheChild.x, TheChild.y+(TheChild.height/2+2), true);//Under
					var Hit1 = GetBodyAtPoint(TheChild.x-(TheChild.width/2)+2, TheChild.y+(TheChild.height/2+2), true);//Down-Left
					var Hit2 = GetBodyAtPoint(TheChild.x+(TheChild.width/2)-2, TheChild.y+(TheChild.height/2+2), true);//Down-Right
					if (Hit != null && Hit.m_userData != TheChild) {
						Body.ApplyImpulse(new b2Vec2(0.0, -3.0), Body.GetWorldCenter());//Applys and impuls to the player. (Makes it jump)
					}
					else if (Hit1 != null && Hit1.m_userData != TheChild || Hit2 != null && Hit2.m_userData != TheChild) {

						Body.ApplyImpulse(new b2Vec2(0.0, -3.0), Body.GetWorldCenter());
					}//Applys and impuls to the player. (Makes it jump)
				}
			}
		};
		Body.m_sweep.a = 0;//This is what stops the player from rotating
		/*
		         But because its only called once a frame it will allow the player to rotate a little.
		         Which makes it more realistic.
		         
		         */

		m_world.Step(m_timeStep, m_iterations);//This runns the Box2D World

		//Body.m_sweep.a = 0; //If you wanned to take the tiny movement away you could move this code here. 
		// The follwoing code rotates, sets the x and y cordinates of the movieclips the player sees.
		for (var bb:b2Body = m_world.m_bodyList; bb; bb = bb.m_next) {//Makes a for loop scanning all the bodys in the World
			if (bb.m_userData is Sprite) {//Checks if bb.m_userData is a spirit (Movieclip)
				bb.m_userData.x = bb.GetPosition().x * physScale;//Changes the x
				bb.m_userData.y = bb.GetPosition().y * physScale;//Changes the y
				bb.m_userData.rotation = bb.GetAngle() * (180/Math.PI);//Changes the rotation
			}
		}
	}
	/* Vars used in creating shapes */
	public var body:b2Body;
	public var bodyDef:b2BodyDef;
	public var boxDef:b2PolygonDef;
	public var circleDef:b2CircleDef;

	public var m_world:b2World;
	public var m_iterations:int = 15;
	public var physScale:Number = 30;
	public var m_timeStep:Number = 1.0/physScale;

}