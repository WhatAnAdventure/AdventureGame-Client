/**
 * Created by Chelsea on 5/8/2014.
 */
package com.whatanadventure.adventuregame.mvc.layouts.layoutDatas
{
    import com.whatanadventure.framework.mvc.layout.*;
    import com.whatanadventure.framework.data.IJsonObject;

    import feathers.data.ListCollection;

    public class CenterButtonGroupLayoutData extends MVCLayoutData implements IJsonObject
    {
        private var _title:String;
        private var _dataProvider:ListCollection;

        public function CenterButtonGroupLayoutData(modelName:String)
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
            _dataProvider = new ListCollection(jsonData.dataProvider);
        }

        public function get title():String
        {
            return _title;
        }

        public function get dataProvider():ListCollection
        {
            return _dataProvider;
        }
    }
}
