using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTraining
{
    public partial class MyInfo : System.Web.UI.Page
    {
        public struct MemberInfo
        {
            public string Account { get; set; }
            public string MemberName { get; set; }
            public string CompanyName { get; set; }
            public string Title { get; set; }
            public string Email { get; set; }
            public string Phone { get; set; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetInfo()
        {
            MemberInfo memberInfo = new MemberInfo();
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberInfo";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                memberInfo.Account = dt.Rows[0]["Account"].ToString();
                memberInfo.MemberName = dt.Rows[0]["MemberName"].ToString();
                memberInfo.CompanyName = dt.Rows[0]["CompanyName"].ToString();
                memberInfo.Title = dt.Rows[0]["Title"].ToString();
                memberInfo.Email = dt.Rows[0]["Email"].ToString();
                memberInfo.Phone = dt.Rows[0]["Phone"].ToString();
            }
            catch (Exception ex)
            {
                sErrMsg = ex.Message;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            return new JavaScriptSerializer().Serialize(memberInfo);
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