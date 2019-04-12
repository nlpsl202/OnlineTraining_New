using System;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web;
using System.Web.Services;
using System.Web.UI;


namespace OnlineTraining
{
    public partial class ClassVideo : System.Web.UI.Page
    {
        public static Stopwatch sw;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                sw = new Stopwatch();
                sw.Start();
            }
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            Label1.Text = sw.Elapsed.Hours.ToString("00") + ":" + sw.Elapsed.Minutes.ToString("00") + ":" + sw.Elapsed.Seconds.ToString("00");
        }

        [WebMethod]
        public static string ExitVideo(string ReadTime)
        {
            string sErrMsg = string.Empty;
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_UI_MemberStudyRecord";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = HttpContext.Current.Session["ClassNo"].ToString();
            sqlObj.SqlCmd.Parameters["@ChapterNo"].Value = HttpContext.Current.Session["ChapterNo"].ToString();
            sqlObj.SqlCmd.Parameters["@ReadTime"].Value = ReadTime;
            sqlObj.SqlCmd.Parameters["@ReturnMsg"].Value = DBNull.Value;
            try
            {
                sqlObj.SqlConn.Open();
                sqlObj.SqlCmd.ExecuteNonQuery();
                sErrMsg = sqlObj.SqlCmd.Parameters["@ReturnMsg"].Value.ToString();
                return "success";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
        }
    }
}