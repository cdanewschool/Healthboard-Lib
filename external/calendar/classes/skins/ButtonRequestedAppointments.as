package external.calendar.classes.skins { // Use unnamed package if this skin is not in its own package.
	
	// Import necessary classes here.
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	import mx.skins.ProgrammaticSkin;
	import mx.skins.Border;
	
	public class ButtonRequestedAppointments extends ProgrammaticSkin {
		
		public var backgroundFillColor:Number;
		
		// Constructor.
		public function ButtonRequestedAppointments() {
			// Set default values.
			backgroundFillColor = 0x00ADEE;
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void {
			// Depending on the skin's current name, set values for this skin.
			
			switch (name) {
				case "upSkin":
					backgroundFillColor = 0x00ADEE;
					break;
				case "overSkin":
					backgroundFillColor = 0x00ADEE;
					break;
				case "downSkin":
					backgroundFillColor = 0x00ADEE;
					break;
				case "disabledSkin":
					backgroundFillColor = 0x00ADEE;
					//alpha = 0;
					break;
			}
			
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(backgroundFillColor);
			g.lineStyle(1, 0xFFFFFF);
			g.drawRect(0, 0, w, h);
			g.endFill();
			
		}
	}
} // Close unnamed package.