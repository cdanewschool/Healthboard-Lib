package external.calendar.classes.views
{
	import external.calendar.classes.utils.CommonUtils;
	
	import mx.containers.ApplicationControlBar;
	import mx.containers.Canvas;
	import mx.controls.Label;
	
	/**
	 * THIS CLASS WILL ALLOW TO GENERATE A LIST OF HOUR CELLS
	 * WHICH WILL BE FROM 00hr. TO 24hr.
	 *
	 * THIS CLASS USES hourCell TO GENERATE THE LIST. IT READ CURRENT DATE TO GENERATE
	 * THE VIEW FOR THAT PARTICULAR DATE.
	 *
	 * ADDITIONALLY IT CONNECTS WITH DATA HOLDER AND CHECK FOR EVENT EXISTENSE FOR A PARTICULAR
	 * DATE AND GENERATE THE VIEW ACCORDINGLY.
	 *
	 * THIS CLASS IS EXTENDED TO CANVAS SO IT COULD BE USED A DISPLAY OBJECT IN MXML FILES AS WELL.
	 */
	
	public class DayView extends Canvas
	{
		private var m_currentDate:Date;
		
		public function DayView()
		{
			super();
		}
		
		// function will generate required view
		private function createIntialChildren():void
		{
			this.removeAllChildren();
			
			var objAppCtrlBar:ApplicationControlBar = new ApplicationControlBar();
			var objDateDisplayer:Label = new Label();
			var objHourContainer:Canvas = new Canvas();
			var objButtonContainer:Canvas = new Canvas();
			
			objHourContainer.horizontalScrollPolicy = "off";
			objHourContainer.verticalScrollPolicy = "off";
			objButtonContainer.horizontalScrollPolicy = "off";
			objButtonContainer.verticalScrollPolicy = "off";
			
			this.addChild(objAppCtrlBar);
			objAppCtrlBar.height = 22;
			objAppCtrlBar.width = this.width;
			objAppCtrlBar.styleName = "appBarDayCell";
			
			objAppCtrlBar.addChild(objDateDisplayer);
			
			this.addChild(objHourContainer);
			this.addChild(objButtonContainer);
			
			objDateDisplayer.text = currentDate.toDateString();
			objDateDisplayer.styleName = "lblViewTitle";
			objDateDisplayer.height = 20;
			objHourContainer.y = objDateDisplayer.height;
			objButtonContainer.y = objDateDisplayer.height;
			
			// common functions which generate hourCell in a loop and present the required view
			CommonUtils.createLeftHourStrip(objHourContainer);
			CommonUtils.createRightHourStrip(objButtonContainer, currentDate);
			
			objButtonContainer.x = objHourContainer.getChildAt(0).width;
			
		}
		
		// prorperty is being set by main.mxml which allow to generate this view as per received date
		public function set currentDate(_currentDate:Date):void
		{
			if(_currentDate != null)
			{
				m_currentDate = new Date(_currentDate.getFullYear(), _currentDate.month, _currentDate.date);;
				createIntialChildren();
			}
			
		}
		
		public function get currentDate():Date
		{
			return m_currentDate;
		}
	}
}
