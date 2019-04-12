using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTraining
{
    public partial class MemberOpinion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string InsertToOpinion(string Body)
        {
            DBUtility sqlObj = null;
            string sErrMsg = string.Empty;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_UI_Opinion";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@Body"].Value = Body;
            try
            {
                sqlObj.SqlConn.Open();
                sqlObj.SqlCmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                sErrMsg = ex.Message;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            return sErrMsg;
        }
    }
}