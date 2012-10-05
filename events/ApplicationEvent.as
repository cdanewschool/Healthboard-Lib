package events
{
	import flash.events.Event;
	
	import models.Message;
	
	public class ApplicationEvent extends Event
	{
		public static const NAVIGATE:String = "navigate";
		
		public static const SET_STATE:String = "setState";
		
		public static const VIEW_FILE:String = "viewFile";
		
		public var data:*;
		
		public var message:Message;
		
		public function ApplicationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var event:ApplicationEvent = new ApplicationEvent(type, bubbles, cancelable);
			event.data = data;
			
			return event;
		}
	}
}