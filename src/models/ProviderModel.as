package models
{
	import flash.utils.describeType;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ProviderModel extends UserModel
	{
		public var education:String;
		
		//	work
		public var location:String;
		public var office:String;
		public var certification:String;
		public var department:String;
		public var specialty:String;
		public var status:String;
		public var role:String;
		
		//	emergency contact
		public var emergencyName:String;
		public var emergencyRelation:String;
		public var emergencyPhone1:String;
		public var emergencyPhone2:String;
		
		//	security
		public var securityQuestion:String;
		public var securityAnswer:String;
		
		public var selected:Boolean;
		
		public var savedSearches:ArrayCollection;
		
		public function ProviderModel()
		{
			super( TYPE_PROVIDER );
			
			selected = true;
		}
		
		override public function get fullName():String
		{
			var name:String = super.fullName;
			
			return (role == 'MD' ? 'Dr. ' : '') + name;
		}
		
		override public function get fullNameAbbreviated():String
		{
			var name:String = super.fullNameAbbreviated;
			
			return (role == 'MD' ? 'Dr. ' : '') + name;
		}
		
		public function get lastNameAbbreviated():String
		{
			return (role == 'MD' ? 'Dr. ' : '') + lastName;
		}
		
		public function clone():ProviderModel
		{
			var val:ProviderModel = new ProviderModel();
			
			var definition:XML = describeType(this);
			
			for each(var prop:XML in definition..accessor)
			{
				if( prop.@access == "readonly" ) continue;
				
				val[prop.@name] = this[prop.@name];
			}
			
			return val;
		}
		
		public function copy( from:ProviderModel ):void
		{
			var definition:XML = describeType(this);
			
			for each(var prop:XML in definition..accessor)
			{
				if( prop.@access == "readonly" ) continue;
				
				this[prop.@name] = from[prop.@name];
			}
		}
		
		public static function fromObj( data:Object ):ProviderModel
		{
			var val:ProviderModel = new ProviderModel();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					try
					{
						val[prop] = data[prop];
					}
					catch(e:Error){}
				}
			}
			
			val.birthdate = new Date( data.birthdate );
			
			return val;
		}
	}
}