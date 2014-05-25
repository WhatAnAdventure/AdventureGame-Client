/**
 * Created by Chelsea on 5/10/2014.
 */
package com.whatanadventure.adventuregame.mvc.layouts
{
    import com.whatanadventure.adventuregame.mvc.layouts.layoutDatas.CenterButtonGroupLayoutData;
    import com.whatanadventure.framework.mvc.IMVCView;
    import com.whatanadventure.framework.mvc.layout.*;

    import feathers.controls.Button;
    import feathers.controls.ButtonGroup;
    import feathers.core.FeathersControl;
    import feathers.data.ListCollection;
    import feathers.layout.AnchorLayoutData;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Quad;
    import starling.events.Event;
    import starling.utils.Color;

    public class CenterButtonGroupLayout extends HeaderedLayout implements ILayout
    {
        private var _bg:DisplayObject;
        private var _buttonGroup:ButtonGroup;

        public function CenterButtonGroupLayout()
        {
            super();
        }

        override public function init(view:FeathersControl):void
        {
            super.init(view);

            addBackground();
            addButtonGroup();

            updateLayout();
        }

        private function addBackground():void
        {
            _bg = new Quad(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, Color.BLACK);
            _view.addChildAt(_bg, 0);
        }

//        private function addHeader():void
//        {
//            _header = new Header();
//            _header.title = (mvcLayoutData as CenterButtonGroupLayoutData).title;
//            _header.layoutData = new AnchorLayoutData();
//            (_header.layoutData as AnchorLayoutData).percentWidth = 100;
//            _view.addChild(_header);
//        }

        private function addButtonGroup():void
        {
            _buttonGroup = new ButtonGroup();
            var buttonGroupDP:ListCollection = new ListCollection();
            for each (var buttonData:Object in (mvcLayoutData as CenterButtonGroupLayoutData).dataProvider.data)
            {
                buttonGroupDP.data.push({"label": buttonData.label, "triggered": onButtonClicked});
            }
            _buttonGroup.dataProvider = buttonGroupDP;
            var layoutData:AnchorLayoutData = new AnchorLayoutData();
            layoutData.horizontalCenter = 0;
            layoutData.verticalCenter = 0;
            _buttonGroup.layoutData = layoutData;
            _view.addChild(_buttonGroup);
        }

        override public function updateLayout():void
        {
            if (_bg && _view.getChildIndex(_bg) != -1)
                _bg.removeFromParent(true);
            addBackground();
        }

        public function onButtonClicked(event:Event):void
        {
            var functionName:String;
            for each (var buttonData:Object in (mvcLayoutData as CenterButtonGroupLayoutData).dataProvider.data)
            {
                if (buttonData.label == (event.target as Button).label)
                {
                    functionName = buttonData.triggered;
                    break;
                }
            }

            var eventName:String = getButtonEventName((event.target as Button).label);
            if (eventName != null && eventName != "")
            {
                _view.dispatchEventWith(eventName);
            }
            else
            {
                if ((_view as IMVCView).controller.hasOwnProperty(functionName))
                    (_view as IMVCView).controller[functionName](event);
                if (_view.hasOwnProperty(functionName))
                    _view[functionName](event);
            }
        }

        private function getButtonEventName(label:String):String
        {
            var result:String;

            for each (var buttonData:Object in (_mvcLayoutData as CenterButtonGroupLayoutData).dataProvider.data)
            {
                if (buttonData.label == label && buttonData.hasOwnProperty("event"))
                {
                    result = buttonData.event;
                    break;
                }
            }

            return result;
        }
    }
}
