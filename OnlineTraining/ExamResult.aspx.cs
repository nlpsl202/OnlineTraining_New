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
    /*public class ExamResultInfo
    {
        public string ExamName { get; set; }
        public string ExamPaperName { get; set; }
        public string ExamFinishTime { get; set; }
        public string ExamTime { get; set; }
        public string ExamScore { get; set; }
        public string Pass { get; set; }
    }*/

    public partial class ExamResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /*[WebMethod]
        public static string GetExamResultInfo()
        {
            ExamResultInfo examInfo = new ExamResultInfo();
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberExam";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = HttpContext.Current.Session["ClassNo"].ToString();
            sqlObj.SqlCmd.Parameters["@ExamID"].Value = HttpContext.Current.Session["ExamID"].ToString();
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 1;
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                examInfo.ExamName = dt.Rows[0]["ExamName"].ToString();
                examInfo.ExamPaperName = dt.Rows[0]["ExamPaperName"].ToString();
                examInfo.ExamFinishTime = dt.Rows[0]["ExamFinishTime"].ToString();
                examInfo.ExamTime = dt.Rows[0]["ExamTime"].ToString();
                examInfo.ExamScore = dt.Rows[0]["ExamScore"].ToString();
                examInfo.Pass = dt.Rows[0]["Pass"].ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            return new JavaScriptSerializer().Serialize(examInfo);
        }

        [WebMethod]
        public static string GetExamResultAnswer()
        {
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberExam";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = HttpContext.Current.Session["ClassNo"].ToString();
            sqlObj.SqlCmd.Parameters["@ExamID"].Value = HttpContext.Current.Session["ExamID"].ToString();
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 2;
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            return dt.Rows[0]["MemberAnswers"].ToString();
        }*/
    }
}