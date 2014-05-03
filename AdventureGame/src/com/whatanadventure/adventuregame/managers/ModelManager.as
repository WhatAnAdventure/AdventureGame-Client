/**
 * Created by Chelsea on 5/3/2014.
 */
package com.whatanadventure.adventuregame.managers
{
    import com.whatanadventure.adventuregame.mvc.models.MainMenuModel;
    import com.whatanadventure.framework.managers.BaseModelManager;

    public class ModelManager extends BaseModelManager
    {
        public static const MAIN_MENU_MODEL:String = "mainMenuModel";

        public function ModelManager(gameManager:GameManager)
        {
            super(gameManager);
        }

        override protected function makeModels():void
        {
            super.makeModels();

            addModel(new MainMenuModel(_gameManager as GameManager, MAIN_MENU_MODEL));
        }
    }
}
