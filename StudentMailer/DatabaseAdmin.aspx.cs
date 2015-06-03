using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;
using System.IO;
using System.Data.OleDb;
using System.Data;
using System.Drawing;

namespace StudentMailer
{
    public partial class DatabaseAdmin : System.Web.UI.Page
    { 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               //Append databounds to dropdownlist 
                module_DropDownList.AppendDataBoundItems = true;
                degree_DropDownList.AppendDataBoundItems = true;
                faculty_dropdownlist.AppendDataBoundItems = true;
                programe_dropdownlist.AppendDataBoundItems = true;
                Tutor_DropDownList.AppendDataBoundItems = true;
                level_DropDownList.AppendDataBoundItems = true;
                year_ddl.AppendDataBoundItems = true;
                faculty_dropdownlist.AppendDataBoundItems = true; 
                //get gridview default value 
                string fileLoc = Server.MapPath("Files") + "\\"; //get file directory on web server  
                //BasicSearchDefaultValue.txt 
                string filePath = fileLoc + "BasicSearchDefaultValue.txt";
                if (File.Exists(filePath))
                {
                    string queryString = System.IO.File.ReadAllText(filePath);
                    queryString = queryString.Trim().Replace("\r\n", "");
                    year_ddl.SelectedValue = queryString.Trim();
                }
            }
            if (IsPostBack)
            { 
                ddl_fileType.AppendDataBoundItems = true;
            }
        }

        public string GetConnectionString()
        {
            //return System.Configuration.ConfigurationManager.ConnectionStrings["Student_Mailer"].ConnectionString; 
            return System.Configuration.ConfigurationManager.ConnectionStrings["Student_Mailer"].ConnectionString;
        }

        /// <summary>
        /// Method populate gridview datasource
        /// </summary>
        public void PopulateGridView()
        {
                //update gridview datasource 
                using (SqlConnection sqlConn = new SqlConnection(this.GetConnectionString()))
                {
                    sqlConn.Open();
                    using (SqlCommand sqlCmd = new SqlCommand("Proc_BasicQuery", sqlConn))
                    {
                        DataSet dt = new DataSet();
                        sqlCmd.CommandType = CommandType.StoredProcedure;
                        sqlCmd.Parameters.Add(new SqlParameter("@DegreeLevelID", Convert.ToInt32(level_DropDownList.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@DegreeID", Convert.ToInt32(degree_DropDownList.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@TutorID", Convert.ToInt32(Tutor_DropDownList.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@CourseID", Convert.ToInt32(programe_dropdownlist.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@FacultyID", Convert.ToInt32(faculty_dropdownlist.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@YearID", Convert.ToInt32(year_ddl.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@ModuleID", Convert.ToInt32("-1")));
                        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
                        da.Fill(dt);
                        sqlConn.Close();
                        Gridview1.DataSource = null; 
                        Gridview1.DataSource = dt; 
                        Gridview1.DataSourceID = String.Empty;
                        Gridview1.DataBind();
                    }

                }
        }

        protected void LoadDatabase_Click(object sender, EventArgs e)
        {
            lblMsg.ForeColor = Color.Black;
            lblMsg.Text = "Upload A CSV File";
            string fileType = ddl_fileType.SelectedValue;
            if (fileType == "1")
            {
                if (fu_UploadFile.HasFile)
                {
                    FileInfo fileInfo = new FileInfo(fu_UploadFile.PostedFile.FileName);
                    if (fileInfo.Name.Contains(".csv"))
                    {
                        lblMsg.ForeColor = Color.Black; //reset label color
                        string fileName = fileInfo.Name.Replace(".csv", "").ToString();
                        string csvFilePath = Server.MapPath("Files") + "\\" + fileInfo.Name;
                        //save the csv file on the server in 'UpLoadedCSVFiles' 
                        //fu_UploadFile.SaveAs(csvFilePath);
                        SqlProvider sqlProvider = new SqlProvider();
                        sqlProvider.LoadClassListFile(csvFilePath);
                        lblMsg.ForeColor = Color.Black;
                        lblMsg.Text = "CSV File Uploaded to Database";
                    }
                    else
                    {
                        //alert user that file is not a csv file
                        lblMsg.ForeColor = Color.Red;
                        lblMsg.Text = "Uploaded file is not CSV file";
                    }
                }
                else
                {
                    //alert user no file found
                    lblMsg.ForeColor = Color.Red;
                    lblMsg.Text = "No File Found, Try To Re-Upload";
                }
            }
            if (fileType == "2")
            {
                if (fu_UploadFile.HasFile)
                {
                    FileInfo fileInfo = new FileInfo(fu_UploadFile.PostedFile.FileName);
                    if (fileInfo.Name.Contains(".csv"))
                    {
                        lblMsg.ForeColor = Color.Black; //reset label color
                        string fileName = fileInfo.Name.Replace(".csv", "").ToString();
                        string csvFilePath = Server.MapPath("Files") + "\\" + fileInfo.Name;
                        //save the csv file on the server in 'MyCSVFolder' 
                        //fu_UploadFile.SaveAs(csvFilePath);
                        SqlProvider sqlProvider = new SqlProvider();
                        sqlProvider.LoadSESFile(csvFilePath);
                        lblMsg.ForeColor = Color.Black;
                        lblMsg.Text = "CSV File Uploaded to Database";

                    }
                    else
                    {
                        //alert user that file is not a csv file
                        lblMsg.ForeColor = Color.Red;
                        lblMsg.Text = "Uploaded file is not CSV file";
                    }
                }
                else
                {
                    //alert user no file found
                    lblMsg.ForeColor = Color.Red;
                    lblMsg.Text = "No File Found, Try To Re-Upload";
                }
            }
        }

        protected void ch_ViewData_CheckedChanged(object sender, EventArgs e)
        {
            if (ch_ViewData.Checked == true)
            {
                gridPanel.Visible = true;
                //UploadFileName = fu_UploadFile.PostedFile.FileName;  
                lblMsg.ForeColor = Color.Black;
                lblMsg.Text = "Upload A CSV File";
                string fileType = ddl_fileType.SelectedValue;
                if (fileType == "1")
                {
                    if (fu_UploadFile.HasFile)
                    {
                        FileInfo fileInfo = new FileInfo(fu_UploadFile.PostedFile.FileName);
                        if (fileInfo.Name.Contains(".csv"))
                        {
                            lblMsg.ForeColor = Color.Black; //reset label color
                            string fileName = fileInfo.Name.Replace(".csv", "").ToString();
                            string csvFilePath = Server.MapPath("Files") + "\\" + fileInfo.Name;
                            //save the csv file on the server in 'MyCSVFolder' 
                            //fu_UploadFile.SaveAs(csvFilePath);
                            //get the location of the csv file 

                            CSVReaderProvider csvReader = new CSVReaderProvider();
                            try
                            {
                                gv_StudentData.DataSource = csvReader.ParseClassListData(csvFilePath, csvReader.ParseCSVHeaders(csvFilePath));
                                gv_StudentData.DataBind();
                                lb_ResultFeedback.Text = gv_StudentData.Rows.Count.ToString() + "Rows Found"; 
                            }
                            catch (Exception ex)
                            {
                                gv_StudentData.DataSource = null;
                                gv_StudentData.DataBind();
                                lb_error.Text = "Error Occured Reading File";
                            }
                        }
                        else
                        {
                            //alert user that file is not a csv file
                            //lblMsg.ForeColor = Color.Red;
                            //lblMsg.Text = "Uploaded file is not CSV file";
                        }
                    }
                }
                if (fileType == "2")
                {
                    if (fu_UploadFile.HasFile)
                    {
                        FileInfo fileInfo = new FileInfo(fu_UploadFile.PostedFile.FileName);
                        if (fileInfo.Name.Contains(".csv"))
                        {
                            lblMsg.ForeColor = Color.Black; //reset label color
                            string fileName = fileInfo.Name.Replace(".csv", "").ToString();
                            string csvFilePath = Server.MapPath("Files") + "\\" + fileInfo.Name;
                            //save the csv file on the server in 'MyCSVFolder' 
                            //fu_UploadFile.SaveAs(csvFilePath);
                            //get the location of the csv file 
                            //string filePath = Server.MapPath("UpLoadedCSVFiles") + "\\";

                            CSVReaderProvider csvReader = new CSVReaderProvider();
                            gv_StudentData.DataSource = csvReader.ParseSESData(csvFilePath, csvReader.ParseCSVHeaders(csvFilePath));
                            gv_StudentData.DataBind();
                            //SqlProvider sqlProvider = new SqlProvider();
                            //sqlProvider.LoadSESFile(csvFilePath);
                            //lblMsg.ForeColor = Color.Black;
                            //lblMsg.Text = "CSV File Uploaded to Database";
                        }
                        else
                        {
                            //alert user that file is not a csv file
                            lblMsg.ForeColor = Color.Red;
                            lblMsg.Text = "Uploaded file is not CSV file";
                        }
                    }
                }
            } 
        }

        protected void btn_BackUp_Click(object sender, EventArgs e)
        {
            lb_BackUp.Visible = true;
            fl_BackUp.Visible = true;
        }

        protected void Gridview1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        { 

        }

        protected void Gridview1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //get gridview unique key
            var dataKey = Gridview1.DataKeys[e.RowIndex].Value;
             
            GridViewRow row = (GridViewRow)Gridview1.Rows[e.RowIndex];
            DropDownList ddl_faculty = row.FindControl("faculty_dropdownlist") as DropDownList;
            DropDownList ddl_level = row.FindControl("level_DropDownList") as DropDownList;
            DropDownList ddl_Degree = row.FindControl("degree_DropDownList") as DropDownList;
            DropDownList ddl_Programme = row.FindControl("programe_dropdownlist") as DropDownList;
            DropDownList ddl_Tutor = row.FindControl("Tutor_DropDownList") as DropDownList;
            DropDownList ddl_Year = row.FindControl("Year_Dropdownlist") as DropDownList;
            TextBox txt_StdNumber = row.FindControl("txt_StdNum") as TextBox;
            TextBox txt_UniEmail = row.FindControl("txt_UniEmail") as TextBox; 
            using (SqlConnection sqlConn = new SqlConnection(this.GetConnectionString()))
            {
                sqlConn.Open();
                using (SqlCommand sqlCmd = new SqlCommand("Proc_DeleteStudentDataRow", sqlConn))
                {
                    try
                    {
                        Int32 rowsAffected;
                        sqlCmd.CommandType = CommandType.StoredProcedure;
                        sqlCmd.Parameters.Add(new SqlParameter("@LevelID", Convert.ToInt32(ddl_level.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@DegreeID", Convert.ToInt32(ddl_Degree.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@TutorID", Convert.ToInt32(ddl_Tutor.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@CourseID", Convert.ToInt32(ddl_Programme.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@FacultyID", Convert.ToInt32(ddl_faculty.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@YearID", Convert.ToInt32(ddl_Year.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@StudentNumber", Convert.ToString(txt_StdNumber.Text.Trim())));
                        sqlCmd.Parameters.Add(new SqlParameter("@Email", Convert.ToString(txt_UniEmail.Text.Trim())));
                        rowsAffected = sqlCmd.ExecuteNonQuery();
                        sqlConn.Close();
                        Gridview1.EditIndex = -1; //exit edit mode 
                        lb_recordsFeedback.Visible = true; lb_recordsFeedback.Text = "";
                        lb_recordsFeedback.Text = "Row Succesfully Updated";
                    }
                    catch (Exception ex)
                    {

                    }
                }
            }

        }

        /* When row updating, call Proc_UpdateStudentMailer and exec update sql procedure 
         * */

        protected void Gridview1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        { 
            //get gridview unique key
            var dataKey = Gridview1.DataKeys[e.RowIndex].Value;

            GridViewRow row = Gridview1.Rows[e.RowIndex] as GridViewRow;//get gridviewrow instance
            DropDownList ddl_faculty = row.FindControl("faculty_dropdownlist") as DropDownList;
            DropDownList ddl_level = row.FindControl("level_DropDownList") as DropDownList;
            DropDownList ddl_Degree = row.FindControl("degree_DropDownList") as DropDownList;
            DropDownList ddl_Programme = row.FindControl("programe_dropdownlist") as DropDownList;
            DropDownList ddl_Tutor = row.FindControl("Tutor_DropDownList") as DropDownList;
            DropDownList ddl_Year = row.FindControl("Year_Dropdownlist") as DropDownList;
            TextBox txt_StdNumber = row.FindControl("txt_StdNum") as TextBox;
            TextBox txt_UniEmail = row.FindControl("txt_UniEmail") as TextBox; 
            using (SqlConnection sqlConn = new SqlConnection(this.GetConnectionString()))
            {
                sqlConn.Open();
                using (SqlCommand sqlCmd = new SqlCommand("Proc_UpdateStudentDataRow", sqlConn))
                {
                    try
                    {
                        Int32 rowsAffected;
                        sqlCmd.CommandType = CommandType.StoredProcedure;
                        sqlCmd.Parameters.Add(new SqlParameter("@LevelID", Convert.ToInt32(ddl_level.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@DegreeID", Convert.ToInt32(ddl_Degree.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@TutorID", Convert.ToInt32(ddl_Tutor.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@CourseID", Convert.ToInt32(ddl_Programme.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@FacultyID", Convert.ToInt32(ddl_faculty.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@YearID", Convert.ToInt32(ddl_Year.SelectedValue)));
                        sqlCmd.Parameters.Add(new SqlParameter("@StudentNumber", Convert.ToString(txt_StdNumber.Text.Trim())));
                        sqlCmd.Parameters.Add(new SqlParameter("@Email", Convert.ToString(txt_UniEmail.Text.Trim())));
                        rowsAffected = sqlCmd.ExecuteNonQuery();
                        sqlConn.Close(); 
                        Gridview1.EditIndex = -1; //exit edit mode 
                        lb_recordsFeedback.Visible = true; lb_recordsFeedback.Text = ""; 
                        lb_recordsFeedback.Text = "Row Succesfully Updated";
                    }
                    catch (Exception ex)
                    {

                    }
                }
            }

        }

        protected void Gridview1_databound(object sender, EventArgs e)
        {
            lb_recordsFeedback.Text = "";
            lb_recordsFeedback.Text += Gridview1.Rows.Count.ToString() + " Record(s) Found        ";
        }
    }
}