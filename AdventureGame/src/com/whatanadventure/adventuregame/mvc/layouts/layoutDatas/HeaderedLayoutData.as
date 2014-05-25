/**
 * Created by Chelsea on 5/10/2014.
 */
package com.whatanadventure.adventuregame.mvc.layouts.layoutDatas
{
    import com.whatanadventure.framework.data.IJsonObject;
    import com.whatanadventure.framework.mvc.layout.MVCLayoutData;

    public class HeaderedLayoutData extends MVCLayoutData implements IJsonObject
    {
        protected var _title:String;

        public function HeaderedLayoutData(modelName:String)
        {
            super(modelName);
        }

        public function toJSON():Object
        {
            return null;
        }

        public function fromJSON(jsonData:Object):void
        {
            _title = jsonData.title;
        }

        public function get title():String
        {
            return _title;
        }
    }
}
