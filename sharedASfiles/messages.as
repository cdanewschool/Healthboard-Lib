import components.messages.NewMessage;
import components.messages.ViewMessage;

import flash.events.Event;
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.collections.IList;
import mx.collections.Sort;
import mx.collections.SortField;
import mx.controls.Alert;
import mx.events.CloseEvent;
import mx.events.CollectionEvent;
import mx.events.ListEvent;
import mx.utils.ObjectUtil;

import spark.events.IndexChangeEvent;

[Embed(source="images/bloodyNose.jpg")] private static var myPic:Class;
//fileReference.
//private var myAttachment:Object = {image: fileReference.data, filename: fileReference.name};
//arrImageAttachments.addItem(myAttachment);
		
[Bindable] private var acMessagesToDisplay:ArrayCollection = new ArrayCollection();
[Bindable] public var acTrashMessages:ArrayCollection = new ArrayCollection();

[Bindable] public var areOptionsEnabled:Boolean = true;

[Bindable] public var currentMainBox:String = "Inbox";
public function showInboxMessages():void {
	acMessagesToDisplay.filterFunction = null;
	acMessagesToDisplay.refresh();
	acMessagesToDisplay.removeAll();
	for(var i:uint = 0; i < acMessages.length; i++) {
		for(var j:uint = 0; j < acMessages[i].messages.length; j++) {
			if(acMessages[i].messages[j].sender != "You") {
				acMessagesToDisplay.addItem(acMessages[i]);
				break;
			}
		}
	}
	if(this.currentState == 'modMessages' || this.currentState == 'providerHome') {		//this if statement prevents an error from the Patient Portal's WIDGET VIEW if the messages module hasn't been opened.
		if(acMessagesToDisplay.length > 0) {
			dgMessages.dataProvider = acMessagesToDisplay;	//in case we're returning from the Trash folder
			dgMessages.visible = dgMessages.includeInLayout = true;
			lblNoMessages.visible = lblNoMessages.includeInLayout = false;
			lblNoMessagesFolder.visible = lblNoMessagesFolder.includeInLayout = false;
			areOptionsEnabled = true;
		}
		else {
			dgMessages.visible = dgMessages.includeInLayout = false;
			lblNoMessages.visible = lblNoMessages.includeInLayout = false;
			lblNoMessagesFolder.visible = lblNoMessagesFolder.includeInLayout = true;
			areOptionsEnabled = false;
		}
		
		mainBox.label = "Inbox";
		viewStackMessages.selectedIndex = 0;
		highlightSelectedFolder('Inbox');
		clearCheckBoxes();
		messagesSearch.text = "Search messages";
		lblSearchResults.visible = btnClearSearch.visible = false;
		
		currentMainBox = "Inbox";		//used by the search filter to update mainBox.label after the user has cleared the search field, to know to which label we need to restore the first tab's label
	}
}

public function showSentMessages():void {
	acMessagesToDisplay.filterFunction = null;
	acMessagesToDisplay.refresh();
	acMessagesToDisplay.removeAll();
	for(var i:uint = 0; i < acMessages.length; i++) {
		var loopMax:uint = (acMessages[i].isDraft) ? acMessages[i].messages.length - 1 : acMessages[i].messages.length;			//if the message thread "isDraft", then we don't loop through the last message (which is the draft message)
		for(var j:uint = 0; j < loopMax; j++) {
			if(acMessages[i].messages[j].sender == "You") {
				acMessagesToDisplay.addItem(acMessages[i]);
				break;
			}
		}
	}
	if(acMessagesToDisplay.length > 0) {
		dgMessages.dataProvider = acMessagesToDisplay;	//in case we're returning from the Trash folder
		dgMessages.visible = dgMessages.includeInLayout = true;
		lblNoMessages.visible = lblNoMessages.includeInLayout = false;
		lblNoMessagesFolder.visible = lblNoMessagesFolder.includeInLayout = false;
		areOptionsEnabled = true;
	}
	else {
		dgMessages.visible = dgMessages.includeInLayout = false;
		lblNoMessages.visible = lblNoMessages.includeInLayout = false;
		lblNoMessagesFolder.visible = lblNoMessagesFolder.includeInLayout = true;
		areOptionsEnabled = false;
	}
	mainBox.label = "Sent";
	viewStackMessages.selectedIndex = 0;
	highlightSelectedFolder('Sent');
	clearCheckBoxes();
	messagesSearch.text = "Search messages";
	lblSearchResults.visible = btnClearSearch.visible = false;
	currentMainBox = "Sent";
}

