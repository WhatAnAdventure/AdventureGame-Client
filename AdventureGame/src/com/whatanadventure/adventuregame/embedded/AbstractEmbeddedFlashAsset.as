/**
 * Created by Chelsea on 4/28/2014.
 */
package com.whatanadventure.adventuregame.embedded
{
    import com.whatanadventure.adventuregame.config.GameConfig;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Stage;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    public class AbstractEmbeddedFlashAsset
    {
        protected static function createBitmapData(bitmapClass:Class, flashStage:Stage = null):BitmapData
        {
            var asset:Bitmap = new bitmapClass();

            var stageWidth:int = flashStage ? flashStage.stageWidth : GameConfig.stageWidth;
            var stageHeight:int = flashStage ? flashStage.stageHeight : GameConfig.stageHeight;

            var scale:Number = Math.max(stageWidth, stageHeight) / asset.width;
            var xOffset:Number = (asset.width * scale - stageWidth) / 2;

            var matrix:Matrix = new Matrix(scale, 0, 0, scale, -xOffset, 0);

            var clone:BitmapData = new BitmapData(stageWidth, stageHeight);

            var rect:Rectangle = new Rectangle(0, 0, stageWidth, stageHeight);
            clone.draw(asset.bitmapData, matrix, null, null, rect, true);

            return clone;
        }

        protected static function createBitmap(bitmapClass:Class, flashStage:Stage = null):Bitmap
        {
            return new Bitmap(createBitmapData(bitmapClass, flashStage));
        }

        public function AbstractEmbeddedFlashAsset()
        {
        }
    }
}
