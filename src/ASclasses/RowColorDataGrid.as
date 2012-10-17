package ASclasses 
{
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.DataGrid;
	
	/**USED IN MESSAGES, VITAL SIGNS, AND EXERCISE MODULES**/
	public class RowColorDataGrid extends DataGrid {
		public var rowColorFunction:Function;
		
		override protected function drawRowBackground(s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int):void {
			if(rowColorFunction != null) {
				var item:Object;
				if(dataIndex < dataProvider.length) item = dataProvider[dataIndex];
				if(item) color = rowColorFunction(item, rowIndex, dataIndex, color);
			}
			
			super.drawRowBackground(s, rowIndex, y, height, color, dataIndex);
		}
	}
}