public function showDraftMessages():void {
	acMessagesToDisplay.filterFunction = null;
	acMessagesToDisplay.refresh();
	acMessagesToDisplay.removeAll();
	for(var i:uint = 0; i < acMessages.length; i++) {
		if(acMessages[i].isDraft) acMessagesToDisplay.addItem(acMessages[i]);
	}
	if(acMessagesToDisplay.length > 0) {
		dgMessages.dataProvider = acMessagesToDisplay;	//in case we're returning from the Trash folder
		dgMessages.visible = dgMessages.includeInLayout = true;
		lblNoMessages.visible = lblNoMessages.includeInLayout = false;
		lblNoMessagesFolder.visible = lblNoMessagesFolder.includeInLayout = false;
		areOptionsEnabled = true;
	}
	else {
		dgMessages.visible = dgMessages.includeInLayout = false;
		lblNoMessages.visible = lblNoMessages.includeInLayout = false;
		lblNoMessagesFolder.visible = lblNoMessagesFolder.includeInLayout = true;
		areOptionsEnabled = false;
	}
	mainBox.label = "Drafts";
	viewStackMessages.selectedIndex = 0;
	highlightSelectedFolder('Drafts');
	clearCheckBoxes();
	messagesSearch.text = "Search messages";
	lblSearchResults.visible= btnClearSearch.visible = false;
	currentMainBox = "Drafts";
}

private function showTrashMessages():void {
	acTrashMessages.filterFunction = null;
	acTrashMessages.refresh();
	if(acTrashMessages.length > 0) {
		dgMessages.dataProvider = acTrashMessages;
		dgMessages.visible = dgMessages.includeInLayout = true;
		lblNoMessages.visible = lblNoMessages.includeInLayout = false;
		lblNoMessagesFolder.visible = lblNoMessagesFolder.includeInLayout = false;
		areOptionsEnabled = true;
	}
	else {
		dgMessages.visible = dgMessages.includeInLayout = false;
		lblNoMessages.visible = lblNoMessages.includeInLayout = false;
		lblNoMessagesFolder.visible = lblNoMessagesFolder.includeInLayout = true;
		areOptionsEnabled = false;
	}
	mainBox.label = "Trash";
	viewStackMessages.selectedIndex = 0;
	highlightSelectedFolder('Trash');
	clearCheckBoxes();
	messagesSearch.text = "Search messages";
	lblSearchResults.visible = btnClearSearch.visible = false;
	currentMainBox = "Trash";
}

//I'm clearing all the checkboxes and corresponding arrays after deleting multiple messages, and also after changing folders (otherwise it acts strangely and selects different messages randomly when changing folders), and also other situations...
private function clearCheckBoxes():void {
	areCheckboxesSelected = true;	//setting it to true is necessary so that when we set it to false in the next line it will update its value and deselect the checkboxes... there is likely a better way to do this...
	areCheckboxesSelected = false;
	selectedMessages.splice(0);	//empty array
	areButtonsEnabled = false;
	selectedTrashMessages.splice(0);	//empty array
	areTrashButtonsEnabled = false;
}

private function highlightSelectedFolder(folder:String = "none"):void {
	btnInbox.styleName = "messageFolderNotSelected";
	btnDrafts.styleName = "messageFolderNotSelected";
	btnSent.styleName = "messageFolderNotSelected";
	btnTrash.styleName = "messageFolderNotSelected";
	if(folder == "Inbox") btnInbox.styleName = "messageFolderSelected";
	else if(folder == "Drafts") btnDrafts.styleName = "messageFolderSelected";
	else if(folder == "Sent") btnSent.styleName = "messageFolderSelected";
	else if(folder == "Trash") btnTrash.styleName = "messageFolderSelected";
}

