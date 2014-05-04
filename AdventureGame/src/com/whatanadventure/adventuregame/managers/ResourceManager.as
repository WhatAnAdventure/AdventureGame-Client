/**
 * Created by Chelsea on 5/3/2014.
 */
package com.whatanadventure.adventuregame.managers
{
    import com.whatanadventure.framework.data.fetchers.ProjectFileDataFetcher;
    import com.whatanadventure.framework.managers.BaseResourceManager;

    public class ResourceManager extends BaseResourceManager
    {
        protected var _gameManager:GameManager;

        public function ResourceManager(gameManager:GameManager)
        {
            super();

            _gameManager = gameManager;

            addDataFetchers();
        }

        protected function addDataFetchers():void
        {
            addDataFetcher(new ProjectFileDataFetcher(_gameManager, "/data/PackagedAssetsManifest.json"));
        }
    }
}
