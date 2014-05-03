/**
 * Created by Chelsea on 5/3/2014.
 */
package com.whatanadventure.adventuregame.mvc.models
{
    import com.whatanadventure.framework.managers.BaseGameManager;
    import com.whatanadventure.framework.mvc.IMVCModel;
    import com.whatanadventure.framework.mvc.MVCModel;

    public class GameDataModel extends MVCModel implements IMVCModel
    {
        private var _defaultTheme:String;

        public function GameDataModel(gameManager:BaseGameManager, modelName:String)
        {
            super(gameManager, modelName);
        }

        public function toJSON():Object
        {
            return null;
        }

        public function fromJSON(data:Object):void
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
    }
}
