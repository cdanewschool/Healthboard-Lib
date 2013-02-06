package edu.newschool.piim.healthboard.view.skins.general
{
	import flash.display.Graphics;
	
	import mx.skins.ProgrammaticSkin;
	
	public class myDropIndicatorSkin extends ProgrammaticSkin
	{
		public function myDropIndicatorSkin()
		{
			super();
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void {  
			super.updateDisplayList(w, h);
			
			var g:Graphics = graphics;
			
			g.clear();
			g.lineStyle(3, 0xFBB03B);
			
			g.moveTo(0, 0);
			g.lineTo(w, 0);
		}
	}
}