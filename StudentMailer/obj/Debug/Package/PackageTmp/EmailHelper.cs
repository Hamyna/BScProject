using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Principal;
using System.Net.Mail;
using System.IO;
using System.Web.UI.WebControls; 

namespace StudentMailer
{
    public class EmailHelper : EventArgs
    {
        /***
         * Method derives useremail from username method
         ***/
        public string GetUserEmail()
        {
            return this.GetUserName()+"@reading.ac.uk";

        }

        /***
         * Method derives user name fromo WindowsPrinciple user
         ***/
        public string GetUserName()
        {
            WindowsPrincipal user = (WindowsPrincipal)HttpContext.Current.User;
            string Name = user.Identity.Name.ToUpper();
            Name = Name.Substring(Name.IndexOf("\\") + 1);
            return Name; 
        }

        /*** 
           Convert fileUpload to Attachment 
      ***/ 
        public Attachment AttachFile(FileUpload att)
        { 
            string fileName = Path.GetFileName(att.PostedFile.FileName); 
            Attachment afile = new Attachment(att.FileContent, fileName);
            return afile;  
        }

        /*** 
         *Get all selected student email in gridview 
        ***/ 
        public string GetSelectStudentEmail(GridView gridview)
        {
            string emailList = string.Empty;
            string email = string.Empty;
            foreach (GridViewRow i in gridview.Rows)
            {
                CheckBox cb = (CheckBox)i.FindControl("cb_select"); //inspect the check box. 
                try
                {
                    if (cb != null && cb.Checked == true) //if email checked by user, add to email section 
                    {
                        email = Convert.ToString(gridview.DataKeys[i.RowIndex].Value); //if row check box if checked, get student email. 
                        emailList += email + "; "; //add to selected student to textbox.   
                    }
                    else //if not checked 
                    { }
                }
                catch (Exception ex)
                {
                    throw new InvalidDataException("Error Occured When Deriving Student Email");
                }
            }
            return emailList;
        }

        /***
         * 
         **/
        public string SendEmail(string ToEmailAddress,string CCEmailAddress,string EmailSubject, string EmailBody,FileUpload A1, FileUpload A2,FileUpload A3)
        {
            string emailFeedback = string.Empty; 
            MailMessage myMessage = new MailMessage();
            try
            {
                //check email paramaters are not null 
                if (ToEmailAddress == string.Empty || ToEmailAddress == " ") emailFeedback = "No Recipient Found, Select Recipient To Proceed";
                else myMessage.To.Add(new MailAddress(ToEmailAddress, "Students"));
                if (CCEmailAddress == string.Empty || CCEmailAddress == " ") emailFeedback = "No CC EmailAddress"; 
                else myMessage.CC.Add(new MailAddress(CCEmailAddress, "Me")); //Add CC Email address 
                if (EmailSubject == string.Empty || EmailSubject == " ") emailFeedback = "No Email Address Found, Enter Email Subject To Proceed";
                else myMessage.Subject = EmailSubject;
                if (EmailBody == string.Empty || EmailBody == " ") emailFeedback = "No Email Body, Enter A Message to Send";
                else myMessage.Body = EmailBody;
                if (A1.HasFile == true) myMessage.Attachments.Add(this.AttachFile(A1));
                if (A2.HasFile == true) myMessage.Attachments.Add(this.AttachFile(A2));
                if (A2.HasFile == true) myMessage.Attachments.Add(this.AttachFile(A2));
                SmtpClient smtp = new SmtpClient();
                smtp.Send(myMessage);
                emailFeedback = "Email Successfully Sent"; 
            }
            catch(Exception ex) { emailFeedback = "Sending Email Unsuccessfull"; }
            //check all to send email 


            return emailFeedback; 
        }

        /*** 
         * Set if action to run on expanding email panel 
         **/ 
        public void OnEmailPanelExpand(GridView gridview, TextBox ToEmailTextBox, TextBox FromEmailTextBox, Button ExpandableButton)
        {
            //set user email by default
            FromEmailTextBox.Text = this.GetUserEmail(); 
            //Copy student email into TOTestBox 
            ToEmailTextBox.Text = this.GetSelectStudentEmail(gridview);
            if (ExpandableButton.Text == "Collapse Email Section")
            {
                ExpandableButton.Text = "Email Student";
            }
            else
            {
                ExpandableButton.Text = "Collapse Email Section";
            } 
        }
    }
}
