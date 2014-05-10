/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.adventuregame.managers
{
    import com.whatanadventure.framework.managers.BaseGameManager;
    import com.whatanadventure.framework.mvc.MVCModel;

    import feathers.controls.ScreenNavigator;

    import starling.events.Event;

    public class GameManager extends BaseGameManager
    {
        private var _navigator:ScreenNavigator;
        private var _navigationManager:NavigationManager;

        public function GameManager()
        {
            super();
        }

        override public function init():void
        {
            super.init();

            _modelManager = new ModelManager(this);

            _resourceManager = new ResourceManager(_modelManager as ModelManager);
            _resourceManager.addEventListener(Event.COMPLETE, onResourceManagerComplete);

            _navigator = new ScreenNavigator();
            _navigationManager = new NavigationManager(this, _navigator);

//            _resourceManager.fetchData();
        }

        protected function onResourceManagerComplete(event:Event):void
        {
            for each (var model:MVCModel in _modelManager.models)
            {
                trace(model);
            }
        }

        public function get navigator():ScreenNavigator
        {
            return _navigator;
        }

        public function get navigationManager():NavigationManager
        {
            return _navigationManager;
        }
    }
}
