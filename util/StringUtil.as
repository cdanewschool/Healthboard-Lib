package util
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
	}
}