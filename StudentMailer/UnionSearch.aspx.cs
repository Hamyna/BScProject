using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net.Mail;
using System.Security.Principal;
using System.Drawing;
using System.Data.SqlClient;
using System.Data;

namespace StudentMailer
{
    public partial class UnionSearch : System.Web.UI.Page
    {
        EmailHelper emailHelper = new EmailHelper(); 

        #region Protected Methods
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                UserName.Text = emailHelper.GetUserName(); 
            }

        }

        protected void Btn_Email_Click(object sender, EventArgs e)
        {
            try
            {
                sendButton.Text = "Send";
                lb_EmailFeedBack.Text = ""; //clear previosu feedback text.
                //execute action when expanding/collaspsing email section 
                emailHelper.OnEmailPanelExpand(gv_StudentData, Tb_To, Tb_FROM, Btn_Email); 
            }
            catch (Exception ex)
            {
                lb_EmailFeedBack.Text = "Error Encountered In Expanding Panel"; 
            }
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
                lb_EmailFeedBack.Text = "Error Encountered Sending Email"; 
            } 
        }

        protected void new_Attachment_OnClick(object sender, EventArgs e)
        {
            //err_lb.Visible = true;
            FileUpload2.Visible = true;
            ImgBtn_NewAttachment1.Visible = true;
            ImgBtn_Attachment.Visible = false;
        }

        protected void new_attachment1_OnClick(object sender, EventArgs e)
        {
            //make controls visisble 
            //td1.Visible = true;
            //lb_att3.Visible = true;
            fileUpload3.Visible = true;
            ImgBtn_NewAttachment2.Visible = false;
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

        protected void Bt_Select_Click(object sender, EventArgs e)
        {
            if (Bt_Select.Text == "Select Result Field")
            {
                Bt_Select.Text = "Collapse Result Field Section";
            }
            else
            {
                Bt_Select.Text = "Select Result Field";
            }
        }

        protected void Btn_UnionSearch_Click(object sender, EventArgs e)
        {
            string subUnionQuery = string.Empty; string UnionQuery = string.Empty; lb_ResultFeedback.Text = ""; lb_Error.Text = ""; 
            if (cb_SavedSearchList.SelectedIndex != -1) //if an item in check box list as been selected 
            {
                if (cb_SavedSearchList.SelectedIndex >= 0) //if more than one item in the check box list selected 
                {
                    try
                    {
                        int check = 0;
                        //Loop through Check Box List and Build Selected Save Search for each save search 
                        foreach (ListItem lt in cb_SavedSearchList.Items)
                        {
                            //get where clause from daabase 
                            string queryString = string.Empty;
                            SqlProvider sqlProvider = new SqlProvider(); 
                            string query = "EXEC dbo.Proc_GetWhereClauseBySearchID @SearchID = " + lt.Value + ", @UserName = '" + UserName.Text.Trim() + "'";
                            queryString = Convert.ToString(sqlProvider.ExecuteSqlScalarCommand(query));
                            if (lt.Selected && check == 0) { subUnionQuery += "   " + this.BuildAdvanceQuery() + queryString; check++; }
                            else if (lt.Selected && check > 0) subUnionQuery += "  UNION   " + this.BuildAdvanceQuery() + queryString; 
                        }
                        //Build Union Query String
                        UnionQuery = this.BuildUnionSQLQuery(subUnionQuery);
                        //Populate gridview 
                        gv_StudentData.Height = 310;
                        gv_Result.Height = 310;
                        try { this.PopulateGridView(gv_StudentData, lb_Error, UnionQuery); }
                        catch (Exception ex) { lb_Error.Text = "Invalid Query String"; }
                        if (gv_StudentData.Rows.Count > 0)
                        {
                            lb_ResultFeedback.Visible = true;
                            lb_ResultFeedback.Text = gv_StudentData.Rows.Count.ToString() + " Record(s) Found";
                        }
                        else
                        {
                            lb_ResultFeedback.Visible = true;
                            lb_ResultFeedback.Text = "No Record(s) Found";
                        }

                    }
                    catch (Exception ex)
                    {
                        lb_Error.Text = "Opppsss!!! Something Went Wrong";
                    }
                }
                else lb_Error.Text = "To View A Union Search Result, Select Two Or More Search";
            }
            else
            {
                lb_Error.Text = "No Search Selected";
                lb_ResultFeedback.Text = "";
                gv_StudentData.DataSource = null; gv_StudentData.DataBind();
            }

            //Build Union Search 


        }

        #endregion 

        #region Public Methods  

        public string[] GetSavedQueriesFiles()
        {
            string Path = Server.MapPath("QueryFiles") + "\\";
            string[] files;
            if (Directory.Exists(Path))
            {
                files = Directory.GetFiles(Path, @"*.txt", SearchOption.TopDirectoryOnly);

                return files;
            }
            else
            {
                //directory does not exist.
            }

            return null;
        }

        public string BuildAdvanceQuery()
        {
            string queryString;

            //build string  
                        
            queryString =  "  SELECT DISTINCT dbo.StudentData.StudentName, dbo.StudentData.StudentNumber, "
                         + "  dbo.StudentData.UniEmail, dbo.DegreeLookUp.DegreeCode, dbo.FacultyLookUp.FacultyName, "
                         + "  dbo.LevelLookUp.LevelName, dbo.ModuleLookUp.ModuleName,  dbo.CourseLookUp.CourseName,"
                         + "  dbo.TutorLookUp.TutorName, dbo.YearLookUp.YearName "
                         + "  FROM dbo.StudentData "
                         + "  JOIN dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID "
                         + "  INNER JOIN dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID "
                         + "  JOIN dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID "
                         + "  JOIN dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID "
                         + "  JOIN dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID " 
                         + "  JOIN dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID "
                         + "  JOIN dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID  "
                         + "  JOIN dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID "
                         + " WHERE  ";
            return queryString;
        }

        public string UserEmail()
        {
            WindowsPrincipal user = (WindowsPrincipal)HttpContext.Current.User;
            string Name = user.Identity.Name.ToUpper();
           // Name = Name.Substring(Name.IndexOf("\\") + 1, 8);
            return Name + "@reading.ac.uk";
        }

        public string BuildUnionSQLQuery(string UnionSubQuery)
        {
            string queryString;
            string Parameters = "";

            //get selected paremeters
            if (cb_StudentName.Checked == true) { Parameters += " A.StudentName As Name "; }
            if (cb_UniversityEmail.Checked == true || cb_UniversityEmail.Checked == false) { Parameters += ", A.UniEmail As Email "; }
            if (cb_StudentNumber.Checked == true) { Parameters += ", A.StudentNumber As 'Student Number' "; }
            if (cb_Course.Checked == true) { Parameters += ", A.CourseName As Course "; }
            if (cb_Degree.Checked == true) { Parameters += ", A.DegreeCode As Degree  "; }
            if (cb_Faculty.Checked == true) { Parameters += ", A.FacultyName As Faculty "; }
            if (cb_Level.Checked == true) { Parameters += ", A.LevelName As Level "; }
            if (cb_Module.Checked == true) { Parameters += ", A.ModuleName As Module "; }
            if (cb_Programme.Checked == true) { Parameters += ", A.CourseName As Course "; }
            if (cb_Tutor.Checked == true) { Parameters += ", A.TutorName As Tutor "; }
            if (cb_AcademicYear.Checked == true) { Parameters += ",  A.YearName As 'Academic Year' "; }
            //build string  
            queryString = " SELECT DISTINCT " + Parameters + " FROM  ( " + "   " + UnionSubQuery + " )A";
            return queryString;
        }

        public void PopulateGridView(GridView gridview, Label errorFeedback, string sqlQuery)
        {
            try
            {
                string connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings["Student_Mailer"].ConnectionString; //get sql connection 
                SqlConnection sqlConnection = new SqlConnection(connectionstring); //get sql connection object
                sqlConnection.Open(); //open sql connection
                SqlCommand command = sqlConnection.CreateCommand(); //create sql command
                command.CommandType = CommandType.Text;
                command.CommandText = sqlQuery;
                SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                dataAdapter.SelectCommand = command;
                DataSet ds = new DataSet();
                dataAdapter.Fill(ds, "StudentData");
                command.ExecuteNonQuery();
                gridview.Height = 280; //enlarge gridview  
                gridview.DataSource = ds;
                gridview.DataBind();
                //ds.Container.Components.Count;
                sqlConnection.Close();
            }
            catch (Exception ex)
            {
                errorFeedback.Visible = true;
                errorFeedback.Text = "Invalid Query String";
            }
        }

    
        #endregion 

        #region Private Methods
        private Attachment attachAFile(FileUpload att)
        {
            FileInfo fileInfo = new FileInfo(att.PostedFile.FileName);
            string filePath = Server.MapPath("UpLoadedCSVFiles") + "\\" + fileInfo.Name;
            att.PostedFile.SaveAs(filePath);
            string fileFullPath = filePath;
            Attachment afile = new Attachment(fileFullPath);
            return afile;

        }

        #endregion

    

       
    }
}