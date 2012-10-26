package models
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class UserModel
	{
		public static const STATE_AVAILABLE:String = "A";
		public static const STATE_UNAVAILABLE:String = "U";
		
		public static const TYPE_PROVIDER:String = "provider";
		public static const TYPE_PATIENT:String = "patient";
		
		public var id:int;
		public var userType:String;
		
		public var firstName:String;
		public var lastName:String;
		public var sex:String;
		public var team:String;
		
		//	contact
		public var email:String;
		public var phone:String;
		
		//	security
		public var username:String;
		public var password:String;
		
		public var available:String;
		
		public var chatHistory:ArrayCollection;
		
		public function UserModel( type:String = TYPE_PATIENT )
		{
			this.userType = type;
		}
		
		
		public function addChat( chat:Chat ):void
		{
			if( !chatHistory ) chatHistory = new ArrayCollection();
			chatHistory.addItem( chat );
		}
		
		public function get fullName():String
		{
			return firstName + ' ' + lastName;
		}
		
		public function get fullNameAbbreviated():String
		{
			return lastName;
		}
		
		public function getDefaultProfilePictureURL( size:String = "small" ):String
		{
			if( userType == UserModel.TYPE_PATIENT )
				return "images/patients/" + size + "/default.jpg";
			
			return "images/providers/" + size + "/default.jpg";
		}
		
		public function getProfilePictureURL( size:String = "small" ):String
		{
			if( userType == UserModel.TYPE_PATIENT )
				return "images/patients/" + size + "/" + lastName.toLowerCase() + ".jpg";
			
			return "images/providers/" + size + "/" + lastName.toLowerCase() + ".jpg";
		}
	}
}