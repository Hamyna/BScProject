using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using System.DirectoryServices;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Configuration;
using System.IO;
using System.Web.UI; 
using System.Text;  

namespace StudentMailer
{   
    public class ActiveDirectoryHelper
    { 

         #region 
         public string GetAppSettingKeyValue(string key)
         { 
             
// string virtualPath = "C:\\StudentMailer 2.1.1";
             System.Configuration.Configuration rootWebConfig1 = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(null);
             if (rootWebConfig1.AppSettings.Settings.Count > 0) 
             {
                 System.Configuration.KeyValueConfigurationElement customSetting = rootWebConfig1.AppSettings.Settings[key];
                 if (customSetting != null) return customSetting.Value;
             }
             return null; 
         }

         private string GetDirPW()
         {
             string value = "adewale1";
             if (value != null) return value;
             else throw new InvalidDataException(string.Format("Null Value Thrown"));
         }

         private string GetDirUN()
         {
             string value = "bs023857";
             if (value != null) return value;
             else throw new InvalidDataException(string.Format("Null Value Thrown"));
         }

         private string GetDirEntryPath()
         {
             string value = "vidc5.rdg-home.ad.rdg.ac.uk";
             if (value != null) return value;
             else throw new InvalidDataException(string.Format("Null Value Thrown"));
         }

         private string GetStaffDirPath()
         {
             string value = "LDAP://CN=SSEstaff,OU=School of Systems Engineering,OU=UserAccounts,DC=rdg-home,DC=ad,DC=rdg,DC=ac,DC=uk";
             if (value != null) return value;
             else throw new InvalidDataException(string.Format("Null Value Thrown"));
         }

         private string GetOperatorDirPath()
         {
             string value = "LDAP://CN=Operator,OU=Student Mailer,OU=School of Systems Engineering,OU=UserAccounts,DC=rdg-home,DC=ad,DC=rdg,DC=ac,DC=uk";
             if (value != null) return value;
             else throw new InvalidDataException(string.Format("Null Value Thrown"));
         }

         private string GetAdminDirPath()
         {
             string value = "LDAP://CN=Admin,OU=Student Mailer,OU=School of Systems Engineering,OU=UserAccounts,DC=rdg-home,DC=ad,DC=rdg,DC=ac,DC=uk";
             if (value != null) return value;
             else throw new InvalidDataException(string.Format("Null Value Thrown"));
         }
         #endregion 

         //method returns all active directory roles. 
        public ArrayList getActiveDirectoryRoles()
        {
            ArrayList groups = new ArrayList();
            foreach (System.Security.Principal.IdentityReference group in System.Web.HttpContext.Current.Request.LogonUserIdentity.Groups)
            {
                groups.Add(group.Translate(typeof
                    (System.Security.Principal.NTAccount)).ToString());
            }
            return groups;
        }

        //public method return a list of staff users detail i.e List<UserObject> 
        public List<UserObject> GetStaffUser(int value)
        {
            List<UserObject> UserList = new List<UserObject>();
            char[] delimiter = new char[] { ',' };
            if (value == 1)
            { 
                DirectoryEntry deGroup = new DirectoryEntry(this.GetDirEntryPath(),this.GetDirUN(),this.GetDirPW());
                deGroup.Path = this.GetStaffDirPath(); 
                foreach (object oMember in deGroup.Properties["Member"])
                {
                    int iLocation = (oMember.ToString()).IndexOf("OU=");
                    if (iLocation > 0) //if location greater than zero, futher drill to get users
                    {
                        DirectoryEntry de = new DirectoryEntry(this.GetDirEntryPath(), this.GetDirUN(), this.GetDirPW()); ;
                        de.Path = "LDAP://" + oMember.ToString();
                        foreach (object w in de.Properties["Member"])
                        {
                            //List<String> lst_userInoformation = new List<String>();
                            UserObject userObject = new UserObject();
                            DirectoryEntry de_user = new DirectoryEntry(this.GetDirEntryPath(), this.GetDirUN(), this.GetDirPW());
                            de_user.Path = "LDAP://" + w.ToString();
                            foreach (object fullName in de_user.Properties["displayName"])
                            {
                                //lst_userInoformation.Add(s1.ToString());
                                userObject.FullName = fullName.ToString();
                            }
                            foreach (object userName in de_user.Properties["title"])
                            {
                                //lst_userInoformation.Add(s2.ToString());
                                userObject.UserName = userName.ToString().ToUpper();
                            }
                            foreach (object email in de_user.Properties["mail"])
                            {
                                //lst_userInoformation.Add(email.ToString());
                                userObject.Email = email.ToString();
                                int index = email.ToString().IndexOf("@");
                                userObject.UserName = email.ToString().Substring(0, index).ToUpper();
                            }
                            UserList.Add(userObject);
                        }
                    }
                    else
                    {
                        //List<String> lst_userInoformation = new List<String>();
                        UserObject userObject = new UserObject();
                        DirectoryEntry de_user = new DirectoryEntry(this.GetDirEntryPath(), this.GetDirUN(), this.GetDirPW());
                        de_user.Path = "LDAP://" + oMember.ToString();
                        foreach (object commonName in de_user.Properties["cn"])
                        {//lst_userInoformation.Add(s1.ToString());
                            userObject.UserName = commonName.ToString().ToUpper();

                        }
                        foreach (object displayName in de_user.Properties["displayName"])
                        {
                            userObject.FullName = displayName.ToString();
                            //lst_userInoformation.Add(displayName.ToString());
                        }
                        foreach (object email in de_user.Properties["mail"])
                        {
                            userObject.Email = email.ToString();
                            //lst_userInoformation.Add(email.ToString());
                        }
                        UserList.Add(userObject);
                    }
                }
            }
            return UserList;
        }

