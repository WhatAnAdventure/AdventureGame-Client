package
{

    import assets.embed.AdventureGameLoadingBG;

    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.text.TextField;
    import flash.utils.getDefinitionByName;

    [SWF(width="960", height="640", frameRate="60", backgroundColor="#2f2f2f")]
    public class WebStartup extends MovieClip
    {
        public function WebStartup()
        {
            addLoadingBG();
            _loadingProgress = addChild(new TextField()) as TextField;
            _loadingProgress.text = "0%";
            preload();
        }

        protected var _loadingProgress:TextField;
        protected var _bg:DisplayObject;

        public function clearScreen():void
        {
            removeChild(_bg);
            _bg = null;

            removeChild(_loadingProgress);
            _loadingProgress = null;
        }

        protected function addLoadingBG():void
        {
            _bg = addChild(AdventureGameLoadingBG.getBitmap());
        }

        protected function preload():void
        {
            stop();

            loaderInfo.addEventListener(ProgressEvent.PROGRESS, onPreloaderProgress);
            loaderInfo.addEventListener(Event.COMPLETE, onPreloaderComplete);
        }

        private function init():void
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

            const StarlingType:Class = getDefinitionByName("starling.core.Starling") as Class;
            const MainType:Class = getDefinitionByName("WebGame") as Class;
            new StarlingType(MainType, stage)//, viewport, null);
            MainType.setStartup(this);

            //            stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
            //            stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
        }

        protected function onPreloaderProgress(event:ProgressEvent):void
        {
            var ratio:Number = Math.round((event.bytesLoaded / event.bytesTotal) * 100);
            _loadingProgress.text = ratio + "%";
        }

        protected function onPreloaderComplete(event:Event):void
        {
            loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onPreloaderProgress);
            loaderInfo.removeEventListener(Event.COMPLETE, onPreloaderComplete);

            gotoAndStop(2);
            init();
        }
    }
}
