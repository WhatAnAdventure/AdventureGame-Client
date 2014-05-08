/**
 * Created by Chelsea on 5/7/2014.
 */
package com.whatanadventure.adventuregame.Utils
{
    public class StringUtils
    {
        public function StringUtils()
        {
        }

        public static function capitalize(s:String):String
        {
            return (s.charAt(0).toUpperCase() + s.substr(1, s.length));
        }
    }
}
