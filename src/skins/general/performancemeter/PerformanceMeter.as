package skins.general.performancemeter
{
	import spark.components.HSlider;
	
	public class PerformanceMeter extends HSlider
	{
		public function PerformanceMeter()
		{
			super();
			
			mouseChildren = false;
			buttonMode = false;
			
			minimum=30;
			maximum=90;
			
			setStyle('skinClass', skins.general.performancemeter.MeterTrack );
		}
		
		override public function set value(newValue:Number):void
		{
			newValue = Math.min( newValue, maximum );
			newValue = Math.max( newValue, minimum );
			
			super.value = newValue;
		}
	}
}