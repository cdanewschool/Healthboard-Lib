package external.calendar.classes.views
{
	import external.calendar.classes.utils.CommonUtils;
	import external.calendar.mxml_views.weekCell;
	
	import mx.containers.Canvas;
	
	/**
	 * THIS CLASS WILL ALLOW TO GENERATE A LIST OF HOUR CELLS
	 * WHICH WILL BE FROM 00hr. TO 24hr. AND THIS LIST WILL BE GENERATED FOR 7 DAYS IN CURRENT WEEK
	 *
	 * THIS CLASS USES hourCell TO GENERATE THE LIST. IT READ CURRENT DATE TO GENERATE
	 * THE VIEW FOR THAT PARTICULAR WEEK.
	 *
	 * ADDITIONALLY IT CONNECTS WITH DATA HOLDER AND CHECK FOR EVENT EXISTENSE FOR A PARTICULAR
	 * DATE AND GENERATE THE VIEW ACCORDINGLY.
	 *
	 * THIS CLASS IS EXTENDED TO CANVAS SO IT COULD BE USED A DISPLAY OBJECT IN MXML FILES AS WELL.
	 */
	
	public class WeekView extends Canvas
	{
		protected var m_objLastGeneratedDate:Date;		//THESE VARIABLES MADE PROTECTED (from private) BY MICHAEL
		protected var m_intTotalDays:int = 6;
		protected var m_currentDate:Date;
		
		public function WeekView()
		{
			super();
		}
		
		protected function createIntialChildren():void
		{
			var intStartDate:int;
			var intEndDate:int;
			var dt:Date = m_currentDate;
			var dtStart:Date;
			
			if(m_objLastGeneratedDate != dt && currentDate != null)
			{
				m_objLastGeneratedDate = dt;
				
				// calculate start date of the current week
				dt.setDate(dt.getDate() - dt.getDay());
				intStartDate = dt.date;
				dtStart = new Date(dt.getFullYear(), dt.month, dt.date);
				
				// calculate end date of the current week
				dt.setDate(dt.getDate() + (m_intTotalDays - dt.getDay()));
				intEndDate = dt.date;
				
				// now generate view as per week dates
				this.removeAllChildren();
				
				var objHourContainer:Canvas = new Canvas();
				objHourContainer.horizontalScrollPolicy = "off";
				objHourContainer.verticalScrollPolicy = "off";
				this.addChild(objHourContainer);
				objHourContainer.y = 22;
				
				// create left stip which is blue colored strip
				CommonUtils.createLeftHourStrip(objHourContainer);
				
				var objWeekCellContainer:Canvas = new Canvas();
				this.addChild(objWeekCellContainer);
				objWeekCellContainer.id = "myObjWeekCellContainer";			//ADDED BY DAMIAN IN AN ATTEMPT TO BE ABLE TO ACCESS THE objWeekCellContainer FROM THE ROOT APPLICATION
				objWeekCellContainer.x = objHourContainer.getChildAt(0).width;
				objWeekCellContainer.width = 720;
				objWeekCellContainer.verticalScrollPolicy = "off";
				objWeekCellContainer.horizontalScrollPolicy = "off";
				
				// generate hour strip for seven daya i.e. number of days in a week
				for(var i:int=0; i<=m_intTotalDays; i++)
				{
					var objWeekCell:weekCell = new weekCell();
					objWeekCellContainer.addChild(objWeekCell);
					objWeekCell.id = "myObjWeekCell" + i;					//ADDED BY DAMIAN IN AN ATTEMPT TO BE ABLE TO ACCESS THE objWeekCell FROM THE ROOT APPLICATION
					objWeekCell.x = objWeekCell.width * i;
					objWeekCell.lblDate.text = CommonUtils.getDayName(dtStart.day).substr(0, 3) + ", " + String(dtStart.date);		//damian
					
					// generate hour strip from common functions
					CommonUtils.createRightHourStrip(objWeekCell.canDayView, dtStart);
					dtStart.date = dtStart.date + 1;
				}
			}
			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number,
													  unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
		
		// set current date for week view and thereafter generate the view on the basis of this date
		public function set currentDate(_currentDate:Date):void
		{
			m_currentDate = new Date(_currentDate.getFullYear(), _currentDate.month, _currentDate.date);
			createIntialChildren();
		}
		
		public function get currentDate():Date
		{
			return m_currentDate;
		}
		
		//ADDED BY DAMIAN 
		public function displayAppointments():void {
			CommonUtils.displayAppointments();
		}		
	}
}