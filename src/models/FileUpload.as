package models
{
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	[Bindable]
	public class FileUpload
	{
		public var name:String;
		public var size:int;
		public var data:*;
		
		public function FileUpload( name:String, size:int, data:* )
		{
			this.name = name;
			this.size = size;
			this.data = data;
		}
		
		public function get fileSize():String 
		{
			if(size < 1024*1024) 
				return '(' + Math.round(size/1024) + 'KB)';
			else 
				return '(' + int((size/(1024*1024))*10)/10 + 'MB)';
		}
		
		public function isImage():Boolean 
		{
			var filename:String = name.toLowerCase();
			
			if( filename.substr(-4) == ".jpg" || filename.substr(-5) == ".jpeg" || filename.substr(-4) == ".gif" || filename.substr(-4) == ".png" ) return true;
			return false;
		}
	}
}