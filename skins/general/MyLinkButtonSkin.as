/**
 * http://blog.flexexamples.com/2008/09/08/extending-the-linkbutton-control-in-flex/
 */
package skins.general {
	import mx.skins.halo.LinkButtonSkin;
	import mx.styles.StyleManager;
	
	public class MyLinkButtonSkin extends LinkButtonSkin {
		public function MyLinkButtonSkin() {
			super();
		}
		override protected function updateDisplayList(w:Number, h:Number):void {
			super.updateDisplayList(w, h);
			
			// Inherited styles
			var cornerRadius:Number = getStyle("cornerRadius");
			var rollOverColor:uint = getStyle("rollOverColor");
			var selectionColor:uint = getStyle("selectionColor");
			
			// Custom styles
			var toggleBackgroundColor:uint = getStyle("toggleBackgroundColor") || getStyle("themeColor");
			
			graphics.clear();
			
			switch (name) {
				case "upSkin":
					// Draw invisible shape so we have a hit area.
					drawRoundRect(
						0,                /* x */
						0,                /* y */
						w,                /* width */
						h,                /* height */
						cornerRadius,    /* cornerRadius */
						0,                /* color */
						0.0                /* alpha */
					);
					break;
				
				case "selectedUpSkin":
				case "selectedOverSkin":
					drawRoundRect(0, 0, w, h, cornerRadius, toggleBackgroundColor, 1.0);
					break;
				
				case "overSkin":
					drawRoundRect(0, 0, w, h, cornerRadius, rollOverColor, 1.0);
					break;
				
				case "selectedDownSkin":
				case "downSkin":
					drawRoundRect(0, 0, w, h, cornerRadius, selectionColor, 1.0);
					break;
				
				case "selectedDisabledSkin":
					// Draw 20% alpha shape so we have a hit area.
					drawRoundRect(0, 0, w, h, cornerRadius, toggleBackgroundColor, 0.2);
					break;
				
				case "disabledSkin":
					// Draw invisible shape so we have a hit area.
					drawRoundRect( 0, 0, w, h, cornerRadius, 0, 0.0);
					break;
			}
		}
	}
}