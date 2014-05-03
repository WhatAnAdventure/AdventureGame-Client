/**
 * Created by Chelsea on 4/28/2014.
 */
package
{
    import com.whatanadventure.adventuregame.config.GameConfig;

    import flash.events.Event;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import starling.core.Starling;
    import starling.events.Event;

    public class WebGame extends MobileGame
    {
        private static var _startup:WebStartupFantasyGame;

        public static function setStartup(startup:WebStartupFantasyGame):void
        {
            _startup = startup;
        }

        public function WebGame()
        {
            Starling.current.addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
        }

        override public function start():void
        {
            init();

            super.start();
        }

        private function init():void
        {
            GameConfig.flashStage = _startup.stage;

            Starling.current.enableErrorChecking = false;

            resizeStarlingStage();

            GameConfig.flashStage.addEventListener(flash.events.Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
            GameConfig.flashStage.addEventListener(flash.events.Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
        }

        private function resizeStarlingStage():void
        {
            var stageDimenstions:Point = GameConfig.getNewStarlingStageDimensions(GameConfig.stageWidth, GameConfig.stageHeight);

            Starling.current.stage.stageWidth = stageDimenstions.x;
            Starling.current.stage.stageHeight = stageDimenstions.y;

            const viewPort:Rectangle = Starling.current.viewPort;
            viewPort.width = stage.stageWidth;
            viewPort.height = stage.stageHeight;
            try
            {
                Starling.current.viewPort = viewPort;
            } catch (error:Error)
            {
            }
        }

        protected function stage_resizeHandler(event:flash.events.Event):void
        {
            resizeStarlingStage();
        }

        protected function stage_deactivateHandler(event:flash.events.Event):void
        {
            Starling.current.stop();
            GameConfig.flashStage.addEventListener(flash.events.Event.ACTIVATE, stage_activateHandler, false, 0, true);
        }

        protected function stage_activateHandler(event:flash.events.Event):void
        {
            GameConfig.flashStage.removeEventListener(flash.events.Event.ACTIVATE, stage_activateHandler);
            Starling.current.start();
        }

        private function onRootCreated(event:starling.events.Event):void
        {
            Starling.current.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);

            start();
            Starling.current.start();
            _startup.clearScreen();
        }
    }
}
