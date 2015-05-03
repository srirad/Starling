package LuckyCat 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import starling.core.Starling;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import LuckyCat.FullScreenExtension;
	import citrus.objects.CitrusSprite;
	import starling.extensions.particles.PDParticleSystem;
	import LuckyCat.GetParticleAssets;
	import starling.textures.Texture;
	
	
	
	
	[SWF(frameRate="60",backgroundColor="0X000000")] 
	
	public class InitializeStarling extends Sprite
	{
		public static var mStarling:Starling;
		public static var missileparticle:CitrusSprite;
		
		public function InitializeStarling()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		
		}
		
		private function onAdded(e:Event):void
		{
			mStarling = FullScreenExtension.createStarling(BackDrop, stage, stage.stageWidth, stage.stageHeight, "center", "center");
	//		mStarling.antiAliasing = 1;
//			configureBackBuffer(32, 32, mAntiAliasing, false);
 
			mStarling.start();
		
		}
	}
}
