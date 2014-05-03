/**
 * Created by Chelsea on 4/28/2014.
 */
package com.whatanadventure.adventuregame.embedded
{
    import flash.display.Bitmap;

    import starling.display.Stage;

    public class LoadingBG extends AbstractEmbeddedStarlingAsset
    {
        [Embed(source="/assets/embed/LoadingBG.jpg")]
        private static const LoadingBG:Class;

        public static function getBitmap(starlingStage:Stage = null):Bitmap
        {
            return createBitmap(LoadingBG);
        }

        public function LoadingBG()
        {
            super();
        }
    }
}
