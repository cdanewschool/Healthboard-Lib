package edu.newschool.piim.healthboard.view.components.calendar
{
	[Bindable]
	public interface ICalendarItem
	{
		function get description():String;
		function set description(value:String):void;
		
		function get from():Date;
		function set from(value:Date):void;
		
		function get to():Date;
		function set to(value:Date):void;
		
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		
		function get isScheduled():Boolean;
	}
}