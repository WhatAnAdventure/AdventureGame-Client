/**
 * Created by Chelsea on 5/9/2014.
 */
package com.whatanadventure.adventuregame.mvc.views
{
    import com.whatanadventure.framework.mvc.view.CenterButtonGroupView;

    import starling.events.Event;

    public class MainMenu extends CenterButtonGroupView
    {
        public function MainMenu()
        {
            super();
        }

        public function onStartGame(event:Event):void
        {
            trace("onStartGame");
        }

        public function onLoadGame(event:Event):void
        {
            trace("onLoadGame");
        }

        public function onSettings(event:Event):void
        {
            trace("onSettings");
        }
    }
}
