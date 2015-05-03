package LuckyCat.events
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Srini
	 */
	public class NavigationEvent extends Event
	{
		public static const CHANGE_SCREEN:String = "ChangeScreen";
		
		
		public var params:Object;
		
		public function NavigationEvent(type:String, _params:Object = null, bubbles:Boolean = false)
		{
			super(type, bubbles);
			this.params = _params;
		}
	
	}

}