/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.adventuregame.screens
{
    import com.whatanadventure.adventuregame.embedded.AdventureGameLoadingBG;
    import com.whatanadventure.adventuregame.managers.GameManager;

    import feathers.controls.ProgressBar;
    import feathers.controls.Screen;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.textures.Texture;

    public class LoadingScreen extends Screen
    {
        public function LoadingScreen()
        {
            super();

            layout = new AnchorLayout();
        }
        protected var _bg:Image;
        protected var _progressBar:ProgressBar;

        protected var _gameManager:GameManager;

        public function set gameManager(value:GameManager):void
        {
            _gameManager = value;

            initLoadingScreen();
        }

        protected function initLoadingScreen():void
        {
            addLoadingBG();
            addProgressBar();
        }

        protected function addLoadingBG():void
        {
            _bg = addChildAt(new Image(Texture.fromBitmap(AdventureGameLoadingBG.getBitmap())), 0) as Image;
        }

        protected function addProgressBar():void
        {
            _progressBar = new ProgressBar();
            _progressBar.minimum = 0;
            _progressBar.maximum = 100;
            _progressBar.value = 50;
//            _progressBar.width = Starling.current.stage.stageWidth * (2/3);

            var layoutData:AnchorLayoutData = new AnchorLayoutData();
            layoutData.horizontalCenter = 0;
            layoutData.verticalCenter = Starling.current.stage.stageHeight / 3;
            _progressBar.layoutData = layoutData;
            addChild(_progressBar);
        }
    }
}
