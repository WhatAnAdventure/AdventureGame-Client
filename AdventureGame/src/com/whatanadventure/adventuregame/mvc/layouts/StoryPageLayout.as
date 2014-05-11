/**
 * Created by Chelsea on 5/10/2014.
 */
package com.whatanadventure.adventuregame.mvc.layouts
{
    import com.whatanadventure.adventuregame.mvc.LayoutClassLookUp;
    import com.whatanadventure.adventuregame.mvc.layouts.layoutDatas.StoryPageLayoutData;
    import com.whatanadventure.framework.mvc.layout.ILayout;
    import com.whatanadventure.framework.mvc.layout.MVCLayout;

    import feathers.controls.Header;
    import feathers.controls.LayoutGroup;
    import feathers.core.FeathersControl;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import starling.display.DisplayObject;

    public class StoryPageLayout extends MVCLayout implements ILayout
    {

        private var _bg:DisplayObject;
        private var _header:Header;

        public function StoryPageLayout()
        {
            super();
        }

        public function init(view:FeathersControl):void
        {
            if (view is LayoutGroup)
                (view as LayoutGroup).layout = new AnchorLayout();

            _view = view;

//            addBackground();
            addHeader();
        }

        private function addHeader():void
        {
            _header = new Header();
            _header.title = (mvcLayoutData as StoryPageLayoutData).title;
            _header.layoutData = new AnchorLayoutData();
            (_header.layoutData as AnchorLayoutData).percentWidth = 100;
            _view.addChild(_header);
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
