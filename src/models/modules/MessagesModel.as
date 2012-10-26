package models.modules
{
	import models.modules.ModuleModel;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class MessagesModel extends ModuleModel
	{
		public static const INBOX:String = "inbox";
		public static const DRAFT:String = "draft";
		public static const SENT:String = "sent";
		public static const TRASH:String = "trash";
		
		public var messages:ArrayCollection;
		public var messagesToDisplay:ArrayCollection;
		public var messagesTrash:ArrayCollection;
		
		/**
		 * howToHandleMessageTabs is a fix; if we call createNewMessage from the appointments 
		 * module (i.e. sending a msg to a doctor or nurse) or viewMessage from the Widgets module 
		 * before the messages module has been created, then it messes up everything... so, the 
		 * first time we want to createNewMessage from appts or viewMessage from Widgets, we just 
		 * set it to "viewWidgetMessage" or "createApptsMessage", and the corresponding function 
		 * will be called from the messages module instead...
		*/
		public var howToHandleMessageTabs:String = "not created";
		
		public var pendingMessage:Object;
		public var pendingRecipientType:int = -1;
		
		public var currentMainBox:String = "Inbox";
	}
}