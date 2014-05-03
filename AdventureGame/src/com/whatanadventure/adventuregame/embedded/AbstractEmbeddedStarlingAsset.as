/**
 * Created by Chelsea on 4/28/2014.
 */
package com.whatanadventure.adventuregame.embedded
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    import starling.core.Starling;
    import starling.display.Stage;

    public class AbstractEmbeddedStarlingAsset
    {
        protected static function createBitmapData(bitmapClass:Class, starlingStage:Stage = null):BitmapData
        {
            var asset:Bitmap = new bitmapClass();

            var stageWidth:int = starlingStage ? starlingStage.stageWidth : Starling.current.stage.stageWidth;
            var stageHeight:int = starlingStage ? starlingStage.stageHeight : Starling.current.stage.stageHeight;

            var scale:Number = Math.max(stageWidth, stageHeight) / asset.width;
            var xOffset:Number = (asset.width * scale - stageWidth) / 2;

            var matrix:Matrix = new Matrix(scale, 0, 0, scale, -xOffset, 0);

            var clone:BitmapData = new BitmapData(stageWidth, stageHeight);

            var rect:Rectangle = new Rectangle(0, 0, stageWidth, stageHeight);
            clone.draw(asset.bitmapData, matrix, null, null, rect, true);

            return clone;
        }

        protected static function createBitmap(bitmapClass:Class, starlingStage:Stage = null):Bitmap
        {
            return new Bitmap(createBitmapData(bitmapClass, starlingStage));
        }

        public function AbstractEmbeddedStarlingAsset()
        {
        }
    }
}
