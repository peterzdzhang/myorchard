using Orchard.UI.Resources;
using System;

namespace PJS.Bootstrap {
    public class ResourceManifest : IResourceManifestProvider {
        public void BuildManifests(ResourceManifestBuilder builder) {
            var manifest = builder.Add();

            manifest.DefineScript("Bootstrap").SetUrl("bootstrap-3.3.5/js/bootstrap.min.js", "bootstrap-3.3.5/js/bootstrap.js").SetVersion("3.3.4").SetDependencies("jQuery");
            manifest.DefineScript("HoverDropdown").SetUrl("hover-dropdown.js").SetDependencies("Bootstrap");
            manifest.DefineScript("Stapel-Modernizr").SetUrl("stapel/modernizr.custom.63321.js");
            manifest.DefineScript("Stapel").SetUrl("stapel/jquery.stapel.js").SetDependencies("jQuery", "Stapel-Modernizr");
            manifest.DefineScript("prettyPhoto").SetUrl("prettyPhoto/jquery.prettyPhoto.js").SetDependencies("jQuery");
            manifest.DefineScript("Custom").SetUrl("custom.js").SetDependencies("jQuery");

            manifest.DefineStyle("Stapel").SetUrl("stapel/stapel.css");
            manifest.DefineStyle("prettyPhoto").SetUrl("prettyPhoto/prettyPhoto.css");

            //jQuery Grid
            manifest.DefineScript("jqgrid").SetUrl("jquery.jqGrid.min.js", "jquery.jqGrid.js").SetDependencies("jQuery");
            manifest.DefineScript("jqgrid_en").SetUrl("i18n/grid.locale-en.js").SetDependencies("jqGrid");
            manifest.DefineStyle("jqgrid").SetUrl("jqgrid/ui.jqgrid.css");
            manifest.DefineStyle("jqgrid_bootstrap").SetUrl("jqgrid/ui.jqgrid-bootstrap.css").SetDependencies("Bootstrap", "jqgrid");
            manifest.DefineStyle("jqgrid_bootstrap_ui").SetUrl("jqgrid/ui.jqgrid-bootstrap-ui.css").SetDependencies("Bootstrap", "jqgrid");
            manifest.DefineStyle("multiselect").SetUrl("jqgrid/ui.multiselect.css");
        }
    }
}
