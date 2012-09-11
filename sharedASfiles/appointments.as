import ASclasses.Constants;

/**The following variables and function are used by the Appointments WIDGET.
 * Ideally, we shouldn't have to re-declare all the appointments statically here. This was only done because when we load the widget view, we don't have access to the DataHolder appointments, since addInitialAppointments() hasn't been called yet.
 * When trying to call addInitialAppointments() or onApplicationStart() before loading the widget view (i.e. on application start), there were errors, mainly due to the fact that the appointments state wasn't yet loaded; even after setting the state's itemCreationPolicy="immediate".
 */
[Bindable] [Embed("images/blueArrowLeft.png")] public var blueArrowLeft:Class;
[Bindable] [Embed("images/blueArrowRight.png")] public var blueArrowRight:Class;
[Bindable] [Embed("images/grayArrowLeft.png")] public var grayArrowLeft:Class;
[Bindable] [Embed("images/grayArrowRight.png")] public var grayArrowRight:Class;
[Bindable] public var appointments:Array;
[Bindable] public var currentAppt:uint = 10;
public function populateDatesForWidget():void {
	var myDate:Date = new Date(new Date().setHours(0,0,0,0));
	var daysToAddToReachWednesday:Array = [3,2,1,7,6,5,4];
	var daysToAddToReachFriday:Array = [5,4,3,2,1,7,6];
	var nextWeekButNotWednesday:uint = (myDate.getDay() != 3) ? 7 : 8;
	appointments = new Array({month:"JULY", date: 7, daytime: "THURSDAY 11:00 AM", details: "Nasal Procedure\nDr. Berg\n(999) 999-9999"},
		{month:"AUGUST", date: 11, daytime: "THURSDAY 11:00 AM", details: "Consultation\nDr. Hammond\n(999) 999-9999"},
		{month:"AUGUST", date: 11, daytime: "THURSDAY 1:00 PM", details: "Surgery\nDr. Berg\n(999) 999-9999"},
		{month:"AUGUST", date: 11, daytime: "THURSDAY 4:00 PM", details: "Blood Test\nDr. Rothstein\n(999) 999-9999"},
		{month:"AUGUST", date: 11, daytime: "THURSDAY 7:00 PM", details: "Cardiac Stress Test\nDr. Hammond\n(999) 999-9999"},
		{month:"SEPTEMBER", date: 16, daytime: "FRIDAY 11:00 AM", details: "Physician Examination\nDr. Berg\n(999) 999-9999"},
		{month:"SEPTEMBER", date: 16, daytime: "FRIDAY 1:00 PM", details: "MRI\nDr. Berg\n(999) 999-9999"},
		{month:"OCTOBER", date: 7, daytime: "FRIDAY 11:00 AM", details: "Appendectomy\nDr. Berg\n(999) 999-9999"},
		{month:"OCTOBER", date: 7, daytime: "FRIDAY 1:00 PM", details: "Colonscopy\nDr. Berg\n(999) 999-9999"},
		{month:"OCTOBER", date: 16, daytime: "MONDAY 1:00 PM", details: "MRI\nDr. Berg\n(999) 999-9999"},
		{month:String(Constants.MONTHS[today.getMonth()]).toUpperCase(), date: today.getDate(), daytime: Constants.DAYS[today.getDay()] + ' 11:00 AM', details: "Physical Examination\nDr. Berg\n(999) 999-9999"},
		{month:String(Constants.MONTHS[new Date(new Date().setDate(myDate.date + daysToAddToReachWednesday[today.getDay()])).getMonth()]).toUpperCase(), date: new Date(new Date().setDate(myDate.date + daysToAddToReachWednesday[today.getDay()])).getDate(), daytime: 'WEDNESDAY 11:00 AM', details: "Physical Therapy\nDr. Berg\n(999) 999-9999"},
		{month:String(Constants.MONTHS[new Date(new Date().setDate(myDate.date + daysToAddToReachFriday[today.getDay()])).getMonth()]).toUpperCase(), date: new Date(new Date().setDate(myDate.date + daysToAddToReachFriday[today.getDay()])).getDate(), daytime: 'FRIDAY 9:30 AM', details: "Allergies\nDr. Greenfield\n(999) 999-9999"},
		{month:String(Constants.MONTHS[new Date(new Date().setDate(myDate.date + nextWeekButNotWednesday)).getMonth()]).toUpperCase(), date: new Date(new Date().setDate(myDate.date + nextWeekButNotWednesday)).getDate(), daytime: (myDate.getDay() != 3) ? Constants.DAYS[myDate.getDay()] + ' 11:30 AM' : 'THURSDAY 11:30 AM', details: "Flu Vaccination\nDr. Berg\n(999) 999-9999"});
	
}