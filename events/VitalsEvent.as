package events
{
	import flash.events.Event;
	
	public class VitalsEvent extends Event
	{
		public static const ADD:String = "VitalsEvent.ADD";
		
		public var data:*;
		
		public function VitalsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var event:VitalsEvent = new VitalsEvent(type, bubbles, cancelable);
			event.data = data;
			
			return event;
		}
	}
}