public var arrOpenTabs:Array = new Array();		//to keep track of which messages (or new messages) are "currently" open, so that if trying to open one that's already open, we can select it (this array excludes the "Inbox" and the "Open New Message" tabs)

private function getUnreadMessagesCount():String {
	var unreadMessages:uint = 0;
	for(var i:uint = 0; i < acMessages.length; i++) {
		//original set up:
		/*for(var j:uint = 0; j < acMessages[i].messages.length; j++) {
		if(acMessages[i].messages[j].status == "unread") unreadMessages++;
		}*/
		
		//current:
		var isInboxMessage:Boolean = false
		for(var j:uint = 0; j < acMessages[i].messages.length; j++) {
			if(acMessages[i].messages[j].sender != "You") {
				isInboxMessage = true;
				break;
			}
		}
		if(isInboxMessage) {
			if(acMessages[i].status == "unread") unreadMessages++;
		}
	}
	return (unreadMessages == 0) ? '' : ' (' + unreadMessages + ')';
}

public function getDraftMessagesCount():String {
	var draftMessages:uint = 0;
	for(var i:uint = 0; i < acMessages.length; i++) {
		if(acMessages[i].isDraft) draftMessages++;
	}
	return (draftMessages == 0) ? '' : ' (' + draftMessages + ')';
}

/**
 * This function takes an ID as a parameter, and tells us which message it belongs to.
 * It is used when adding a reply to a message from the ViewMessage component, so we know what message to add the reply to.
 */
public function getMessageIndex(id:uint):uint {
	for(var i:uint = 0; i < acMessages.length; i++) {
		if(acMessages[i].id == id) return i;
	}
	return 0;
}

public var arrNewMessages:Array = new Array();
private var arrNewMessagesIndices:Array;
private var newMessage:NewMessage;
protected function tabbar1_changeHandler(event:IndexChangeEvent):void {
	if(tabsMessages.selectedIndex == viewStackMessages.length - 1) {			//If the user clicked on the "Open New Message" tab
		if(arrOpenTabs.indexOf("NEW") == -1) {									//We check if there are NONE "New Message" tabs open
			createNewMessage();													//Create new message
		}
		else {																	//Else (if there is at least one "New Message" tab open)
			var isThereAnEmptyMessage:Boolean = false;
			for(var i:uint = 0; i < arrNewMessages.length; i++) {				//We loop through the "New Message" tabs open (which we push to the arrNewMessages array every time we open one)
				if(arrNewMessages[i].messageText.text == "") {					//And check if that "New Message" is empty (the user didn't write anything yet)
					isThereAnEmptyMessage = true;
					break;														//We break the loop (i stays equal to the first index of arrNewMessages where there was an empty "New Message")
				}
			}
			if(isThereAnEmptyMessage) {											//If we found one
				arrNewMessagesIndices = populateNewMessageIndices();			//We put in this array, all the tab indices where there is a new message
				viewStackMessages.selectedIndex = arrNewMessagesIndices[i] + 1;	//And we select the first one (i) where there was an empty "New Message"
			}
			else {																//Else (if there are no empty "New Messages")
				createNewMessage();												//We proceed to create a new one.
			}
		}
		highlightSelectedFolder();
	}
	else {					//This "else" block is only to highlight (orange) the corresponding folder name
		if(arrOpenTabs[tabsMessages.selectedIndex - 1] == "NEW") highlightSelectedFolder();		//deselect all folders
		else highlightSelectedFolder(currentMainBox);
	}
}

private function populateNewMessageIndices():Array {
	var returnArray:Array = new Array();
	for(var i:uint = 0; i < arrOpenTabs.length; i++) {
		if(arrOpenTabs[i] == "NEW") returnArray.push(i);
	}
	return returnArray;
}

public function createNewMessage(selectedRecipient:uint = 0):void {		//selectedRecipient is only != 0 when called from the appointments module
	newMessage = new NewMessage();
	viewStackMessages.addChildAt(newMessage,viewStackMessages.length - 1);
	arrNewMessages.push(newMessage);
	arrOpenTabs.push("NEW");
	
	if(selectedRecipient != 0) {
		newMessage.cbRecipients.selectedIndex = selectedRecipient - 1;
		newMessage.cbSubjects.selectedIndex = selectedRecipient - 1;
		newMessage.label = newMessage.cbSubjects.selectedItem;
	}
}

