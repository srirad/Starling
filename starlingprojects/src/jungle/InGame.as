package jungle
{
	import citrus.core.starling.StarlingState;
	import jungle.JGameBackground;
	import citrus.physics.box2d.Box2D;
	import Box2D.Common.Math.b2Vec2;
	import citrus.objects.platformer.box2d.Platform;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import starling.display.MovieClip;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.view.starlingview.AnimationSequence;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import flash.display.Bitmap;
	
//import games.hungryhero.com.hsharma.hungryHero.gameElements.GameBackground;
	/**
	 * ...
	 * @author srini
	 */
	public class InGame extends StarlingState
	{
		
		private var bg:JGameBackground;
		private var _box2D:Box2D;
		private var floor:Platform;
		private var floor1:Platform;
		private var gravvec:b2Vec2;
		private var obstacle1:CitObj;
		private var obstacle2:CitObj;
		private var heroView:CitObj;
		private var hero:Hero;
		
		[Embed(source="/../embed/Hero.xml",mimeType="application/octet-stream")]
		private var _heroConfig:Class;
		
		[Embed(source="/../embed/Hero.png")]
		private var _heroPng:Class;
		//private var boxObj
		
		[Embed(source="/../embed/games/tinywings/ball.png")]
		public static const HeroView:Class;
		
		public function InGame()
		{
			
			super();
		
			// Is hardware rendering?
			//		isHardwareRendering = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1;
			//		isHardwareRendering = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1;
		
		}
		
		override public function initialize():void
		{
			
			super.initialize();
			
			_box2D = new Box2D("box2d");
			_box2D.visible = true;
			_box2D.gravity = new b2Vec2(0, 10);
			add(_box2D);
			
			drawGame();
		}
		
		private function drawGame():void
		{
			// Draw background.
			bg = new JGameBackground();
			add(bg);
			
			floor = new Platform("FLOOR", {x: 0, y: stage.stageHeight - 20, width: stage.stageWidth, height: 40});
			add(floor);
			//	floor.type = b2Body.b2_dynamicBody();
			
			floor1 = new Platform("FLOOR1", {x: floor.x + floor.width, y: stage.stageHeight - 20, width: stage.stageWidth, height: 40});
			//	floor1.rotation = 180;
			add(floor1);
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.position.Set(320 / 30, 30 / 30);
			
			var circleShape:b2CircleShape;
			circleShape = new b2CircleShape(25 / 30);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = circleShape;
			fixtureDef.density = 10;
			fixtureDef.restitution = 0.8;
			fixtureDef.friction = 1;
			
			var ballvel:b2Vec2 = new b2Vec2(0, 0);
			var theBall:b2Body = _box2D.world.CreateBody(bodyDef);
			
			theBall.CreateFixture(fixtureDef);
			theBall.SetLinearVelocity(ballvel);
			
			/*	var heroTex:MovieClip = new MovieClip(GetAssets.getHeroAtlas().getTextures("walk"), 11);
			   hero = new Hero("hero", { view:heroTex } );
			   hero.y = floor.y - (floor.height<<1);
			   hero.x = stage.stageWidth +50;
			 */
			
			/*		var herotex:MovieClip = new MovieClip(GetAssets.getAtlas().getTextures("deer_"), 12);
			
			   herotex.scaleX = -0.5;
			   herotex.scaleY = 0.5;
			
			   hero = new CitObj("deer", {view: obsTex1});
			   hero.y = floor.y - (floor.height << 1);
			   hero.x = stage.stageWidth + 50;
			 */
			
			var herotex:MovieClip = new MovieClip(GetAssets.getAtlas().getTextures("deer_"), 12);
			
			herotex.scaleX = -0.5;
			herotex.scaleY = 0.5;
			
			heroView = new CitObj("deer", {view: herotex});
			//	heroView.y = floor.y - (floor.height << 1);
			//	heroView.x = 350;
			
			var obsTex1:MovieClip = new MovieClip(GetAssets.getAtlas().getTextures("deer_"), 12);
			
			obsTex1.scaleX = 0.5;
			obsTex1.scaleY = 0.5;
			
			obstacle1 = new CitObj("deer", {view: obsTex1});
			obstacle1.y = floor.y - (floor.height << 1);
			obstacle1.x = stage.stageWidth + 50;
			
			var obsTex2:MovieClip = new MovieClip(GetAssets.getAtlas().getTextures("parrot_"), 9);
			
			obsTex2.scaleX = 0.5;
			obsTex2.scaleY = 0.5;
			
			obstacle2 = new CitObj("parrot", {view: obsTex2});
			obstacle2.y = 100;
			obstacle2.x = stage.stageWidth + 50;
			
			add(obstacle1);
			add(obstacle2);
			//add(heroView);
			
			/*		hero = new Hero("hero", {x: 300, y: 300, width:150, height: 110, hurtVelocityX: 5, hurtVelocityY: 8});
			   add(hero);
			   hero.offsetX = 150;
			   hero.friction = 80;
			
			   //hero.offsetY = 10;
			   hero.view = herotex;
			   //	hero.x = 200;
			
			   /*	var bitmap:Bitmap = new _heroPng();
			   var texture:Texture = Texture.fromBitmap(bitmap);
			   var xml:XML = XML(new _heroConfig());
			   var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml);
			
			   hero = new Hero("hero", {x: 100, y: 300, width: 60, height: 135, hurtVelocityX: 5, hurtVelocityY: 8});
			   add(hero);
			   hero.view = new AnimationSequence(sTextureAtlas, ["walk", "duck", "idle", "jump", "hurt"], "idle");
			 */
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		
		// To create totem
		private function brick(pX:int, pY:int, w:Number, h:Number):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(pX / worldScale, pY / worldScale);
// bodyDef.type=b2Body.b2_dynamicBody;
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(w / 2 / worldScale, h / 2 / worldScale);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 2;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var theBrick:b2Body = world.CreateBody(bodyDef);
			theBrick.CreateFixture(fixtureDef);
		}
		
		private function onGameTick(event:Event):void
		{
			
			obstacle1.x -= 5 * Math.random();
			if (obstacle1.x <= -stage.stageWidth / 2)
			{
				obstacle1.x = stage.stageWidth + 50;
				
			}
			
			obstacle2.x -= 5;
			if (obstacle2.x <= -stage.stageWidth / 2)
			{
				obstacle2.x = stage.stageWidth + 50;
				
			}
			
			if (floor1.x <= -stage.stageWidth / 2)
			{
				
				floor1.x = floor.x + stage.stageWidth;
			}
			
			var timeStep:Number = 1 / 30;
			var velIterations:int = 10;
			var posIterations:int = 10;
			_box2D.world.Step(timeStep, velIterations, posIterations);
		
		}
	
	}

}