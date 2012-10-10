package util
{
	import ASclasses.Constants;

	public class DateUtil
	{
		public static function formatDateFromString(date:String):String 
		{
			if(date.charAt(1) == '/') date = '0' + date
			if(date.charAt(4) == '/') date = date.substr(0,3) + '0' + date.substr(-6);
			
			return Constants.MONTHS[uint(date.substr(0,2))-1] + ' ' + uint(date.substr(3,2)) + ', ' + date.substr(-4);
		}
	}
}