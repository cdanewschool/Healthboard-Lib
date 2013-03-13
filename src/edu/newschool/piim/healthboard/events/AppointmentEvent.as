package edu.newschool.piim.healthboard.events
{
	import edu.newschool.piim.healthboard.enum.AppointmentType;
	import edu.newschool.piim.healthboard.model.AppointmentCategory;
	
	import flash.events.Event;

	public class AppointmentEvent extends Event
	{
		public static const REQUEST_APPOINTMENT:String = "AppointmentEvent.REQUEST_APPOINTMENT";
		
		public static const VIEW_AVAILABILITY:String = "AppointmentEvent.VIEW_AVAILABILITY";
		
		public static const AVAILABILITY_LOADED:String = "AppointmentEvent.AVAILABILITY_LOADED";
		
		public static const CANCEL_APPOINTMENT:String = "AppointmentEvent.CANCEL_APPOINTMENT";
		public static const CONFIRM_APPOINTMENT:String = "AppointmentEvent.CONFIRM_APPOINTMENT";
		public static const CONFIRM_APPOINTMENT_SUCCESS:String = "AppointmentEvent.CONFIRM_APPOINTMENT_SUCCESS";
		
		public var data:*;
		public var category:AppointmentCategory;
		public var description:String;
		
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