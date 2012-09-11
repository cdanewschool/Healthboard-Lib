//http://blog.9mmedia.com/?p=535
package external.collapsibleTitleWindow.components.enhancedtitlewindow
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.TitleWindow;
	import spark.layouts.supportClasses.LayoutBase;
	
	[Style(name="titleBarHeight", type="Number", inherit="no", theme="spark")]
	[Style(name="showExpandIndicator", type="Boolean", inherit="no", theme="spark")]

	public class EnhancedTitleWindow extends TitleWindow
	{
		public static const EXPANDED:String = "EnhancedTitleWindow:expanded";
		public static const COLLAPSED:String = "EnhancedTitleWindow:collapsed";
		
		public var module:String;
		
		public var headerClickable:Boolean;
		
		[Bindable]
		public var collapsible:Boolean;
		
		[Bindable]
		public var showCloseButton:Boolean;
		
		[SkinPart(required="false")]
		public var expandIndicator:UIComponent;
		
		[SkinPart(required="false")]
		public var topGroup:Group;
		
		[SkinPart(required="false")]
		public var titleBarContentGroup:Group;
		
		protected var expandedChanged:Boolean;
		protected var _expanded:Boolean = true;
		protected var _titleBarContent:Array;
		protected var _titleBarLayout:LayoutBase;
		
		public function EnhancedTitleWindow()
		{
			super();
		}
		
		[Bindable]
		public function get expanded():Boolean
		{
			return _expanded;
		}

		public function set expanded(value:Boolean):void
		{
			if(value != _expanded){
				expandedChanged = true;
				_expanded = value;
				invalidateProperties();
				invalidateSkinState();
			}
		}
		
		public function set titleBarContent(value:Array):void
		{
			_titleBarContent = value;
		}
		
		public function get titleBarLayout():LayoutBase
		{
			return _titleBarLayout;
		}
		
		public function set titleBarLayout(value:LayoutBase):void
		{
			_titleBarLayout = value;
			if(titleBarContentGroup)
				titleBarContentGroup.layout = _titleBarLayout;
		}

		protected function onExpandIndicatorClick(event:MouseEvent):void
		{
			if(!headerClickable && collapsible) 
				expanded = !expanded;
		}
		
		protected function onCloseClick(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
		}
		
		protected function onHeaderClicked(event:MouseEvent):void
		{
			if(headerClickable && collapsible)
				expanded = !expanded;
		}
		
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			
			if(instance == expandIndicator){
				expandIndicator.addEventListener(MouseEvent.CLICK, onExpandIndicatorClick);
			}else if(instance == topGroup){
				topGroup.addEventListener(MouseEvent.CLICK, onHeaderClicked);
			}else if(instance == titleBarContentGroup){
				if(_titleBarContent)
					titleBarContentGroup.mxmlContent = _titleBarContent;
				if(_titleBarLayout)
					titleBarContentGroup.layout = _titleBarLayout;
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
			
			if(instance == expandIndicator){
				expandIndicator.removeEventListener(MouseEvent.CLICK, onExpandIndicatorClick);
			}else if(instance == topGroup){
				topGroup.removeEventListener(MouseEvent.CLICK, onHeaderClicked);
			}
		}
		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			if(expandedChanged){
				expandIndicator.currentState = _expanded ? "expanded" : "collapsed";
				if(_expanded)
					dispatchEvent(new Event(EXPANDED));
				else
					dispatchEvent(new Event(COLLAPSED));
				
				expandedChanged = false;
			}
		}
		
		override protected function getCurrentSkinState():String
		{
			var state:String = super.getCurrentSkinState(); 
			if(collapsible){
				if(!_expanded){
					if(enabled)
						state = "collapsed";
					else
						state = "disabledCollapsed";
				}
			}
			return state;
		}
	}
}