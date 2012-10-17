//http://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf69084-7c28.html
package ASclasses {
	import mx.charts.chartClasses.DataTip;
	import mx.charts.*;
	import flash.display.*; 
	import flash.geom.Matrix;
	
	public class MyCustomDataTip extends DataTip {
		
		public function MyCustomDataTip() {
			super();
			this.setStyle("backgroundColor", '#F7F4E9');
			//this.setStyle("paddingLeft",9);
			//this.setStyle("paddingTop",7);
			//this.setStyle("paddingRight",20);
			this.setStyle("color", "#404040");	//595959
			this.setStyle("fontSize",10);
			this.setStyle("paddingBottom",-8);
			this.setStyle("paddingTop",1);
			this.setStyle("paddingRight",-6);
		}       
		
		/*override protected function updateDisplayList(w:Number, h:Number):void {
			super.updateDisplayList(w, h);
			
			//this.setStyle("textAlign","center");
			var g:Graphics = graphics; 
			g.clear();
			var m:Matrix = new Matrix();
			m.createGradientBox(w+100,h,0,0,0);
			g.beginGradientFill(GradientType.LINEAR,[0xFF0000,0xFFFFFF],
				[.1,1],[0,255],m,null,null,0);
			g.drawRect(-50,0,w+100,h);
			g.endFill(); 
		}*/
	}
}