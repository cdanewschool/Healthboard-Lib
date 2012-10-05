package events
{
	import flash.events.Event;
	
	public class RecommendationEvent extends Event
	{
		public static const HANDLE:String = "RecommendationEvent.HANDLE";
		
		public var data:*;
		
		public function RecommendationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:* = null )
		{
			super(type, bubbles, cancelable);
			
			this.data = data;
		}
		
		override public function clone():Event
		{
			var event:RecommendationEvent = new RecommendationEvent(type, bubbles, cancelable);
			event.data = data;
			
			return event;
		}
	}
}