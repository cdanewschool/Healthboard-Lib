package events
{
	import flash.events.Event;
	
	public class ApplicationEvent extends Event
	{
		public static const NAVIGATE:String = "navigate";
		public static const VIEW_FILE:String = "viewFile";
		
		public var data:*;
		
		public function ApplicationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}