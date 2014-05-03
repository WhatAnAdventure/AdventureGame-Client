/**
 * Created by Chelsea on 4/28/2014.
 */
package com.whatanadventure.adventuregame.embedded
{
    import flash.display.Bitmap;
    import flash.display.Stage;

    public class SplashScreen extends AbstractEmbeddedFlashAsset
    {
        [Embed(source="/assets/embed/SplashScreen.jpg")]
        private static const SplashScreen:Class;

        public static function getBitmap(flashStage:Stage = null):Bitmap
        {
            return createBitmap(SplashScreen, flashStage);
        }

        public function SplashScreen()
        {
            super();
        }
    }
}
