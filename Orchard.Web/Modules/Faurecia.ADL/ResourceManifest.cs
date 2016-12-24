using Orchard.UI.Resources;

namespace Faurecia.ADL
{
    public class ResourceManifest : IResourceManifestProvider {
        public void BuildManifests(ResourceManifestBuilder builder) {
            var manifest = builder.Add();

            manifest.DefineScript("Microsoft_jQueryAjax")
                        .SetVersion("3.2.3")
                        .SetUrl("jquery.unobtrusive-ajax.min.js", "jquery.unobtrusive-ajax.js")
                        .SetDependencies("jQuery");

            manifest.DefineScript("jquery_validate").SetVersion("1.8.0.1")
                                                    .SetUrl("jquery.validate.min.js", "jquery.validate.js")
                                                    .SetDependencies("jQuery");

            manifest.DefineScript("Microsoft_jQueryAjax_Validate").SetVersion("3.2.3")
                                    .SetUrl("jquery.validate.unobtrusive.min.js", "jquery.validate.unobtrusive.js")
                                    .SetDependencies("Microsoft_jQueryAjax", "jquery_validate");
            

            manifest.DefineStyle("FaureciaADLStyle").SetUrl("styles/styles.css");
        }
    }
}
