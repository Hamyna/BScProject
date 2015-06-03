using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration; 

namespace StudentMailer
{
    public class AppConfiguration
    {
        public static string FromAddress
        {
            get
            {
                string result = WebConfigurationManager.AppSettings.Get("fromAddress");
                if (!string.IsNullOrEmpty(result))
                {       
                    return result;
                }
                throw new Exception("AppSetting FromAddress not found in web.confiq file.");
            }
        }

        public static string FromName
        {
            get
            {
                string result = WebConfigurationManager.AppSettings.Get("fromName");
                if (!string.IsNullOrEmpty(result))
                {
                    return result;
                }
                throw new Exception("AppSetting FromName not found in web.confiq file.");
            }
        }
        public static string ToAddress
        {
            get
            {
                string result = WebConfigurationManager.AppSettings.Get("toAddress");
                if (!string.IsNullOrEmpty(result))
                {
                    return result;
                }
                throw new Exception("AppSetting toAddress not found in web.confiq file.");
            }
        }
        public static string ToName
        {
            get
            {
                string result = WebConfigurationManager.AppSettings.Get("ToName");
                if (!string.IsNullOrEmpty(result))
                {
                    return result;
                }
                throw new Exception("AppSetting toName not found in web.confiq file.");
            }
        }

       /* public static bool SendMailOnError
        {
            get
            {
                string result = WebConfigurationManager.AppSettings.Get("SendMailOnError");
                if (!string.IsNullOrEmpty(result))
                {
                    return Convert.ToBoolean(result);
                }
                throw new Exception("AppSetting SendMailOnError not Found in the web.config file.");
            }
        }
        */ 
    }
}