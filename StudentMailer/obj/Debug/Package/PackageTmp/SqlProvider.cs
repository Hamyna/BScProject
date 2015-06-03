using System;
using System.Collections.Generic;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.IO; 
namespace StudentMailer
{
    public class SqlProvider : CSVReaderProvider 
    {
        private readonly string _connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Student_Mailer"].ConnectionString; //connection string 
        public SqlProvider()
        {
        }

        #region SqlTransaction  
        public void UpsertStudentData(StudentData _studentData)
        {
            try
            {
                if (_connectionString != null)
                    using (SqlConnection sqlConnection = new SqlConnection(_connectionString))
                    {
                        if (sqlConnection == null)
                        {
                            ///"Sql Connection Failed"
                        }
                        else
                        {
                            SqlCommand sqlCommand = sqlConnection.CreateCommand();
                            sqlCommand.Connection = sqlConnection;
                            sqlCommand.CommandTimeout.Equals(60000);
                            sqlCommand.CommandType = CommandType.Text;
                            string updateQuery = "Update [Student_Mailer].[dbo].[StudentData] "
                                                    + " SET " +
                                                    " [StudentNumber]  = @StudentNumber " +
                                                    ",[UniEmail] = @UniEmail " +
                                                    ",[StudentName] = @StudentName " +
                                                    ",[Initial]  = @Initial " +
                                                    ",[LevelID] = @LevelID " +
                                                    ",[CourseID]  = @CourseID " +
                                                    ",[FacultyID] = @FacultyID " +
                                                    ",[DegreeID] = @DegreeID " +
                                                    ",[TutorID] = @TutorID " +
                                                    ",[YearID] = @YearID " +
                                                    ",[Status] = @Status " +
                                                    ",[SPRCode] = @SPRCode " +
                                                    ",[OtherEmail] = @OtherEmail " +
                                                    "WHERE  [StudentNumber] = @StudentNumber AND [UniEmail] = @UniEmail ";
                            string insertQuery = " IF(@@ROWCOUNT = 0) BEGIN " +
                                                 " INSERT INTO [Student_Mailer].[dbo].[StudentData] " +
                                                         " ([StudentNumber] " +
                                                         " ,[UniEmail] " +
                                                         " ,[StudentName] " +
                                                         " ,[Initial] " +
                                                         " ,[LevelID] " +
                                                         " ,[CourseID] " +
                                                         " ,[FacultyID] " +
                                                         " ,[DegreeID] " +
                                                         " ,[TutorID] " +
                                                         " ,[YearID] " +
                                                         " ,[Status] " +
                                                         " ,[SPRCode] " +
                                                         " ,[OtherEmail]) " +
                                                         "  VALUES ( " +
                                                         "  @StudentNumber " +
                                                         " ,@UniEmail  " +
                                                         " ,@StudentName " +
                                                         " ,@Initial " +
                                                         " ,@LevelID " +
                                                         " ,@CourseID " +
                                                         " ,@FacultyID " +
                                                         " ,@DegreeID  " +
                                                         " ,@TutorID " +
                                                         " ,@YearID  " +
                                                         " ,@Status " +
                                                         " ,@SPRCode " +
                                                         " ,@OtherEmail )" +
                                                         "END ";
                            sqlCommand.CommandText = updateQuery + " " + insertQuery;
                            //Add paramters and assign values
                            if (_studentData.StudentNumber == null)
                            {
                                sqlCommand.Parameters.Add("@StudentNumber", SqlDbType.NVarChar, 50).Value = "N/A";
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@StudentNumber", SqlDbType.NVarChar, 50).Value = _studentData.StudentNumber;
                            }
                            if (_studentData.UniEmail == null)
                            {
                                sqlCommand.Parameters.Add("@UniEmail", SqlDbType.NVarChar, 50).Value = "N/A";
                            }
                            else
                            {
                            sqlCommand.Parameters.Add("@UniEmail", SqlDbType.NVarChar, 50).Value = _studentData.UniEmail;
                            }
                            if (_studentData.StudentName == null)
                            {
                                sqlCommand.Parameters.Add("@StudentName", SqlDbType.NVarChar, 50).Value = "N/A";
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@StudentName", SqlDbType.NVarChar, 50).Value = _studentData.StudentName;
                            }
                            if (_studentData.Initial == null)
                            {
                                sqlCommand.Parameters.Add("@Initial", SqlDbType.NVarChar, 50).Value = "N/A";
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@Initial", SqlDbType.NVarChar, 50).Value = _studentData.Initial;
                            }
                            if (_studentData.Level == null)
                            {
                                sqlCommand.Parameters.Add("@LevelID", SqlDbType.SmallInt, 50).Value = 0;
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@LevelID", SqlDbType.SmallInt, 50).Value = this.GetLevelID(Convert.ToString(_studentData.Level));
                            }
                            if (_studentData.Faculty == null)
                            {
                                sqlCommand.Parameters.Add("@CourseID", SqlDbType.Int, 50).Value = 0;
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@CourseID", SqlDbType.Int, 50).Value = this.GetCourseID(_studentData.CourseCode);
                            }
                            if (_studentData.Faculty == null)
                            {
                                sqlCommand.Parameters.Add("@FacultyID", SqlDbType.Int).Value = 0;
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@FacultyID", SqlDbType.Int).Value = this.GetFacultyID(_studentData.Faculty);
                            }
                            if (_studentData.DegreeCode == null)
                            {
                                sqlCommand.Parameters.Add("@DegreeID", SqlDbType.Int).Value = 0;
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@DegreeID", SqlDbType.Int).Value = this.GetDegreeID(_studentData.DegreeCode);
                            }
                            if (_studentData.TutorCode == null)
                            {
                                sqlCommand.Parameters.Add("@TutorID", SqlDbType.Int).Value = 0;
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@TutorID", SqlDbType.Int).Value = this.GetTutorID(_studentData.TutorCode);
                            }
                           
                            if (_studentData.Year == null)
                            {
                                sqlCommand.Parameters.Add("@YearID", SqlDbType.SmallInt).Value = 0;
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@YearID", SqlDbType.SmallInt).Value = this.GetYearID(_studentData.Year);
                            }
                           
                            if (_studentData.Status == null)
                            {
                                sqlCommand.Parameters.Add("@Status", SqlDbType.NVarChar, 4).Value = "N/A";
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@Status", SqlDbType.NVarChar, 4).Value = _studentData.Status;
                            }
                            if (_studentData.SPRCode == null)
                            {
                                sqlCommand.Parameters.Add("@SPRCode", SqlDbType.NVarChar, 20).Value = "N/A";
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@SPRCode", SqlDbType.NVarChar, 20).Value = _studentData.SPRCode;
                            }
                            if (_studentData.ContactEmail == null)
                            {
                                sqlCommand.Parameters.Add("@OtherEmail", SqlDbType.NVarChar, 50).Value = "N/A";
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@OtherEmail", SqlDbType.NVarChar, 50).Value = _studentData.ContactEmail;
                            }
                            sqlConnection.Open();
                            sqlCommand.ExecuteNonQuery();
                            sqlConnection.Close();
                        }
                    }
            }
            catch (Exception ex)
            {
                //catch exception
                throw new InvalidDataException(ex.ToString());
            }

        }

