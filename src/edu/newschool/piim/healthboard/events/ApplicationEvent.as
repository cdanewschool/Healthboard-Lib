package edu.newschool.piim.healthboard.events
{
	import flash.events.Event;
	
	import edu.newschool.piim.healthboard.model.Message;
	
	public class ApplicationEvent extends Event
	{
		public static const NAVIGATE:String = "navigate";
		
		public static const SET_STATE:String = "setState";
		
		public static const VIEW_FILE:String = "viewFile";
		
		public static const SHOW_STATUS:String = "showStatus";
		
		public static const STYLES_LOADED:String = "stylesLoaded";
		
		public var data:*;
		
		public var message:Message;
		
		public function ApplicationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:* = null )
		{
			super(type, bubbles, cancelable);
			
			this.data = data;
		}
		
		override public function clone():Event
		{
			var event:ApplicationEvent = new ApplicationEvent(type, bubbles, cancelable);
			event.data = data;
			
			return event;
		}
	}
}