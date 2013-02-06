//http://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf69084-7c28.html
package edu.newschool.piim.healthboard.view.components.tooltips 
{
	import mx.charts.chartClasses.DataTip;
	import mx.charts.*;
	import flash.display.*; 
	import flash.geom.Matrix;
	
	public class MyCustomDataTip extends DataTip 
	{
		public function MyCustomDataTip() 
		{
			super();
			this.setStyle("backgroundColor", '#F7F4E9');
			this.setStyle("color", "#404040");	//595959
			this.setStyle("fontSize",10);
			this.setStyle("paddingBottom",-8);
			this.setStyle("paddingTop",1);
			this.setStyle("paddingRight",-6);
		} 
	}
}