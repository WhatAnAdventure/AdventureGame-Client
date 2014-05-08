/**
 * Created by Chelsea on 5/7/2014.
 */
package com.whatanadventure.adventuregame.managers
{
    import com.whatanadventure.adventuregame.mvc.models.GameDataModel;
    import com.whatanadventure.adventuregame.mvc.views.LoadingScreen;
    import com.whatanadventure.adventuregame.mvc.views.MainMenu;

    import feathers.controls.ScreenNavigator;
    import feathers.controls.ScreenNavigatorItem;
    import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class NavigationManager extends EventDispatcher
    {
        private static const LOADING_SCREEN:String = "loadingScreen";
        private static const LOADING_SCREEN_CLASS:Class = LoadingScreen;
        private static const MAIN_MENU:String = "mainMenu";
        private static const MAIN_MENU_CLASS:Class = MainMenu;

        private var _gameManager:GameManager;
        private var _screenNavigator:ScreenNavigator;
        private var _transitionManager:ScreenSlidingStackTransitionManager;
        private var _gameDataModel:GameDataModel;

        public function NavigationManager(gameManager:GameManager, screenNavigator:ScreenNavigator)
        {
            super();

            _gameManager = gameManager;
            _screenNavigator = screenNavigator;

            _transitionManager = new ScreenSlidingStackTransitionManager(_screenNavigator);
            _transitionManager.duration = 0.4;

            _gameManager.navigator.addScreen(LOADING_SCREEN, new ScreenNavigatorItem(LOADING_SCREEN_CLASS, {"complete":onLoadingScreenComplete}, {"gameManager":_gameManager}));
            _gameManager.navigator.showScreen(LOADING_SCREEN);
        }

        private function onLoadingScreenComplete(event:Event):void
        {
            _gameDataModel = _gameManager.modelManager.getModel(ModelManager.GAME_DATA) as GameDataModel;
            var screenId:String = NavigationManager[_gameDataModel.firstScreen];
            _gameManager.navigator.addScreen(screenId, new ScreenNavigatorItem(NavigationManager[_gameDataModel.firstScreen + "_CLASS"], null, {"gameManager":_gameManager}));
            _gameManager.navigator.showScreen(screenId);
        }

        public function get screenNavigator():ScreenNavigator
        {
            return _screenNavigator;
        }
    }
}