        public void UpsertStudentModule(StudentData _studentData)
        {
            try
            {
                if (_connectionString != null)
                    using (SqlConnection sqlConnection = new SqlConnection(_connectionString))
                    {
                        if (sqlConnection == null)
                        {
                            ///"Sql Connection Failed")
                        }
                        else
                        {
                            SqlCommand sqlCommand = sqlConnection.CreateCommand();
                            sqlCommand.Connection = sqlConnection;
                            sqlCommand.CommandTimeout.Equals(60000);
                            sqlCommand.CommandType = CommandType.Text;
                            string updateQuery = "Update [Student_Mailer].[dbo].[StudentModule] "
                                                    +" SET " +
                                                    " [StudentID]  = @StudentID " +
                                                    " ,[ModuleID] = @ModuleID " +
                                                    " ,[YearID] = @YearID " +
                                                    " WHERE  [StudentID] = @StudentID AND [ModuleID] = @ModuleID ";
                            string insertQuery = " IF(@@ROWCOUNT = 0) BEGIN " +
                                                 " INSERT INTO [Student_Mailer].[dbo].[StudentModule] " +
                                                          " ([StudentID] " +
                                                          " ,[ModuleID] " +
                                                          " ,[YearID] )" +
                                                         "  VALUES ( " +
                                                         "  @StudentID " +
                                                         " ,@ModuleID  " +
                                                         " ,@YearID )" + 
                                                         "END ";
                            sqlCommand.CommandText = updateQuery + " " + insertQuery;
                            //Add paramters and assign values
                            if (_studentData.StudentNumber == null)
                            {
                                sqlCommand.Parameters.Add("@StudentID", SqlDbType.SmallInt).Value = 0;
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@StudentID", SqlDbType.SmallInt).Value = this.GetStudentID(_studentData.StudentNumber);
                            }
                            if (_studentData.ModuleCode == null)
                            {
                                sqlCommand.Parameters.Add("@ModuleID", SqlDbType.SmallInt).Value = 0;
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@ModuleID", SqlDbType.SmallInt).Value = this.GetModuleID(_studentData.ModuleCode);
                            }
                            if (_studentData.Year == null)
                            {
                                sqlCommand.Parameters.Add("@YearID", SqlDbType.SmallInt).Value = 0;
                            }
                            else
                            {
                                sqlCommand.Parameters.Add("@YearID", SqlDbType.SmallInt).Value = this.GetYearID(_studentData.Year);
                            }
                            sqlConnection.Open();
                            sqlCommand.ExecuteNonQuery();
                            sqlConnection.Close();
                        }
                    }
            }
            catch (Exception ex)
            {
                //catch exception 
                throw new Exception(ex.ToString()); 
            }
        }

