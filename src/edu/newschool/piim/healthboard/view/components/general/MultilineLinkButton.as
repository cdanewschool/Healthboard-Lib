package edu.newschool.piim.healthboard.view.components.general 
{
	import flash.text.TextLineMetrics;
	
	public class MultilineLinkButton extends MainLinkButton 
	{
		override protected function createChildren():void 
		{
			super.createChildren();
			
			if (textField)
			{
				textField.wordWrap = false;
				textField.multiline = true;
			}
		}
		
		override public function measureText(s:String):TextLineMetrics 
		{
			textField.text = s;
			
			try
			{
				var lineMetrics:TextLineMetrics = textField.getLineMetrics(0);
				lineMetrics.width = textField.textWidth;
				lineMetrics.height = textField.textHeight;
			}
			catch(e:Error){}
			
			return lineMetrics;
		}
	}
}