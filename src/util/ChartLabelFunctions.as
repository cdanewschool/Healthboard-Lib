package util
{
	import mx.charts.DateTimeAxis;
	
	import util.DateFormatters;

	public class ChartLabelFunctions
	{
		public static function lblHAxisPlotChartDay(cat:Object, pcat:Object, ax:DateTimeAxis):String 
		{
			return DateFormatters.dateFormatterDay.format(new Date(cat.fullYear, cat.month, cat.dateUTC));				
		}
		
		public static function lblHAxisPlotChartMonth(cat:Object, pcat:Object, ax:DateTimeAxis):String 
		{
			return DateFormatters.dateFormatter.format(new Date(cat.fullYear, cat.month, cat.dateUTC));				
		}
		
		public static function lblHAxisPlotChartYear(cat:Object, pcat:Object, ax:DateTimeAxis):String 
		{
			return DateFormatters.dateFormatterYear.format(new Date(cat.fullYear, cat.month, cat.dateUTC));				
		}
		
		public static function lblHAxisPlotChartDayOnly(cat:Object, pcat:Object, ax:DateTimeAxis):String 
		{
			return DateFormatters.dateFormatterDayOnly.format(new Date(cat.fullYear, cat.month, cat.dateUTC));				
		}
	}
}