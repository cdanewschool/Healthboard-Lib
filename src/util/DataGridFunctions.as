package util
{
	public class DataGridFunctions
	{
		public static function calcCommentsRowColor(item:Object, rowIndex:int, dataIndex:int, color:uint):uint 
		{
			if(item.chartType == "comments" || item.chartType == "untrackable") return 0x000000;
			
			else return color;
		}
		
	}
}