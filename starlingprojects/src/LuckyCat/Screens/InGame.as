package LuckyCat.Screens
{
	import citrus.input.controllers.starling.VirtualButton;
	import flash.desktop.InteractiveIcon;
	import starling.animation.DelayedCall;
	import starling.display.Button;
	import starling.display.Quad;
	
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import LuckyCat.GetAssets;
	import starling.display.DisplayObject;
	import LuckyCat.events.NavigationEvent;
	import starling.animation.Tween;
	import starling.core.Starling;
	import LuckyCat.FullScreenExtension;
	import flash.geom.Rectangle;
	import citrus.objects.CitrusSprite;
	import starling.extensions.particles.PDParticleSystem;
	import LuckyCat.GetParticleAssets;
	import starling.textures.Texture;
	import flash.display.Shape;
	import LuckyCat.Sounds;
	import flash.media.SoundMixer;
	
	/**
	 * ...
	 * @author Srini
	 */
	public class InGame extends Sprite
	{
		private var loginImg:Image;
		public var bg:Background;
		
		private var catSprite:Sprite;
		private var catImg:Image;
		private var coin:Image;
		private var coinMoving:Boolean = false;
		
		private var bounds1:Rectangle;
		private var bounds2:Rectangle;
		
		private var hits:int;
		private var miss:int;
		private var hitsText:TextField;
		private var missText:TextField;
		
		private var timeTaken:Number = 1;
		
		private var timeTaken1:Number = 1;
		private var timeTaken2:Number = 1;
		
		private var caught:Boolean = false;
		private var redFlight:Image;
		
		private var greenFlight:Image;
		private var greenFlight2:Image;
		
		private var emissile:Image;
		
		private var gameOver:Boolean = true;
		
		private var playBtn:Image;
		
		private var life1:Quad;
		private var life2:Quad;
		private var life3:Quad;
		
		private var lifeleft:int;
		
		private var isFirstTime:Boolean = true;
		
		public static var missileparticle:CitrusSprite;
		
		private var timebar:Quad;
		
		private var barFullWidth:Number = 180.00;
		
		private var timeLeft:Number = 1800;
		
		private var barMaxHeight:Number = -200;
		
		private var hasFired:Boolean = false;
		
		private var missileStartPoint:Number;
		
	private	var size:int = 7;
		private var fixed:Boolean = true
		
		private var objectVector:Vector.<Image>;
		
		
		public function InGame()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			
			bg = new Background();
			bg = new Background();
			
			addChild(bg);
			
		/*	playBtn = new Image(GetAssets.getTexture("play1"));
			playBtn.x = 800 - 250;
			playBtn.y = 1700;
			
			addChild(playBtn);
			isFirstTime = true;
			playBtn.addEventListener(TouchEvent.TOUCH, startGame);
			
			redFlight = new Image(GetAssets.getTexture("asteroid"));
			redFlight.y = 200;
			redFlight.x = redFlight.x + redFlight.x + stage.stageWidth;
			addChild(redFlight);
			
			greenFlight = new Image(GetAssets.getTexture("greenFlight"));
			greenFlight.y = 400;
			greenFlight.x = stage.stageWidth;
			addChild(greenFlight);
			
			greenFlight2 = new Image(GetAssets.getTexture("greenFlight"));
			greenFlight2.y = 490;
			greenFlight2.x = stage.stageWidth;
			addChild(greenFlight2);
			
			hitsText = new TextField(500, 300, "", "Arial", 200, 0Xffffff);
			
			hitsText.x = (stage.stageWidth >> 1) - 250;
			hitsText.y = (stage.stageHeight >> 1);
			addChild(hitsText);
			
			missText = new TextField(500, 300, "", "Arial", 100, 0Xff0000);
			
			missText.x = (stage.stageWidth >> 1) - 250;
			missText.y = 1000;
			addChild(missText);
			
			timebar = new Quad(20, -1, 0x000000);
			timebar.x = 50;
			timebar.y = stage.stageHeight - 700;
			
			var timegauge:Quad = new Quad(60, -1 * 600, 0xffffff);
			timegauge.x = timebar.x - 20;
			timegauge.y = timebar.y;
			addChild(timegauge);
			addChild(timebar);
			
			var delayedCall:DelayedCall = new DelayedCall(animateprogbar, 0.1);
			delayedCall.repeatCount = int.MAX_VALUE;
			Starling.juggler.add(delayedCall);
			
			var emissileBase:Image = new Image(GetAssets.getTexture("emissilebase"));
			
			emissileBase.scaleX = 2.5;
			emissileBase.scaleY = 2.5;
			emissileBase.x = (1600 >> 1) - (emissileBase.width >> 1);
			emissileBase.y = 2560 - 350;
			stage.addChild(emissileBase);
			
			emissile = new Image(GetAssets.getTexture("missile"));
			emissile.scaleX = 2.5;
			emissile.scaleY = 2.5;
			emissile.x = (1600 >> 1) - (emissile.width >> 1);
			emissile.y = emissileBase.y + 250;
			
			missileStartPoint = emissile.y;
			
			this.addEventListener(Event.ENTER_FRAME, checkCollision);
			//	emissile.addEventListener(Event
			
			stage.addChild(emissile);
			
			Sounds.muted = true;
			
			var tempObj1:Image = new Image(GetAssets.getTexture("greenFlight"));
			var tempObj2:Image = new Image(GetAssets.getTexture("greenFlight2"));
			
			
			objectVector = new Vector.<Image>(4, false); 
			objectVector.push(tempObj1);
			objectVector.push(tempObj2); */
			
		
		}
		
		public function animateprogbar():void
		{
			if (!gameOver)
			{
				timebar.height = timebar.height - 10;
				
				if (timebar.height < (-1 * timeLeft / 3))
				{
					
					endGame();
					
				}
			}
		}
		
		public function playbuttonClicked(e:TouchEvent):void
		{
			
			startGame();
		
		}
		
		private function checkCollision(e:EnterFrameEvent):void
		{
			bounds1 = emissile.bounds;
			bounds2 = redFlight.bounds;
			
		//	emissile.hitTest
			
			if (emissile.bounds.intersects(greenFlight.bounds) || emissile.bounds.intersects(greenFlight2.bounds))
			{
				endGame();
				
			}
			else if (bounds1.intersects(bounds2))
				caught = true;
		
		}
		
		private function moveRedFlight():void
		{
			timeTaken = getrandtime();
			
			var tweenMainPage:Tween = new Tween(redFlight, timeTaken);
			tweenMainPage.moveTo(0 - redFlight.width, redFlight.y);
			
			Starling.juggler.add(tweenMainPage);
			tweenMainPage.onComplete = wrapMove;
		
		}
		
		private function showLife():void
		{
			
			if (lifeleft == 2)
			{
				life1.color = 0Xff0000;
			}
			else if (lifeleft == 1)
			{
				life1.color = 0Xff0000;
				life2.color = 0Xff0000;
			}
			
			if (lifeleft == 0)
			{
				life1.color = 0Xff0000;
				life2.color = 0Xff0000;
				life3.color = 0Xff0000;
				endGame();
				
			}
		
		}
		
		private function endGame():void
		{
			
			caught = false;
			gameOver = true;
			missText.visible = true;
			missText.text = "GAME OVER";
			playBtn.visible = true;
			//	bg.visible = false;
			isFirstTime = true;
			hasFired = false;
			
			//	timebar.height = -1;
			timeLeft = 1800;
			
			Starling.juggler.removeTweens(redFlight);
			Starling.juggler.removeTweens(greenFlight);
			Starling.juggler.removeTweens(greenFlight2);
			//	bg.removeEventListeners();
		
		}
		
		private function getrandtime():Number
		{
			if (!isFirstTime)
			{
				return (Math.random() * 2.2) + 0.4;
			}
			else
			{
				return 1;
				
			}
		
		}
		
	private	function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		private function startGame():void
		{
			if (!Sounds.muted)
				Sounds.sndStart.play();
			
			lifeleft = 3;
			gameOver = false;
			playBtn.visible = false;
			hits = 0;
			hitsText.text = hits + "";
			missText.visible = false;
			//	bg.visible = true;
			hasFired = false;
			bg.speed = 5;
			
			Starling.juggler.removeTweens(redFlight);
			Starling.juggler.removeTweens(greenFlight);
			Starling.juggler.removeTweens(greenFlight2);
			
			greenFlight.x = redFlight.x;
			greenFlight2.x = redFlight.x;
			
			life1 = new Quad(60, 60, 0X00ff00);
			life1.y = 30;
			life1.x = stage.stageWidth - 240;
			addChild(life1);
			
			life2 = new Quad(60, 60, 0X00ff00);
			life2.y = 30;
			life2.x = life1.x - 65;
			addChild(life2);
			life3 = new Quad(60, 60, 0X00ff00);
			life3.y = 30;
			life3.x = life2.x - 65;
			addChild(life3);
			
			timebar.height = -1;
			
			isFirstTime = true;
			wrapMove();
			wrapMovegreen1();
			//	wrapMovegreen2();
			moveGreenFlight2();
		
		}
		
		private function moveGreenFlight1():void
		{
			timeTaken1 = getrandtime();
			var tweenMainPage1:Tween = new Tween(greenFlight, timeTaken1);
			tweenMainPage1.moveTo(0 - greenFlight.width, greenFlight.y);
			Starling.juggler.add(tweenMainPage1);
			tweenMainPage1.onComplete = wrapMovegreen1;
		
		}
		
		private function wrapMovegreen1():void
		{
			
			greenFlight.x = stage.stageWidth;
			greenFlight.y = randomRange(100, stage.stageHeight - 500);
			moveGreenFlight1();
		
		}
		
		private function moveGreenFlight2():void
		{
			timeTaken2 = getrandtime();
			var tweenMainPage2:Tween = new Tween(greenFlight2, timeTaken2);
			tweenMainPage2.moveTo(0 - greenFlight2.width, greenFlight2.y);
			Starling.juggler.add(tweenMainPage2);
			
			if (isFirstTime)
			{
				tweenMainPage2.onComplete = addbgEvent;
				
			}
		
		}
		
		private function addbgEvent():void
		{
			
			if (isFirstTime)
			{
				Starling.juggler.removeTweens(greenFlight2);
				bg.addEventListener(TouchEvent.TOUCH, detectGesture);
				isFirstTime = false;
				greenFlight2.x = stage.stageWidth;
			}
			
			timeTaken2 = getrandtime();
			var tweenMainPage2:Tween = new Tween(greenFlight2, timeTaken2);
			tweenMainPage2.moveTo(0 - greenFlight2.width, greenFlight2.y);
			Starling.juggler.add(tweenMainPage2);
			tweenMainPage2.onComplete = wrapMovegreen2;
		
		}
		
		private function wrapMovegreen2():void
		{
			
			greenFlight2.x = stage.stageWidth;
			greenFlight2.y = randomRange(100, stage.stageHeight - 500);
			addbgEvent();
		}
		
		private function wrapMove():void
		{
			
			redFlight.x = stage.stageWidth
			redFlight.y = randomRange(100, stage.stageHeight - 500);
			moveRedFlight();
		
		}
		
		private function rePosition():void
		{
			if (caught)
			{
				hits = hits + 1;
				hitsText.text = hits + "";
			}
			else
			{
				lifeleft--;
				showLife();
			}
			
			emissile.y = missileStartPoint;
			coinMoving = false;
			caught = false;
		
		}
		
		private function detectGesture(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this.stage);
			
			if (!coinMoving)
			{
				if (touch != null)
				{
					
					if (!gameOver)
					{
						if (TouchPhase.ENDED)
						{
							if (!isFirstTime)
							{
								
								if (!Sounds.muted)
									Sounds.sndShoot.play();
								coinMoving = true;
								
								var clicked:DisplayObject = e.currentTarget as DisplayObject;
								var tweenMainPage:Tween = new Tween(emissile, 0.5);
								tweenMainPage.moveTo(emissile.x, 0);
								
								Starling.juggler.add(tweenMainPage);
								tweenMainPage.onComplete = rePosition;
								timebar.height = -1;
								timeLeft = 1800;
								
							}
						}
						
					}
				}
				
			}
		
		}
	
	}

}