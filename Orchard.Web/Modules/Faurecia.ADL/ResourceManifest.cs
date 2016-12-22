using Orchard.UI.Resources;

namespace Faurecia.ADL
{
    public class ResourceManifest : IResourceManifestProvider {
        public void BuildManifests(ResourceManifestBuilder builder) {
            var manifest = builder.Add();
        }
    }
}
