//http://blog.9mmedia.com/?p=535
package com.ninemmedia.code.collapsibleTitleWindow.components.enhancedtitlewindow
{
	import edu.newschool.piim.healthboard.events.EnhancedTitleWindowEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	
	import edu.newschool.piim.healthboard.view.skins.general.CustomTitleWindowCloseButtonSkinSMALL;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.TitleWindow;
	import spark.core.IDisplayText;
	import spark.layouts.supportClasses.LayoutBase;
	import spark.skins.spark.TitleWindowCloseButtonSkin;
	
	[Style(name="titleBarHeight", type="Number", inherit="no", theme="spark")]
	[Style(name="showExpandIndicator", type="Boolean", inherit="no", theme="spark")]

	[Event(name="expanded", type="edu.newschool.piim.healthboard.events.EnhancedTitleWindowEvent")]
	[Event(name="collapsed", type="edu.newschool.piim.healthboard.events.EnhancedTitleWindowEvent")]
	[Event(name="headerClicked", type="edu.newschool.piim.healthboard.events.EnhancedTitleWindowEvent")]
	
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
		
		private var _module:String;
		
		public var headerClickable:Boolean;
		
		[Bindable]
		public var collapsible:Boolean;
		
		[Bindable]
		public var showCloseButton:Boolean;
		
		[Bindable]
		public var closeButtonSkinClass:Class = CustomTitleWindowCloseButtonSkinSMALL;
		
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
		
		[Bindable] public var showDropDown:Boolean = false;
		[Bindable] public var dropDownDataProvider:ArrayCollection;
		[Bindable] public var dropDownChangeCallback:Function;
		
		[Bindable] public var displayWarning:Boolean = false;
		[Bindable] public var warningToolTip:String = new String();
		
		[Bindable]
		public function get module():String
		{
			return _module;
		}

		public function set module(value:String):void
		{
			_module = value;
			
			if( skin ) skin.invalidateProperties();
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
			event.stopImmediatePropagation();
			
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
			this.dispatchEvent( new EnhancedTitleWindowEvent(EnhancedTitleWindowEvent.HEADER_CLICKED,true) );
			
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
			
			if( subtitle 
				&& subTitleDisplay 
				&& subTitleDisplay.text != subtitle )
			{
				subTitleDisplay.text = subtitle;
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList( unscaledWidth, unscaledHeight );
			
			if( closeButtonSkinClass == TitleWindowCloseButtonSkin )
			{
				closeButton.width = 15;
				closeButton.height = 15;
				closeButton.right = 7;
				closeButton.top = 7;
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
			
			invalidateProperties();
		}
	}
}
