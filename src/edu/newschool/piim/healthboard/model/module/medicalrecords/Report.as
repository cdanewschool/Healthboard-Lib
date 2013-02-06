package edu.newschool.piim.healthboard.model.module.medicalrecords
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Report
	{
		public var elements:ArrayCollection;
		
		public function Report()
		{
		}
		
		public static function fromObj( data:Object ):Report
		{
			var val:Report = new Report();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					try{ val[prop] = data[prop]; }
					catch(e:Error){}
				}
			}
			
			if( data.hasOwnProperty('element') )
			{
				var results:ArrayCollection = data.element is ArrayCollection ? data.element : new ArrayCollection( [ data.element ] );
				
				var elements:ArrayCollection = new ArrayCollection();
				
				for each(var result:Object in results) 
				{
					elements.addItem( SummaryElement.fromObj(result) );
				}
				
				val.elements = elements;
			}
			
			return val;
		}
	}
}