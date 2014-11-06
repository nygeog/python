using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;
using ESRI.ArcGIS.E2API;
using System.Net;
using System.Web;
using System.IO;
using System.Xml;
using System.Xml.XPath;

namespace StreetViewer
{
    public class CustomTask : Task
    {
        public override void Execute(TaskContext taskContext)
        {
            ParameterSet parameters = taskContext.GetParameters();
            XmlDocument _doc = new XmlDocument();
            //string street1 = "";
            //string street2 = "";

            try
            {
                Point location = parameters.GetParameter("Geometry") as Point;
                string coords = parameters.GetParameter("COORDS") as string;
                //string UrlString = "";

                //below commented out for UC
                ////use GeoNames.org to find the nearest intersection to provide a meaningful title for the result and the popup
                //UrlString = "http://ws.geonames.org/findNearestIntersection?lat=" + location.Y.ToString() + "&lng=" + location.X.ToString();
                //_doc.Load(UrlString);
                //XPathNavigator nav = _doc.CreateNavigator();
                //XPathNodeIterator itr = nav.Select("/geonames/intersection");
                //while (itr.MoveNext())
                //{
                //    XPathNodeIterator nodeItrChildren = itr.Current.SelectChildren(XPathNodeType.Element);

                //    XPathNavigator currNode = nodeItrChildren.Current;
                //    street1 = currNode.SelectSingleNode("street1").InnerXml;
                //    street2 = currNode.SelectSingleNode("street2").InnerXml;
                //}
                //above commented out for UC

                // Set up the appearance of the result.
                //PlaceResult newResult = new PlaceResult("StreetViewer", "StreetView at " + street1 +  "&"  + street2,
                PlaceResult newResult = new PlaceResult("StreetViewer", "StreetView",
                    location, "Yellow Pushpin");
                newResult.SubType = "Places";
                newResult.Category = "StreetViewer Results";
                //next line is server that contains the HTML page (getPano.html) that creates the StreetView
                //newResult.Description = "http://www.yoursite.com/folder/getPano.html?lat=" + location.Y.ToString() + "&long=" + location.X.ToString();
                newResult.Description = "http://www.gisconsultancy.com/stview/getPano.html?lat=" + location.Y.ToString() + "&long=" + location.X.ToString();
                //newResult.Title = "StreetView at " + street1 + " + " + street2;
                newResult.Title = "StreetView";
                taskContext.UpdateResult(newResult);

            }
            catch
            {
                // Could investigate the exception thrown here.
                // In this case, do not create a Result, just set the status and message on the TaskContext and return.
                taskContext.SetStatusMessage(esriE2TaskStatus.CompletedNoValue, "StreetViewer did not find that location.");
                taskContext.ExitStatus = esriE2TaskExitStatus.CompletedNoValue;
            }
        }
    }
}
