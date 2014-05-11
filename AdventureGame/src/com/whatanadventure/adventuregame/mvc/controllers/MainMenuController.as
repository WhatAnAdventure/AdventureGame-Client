/**
 * Created by Chelsea on 5/10/2014.
 */
package com.whatanadventure.adventuregame.mvc.controllers
{
    import com.whatanadventure.framework.mvc.MVCController;

    import starling.events.Event;

    public class MainMenuController extends MVCController
    {
        public function MainMenuController()
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
