package edu.newschool.piim.healthboard.util
{
	public class ArrayUtil
	{
		public static function unique(array:Array):Array 
		{
			var arrayL:uint = array.length;
			
			if (!arrayL) return [];
			
			var newArray:Array = [array[0]];
			
			for (var i:uint = 1; i < arrayL; i++) 
			{
				var item:* = array[i];
				if (array.lastIndexOf(item, i - 1) == -1) {
					newArray.push(item);
				}
			}
			
			return newArray;
		}
	}
}