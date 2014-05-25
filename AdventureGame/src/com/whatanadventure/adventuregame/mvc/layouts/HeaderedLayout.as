/**
 * Created by Chelsea on 5/24/2014.
 */
package com.whatanadventure.adventuregame.mvc.layouts
{
    import com.whatanadventure.adventuregame.managers.NavigationManager;
    import com.whatanadventure.adventuregame.mvc.LayoutClassLookUp;
    import com.whatanadventure.adventuregame.mvc.layouts.layoutDatas.HeaderedLayoutData;
    import com.whatanadventure.framework.mvc.layout.ILayout;
    import com.whatanadventure.framework.mvc.layout.MVCLayout;

    import feathers.controls.Button;

    import feathers.controls.Header;
    import feathers.controls.LayoutGroup;
    import feathers.core.FeathersControl;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import starling.display.DisplayObject;

    import starling.events.Event;

    public class HeaderedLayout extends MVCLayout implements ILayout
    {
        protected var _header:Header;
        protected var _backButton:Button;

        public function HeaderedLayout()
        {
            super();
        }

        public function init(view:FeathersControl):void
        {
            if (view is LayoutGroup)
                (view as LayoutGroup).layout = new AnchorLayout();

            _view = view;

            addHeader();
            addBackButton();
        }

        protected function addHeader():void
        {
            _header = new Header();
            _header.title = (mvcLayoutData as HeaderedLayoutData).title;
            _header.layoutData = new AnchorLayoutData();
            (_header.layoutData as AnchorLayoutData).percentWidth = 100;
            _view.addChild(_header);
        }

        private function addBackButton():void
        {
            if ((mvcLayoutData as HeaderedLayoutData).hasBackButton)
            {
                var backButton:Button = new Button();
                backButton.label = "Back";
                backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

                _header.leftItems = new <DisplayObject>[backButton];
            }
        }

        private function backButton_triggeredHandler(event:Event):void
        {
            _view.dispatchEventWith(NavigationManager.BACK_EVENT);
        }

        public function updateLayout():void
        {
        }

        public function get layoutDataClass():Class
        {
            return LayoutClassLookUp[layoutType].layoutData;
        }
    }
}
