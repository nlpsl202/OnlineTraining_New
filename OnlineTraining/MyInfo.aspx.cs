using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTraining
{
    public partial class MyInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string ChangePassword(string OldPassword, string NewPassword)
        {
            DBUtility sqlObj = null;
            string sErrMsg = string.Empty;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_UI_Member";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@Password"].Value = OldPassword;
            sqlObj.SqlCmd.Parameters["@NewPassword"].Value = NewPassword;
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 1;
            sqlObj.SqlCmd.Parameters["@ReturnMsg"].Value = DBNull.Value;
            try
            {
                sqlObj.SqlConn.Open();
                sqlObj.SqlCmd.ExecuteNonQuery();
                sErrMsg = sqlObj.SqlCmd.Parameters["@ReturnMsg"].Value.ToString();
            }
            catch (Exception ex)
            {
                sErrMsg = ex.Message;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            if (sErrMsg.IndexOf("成功") >= 0)
            {
                sErrMsg = "變更密碼成功!";
            }
            else if (sErrMsg.IndexOf("失敗") >= 0)
            {
                sErrMsg = "舊密碼錯誤!";
            }
            return sErrMsg;
        }
    }
}