private function openDraftMessage(myData:Object):void {
	newMessage = new NewMessage();
	newMessage.draftMessage = myData;
	viewStackMessages.addChildAt(newMessage,viewStackMessages.length - 1);
	viewStackMessages.selectedIndex = viewStackMessages.length - 2;
	arrNewMessages.push(newMessage);
	arrOpenTabs.push(myData);
}

/**
 * Problems:
 * 1. the skin doesn't work cause it's Spark (not MX)
 * 2. Can't get a single tab to be closeable, yet...
 */
/*
protected function tabsMessages_childIndexChangeHandler(event:ItemClickEvent):void
{
if(tabsMessages.selectedIndex == viewStackMessages.length - 1) {
var newMessage:Message = new Message();
newMessage.setStyle("closable", false);
viewStackMessages.addChildAt(newMessage,viewStackMessages.length - 1);
//tabsMessages.invalidateDisplayList();
//tabsMessages.selectedIndex = viewStackMessages.length - 2;

}
}*/

public function removeTab(message:NewMessage):void {
	viewStackMessages.removeChild(message);
}

[Bindable] private var areMessageButtonsEnabled:Boolean = false;
public function messageCheckbox_clickHandler(event:MouseEvent):void
{
	var isAnyCheckboxSelected:Boolean = false;
	for(var i:uint = 0; i < acMessages.length; i++) {
		/*if(dgMessages.rendererArray[i + 1][1].messageCheckbox.selected) {
		isAnyCheckboxSelected = true;
		break;
		}*/
	}
	areMessageButtonsEnabled = isAnyCheckboxSelected;
}

public function viewMessage(myData:Object):void
{
	var isMessageAlreadyOpen:Boolean = false;
	for(var j:uint = 0; j < arrOpenTabs.length; j++) {
		if(arrOpenTabs[j] == myData) {
			isMessageAlreadyOpen = true;
			viewStackMessages.selectedIndex = j + 1;		//+1 because in arrOpenTabs we don't include the "inbox" tab
			break;
		}
	}				
	if(!isMessageAlreadyOpen) {
		if(!myData.isDraft || myData.messages.length > 1) {		//if the message IS NOT a draft, or if it's a draft for an existing message (i.e. reply)
			var viewMessage:ViewMessage = new ViewMessage();
			viewMessage.messages = myData;		//acMessages[event.rowIndex];
			viewStackMessages.addChildAt(viewMessage,viewStackMessages.length - 1);
			tabsMessages.selectedIndex = viewStackMessages.length - 2;
			arrOpenTabs.push(myData);	
			myData.status = "read";
			for(var i:uint = 0; i < myData.messages.length; i++) {
				myData.messages[i].status = "read";
			}
			btnInbox.label = "Inbox"+getUnreadMessagesCount();
			if(getUnreadMessagesCount() == '') {
				lblMessagesNumber.text = "no";
				lblMessagesNumber.setStyle("color","0xFFFFFF");
				lblMessagesNumber.setStyle("fontWeight","normal");
				lblMessagesNumber.setStyle("paddingLeft",-3);
				lblMessagesNumber.setStyle("paddingRight",-3);
			}
			else lblMessagesNumber.text = getUnreadMessagesCount().substr(2,1);
			dgMessages.invalidateList();
			//lblMessagesNumber.text = (getUnreadMessagesCount() == '') ? 'no' : getUnreadMessagesCount().substr(2,1);	
		}
		else {													//if it's a new message draft
			openDraftMessage(myData);
		}
	}
}

private function calcRowColor(item:Object, rowIndex:int, dataIndex:int, color:uint):uint {
	if(item.status == "read" || item.status == "replied") return 0x4A4A49;
	else return 0x383838;
}