        public void LoadClassListFile(string CSVFile)
        {
            List<StudentData> _studentData = new List<StudentData>();
            _studentData = ParseClassListData(CSVFile, ParseCSVHeaders(CSVFile));
            int lenght = _studentData.Count;

                foreach (StudentData a in _studentData)
                {
                    UpsertStudentData(a);
                    UpsertStudentModule(a);
                    //upsertStudentModule(a);
                }
        }

        public void LoadSESFile(string CSVFile)
        {
            List<StudentData> _studentData = new List<StudentData>();
            _studentData = ParseSESData(CSVFile, ParseCSVHeaders(CSVFile));
            int lenght = _studentData.Count;
            foreach (StudentData a in _studentData)
            {
                //execute the upsert for each set of studentData 
                try
                {
                    UpsertStudentData(a);
                    UpsertStudentModule(a);
                }
                catch(Exception ex)
                {
                    throw new InvalidDataException(ex.ToString());
                }
            }
        }
        #endregion

        #region SqlHelpers
        public SqlConnection GetConnection(SqlCommand sqlCommand)
        {
            SqlConnection sqlConnection = null;
            try
            {
                sqlConnection = new SqlConnection(_connectionString);
                sqlCommand = new SqlCommand();
                if (sqlCommand != null)
                {
                    if (sqlConnection == null) //when connection is null
                    {
                       //Alert connection fil 
                    }
                    else
                    {
                        //open connection 
                        sqlConnection.Open(); //connection successfull
                        //ensure connection state is open
                        if (sqlConnection.State != ConnectionState.Open)
                        {
                            //if not dispose and attribute it to null
                            sqlConnection.Dispose();
                            sqlConnection = null;
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                sqlConnection = null;
            }
            return sqlConnection;
        } 

        public Object ExecuteSqlScalarCommand(string sqlQuery) //
        {
           if (_connectionString == null || _connectionString == "")
           {
               //connection empty
           }

                using (SqlConnection sqlConn = new SqlConnection(_connectionString))
                {
                    SqlCommand cmd = new SqlCommand();
                    Object returnValue;
                    cmd.CommandText = sqlQuery;
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = sqlConn;
                    sqlConn.Open();
                    returnValue = cmd.ExecuteScalar();
                    sqlConn.Close();
                    return returnValue;
                } 
        }

        public void ExecuteNonQuery(string sqlQuery)
        {  
            using (SqlConnection sqlConn = new SqlConnection(_connectionString))
            {  
                try
                {
                    SqlCommand cmd = new SqlCommand(); 
                    cmd.CommandText = sqlQuery; 
                    cmd.Connection = sqlConn;
                    sqlConn.Open();
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sqlQuery;
                    cmd.ExecuteNonQuery();
                    sqlConn.Close();
                }
                catch (Exception ex)
                {

                } 
            } 
        }
         
        #endregion 

        #region GetID's 
        public int GetCourseID(string CourseCode)
        {
            int CourseID=0;
            if(CourseCode == "")
            {
                return 0;
            }
            try
            {
                string sqlQuery = string.Empty;
                sqlQuery = "SELECT courseID FROM CourseLookUp WHERE CourseCode = " + "'" + CourseCode + "'"; //create sql connection 
                //execut sql command
                CourseID = Convert.ToInt32(this.ExecuteSqlScalarCommand(sqlQuery));
            }
            catch(Exception ex)
            {
                throw new InvalidDataException(ex.ToString());
            }
            return CourseID;
        }

        public int GetDegreeID(string DegreeCode)
        {
            if (DegreeCode == "")
            {
                return 0;
            }
            try
            {
                string sqlQuery = "SELECT degreeID FROM dbo.DegreeLookUp WHERE DegreeCode = " + "'" + DegreeCode + "'";
                int DegreeID = Convert.ToInt32(this.ExecuteSqlScalarCommand(sqlQuery));
                return DegreeID;
            }
            catch(Exception ex)
            {
                throw new InvalidDataException(ex.ToString());
            }
        }

        public int GetFacultyID(string FacultyName)
        {
            if (FacultyName == "")
            {
                return 0;
            }
            try
            {
                string sqlQuery = "SELECT FacultyID FROM dbo.FacultyLookUp WHERE FacultyName =  " + "'" + FacultyName + "'";
                int FacultyID = Convert.ToInt32(this.ExecuteSqlScalarCommand(sqlQuery));
                return FacultyID;
            }
            catch (Exception ex)
            {
                throw new InvalidDataException(ex.ToString());
            }
        }

        public int GetLevelID(string LevelNumber)
        {
            if (LevelNumber == "")
            {
                //emptyinput
                return 0; 
            }
            try
            {
                string sqlQuery = "SELECT LevelID FROM dbo.LevelLookUp WHERE Level = " + "'" + LevelNumber + "'";
                int LevelID = Convert.ToInt32(this.ExecuteSqlScalarCommand(sqlQuery));
                return LevelID;
            }
            catch (Exception ex)
            {
                throw new InvalidDataException(ex.ToString());
            }
        }

        public int GetTutorID(string TutorCode)
        {
            if (TutorCode == "")
            {
                return 0; 
            }
            try
            {
                string sqlQuery = "SELECT TutorID FROM dbo.TutorLookUp WHERE tutorCode = " + "'" + TutorCode + "'";
                int TutorID = Convert.ToInt32(this.ExecuteSqlScalarCommand(sqlQuery));
                return TutorID;
            }
            catch (Exception ex)
            {
                throw new InvalidDataException(ex.ToString());
            }
        }

        public int GetYearID(string Year)
        {
            if (Year == "")
            {
            }
            try
            {
                string sqlQuery = "Select yearID FROM dbo.YearLookUp WHERE yearName = " + "'" + Year + "'";
                int yearID = Convert.ToInt32(this.ExecuteSqlScalarCommand(sqlQuery));
                return yearID;
            }
            catch (Exception ex)
            {
                throw new InvalidDataException(ex.ToString());
            }
        }

        public int GetStudentID(string StudentNumber)
        {
            if (StudentNumber == "")
            {
                return 0;
            }
            try
            {
                string sqlQuery = "Select StudentID FROM dbo.StudentData WHERE StudentNumber = " + "'" + StudentNumber + "'";
                int StudentID = Convert.ToInt32(this.ExecuteSqlScalarCommand(sqlQuery));
                return StudentID;
            }
            catch (Exception ex)
            {
                throw new InvalidDataException(ex.ToString());
            }
        }

        public int GetModuleID(string ModuleCode)
        {
            if (ModuleCode == "")
            {
            }
            try
            {
                string sqlQuery = "Select DISTINCT ModuleID FROM dbo.ModuleLookUp WHERE ModuleCode = " + "'" + ModuleCode + "'";
                int ModuleID = Convert.ToInt32(this.ExecuteSqlScalarCommand(sqlQuery));
                return ModuleID;
            }
            catch (Exception ex)
            {
                throw new InvalidDataException(ex.ToString());
            }
        }

        #endregion 
    }
}