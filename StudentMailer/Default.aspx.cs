using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;

namespace StudentMailer
{
    public partial class _Default : System.Web.UI.Page
    {
        EmailHelper emailHelper = new EmailHelper(); 
        protected void Page_Load(object sender, EventArgs e)
        { 
            string Name = emailHelper.GetUserName(); 
            Label1.Text = "Hello " + Name.ToUpper() + ", Welcome to Student Mailer Homepage"; 
        }
    }
}   
