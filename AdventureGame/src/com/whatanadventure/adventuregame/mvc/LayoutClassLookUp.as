/**
 * Created by Chelsea on 5/10/2014.
 */
package com.whatanadventure.adventuregame.mvc
{
    import com.whatanadventure.adventuregame.mvc.layouts.CenterButtonGroupLayout;
    import com.whatanadventure.adventuregame.mvc.layouts.StoryPageLayout;
    import com.whatanadventure.adventuregame.mvc.layouts.layoutDatas.CenterButtonGroupLayoutData;
    import com.whatanadventure.adventuregame.mvc.layouts.layoutDatas.StoryPageLayoutData;

    public class LayoutClassLookUp
    {
        public static const CenterButtonGroup:Object = {
            "layoutData":CenterButtonGroupLayoutData,
            "layout":CenterButtonGroupLayout
        };

        public static const StoryPage:Object = {
            "layoutData":StoryPageLayoutData,
            "layout":StoryPageLayout
        };

        public function LayoutClassLookUp()
        {
        }
    }
}
