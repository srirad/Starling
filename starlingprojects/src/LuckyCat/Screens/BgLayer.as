package LuckyCat.Screens 
{
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.Event;
	import LuckyCat.GetAssets;
	public class BgLayer extends Sprite{
 
		private var image1:Image;
		private var image2:Image;
		public var speed:Number =0;
		public var parallax:Number;
 
		public function BgLayer()
		{
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addstage);
		}
		private function addstage(event:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, addstage);
		/*	image1=new Image(GetAssets.getTexture("bg"));
			image2 = new Image(GetAssets.getTexture("bg"));
			
			image2.height = 2560;
			image2.width = 1600;
			image1.height = 2560;
			image1.width = 1600;
			
			image1.x=0;
			image1.y = 0;
			
			image2.x = 0; 
			image2.y = image2.height;
			
			
			this.addChild(image1);
			this.addChild(image2);*/
 
		}
 
	}

}