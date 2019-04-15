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
    public class ExamInfo
    {
        public string ExamID { get; set; }
        public string ExamName { get; set; }
        public string ExamPaperName { get; set; }
        public string ExamTotalScore { get; set; }
        public string ExamPassScore { get; set; }
        public string ExamTime { get; set; }
        public string ExamCount { get; set; }
    }

    public partial class Exam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetExamInfo()
        {
            ExamInfo examInfo = new ExamInfo();
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_Exam";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = HttpContext.Current.Session["ClassNo"].ToString();
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                HttpContext.Current.Session["ExamID"] = dt.Rows[0]["ExamID"].ToString();
                examInfo.ExamID = dt.Rows[0]["ExamID"].ToString();
                examInfo.ExamName = dt.Rows[0]["ExamName"].ToString();
                examInfo.ExamPaperName = dt.Rows[0]["ExamPaperName"].ToString();
                examInfo.ExamTotalScore = dt.Rows[0]["ExamTotalScore"].ToString();
                examInfo.ExamPassScore = dt.Rows[0]["ExamPassScore"].ToString();
                examInfo.ExamTime = dt.Rows[0]["ExamTime"].ToString();
                examInfo.ExamCount = dt.Rows[0]["ExamCount"].ToString();
                int time = Convert.ToInt32(dt.Rows[0]["ExamTimeInt"]) * 60;
                HttpContext.Current.Session["ExamTimeInt"] = Convert.ToInt32(dt.Rows[0]["ExamTimeInt"]);
                HttpContext.Current.Session["ExamTime"] = (time / 3600).ToString("00") + ":" + (time % 3600 / 60).ToString("00") + ":" + (time % 3600 % 60).ToString("00");
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
    }
}