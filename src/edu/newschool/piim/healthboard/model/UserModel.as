package edu.newschool.piim.healthboard.model
{
	import mx.collections.ArrayCollection;
	
	import edu.newschool.piim.healthboard.util.DateFormatters;

	[Bindable]
	public class UserModel extends PersonModel
	{
		public static const STATE_AVAILABLE:String = "A";
		public static const STATE_UNAVAILABLE:String = "U";
		
		public static const TYPE_PROVIDER:String = "provider";
		public static const TYPE_PATIENT:String = "patient";
		
		//	internal
		public var id:int;
		public var userType:String;
		
		//	basic
		public var birthdate:Date;
		public var sex:int;
		
		//	contact
		public var email:String;
		public var phone:String;
		
		//	location
		public var city:String;
		public var latitude:Number;
		public var longitude:Number;
		public var state:String;
		public var street1:String;
		public var street2:String;
		public var zip:String;
		
		//	security
		public var username:String;
		public var password:String;
		
		//	medical
		public var team:String;
		
		//	application-specific
		public var available:String;
		public var chatHistory:ArrayCollection;
		
		public function UserModel( type:String = TYPE_PATIENT )
		{
			super();
			
			this.userType = type;
			
			this.latitude = NaN;
			this.longitude = NaN;
		}
		
		public function get fullName():String
		{
			return firstName + ' ' + lastName;
		}
		
		public function get fullNameAbbreviated():String
		{
			return lastName;
		}
		
		public function get age():int
		{
			return birthdate ? (AppProperties.getInstance().controller.model.today.fullYear - birthdate.fullYear) : 0;
		}
		
		public function get birthdateLabel():String
		{
			return DateFormatters.dateOnlyBackslashDelimited.format( birthdate );
		}
		
		public function get sexLabel():String
		{
			return sex == 1 ? 'Male' : 'Female';
		}
		
		public function getDefaultProfilePictureURL( size:String = "small" ):String
		{
			if( userType == UserModel.TYPE_PATIENT )
				return "assets/images/patients/" + size + "/default.jpg";
			
			return "assets/images/providers/" + size + "/default.jpg";
		}
		
		public function getProfilePictureURL( size:String = "small" ):String
		{
			if( userType == UserModel.TYPE_PATIENT )
				return "assets/images/patients/" + size + "/" + lastName.toLowerCase() + ".jpg";
			
			return "assets/images/providers/" + size + "/" + lastName.toLowerCase() + ".jpg";
		}
		
		public static function fromObj( data:Object ):UserModel
		{
			var val:UserModel = new UserModel();
			
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
			
			return val;
		}
	}
}