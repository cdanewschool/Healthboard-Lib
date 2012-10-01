package models
{
	public class Message
	{
		public static const URGENCY_NOT_URGENT:String = "Not Urgent";
		public static const URGENCY_URGENT:String = "Urgent";
		public static const URGENCY_SOMEWHAT_URGENT:String = "Somewhat Urgent";
		
		public var recipientAlias:String;
		public var recipients:Array;
		
		public var urgency:String;
		public var body:String;
		
		public function Message()
		{
			urgency = URGENCY_NOT_URGENT;
		}
	}
}