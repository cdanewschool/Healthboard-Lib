package edu.newschool.piim.healthboard.model
{
	import edu.newschool.piim.healthboard.enum.UrgencyType;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Message
	{
		/*public static const URGENCY_NOT_URGENT:String = "Not Urgent";
		public static const URGENCY_URGENT:String = "Urgent";
		public static const URGENCY_SOMEWHAT_URGENT:String = "Somewhat Urgent";*/
		
		public var recipientAlias:String;
		public var recipients:Array;
		public var recipientType:String;
		
		public var subject:String;
		public var body:String;
		public var urgency:int;
		
		public var imageAttachments:ArrayCollection = new ArrayCollection();
		public var nonImageAttachments:ArrayCollection = new ArrayCollection();
		
		public function Message()
		{
			urgency = UrgencyType.NOT_URGENT;
		}
	}
}