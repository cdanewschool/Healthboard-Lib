package components.itemrenderers.datagridcolumn  
{
	import mx.controls.Label;
	import mx.controls.dataGridClasses.*;
	
	public class CustomRowColor extends Label 
	{
		public static const INACTIVE_COLOR:uint = 0x999999;
		public static const ACTIVE_COLOR:uint = 0xFFFFFF;
		
		override public function set data( value:Object ):void 
		{
			if( value != null ) 
			{
				super.data = value;
				
				if(value.status == "inactive") 
				{
					setStyle("color", INACTIVE_COLOR);
				}
				else 
				{
					setStyle("color", ACTIVE_COLOR);
				}
			}
		}
	}
}