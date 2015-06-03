using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace StudentMailer
{
    public class StudentData : EventArgs
    {
        #region Property defination 

        public string StudentNumber { get;  set;}
        public string UniEmail { get;  set; }
        public string StudentName { get; set; } //concatenation of First name and last name
        public string Initial { get; set; }
        public string Year { get; set; }
        public string ModuleCode { get; set; }
        public string ModuleName { get; set; }
        public string Occur { get; set; }
        public string SPRCode { get; set; }
        public string DegreeCode { get; set; }
        public string DegreeName{get; set;} 
        public string Level { get; set; }
        public string CourseName { get; set; } //Also reffered to as Programme Name
        public string CourseCode { get; set; } //Also referred to as ProgrammeCode 
        public string Status { get; set; }
        public string Faculty { get; set; }
        public string TutorCode { get; set; }
        public string TutorName { get; set; }
        public string ContactEmail { get; set; }

        #endregion 


        public StudentData()
        { }

        public StudentData CreateNewStudentData()
        {
            return new StudentData(); 
        }

        public StudentData createStudentData(
            string studentNumber,
            string uniEmail,
            string studentName,
            string initial,
            string year,
            string moduleCode,
            string moduleName,
            string occur,
            string sprCode,
            string degreeCode, 
            string    level,
            string courseName,
            string courseCode,
            string status,
            string faculty,
            string tutorCode,
            string tutorName,
            string contactEmail
            )
        {
            return new StudentData
            {
                StudentNumber = studentNumber,
                UniEmail = uniEmail,
                StudentName = studentName,
                Initial = initial,
                Year = year,
                ModuleCode = moduleCode,
                ModuleName = moduleName,
                Occur = occur,
                SPRCode = sprCode,
                DegreeCode = degreeCode,
                Level = level,
                CourseCode = courseCode,
                Status = status,
                Faculty = faculty,
                TutorCode = tutorCode,
                TutorName = tutorName,
                ContactEmail = contactEmail
            }; 
        }


    }
}
