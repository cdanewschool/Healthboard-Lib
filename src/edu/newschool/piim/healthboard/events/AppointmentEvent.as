package edu.newschool.piim.healthboard.events
{
	import flash.events.Event;

	public class AppointmentEvent extends Event
	{
		public static const ADD_APPOINTMENT:String = "AppointmentEvent.ADD_APPOINTMENT";
		public static const ADD_CLASS:String = "AppointmentEvent.ADD_CLASS";
		
		public static const CANCEL_APPOINTMENT:String = "AppointmentEvent.CANCEL_APPOINTMENT";
		public static const REQUEST_APPOINTMENT:String = "AppointmentEvent.REQUEST_APPOINTMENT";
		public static const REQUEST_CLASS:String = "AppointmentEvent.REQUEST_CLASS";
		
		public static const VIEW_CLASS:String = "AppointmentEvent.VIEW_CLASS";
		public static const VIEW_AVAILABILITY:String = "AppointmentEvent.VIEW_AVAILABILITY";
		
		public var data:*;
		
		public function AppointmentEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:*=null)
		{
			super(type, bubbles, cancelable);
			
			this.data = data;
		}
		
		override public function clone():Event
		{
			var event:AppointmentEvent = new AppointmentEvent(type, bubbles, cancelable, data);
			return event;
		}
	}
}