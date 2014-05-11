/**
 * Created by Chelsea on 5/3/2014.
 */
package com.whatanadventure.adventuregame.mvc.models
{
    import com.whatanadventure.framework.data.IJsonObject;
    import com.whatanadventure.framework.managers.BaseGameManager;
    import com.whatanadventure.framework.mvc.IMVCModel;
    import com.whatanadventure.framework.mvc.MVCModel;

    public class GameDataModel extends MVCModel implements IMVCModel, IJsonObject
    {
        private var _defaultTheme:String;
        private var _firstScreen:String;

        public function GameDataModel(modelName:String)
        {
            super(modelName);
        }

        public function toJSON():Object
        {
            return null;
        }

        public function fromJSON(jsonData:Object):void
        {
        }

        public function get defaultTheme():String
        {
            return _defaultTheme;
        }

        public function set defaultTheme(value:String):void
        {
            _defaultTheme = value;
        }

        public function get firstScreen():String
        {
            return _firstScreen;
        }

        public function set firstScreen(value:String):void
        {
            _firstScreen = value;
        }
    }
}
