/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.adventuregame.managers
{
    import com.whatanadventure.framework.managers.BaseGameManager;

    public class GameManager extends BaseGameManager
    {
//        private var _modelManager:ModelManager;
//        private var _resourceManager:ResourceManager;

        public function GameManager()
        {
            super();
        }

        override public function init():void
        {
            super.init();

            _modelManager = new ModelManager(this);
            _resourceManager = new ResourceManager(this);

            _resourceManager.fetchData();
        }

//        public function get modelManager():ModelManager
//        {
//            return _modelManager;
//        }
//
//        public function get resourceManager():ResourceManager
//        {
//            return _resourceManager;
//        }
    }
}
