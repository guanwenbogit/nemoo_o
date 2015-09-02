package com.support {

  import flash.display.Sprite;

  import flash.events.ContextMenuEvent;
  import flash.events.EventDispatcher;
  import flash.ui.ContextMenu;
  import flash.ui.ContextMenuItem;

  /**
   * @author sytang
   */
  public class VersionUtil extends EventDispatcher {
    public static function init(app:Sprite):void {
      var menu:ContextMenu = new ContextMenu();	

	  var logItem : ContextMenuItem = new ContextMenuItem("show log");
	  logItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, logItemClickHandler);
	  menu.customItems.push(logItem);
	  
	  var item:ContextMenuItem = new ContextMenuItem(build_date);
	  item.separatorBefore = true;
	  menu.customItems.push(item);
  
      app.contextMenu = menu;
    }
	
	private static function logItemClickHandler(event:ContextMenuEvent):void
	{

	}
	
  }
}
