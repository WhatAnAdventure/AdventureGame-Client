/**
 * Created by Chelsea on 5/3/2014.
 */
package com.whatanadventure.adventuregame.managers
{
    import com.whatanadventure.adventuregame.mvc.models.GameDataModel;
    import com.whatanadventure.adventuregame.mvc.models.MVCLayouts;
    import com.whatanadventure.framework.data.IJsonObject;
    import com.whatanadventure.framework.managers.BaseModelManager;
    import com.whatanadventure.framework.managers.IModelManager;
    import com.whatanadventure.framework.mvc.MVCModel;

    public class ModelManager extends BaseModelManager implements IModelManager
    {
        private var _gameManager:GameManager;

        public static const GAME_DATA:Object = {
            "name":"gameData",
            "classReference":GameDataModel
        };

        public static const MVC_LAYOUTS:Object = {
            "name":"mvcViews",
            "classReference":MVCLayouts
        };

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
            var modelClass:Class = ModelManager[fileData.modelManagerKey].classReference as Class;
            if (modelClass)
            {
                var addedModel:MVCModel = addModel(new modelClass(ModelManager[fileData.modelManagerKey].name));
                addedModel.setProperties(fileData.properties);
                (addedModel as IJsonObject).fromJSON(fileData);
            }
            else
            {
                modelClass = BaseModelManager[fileData.modelManagerKey + "_CLASS"] as Class;
                var addedModel:MVCModel = addModel(new modelClass(BaseModelManager[fileData.modelManagerKey]));
                addedModel.setProperties(fileData.properties);
                (addedModel as IJsonObject).fromJSON(fileData);
            }
        }
    }
}