protected function dgMessages_itemClickHandler(event:ListEvent):void {
	if(event.columnIndex == 1) {		//column with checkbox
		//handle checkbox from here?
	}
	else if(event.columnIndex == 4) {	//column with delete btn
		if(currentMainBox != "Trash") {
			acTrashMessages.addItem(acMessages.removeItemAt(acMessages.getItemIndex(event.itemRenderer.data)));
			//acMessages.removeItemAt(event.rowIndex);
			
			btnInbox.label = "Inbox"+getUnreadMessagesCount();
			btnDrafts.label = 'Drafts'+getDraftMessagesCount();
			if(getUnreadMessagesCount() == '') {
				lblMessagesNumber.text = "no";
				lblMessagesNumber.setStyle("color","0xFFFFFF");
				lblMessagesNumber.setStyle("fontWeight","normal");
				lblMessagesNumber.setStyle("paddingLeft",-3);
				lblMessagesNumber.setStyle("paddingRight",-3);
			}
			else lblMessagesNumber.text = getUnreadMessagesCount().substr(2,1);
			
			if(currentMainBox == "Inbox") showInboxMessages();
			else if(currentMainBox == "Sent") showSentMessages();
			else if(currentMainBox == "Drafts") showDraftMessages();
		}
		else {
			Alert.show("Are you sure you want to permanently delete this message?","Message will be deleted permanently",Alert.YES | Alert.CANCEL,this,addArguments(alertListener, [acTrashMessages.getItemIndex(event.itemRenderer.data)]));
		}
	}
	else {
		viewMessage(event.itemRenderer.data);
		//viewMessage(acMessages[event.rowIndex]);
	}
}

// This method will return our function with the additional parameters included
// http://stackoverflow.com/questions/5071468/flex-sending-parameters-to-alert-closehandler
private function addArguments(method:Function, additionalArguments:Array):Function {
	return function(event:Event):void {method.apply(null, [event].concat(additionalArguments));}
}

private function alertListener(eventObj:CloseEvent, myItemIndex:int):void {
	if (eventObj.detail==Alert.YES) acTrashMessages.removeItemAt(myItemIndex);
}

