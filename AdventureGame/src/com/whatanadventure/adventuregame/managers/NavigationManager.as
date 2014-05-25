/**
 * Created by Chelsea on 5/7/2014.
 */
package com.whatanadventure.adventuregame.managers
{
    import com.whatanadventure.adventuregame.mvc.MVCClassLookUp;
    import com.whatanadventure.adventuregame.mvc.models.GameDataModel;
    import com.whatanadventure.adventuregame.mvc.models.MVCLayouts;
    import com.whatanadventure.adventuregame.mvc.views.LoadingScreen;
    import com.whatanadventure.framework.mvc.MVCController;
    import com.whatanadventure.framework.mvc.layout.MVCLayout;
    import com.whatanadventure.framework.mvc.view.MVCScreen;
    import com.whatanadventure.framework.util.ObjectUtil;

    import feathers.controls.ScreenNavigator;
    import feathers.controls.ScreenNavigatorItem;
    import feathers.events.FeathersEventType;
    import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class NavigationManager extends EventDispatcher
    {
        public static const BACK_EVENT:String = "back_event";

        private static const LOADING_SCREEN:String = "loadingScreen";
        private static const LOADING_SCREEN_CLASS:Class = LoadingScreen;

        private var _gameManager:GameManager;
        private var _screenNavigator:ScreenNavigator;
        private var _transitionManager:ScreenSlidingStackTransitionManager;
        private var _gameDataModel:GameDataModel;
        private var _mvcLayouts:MVCLayouts;
        private var _screenHistory:Vector.<String>;

        public function NavigationManager(gameManager:GameManager, screenNavigator:ScreenNavigator)
        {
            super();

            _gameManager = gameManager;
            _screenNavigator = screenNavigator;
            _screenHistory = new Vector.<String>();

            _transitionManager = new ScreenSlidingStackTransitionManager(_screenNavigator);
            _transitionManager.duration = 0.4;

            _gameManager.navigator.addScreen(LOADING_SCREEN, new ScreenNavigatorItem(LOADING_SCREEN_CLASS, {"complete":onLoadingScreenComplete}, {"gameManager":_gameManager}));
            _gameManager.navigator.showScreen(LOADING_SCREEN);

            addListeners();
        }

        private function addListeners():void
        {
            _screenNavigator.addEventListener(Event.CHANGE, onScreenChange);
        }

        private function onScreenChange(event:Event):void
        {
            if (_screenHistory.length > 1)
                _screenHistory.splice(0, 1);
            _screenHistory.push(_screenNavigator.activeScreenID);
        }

        private function onLoadingScreenComplete(event:Event):void
        {
            _gameDataModel = _gameManager.modelManager.getModel(ModelManager.GAME_DATA.name) as GameDataModel;
            _mvcLayouts = _gameManager.modelManager.getModel(ModelManager.MVC_VIEWS.name) as MVCLayouts;

            addScreenByViewId(_gameDataModel.firstScreen);
            _gameManager.navigator.showScreen(_gameDataModel.firstScreen);
        }

        private function addScreenByViewId(viewId:String, isNested:Boolean = false):void
        {
            if (_screenNavigator.hasScreen(viewId))
                return; //don't try to add a screen if it already has one

            var firstLayout:MVCLayout = _mvcLayouts.getLayoutByViewId(viewId);
            addScreenByMVCLayout(firstLayout, isNested);
        }

        private function addScreenByMVCLayout(mvcLayout:MVCLayout, isNested:Boolean = false):void
        {
            var controllerClass:Class = (MVCClassLookUp[mvcLayout.mvcType] && MVCClassLookUp[mvcLayout.mvcType].hasOwnProperty("controller")) ? MVCClassLookUp[mvcLayout.mvcType].controller : MVCController;
            var controller:MVCController = new controllerClass();
            var viewClass:Class = (MVCClassLookUp[mvcLayout.mvcType] && MVCClassLookUp[mvcLayout.mvcType].hasOwnProperty("view")) ? MVCClassLookUp[mvcLayout.mvcType].view : MVCScreen;

            var navigations:Object = ObjectUtil.copy(mvcLayout.navigations);
            navigations[BACK_EVENT] = onBackButton;

            _gameManager.navigator.addScreen(mvcLayout.viewId, new ScreenNavigatorItem(viewClass, navigations, {"gameManager":_gameManager, "mvcLayout":mvcLayout, "controller":controller}));

            if (!isNested)
            {
                for each (var viewId:String in mvcLayout.navigations)
                {
                    addScreenByViewId(viewId, true);
                }
            }
        }

        private function onBackButton():void
        {
                var nextScreenId:String = previousScreenId;
                if (!_screenNavigator.hasScreen(nextScreenId))
                    addScreenByViewId(nextScreenId);
                _screenNavigator.showScreen(nextScreenId);
        }

        public function get previousScreenId():String
        {
            var result:String;

            if (_screenHistory.length >= 2)
                result = _screenHistory[_screenHistory.length - 2];

            return result;
        }

        public function get screenNavigator():ScreenNavigator
        {
            return _screenNavigator;
        }
    }
}
