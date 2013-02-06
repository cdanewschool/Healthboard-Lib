package models
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class AppointmentCategory
	{
		public var id:String;
		public var label:String;
		public var categories:ArrayCollection;
		
		public function AppointmentCategory( id:String=null, label:String=null, categories:ArrayCollection = null )
		{
			this.id = id;
			this.label = label;
			this.categories = categories;
		}
		
		public function addCategory( category:AppointmentCategory):void
		{
			var exists:Boolean = false;
			
			for each(var c:AppointmentCategory in children)
			{
				if( c.id == category.id ) exists = true;
			}
			
			if( !exists )
			{
				categories && categories.length? categories.addItem( category ) : categories = new ArrayCollection[category];
			}
		}
		
		public function get children():ArrayCollection
		{
			return categories;
		}
		
		public static function fromObj( data:Object ):AppointmentCategory
		{
			var val:AppointmentCategory = new AppointmentCategory();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					try{ val[prop] = data[prop]; }
					catch(e:Error){}
				}
			}
			
			if( data.hasOwnProperty('category') )
			{
				var results:ArrayCollection = data.category is ArrayCollection ? data.category : new ArrayCollection( [ data.category ] );
				var categories:ArrayCollection = new ArrayCollection();
				
				for each(var result:Object in results) 
					categories.addItem( AppointmentCategory.fromObj( result ) );
				
				val.categories = categories;
			}
			
			return val;
		}
	}
}