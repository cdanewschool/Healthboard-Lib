package edu.newschool.piim.healthboard.events
{
	import flash.events.Event;
	
	public class EnhancedTitleWindowEvent extends Event
	{
		public static const EXPANDED:String = "expanded";
		public static const COLLAPSED:String = "collapsed";
		public static const HEADER_CLICKED:String = "headerClicked";
		
		public function EnhancedTitleWindowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new EnhancedTitleWindowEvent(type, bubbles, cancelable);
		}
	}
}