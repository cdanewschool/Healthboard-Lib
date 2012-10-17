package events
{
	import flash.events.Event;
	
	public class ApplicationDataEvent extends Event
	{
		public static const LOAD:String = "DataEvent.load";
		public static const LOADED:String = "DataEvent.loaded";
		
		public var data:*;
		
		public function ApplicationDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var event:ApplicationDataEvent = new ApplicationDataEvent(type, bubbles, cancelable);
			event.data = data;
			
			return event;
		}
	}
}