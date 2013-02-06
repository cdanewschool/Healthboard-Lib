package edu.newschool.piim.healthboard.util
{
	import mx.charts.DateTimeAxis;
	
	import edu.newschool.piim.healthboard.util.DateFormatters;

	public class ChartLabelFunctions
	{
		public static function lblHAxisPlotChartDay(cat:Object, pcat:Object, ax:DateTimeAxis):String 
		{
			return DateFormatters.dateFormatterDay.format(new Date(cat.fullYear, cat.month, cat.dateUTC));				
		}
		
		//used for "Medications" chart (which has displayLocalTime="true")
		public static function lblHAxisPlotChartMonth(cat:Object, pcat:Object, ax:DateTimeAxis):String 
		{
			return DateFormatters.dateFormatter.format(new Date(cat.fullYear, cat.month, cat.dateUTC));				
		}
		
		//used for "Medical Records" and "Immunizations" chart (which don't have displayLocalTime="true")
		public static function lblHAxisPlotChartMonth2(cat:Object, pcat:Object, ax:DateTimeAxis):String 
		{
			return DateFormatters.dateFormatter.format(new Date(cat.fullYear, cat.month + 1, cat.dateUTC));				
		}
		
		public static function lblHAxisPlotChartYear(cat:Object, pcat:Object, ax:DateTimeAxis):String 
		{
			return DateFormatters.dateFormatterYear.format(new Date(cat.fullYear, cat.month + 1, cat.dateUTC));				
		}
		
		public static function lblHAxisPlotChartDayOnly(cat:Object, pcat:Object, ax:DateTimeAxis):String 
		{
			return DateFormatters.dateFormatterDayOnly.format(new Date(cat.fullYear, cat.month, cat.dateUTC));				
		}
	}
}