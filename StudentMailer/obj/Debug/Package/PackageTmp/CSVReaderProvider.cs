using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LumenWorks.Framework.IO.Csv;
using System.IO;
using System.Data.SqlClient;
using System.Text;

namespace StudentMailer
{
    public class CSVReaderProvider :EventArgs 
    {
        //private readonly string _connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Student_Mailer"].ConnectionString;; //connection string 
        #region Protected Method

        protected static bool ValidateFieldHeader(string[] headers, int fieldNumber, string expecting, bool isRequiredField)
        {

            if ((fieldNumber >= headers.Length || headers[fieldNumber] == "") && !isRequiredField) return false;

            if (fieldNumber >= headers.Length)
            {
                throw new InvalidDataException(string.Format("Field {0}: Expecting '{1}' - field number {0} > header field count",
                                                                       fieldNumber, expecting));
            }

            if (headers[fieldNumber] != expecting)
            {
                throw new InvalidDataException(string.Format("Field {0}: Expecting '{1}' found '{2}'", fieldNumber, expecting, headers[fieldNumber]));
            }

            return true;


        }

        ///// <summary>
        ///// Returns a CSVReader Object of given csv file, input = csv file, output = CSVReader Object  
        ///// </summary>
        public CsvReader ParseCSVReader(string fileName)
        {
            try
            {
                if (fileName == null || fileName == "")
                {
                    throw new InvalidDataException("Missing File");
                }
                CsvReader csvReader = new CsvReader(new StreamReader(fileName), true);
                return csvReader;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
        }

        ///// <summary>
        //// Returns all headers in csvfile
        ///// </summary>
        public string[] ParseCSVHeaders(String FileName)
        {
            try
            {
                CsvReader csvReader = this.ParseCSVReader(FileName);
                string[] h = csvReader.GetFieldHeaders();
                string[] hearders = h[0].Split('|');
                return hearders;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
        }

        ///// <summary>
        ////  Read ClassList cvs file and returns a list of studentData object 
        ///// </summary>
        public List<StudentData> ParseClassListData(string CSVFile, string[] Headers)
        {
            //validate field names, throw exception if field name mismatched
            ValidateFieldHeader(Headers, 0, "Year", true);
            ValidateFieldHeader(Headers, 1, "Module code", true);
            ValidateFieldHeader(Headers, 2, "Module name", true);
            ValidateFieldHeader(Headers, 3, "Occurr", true);
            ValidateFieldHeader(Headers, 4, "SPR code", true);
            ValidateFieldHeader(Headers, 5, "Surname", true);
            ValidateFieldHeader(Headers, 6, "First name", true);
            ValidateFieldHeader(Headers, 7, "Initials", true);
            ValidateFieldHeader(Headers, 8, "Degree code", true);
            ValidateFieldHeader(Headers, 9, "Level", true);
            ValidateFieldHeader(Headers, 10, "Programme code", true);
            ValidateFieldHeader(Headers, 11, "Programme name", true);
            ValidateFieldHeader(Headers, 12, "Status", true);
            ValidateFieldHeader(Headers, 13, "Faculty", true);
            ValidateFieldHeader(Headers, 14, "Tutor code", true);
            ValidateFieldHeader(Headers, 15, "Tutor name", true);
            ValidateFieldHeader(Headers, 16, "Univ e-mail", true);
            try
            {

                //get csvReader object 
                CsvReader csvReader = this.ParseCSVReader(CSVFile);
                string[] studentDataRecord;
                List<StudentData> _studentDataList = new List<StudentData>();
                while (csvReader.ReadNextRecord())
                {
                    string studentData = csvReader[0];
                    studentDataRecord = studentData.Split('|');
                    StudentData _studentData = new StudentData();
                    if (studentDataRecord.Count() == 17)
                    {
                        _studentData.StudentNumber = Convert.ToString(studentDataRecord[4].Substring(0, studentDataRecord[4].Length - 2));
                        _studentData.UniEmail = Convert.ToString(studentDataRecord[16]); 
                       _studentData.StudentName = Convert.ToString(studentDataRecord[5]) + " " + Convert.ToString(studentDataRecord[6]); 
                       _studentData.Initial = Convert.ToString(studentDataRecord[7]); 
                       _studentData.Year = Convert.ToString(studentDataRecord[0]); 
                       _studentData.ModuleCode = Convert.ToString(studentDataRecord[1]); 
                       _studentData.ModuleName = Convert.ToString(studentDataRecord[2]); 
                       _studentData.Occur = Convert.ToString(studentDataRecord[3]); 
                       _studentData.SPRCode = Convert.ToString(studentDataRecord[4]); 
                       _studentData.DegreeCode = Convert.ToString(studentDataRecord[8]); 
                       _studentData.Level = Convert.ToString(studentDataRecord[9]); 
                       _studentData.CourseCode = Convert.ToString(studentDataRecord[10]); 
                       _studentData.CourseName = Convert.ToString(studentDataRecord[11]); 
                       _studentData.Status = Convert.ToString(studentDataRecord[12]); 
                       _studentData.Faculty = Convert.ToString(studentDataRecord[13]); 
                       _studentData.TutorCode = Convert.ToString(studentDataRecord[14]); 
                       _studentData.TutorName = Convert.ToString(studentDataRecord[15]); 
                    }
                    //add current studentData record to list 
                    _studentDataList.Add(_studentData);
                }
                return _studentDataList;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString()); 
            }
        }

        ///// <summary>
        ////  Read SES cvs file and returns a list of studentData object 
        ///// </summary>                                                                                                                             
        public List<StudentData> ParseSESData(string CSVFile, string[] Headers)
        {
            //Validate csv headers files
            ValidateFieldHeader(Headers, 0, "Stu no", true);
            ValidateFieldHeader(Headers, 1, "Name", true);
            ValidateFieldHeader(Headers, 2, "Course", true);
            ValidateFieldHeader(Headers, 3, "SCJ status", true);
            ValidateFieldHeader(Headers, 4, "contact email address", true);
            ValidateFieldHeader(Headers, 5, "Uni email address", true);
            ValidateFieldHeader(Headers, 6, "Programme code", true);
            ValidateFieldHeader(Headers, 7, "Course code", true);
            //get csvReader object
            try
            {
                CsvReader csvReader = new CsvReader(new StreamReader(CSVFile), true);
                string[] studentDataRecord;
                int StuNumberIndex = csvReader.GetFieldIndex("Stu no");
                int NameIndex = csvReader.GetFieldIndex("Name");
                int CourseIndex = csvReader.GetFieldIndex("Course");
                int SCJStatusIndex = csvReader.GetFieldIndex("SCJ status");
                int ContactEmailAddressIndex = csvReader.GetFieldIndex("contact email address");
                int UniEmailIndex = csvReader.GetFieldIndex("Uni email address");
                int ProgrammeCodeIndex = csvReader.GetFieldIndex("Programme code");
                int CourseCodeIndex = csvReader.GetFieldIndex("Course code");
                List<StudentData> _studentDataList = new List<StudentData>();

                while (csvReader.ReadNextRecord())
                {
                         string studentData = csvReader[0];
                         studentDataRecord = studentData.Split('|');
                         StudentData _studentData = new StudentData();
                        _studentData.StudentName = Convert.ToString(studentDataRecord[1]);
                        _studentData.Initial = Convert.ToString(studentDataRecord[1].Substring(0, 1));
                        _studentData.StudentNumber = Convert.ToString(studentDataRecord[0]); //Derive student number from SPR Code
                        _studentData.UniEmail = Convert.ToString(studentDataRecord[5]);
                        _studentData.DegreeCode = Convert.ToString(studentDataRecord[6]);
                        _studentData.CourseCode = Convert.ToString(studentDataRecord[7]);
                        _studentData.Status = Convert.ToString(studentDataRecord[3]);

                        //add current studentData record to list 
                        _studentDataList.Add(_studentData);
                }

                return _studentDataList;
            }
            catch(Exception ex)
            {
                throw new Exception(ex.ToString());
            }
        }

        #endregion 

    }
}