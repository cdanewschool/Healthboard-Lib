package edu.newschool.piim.healthboard.view.components.calendar
{
	import flash.events.Event;
	
	public class CalendarEvent extends Event
	{
		public static const SELECT:String = "CalendarEvent.SELECT";
		
		public var data:ICalendarItem;
		
		public function CalendarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var event:CalendarEvent = new CalendarEvent(type, bubbles, cancelable);
			event.data = data;
			
			return event;
		}
	}
}