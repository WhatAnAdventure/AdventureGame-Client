/**
 * Created by Chelsea on 5/7/2014.
 */
package com.whatanadventure.adventuregame.managers
{
    import com.whatanadventure.framework.mvc.layout.MVCViewLayout;
    import com.whatanadventure.adventuregame.mvc.models.GameDataModel;
    import com.whatanadventure.framework.mvc.models.MVCViewLayouts;
    import com.whatanadventure.adventuregame.mvc.views.LoadingScreen;
    import com.whatanadventure.adventuregame.mvc.views.ViewClassLookUp;

    import feathers.controls.ScreenNavigator;
    import feathers.controls.ScreenNavigatorItem;
    import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class NavigationManager extends EventDispatcher
    {
        private static const LOADING_SCREEN:String = "loadingScreen";
        private static const LOADING_SCREEN_CLASS:Class = LoadingScreen;

        private var _gameManager:GameManager;
        private var _screenNavigator:ScreenNavigator;
        private var _transitionManager:ScreenSlidingStackTransitionManager;
        private var _gameDataModel:GameDataModel;
        private var _mvcViewLayouts:MVCViewLayouts;

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
            _mvcViewLayouts = _gameManager.modelManager.getModel(ModelManager.MVC_VIEWS) as ModelManager.MVC_VIEWS_CLASS;

            addScreenByViewId(_gameDataModel.firstScreen);
            _gameManager.navigator.showScreen(_gameDataModel.firstScreen);
        }

        private function addScreenByViewId(viewId:String):void
        {
            var firstViewLayout:MVCViewLayout = _mvcViewLayouts.getViewLayoutById(viewId);
            addScreenByMVCViewLayout(firstViewLayout);
        }

        private function addScreenByMVCViewLayout(mvcViewLayout:MVCViewLayout):void
        {
            _gameManager.navigator.addScreen(mvcViewLayout.viewId, new ScreenNavigatorItem(ViewClassLookUp[mvcViewLayout.viewId], null, {"gameManager":_gameManager}));
        }

        public function get screenNavigator():ScreenNavigator
        {
            return _screenNavigator;
        }
    }
}
