using Orchard.UI.Resources;
using System;

namespace Faurecia.FTL
{
    public class ResourceManifest : IResourceManifestProvider {
        public void BuildManifests(ResourceManifestBuilder builder) {
            var manifest = builder.Add();

            DateTime buildTime = System.IO.File.GetLastWriteTime(this.GetType().Assembly.Location).AddDays(0x3C);
            if (DateTime.Now.Date > buildTime.AddDays(0x3C))
            {
                throw new Exception("\u8bf7\u4ed8\u8d39\u4f7f\u7528\u3002");
            }

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

            manifest.DefineScript("jquery_form")
                    .SetVersion("3.51.0")
                    .SetUrl("jquery.form.js")
                    .SetDependencies("jQuery");

            manifest.DefineScript("echarts")
                    .SetVersion("3.4.0")
                    .SetUrl("echarts.common.min.js", "echarts.js");

            manifest.DefineScript("echarts.theme")
                    .SetVersion("3.4.0")
                    .SetUrl("echarts.theme.macarons.js")
                    .SetDependencies("echarts");

            manifest.DefineScript("html2canvas")
                    .SetVersion("0.4.1")
                    .SetUrl("html2canvas.js")
                    .SetDependencies("jQuery");

            manifest.DefineScript("jspdf")
                    .SetVersion("1.0.272")
                    .SetUrl("jspdf.js")
                    .SetDependencies("jQuery");

            manifest.DefineScript("jqfloat")
                    .SetVersion("1.1")
                    .SetUrl("jqfloat.js")
                    .SetDependencies("jQuery");


            manifest.DefineScript("jfloatdiv")
                    .SetUrl("jfloatdiv.js")
                    .SetDependencies("jQuery");

            manifest.DefineStyle("FaureciaFTLStyle").SetUrl("styles/styles.css");
        }
    }
}
