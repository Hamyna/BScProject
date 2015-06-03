using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.DirectoryServices;
using StudentMailer;
using System.Net.Mail;
using System.IO;
using System.Drawing;
using System.Security.Principal;

namespace StudentMailer
{
    public partial class UserAdmin : System.Web.UI.Page
    {
        EmailHelper emailHelper = new EmailHelper();
        ActiveDirectoryHelper activeDirectoryHelper = new ActiveDirectoryHelper(); 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) Groups_dropdownlist.AppendDataBoundItems = true;

            gv_UserInRoles.DataSource = activeDirectoryHelper.GetOperatorUser(Groups_dropdownlist);
            gv_UserInRoles.DataBind();
            int count = activeDirectoryHelper.GetOperatorUser(Groups_dropdownlist).Count; lb_ResultFeedback.Visible = true;
            lb_ResultFeedback.Text = activeDirectoryHelper.GetOperatorUser(Groups_dropdownlist).Count.ToString() + " Operator(s) "; 
        }

        private string GetConnectionString()
        {
            //return System.Configuration.ConfigurationManager.ConnectionStrings["Student_Mailer"].ConnectionString; 
            return System.Configuration.ConfigurationManager.ConnectionStrings["Student_Mailer"].ConnectionString;
        }
      
        public string UserEmail()
        {
            WindowsPrincipal user = (WindowsPrincipal)HttpContext.Current.User;
            string Name = user.Identity.Name.ToUpper();
            Name = Name.Substring(Name.IndexOf("\\") + 1, 8);
            return Name + "@reading.ac.uk";
        }

        public string[] SplitEmails(string emailString)
        { return emailString.Split(';'); }

        protected void OnSelectedIndexChanged_Groups_dropdownlist(object sender, EventArgs e)
        {
            lb_ResultFeedback.Visible = true; 
            if (Convert.ToInt32(Groups_dropdownlist.SelectedValue) == 1)
            {
                gv_UserInRoles.DataSource = activeDirectoryHelper.GetStaffUser(1);
                gv_UserInRoles.DataBind();
                //update feedback 
                int count = activeDirectoryHelper.GetStaffUser(1).Count;
                lb_ResultFeedback.Text = activeDirectoryHelper.GetStaffUser(1).Count.ToString() + " Staff(s) "; 
            }
            if (Convert.ToInt32(Groups_dropdownlist.SelectedValue) == 2)
            {
                gv_UserInRoles.DataSource = activeDirectoryHelper.GetAdminUser(Groups_dropdownlist);
                gv_UserInRoles.DataBind();
                //Update feedb
                int count = activeDirectoryHelper.GetAdminUser(Groups_dropdownlist).Count;
                lb_ResultFeedback.Text = activeDirectoryHelper.GetAdminUser(Groups_dropdownlist).Count.ToString() + " Admin(s) "; 
            }      
            if (Convert.ToInt32(Groups_dropdownlist.SelectedValue) == 3)
            {
                gv_UserInRoles.DataSource = activeDirectoryHelper.GetOperatorUser(Groups_dropdownlist);
                gv_UserInRoles.DataBind();
                //Update feedb
                int count = activeDirectoryHelper.GetOperatorUser(Groups_dropdownlist).Count;
                lb_ResultFeedback.Text = activeDirectoryHelper.GetOperatorUser(Groups_dropdownlist).Count.ToString() + " Operator(s) "; 
            }
            if (Convert.ToInt32(Groups_dropdownlist.SelectedValue) == -1)
            {
                gv_UserInRoles.DataSource = activeDirectoryHelper.GetAllUsers(Groups_dropdownlist);
               gv_UserInRoles.DataBind();
               lb_ResultFeedback.Text = Convert.ToString(activeDirectoryHelper.GetAdminUser(Groups_dropdownlist).Count + activeDirectoryHelper.GetOperatorUser(Groups_dropdownlist).Count + activeDirectoryHelper.GetStaffUser(1).Count) + " Users";
               
            }
        }

        private Attachment attachAFile(FileUpload att)
        {
            FileInfo fileInfo = new FileInfo(att.PostedFile.FileName);
            string filePath = Server.MapPath("UpLoadedCSVFiles") + "\\" + fileInfo.Name;
            att.PostedFile.SaveAs(filePath);
            string fileFullPath = filePath;
            Attachment afile = new Attachment(fileFullPath);
            return afile;

        }

        protected void Btn_Email_Click(object sender, EventArgs e)
        {
            bool isChecked = false;
            string st_email;
            sendButton.Text = "Send";
           
            Tb_FROM.Text = this.UserEmail();
            //loop through each role in gridview 
            foreach (GridViewRow i in gv_UserInRoles.Rows)
            {
                CheckBox cb = (CheckBox)i.FindControl("cb_select"); //inspect the check box.
                if (cb != null && cb.Checked) //if check 
                {
                    isChecked = true;
                }
                else //if not checked 
                {
                    isChecked = false;
                }
                if (isChecked == true)
                {
                    Tb_To.Text = " ";
                    st_email = Convert.ToString(gv_UserInRoles.DataKeys[i.RowIndex].Value); //if check box not selected, ensure it not in the message to text box.
                }
                if (isChecked == false)
                {                
                    st_email = Convert.ToString(gv_UserInRoles.DataKeys[i.RowIndex].Value); //if row check box if checked, get student email. 
                    Tb_To.Text += st_email + "; \r\n"; //add to message textbox. 
                }
            }
        }

        protected void new_attachment1_OnClick(object sender, EventArgs e)
        {
            //make controls visisble 
            //td1.Visible = true;
            //lb_att3.Visible = true;
            fileUpload3.Visible = true;
            ImgBtn_NewAttachment2.Visible = false;
        }

        protected void Button2_OnClick(object sender, EventArgs e)
        {
            //err_lb.Visible = true;
            FileUpload2.Visible = true;
            ImgBtn_NewAttachment1.Visible = true;
            ImgBtn_Attachment.Visible = false;
        }

        protected void Btn_EmailStaff_Click(object sender, EventArgs e)
        {  
            lb_EmailFeedBack.Text = ""; //clear previosu feedback text.
            //execute action when expanding/collaspsing email section 
            emailHelper.OnEmailPanelExpand(gv_UserInRoles, Tb_To, Tb_FROM, Btn_EmailStaff); 

        }

        protected void new_attachment_OnClick(object sender, EventArgs e)
        {
            //make upload controls visible  
            //dynamicUpload.Visible = true;
            //lb_att2.Visible = true;
            fileUpload1.Visible = true;
            ImgBtn_NewAttachment1.Visible = false;
            ImgBtn_NewAttachment2.Visible = true;
        }

        protected void sendButton_OnClick(object sender, EventArgs e)
        {
            sendButton.Text = "Send";
            sendButton.Font.Bold = true;
            try
            {
                lb_EmailFeedBack.Font.Bold = true;
                lb_EmailFeedBack.ForeColor = Color.DarkGreen;
                lb_EmailFeedBack.Text = emailHelper.SendEmail(emailHelper.GetUserEmail(), "denikeyusuf@yahoo.com", Tb_Subject.Text.ToString(), Tb_Body.Text.ToString(), fileUpload1, FileUpload2, fileUpload3);
            }
            catch (Exception ex)
            {

            }
        }

    }
}