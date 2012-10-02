package events
{
	import flash.events.Event;
	
	import models.Message;
	import models.UserModel;
	
	public class ApplicationEvent extends Event
	{
		public static const NAVIGATE:String = "navigate";
		public static const VIEW_FILE:String = "viewFile";
		
		public static const SHOW_CONTEXT_MENU:String = "showContextMenu";
		
		public var data:*;
		
		public var user:UserModel;
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