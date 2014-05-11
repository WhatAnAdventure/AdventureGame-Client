/**
 * Created by Chelsea on 5/7/2014.
 */
package com.whatanadventure.adventuregame.managers
{
    import com.whatanadventure.framework.managers.BaseModelManager;
    import com.whatanadventure.framework.mvc.MVCController;
    import com.whatanadventure.framework.mvc.layout.MVCLayout;
    import com.whatanadventure.adventuregame.mvc.models.GameDataModel;
    import com.whatanadventure.adventuregame.mvc.models.MVCLayouts;
    import com.whatanadventure.adventuregame.mvc.views.LoadingScreen;
    import com.whatanadventure.adventuregame.mvc.MVCClassLookUp;

    import feathers.controls.Screen;

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
        private var _mvcLayouts:MVCLayouts;

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
            _gameDataModel = _gameManager.modelManager.getModel(ModelManager.GAME_DATA.name) as GameDataModel;
            _mvcLayouts = _gameManager.modelManager.getModel(ModelManager.MVC_LAYOUTS.name) as MVCLayouts;

            addScreenByViewId(_gameDataModel.firstScreen);
            _gameManager.navigator.showScreen(_gameDataModel.firstScreen);
        }

        private function addScreenByViewId(viewId:String):void
        {
            var firstLayout:MVCLayout = _mvcLayouts.getLayoutByViewId(viewId);
            addScreenByMVCLayout(firstLayout);
        }

        private function addScreenByMVCLayout(mvcLayout:MVCLayout):void
        {
            var controllerClass:Class = MVCClassLookUp[mvcLayout.viewId].controller;
            var controller:MVCController = new controllerClass();
            _gameManager.navigator.addScreen(mvcLayout.viewId, new ScreenNavigatorItem(MVCClassLookUp[mvcLayout.viewId].view, null, {"gameManager":_gameManager, "mvcLayout":mvcLayout, "controller":controller}));
        }

        public function get screenNavigator():ScreenNavigator
        {
            return _screenNavigator;
        }
    }
}
