/**
 * Created by Chelsea on 5/9/2014.
 */
package com.whatanadventure.adventuregame.mvc
{
    import com.whatanadventure.adventuregame.mvc.controllers.MainMenuController;
    import com.whatanadventure.framework.mvc.view.MVCScreen;

    public class MVCClassLookUp
    {
        public static const MAIN_MENU:Object = {
            "controller":MainMenuController,
            "view":MVCScreen
        };

        public function MVCClassLookUp()
        {
        }
    }
}
