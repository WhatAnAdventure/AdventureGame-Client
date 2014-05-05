/**
 * Created by Chelsea on 4/28/2014.
 */
package com.whatanadventure.adventuregame.embedded
{
    import flash.display.Bitmap;
    import flash.display.Stage;

    public class WebLoadingBG extends AbstractEmbeddedFlashAsset
    {
        [Embed(source="/assets/embed/LoadingBG.jpg")]
        private static const WebLoadingBG:Class;

        public static function getBitmap(flashStage:Stage = null):Bitmap
        {
            return createBitmap(WebLoadingBG, flashStage);
        }

        public function WebLoadingBG()
        {
            super();
        }
    }
}
