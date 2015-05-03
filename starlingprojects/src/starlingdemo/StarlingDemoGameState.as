package starlingdemo {

	import Box2D.Dynamics.Contacts.b2Contact;

	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.view.starlingview.AnimationSequence;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import flash.display.Bitmap;
	import citrus.view.starlingview.StarlingCamera;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import citrus.view.ACitrusCamera;
	
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	/**
	 * @author Aymeric
	 */
	
	
	 
	public class StarlingDemoGameState extends StarlingState {
		
		[Embed(source="/../embed/Hero.xml", mimeType="application/octet-stream")]
		private var _heroConfig:Class;
		
		[Embed(source="/../embed/Hero.png")]
		private var _heroPng:Class;
		
		private var _camera:StarlingCamera;
		private var _bounds:Rectangle;
		
		private var platform:Platform;
		
        var hero:Hero;
		
		
		public function StarlingDemoGameState() {
			super();
		}

		override public function initialize():void {
			super.initialize();
			
			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
			
		//	add(new Platform("bottom", {x:stage.stageWidth / 2, y:stage.stageHeight, width:78700}));
			
		   
		   platform = new Platform("cloud", { x:350, y:stage.stageHeight, width:700 } );
			add(platform);
			
			var coin:Coin = new Coin("coin", {x:360, y:200, view:"levels/SoundPatchDemo/jewel.png"});
			add(coin);
			coin.onBeginContact.add(coinTouched);
			
			var bitmap:Bitmap = new _heroPng();
			var texture:Texture = Texture.fromBitmap(bitmap);
			var xml:XML = XML(new _heroConfig());
			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml);
			
			hero = new Hero("hero", {x:100, y:300, width:60, height:135, hurtVelocityX:5, hurtVelocityY:8});
			add(hero);
			hero.view = new AnimationSequence(sTextureAtlas, ["walk", "duck", "idle", "jump", "hurt"], "idle");
			hero.onGiveDamage.add(heroAttack);
			hero.onTakeDamage.add(heroHurt);
			
			var enemy:Enemy = new Enemy("enemy", {x:stage.stageWidth - 50, y:350, width:46, height:68, leftBound:20, rightBound:stage.stageWidth - 20});
		//	add(enemy);
			
			
			_bounds = new Rectangle(0, 0, 2048, 1200);
			
			/* Camera Set Up*/
				//camera setup
			_camera = view.camera as StarlingCamera;
			_camera.setUp(hero,_bounds, new Point(0.5, 0.5), new Point(0.05, 0.05));
			_camera.allowRotation = true;
			_camera.allowZoom = true;
			_camera.deadZone = new Rectangle(0, 0, 2*stage.stageWidth/3, stage.stageHeight/3);
			_camera.parallaxMode = ACitrusCamera.PARALLAX_MODE_DEPTH;
	//		-_camera.boundsMode = ACitrusCamera.BOUNDS_MODE_AABB;
			
			_camera.setZoom(1.2);
			_camera.reset();
			
			_camera.target = hero; 
			
			
			addEventListener(Event.ENTER_FRAME, checkPlatform);
			
		}
		
		
		private function checkPlatform(e:EnterFrameEvent):void
		{
			if(hero.x > 100) {
				
			//	hero.visible = false;
			//	platform.x = hero.x;
			//	hero.x = 5;
			//	
			}
		
		}

		private function heroHurt():void {
			_ce.sound.playSound("Hurt");
		}
		
		private function heroAttack():void {
			_ce.sound.playSound("Kill");
		}

		private function coinTouched(contact:b2Contact):void {
			trace('coin touched by an object');
		}

	}
}
