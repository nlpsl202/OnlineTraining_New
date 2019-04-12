using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTraining
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        [WebMethod]
        public static string LoginCheck(string Account, string Password)
        {
            DBUtility sqlObj = null;
            string sErrMsg = string.Empty;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_Member";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = Account;
            sqlObj.SqlCmd.Parameters["@Password"].Value = Password;
            sqlObj.SqlCmd.Parameters["@ReturnName"].Value = DBNull.Value;
            sqlObj.SqlCmd.Parameters["@ReturnMsg"].Value = DBNull.Value;
            try
            {
                sqlObj.SqlConn.Open();
                sqlObj.SqlCmd.ExecuteNonQuery();
                HttpContext.Current.Session["Account"] = Account;
                HttpContext.Current.Session["MemberName"] = sqlObj.SqlCmd.Parameters["@ReturnName"].Value.ToString();
                sErrMsg = sqlObj.SqlCmd.Parameters["@ReturnMsg"].Value.ToString();
            }
            catch (Exception ex)
            {
                sErrMsg = "登入失敗:" + ex.Message;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            if (sErrMsg.IndexOf("成功") >= 0)
            {
                sErrMsg = "登入成功!";
            }
            else
            {
                sErrMsg = "帳號或密碼錯誤!";
            }
            return sErrMsg;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Button1.Text = Session["ClassNo"].ToString();
        }
    }
}