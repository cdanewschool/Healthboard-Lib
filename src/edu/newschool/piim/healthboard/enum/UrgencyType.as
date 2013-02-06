package edu.newschool.piim.healthboard.enum
{
	public class UrgencyType
	{
		[Bindable] [Embed(source="/images/messagesUrgentSmall.png")] public static var iconUrgent:Class;
		[Bindable] [Embed(source="/images/messagesSomewhatUrgentSmall.png")] public static var iconSomewhatUrgent:Class;
		
		public static const URGENT:int = 2;
		public static const SOMEWHAT_URGENT:int = 1;
		public static const NOT_URGENT:int = 0;
		
		public static function getUrgencyLabel( urgency:int ):String
		{
			if( urgency == 2 ) return "Urgent";
			if( urgency == 1 ) return "Somewhat urgent";
			
			return "Not urgent";
		}
	}
}