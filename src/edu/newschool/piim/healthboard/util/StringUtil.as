package edu.newschool.piim.healthboard.util
{
	public class StringUtil
	{
		public static function titleCase(txt:String):String 
		{
			txt = txt.split(" ").map(function(myElement:String, myIndex:int, myArr:Array):String {
				return myElement.substr(0, 1).toLocaleUpperCase() + myElement.substr(1);
			}).join(" ");
			
			return txt;
		}
		
		public static function leftPad( value:String, places:int = 2, fillValue:String = "0" ):String
		{
			if( value.length < places )
			{
				while( value.length < places )
				{
					value = fillValue + value;
				}
			}
			
			return value;
		}
	}
}