public function displayTime(date:String, format:String = "normal"):String {		//format == short only when called from Messages WIDGET (patient and provider)
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

/**The following two functions were copied from the Adobe documentation:
 * http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Date.html?filter_flash=cs5&filter_flashplayer=10.2&filter_air=2.6#getHours()
 */
private function getUSClockTime(hrs:uint, mins:uint):String {
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

private function doubleDigitFormat(num:uint):String {
	if(num < 10) {
		return ("0" + num);
	}
	return "" + num;	//originally: num as String, but it wasn't working properly
}

[Bindable] public var selectedMessages:Array = new Array();
[Bindable] public var selectedTrashMessages:Array = new Array();
[Bindable] public var areButtonsEnabled:Boolean = false;
[Bindable] public var areTrashButtonsEnabled:Boolean = false;
[Bindable] public var areCheckboxesSelected:Boolean = false;
public function selectMultiple(message:Object, isSelected:Boolean):void {
	if(currentMainBox != "Trash") {
		if(isSelected) selectedMessages.push(message);
		else selectedMessages.splice(selectedMessages.indexOf(message),1);
		areButtonsEnabled = selectedMessages.length > 0 ? true : false;
	}
	else {
		if(isSelected) selectedTrashMessages.push(message);
		else selectedTrashMessages.splice(selectedTrashMessages.indexOf(message),1);
		areTrashButtonsEnabled = selectedTrashMessages.length > 0 ? true : false;
	}
}

private function select(selection:String):void {
	if(currentMainBox != "Trash") {
		if(selection == 'all') {
			areCheckboxesSelected = false;
			areCheckboxesSelected = true;
			selectedMessages.splice(0);
			for(var i:uint = 0; i < acMessagesToDisplay.length; i++) {
				selectedMessages.push(acMessagesToDisplay[i]);
			}
			if(selectedMessages.length > 0) areButtonsEnabled = true;
		}
		else if(selection == 'read') {
			selectedMessages.splice(0);
			for(var j:uint = 0; j < acMessagesToDisplay.length; j++) {
				if(acMessagesToDisplay[j].status == "read") {
					acMessagesToDisplay[j].checkboxSelection = true;
					selectedMessages.push(acMessagesToDisplay[j]);
				}
			}
			areButtonsEnabled = selectedMessages.length > 0 ? true : false;
			areCheckboxesSelected = true;
			areCheckboxesSelected = false;		//resetting this bindable variable here, also makes the checkbox check for the checkboxSelection property on each message.
			for(var z:uint = 0; z < acMessagesToDisplay.length; z++) {
				acMessagesToDisplay[z].checkboxSelection = false;	//reset checkboxSelection to false, since the checkbox has already been selected, and we don't want it to stay selected after other user actions (click on selection buttons, changing folders, etc)
			}	
		}
		else if(selection == 'none') {
			clearCheckBoxes();
		}
	}
	else {
		if(selection == 'all') {
			areCheckboxesSelected = false;
			areCheckboxesSelected = true;
			selectedTrashMessages.splice(0);
			for(var s:uint = 0; s < acTrashMessages.length; s++) {
				selectedTrashMessages.push(acTrashMessages[s]);
			}
			if(selectedTrashMessages.length > 0) areTrashButtonsEnabled = true;
		}
		else if(selection == 'read') {
			selectedTrashMessages.splice(0);
			for(var t:uint = 0; t < acTrashMessages.length; t++) {
				if(acTrashMessages[t].status == "read") {
					acTrashMessages[t].checkboxSelection = true;
					selectedTrashMessages.push(acTrashMessages[t]);
				}
			}
			areTrashButtonsEnabled = selectedTrashMessages.length > 0 ? true : false;
			areCheckboxesSelected = true;
			areCheckboxesSelected = false;
			for(var u:uint = 0; u < acTrashMessages.length; u++) {
				acTrashMessages[u].checkboxSelection = false;	//reset checkboxSelection to false, since the checkbox has already been selected, and we don't want it to stay selected after other user actions (click on selection buttons, changing folders, etc)
			}
		}
		else if(selection == 'none') {
			clearCheckBoxes();
		}
	}
}

private function deleteMultiple():void {
	if(currentMainBox != "Trash") {
		for(var i:uint = 0; i < selectedMessages.length; i++) {
			acTrashMessages.addItem(acMessages.removeItemAt(acMessages.getItemIndex(selectedMessages[i])));
		}
		
		btnInbox.label = "Inbox"+getUnreadMessagesCount();
		btnDrafts.label = 'Drafts'+getDraftMessagesCount();
		if(getUnreadMessagesCount() == '') {
			lblMessagesNumber.text = "no";
			lblMessagesNumber.setStyle("color","0xFFFFFF");
			lblMessagesNumber.setStyle("fontWeight","normal");
			lblMessagesNumber.setStyle("paddingLeft",-3);
			lblMessagesNumber.setStyle("paddingRight",-3);
		}
		else lblMessagesNumber.text = getUnreadMessagesCount().substr(2,1);
		
		if(currentMainBox == "Inbox") showInboxMessages();
		else if(currentMainBox == "Sent") showSentMessages();
		else if(currentMainBox == "Drafts") showDraftMessages();
	}
	else {
		for(var j:uint = 0; j < selectedTrashMessages.length; j++) {
			acTrashMessages.removeItemAt(acTrashMessages.getItemIndex(selectedTrashMessages[j]));
		}
		showTrashMessages();
	}
	clearCheckBoxes();
}

private function markUnread():void {
	if(currentMainBox != "Trash") {
		for(var i:uint = 0; i < selectedMessages.length; i++) {
			acMessages[acMessages.getItemIndex(selectedMessages[i])].status = "unread";
			for(var j:uint = 0; j < acMessages[acMessages.getItemIndex(selectedMessages[i])].messages.length; j++) {
				acMessages[acMessages.getItemIndex(selectedMessages[i])].messages[j].status = "unread";
			}
		}
		
		if(getUnreadMessagesCount() != '') {
			btnInbox.label = "Inbox"+getUnreadMessagesCount();
			lblMessagesNumber.text = getUnreadMessagesCount().substr(2,1);
			lblMessagesNumber.setStyle("color","0xFF931E");
			lblMessagesNumber.setStyle("fontWeight","bold");
		}		
		
		if(currentMainBox == "Inbox") showInboxMessages();
		else if(currentMainBox == "Sent") showSentMessages();
		else if(currentMainBox == "Drafts") showDraftMessages();
	}
	else {
		for(var k:uint = 0; k < selectedTrashMessages.length; k++) {
			acTrashMessages[acTrashMessages.getItemIndex(selectedTrashMessages[k])].status = "unread";
			for(var l:uint = 0; l < acTrashMessages[acTrashMessages.getItemIndex(selectedTrashMessages[k])].messages.length; l++) {
				acTrashMessages[acTrashMessages.getItemIndex(selectedTrashMessages[k])].messages[l].status = "unread";
			}
		}
		showTrashMessages();
	}
}

private function showAll():void {
	if(currentMainBox != 'Trash') {
		acMessagesToDisplay.filterFunction = null;
		acMessagesToDisplay.refresh();
	}
	else {
		acTrashMessages.filterFunction = null;
		acTrashMessages.refresh();
	}
	
	clearCheckBoxes();		//resetting all selections to avoid conflicts
	messagesSearch.text = "Search messages";
	lblSearchResults.visible = btnClearSearch.visible = false;
	dgMessages.visible = dgMessages.includeInLayout = true;
	lblNoMessages.visible = lblNoMessages.includeInLayout = false;
}

private function showUnread():void {
	if(currentMainBox != 'Trash') {
		acMessagesToDisplay.filterFunction = filterUnread;
		acMessagesToDisplay.refresh();
	}
	else {
		acTrashMessages.filterFunction = filterUnread;
		acTrashMessages.refresh();
	}
	
	clearCheckBoxes();		//resetting all selections to avoid conflicts (i.e. if the user filters only "unread" messages while there were "read" messages previously selected, then if the user clicked "DELETE" (and we didn't do the following), then those previously selected messages would be deleted as well, even thought there were not shown on the screen at the moment of deleting...)
	messagesSearch.text = "Search messages";
	lblSearchResults.visible = btnClearSearch.visible = false;
	dgMessages.visible = dgMessages.includeInLayout = true;
	lblNoMessages.visible = lblNoMessages.includeInLayout = false;
}

private function filterUnread(item:Object):Boolean {
	return item.status == "unread";
}

private function messageSort():void {
	if(currentMainBox != "Trash") {
		acMessagesToDisplay.sort = new Sort();
		if(dropDownMessageSort.selectedIndex == 0) {
			var sortField:SortField = new SortField();
			sortField.compareFunction = compareDates;
			acMessagesToDisplay.sort.fields = [sortField];
		}
		else if(dropDownMessageSort.selectedIndex == 1) acMessagesToDisplay.sort.fields = [new SortField("correspondent")];
		else if(dropDownMessageSort.selectedIndex == 2) {
			var sortField2:SortField = new SortField();
			sortField2.compareFunction = compareUrgencies;
			acMessagesToDisplay.sort.fields = [sortField2];
		}
		acMessagesToDisplay.refresh();
	}
	else {
		acTrashMessages.sort = new Sort();
		if(dropDownMessageSort.selectedIndex == 0) {
			var sortFieldTrash:SortField = new SortField();
			sortFieldTrash.compareFunction = compareDates;
			acTrashMessages.sort.fields = [sortFieldTrash];
		}
		else if(dropDownMessageSort.selectedIndex == 1) acTrashMessages.sort.fields = [new SortField("correspondent")];
		else if(dropDownMessageSort.selectedIndex == 2) {
			var sortFieldTrash2:SortField = new SortField();
			sortFieldTrash2.compareFunction = compareUrgencies;
			acTrashMessages.sort.fields = [sortFieldTrash2];
		}
		acTrashMessages.refresh();
	}
	
	clearCheckBoxes();		//resetting selections to avoid possible conflicts (refreshing acMessagesToDisplay causing selections to be set = areCheckboxesSelected, and this ignores any changes made after that...)
}

private function compareDates(itemA:Object, itemB:Object):int {
	var date1:Date = new Date(itemA.date);
	var date2:Date = new Date(itemB.date);
	return (date1.getTime() < date2.getTime()) ? 1 : -1;
}

private function compareUrgencies(itemA:Object, itemB:Object):int {
	//var arrUrgencies:Array = ["Not urgent", "Somewhat urgent", "Urgent"];
	var urgency1:String = itemA.messages[itemA.messages.length - 1].urgency;
	var urgency2:String = itemB.messages[itemB.messages.length - 1].urgency;
	return ObjectUtil.stringCompare(urgency1, urgency2) * -1;								//this is the "shortcut" way of doing this... (we're using it since "Urgent", "Somewhat urgent", and "Not urgent" happen to be inversely alphabetically arranged)
	//if(arrUrgencies.indexOf(urgency1) == arrUrgencies.indexOf(urgency2)) return 0;		//this would be the proper way...
	//else if(arrUrgencies.indexOf(urgency1) < arrUrgencies.indexOf(urgency2)) return 1;
	//else return -1;
}

private function searchFilter():void {
	if(currentMainBox != 'Trash') {
		acMessagesToDisplay.filterFunction = filterSearch;
		acMessagesToDisplay.refresh();
		if(acMessagesToDisplay.length == 0) {
			dgMessages.visible = dgMessages.includeInLayout = false;
			lblNoMessagesFolder.visible = lblNoMessagesFolder.includeInLayout = false;
			lblNoMessages.visible = lblNoMessages.includeInLayout = true;
			//areOptionsEnabled = false;		//commented out because this is messing with the lblNoMessages for some strange reason
		}
		else {
			dgMessages.visible = dgMessages.includeInLayout = true;
			lblNoMessages.visible = lblNoMessages.includeInLayout = false;
			lblNoMessagesFolder.visible = lblNoMessagesFolder.includeInLayout = false;
			//areOptionsEnabled = true;			//commented out because this is messing with the lblNoMessages for some strange reason
		}
	}
	else {
		acTrashMessages.filterFunction = filterSearch;
		acTrashMessages.refresh();
		if(acTrashMessages.length == 0) {
			dgMessages.visible = dgMessages.includeInLayout = false;
			lblNoMessagesFolder.visible = lblNoMessagesFolder.includeInLayout = false;
			lblNoMessages.visible = lblNoMessages.includeInLayout = true;
			//areOptionsEnabled = false;		//commented out because this is messing with the lblNoMessages for some strange reason
		}
		else {
			dgMessages.visible = dgMessages.includeInLayout = true;
			lblNoMessages.visible = lblNoMessages.includeInLayout = false;
			lblNoMessagesFolder.visible = lblNoMessagesFolder.includeInLayout = false;
			//areOptionsEnabled = true;			//commented out because this is messing with the lblNoMessages for some strange reason
		}
	}
	viewStackMessages.selectedIndex = 0;
	if(messagesSearch.text != "") {
		lblSearchResults.text = 'Search Results: "' + messagesSearch.text + '"';
		lblSearchResults.visible = btnClearSearch.visible = true;
	}
	else lblSearchResults.visible = btnClearSearch.visible = false;
	//if(messagesSearch.text != "") mainBox.label = "Search Results: " + messagesSearch.text;
	//else mainBox.label = currentMainBox;
	
	clearCheckBoxes();		//resetting all selections to avoid conflicts (i.e. if the user filters only "abc" messages while there were other messages previously selected, then if the user clicked "DELETE" (and we didn't do the following), then those previously selected messages would be deleted as well, even thought there were not shown on the screen at the moment of deleting...)
}

private function filterSearch(item:Object):Boolean {
	var pattern:RegExp = new RegExp("[^]*"+messagesSearch.text+"[^]*", "i");
	var concatenatedMessages:String = "";
	for(var i:uint = 0; i < item.messages.length; i++) {
		concatenatedMessages += item.messages[i].text;
	}
	return pattern.test(item.correspondent) || pattern.test(item.subject) || pattern.test(concatenatedMessages);
}

private function clearSearch():void {
	if(currentMainBox == "Inbox") showInboxMessages();
	else if(currentMainBox == "Sent") showSentMessages();
	else if(currentMainBox == "Drafts") showDraftMessages();
	else if(currentMainBox == "Trash") showTrashMessages();
}