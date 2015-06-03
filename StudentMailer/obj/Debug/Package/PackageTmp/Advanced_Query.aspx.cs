using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Net.Mail;
using System.Drawing;
using System.IO;
using System.Security.Principal;
using StudentMailer;

namespace StudentMailer
{
    public partial class Advanced_Query : System.Web.UI.Page
    {
        #region Private Generic Parameters 
        private readonly string _connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Student_Mailer"].ConnectionString; //connection string 
        EmailHelper emailHelper = new EmailHelper(); //initialise email helper class
        SqlProvider sqlProvider = new SqlProvider();
        #endregion 

        #region Public Methods
        public string AddUserSubQuery(DropDownList ddl_LogicalLink, DropDownList ddl_TableOptions, DropDownList ddl_SelectedTableValue)
        {
            //return whereQuery;
            string queryString = string.Empty;
            //Add logical link if "or" "and"
            if (ddl_LogicalLink.SelectedIndex.ToString() != "0" && ddl_LogicalLink.SelectedIndex.ToString() != "2" && ddl_LogicalLink.SelectedIndex.ToString() != "3")
            {
                queryString += " " + ddl_LogicalLink.SelectedItem.ToString();
                if (ddl_TableOptions.SelectedItem.ToString() == "Academic Year") { queryString += " Academic Year"; cb_AcademicYear.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Tutor") { queryString += " Tutor"; cb_Tutor.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Degree") { queryString += " Degree"; cb_Degree.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Module") { queryString += " Module"; cb_Module.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Faculty") { queryString += " Faculty"; cb_Faculty.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Level") { queryString += " Level"; cb_Level.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Programme") { queryString += " Programme"; cb_Programme.Checked = true; };
                queryString += "IS " + ddl_SelectedTableValue.SelectedItem.ToString();
            }

            //Add logical Link if "NOT"
            if (ddl_LogicalLink.SelectedIndex.ToString() != "0" && ddl_LogicalLink.SelectedIndex.ToString() == "2")
            {
                queryString += " AND";

                if (ddl_TableOptions.SelectedItem.ToString() == "Academic Year") { queryString += " Academic Year"; cb_AcademicYear.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Tutor") { queryString += " Tutor"; cb_Tutor.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Degree") { queryString += " Degree"; cb_Degree.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Module") { queryString += " Module"; cb_Module.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Faculty") { queryString += " Faculty"; cb_Faculty.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Level") { queryString += " Level"; cb_Level.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Programme") { queryString += " Programme"; cb_Programme.Checked = true; };
                queryString += " EXCEPT " + ddl_SelectedTableValue.SelectedItem.ToString();
            }

            //Add logical Link if "IN"
            if (ddl_LogicalLink.SelectedIndex.ToString() != "0" && ddl_LogicalLink.SelectedIndex.ToString() == "3")
            {
                queryString += "AND ";
                if (ddl_TableOptions.SelectedItem.ToString() == "Academic Year") { queryString += " Academic Year"; cb_AcademicYear.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Tutor") { queryString += " Tutor"; cb_Tutor.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Degree") { queryString += " Degree"; cb_Degree.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Module") { queryString += " Module"; cb_Module.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Faculty") { queryString += " Faculty"; cb_Faculty.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Level") { queryString += " Level"; cb_Level.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Programme") { queryString += " Programme"; cb_Programme.Checked = true; };
                queryString += " " + ddl_LogicalLink.SelectedItem.ToString() + " " + ddl_SelectedTableValue.SelectedItem.ToString();
            }


            if (ddl_TableOptions.SelectedIndex.ToString() != "0" && ddl_LogicalLink.SelectedIndex.ToString() == "0")
            {
                if (ddl_TableOptions.SelectedItem.ToString() == "Academic Year") { queryString += " Academic Year"; cb_AcademicYear.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Tutor") { queryString += " Tutor"; cb_Tutor.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Degree") { queryString += " Degree"; cb_Degree.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Module") { queryString += " Module"; cb_Module.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Faculty") { queryString += " Faculty"; cb_Faculty.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Level") { queryString += " Level"; cb_Level.Checked = true; };
                if (ddl_TableOptions.SelectedItem.ToString() == "Programme") { queryString += " Programme"; cb_Programme.Checked = true; };
                queryString += " IS " + ddl_SelectedTableValue.SelectedItem.ToString();
            }
            return queryString;
        }

        public string BuildAdvanceQuery()
        {
            string queryString;
            string Parameters = "";

            //get selected paremeters
            if (cb_StudentName.Checked == true) { Parameters += " dbo.StudentData.StudentName As Name "; }
            if (cb_UniversityEmail.Checked == true || cb_UniversityEmail.Checked == false) { Parameters += ", dbo.StudentData.UniEmail As Email "; }
            if (cb_StudentNumber.Checked == true) { Parameters += ", dbo.StudentData.StudentNumber As 'Student Number' "; }
            if (cb_Course.Checked == true) { Parameters += ", dbo.CourseLookUp.CourseName As Course "; }
            if (cb_Degree.Checked == true) { Parameters += ", dbo.DegreeLookUp.DegreeCode As Degree  "; }
            if (cb_Faculty.Checked == true) { Parameters += ", dbo.FacultyLookUp.FacultyName As Faculty "; }
            if (cb_Level.Checked == true) { Parameters += ",  dbo.LevelLookUp.LevelName As Level "; }
            if (cb_Module.Checked == true) { Parameters += ", dbo.ModuleLookUp.ModuleName As Module "; }
            if (cb_Programme.Checked == true) { Parameters += ", dbo.CourseLookUp.CourseName As Course "; }
            if (cb_Tutor.Checked == true) { Parameters += ", dbo.TutorLookUp.TutorName As Tutor "; }
            if (cb_AcademicYear.Checked == true) { Parameters += ",  dbo.YearLookUp.YearName As 'Academic Year' "; }

            Parameters += ", dbo.StudentData.StudentID As StudentID ";

            //build string  
            queryString = " SELECT DISTINCT " + Parameters + " FROM dbo.StudentData INNER JOIN dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID "
                         + "  JOIN dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID "
                         + "  JOIN dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID "
                         + "  JOIN dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID "
                         + "  JOIN dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID "
                         + "  JOIN dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID "
                         + "  JOIN dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID  "
                         + "  JOIN dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID "
                         + " WHERE  ";
            return queryString;
        }

        public void ResetDropDownList(object sender, EventArgs e)
        {
            //reset all dropdownlist 
            ddl_LogicalLink.SelectedIndex = -1;
            ddl_SelectedTable.SelectedIndex = -1;
            ddl_TableOptions1.SelectedIndex = -1;
            ddl_TableOptions1.Enabled = true;

            //Hide logical link 
            ddl_LogicalLink.Visible = false;
            lb_LogicalLink.Visible = false;
            Btn_Delete.Visible = false;
            Btn_Change.Visible = false;

            //reset check box 
            cb_StudentName.Checked = true;
            cb_StudentNumber.Checked = true;
            cb_UniversityEmail.Checked = true;
            cb_Module.Checked = false;
            cb_Programme.Checked = false;
            cb_Level.Checked = false;
            cb_Faculty.Checked = false;
            cb_Degree.Checked = false;
            cb_Course.Checked = false;
            cb_AcademicYear.Checked = false;
            cb_Tutor.Checked = false;

            //reset feedback 
            lb_feedback.Text = "";
        }

        public bool validateWhereClause(string whereClause)
        {
            lb_err.Text = "";
            lb_err.Visible = false;
            if (whereClause != " ")
            {
                int a = whereClause.IndexOf("AND");
                int b = whereClause.IndexOf("OR");
                if (a.ToString() == "-1" && b.ToString() == "-1")
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else
            { return false; }
        }

        public DataTable GetDataSource(string query)
        {
            try
            {
                SqlConnection connection = new SqlConnection(_connectionString);
                connection.Open();
                SqlDataAdapter da_module = new SqlDataAdapter(query, connection);
                DataTable dataTable = new DataTable();
                da_module.Fill(dataTable);
                connection.Close();
                return dataTable;
            }
            catch (Exception ex)
            {
                throw new IOException(ex.ToString());
            }
        }

        /// <summary>
        /// Method polpulate 
        /// </summary>
        /// <param name="CategoryValue"></param>

        /// <summary>
        /// Method populate table option dropdownlist when user select as table to view it users 
        /// </summary>
        /// <param name="CategoryValue"></param>
        /// <param name="isTableSelected"></param>
        public void PopulateTableOptionsDropdonlist(int CategoryValue, bool isTableSelected)
        {
            //if tableselected is true, set dropdownlist selected value to user selected option 
            if (isTableSelected == true)
            {
                ddl_TableOptions1.SelectedValue = CategoryValue.ToString();
            }

            //populate table options dropdownlist  
            if (CategoryValue == 1)
            {
                //DataSet dataset = this.GetDataSource(); EXEC [Proc_GetTutor]
                ddl_SelectedTable.DataSource = this.GetDataSource("EXEC [Proc_GetAcademicYear]");
                //ddl_SelectedTable.DataSource = dataTable;
                ddl_SelectedTable.DataValueField = "YearID";
                ddl_SelectedTable.DataTextField = "YearName";
                ddl_SelectedTable.DataBind();
                ddl_SelectedTable.Visible = true;
                lb_SelectedTableName1.Visible = true;
                lb_SelectedTableName1.Text = "Academic Year";
                //btn_AddQuery.Visible = true;
            }
            if (CategoryValue == 2)
            {
                //DataSet dataset = this.GetDataSource();
                ddl_SelectedTable.DataSource = this.GetDataSource("EXEC [Proc_GetTutor]");
                //ddl_SelectedTable.DataSource = dataTable;
                ddl_SelectedTable.DataValueField = "TutorID";
                ddl_SelectedTable.DataTextField = "TutorName";
                ddl_SelectedTable.DataBind();
                ddl_SelectedTable.Visible = true;
                lb_SelectedTableName1.Visible = true;
                lb_SelectedTableName1.Text = "Tutor";
                //btn_AddQuery.Visible = true;
            }
            if (CategoryValue == 3)
            {
                //DataSet dataset = this.GetDataSource();
                ddl_SelectedTable.DataSource = this.GetDataSource("EXEC [Proc_GetDegree]");
                //ddl_SelectedTable.DataSource = dataTable;
                ddl_SelectedTable.DataValueField = "DegreeID";
                ddl_SelectedTable.DataTextField = "DegreeCode";
                ddl_SelectedTable.DataBind();
                ddl_SelectedTable.Visible = true;
                lb_SelectedTableName1.Visible = true;
                lb_SelectedTableName1.Text = "Degree";
                //btn_AddQuery.Visible = true;
            }
            if (CategoryValue == 4)
            {
                //DataSet dataset = this.GetDataSource();
                ddl_SelectedTable.DataSource = this.GetDataSource("EXEC [Proc_GetModule]");
                //ddl_SelectedTable.DataSource = dataTable;
                ddl_SelectedTable.DataValueField = "ModuleID";
                ddl_SelectedTable.DataTextField = "ModuleName";
                ddl_SelectedTable.DataBind();
                ddl_SelectedTable.Visible = true;
                lb_SelectedTableName1.Visible = true;
                lb_SelectedTableName1.Text = "Module";
                //btn_AddQuery.Visible = true;
            }
            if (CategoryValue == 5)
            {
                //DataSet dataset = this.GetDataSource();
                ddl_SelectedTable.DataSource = this.GetDataSource("EXEC [Proc_GetFaculty]");
                //ddl_SelectedTable.DataSource = dataTable;
                ddl_SelectedTable.DataValueField = "FacultyID";
                ddl_SelectedTable.DataTextField = "FacultyName";
                ddl_SelectedTable.DataBind();
                ddl_SelectedTable.Visible = true;
                lb_SelectedTableName1.Visible = true;
                lb_SelectedTableName1.Text = "Faculty";
                //btn_AddQuery.Visible = true;
            }
            if (CategoryValue == 6)
            {
                //DataSet dataset = this.GetDataSource();
                ddl_SelectedTable.DataSource = this.GetDataSource("EXEC [Proc_GetLevel]");
                //ddl_SelectedTable.DataSource = dataTable;
                ddl_SelectedTable.DataValueField = "LevelID";
                ddl_SelectedTable.DataTextField = "LevelName";
                ddl_SelectedTable.DataBind();
                ddl_SelectedTable.Visible = true;
                lb_SelectedTableName1.Visible = true;
                lb_SelectedTableName1.Text = "Level"; //btn_AddQuery.Visible = true;
            }
            if (CategoryValue == 7)
            {
                //DataSet dataset = this.GetDataSource();
                ddl_SelectedTable.DataSource = this.GetDataSource("EXEC [Proc_GetCourse]");
                //ddl_SelectedTable.DataSource = dataTable;
                ddl_SelectedTable.DataValueField = "CourseID";
                ddl_SelectedTable.DataTextField = "CourseName";
                ddl_SelectedTable.DataBind();
                ddl_SelectedTable.Visible = true;
                lb_SelectedTableName1.Visible = true;
                lb_SelectedTableName1.Text = "Programme"; //btn_AddQuery.Visible = true;
            }
            if (CategoryValue == -1)
            {
                ddl_SelectedTable.DataSource = null;
                ddl_SelectedTable.DataValueField = " ";
                ddl_SelectedTable.DataTextField = " ";
                ddl_SelectedTable.Visible = false;
                lb_SelectedTableName1.Visible = false;
                ddl_SelectedTable.DataBind(); //btn_AddQuery.Visible = false;
            }
        }

        /// <summary>
        /// Method return yearName given the ID from sql YearLookUp Table
        /// </summary>
        /// <param name="Field"></param>
        /// <param name="ID"></param>
        /// <returns></returns>
        /// 
        public string GetTableValueByID(string Field, int ID)
        {
            string query = string.Empty;
            if (Field == "Year") { query = "SELECT DISTINCT YearName FROM YearLookUp WHERE YearID = " + ID.ToString(); }
            if (Field == "Module") { query = "Select ModuleCode FROM ModuleLookUp WHERE ModuleID = " + ID.ToString(); }
            if (Field == "Tutor") { query = "Select TutorName FROM TutorLookUp WHERE TutorID = " + ID.ToString(); }
            if (Field == "Level") { query = "Select LevelName FROM LevelLookUp WHERE LevelID = " + ID.ToString(); }
            if (Field == "Degree") { query = "Select DegreeCode FROM DegreeLookUp WHERE DegreeID = " + ID.ToString(); }
            if (Field == "Faculty") { query = "Select FacultyName FROM FacultyLookUp WHERE FacultyID = " + ID.ToString(); }
            if (Field == "Course") { query = "Select CourseName FROM CourseLookUp WHERE CourseID = " + ID.ToString(); }
            return Convert.ToString(sqlProvider.ExecuteSqlScalarCommand(query));
        }

        /// <summary>
        /// Given a table name with its respective Primary key code or name, method returns it table ID
        /// </summary>
        /// <param name="Field"></param>
        /// <param name="Value"></param>
        /// <returns></returns>
        public string GetIDByTableValue(string Field, string Value)
        {
            string query = string.Empty;
            if (Field.Contains("Year") == true) { query = "Select YearID FROM YearLookUp WHERE YearName = '" + Value.ToString().Trim() + "'"; }
            if (Field.Contains("Module") == true) { query = "Select  ModuleID FROM ModuleLookUp WHERE  ModuleName = '" + Value.ToString().Trim() + "'"; }
            if (Field.Contains("Tutor") == true) { query = "Select TutorID FROM TutorLookUp WHERE TutorName = '" + Value.ToString().Trim() + "'"; }
            if (Field.Contains("Level") == true) { query = "Select  LevelID FROM LevelLookUp WHERE LevelName = '" + Value.ToString().Trim() + "'"; }
            if (Field.Contains("Degree") == true) { query = "Select  DegreeID FROM DegreeLookUp WHERE  DegreeCode = '" + Value.ToString().Trim() + "'"; }
            if (Field.Contains("Faculty") == true) { query = "Select  FacultyID FROM FacultyLookUp WHERE FacultyName = '" + Value.ToString().Trim() + "'"; }
            if (Field.Contains("Course") == true) { query = "Select CourseID FROM CourseLookUp WHERE CourseName = '" + Value.ToString().Trim() + "'"; }
            return " " + Convert.ToString(sqlProvider.ExecuteSqlScalarCommand(query));
        }

        public string ConvertUserQueryStringToSqlQueryString(string userQuery)
        {
            //replace IS with = and replace NOT with != 
            if (userQuery.Contains("EXCEPT"))
            {
                userQuery = userQuery.Replace("EXCEPT", "!=");
            }
            if (userQuery.Contains("IS"))
            {
                userQuery = userQuery.Replace("IS", "=");
            }
            if (userQuery.Contains("IN"))
            {
                userQuery = userQuery.Replace("IN", "=");
            }

            //replace Category Name with table respective sql clause 
            if (userQuery.Contains("Year")) { userQuery = userQuery.Replace("Academic Year", "dbo.StudentData.YearID"); }
            if (userQuery.Contains("Module")) { userQuery = userQuery.Replace("Module", "dbo.StudentModule.ModuleID"); }
            if (userQuery.Contains("Tutor")) { userQuery = userQuery.Replace("Tutor", "dbo.StudentData.TutorID"); }
            if (userQuery.Contains("Level")) { userQuery = userQuery.Replace("Level", "dbo.StudentData.LevelID"); }
            if (userQuery.Contains("Degree")) { userQuery = userQuery.Replace("Degree", "dbo.StudentData.DegreeID"); }
            if (userQuery.Contains("Faculty")) { userQuery = userQuery.Replace("Faculty", "dbo.StudentData.FacultyID"); }
            if (userQuery.Contains("Programme")) { userQuery = userQuery.Replace("Programme", "dbo.StudentData.CourseID"); }

            string[] splituserQuery;
            splituserQuery = userQuery.Split('=');
            string ID = splituserQuery.Last();
            //replace Names/Code with respective ID's
            if (userQuery.Contains("YearID")) { userQuery = userQuery.Replace(ID, this.GetIDByTableValue("Year", ID)); }
            if (userQuery.Contains("ModuleID")) { userQuery = userQuery.Replace(ID, this.GetIDByTableValue("Module", ID)); }
            if (userQuery.Contains("TutorID")) { userQuery = userQuery.Replace(ID, this.GetIDByTableValue("Tutor", ID)); }
            if (userQuery.Contains("LevelID")) { userQuery = userQuery.Replace(ID, this.GetIDByTableValue("Level", ID)); }
            if (userQuery.Contains("DegreeID")) { userQuery = userQuery.Replace(ID, this.GetIDByTableValue("Degree", ID)); }
            if (userQuery.Contains("FacultyID")) { userQuery = userQuery.Replace(ID, this.GetIDByTableValue("Faculty", ID)); }
            if (userQuery.Contains("CourseID")) { userQuery = userQuery.Replace(ID, this.GetIDByTableValue("Course", ID)); }

            return userQuery;
        }

        /// <summary>
        /// Method Accept Check Box List consisting of all user designed qery and return a sql statement equivalent 
        /// </summary>
        /// <param name="cbList"></param>
        /// <returns></returns>
        public string GenerateSQLQueryString(CheckBoxList cbList)
        {
            string SqlString = string.Empty;
            List<string> ANDList = new List<string>();
            List<string> ORList = new List<string>();
            string firstWhereClause = string.Empty; //stores the first query withour a logical link 
            string firstLogicalLink = string.Empty; //stores the logical link connecting first and second sub query
            int check = 0;

            //loop through checkboxList 
            foreach (ListItem cb in cbList.Items)
            {
                if (check == 0) // this is the firts loop,this means this subquery as no logical link 
                {
                    check++;//increase check by 1 
                    //Generate SQL Syntax of User query and store it 
                    firstWhereClause = this.ConvertUserQueryStringToSqlQueryString(cb.Text);
                }
                else  //this is not the first loop, hence logical link is included
                {
                    if (check == 1 && cbList.Items.Count > 0)
                    {
                        string[] getLink = cb.Text.Split(' ');
                        if (getLink.Count() >= 0) { firstLogicalLink = getLink[1].ToString(); } //get first logical link 
                        else { firstLogicalLink = "OR"; } //set first logical link default is "OR" 

                        string subQuery = string.Empty;
                        if (cb.Text.Contains("AND") == true)
                        {
                            if (cb.Text.Contains("EXCEPT") == true)
                            {
                                subQuery = cb.Text.Replace("AND", "");
                                ANDList.Add(ConvertUserQueryStringToSqlQueryString(subQuery));
                            }
                            else if (cb.Text.Contains("IN") == true)
                            {
                                subQuery = cb.Text.Replace("AND", "");
                                ANDList.Add(ConvertUserQueryStringToSqlQueryString(subQuery));
                            }
                            else
                            {
                                subQuery = cb.Text.Replace("AND", "");
                                ANDList.Add(ConvertUserQueryStringToSqlQueryString(subQuery));
                            }

                        } 
                        check++;
                    }
                    else
                    {
                        string subQuery = string.Empty;
                        if (cb.Text.Contains("AND") == true)
                        {
                            if (cb.Text.Contains("EXCEPT") == true)
                            {
                                subQuery = cb.Text.Replace("AND", "");
                                ANDList.Add(ConvertUserQueryStringToSqlQueryString(subQuery));
                            }
                            else if (cb.Text.Contains("IN") == true)
                            {
                                subQuery = cb.Text.Replace("AND", "");
                                ANDList.Add(ConvertUserQueryStringToSqlQueryString(subQuery));
                            }
                            else
                            {
                                subQuery = cb.Text.Replace("AND", "");
                                ANDList.Add(ConvertUserQueryStringToSqlQueryString(subQuery));
                            }

                        } 
                    }
                }

            }
            //generate AND clause from string 
            string ANDString = string.Empty;
            int ORIndex = 0, ANDIndex = 0; 
            //Loop through ANDList and Build And sub query 
            foreach (string b in ANDList)
            {
                if (ANDIndex == 0)
                {
                    ANDString += b.ToString(); //first sub OR Query
                    ANDIndex++;
                }
                else
                {
                    ANDString += " AND " + b.ToString();
                }
            }

            if (ANDString == "")
            {
                SqlString = this.BuildAdvanceQuery()  + firstWhereClause;
            } 
            else
            {
                SqlString = this.BuildAdvanceQuery() + firstWhereClause + "AND" + ANDString;
            }
            return SqlString;
        }

        /// <summary>
        /// Method converts user query to sql query
        /// </summary>
        /// <param name="sqlQuery"></param>
        /// <returns></returns>
        public string ConvertSQLQueryStringToUserQuery(string sqlQuery)
        {
            string userQuery = string.Empty;

            //replace Category Name with table respective sql clause 
            if (sqlQuery.Contains("Year")) { userQuery = sqlQuery.Replace("dbo.StudentData.YearID", "Academic Year"); }
            if (sqlQuery.Contains("Module")) { userQuery = sqlQuery.Replace("dbo.StudentModule.ModuleID", "Module"); }
            if (sqlQuery.Contains("Tutor")) { userQuery = sqlQuery.Replace("dbo.StudentData.TutorID", "Tutor"); }
            if (sqlQuery.Contains("Level")) { userQuery = sqlQuery.Replace("dbo.StudentData.LevelID", "Level"); }
            if (sqlQuery.Contains("Degree")) { userQuery = sqlQuery.Replace("dbo.StudentData.DegreeID", "Degree"); }
            if (sqlQuery.Contains("Faculty")) { userQuery = sqlQuery.Replace("dbo.StudentData.FacultyID", "Faculty"); }
            if (sqlQuery.Contains("Course")) { userQuery = sqlQuery.Replace("dbo.StudentData.CourseID", "Programme"); }

            string[] splituserQuery;
            splituserQuery = userQuery.Split('=');
            string Value = splituserQuery.Last();
            //replace Names/Code with respective ID's
            if (userQuery.Contains("Year")) { userQuery = userQuery.Replace(Value, this.GetTableValueByID("Year", Convert.ToInt16(Value))); }
            if (userQuery.Contains("Module")) { userQuery = userQuery.Replace(Value, this.GetTableValueByID("Module", Convert.ToInt16(Value))); }
            if (userQuery.Contains("Tutor")) { userQuery = userQuery.Replace(Value, this.GetTableValueByID("Tutor", Convert.ToInt16(Value))); }
            if (userQuery.Contains("Level")) { userQuery = userQuery.Replace(Value, this.GetTableValueByID("Level", Convert.ToInt16(Value))); }
            if (userQuery.Contains("Degree")) { userQuery = userQuery.Replace(Value, this.GetTableValueByID("Degree", Convert.ToInt16(Value))); }
            if (userQuery.Contains("Faculty")) { userQuery = userQuery.Replace(Value, this.GetTableValueByID("Faculty", Convert.ToInt16(Value))); }
            if (userQuery.Contains("Course")) { userQuery = userQuery.Replace(Value, this.GetTableValueByID("Course", Convert.ToInt16(Value))); }


            if (userQuery.Contains("=") && !userQuery.Contains("!")) userQuery = userQuery.Replace("=", " IS ");
            if (userQuery.Contains("!=")) userQuery = userQuery.Replace("!=", " IS NOT ");
            return userQuery;
        }

        /// <summary>
        /// Method returns List of where sub clause 
        /// </summary>
        /// <param name="whereString"></param>
        /// <returns></returns>
        public List<string> GetListOfWhereClause(string whereString)
        {
            List<string> list = new List<string>();
            string newWhereString = string.Empty;
            newWhereString = whereString.Trim();
            if (newWhereString != "")
            {
                whereString = whereString.Replace("(", "").Replace(")", ""); 
                string[] splitWhereString = whereString.Split(new string[] { "AND" }, StringSplitOptions.None); 
                int index = splitWhereString.Count();

                //get all logical sub where clause 
                int check = 0; 
                foreach (string a in splitWhereString)
                {
                    if (check == 0)
                    {
                        //first sub logical clause
                        check++; 
                        list.Add(ConvertSQLQueryStringToUserQuery(a));
                    }
                    else if (check > 0)  
                    {
                        //second abd above sub logical clause
                        list.Add("AND" + ConvertSQLQueryStringToUserQuery(a));
                    }
                }

            }
            return list;
        }

        public void PopulateGridView(GridView gridview, Label errorFeedback, string sqlQuery)
        {
            try
            {
                SqlConnection sqlConnection = new SqlConnection(_connectionString); //get sql connection object
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

        [ThemeableAttribute(false)]
        public virtual string ValidationGroup
        { get; set; }
        #endregion

        #region Private Methods 

        #endregion

        #region Protected Methods

        protected void Button2_OnClick(object sender, EventArgs e)
        {
            //make control visible
            FileUpload2.Visible = true;
            ImgBtn_NewAttachment1.Visible = true;
            ImgBtn_Attachment.Visible = false;
        }

        protected void new_attachment1_OnClick(object sender, EventArgs e)
        {
            //make controls visisble  
            fileUpload3.Visible = true;
            ImgBtn_NewAttachment2.Visible = false;
        }

        protected void new_attachment_OnClick(object sender, EventArgs e)
        { //Set upload control to visible 
            fileUpload1.Visible = true;
            ImgBtn_NewAttachment1.Visible = false;
            ImgBtn_NewAttachment2.Visible = true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Set dropdownlist AppendDataBounds 
                lb_UserName.Text = "SSSADW"; 
                //lb_UserName.Text = emailHelper.GetUserName(); 
                ddl_TableOptions1.AppendDataBoundItems = true;  
                ddl_SelectedTable.AppendDataBoundItems = true; 
                ddl_SavedSearch.AppendDataBoundItems = true;
                cb_Query.AppendDataBoundItems = true;
                RBL_Visibility.AppendDataBoundItems = true;
                
            }
        }

        protected void ddl_TableOptions_SelectedIndexChanged(object sender, EventArgs e)
        {
            int value = Convert.ToInt32(ddl_TableOptions1.SelectedValue);
            ddl_SelectedTable.DataSource = null; ddl_SelectedTable.DataBind();
            ddl_SelectedTable.AppendDataBoundItems = false;
            // txt_Search.Text = "View Search In Text";
            this.PopulateTableOptionsDropdonlist(value, false);
        }

        protected void btn_AddQuery_Click(object sender, EventArgs e)
        {
            ddl_LogicalLink.Visible = true; //make logical link dropdownlist visible
            lb_LogicalLink.Visible = true; //make logical link label visible  
            ddl_LogicalLink.Enabled = true;
            string newSubQuery = string.Empty; //Clear sub query string 
            string userQuery = string.Empty; //clear query that will be shown to user 
            newSubQuery = this.AddUserSubQuery(ddl_LogicalLink, ddl_TableOptions1, ddl_SelectedTable); //get user built query in sql
            bool validate = this.validateWhereClause(newSubQuery); //validate is subquery is in the right format 
            if (validate == false && ddl_LogicalLink.SelectedIndex == 0 && cb_Query.Items.Count == 0) //if this is user first sub query
            {
                //Add user query to check box list 
                userQuery = this.AddUserSubQuery(ddl_LogicalLink, ddl_TableOptions1, ddl_SelectedTable); //get query to be displayed to user
                btn_Query.Visible = true; //enable query n visibbuttoility 
                ListItem newQuery = new ListItem(); //create new List item object which will be added to checkboxList
                //int index = Convert.ToInt16(ddl_TableOptions1.SelectedValue); //get table index to set as value for checkbox
                //newQuery.Value = index.ToString();
                newQuery.Text = userQuery; //set query text to list Item text
                cb_Query.Items.Add(newQuery); //Add item to check box list
            }
            else if (validate == true && cb_Query.Items.Count > 0)  //if this is not user first subquery
            {
                ddl_LogicalLink.Visible = true;
                lb_LogicalLink.Visible = true;
                ddl_LogicalLink.Enabled = true;
                userQuery = this.AddUserSubQuery(ddl_LogicalLink, ddl_TableOptions1, ddl_SelectedTable);
                btn_Query.Visible = true;
                //update edit checkbox listItem conrol   
                ListItem newQuery = new ListItem();
                int index = Convert.ToInt16(ddl_TableOptions1.SelectedValue);
                newQuery.Value = index.ToString();
                newQuery.Text = userQuery;
                cb_Query.Items.Add(newQuery);
            }
            else
            {
                newSubQuery = string.Empty; //empty sub query string 
                lb_err.Visible = true; //enable user to view error result 
                lb_err.ForeColor = Color.Red;
                lb_err.Text = "Invalid Query, Logical Link Missing"; //Allert User About Missing Logical Link 
                ddl_LogicalLink.BackColor = Color.Red; //Set Logical Link DropDownlist Back Color To Red
            }

        }

        protected void ddl_LogicalLink_SelectedIndexChanged(object sender, EventArgs e)
        {
            //ddl_TableOptions2.Visible = true;
            //lb_TableOptions2.Visible = true;
            lb_err.Text = "";
            ddl_LogicalLink.BackColor = Color.White;
            //ddl_LogicalLink.CssClass = "NavDropDownList";
        }

        protected void btn_Query_Click(object sender, EventArgs e)
        {
            gv_StudentData.DataSource = null; //clear previous result  
            gv_StudentData.DataBind();
            //check if user did build a query statement before clicking query 
            if (cb_Query.Items.Count < 0) //check is user as built search before querying the database
            {
                lb_ResultFeedback.Visible = false;
                lb_err.Visible = true; //enable error label visibility
                lb_err.Text = "Empty Search"; //alert user no search statement is built yet. 
                gv_StudentData.Height = 12; //reduce gridvieew height
                gv_Result.Height = 20; //reduce gridview panel 
                gv_StudentData.DataSource = null;  //reset gridview datasource
                gv_StudentData.DataBind(); //bind gridview data to null 
            }
            else
            {
                this.PopulateGridView(gv_StudentData, lb_err, this.GenerateSQLQueryString(cb_Query));
                int recordNumber = Convert.ToInt32(gv_StudentData.Rows.Count);
                gv_Result.Height = 290;
                lb_ResultFeedback.Visible = true;
                if (recordNumber > 0)
                {
                    lb_ResultFeedback.Text = recordNumber.ToString() + "  Record(s) Found";
                }
                else
                {
                    lb_ResultFeedback.Text = "No Record(s) Found";
                }
            }
            ddl_TableOptions1.Enabled = true;
            ddl_SelectedTable.Enabled = true;
            //lb_CummulateQuery.Text = "";
            //.Text = ""; //empty query container 
            //this.ResetDropDownList(sender, e); 

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

        protected void Btn_Email_Click(object sender, EventArgs e)
        {
            sendButton.Text = "Send";
            lb_EmailFeedBack.Text = ""; //clear previosu feedback text.
            //execute action when expanding/collaspsing email section 
            emailHelper.OnEmailPanelExpand(gv_StudentData, Tb_To, Tb_FROM, Btn_Email); 
        }

        protected void btn_ClearQuery_Click(object sender, EventArgs e)
        {
            //reset dropdownlist 
            this.ResetDropDownList(sender, e);

            //txt_Search.Text = "View Search In Text";
            gv_StudentData.Height = 12;
            gv_Result.Height = 20;
            gv_StudentData.DataSource = null;
            gv_StudentData.DataBind();

            //clear check box data 
            cb_Query.DataSource = null;
            cb_Query.DataBind();

            //clear Search Feedback Result  
            lb_ResultFeedback.Text = " ";
            lb_ResultFeedback.Visible = false;

            //clear query List 
            cb_Query.Items.Clear();
        }

        protected void Btn_Save_Click(object sender, EventArgs e)
        {
            if (btn_SaveSearch.Text == "Save Search")
            {
                btn_SaveSearch.Text = "Collaspe Save Search Section";
            }
            else
            {
                btn_SaveSearch.Text = "Save Search";
            }
            lb_fileerror.Text = ""; //empty file error text 
            if (Txt_fileName.Text == "" || Txt_fileName.Text == " ")
            {
                lb_fileerror.Text = "";
                lb_fileerror.ForeColor = Color.Red;
                lb_fileerror.Text = "No Name Found,Provide A Name To Proceed";
            }
            else
            {
                if (cb_Query.Items.Count >= 0)
                {
                    if (cb_Query.Items.Count != 0)
                    {
                        string whereClause = this.GenerateSQLQueryString(cb_Query).Replace(this.BuildAdvanceQuery(), "");  //get where clause from generated SQLQuery
                        string userName = emailHelper.GetUserName();
                        //execute sql procedure to store 
                        using (SqlConnection sqlConn = new SqlConnection(_connectionString))
                        {
                            sqlConn.Open();
                            using (SqlCommand sqlCmd = new SqlCommand("Proc_CreateUserSearch", sqlConn))
                            {
                                Int32 rowsAffected = -1;
                                try
                                {
                                    sqlCmd.CommandType = CommandType.StoredProcedure;
                                    sqlCmd.Parameters.Add(new SqlParameter("@UserName", userName));
                                    sqlCmd.Parameters.Add(new SqlParameter("@SearchName", Txt_fileName.Text.ToString().Trim()));
                                    sqlCmd.Parameters.Add(new SqlParameter("@WhereClause", whereClause));
                                    rowsAffected = sqlCmd.ExecuteNonQuery();
                                    sqlConn.Close();
                                    lb_fileerror.ForeColor = Color.Black;
                                    lb_fileerror.Text = "Search - " + Txt_fileName.Text + " Successfully Saved";
                                    ddl_SavedSearch.Items.Clear();
                                    ddl_SavedSearch.DataBind();
                                }
                                catch (Exception ex)
                                {
                                    lb_fileerror.ForeColor = Color.Red; lb_fileerror.Text = "Error Saving Search, Try again";
                                }

                            }
                        }

                    }
                    else
                    {
                        lb_fileerror.Text = ""; lb_fileerror.ForeColor = Color.Red;
                        lb_fileerror.Text = "Search Empty";
                    }
                }
            }
        }

        protected void btn_SaveSearch_Click(object sender, EventArgs e)
        {
            ddl_SavedSearch.Items.Clear();
            ddl_SavedSearch.DataBind();
            if (btn_SaveSearch.Text == "Save Search")
            {
                btn_SaveSearch.Text = "Collapse Save Search Section";
            }
            else
            {
                btn_SaveSearch.Text = "Save Search";
            }
        }

        protected void ddl_SavedSearch_SelectedIndexChanged(object sender, EventArgs e)
        {
            //txt_Search.Text = "View Search In Text"; 
            //empty query list check box  
            lb_feedback.Text = "";
            lb_err.Text = "";
            gv_StudentData.DataSource = null; gv_StudentData.DataBind();
            if (ddl_SavedSearch.SelectedItem.ToString() == "---Select---" || ddl_SavedSearch.SelectedValue.ToString() == "-1")
            {
                //Btn_RemoveSaveSearch.Visible = false;
                Btn_DeleteSaveSavedSearch.Visible = false;
                gv_StudentData.Height = 12;
                gv_Result.Height = 20;
                lb_ResultFeedback.Text = "";
            }
            else
            {
                Btn_DeleteSaveSavedSearch.Visible = true;
                Btn_DeleteSaveSavedSearch.Visible = true;
                //string fileName = Server.MapPath("QueryFiles") + "\\" + ddl_SavedSearch.SelectedItem.ToString() + ".txt";
                string queryString = string.Empty;
                string query = "EXEC dbo.Proc_GetWhereClauseBySearchID @SearchID = " + Convert.ToInt32(ddl_SavedSearch.SelectedItem.Value) + ", @UserName = '" + emailHelper.GetUserName().TrimStart().TrimEnd() + "'";
                //string query = "EXEC dbo.Proc_GetWhereClauseBySearchID @SearchID = " + Convert.ToInt32(ddl_SavedSearch.SelectedItem.Value) + ", @UserName = '" + "SSSADW" + "'";
                queryString = Convert.ToString(sqlProvider.ExecuteSqlScalarCommand(query));
                cb_Query.Items.Clear();
                List<string> list = new List<string>();
                list = this.GetListOfWhereClause(queryString);
                foreach (string a in list)
                {
                    ListItem listItem = new ListItem();
                    listItem.Text = a;
                    cb_Query.Items.Add(listItem);
                }
                //query the database 
                try
                {
                    string connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings["Student_Mailer"].ConnectionString;
                    SqlConnection sqlConnection = new SqlConnection(connectionstring);
                    sqlConnection.Open();
                    SqlCommand command = sqlConnection.CreateCommand();
                    command.CommandType = CommandType.Text;
                    command.CommandText = this.BuildAdvanceQuery() + " " + queryString;

                    //display seaarch for users to view  
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                    dataAdapter.SelectCommand = command;
                    DataSet ds = new DataSet();
                    dataAdapter.Fill(ds, "StudentData");
                    command.ExecuteNonQuery();
                    gv_StudentData.Height = 280;
                    gv_Result.Height = 300;
                    gv_StudentData.DataSource = ds;
                    gv_StudentData.DataBind();
                    //enable logical linl dropdownlist to be visible by user 
                    ddl_LogicalLink.Visible = true;
                    lb_LogicalLink.Visible = true;
                    int recordNumber = Convert.ToInt32(gv_StudentData.Rows.Count);
                    lb_ResultFeedback.Visible = true;
                    if (recordNumber > 0)
                    {
                        lb_ResultFeedback.Text = recordNumber.ToString() + "  Record(s) Found";
                        lb_feedback.ForeColor = Color.Black;
                        lb_feedback.Visible = true;
                        lb_feedback.Text = "Selected Search Is -" + ddl_SavedSearch.SelectedItem.Text;
                    }
                    else
                    {
                        lb_ResultFeedback.Text = "No Record(s) Found";
                    }
                    //close sql connecion
                    sqlConnection.Close();
                    queryString = string.Empty;
                }
                catch (Exception ex)
                {
                    lb_err.Visible = true;
                    //txt_Search.Text = "View Search In Text"  
                    //lb_err.Text = ex.ToString();
                    lb_err.Text = "Invalid Query String";
                    gv_StudentData.Height = 0;
                    ddl_LogicalLink.Visible = false; lb_LogicalLink.Visible = true;
                }
            }
        }

        protected void cb_Query_SelectedIndexChanged(object sender, EventArgs e)
        {
            //get selected check box value 
            ddl_LogicalLink.Enabled = true;
            lb_LogicalLink.Enabled = true;
            if (cb_Query.SelectedIndex != -1)
            {
                string selectedQueryItem = cb_Query.SelectedItem.ToString();
                string selectedQueryValue = cb_Query.SelectedValue.ToString();
                //make change button visible 
                Btn_Change.Visible = true;
                Btn_Delete.Visible = true;
            }
            if (cb_Query.SelectedIndex == -1)
            {
                //make change button invisible 
                Btn_Change.Visible = false;
                Btn_Delete.Visible = false;
            }
            //if selected sub query as no logical link, hide logical link dropdownlist 
            if (cb_Query.SelectedIndex == 0)
            {
                ddl_LogicalLink.Enabled = false;
                ddl_LogicalLink.SelectedIndex = 0;
                lb_LogicalLink.Enabled = false;
            }

        }

        protected void Btn_Change_Click(object sender, EventArgs e)
        {
            //change selected search to new user choosen search on check box list 
            cb_Query.SelectedItem.Text = this.AddUserSubQuery(ddl_LogicalLink, ddl_TableOptions1, ddl_SelectedTable);
            //cb_Query.SelectedValue = Convert.ToString(ddl_TableOptions1.SelectedValue); 

        }

        /*summary 
         * Delete Sub Search When Building Search Statement 
         * */
        protected void Btn_Delete_Click(object sender, EventArgs e)
        {
            //get sub query user as requested to be deleted    
            if (cb_Query.SelectedIndex != -1)
            {
                //remove query from dropdownlist
                cb_Query.Items.RemoveAt(cb_Query.SelectedIndex);
                ddl_TableOptions1.Enabled = true;
                ddl_SavedSearch.Items.Clear();
                ddl_SavedSearch.DataBind();
                //remove query from database 

            }
            else
            {
                //inform user no sub query selected 
            }
        }

        protected void Btn_DeleteSaveSavedSearch_Click(object sender, EventArgs e)
        {
            //get selected saved search 
            if (ddl_SavedSearch.SelectedIndex != -1)
            {
                ///get file path 
                int searchID = Convert.ToInt32(ddl_SavedSearch.SelectedItem.Value);
                try
                {
                    //call delete procedure
                    string sqlQuery = "EXEC dbo.[Proc_DeleteUserSearch] @SearchID = " + searchID; 
                    sqlProvider.ExecuteNonQuery(sqlQuery);
                    lb_fileerror.ForeColor = Color.Black;
                    lb_fileerror.Text = ddl_SavedSearch.SelectedItem.Text + " Successfully Deleted";
                    //update dropdowlist 
                    ddl_SavedSearch.Items.Clear();
                    ddl_SavedSearch.DataBind();
                }
                catch (Exception ex)
                {
                    lb_fileerror.Text = ""; lb_fileerror.ForeColor = Color.Red;
                    lb_fileerror.Text = "Delete Unsuccessfull";
                }
            }
        }

        protected void cb_ListOfGroup_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Btn_Group_Click(object sender, EventArgs e)
        {
            try
            {
                lb_errorFeedback.Text = ""; //clear error test 
                lb_groupFeedback.Text = ""; //clear feedback test 
                string userID, userName, groupName = "";
                int visibility; 
                userName = emailHelper.GetUserName();
                //get userID
                string sqlQuery = "SELECT DISTINCT [UserID] FROM [Student_Mailer].[dbo].[UserLookup] WHERE [UserName] = " + "'" + userName + "'"; 
                userID = Convert.ToString(sqlProvider.ExecuteSqlScalarCommand(sqlQuery));
                //get group name 
                if (Txt_GroupName.Text != "" || Txt_GroupName.Text != " ")
                {
                    groupName = Txt_GroupName.Text.Trim();
                }
                else lb_errorFeedback.Text = "No Group Name Provided";

                //check user select a visibility status
                if (RBL_Visibility.SelectedIndex.ToString() == "-1")
                {
                    lb_errorFeedback.Text = "No access select, you must select an access state";
                }
                visibility = Convert.ToInt16(RBL_Visibility.SelectedItem.Value);
                using (SqlConnection sqlConn = new SqlConnection(_connectionString))
                {
                    sqlConn.Open();
                    using (SqlCommand sqlCmd = new SqlCommand("Proc_CreateUserGroup", sqlConn))
                    {
                        try
                        {
                            Int32 rowsAffected;
                            sqlCmd.CommandType = CommandType.StoredProcedure;
                            sqlCmd.Parameters.Add(new SqlParameter("@UserID", Convert.ToInt32(userID)));
                            sqlCmd.Parameters.Add(new SqlParameter("@GroupName", groupName));
                            sqlCmd.Parameters.Add(new SqlParameter("@Status", Convert.ToInt16(visibility)));
                            rowsAffected = sqlCmd.ExecuteNonQuery();
                            sqlConn.Close();
                        }
                        catch (Exception ex)
                        {

                        }
                        lb_groupFeedback.Text = "Group " + groupName + " Successfully Created";
                        rb_ListOfGroup.DataBind(); //update list 
                    }
                }
            }
            catch (Exception ex)
            {
                lb_errorFeedback.Text = "An Unhandled Exception Occured";
            }
        }

        protected void Btn_DeleteGroup_Click(object sender, EventArgs e)
        {
            lb_errorFeedback.Text = ""; lb_groupFeedback.Text = "";
            try
            {
                //check a group as been selected 
                if (rb_ListOfGroup.SelectedIndex.ToString() == "-1")
                {
                    lb_errorFeedback.Text = "Select a Group to Delete";
                }
                else
                {
                    string groupName = rb_ListOfGroup.SelectedItem.Text;
                    using (SqlConnection sqlConn = new SqlConnection(_connectionString))
                    {
                        sqlConn.Open();
                        using (SqlCommand sqlCmd = new SqlCommand("Proc_DeleteUserGroup", sqlConn))
                        {
                            try
                            {
                                Int32 rowsAffected;
                                sqlCmd.CommandType = CommandType.StoredProcedure;
                                sqlCmd.Parameters.Add(new SqlParameter("@GroupName", groupName));
                                rowsAffected = sqlCmd.ExecuteNonQuery();
                                sqlConn.Close();
                            }
                            catch (Exception ex)
                            {

                            }
                            lb_groupFeedback.Text = "Group " + groupName + " Successfully Deleted";
                            rb_ListOfGroup.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            }

        }

        protected void Btn_AssignStudentToGroup_Click(object sender, EventArgs e)
        {
            lb_errorFeedback.Text = ""; lb_groupFeedback.Text = "";
            try
            {
                bool isGridViewIsSelected = false; //use to check any checkbox is selected
                if (gv_StudentData.Rows.Count != 0)
                {
                    string query = "INSERT INTO [Student_Mailer].[dbo].[StudentGroups]([GroupID] ,[StudentID]) VALUES ";
                    string values = "";
                    if (rb_ListOfGroup.SelectedIndex != -1)
                    {
                        string groupID = rb_ListOfGroup.SelectedItem.Value.ToString();
                        //check user as selected student in gridview 
                        foreach (GridViewRow i in gv_StudentData.Rows)
                        {
                            int studentID = Convert.ToInt32(gv_StudentData.DataKeys[i.RowIndex].Values[1]);
                            CheckBox cb = (CheckBox)i.FindControl("cb_select"); //inspect the check box.
                            bool isCheckBoxSelected = false;
                            if (cb != null && cb.Checked) //if check 
                            {
                                isCheckBoxSelected = true;
                                isGridViewIsSelected = true;
                            }
                            if (isGridViewIsSelected == true)
                            { //no student selected  
                                if (isCheckBoxSelected == true)
                                {
                                    values += "( " + groupID + "," + studentID + "),";
                                }
                            }
                            else lb_errorFeedback.Text = "No Student Selected";
                        }
                        if (isGridViewIsSelected == true)
                        {
                            string sqlQuery = query + values.Substring(0, values.Length - 1);

                            using (SqlConnection sqlConnection = new SqlConnection(_connectionString))
                            {
                                if (sqlConnection == null)
                                {
                                    ///"Sql Connection Failed")
                                }
                                SqlCommand sqlCommand = sqlConnection.CreateCommand();
                                sqlCommand.Connection = sqlConnection;
                                sqlCommand.CommandTimeout.Equals(60000);
                                sqlCommand.CommandType = CommandType.Text;
                                //Add paramters and assign values
                                sqlCommand.CommandText = sqlQuery;
                                sqlConnection.Open();
                                sqlCommand.ExecuteNonQuery();
                                sqlConnection.Close();
                                lb_groupFeedback.Visible = true;
                                lb_groupFeedback.Visible = true;
                                lb_groupFeedback.Text = "Student Added To Group - " + rb_ListOfGroup.SelectedItem.Text;
                                lb_errorFeedback.Text = "";

                            }
                        }
                    }
                    else
                    {
                        lb_errorFeedback.Text = "No Group Selected, Please Select a Group to continue";
                    }
                }
                else lb_errorFeedback.Text = "No Student Data Displayed";
            }
            catch (Exception ex)
            {
                lb_errorFeedback.Text = "Exception caught in the process";
            }

        }

        protected void Btn_ViewStudent_Click(object sender, EventArgs e)
        {
            lb_errorFeedback.Text = ""; lb_groupFeedback.Text = "";
            try
            {
                //check a group as been selected 
                if (rb_ListOfGroup.SelectedIndex.ToString() == "-1")
                {
                    lb_errorFeedback.Text = "Select a Group to View Its Users";
                }
                else
                {
                    string groupName = rb_ListOfGroup.SelectedItem.Text;
                    int groupID = Convert.ToInt32(rb_ListOfGroup.SelectedItem.Value);
                    string sqlQyery = "EXEC dbo.[Proc_GetStudentsInGroup] @GroupID = " + groupID;
                    try
                    {
                        this.PopulateGridView(gv_StudentData, lb_errorFeedback, sqlQyery);
                        int recordNumber = Convert.ToInt32(gv_StudentData.Rows.Count);
                        gv_Result.Height = 290;
                        lb_ResultFeedback.Visible = true;
                        if (recordNumber > 0)
                        {
                            lb_ResultFeedback.Text = recordNumber.ToString() + "  Record(s) Found";
                        }
                        else
                        {
                            lb_ResultFeedback.Text = "No Record(s) Found";
                        }
                    }
                    catch (Exception ex)
                    {
                        lb_groupFeedback.Text = "Students In " + groupName + "Successfully Displayed in Result Section";
                    }

                }
            }
            catch (Exception ex)
            {
            }

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

        protected void Btn_Groups_Click(object sender, EventArgs e)
        {
            if (Btn_Groups.Text == "Groups")
            {
                Btn_Groups.Text = "Collapse Group Section";
            }
            else
            {
                Btn_Groups.Text = "Groups";
            }
        }

        #endregion

    }
}