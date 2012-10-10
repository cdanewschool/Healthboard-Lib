package external.calendar.classes.events
{
	import flash.events.Event;
	
	/**
	 * CUSTOM EVENTS CLASS WILL ALLOWS TO DISPATCH EVENTS
	 * ALONG WITH A OBJECT WHICH SHOULD BE PASSED WHILE DISPATCHING THE EVENT
	 * THIS OBJECT COULD STORE ANY THING AND CAN BE USED WHILE LISTENING TO THE EVENT
	 *
	 * EXTENDS TO EVENT CLASS
	 */
	public class CustomEvents extends Event
	{
		public static const MONTH_VIEW_CLICK:String = "monthViewClick";
		public static const ADD_NEW_EVENT:String = "addNewEvent";
		
		public var object:Object;
		
		public function CustomEvents(type:String, obj:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			object = obj;
			super(type, bubbles, cancelable);
		}
		
	}
}