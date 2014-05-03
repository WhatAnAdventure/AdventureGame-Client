/**
 * Created by Chelsea on 4/27/2014.
 */
package com.whatanadventure.adventuregame.config
{
    import flash.display.Stage;
    import flash.geom.Point;
    import flash.system.Capabilities;

    public class GameConfig
    {

        public static const SWF_WIDTH:int = 640;
        public static const SWF_HEIGHT:int = 960;
        public static var PLATFORMS:Object = {
            "iOS": "iOS",
            "Android": "Android",
            "Web": "Web",
            "Desktop": "Desktop"
        };
        public static var flashStage:Stage;
        public static var swfScale:Number;

        public static function get stageWidth():int
        {
            var result:int;

            result = (isMobile()) ? flashStage.fullScreenWidth : flashStage.stageWidth;

            return result;
        }

        public static function get stageHeight():int
        {
            var result:int;

            result = (isMobile()) ? flashStage.fullScreenHeight : flashStage.stageHeight;

            return result;
        }

        public static function getPlatform():String
        {
            if (PLATFORMS[Capabilities.manufacturer])
                return Capabilities.manufacturer;
            else if (Capabilities.manufacturer.indexOf("Adobe") != -1)
                return PLATFORMS.Desktop;
            else
                return PLATFORMS.Web;
        }

        public static function isMobile():Boolean
        {
            var platform:String = getPlatform();
            return (platform == PLATFORMS.Android || platform == PLATFORMS.iOS);

        }

        public static function getNewStarlingStageDimensions(stageWidth:int, stageHeight:int):Point
        {
            var tmp:Number;
            var isLandscape:Boolean = (stageWidth > stageHeight);
            if (isLandscape)
            {
                tmp = stageWidth;
                stageWidth = stageHeight;
                stageHeight = tmp;
            }

            if (!GameConfig.swfScale)
            {
                if (stageWidth / stageHeight <= SWF_WIDTH / SWF_HEIGHT)
                    GameConfig.swfScale = SWF_WIDTH / stageWidth;
                else
                    GameConfig.swfScale = SWF_HEIGHT / stageHeight;
            }

            stageWidth *= GameConfig.swfScale;
            stageHeight *= GameConfig.swfScale;

            if (isLandscape)
            {
                tmp = stageWidth;
                stageWidth = stageHeight;
                stageHeight = tmp;
            }

            return new Point(stageWidth, stageHeight);
        }

        public function GameConfig()
        {
        }
    }
}
