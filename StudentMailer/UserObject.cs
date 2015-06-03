using System;
using System.Collections.Generic;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.IO;
namespace StudentMailer
{
    public class UserObject : EventArgs
    {
        public UserObject CreaateNewUserObject()
        {
            return new UserObject();
        }
       
        public UserObject createUserObject(
            string _fullName,
            string _userName,
            string _email )
        {
        return new UserObject {
            FullName = _fullName,
            UserName = _userName,
            Email = _email,
            };
        }

        #region set get method
        public string FullName
        { get; set; }
        public string UserName
        { get; set; }
        public string Email
        { get; set; }
        #endregion 
    }
}