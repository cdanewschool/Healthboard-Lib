package components.itemrenderers.tree
{
	import flash.events.MouseEvent;
	
	import mx.controls.LinkButton;
	import mx.controls.treeClasses.TreeItemRenderer;
	import mx.controls.treeClasses.TreeListData;
	
	import spark.components.Image;
	
	public class MyTreeItemRenderer extends TreeItemRenderer
	{
		public var btnLink:LinkButton;
		public var imgRedMark:Image;
		[Embed(source="images/redMark.png")] [Bindable] public var redMark:Class;
		public function MyTreeItemRenderer()
		{
			super();
		}
		
		override protected function createChildren():void{
			super.createChildren();
			
			btnLink = new LinkButton();
			btnLink.visible = true;
			btnLink.setStyle("textAlign","left");
			btnLink.setStyle("color","0xAEDEE4");
			btnLink.setStyle("fontWeight","normal");
			btnLink.setStyle("textRollOverColor","0xAEDEE4");
			btnLink.setStyle("textSelectedColor","0xAEDEE4");
			btnLink.setStyle("skin", null);
			btnLink.addEventListener(MouseEvent.ROLL_OVER,manageMouseOver);
			btnLink.addEventListener(MouseEvent.ROLL_OUT,manageMouseOut);
			addChild(btnLink);
			
			imgRedMark = new Image();
			imgRedMark.width = 13;
			imgRedMark.height = 15;
			imgRedMark.y = -2;
			imgRedMark.x = 139;
			imgRedMark.source = redMark;
			imgRedMark.toolTip = "No refills left.";
			
			addChild(imgRedMark);
		}
		
		private function manageMouseOver(event:MouseEvent):void{
			btnLink.setStyle("rollOver",btnLink.styleName='linkBtnUnderline');
		}
		
		private function manageMouseOut(event:MouseEvent):void{
			btnLink.setStyle("rollOut",btnLink.styleName='linkBtn');
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			if(super.data){
				if(TreeListData(super.listData).hasChildren) {
					label.visible = true;
					label.includeInLayout = true;
					this.btnLink.visible = false;
					this.btnLink.includeInLayout = false;
					this.imgRedMark.visible = this.imgRedMark.includeInLayout = false;
				}
				else {
					label.visible = false;
					label.includeInLayout = false;
					this.btnLink.visible = true;
					this.btnLink.includeInLayout = true;
					this.btnLink.label = TreeListData(super.listData).label;
					this.imgRedMark.visible = this.imgRedMark.includeInLayout = (TreeListData(super.listData).label == "Lisinopril (Prinivil/Zestril)" || TreeListData(super.listData).label == "Warfarin (Coumadin®)");
					btnLink.x = 7;
					btnLink.y = 3;
					btnLink.width = 150;
					btnLink.height = 20;
				}
			}
		}
	}
}