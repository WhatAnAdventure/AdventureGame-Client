/**
 * Created by Chelsea on 5/3/2014.
 */
package com.whatanadventure.adventuregame.mvc.models
{
    import com.whatanadventure.adventuregame.managers.GameManager;
    import com.whatanadventure.framework.mvc.MVCModel;

    public class MainMenuModel extends MVCModel
    {
        public function MainMenuModel(gameManager:GameManager, modelName:String)
        {
            super(gameManager, modelName);
        }
    }
}
