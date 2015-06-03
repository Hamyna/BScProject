using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentMailer
{
    public partial class Help : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string filePath = Server.MapPath("Files") + "\\" + "Help.pdf";
            if (!IsPostBack)
            {
                //get help document 
                byte[] pdfData = System.IO.File.ReadAllBytes(filePath);
                this.HelPdfDocument.CreateDocument("Student Mailer User Guide", pdfData);
            }
        }
    }
}