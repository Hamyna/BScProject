using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail; 
using System.Text;
using System.IO;
using System.Drawing;
using System.Net.Configuration;
using System.Web.UI.WebControls;
using System.Security.Principal;
using System.Web;

namespace StudentMailer
{
    public partial class Basic_Query : System.Web.UI.Page
    {
        EmailHelper emailHelper = new EmailHelper(); 

        #region Public Method 

 
        #endregion 

        #region Protected Method 

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //AppendDataBounds to all dropdownlist
                module_DropDownList.AppendDataBoundItems = true;
                degree_DropDownList.AppendDataBoundItems = true;
                faculty_dropdownlist.AppendDataBoundItems = true;
                programe_dropdownlist.AppendDataBoundItems = true;
                Tutor_DropDownList.AppendDataBoundItems = true;
                level_DropDownList.AppendDataBoundItems = true;
                year_ddl.AppendDataBoundItems = true; 
            }

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            sendButton.Text = "Send";
            lb_EmailFeedBack.Text = ""; //clear previosu feedback text.
            //execute action when expanding/collaspsing email section 
            emailHelper.OnEmailPanelExpand(Gridview1, Tb_To, Tb_FROM, Button1); 
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
      
        protected void Gridview1_DataBound(object sender, EventArgs e)
        {
            lb_recordsFeedback.Text = "";
            lb_recordsFeedback.Text += Gridview1.Rows.Count.ToString() + " Record(s) Found        ";
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

        #endregion 
    }
}
    