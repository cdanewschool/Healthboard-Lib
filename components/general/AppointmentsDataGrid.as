package components.general
{
	import enum.AppointmentStatus;
	
	import flash.display.Sprite;
	
	import mx.controls.DataGrid;
	
	public class AppointmentsDataGrid extends DataGrid
	{
		public function AppointmentsDataGrid()
		{
			super();
		}
		
		protected override function drawRowBackground(s:Sprite, rowIndex:int,  y:Number, height:Number, color:uint, dataIndex:int):void
		{
			if ( dataProvider.length > dataIndex 
					&& dataProvider[dataIndex].status == AppointmentStatus.COMPLETED )
				color = 0x3C3C3B;
			
			super.drawRowBackground(s, rowIndex, y, height, color, dataIndex);
		}
	}
}