package models.modules
{
	import models.modules.ModuleModel;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	
	[Bindable]
	public class MessagesModel extends ModuleModel
	{
		public static const ID:String = "messages";
		
		public static const INBOX:String = "inbox";
		public static const DRAFT:String = "draft";
		public static const SENT:String = "sent";
		public static const TRASH:String = "trash";
		
		public var messages:ArrayCollection;
		public var messagesToDisplay:ArrayCollection;
		public var messagesTrash:ArrayCollection;
		public var recipientTypes:ArrayCollection;
		
		public var pendingMessage:Object;
		public var pendingRecipientType:String;
		public var pendingRecipients:Array;
		
		public var currentMainBox:String = INBOX;
		
		public var draftMessageCount:int;
		public var unreadMessageCount:int;
		
		public var predefinedSubjects:ArrayCollection;
		public var dateFormatter:DateFormatter;
	}
}