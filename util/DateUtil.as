package util
{
	import ASclasses.Constants;

	public class DateUtil
	{
		public static const SECOND:Number = 1000;
		public static const MINUTE:Number = SECOND * 60;
		public static const HOUR:Number = MINUTE * 60;
		public static const DAY:Number = HOUR * 24;
		public static const WEEK:Number = DAY * 7;
		public static const MONTH:Number = WEEK * 4;
		public static const YEAR:Number = MONTH * 12;
		
		public static function formatDateFromString(date:String):String 
		{
			if(date.charAt(1) == '/') date = '0' + date
			if(date.charAt(4) == '/') date = date.substr(0,3) + '0' + date.substr(-6);
			
			return Constants.MONTHS[uint(date.substr(0,2))-1] + ' ' + uint(date.substr(3,2)) + ', ' + date.substr(-4);
		}
		
		public static function get10DigitDate(date:String):String 
		{
			if(date.charAt(1) == '/') date = '0' + date;									// 3/4/2012
			if(date.charAt(4) == '/') date = date.substr(0,3) + '0' + date.substr(-6);		// 03/4/2012
			return date;
		}
	}
}