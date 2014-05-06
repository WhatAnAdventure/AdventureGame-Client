/**
 * Created by Chelsea on 4/27/2014.
 */
package com.whatanadventure.adventuregame.mvc.views
{
    import com.whatanadventure.adventuregame.managers.GameManager;
    import com.whatanadventure.framework.mvc.IMVCView;
    import com.whatanadventure.framework.mvc.MVCView;

    import feathers.controls.ButtonGroup;
    import feathers.controls.Header;

    import feathers.controls.Screen;
    import feathers.data.ListCollection;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import starling.core.Starling;

    import starling.display.DisplayObject;

    import starling.display.Quad;
    import starling.events.Event;
    import starling.utils.Color;

    public class MainMenu extends Screen implements IMVCView
    {
        private var _gameManager:GameManager;

        private var _bg:DisplayObject;
        private var _header:Header;
        private var _buttonGroup:ButtonGroup;

        public function MainMenu()
        {
            super();

            layout = new AnchorLayout();
        }

        public function set gameManager(value:GameManager):void
        {
            _gameManager = value;

            init();
        }

        private function init():void
        {
            addBackground();
            addHeader();
            addButtonGroup();

            updateLayout();
        }

        private function addBackground():void
        {
            _bg = new Quad(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, Color.BLACK);
            addChildAt(_bg, 0);
        }

        private function addHeader():void
        {
            _header = new Header();
            _header.title = "Main Menu";
            _header.layoutData = new AnchorLayoutData();
            (_header.layoutData as AnchorLayoutData).percentWidth = 100;
            addChild(_header);
        }

        private function addButtonGroup():void
        {
            _buttonGroup = new ButtonGroup();
            _buttonGroup.dataProvider = new ListCollection(
                    [
                        {label: "Start Game", triggered: onStartGame},
                        {label: "Load Game", triggered: onLoadGame},
                        {label: "Settings", triggered: onSettings},
                    ]
            );
            var layoutData:AnchorLayoutData = new AnchorLayoutData();
            layoutData.horizontalCenter = 0;
            layoutData.verticalCenter = 0;
            _buttonGroup.layoutData = layoutData;
            addChild(_buttonGroup);
        }

        private function onStartGame(event:Event):void
        {
            trace("onStartGame");
        }

        private function onLoadGame(event:Event):void
        {
            trace("onLoadGame");
        }

        private function onSettings(event:Event):void
        {
            trace("onSettings");
        }

        public function reinitialize():void
        {
            invalidate(MVCView.INVALIDATION_FLAG_ROTATE);
        }

        override protected function draw():void
        {
            super.draw();

            if (isInvalid(MVCView.INVALIDATION_FLAG_ROTATE))
            {
                updateLayout();
            }
        }

        public function updateLayout():void
        {
            if (_bg && getChildIndex(_bg) != -1)
                _bg.removeFromParent(true);
            addBackground();
        }
    }
}
