using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;

using ESRI.ArcGIS.E2API;

namespace StreetViewer
{
    public class CustomTaskUI : TaskUI
    {
        private CustomTaskControl _taskControl = null;
        private MenuDef _mainMenu = null;
        private MenuDef _sendToMenu = null;

        public CustomTaskUI()
        {
            // Perform any initialization required early on.
        }

        #region TaskUI mandatory overrides

        public override string Name
        {
            get
            {
                // The name of the TaskUI should include the Namespace and Name of the class.
                return this.GetType().ToString();
            }
        }

        public override string Title
        {
            get
            {
                // The Title will be shown in the title bar in the task center.
                return "StreetViewer";
            }
        }

        public override ContainerControl GetTaskWindow()
        {
            // Return the item which will be displayed in the task center.
            try
            {
                if (_taskControl == null)
                    _taskControl = new CustomTaskControl(this);
            }
            catch (System.Exception ex)
            {
                // Allowing exceptions back to the application here may corrupt the task display in Explorer.
                // You may wish to implement a method of disabling your task, depending on specific exceptions.
                // An alternative is to return a simple control showing an error message:
                return CreateErrorControl(ex);
            }

            return _taskControl;
        }

        #endregion

        #region TaskUI Optional overrides


        public override string TitleImage
        {
            get { return "StreetViewer"; }
        }

        public override void Startup()
        {
            // Add images to the ImageSet in the application for use by this task.
            ImageSet imgs = this.E2.ImageSet;
            imgs.AddImage("StreetViewer", TaskImageFromName("StreetViewer"));
        }

        public override MenuDef GetMenu(esriE2MenuType menuType, object menuArgs)
        {
            if (menuType == esriE2MenuType.ResultContextMenu)
            {
                // GetMenu for a ResultContextMenu is only called on the TaskUI which created the result
                // in the first place, and can be used to add any additional context menu items to the 
                // standard menu.
                if (_mainMenu == null)
                {
                    // For the main context menu, support one simple item.
                    _mainMenu = new MenuDef();
                }
                return this._mainMenu;
            }
            else if (menuType == esriE2MenuType.ResultSendToMenu)
            {
                // GetMenu for a ResultSentToMenu is called for any result, regardless of which TaskUI 
                // first created the result. Here, the TaskUI should decide if it supports working with
                // the menuArgs passed in.
                // For the send to menu, support all PlaceResults with Point geometries.
                // Checking the category means we do not present the context menu for failed executions, 
                // only for results where we successfully set the Category property.
                ResultInfo resInfo = menuArgs as ResultInfo;
                PlaceResult chosenRes = resInfo.ChosenResult as PlaceResult;
                if ((chosenRes != null) && (chosenRes.Geometry is Point))
                {
                    if (this._sendToMenu == null)
                    {
                        // Create the menu if required.
                        _sendToMenu = new MenuDef();
                        _sendToMenu.AddItem("StreetViewer", "StreetViewer", false, false, 361); //361 is arbitrary could be any number

                    }
                    return this._sendToMenu;
                }
            }
            // For all other cases, do not provide a menu.
            return null;

        }

        public override void DoMenuItem(esriE2MenuType menuType, object menuArgs, int menuItemId)
        {
            // Perform the actual work of the context menu.
            // First, get the result information (not applicable to the Options menu).
            ResultInfo resInfo = menuArgs as ResultInfo;
            // Choose the item action to run.
            switch (menuItemId)
            {
                case (361): // Send To menu item. 361 is arbitrary, could be any number
                    {

                        SendLocationToDialog(resInfo.ChosenResult);
                        break;
                    }
            }
        }

 

        #endregion

        #region Utility Functions

        /// <summary>
        /// Sends the result to the StartLocation TextBox of the TaskUI.
        /// </summary>
        private void SendLocationToDialog(Result result)
        {
            // Utility function to send the Point Geometry of the chosen result to 
            // the StartLocation of the TaskUI dialog.
            PlaceResult res = result as PlaceResult;
            if ((res != null) && (res.Geometry is Point))
            {
                _taskControl.StartLocation = res;
            }
        }

    

        /// <summary>
        /// Returns an image from assembly resources.
        /// </summary>
        /// <param name="name">Name of the resource to create an image from. Should not include 
        ///   the task namespace.</param>
        /// <returns>An image</returns>
        private System.Drawing.Bitmap TaskImageFromName(string name)
        {
            // This utility function simply returns a bitmap from a name by retrieving 
            // an assembly resource.
            try
            {
                string fullName = this.GetType().Namespace + ".Images." + name + ".png";
                System.Drawing.Bitmap image = new System.Drawing.Bitmap(GetType().Assembly.GetManifestResourceStream(fullName));
                image.MakeTransparent(image.GetPixel(1, 1));
                return image;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.ToString());
            }
            return null;
        }

        /// <summary>
        /// Create a simple user control which will report an error.
        /// </summary>
        /// <param name="ex">The exception to report on.</param>
        /// <returns>A UserControl containing a label reporting the error.</returns>
        private ContainerControl CreateErrorControl(Exception ex)
        {
            UserControl usrCtrl = new UserControl();
            usrCtrl.Padding = new Padding(10);

            Label lbl = new Label();
            lbl.Dock = DockStyle.Fill;
            lbl.Text = "This task has an error:" + Environment.NewLine + ex.Message;
            usrCtrl.Controls.Add(lbl);

            return usrCtrl;
        }

        #endregion

    }
}
