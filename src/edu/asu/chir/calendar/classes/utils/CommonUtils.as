package edu.asu.chir.calendar.classes.utils
{
	import edu.newschool.piim.healthboard.events.AppointmentEvent;
	
	import edu.asu.chir.calendar.classes.model.DataHolder;
	import edu.asu.chir.calendar.mxml_views.hourCell;
	import edu.asu.chir.calendar.mxml_views.hourCellLeftStrip;
	
	import flash.events.MouseEvent;
	
	import edu.newschool.piim.healthboard.model.module.appointments.PatientAppointment;
	
	import mx.containers.Canvas;
	import mx.controls.Button;
	
	import edu.newschool.piim.healthboard.util.DateUtil;
	
	/**
	 * COMMON UTILS CLASS CONATINS ALL COMMON FUNCTIONS/VARIABLES
	 * WHICH COULD BE USED BY DIFFERENT CLASSES OR VIEWS
	 */
	
	public class CommonUtils
	{
		// used to send values to Event Form
		[Bindable]
		public static var hour:int
		
		// used to send values to Event Form
		[Bindable]
		public static var meridiem:int;
		
		// used to send values to Event Form
		[Bindable]
		public static var mins:int;
		
		// used to send values to Event Form
		[Bindable]
		public static var description:String;
		
		// used to send values to Event Form
		[Bindable]
		public static var currentDate:Date;
		
		// Constructor
		public function CommonUtils()
		{
		}
		
		/**
		 * returns day name for a particular day number in a week
		 */
		public static function getDayName(_intDayNumber:int):String
		{
			_intDayNumber++;
			switch (_intDayNumber)
			{
				case 1:
					return "Sunday";
					break;
				case 2:
					return "Monday";
					break;
				case 3:
					return "Tuesday";
					break;
				case 4:
					return "Wednesday";
					break;
				case 5:
					return "Thursday";
					break;
				case 6:
					return "Friday";
					break;
				case 7:
					return "Saturday";
					break;
				default:
					return "no day";
			}
		}
		
		/**
		 * returns day count for a month
		 */
		public static function getDaysCount(_intMonth:int, _intYear:int):int
		{
			_intMonth ++;
			switch (_intMonth)
			{
				case 1:
				case 3:
				case 5:
				case 7:
				case 8:
				case 10:
				case 12:
					return 31;
					break;
				case 4:
				case 6:
				case 9:
				case 11:
					return 30;
					break;
				case 2:
					if((_intYear % 4 == 0 && _intYear % 100 != 0) || _intYear % 400 ==0)
					{
						return 29;
					}
					else
					{
						return 28;
					}
					break;
				default:
					return -1;
			}
		}
		
		/**
		 * creates blue color strip which shows hours in week and day view
		 */
		public static function createLeftHourStrip(_parent:Canvas):void
		{
			for(var i:int=6; i<24; i++)
			{
				var strLabel:String = "";
				var objLeftStrip:hourCellLeftStrip = new hourCellLeftStrip();
				objLeftStrip.y = objLeftStrip.height * (i - 6);
				_parent.addChild(objLeftStrip);
				
				/*if(i == 0)
				{
					objLeftStrip.lblMins.text = "am";
				}
				else if(i == 12)
				{
					objLeftStrip.lblMins.text = "pm";
				}
				else
				{
					objLeftStrip.lblMins.text = "00";
				}*/	//commented out by Damian
				
				/*if(i == 0)
				{
					strLabel = "12";
				}
				else if(i>12)
				{
					strLabel = String(i-12);
				}
				else
				{*/		//commented out (damian)
					strLabel = String(i);
				//}
				
				strLabel = (strLabel.length < 2) ? ("0" + strLabel) : strLabel;
				
				objLeftStrip.lblHours.text = strLabel;
				
			}
		}
		
		/**
		 * FUNCTION ADDED BY MICHAEL
		 * creates right strip which shows buttons in week and day view. which allow user to set
		 * some new events on a particular time. But only allows certain times to be clicked... I hope...
		 */
		public static function createRightHourStripTimeSlots(_parent:Canvas, _savedDate:Date, timeSlots:Object):void 
		{
			var intStartDate:int;
			
			for(var i:int=6; i<24; i++) 
			{
				var strLabel:String;
				
				var objHourCell:hourCell = new hourCell();
				objHourCell.y = objHourCell.height * (i - 6);
				
				_parent.addChild(objHourCell);
				
				if(i == 0) strLabel = "12";
				else if(i>12) strLabel = String(i-12);
				else strLabel = String(i);
				
				strLabel = (strLabel.length < 2) ? ("0" + strLabel) : strLabel;
				var dt:* = _savedDate != null ? new Date(_savedDate.getFullYear(), _savedDate.month, _savedDate.date) : null;
				objHourCell.data = {date: dt, time: strLabel, meridiem: (i < 12? "am" : "pm")};
				
				var currentDate:String = CommonUtils.formatHourCellDate(objHourCell);
				
				// check if event already saved for current time then show its description
				for(var j:int=0; j<DataHolder.getInstance().dataProvider.length; j++) 
				{
					var obj:PatientAppointment = DataHolder.getInstance().dataProvider[j];
					
					if( DateUtil.dateCompare(obj.date, _savedDate) )
					{
						if(parseInt(obj.hour) == parseInt(strLabel) && obj.meridiem == objHourCell.data.meridiem)
						{
							if(obj.mins == 0)
							{
								objHourCell.btnFirstHalf.label = obj.description;
								objHourCell.btnFirstHalf.visible = true;
								objHourCell.btnFirstHalf.styleName = obj.selected ? "btnSelectedAppointments" : "btnRequestedAppointments";
								objHourCell.btnFirstHalf.buttonMode = false;
								objHourCell.btnFirstHalf.id = currentDate + '1';
								objHourCell.btnFirstHalf.addEventListener(MouseEvent.CLICK, func(obj));
							}
							else
							{
								objHourCell.btnSecondHalf.label = obj.description;
								objHourCell.btnSecondHalf.visible = true;
								objHourCell.btnSecondHalf.styleName = obj.selected ? "btnSelectedAppointments" : "btnRequestedAppointments";
								objHourCell.btnSecondHalf.buttonMode = false;
								objHourCell.btnSecondHalf.id = currentDate + '2';
								objHourCell.btnSecondHalf.addEventListener(MouseEvent.CLICK, func(obj));
							}
						}
					}
				}
			}
		}
		
		//DB
		//see http://nwebb.co.uk/blog/?p=243
		private static function func(myObj:Object):Function 
		{
			return function(mouseEvent:MouseEvent):void 
			{
				onDayViewClick(mouseEvent,myObj);		//set this appointment = selected, and all the others = not selected (and also updates the right column)
			}
		}
		
		/**
		 * FUNCTION ADDED BY MICHAEL
		 * get a formated string of HourCell date
		 */
		public static function formatHourCellDate(hCell:hourCell):String
		{
			return 'date-' 
			+ (hCell.data.date.month + 1) 
				+'-'+ (hCell.data.date.date) 
				+'-'+ (hCell.data.date.fullYear) 
				+':'+ hCell.data.time+''
				+ hCell.data.meridiem;
		}
		
		
		/**
		 * creates right strip which shows buttons in week and day view. which allow user to set
		 * some new events on a particular time.
		 */
		public static function createRightHourStrip(_parent:Canvas, _savedDate:Date = null):void
		{
			for(var i:int=0; i<24; i++)
			{
				var strLabel:String;
				var objHourCell:hourCell = new hourCell();
				objHourCell.y = objHourCell.height * i;
				_parent.addChild(objHourCell);
				
				if(i == 0)
				{
					strLabel = "12";
				}
				else if(i>12)
				{
					strLabel = String(i-12);
				}
				else
				{
					strLabel = String(i);
				}
				
				strLabel = (strLabel.length < 2) ? ("0" + strLabel) : strLabel;
				
				var dt:* = _savedDate != null ? new Date(_savedDate.getFullYear(), _savedDate.month, _savedDate.date) : null;
				objHourCell.data = {date: dt, time: strLabel, meridiem: (i < 12? "am" : "pm")};
				
				// check if event already saved for current time then show its description
				for(var j:int=0; j<DataHolder.getInstance().dataProvider.length; j++)
				{
					var obj:PatientAppointment = DataHolder.getInstance().dataProvider[j];
					
					if( DateUtil.dateCompare(obj.date, _savedDate) )
					{
						if(obj.hour == strLabel && obj.meridiem == objHourCell.data.meridiem)
						{
							if(obj.mins == 0)
							{
								objHourCell.btnFirstHalf.label = obj.description;
							}
							else
							{
								objHourCell.btnSecondHalf.label = obj.description;
							}
						}
					}
				}
			}
		}
		
		public static function displayAppointments():void 
		{
			var objHourCell:hourCell;
			var mybtn:Button = new Button();
			mybtn.styleName="btnDayItems";
			mybtn.label="+ Click to Request";
			mybtn.id="btnFirstHalf";
			objHourCell.addChild(mybtn);
		}
		
		/**
		 * Click event of buttons of First and Second half of a hour
		 * set various values like hour, meridiem, date
		 * these values are used by Event Form
		 */
		private static function onDayViewClick(event:MouseEvent,obj:Object):void
		{
			var btn:Button = Button(event.target);
			var objHourCell:hourCell = hourCell(btn.parent);
			
			if(event.target.toString().indexOf("btnFirstHalf") != -1)
			{
				hour = objHourCell.data.time == "12" ? 0 : int(objHourCell.data.time);
				meridiem = objHourCell.data.meridiem == "am"? 0 : 1;
				mins = 0;
			}
			else if(event.target.toString().indexOf("btnSecondHalf") != -1)
			{
				hour = objHourCell.data.time == "12" ? .5 : int(objHourCell.data.time) + .5;
				meridiem = objHourCell.data.meridiem == "am"? 0 : 1;
				mins = 1;
			}
			currentDate = objHourCell.data.date;
			description = btn.label;
			
			var evt:AppointmentEvent = new AppointmentEvent( AppointmentEvent.VIEW_CLASS, true );
			evt.data = obj;
			objHourCell.dispatchEvent( evt );
		}
		
	}
}
