package LuckyCat.Screens 
{
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import flash.ui.Keyboard;
//	import flash.events.Event;
 
	public class Background extends Sprite
	{
		private var bg:BgLayer;
		public var speed:Number =0;
		public function Background()
		{
 
			addEventListener(starling.events.Event.ADDED_TO_STAGE, addstage);
		}
		private function addstage(event:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, addstage);
			bg=new BgLayer();
		//	bg1=new BgLayer();
			bg.parallax=10;
			//bg1.parallax=1.5;
			this.addChild(bg);
			//this.addChild(bg1);
		//	this.addEventListener(starling.events.Event.ENTER_FRAME, enterframe);
		}
		private function enterframe(e:EnterFrameEvent):void
		{
			bg.y-=speed*bg.parallax*e.passedTime;
			if(bg.y <= -stage.stageWidth)
			{
        		bg.y =0;
    		}
		}
 
		public function initialize():void
		{
			this.visible=true;
		}
	}

}