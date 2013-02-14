package edu.newschool.piim.healthboard.model
{
	import edu.newschool.piim.healthboard.enum.UrgencyType;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Message
	{
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