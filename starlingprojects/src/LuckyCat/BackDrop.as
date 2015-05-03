package LuckyCat
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import LuckyCat.Screens.InGame;
	import starling.animation.Tween;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import LuckyCat.GetAssets;
	import LuckyCat.FullScreenExtension;
	import LuckyCat.events.NavigationEvent;
	import starling.animation.Transitions;
	import starling.core.Starling;
	
//	import StarlingTemp.Constants;
	
	/**
	 * ...
	 * @author Srini
	 */
	public class BackDrop extends Sprite
	{
		private var inGame:InGame;
		private var fullBg:Sprite;
		
		public function BackDrop()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			inGame = new InGame();
			FullScreenExtension.stage.addChild(inGame);
		}

	}
}