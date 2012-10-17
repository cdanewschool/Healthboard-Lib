package components.itemrenderers.datagridcolumn {
	import mx.controls.Label;
	import mx.controls.dataGridClasses.*;
	
	public class CustomRowColorAlternative extends Label {
		override public function set data(value:Object):void {
			if(value != null) {
				super.data = value;
				if(value.status == "inactive") {		//value.[DataGridListData(listData).dataField]
					setStyle("color", 0x999999);
				}
				else {
					setStyle("color", 0xAEDEE4);
				}
			}
		}
	}
}