/**
 * Created by Chelsea on 5/10/2014.
 */
package com.whatanadventure.adventuregame.mvc.layouts
{
    import com.whatanadventure.adventuregame.mvc.LayoutClassLookUp;
    import com.whatanadventure.adventuregame.mvc.layouts.layoutDatas.CenterButtonGroupLayoutData;
    import com.whatanadventure.framework.data.IJsonObject;
    import com.whatanadventure.framework.mvc.layout.*;
    import com.whatanadventure.framework.mvc.IMVCView;

    import feathers.controls.Button;
    import feathers.controls.ButtonGroup;
    import feathers.controls.Header;
    import feathers.controls.LayoutGroup;
    import feathers.core.FeathersControl;
    import feathers.data.ListCollection;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import starling.core.Starling;

    import starling.display.DisplayObject;
    import starling.display.Quad;
    import starling.events.Event;
    import starling.utils.Color;

    public class CenterButtonGroupLayout extends MVCLayout implements ILayout, IJsonObject
    {
        protected var _view:FeathersControl;

        private var _bg:DisplayObject;
        private var _header:Header;
        private var _buttonGroup:ButtonGroup;

        public function CenterButtonGroupLayout()
        {
            super();
        }

        public function init(view:FeathersControl):void
        {
            if (view is LayoutGroup)
                (view as LayoutGroup).layout = new AnchorLayout();

            _view = view;

            addBackground();
            addHeader();
            addButtonGroup();

            updateLayout();
        }

        private function addBackground():void
        {
            _bg = new Quad(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, Color.BLACK);
            _view.addChildAt(_bg, 0);
        }

        private function addHeader():void
        {
            _header = new Header();
            _header.title = (mvcLayoutData as CenterButtonGroupLayoutData).title;
            _header.layoutData = new AnchorLayoutData();
            (_header.layoutData as AnchorLayoutData).percentWidth = 100;
            _view.addChild(_header);
        }

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

        public function updateLayout():void
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

            (_view as IMVCView).controller[functionName](event);
//            _view[functionName](event);
        }

        public function toJSON():Object
        {
            return null;
        }

        public function fromJSON(jsonData:Object):void
        {
            _layoutClass = jsonData.layoutClass;
            _viewId = jsonData.viewId;

            var layoutDataClass:Class = LayoutClassLookUp[layoutClass].layoutData;
            var mvcViewLayoutData:MVCLayoutData = new layoutDataClass(_viewId) as MVCLayoutData;
            (mvcViewLayoutData as IJsonObject).fromJSON(jsonData.layoutData);
            _mvcLayoutData = mvcViewLayoutData;
        }
    }
}
