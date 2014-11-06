using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using System.Xml.XPath;
using System.IO;
using ESRI.ArcGIS.E2API;

namespace StreetViewer
{
    public partial class CustomTaskControl : UserControl
    {
        private const string _coordFormat = "#,##0.0000";
        private CustomTaskUI _taskUI = null;
        private const string _dataFormat = "ESRI E2 Result";
        private ESRI.ArcGIS.E2API.Point location = null;

        public CustomTaskControl(CustomTaskUI taskUI)
        {
            _taskUI = taskUI;

            InitializeComponent();
        }

        internal PlaceResult StartLocation
        {
            set
            {
                PlaceResult result = value;
                txtLocation.Tag = result.Geometry;
                txtLocation.Text = FormatPointCoords(result.Geometry as ESRI.ArcGIS.E2API.Point);
                location = result.Geometry as ESRI.ArcGIS.E2API.Point;
                LoadStreetViewQuery();
            }
        }

        private void btnGetLocation_Click(object sender, EventArgs e)
        {
            // Convert the click on the map into a point Geometry.
            try
            {
                location = _taskUI.E2.CurrentView.TrackPoint();
                txtLocation.Text = FormatPointCoords(location);
                txtLocation.Tag = location;
                LoadStreetViewQuery();

            }
            catch (Exception error)
            {
                System.Diagnostics.Debug.WriteLine(error.ToString());
            }
        }

        private string FormatPointCoords(ESRI.ArcGIS.E2API.Point location)
        {
            if (location != null)
            {
                return location.Y.ToString(_coordFormat) + ", " + location.X.ToString(_coordFormat);
            }
            return "";
        }

        private void btnFind_Click(object sender, EventArgs e)
        {

            DoFind();
        }

        private bool LoadStreetViewQuery()
        {
          try {
              string url = "http://your_ site.com/folder_name/panoAvailable.html?lat=" + location.Y.ToString() + "&long=" + location.X.ToString();
          webBrowser1.Navigate(url);
            return true;
          }
          catch
          {
            return false;
          }
        }

        private bool CheckQueryResponse()
        {
          HtmlDocument doc = webBrowser1.Document;
          string response = doc.InvokeScript("getResult").ToString();
          if ( response == "True")
          {
              return true;
          }
         else
          {
            return false;
          }

        }

        private void DoFind()
        {

            if (txtLocation.Tag != null)
            {

              bool validPoint = CheckQueryResponse();
              if (!validPoint)
              {
                _taskUI.E2.MessageBox("No Image found at this location, please select another location.", "StreetViewer", esriE2MessageBoxType.Information);
                location = _taskUI.E2.CurrentView.TrackPoint();
                txtLocation.Text = FormatPointCoords(location);
                txtLocation.Tag = location;
                //this.btnFind.Enabled = (this.txtLocation.Text.Length > 0);
                LoadStreetViewQuery();
                return;
              }

                TaskContext newTaskContext = new ESRI.ArcGIS.E2API.TaskContext();
                newTaskContext.TaskName = typeof(StreetViewer.CustomTask).FullName;
                newTaskContext.TaskUIName = _taskUI.Name;

                ESRI.ArcGIS.E2API.ParameterSet parameters = new ESRI.ArcGIS.E2API.ParameterSet();
                parameters.SetParameter("Geometry", txtLocation.Tag);
                parameters.SetParameter("COORDS", txtLocation.Text);
                newTaskContext.UpdateParameters(parameters);

                _taskUI.E2.ProcessTask(newTaskContext, esriE2TaskExecution.Show);

                txtLocation.Text = "";
                txtLocation.Tag = null;
                txtLocation.Refresh();
            }
        }

        private void txtLocation_TextChanged(object sender, EventArgs e)
        {
            this.btnFind.Enabled = (this.txtLocation.Text.Length > 0);
        }

        private void txtLocation_DragEnter(object sender, DragEventArgs e)
        {
            // The DragEnter event handler has two tasks: 
            // - to verify that the data being dragged is an acceptable type 
            // - to ensure the requested action (Effect) is acceptable
            e.Effect = DragDropEffects.None;

            // Using the IDataObject interface, check if the data of the drag operation, from the DragEventArgs
            // is supported.
            IDataObject data = e.Data;
            bool foundData = data.GetDataPresent(_dataFormat);
            if (foundData)
            {
                // Set the appropriate Effect for the drag drop operation.
                // This will decide the mouse icon while over the control.
                e.Effect = DragDropEffects.Copy;
            }

        }
        private void txtLocation_DragDrop(object sender, DragEventArgs e)
        {
            // Using the IDataObject interface, check  the data type again and then retrieve the 
            // data of the drag operation from the DragEventArgs
            IDataObject data = e.Data;
            bool foundData = data.GetDataPresent(_dataFormat);
            if (foundData)
            {
                PlaceResult res = GetResultFromDragData(data);

                AddResultToTextBox(res);
                location = res.Geometry as ESRI.ArcGIS.E2API.Point; //****set location so it’s not null
                LoadStreetViewQuery();//****call method

            }
        }
        private PlaceResult GetResultFromDragData(IDataObject dragData)
        {
            if (dragData == null) return null;

            // Get the dragged data
            object o = dragData.GetData(_dataFormat);

            //convert dragged data into xml string
            string xml = XmlHelper.XmlFromMemory((MemoryStream)o);

            //create Result from xml string
            return XmlHelper.ObjectFromXml(xml) as PlaceResult;
        }

        private void AddResultToTextBox(PlaceResult res)
        {
            //Add result into TextBox
            this.txtLocation.Text = res.Title;
            this.txtLocation.Tag = res.Geometry;

        }

        private void SetTag(string plc)
        {
            plc = plc.Replace("(historical)", "");
            string Urlstring4;
            Urlstring4 = "http://ws.geonames.org/search?q=" + plc;
            XmlDocument _doc4 = new XmlDocument();
            _doc4.Load(Urlstring4);
            XPathNavigator nav4 = _doc4.CreateNavigator();

            XPathNavigator node4 = nav4.SelectSingleNode("/geonames/geoname/lat");
            String nodeLat = node4.InnerXml;
            node4 = nav4.SelectSingleNode("/geonames/geoname/lng");
            string nodeLng = node4.InnerXml;
            ESRI.ArcGIS.E2API.Point location = new ESRI.ArcGIS.E2API.Point(Convert.ToDouble(nodeLng), Convert.ToDouble(nodeLat));
            txtLocation.Tag = location;

        }

    }
}
