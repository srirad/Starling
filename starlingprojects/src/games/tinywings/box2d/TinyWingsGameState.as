package games.tinywings.box2d {

	import Box2D.Common.Math.b2Vec2;

	import citrus.core.starling.StarlingState;
	import citrus.physics.box2d.Box2D;
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Platform;
	import flash.geom.Point;
	import starling.text.TextField;
	import starling.display.Sprite;
	import starling.display.Image;

	/**
	 * @author Cyril Poëtte
	 */
	public class TinyWingsGameState extends StarlingState {
		
		[Embed(source="/../embed/games/tinywings/ball.png")]
		public static const HeroView:Class;
		
		private var _box2D:Box2D;
		private var _ball:Ball;
		
		private var _hillsTexture:HillsTexture;
		
		var legend:TextField;

		public function TinyWingsGameState() {
			super();
		}

		override public function initialize():void {
			
			super.initialize();

			_box2D = new Box2D("box2d");
			_box2D.visible = true;
			_box2D.gravity = new b2Vec2(0, 3);
			add(_box2D);
			
			var bgsprite:Sprite = new Sprite();
			
			
			var	bg:Image = new Image(GetAssets.getTexture("bg"));
		
			bg.x = 0;
			bgsprite.addChild(bg);
			add(bgsprite);
			
			_ball = new Ball("hero", {radius:0.6, hurtVelocityX:5, hurtVelocityY:8, group:1, view:new HeroView()});
			_ball.x = 100;
			_ball.y = -300;
			add(_ball);
			
			var p1:Platform = new Platform("p1", {x:stage.stageWidth >>1, y: stage.stageHeight - 20, width: stage.stageWidth, height:40});
add(p1);
			
			var mp:MovingPlatform = new MovingPlatform("mp",{x:220, y:700, width:200, height: 40, startX: 220, startY: 700, endX:500, endY: 151});
			add(mp);
			
			legend = new TextField(100, 20, "Hello Starling!", "Arial", 14, 0xFF0000);
			
			
		    addChild(legend);
			
		
			
			_hillsTexture = new HillsTexture();
			
			//	var hills:HillsManagingGraphics = new HillsManagingGraphics("hills",{rider:_ball, sliceWidth:30, roundFactor:20, sliceHeight:800, widthHills:stage.stageWidth, registration:"topLeft", view:_hillsTexture});
		//	add(hills);

			var hills:HillsManagingGraphics = new HillsManagingGraphics("hills", { rider:_ball, sliceWidth:30, roundFactor:10, sliceHeight:50, widthHills:stage.stageWidth, heightHills:500,  registration:"topLeft", view:_hillsTexture } );
			add(hills);
	
			view.camera.setUp(_ball,null,new Point(0.25 , 0.5));
			
		}
			
		override public function update(timeDelta:Number):void {
		/*	var heroPos:String = _ball.x + "";
			
			legend.text = legend.text + heroPos;*/
			
			super.update(timeDelta);
			_hillsTexture.update();
		}
	}
}
