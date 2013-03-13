package edu.newschool.piim.healthboard.model.module.appointments
{
	import edu.newschool.piim.healthboard.util.DateUtil;
	import edu.newschool.piim.healthboard.view.components.calendar.ICalendarItem;
	
	[Bindable]
	public class TimeSlot implements ICalendarItem
	{
		private var _from:Date;
		private var _to:Date;
		private var _description:String;
		private var _selected:Boolean;
		
		protected var _scheduled:Boolean;
		
		public function TimeSlot()
		{
		}
		
		public function get description():String{ return _description; }
		public function set description(value:String):void { _description = value; }
		
		public function get from():Date{ return _from; }
		public function set from(value:Date):void { _from = value; }
		
		public function get to():Date{ return _to; }
		public function set to(value:Date):void { _to = value; }

		public function get selected():Boolean { return _selected; }
		public function set selected(value:Boolean):void { _selected = value; }
		
		public function get isScheduled():Boolean { return _scheduled; };
		
		public static function fromObj( data:Object ):TimeSlot
		{
			var val:TimeSlot = new TimeSlot();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					try{ val[prop] = data[prop]; }
					catch(e:Error){}
				}
			}
			
			if( data.hasOwnProperty('from') ) val.from = new Date( Date.parse( DateUtil.modernizeDate( data.from ) ) );
			if( data.hasOwnProperty('to') ) val.to = new Date( Date.parse( DateUtil.modernizeDate( data.to ) ) );
			
			return val;
		}
	}
}