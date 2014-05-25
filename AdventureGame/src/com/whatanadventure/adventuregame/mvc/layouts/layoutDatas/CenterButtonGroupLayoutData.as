/**
 * Created by Chelsea on 5/8/2014.
 */
package com.whatanadventure.adventuregame.mvc.layouts.layoutDatas
{
    import com.whatanadventure.framework.data.IJsonObject;

    import feathers.data.ListCollection;

    public class CenterButtonGroupLayoutData extends HeaderedLayoutData implements IJsonObject
    {
        private var _dataProvider:ListCollection;

        public function CenterButtonGroupLayoutData(modelName:String)
        {
            super(modelName);
        }

        override public function toJSON():Object
        {
            return null;
        }

        override public function fromJSON(jsonData:Object):void
        {
            super.fromJSON(jsonData);

            _title = jsonData.title;
            _dataProvider = new ListCollection(jsonData.dataProvider);
        }

        public function get dataProvider():ListCollection
        {
            return _dataProvider;
        }
    }
}
