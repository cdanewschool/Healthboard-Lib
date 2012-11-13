package components.general
{
	import flash.events.MouseEvent;
	
	import mx.controls.LinkButton;
	
	public class MainLinkButton extends LinkButton
	{
		public function MainLinkButton()
		{
			super();
			
			addEventListener( MouseEvent.ROLL_OVER, onRollOver );
			addEventListener( MouseEvent.ROLL_OUT, onRollOut );
			
			setStyle( 'skin', null );
			setStyle( 'textDecoration', 'none' );
		}
		
		private function onRollOver( event:MouseEvent ):void
		{
			setStyle( 'textDecoration', 'underline' );
		}
		
		private function onRollOut( event:MouseEvent ):void
		{
			setStyle( 'textDecoration', 'none' );
		}
	}
}