        //public method return a list of Admin users detail i.e List<UserObject> 
        public List<UserObject> GetAdminUser(DropDownList Groups_dropdownlist)
        {
            char[] delimiter = new char[] { ',' };
            List<UserObject> UserList = new List<UserObject>();
            if (Convert.ToInt32(Groups_dropdownlist.SelectedValue) == 2)
            {
                DirectoryEntry deGroup = new DirectoryEntry(this.GetDirEntryPath(), this.GetDirUN(), this.GetDirPW()); ;
                deGroup.Path = this.GetAdminDirPath();
                foreach (object oMember in deGroup.Properties["Member"])
                {
                    DirectoryEntry de_user = new DirectoryEntry(this.GetDirEntryPath(), this.GetDirUN(), this.GetDirPW()); ;
                    de_user.Path = "LDAP://" + oMember.ToString();
                    UserObject userObject = new UserObject();
                    foreach (object commonName in de_user.Properties["cn"])
                    {
                        userObject.UserName = commonName.ToString().ToUpper();
                        userObject.Email = userObject.UserName.ToString() + "@reading.ac.uk";
                    }
                    foreach (object displayName in de_user.Properties["displayName"])
                    {
                        userObject.FullName = displayName.ToString();
                    }
                    foreach (object email in de_user.Properties["mail"])
                    {
                        userObject.Email = email.ToString();
                        string newemail = userObject.UserName.ToString() + "@reading.ac.uk";
                        userObject.Email = newemail;
                        //lst_Admin.Add(s3.ToString());
                    }
                    UserList.Add(userObject);
                }
            }
            return UserList;
        }

        //public method return a list of Operator users detail i.e List<UserObject> 
        public List<UserObject> GetOperatorUser(DropDownList Groups_dropdownlist)
        {
            char[] delimiter = new char[] { ',' };
            List<UserObject> UserList = new List<UserObject>();
            if (Convert.ToInt32(Groups_dropdownlist.SelectedValue) == 3)
            {
                DirectoryEntry deGroup = new DirectoryEntry(this.GetDirEntryPath(), this.GetDirUN(), this.GetDirPW()); 
                deGroup.Path = this.GetOperatorDirPath();
                foreach (object oMember in deGroup.Properties["Member"])
                {
                    string h = oMember.ToString();
                    string[] mystr = h.Split(delimiter);
                    //DirectoryEntry ldapConnection = new DirectoryEntry("rizzo.leeds-art.ac.uk"); ldapConnection.Path = "LDAP://OU=staffusers,DC=leeds-art,DC=ac,DC=uk"; 
                    DirectoryEntry de = new DirectoryEntry(this.GetDirEntryPath(), this.GetDirUN(), this.GetDirPW());
                    de.Path = "LDAP://" + mystr.ElementAt(0) + "," + "CN=Users,DC=rdg-home,DC=ad,DC=rdg,DC=ac,DC=uk";
                    foreach (object a in de.Properties["Member"])
                    {

                        UserObject userObject = new UserObject();
                        DirectoryEntry de1 = new DirectoryEntry(this.GetDirEntryPath(), this.GetDirUN(), this.GetDirPW());
                        de1.Path = "LDAP://" + a.ToString();
                        foreach (object commonName in de1.Properties["cn"])
                        {
                            userObject.UserName = commonName.ToString().ToUpper();
                        }
                        foreach (object displayName in de1.Properties["displayName"])
                        {
                            userObject.FullName = displayName.ToString();
                        }
                        foreach (object email in de1.Properties["mail"])
                        {
                            userObject.Email = email.ToString();
                        }
                        UserList.Add(userObject);
                    }
                }
            }
            return UserList;
        }

        //public method return a list of all users detail i.e List<UserObject> 
        public List<UserObject> GetAllUsers(DropDownList Groups_dropdownlist)
        {
            List<UserObject> _list = new List<UserObject>();
            _list.AddRange(this.GetAdminUser(Groups_dropdownlist));
            _list.AddRange(this.GetStaffUser(1));
            _list.AddRange(this.GetOperatorUser(Groups_dropdownlist));
            return _list;
        }

    }
}