/**
 * Created by Chelsea on 4/27/2014.
 */
package com.whatanadventure.adventuregame.config
{
    import flash.desktop.NativeApplication;
    import flash.display.Stage;
    import flash.geom.Point;
    import flash.system.Capabilities;

    import starling.core.Starling;

    public class GameConfig
    {

        public static const SWF_WIDTH:int = 640;
        public static const SWF_HEIGHT:int = 960;
        public static var PLATFORMS:Object = {
//            "iOS": "iOS",
//            "Android": "Android",
            "Mobile": "Mobile",
            "Web": "Web",
            "Emulator": "Emulator",
            "Desktop": "Desktop"
        };
        public static const BUILD_ENVIRONMENTS:Object = {
            "LIVE":"LIVE",
            "DEV":"DEV"
        };
        public static const SHARED_OBJECT_NAME:String = "com.whatanadventure.adventuregame";
        public static function get environment():String
        {
            var result:String;

            if (BUILD_ENVIRONMENTS.hasOwnProperty(DEFINE::BUILD))
                result = BUILD_ENVIRONMENTS[DEFINE::BUILD];

            return result;
        };
        public static var flashStage:Stage;
        public static var swfScale:Number;

        public static function get stageWidth():int
        {
            var result:int;

            result = (getPlatform() == PLATFORMS.Mobile) ? flashStage.fullScreenWidth : flashStage.stageWidth;

            return result;
        }

        public static function get stageHeight():int
        {
            var result:int;

            result = (getPlatform() == PLATFORMS.Mobile) ? flashStage.fullScreenHeight : flashStage.stageHeight;

            return result;
        }

        public static function getPlatform():String
        {
            var result:String;

            if (Capabilities.manufacturer == "iOS" || Capabilities.manufacturer == "Android")
                result = PLATFORMS.Mobile;
            else if (Capabilities.manufacturer.indexOf("Adobe") != -1)
            {
                if (getAppId().indexOf(PLATFORMS.Desktop) != -1)
                    result = PLATFORMS.Desktop;
                else
                    result = PLATFORMS.Emulator;
            }
            else
                result = PLATFORMS.Web;

            trace("manufacturer: " + Capabilities.manufacturer);
            return result;
        }

        public static function getAppId():String
        {
            var result:String;

            if (NativeApplication.nativeApplication)
            {
                var appDescriptor:XML = NativeApplication.nativeApplication.applicationDescriptor;
                var ns:Namespace = appDescriptor.namespace();
                var appId:String = appDescriptor.ns::id;
                var appVersion:String = appDescriptor.ns::version;
                trace("appId:", appId);
                trace("version:", appVersion);
                result = appId;
            }

            return result;
        }

//        public static function isMobile():Boolean
//        {
//            var platform:String = getPlatform();
//            return (platform == PLATFORMS.Android || platform == PLATFORMS.iOS);
//
//        }

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

        public static var SCREEN_ORIENTATIONS:Object = {
            "landscape":"landscape",
            "portrait":"portrait"
        };
        public static function get screenOrientation():String
        {
            return (Starling.current.stage.stageHeight < Starling.current.stage.stageWidth) ? SCREEN_ORIENTATIONS.landscape : SCREEN_ORIENTATIONS.portrait;
        }

        public static const HD_TEXTURE_THRESHOLD:int = 1280;
        public static function useHDTextures():Boolean
        {
            return (Math.max(stageWidth, stageHeight) > HD_TEXTURE_THRESHOLD)
        }

        public function GameConfig()
        {
        }
    }
}
