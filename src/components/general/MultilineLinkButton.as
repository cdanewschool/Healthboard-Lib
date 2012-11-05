package components.general 
{
	import mx.controls.LinkButton;
	import flash.text.TextLineMetrics;
	
	public class MultilineLinkButton extends LinkButton 
	{
		override protected function createChildren():void 
		{
			super.createChildren();
			
			if (textField)
			{
				textField.wordWrap = true;
				textField.multiline = true;
			}
		}
		
		override public function measureText(s:String):TextLineMetrics 
		{
			textField.text = s;
			
			var lineMetrics:TextLineMetrics = textField.getLineMetrics(0);
			lineMetrics.width = textField.textWidth;
			lineMetrics.height = textField.textHeight;
			
			return lineMetrics;
		}
	}
}