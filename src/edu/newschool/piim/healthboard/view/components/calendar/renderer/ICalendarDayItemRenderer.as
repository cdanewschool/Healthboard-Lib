package edu.newschool.piim.healthboard.view.components.calendar.renderer
{
	import mx.collections.ArrayCollection;

	public interface ICalendarDayItemRenderer
	{
		function get date():Date;
		
		function set selectable(value:Boolean):void;
		function get selectable():Boolean;
		
		function set selected(value:Boolean):void;
		function get selected():Boolean;
		
		function set appointments(value:ArrayCollection):void;
		function get appointments():ArrayCollection;
	}
}