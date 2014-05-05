/**
 * Created by Chelsea on 4/27/2014.
 */
package com.whatanadventure.adventuregame.mvc.views
{
    import com.whatanadventure.adventuregame.managers.GameManager;

    import feathers.controls.Screen;

    public class MainMenu extends Screen
    {
        public function MainMenu()
        {
            super();
        }

        private var _gameManager:GameManager;

        public function set gameManager(value:GameManager):void
        {
            _gameManager = value;

            init();
        }

        private function init():void
        {

        }
    }
}
