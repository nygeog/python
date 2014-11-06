using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

// Version information for an assembly consists of the following four values: 
//  <Major Version>.<Minor Version>.<Build Number>.<Revision> 
// You can specify all the values or you can default the Revision and Build Numbers by using the 
// '*' character, e.g. 1.0.0.*. It is recommended that you manually increment version numbers of 
// your custom task, because ArcGIS Explorer will attempt to download the specific version of a 
// custom task dll which is indicated in the .tsk file.
// If you wish to deploy a new version of your task simultaneously to an older version, you should
// rename your task assembly and deploy as a new task. See the ArcGIS Explorer SDK helpfiles for 
// details of assembly naming conventions, versioning, and deployment.
[assembly: AssemblyVersion("1.0.500.0")]
[assembly: AssemblyFileVersion("1.0.500.0")]

// General Information about an assembly is controlled through the following set of attributes.
// Change these attribute values to modify the information associated with an assembly.
[assembly: AssemblyTitle("StreetViewer")]
[assembly: AssemblyDescription("StreetViewer Custom ArcGIS Explorer Task")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("")]
[assembly: AssemblyProduct("StreetViewer")]
[assembly: AssemblyCopyright("")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]

// You do not need to expose ArcGIS Explorer tasks to COM. The Compiler at VS2005 will default 
// the ComVisible attribute of a new assembly to False. However, unless you retain this attribute, 
// then it may be added incorrectly if you view the Project Properties Assembly Information 
// dialog.
[assembly: ComVisibleAttribute(false)]
