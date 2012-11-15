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
		public static const MONTH:Number = DAY * 30.4368;
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
		
		public static function compareByDate( item:Object, item2:Object, fields:Array = null):int
		{
			if( item.date.time > item2.date.time ) return 1;
			else if( item.date.time < item2.date.time ) return-1;
			
			return 0;
		}
		
		public static  function modernizeDate( value:String ):String
		{
			var dateTimeParts:Array = value.split(' ');
			var date:String = dateTimeParts[0];
			var time:String = dateTimeParts.length > 1 ? ' ' + dateTimeParts[1] : '';
			
			var dateParts:Array = date.split('/');
			
			var today:Date = AppProperties.getInstance().controller.model.today;
			
			var now:Date = new Date( today.fullYear, today.month, today.date );
			
			var x= dateParts[0].substr(1);
			
			if( dateParts[0] == "*" ) 
				dateParts[0] = now.month;
			else if( new RegExp( /-|\+/ ).exec( dateParts[0] ) == null )
				now.month = parseInt( dateParts[0] );
			else 
				now.time += parseInt( dateParts[0].charAt(0) == "+" ? dateParts[0].substr(1) : dateParts[0] ) * MONTH;
			
			if( dateParts[1] == "*" ) 
				dateParts[1] = now.date;
			else if( new RegExp( /-|\+/ ).exec( dateParts[1] ) == null )
				now.date = parseInt( dateParts[1] );
			else 
				now.time += parseInt( dateParts[1].charAt(0) == "+" ? dateParts[1].substr(1) : dateParts[1] ) * DAY;
			
			if( dateParts[2] == "*" ) 
				dateParts[2] = now.fullYear;
			else if( new RegExp( /-|\+/ ).exec( dateParts[2] ) == null )
				now.fullYear = parseInt( dateParts[2] );
			else 
				now.time += parseInt( dateParts[2].charAt(0) == "+" ? dateParts[2].substr(1) : dateParts[2] ) * YEAR;
			
			return (now.month+1) + '/' + now.date + '/' + now.fullYear + time;
		}
		
		/*
		public static  function modernizeDate( value:String ):String
		{
			var today:Date = AppProperties.getInstance().controller.model.today;
			
			var year:int = today.fullYear;
			var month:int = today.month + 1;
			var date:int = today.date;
			
			value = value.replace( "{{DAY}}", date );
			value = value.replace( "{{MONTH}}", month );
			value = value.replace( /{{YEAR}}/, year );
			
			for(var i:int=0;i<today.date;i++) value = value.replace( "{{DAY-" + i + "}}", today.date - i );
			for(var i:int=today.date;i>0;i--) value = value.replace( "{{DAY+" + i + "}}", today.date + i );
			for(var i:int=1;i<=today.month;i++) value = value.replace( "{{MONTH-" + i + "}}", today.month + 1 - i );
			for(var i:int=0;i<5;i++) value = value.replace( "{{YEAR-" + i + "}}", today.fullYear - i );
			
			return value;
		}
		*/
	}
}