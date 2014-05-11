/**
 * Created by Chelsea on 5/8/2014.
 */
package com.whatanadventure.adventuregame.mvc.models
{
    import com.whatanadventure.adventuregame.mvc.MVCClassLookUp;
    import com.whatanadventure.framework.data.IJsonObject;
    import com.whatanadventure.framework.mvc.IMVCModel;
    import com.whatanadventure.framework.mvc.MVCModel;
    import com.whatanadventure.adventuregame.mvc.LayoutClassLookUp;
    import com.whatanadventure.framework.mvc.layout.MVCLayout;

    public class MVCLayouts extends MVCModel implements IMVCModel, IJsonObject
    {
        protected var _mvcLayouts:Vector.<MVCLayout>;

        public function MVCLayouts(modelName:String)
        {
            super(modelName);
        }

        public function getLayoutByViewId(viewId:String):MVCLayout
        {
            var result:MVCLayout;

            for each (var iLayout:MVCLayout in _mvcLayouts)
            {
                if (iLayout.viewId == viewId)
                {
                    result = iLayout;
                    break;
                }
            }

            return result;
        }

        public function toJSON():Object
        {
            return null;
        }

        public function fromJSON(jsonData:Object):void
        {
            _mvcLayouts = new Vector.<MVCLayout>();

            var layoutClass:Class;
            var mvcLayout:MVCLayout;
            for each (var layoutJson:Object in jsonData.layouts)
            {
                layoutClass = LayoutClassLookUp[layoutJson.layoutClass].layout;
                mvcLayout = new layoutClass();
                (mvcLayout as IJsonObject).fromJSON(layoutJson);
                _mvcLayouts.push(mvcLayout);
            }
        }
    }
}
