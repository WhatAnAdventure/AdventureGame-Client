/**
 * Created by Chelsea on 4/27/2014.
 */
package {
    import com.whatanadventure.adventuregame.config.GameConfig;
    import com.whatanadventure.adventuregame.managers.GameManager;
    import com.whatanadventure.adventuregame.mvc.views.LoadingScreen;
    import com.whatanadventure.adventuregame.mvc.views.MainMenu;
    import com.whatanadventure.framework.mvc.IMVCView;

    import feathers.controls.ScreenNavigator;
    import feathers.controls.ScreenNavigatorItem;
    import feathers.core.DisplayListWatcher;
    import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

    import flash.geom.Rectangle;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.ResizeEvent;

    import themes.MetalWorksMobileTheme.source.feathers.themes.MetalWorksMobileTheme;

    public class MobileGame extends Sprite
    {
        private static const MAIN_MENU:String = "mainMenu";
        private static const LOADING_SCREEN:String = "loadingScreen";

        public function MobileGame()
        {
            super();
        }

        private var _theme:DisplayListWatcher;
        private var _navigator:ScreenNavigator;
        private var _transitionManager:ScreenSlidingStackTransitionManager;
        private var _gameManager:GameManager;

        public function start():void
        {
            setTheme();

            _gameManager = new GameManager();
            _gameManager.init();

            _gameManager.resourceManager.addEventListener(Event.COMPLETE, onResourceManagerComplete);

            _navigator = new ScreenNavigator();
            addChild(_navigator);

            _navigator.addScreen(LOADING_SCREEN, new ScreenNavigatorItem(LoadingScreen, {"complete":MAIN_MENU}, {"gameManager":_gameManager}));
            _navigator.addScreen(MAIN_MENU, new ScreenNavigatorItem(MainMenu, null, {"gameManager":_gameManager}));

            _navigator.showScreen(LOADING_SCREEN);

            _transitionManager = new ScreenSlidingStackTransitionManager(_navigator);
            _transitionManager.duration = 0.4;
        }

        private function onResourceManagerComplete(event:Event):void
        {
            _gameManager.resourceManager.removeEventListener(Event.COMPLETE, onResourceManagerComplete);

            if (GameConfig.getPlatform() == GameConfig.PLATFORMS.Mobile || GameConfig.getPlatform() == GameConfig.PLATFORMS.Emulator)
            {
                Starling.current.nativeStage.autoOrients = true;
                Starling.current.stage.addEventListener(Event.RESIZE, onResize);
            }
        }

        /** This event handler is called when the device rotates. */
        private function onResize(event:ResizeEvent):void
        {
            updateDimensions(event.width, event.height);
            updatePositions(event.width, event.height);
        }

        /** Updates the size of stage and viewPort depending on the
         *  current screen size in PIXELS. */
        private function updateDimensions(width:int, height:int):void
        {
            var scale:Number = Starling.current.contentScaleFactor;
            var viewPort:Rectangle = new Rectangle(0, 0, width, height);

            Starling.current.viewPort = viewPort;
            stage.stageWidth  = viewPort.width  / scale;
            stage.stageHeight = viewPort.height / scale;
        }

        /** This is the hard part: update your user interface for the new orientation. */
        private function updatePositions(width:int, height:int):void
        {
            // Update the positions of the objects that make up your game.
           invalidateParentFeathersControl(Starling.current.stage);
        }

        private function invalidateParentFeathersControl(displayObject:DisplayObject):Boolean
        {
            var result:Boolean;

            if (displayObject is IMVCView)
            {
                (displayObject as IMVCView).reinitialize();
                result = true;
            }

            if (!result)
            {
                if (displayObject is DisplayObjectContainer)
                {
                    for (var i:int = 0; i < (displayObject as DisplayObjectContainer).numChildren; i++)
                    {
                        if (invalidateParentFeathersControl((displayObject as DisplayObjectContainer).getChildAt(i)));
                            break;
                    }
                }
            }

            return result;
        }

//        private function onRotate(event:ResizeEvent):void
//        {
//            var viewport:Rectangle = new Rectangle(0, 0, event.width, event.height);
//
//            Starling.current.viewPort = viewport;
//
//            if ((event.width - event.height) * (stage.stageWidth - stage.stageHeight) < 0)
//            {
//                var tmp:int = stage.stageWidth;
//                stage.stageWidth = stage.stageWidth;
//                stage.stageWidth = tmp;
//            }
//        }

        protected function setTheme():void
        {
            _theme = new MetalWorksMobileTheme(stage);
        }
    }
}
