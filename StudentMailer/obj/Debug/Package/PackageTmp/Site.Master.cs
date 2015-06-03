using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;  

namespace StudentMailer
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        EmailHelper emailHelper = new EmailHelper(); 
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = "You are Logged in as " + emailHelper.GetUserName(); 
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Clear();
            string filePath = "~/UploadedCSVFiles/Help.pdf";
            Response.ContentType = "application/pdf";
            Response.WriteFile(filePath);
            Response.End();
        }

        protected void LBtn_LoggOff_Click(object sender, EventArgs e)
        { 
            FormsAuthentication.SignOut();  
            Response.Redirect("LogOut.aspx");
        } 
    }
}
