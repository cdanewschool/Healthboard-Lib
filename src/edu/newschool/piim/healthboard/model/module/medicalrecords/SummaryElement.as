package edu.newschool.piim.healthboard.model.module.medicalrecords
{
	[Bindable]
	public class SummaryElement
	{
		public var title:String;
		public var text:String;
		
		public function SummaryElement()
		{
		}
		
		public static function fromObj( data:Object ):SummaryElement
		{
			var val:SummaryElement = new SummaryElement();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					try{ val[prop] = data[prop]; }
					catch(e:Error){}
				}
			}
			
			return val;
		}
	}
}