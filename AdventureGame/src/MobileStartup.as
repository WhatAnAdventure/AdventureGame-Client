package {

    import com.whatanadventure.adventuregame.config.GameConfig;
    import com.whatanadventure.adventuregame.embedded.SplashScreen;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.display3D.Context3DProfile;
    import flash.display3D.Context3DRenderMode;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import starling.core.Starling;
    import starling.events.Event;

    [SWF(width="640", height="960", frameRate="60", backgroundColor="#2f2f2f")]
    public class MobileStartup extends Sprite
    {
        public function MobileStartup()
        {
            addEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame);
        }

        protected var _starling:Starling;
        protected var _app:MobileGame;

        protected function addSplashScreen():void
        {
            addChildAt(SplashScreen.getBitmap(), 0);
        }

        private function init():void
        {
            if (stage)
            {
                stage.scaleMode = StageScaleMode.SHOW_ALL;
                stage.align = StageAlign.TOP_LEFT;
            }
            mouseEnabled = mouseChildren = false;

            Starling.handleLostContext = true;
            Starling.multitouchEnabled = true;

            stage.autoOrients = false;

            GameConfig.flashStage = stage;

            var viewport:Rectangle = new Rectangle(0, 0, GameConfig.stageWidth, GameConfig.stageHeight);
            _starling = new Starling(MobileGame, stage, viewport, null, Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
            _starling.addEventListener(starling.events.Event.ROOT_CREATED,
                    function onRootCreated(event:Object, app:MobileGame):void
                    {
                        _app = app;
                        _starling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
                        removeChildAt(0); //splash screen

                        app.start();
                        _starling.start();
                    }
            );
            _starling.enableErrorChecking = false;

            resizeStarlingStage();

            addSplashScreen();

            //_starling.showStats = true;
            //_starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
            _starling.start();

            stage.addEventListener(flash.events.Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
            stage.addEventListener(flash.events.Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
        }

        private function resizeStarlingStage():void
        {
            var stageDimenstions:Point = GameConfig.getNewStarlingStageDimensions(GameConfig.stageWidth, GameConfig.stageHeight);

            _starling.stage.stageWidth = stageDimenstions.x;
            _starling.stage.stageHeight = stageDimenstions.y;

            const viewPort:Rectangle = _starling.viewPort;
            viewPort.width = stage.stageWidth;
            viewPort.height = stage.stageHeight;
            try
            {
                _starling.viewPort = viewPort;
            }
            catch (error:Error)
            {
            }

            //            trace("Starling stage1 (" + _starling.stage.stageWidth + ", "  + _starling.stage.stageHeight + ")");
            //            trace("Starling stage2 (" + _starling.stage.width + ", "  + _starling.stage.height + ")");
        }

        protected function stage_resizeHandler(event:flash.events.Event):void
        {
            resizeStarlingStage();
        }

        protected function stage_deactivateHandler(event:flash.events.Event):void
        {
            _starling.stop();
            stage.addEventListener(flash.events.Event.ACTIVATE, stage_activateHandler, false, 0, true);
        }

        protected function stage_activateHandler(event:flash.events.Event):void
        {
            stage.removeEventListener(flash.events.Event.ACTIVATE, stage_activateHandler);
            _starling.start();
        }

        private function onEnterFrame(event:flash.events.Event):void
        {
            removeEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame);
            init();
        }
    }
}
