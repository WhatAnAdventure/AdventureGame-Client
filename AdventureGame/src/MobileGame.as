/**
 * Created by Chelsea on 4/27/2014.
 */
package {
    import com.whatanadventure.adventuregame.managers.GameManager;
    import com.whatanadventure.adventuregame.screens.LoadingScreen;
    import com.whatanadventure.adventuregame.themes.AdventureGameTheme;

    import feathers.controls.ScreenNavigator;
    import feathers.controls.ScreenNavigatorItem;
    import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
    import feathers.themes.MetalWorksMobileTheme;

    import starling.display.Sprite;

    public class MobileGame extends Sprite
    {
        private static const MAIN_MENU:String = "mainMenu";
        private static const LOADING_SCREEN:String = "loadingScreen";

        public function MobileGame()
        {
            super();
        }

        private var _theme:MetalWorksMobileTheme;
        private var _navigator:ScreenNavigator;
        private var _transitionManager:ScreenSlidingStackTransitionManager;
        private var _gameManager:GameManager;

        public function start():void
        {
            setTheme();

            _gameManager = new GameManager();
            _gameManager.init();

            _navigator = new ScreenNavigator();
            addChild(_navigator);

//            _navigator.addScreen(MAIN_MENU, new ScreenNavigatorItem(MainMenu, null, {"gameManager":_gameManager}));
            _navigator.addScreen(LOADING_SCREEN, new ScreenNavigatorItem(LoadingScreen, {"complete":MAIN_MENU}, {"gameManager":_gameManager}));

            _navigator.showScreen(LOADING_SCREEN);

            _transitionManager = new ScreenSlidingStackTransitionManager(_navigator);
            _transitionManager.duration = 0.4;
        }

        protected function setTheme():void
        {
            _theme = new AdventureGameTheme(stage);
        }
    }
}
