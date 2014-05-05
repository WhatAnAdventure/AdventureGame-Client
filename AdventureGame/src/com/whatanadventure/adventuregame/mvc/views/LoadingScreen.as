/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.adventuregame.mvc.views
{
    import com.whatanadventure.adventuregame.config.GameConfig;
    import com.whatanadventure.adventuregame.embedded.LoadingBG;
    import com.whatanadventure.adventuregame.managers.GameManager;
    import com.whatanadventure.framework.mvc.IMVCView;

    import feathers.controls.Button;
    import feathers.controls.ProgressBar;
    import feathers.controls.Screen;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import flash.events.ProgressEvent;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.events.Event;
    import starling.textures.Texture;

    public class LoadingScreen extends Screen implements IMVCView
    {
        protected var _bg:Image;
        protected var _progressBar:ProgressBar;
        protected var _playButton:Button;

        public function LoadingScreen()
        {
            super();

            layout = new AnchorLayout();
        }

        protected var _gameManager:GameManager;
        private var _isComplete:Boolean;

        public function set gameManager(value:GameManager):void
        {
            _gameManager = value;

            initLoadingScreen();
        }

        protected function initLoadingScreen():void
        {
            addLoadingBG();
            if (!_isComplete)
                addProgressBar();
            else
                addPlayButton();
            _gameManager.resourceManager.addEventListener(ProgressEvent.PROGRESS, onProgress);
            _gameManager.resourceManager.addEventListener(Event.COMPLETE, onComplete);
        }

        private function onProgress(event:Event):void
        {
            _progressBar.value = Math.floor((event.data.bytesLoaded / event.data.bytesTotal) * 100);
            trace("Progress Bar: " + _progressBar.value + "%");
        }

        private function onComplete(event:Event):void
        {
            trace("PROGRESS BAR COMPLETE!");
            _progressBar.removeFromParent(true);
            _isComplete = true;
            addPlayButton();
        }

        private function addPlayButton():void
        {
            _playButton = new Button();
            _playButton.label = "Play";
            var layoutData:AnchorLayoutData = new AnchorLayoutData();
            layoutData.horizontalCenter = 0;
            layoutData.verticalCenter = Starling.current.stage.stageHeight / 3;
            if (GameConfig.screenOrientation == GameConfig.SCREEN_ORIENTATIONS.landscape)
                layoutData.verticalCenter *= -1;
            _playButton.layoutData = layoutData;
            _playButton.addEventListener(Event.TRIGGERED, onPlay);
            addChild(_playButton);
        }

        private function onPlay(event:Event):void
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }

        protected function addLoadingBG():void
        {
            _bg = addChildAt(new Image(Texture.fromBitmap(LoadingBG.getBitmap())), 0) as Image;
        }

        protected function addProgressBar():void
        {
            _progressBar = new ProgressBar();
            _progressBar.minimum = 0;
            _progressBar.maximum = 100;
            _progressBar.value = 0;
//            _progressBar.width = Starling.current.stage.stageWidth * (2/3);

            var layoutData:AnchorLayoutData = new AnchorLayoutData();
            layoutData.horizontalCenter = 0;
            layoutData.verticalCenter = Starling.current.stage.stageHeight / 3;
            if (GameConfig.screenOrientation == GameConfig.SCREEN_ORIENTATIONS.landscape)
                layoutData.verticalCenter *= -1;
            _progressBar.layoutData = layoutData;
            addChild(_progressBar);
        }

        public function reinitialize()
        {
            removeChildren(0, -1, true);
            initLoadingScreen();
        }
    }
}
