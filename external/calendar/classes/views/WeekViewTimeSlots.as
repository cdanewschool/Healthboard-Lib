package external.calendar.classes.views 
{
	import external.calendar.classes.utils.CommonUtils;
	import external.calendar.mxml_views.hourCell;
	import external.calendar.mxml_views.weekCell;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.containers.Canvas;
	import mx.controls.Alert;
	
	public class WeekViewTimeSlots extends WeekView {
		
		private var _timeSlots:Object = null;
		private var _rebuildTimeSlots:Boolean = false;
		private var _hourCells:Array = [];
		
		public function WeekViewTimeSlots() {
			super();
		}
		
		public function set timeSlots(data:Object):void{
			_timeSlots = data;
			rebuildTimeSlots();
		}
		
		//added by DB
		public function setTimeSlots(data:Object):void {
			_timeSlots = data;
			rebuildTimeSlots();
		}
		
		[Bindable]public function get timeSlots():Object{
			return _timeSlots;
		}
		
		protected function rebuildTimeSlots():void{
			var i:int = 0;
			var	currentDate:String;
			var hCell:hourCell;
			
			var dt:Date = m_currentDate;
			var dtStart:Date;
			dtStart = new Date(dt.getFullYear(), dt.month, dt.date);
			dtStart.date = dtStart.date - 6;
			
			var myHour:int = 6;	//changed from 0 to 6, since the calendar now runs from 6am to midnight (instead of 0 to midnight)
			for(i; i<_hourCells.length; i++){
				hCell = _hourCells[i];
				//Alert.show(dtStart.toString());
				
				//if(i == 24 || i == 48 || i == 72 || i == 96 || i == 120 || i == 144) {
				if(i == 18 || i == 36 || i == 54 || i == 72 || i == 90 || i == 108) {		//using these numbers instead, since the weekly calendar now has 18-hour days.
					dtStart.date = dtStart.date + 1;
					myHour = 6;		//changed from 0 to 6, since the calendar now runs from 6am to midnight (instead of 0 to midnight)
				}
				
				hCell.fillSlot(_timeSlots[CommonUtils.formatHourCellDate(hCell)], dtStart, myHour);
				
				myHour++;
			}
		}
		override protected function createIntialChildren():void {
			var intStartDate:int;
			var intEndDate:int;
			var dt:Date = m_currentDate;
			var dtStart:Date;
			
			if((m_objLastGeneratedDate != dt && currentDate != null)) {
				_hourCells = [];
				m_objLastGeneratedDate = dt;
				
				// calculate start date of the current week
				dt.setDate(dt.getDate() - dt.getDay());
				intStartDate = dt.date;
				dtStart = new Date(dt.getFullYear(), dt.month, dt.date);
				
				// calculate end date of the current week
				dt.setDate(dt.getDate() + (m_intTotalDays - dt.getDay()));
				intEndDate = dt.date;
				
				// now generate view as per week dates
				while( numChildren ) removeChildAt( 0 );
				
				var objHourContainer:Canvas = new Canvas();
				objHourContainer.horizontalScrollPolicy = "off";
				objHourContainer.verticalScrollPolicy = "off";
				this.addChild(objHourContainer);
				objHourContainer.y = 22;
				
				trace( objHourContainer.parent );
				
				// create left stip which is blue colored strip
				CommonUtils.createLeftHourStrip(objHourContainer);
				
				var objWeekCellContainer:Canvas = new Canvas();		
				objWeekCellContainer.addEventListener( Event.REMOVED, onRemoved );
				this.addChild(objWeekCellContainer);
				objWeekCellContainer.x = objHourContainer.getChildAt(0).width;
				objWeekCellContainer.width = 720;
				objWeekCellContainer.verticalScrollPolicy = "off";
				objWeekCellContainer.horizontalScrollPolicy = "off";
				
				// generate hour strip for seven daya i.e. number of days in a week
				for(var i:int=0; i<=m_intTotalDays; i++) {	
					var objWeekCell:weekCell = new weekCell();				
					objWeekCellContainer.addChild(objWeekCell);
					objWeekCell.x = objWeekCell.width * i;
					objWeekCell.lblDate.text = String(dtStart.date) + "    " + CommonUtils.getDayName(dtStart.day).substr(0, 3);
					// generate hour strip from common functions
					CommonUtils.createRightHourStripTimeSlots(objWeekCell.canDayView, dtStart, _timeSlots);
					_hourCells = _hourCells.concat(objWeekCell.canDayView.getChildren());
					dtStart.date = dtStart.date + 1;
				}
			}
		}
		
		private function onRemoved( event:Event ):void
		{
			
		}
	}
}