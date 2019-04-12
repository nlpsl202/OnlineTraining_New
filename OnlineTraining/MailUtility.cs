using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace OnlineTraining
{
    public class MailUtility
    {
        #region 寄信相關

        public static void SendEmail()
        {
            try
            {
                // 取得寄信範本檔的實體路徑
                string path = HttpContext.Current.Server.MapPath("~/App_Data/mail.txt");
                var template = File.ReadAllText(path);
                PasswordNotify passNotify = new PasswordNotify(template);

                passNotify.System = "哈哈論壇";
                passNotify.Account = "哈妮小姐";
                passNotify.ResetPassword = "111122233";
                passNotify.ResetUrl = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpRuntime.AppDomainAppVirtualPath + @"/IndexPages.aspx";  //IndexPages.aspx是自己設計的首頁~如果名稱不同要記得修改這個~


                passNotify.Subject = "密碼重設通知"; //寄信的信件主題
                passNotify.SenderEmail = "jeff.peng@avtech.com.tw"; //寄信者的email,要填真的
                passNotify.ReceiverEmail = "qsc5367899@gmail.com"; //這裡輸入哈妮小姐的email

                passNotify.Host = "192.168.1.249"; //請設定自己或公司的IP
                passNotify.SendEmail();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion
    }

    public class ResetPwdEmailTemplateModel
    {
        public string System { get; set; }
        public string Account { get; set; }
        public string ResetPassword { get; set; }
        public string ResetURL { get; set; }
        public DateTime Date { get; set; }

        public string DeleteComment { get; set; }
    }

    public class EmailTemplateEngine<T>
    {
        private readonly T _templateModel;
        private readonly string _templateContent;

        public EmailTemplateEngine(T templateModel, string templateContent)
        {
            _templateModel = templateModel;
            _templateContent = templateContent;
        }

        /// <summary>
        /// Renders the template.
        /// </summary>
        /// <returns></returns>
        public string Render()
        {
            IEnumerable<KeyValuePair<string, object>> modelProperties = GatherModelPropertiesAndValues();
            var output = LoadTemplate();

            foreach (var modelProperty in modelProperties)
            {
                output = output.Replace("<<" + modelProperty.Key + ">>", ObjectToString(modelProperty.Value));
            }

            return output;
        }

        /// <summary>
        /// Loads the template.
        /// </summary>
        /// <returns></returns>
        private string LoadTemplate()
        {
            return _templateContent;// File.ReadAllText(_templateFilePath);
        }

        /// <summary>
        /// Converts the objects to a string.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        private static string ObjectToString(object value)
        {
            if (value == null)
                return string.Empty;

            if (value.GetType() == typeof(string))
                return (string)value;

            if (value.GetType() == typeof(DateTime))
            {
                // Add formatting here at some point
                DateTime dateTime = (DateTime)value;
                return dateTime.ToString();
            }

            return value.ToString();
        }

        /// <summary>
        /// Gathers the model properties and values into a dictionary
        /// </summary>
        /// <returns></returns>
        private IEnumerable<KeyValuePair<string, object>> GatherModelPropertiesAndValues()
        {
            IDictionary<string, object> properties = new Dictionary<string, object>();
            foreach (PropertyInfo propertyInfo in _templateModel.GetType().GetProperties())
            {
                string name = propertyInfo.Name;
                object value = propertyInfo.GetValue(_templateModel, null);

                properties.Add(name, value);
            }

            return properties;
        }
    }

    public class PasswordNotify
    {
        private string _output;


        private string _system;

        private string _senderEmail;
        private string _receiverEmail;
        private string _account;
        private string _resetPassword;
        private string _subject;
        private string _resetUrl;
        private ResetPwdEmailTemplateModel _model;
        private string _template;
        private string _host;

        private string _deleteComment;

        public string Host
        {
            get { return _host; }
            set { _host = value; }
        }

        public string Output
        {
            get { return _output; }
        }
        public string System
        {
            get { return _system; }
            set { _system = value; }
        }
        public string SenderEmail
        {
            get { return _senderEmail; }
            set { _senderEmail = value; }
        }

        public string ReceiverEmail
        {
            get { return _receiverEmail; }
            set { _receiverEmail = value; }
        }

        public string Account
        {
            get { return _account; }
            set { _account = value; }
        }


        public string ResetPassword
        {
            get { return _resetPassword; }
            set { _resetPassword = value; }
        }


        public string Subject
        {
            get { return _subject; }
            set { _subject = value; }
        }


        public string ResetUrl
        {
            get { return _resetUrl; }
            set { _resetUrl = value; }
        }

        public string DeleteComment
        {
            get { return _deleteComment; }
            set { _deleteComment = value; }
        }

        public PasswordNotify(string template)
        {
            _model = new ResetPwdEmailTemplateModel { Date = DateTime.Now };
            _template = template;

            // model

        }

        public int SendEmail()
        {
            int rtn = 0;
            EmailTemplateEngine<ResetPwdEmailTemplateModel> templateEngine
                                            = new EmailTemplateEngine<ResetPwdEmailTemplateModel>(_model, _template);
            _model.Account = _account;
            _model.ResetPassword = _resetPassword;
            _model.ResetURL = _resetUrl;
            _model.DeleteComment = _deleteComment;  //刪文時的內容
            _model.System = _system;
            _output = templateEngine.Render();
            rtn = InternalSendEmail();

            return rtn;
        }

        private int InternalSendEmail()
        {
            int rtn = 0;
            MailAddress to = new MailAddress(_receiverEmail);
            MailAddress from = new MailAddress(_senderEmail);
            MailMessage message = new MailMessage(from, to);
            message.Subject = _subject;

            message.Body = _output;
            // Use the application or machine configuration to get the 
            // host, port, and credentials.
            SmtpClient client = new SmtpClient();

            client.Host = _host;

            try
            {
                client.Send(message);
            }
            catch (Exception ex)
            {
                rtn = 999;
                throw ex;
            }

            return rtn;
        }
    }
}