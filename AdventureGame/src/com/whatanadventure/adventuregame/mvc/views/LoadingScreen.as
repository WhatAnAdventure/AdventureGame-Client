/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.adventuregame.mvc.views
{
    import com.whatanadventure.adventuregame.config.GameConfig;
    import com.whatanadventure.adventuregame.embedded.LoadingBG;
    import com.whatanadventure.adventuregame.managers.GameManager;
    import com.whatanadventure.framework.mvc.MVCController;
    import com.whatanadventure.framework.mvc.layout.ILayout;
    import com.whatanadventure.framework.mvc.layout.MVCLayout;
    import com.whatanadventure.framework.mvc.IMVCView;
    import com.whatanadventure.framework.mvc.MVCView;

    import feathers.controls.Button;
    import feathers.controls.ProgressBar;
    import feathers.controls.Screen;
    import feathers.core.FeathersControl;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import flash.events.ProgressEvent;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.events.Event;
    import starling.textures.Texture;

    public class LoadingScreen extends Screen implements IMVCView
    {
        protected var _gameManager:GameManager;
        private var _isComplete:Boolean;

        protected var _bg:Image;
        protected var _progressBar:ProgressBar;
        protected var _playButton:Button;

        public function LoadingScreen()
        {
            super();

            layout = new AnchorLayout();
        }

        public function set gameManager(value:GameManager):void
        {
            _gameManager = value;

            initLoadingScreen();
        }

        protected function initLoadingScreen():void
        {
//            addLoadingBG();
            if (!_isComplete)
                addProgressBar();
            else
                addPlayButton();
            _gameManager.resourceManager.addEventListener(ProgressEvent.PROGRESS, onProgress);
            _gameManager.resourceManager.addEventListener(Event.COMPLETE, onComplete);
            updateLayout();
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
            updateLayout();
        }

        private function addPlayButton():void
        {
            _playButton = new Button();
            _playButton.label = "Play";
            var layoutData:AnchorLayoutData = new AnchorLayoutData();
//            layoutData.horizontalCenter = 0;
//            layoutData.verticalCenter = Starling.current.stage.stageHeight / 3;
//            if (GameConfig.screenOrientation == GameConfig.SCREEN_ORIENTATIONS.landscape)
//                layoutData.verticalCenter *= -1;
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
//            layoutData.horizontalCenter = 0;
//            layoutData.verticalCenter = Starling.current.stage.stageHeight / 3;
//            if (GameConfig.screenOrientation == GameConfig.SCREEN_ORIENTATIONS.landscape)
//                layoutData.verticalCenter *= -1;
            _progressBar.layoutData = layoutData;
            addChild(_progressBar);
        }

        override protected function draw():void
        {
            super.draw();

            if (isInvalid(MVCView.INVALIDATION_FLAG_ROTATE))
            {
                updateLayout();
            }
        }

        public function reinitialize():void
        {
            invalidate(MVCView.INVALIDATION_FLAG_ROTATE);
        }

        private function updateLayout():void
        {
            if (_bg && getChildIndex(_bg) != -1)
                _bg.removeFromParent(true);
            addLoadingBG();

            if (_progressBar && getChildIndex(_progressBar) != -1)
            {
                (_progressBar.layoutData as AnchorLayoutData).horizontalCenter = 0;
                (_progressBar.layoutData as AnchorLayoutData).verticalCenter = Starling.current.stage.stageHeight / 3;
                if (GameConfig.screenOrientation == GameConfig.SCREEN_ORIENTATIONS.landscape)
                    (_progressBar.layoutData as AnchorLayoutData).verticalCenter *= -1;
            }

            if (_playButton && getChildIndex(_playButton) != -1)
            {
                (_playButton.layoutData as AnchorLayoutData).horizontalCenter = 0;
                (_playButton.layoutData as AnchorLayoutData).verticalCenter = Starling.current.stage.stageHeight / 3;
                (_playButton.layoutData as AnchorLayoutData).percentWidth = (2/3) * 100;
                if (GameConfig.screenOrientation == GameConfig.SCREEN_ORIENTATIONS.landscape)
                    (_playButton.layoutData as AnchorLayoutData).verticalCenter *= -1;
            }
        }

        public function get mvcViewLayout():MVCLayout
        {
            //special case, none needed
            return null;
        }

        public function get controller():MVCController
        {
            //special case, none needed
            return null;
        }

        public function onModelChange(event:Event):void
        {
            //special case, none needed
        }

        public function get mvcLayoutData():ILayout
        {
            //special case, none needed
            return null;
        }

        public function addLayout():void
        {
            //special case, none needed
        }

        public function addController():void
        {
            //special case, none needed
        }

        public function addModels():void
        {
            //special case, none needed
        }

        public function set mvcLayout(value:ILayout):void
        {
            //special case, none needed
        }

        public function get mvcLayout():ILayout
        {
            //special case, none needed
            return null;
        }

        public function set controller(controller:MVCController):void
        {
            //special case, none needed
        }

        public function get viewId():String
        {
            //special case, none needed
            return "";
        }
    }
}
