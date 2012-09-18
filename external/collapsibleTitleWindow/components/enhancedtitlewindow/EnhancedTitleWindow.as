//http://blog.9mmedia.com/?p=535
package external.collapsibleTitleWindow.components.enhancedtitlewindow
{
	import events.EnhancedTitleWindowEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.TitleWindow;
	import spark.core.IDisplayText;
	import spark.layouts.supportClasses.LayoutBase;
	
	[Style(name="titleBarHeight", type="Number", inherit="no", theme="spark")]
	[Style(name="showExpandIndicator", type="Boolean", inherit="no", theme="spark")]

	[Event(name="expanded", type="events.EnhancedTitleWindowEvent")]
	[Event(name="collapsed", type="events.EnhancedTitleWindowEvent")]
	
	public class EnhancedTitleWindow extends TitleWindow
	{
		[SkinPart(required="false")]
		
		/**
		 *  The skin part that defines the appearance of the 
		 *  title text in the container.
		 *
		 *  @see spark.skins.spark.PanelSkin
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public var subTitleDisplay:IDisplayText;
		
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
		
		private var _subtitle:String;
		
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
					this.dispatchEvent( new EnhancedTitleWindowEvent(EnhancedTitleWindowEvent.EXPANDED,true) );
				else
					this.dispatchEvent( new EnhancedTitleWindowEvent(EnhancedTitleWindowEvent.COLLAPSED,true));
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
		
		public function get subtitle():String 
		{
			return _subtitle;
		}
		
		/**
		 *  @private
		 */
		public function set subtitle(value:String):void 
		{
			_subtitle = value;
			
			if (subTitleDisplay)
				subTitleDisplay.text = subtitle;
		}
	}
}
