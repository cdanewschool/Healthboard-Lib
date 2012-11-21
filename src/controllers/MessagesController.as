package controllers
{
	import controllers.BaseModuleController;
	
	import enum.RecipientType;
	
	import models.FileUpload;
	import models.modules.MessagesModel;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	public class MessagesController extends BaseModuleController
	{
		[Embed(source="/images/bloodyNose.jpg")] private var myPic:Class;
		
		public function MessagesController()
		{
			super();
			
			model = new MessagesModel();
		}
		
		override public function init():void
		{
			super.init();
			
			var model:MessagesModel = model as MessagesModel;
			
			model.recipientTypes = new ArrayCollection
				(
					[
						{label: "a Physician", data: RecipientType.PROVIDER},
						{label:	"a Nurse", data: RecipientType.NURSE},
						{label:	"an Administrator", data: RecipientType.ADMINISTRATOR},
						{label:	"Front Desk", data: RecipientType.DESK}
					]
				);
			
			model.messages = new ArrayCollection
				(
					[
						{
							status: "unread", correspondent: "Physician", prefix: "a ", date: "Aug 25 2011 02:31:00 PM", subject: "Low glucose levels", isDraft: false, checkboxSelection: false,  messages: 
							[
								{sender: "You", date: "Aug 24 2011 04:45:00 PM", text: "Hi Doctor,\n\nI was looking at my blood test results and realized my glucose levels where low. I sometimes feel nervous and weak, and I was reading on WebMD.com that these are symptoms of hypoglycemia.\n\nShould I come in for a check?", imageAttachments: null, nonImageAttachments: null, urgency: "Somewhat urgent", status: "read"},
								{sender: "Physician", date: "Aug 25 2011 02:31:00 PM", text: "Hi,\n\nAn actual diagnosis of hypoglycemia requires satisfying the \"Whipple triad.\" These three criteria include:\n\n1. Documented low glucose levels (less than 40 mg/dL (2.2 mmol/L), often tested along with insulin levels and sometimes with C-peptide levels)\n2. Symptoms of hypoglycemia when the blood glucose level is abnormally low\n3. Reversal of the symptoms when blood glucose levels are returned to normal\n\nPrimary hypoglycemia is rare and often diagnosed in infancy. People may have symptoms of hypoglycemia without really having low blood sugar. In such cases, dietary changes such as eating frequent small meals and several snacks a day and choosing complex carbohydrates over simple sugars may be enough to ease symptoms.\n\nBottom line: I don't think you have anything to worry about, but let me know if you'd like to come in.", imageAttachments: null, nonImageAttachments: null, urgency: "Not urgent", status: "unread"}
							]
						},
						
						{
							status: "unread", correspondent: "Nurse", prefix: "a ", date: "Aug 22 2011 05:45:00 PM", subject: "Chronic pain", isDraft: false, checkboxSelection: false,  messages: 
							[
								{sender: "Nurse", date: "Aug 22 2011 03:45:00 PM", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip...", imageAttachments: null, nonImageAttachments: null, urgency: "Urgent", status: "read"},
								{sender: "You", date: "Aug 22 2011 04:45:00 PM", text: "Reply number 1...", imageAttachments: null, nonImageAttachments: null, urgency: "Somewhat urgent", status: "read"},
								{sender: "Nurse", date: "Aug 22 2011 05:45:00 PM", text: "3rd messageeeeee", imageAttachments: null, nonImageAttachments: null, urgency: "Not urgent", status: "unread"}
							]
						},
						{
							status: "read", correspondent: "Administration", prefix: "", date: "Aug 21 2011 01:03:54 AM", subject: "Problem sleeping more than a few hours", isDraft: false, checkboxSelection: false,  
							messages: 
							[
								{sender: "Administration", date: "Aug 21 2011 01:03:54 AM", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip...", imageAttachments: null, nonImageAttachments: null, urgency: "Somewhat urgent", status: "read"}
							]
						},
						{
							status: "unread", correspondent: "Front Desk", prefix: "", date: "Feb 2 2011 01:03:54 AM", subject: "Persistent cough", isDraft: false, checkboxSelection: false,  messages: 
							[
								{sender: "Front Desk", date: "Feb 2 2011 01:03:54 AM", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip...", imageAttachments: null, nonImageAttachments: null, urgency: "Urgent", status: "unread"}
							]
						},
						{
							status: "read", correspondent: "Nurse", prefix: "a ", date: "Jan 15 2011 01:03:54 AM", subject: "Your recovery", isDraft: false, checkboxSelection: false,  messages:
							[
								{sender: "Nurse", date: "Jan 15 2011 01:03:54 AM", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip...", imageAttachments: null, nonImageAttachments: null, urgency: "Somewhat urgent", status: "read"}
							]
						},
						{
							status: "read", correspondent: "Administration", prefix: "", date: "Apr 15 2011 01:03:54 AM", subject: "Billing", isDraft: false, checkboxSelection: false, 
							messages: 
							[
								{sender: "You", date: "Apr 15 2011 01:03:54 AM", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip...", imageAttachments: null, nonImageAttachments: null, urgency: "Somewhat urgent", status: "read"}
							]
						},
						{
							status: "read", correspondent: "Nurse", prefix: "a ", date: "Mar 15 2011 01:03:54 AM", subject: "Feeling better", isDraft: false, checkboxSelection: false, 
							messages:
							[
								{sender: "You", date: "Mar 15 2011 01:03:54 AM", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip...", imageAttachments: null, nonImageAttachments: null, urgency: "Somewhat urgent", status: "read"}
							]
						},
						{
							status: "read", correspondent: "Physician", prefix: "a ", date: "Jan 15 2011 01:03:54 AM", subject: "Headache", isDraft: false, checkboxSelection: false, 
							messages: 
							[
								{sender: "You", date: "Jan 15 2011 01:03:54 AM", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip...", imageAttachments: null, nonImageAttachments: null, urgency: "Somewhat urgent", status: "read"}
							]
						},
						{
							status: "read", correspondent: "Physician", prefix: "a ", date: "Dec 24 2010 01:03:54 AM", subject: "Thanks", isDraft: false, checkboxSelection: false, 
							messages: 
							[
								{sender: "You", date: "Dec 24 2010 01:03:54 AM", text: "Hi Doctor,\n\nIt's been a month since my sinus surgery, and I still get periodical nose bleeding. Should I have this checked?", imageAttachments: new ArrayCollection([ new FileUpload('bloodyNose.jpg', 0, myPic)]), nonImageAttachments: null, urgency: "Not urgent", status: "read"}
						]
						},
						{
							status: "read", correspondent: "Front Desk", prefix: "", date: "Nov 29 2010 01:03:54 AM", subject: "Rescheduling checkup", isDraft: false, checkboxSelection: false, 
							messages: 
							[
								{sender: "You", date: "Nov 29 2010 01:03:54 AM", text: "Would it be possible to reschedule tomorrow's appointment to sometime next week?", imageAttachments: null, nonImageAttachments: null, urgency: "Urgent", status: "unread"}
							]
						}
					]
				);
			
			model.messagesToDisplay = new ArrayCollection();
			model.messagesTrash = new ArrayCollection();
			
			model.predefinedSubjects = new ArrayCollection
				(
					[
						'Question about my medication',
						'Question about my recovery',
						'Question about billing',
						'Scheduling an appointment'
					]
				);
			
			model.messages.addEventListener( CollectionEvent.COLLECTION_CHANGE, onMessagesChange );
			
			updateMessageCounts();
		}
		
		public function showMessages( type:String ):void 
		{
			var model:MessagesModel = model as MessagesModel;
			
			model.currentMainBox = type;
			
			if( model.currentMainBox == MessagesModel.TRASH )
			{
				model.messagesTrash.filterFunction = null;
				model.messagesTrash.refresh();	
			}
			else
			{
				model.messagesToDisplay.filterFunction = null;
				model.messagesToDisplay.refresh();
				model.messagesToDisplay.removeAll();
			}
			
			var i:uint;
			
			if( model.currentMainBox == MessagesModel.INBOX )
			{
				for(i = 0; i < model.messages.length; i++) 
				{
					for(var j:uint = 0; j < model.messages[i].messages.length; j++) 
					{
						if(model.messages[i].messages[j].sender != "You") 
						{
							model.messagesToDisplay.addItem( model.messages[i] );
							break;
						}
					}
				}
			}
			else if( model.currentMainBox == MessagesModel.SENT )
			{
				for(i = 0; i < model.messages.length; i++) 
				{
					var loopMax:uint = (model.messages[i].isDraft) ? model.messages[i].messages.length - 1 : model.messages[i].messages.length;			//if the message thread "isDraft", then we don't loop through the last message (which is the draft message)
					
					for(var j:uint = 0; j < loopMax; j++) 
					{
						if(model.messages[i].messages[j].sender == "You") 
						{
							model.messagesToDisplay.addItem(model.messages[i]);
							break;
						}
					}
				}
			}
			else if( model.currentMainBox == MessagesModel.DRAFT )
			{
				for(var i:uint = 0; i < model.messages.length; i++)
				{
					if(model.messages[i].isDraft) model.messagesToDisplay.addItem(model.messages[i]);
				}
			}
		}
		
		//	TODO: use a common date util
		public function displayTime(date:String, format:String = "normal"):String 
		{
			//	format == short only when called from Messages WIDGET (patient and provider)
			var givenDate:Date = new Date(date);
			var oneDayInMillisenconds:Number = 1000*60*60*24;
			var monthLabels:Array = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
			var monthLabelsShort:Array = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
			
			var givenDateNoTime:Date = new Date(date);
			givenDateNoTime.setHours(0,0,0,0);
			var today:Date = new Date();
			today.setHours(0,0,0,0);
			
			if(givenDateNoTime.getTime() == today.getTime()) return getUSClockTime(givenDate.getHours(), givenDate.getMinutes());
			else if(givenDateNoTime.getTime() == today.getTime() - oneDayInMillisenconds) return "Yesterday";
			else return (format == "normal") ? monthLabels[givenDate.getMonth()] + ' ' + givenDate.getDate() + ', ' + givenDate.getFullYear() : monthLabelsShort[givenDate.getMonth()] + ' ' + givenDate.getDate();
		}
		
		private function onMessagesChange(event:CollectionEvent=null):void
		{
			updateMessageCounts();
		}
		
		public function updateMessageCounts():void
		{
			var model:MessagesModel = model as MessagesModel;
			
			var unreadMessages:uint = 0;
			var draftMessages:uint = 0;
			
			for(var i:uint = 0; i < model.messages.length; i++) 
			{
				var isInboxMessage:Boolean = false;
				
				for(var j:uint = 0; j < model.messages[i].messages.length; j++) 
				{
					if(model.messages[i].messages[j].sender != "You") 
					{
						isInboxMessage = true;
						break;
					}
				}
				
				if(isInboxMessage) 
				{
					if(model.messages[i].status == "unread") unreadMessages++;
				}
			}
			
			for(var i:uint = 0; i < model.messages.length; i++) 
			{
				if(model.messages[i].isDraft) draftMessages++;
			}
			
			model.draftMessageCount = draftMessages;
			model.unreadMessageCount = unreadMessages;
		}
		
		/**The following two functions were copied from the Adobe documentation:
		 * http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Date.html?filter_flash=cs5&filter_flashplayer=10.2&filter_air=2.6#getHours()
		 */
		private function getUSClockTime(hrs:uint, mins:uint):String 
		{
			var modifier:String = "pm";
			var minLabel:String = doubleDigitFormat(mins);
			
			if(hrs > 12) {
				hrs = hrs-12;
			} else if(hrs == 0) {
				modifier = "am";
				hrs = 12;
			} else if(hrs < 12) {
				modifier = "am";
			}
			
			return (hrs + ":" + minLabel + modifier);
		}
		
		private function doubleDigitFormat(num:uint):String 
		{
			if(num < 10) {
				return ("0" + num);
			}
			return "" + num;	//originally: num as String, but it wasn't working properly
		}
	}
}