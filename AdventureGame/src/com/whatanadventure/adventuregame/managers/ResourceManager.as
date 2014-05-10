/**
 * Created by Chelsea on 5/3/2014.
 */
package com.whatanadventure.adventuregame.managers
{
    import com.whatanadventure.adventuregame.config.GameConfig;
    import com.whatanadventure.framework.data.fetchers.LocalDataFetcher;
    import com.whatanadventure.framework.data.fetchers.ProjectFileDataFetcher;
    import com.whatanadventure.framework.managers.BaseResourceManager;

    public class ResourceManager extends BaseResourceManager
    {
        public function ResourceManager(modelManager:ModelManager)
        {
            super(modelManager);

            addDataFetchers();
        }

        protected function addDataFetchers():void
        {
            switch (GameConfig.getPlatform())
            {
                case GameConfig.PLATFORMS.Mobile:
                case GameConfig.PLATFORMS.Emulator:
                    addDataFetcher(new ProjectFileDataFetcher(this, "/data/ContentDataManifest.json"));
                    break;
                case GameConfig.PLATFORMS.Desktop:
                    addDataFetcher(new LocalDataFetcher(this));
                    break;
            }
        }
    }
}
