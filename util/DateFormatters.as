package util
{
	import mx.formatters.DateFormatter;

	public class DateFormatters
	{
		public static var dateFormatter:DateFormatter = new DateFormatter();
		dateFormatter.formatString = "MMM YY";
		
		public static var dateFormatterDay:DateFormatter = new DateFormatter();
		dateFormatterDay.formatString = "EEE, MMM D";
		
		public static var dateFormatterYear:DateFormatter = new DateFormatter();
		dateFormatterYear.formatString = "YYYY";
		
		public static var dateFormatterToday:DateFormatter = new DateFormatter();
		
		public static var dateFormatterDayOnly:DateFormatter = new DateFormatter();
		dateFormatterDayOnly.formatString = "EEE";
	}
}