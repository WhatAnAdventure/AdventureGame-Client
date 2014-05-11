/**
 * Created by Chelsea on 5/10/2014.
 */
package com.whatanadventure.adventuregame.mvc.views
{
    import com.whatanadventure.adventuregame.mvc.event.MainMenuEvent;
    import com.whatanadventure.framework.mvc.view.MVCScreen;

    import starling.events.Event;

    public class MainMenuScreen extends MVCScreen
    {
        public function MainMenuScreen()
        {
            super();
        }

        public function onStartGame(event:Event):void
        {
            trace("onStartGame");
            dispatchEventWith(MainMenuEvent.START_GAME);
        }

        public function onLoadGame(event:Event):void
        {
            trace("onLoadGame");
            dispatchEventWith(MainMenuEvent.LOAD_GAME);
        }

        public function onSettings(event:Event):void
        {
            trace("onSettings");
            dispatchEventWith(MainMenuEvent.SETTINGS);
        }
    }
}
