/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.adventuregame.managers
{
    import com.whatanadventure.framework.managers.BaseGameManager;
    import com.whatanadventure.framework.mvc.MVCModel;

    import starling.events.Event;

    public class GameManager extends BaseGameManager
    {
        public function GameManager()
        {
            super();
        }

        override public function init():void
        {
            super.init();

            _modelManager = new ModelManager(this);
            _resourceManager = new ResourceManager(this);

            _resourceManager.addEventListener(Event.COMPLETE, onResourceManagerComplete);

            _resourceManager.fetchData();
        }

        protected function onResourceManagerComplete(event:Event):void
        {
            trace("here");
            for each (var model:MVCModel in _modelManager.models)
            {
                trace(model);
            }
        }
    }
}
