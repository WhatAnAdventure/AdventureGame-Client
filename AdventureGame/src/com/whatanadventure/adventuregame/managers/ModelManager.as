/**
 * Created by Chelsea on 5/3/2014.
 */
package com.whatanadventure.adventuregame.managers
{
    import com.whatanadventure.adventuregame.mvc.models.GameDataModel;
    import com.whatanadventure.adventuregame.mvc.models.MainMenuModel;
    import com.whatanadventure.framework.managers.BaseModelManager;
    import com.whatanadventure.framework.managers.IModelManager;
    import com.whatanadventure.framework.mvc.MVCModel;

    public class ModelManager extends BaseModelManager implements IModelManager
    {
        private var _gameManager:GameManager;

        public static const GAME_DATA:String = "gameData";
        public static const MAIN_MENU:String = "mainMenu";

        public static const GAME_DATA_CLASS:Class = GameDataModel;
        public static const MAIN_MENU_CLASS:Class = MainMenuModel;

        public function ModelManager(gameManager:GameManager)
        {
            super();

            _gameManager = gameManager;
        }

        override protected function makeModels():void
        {
            super.makeModels();
        }

        public function makeModelFromData(fileData:Object):void
        {
            var modelClass:Class = ModelManager[fileData.modelManagerKey + "_CLASS"] as Class;
            var addedModel:MVCModel = addModel(new modelClass(_gameManager, ModelManager[fileData.modelManagerKey]));
            addedModel.setProperties(fileData.properties);
        }
    }
}
