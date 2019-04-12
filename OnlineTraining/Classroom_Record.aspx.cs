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
    public partial class Classroom_Record : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class RecordInfo
        {
            public string ExamName { get; set; }
            public string ExamScore { get; set; }
            public string ExamPassScore { get; set; }
            public string ClassPass { get; set; }
            public string ExamFinishTime { get; set; }
            public string ChapterName { get; set; }
            public string ReadTime { get; set; }
            public string PassCondition { get; set; }
            public string ChapterPass { get; set; }
            public string LastReadTime { get; set; }
            public string TotalReadTime { get; set; }
        }

        [WebMethod]
        public static string GetRecordInfo()
        {
            List<RecordInfo> recordInfos = new List<RecordInfo>();
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_ClassRecord";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = HttpContext.Current.Session["ClassNo"].ToString();
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    recordInfos.Add(new RecordInfo
                    {
                        ExamName = dt.Rows[i]["ExamName"].ToString(),
                        ExamScore = dt.Rows[i]["ExamScore"].ToString(),
                        ExamPassScore = dt.Rows[i]["ExamPassScore"].ToString(),
                        ClassPass = dt.Rows[i]["ClassPass"].ToString(),
                        ExamFinishTime = dt.Rows[i]["ExamFinishTime"].ToString(),
                        ChapterName = dt.Rows[i]["ChapterName"].ToString(),
                        ReadTime = dt.Rows[i]["ReadTime"].ToString(),
                        PassCondition = dt.Rows[i]["PassCondition"].ToString(),
                        ChapterPass = dt.Rows[i]["ChapterPass"].ToString(),
                        LastReadTime = dt.Rows[i]["LastReadTime"].ToString(),
                        TotalReadTime = dt.Rows[i]["TotalReadTime"].ToString()
                    });
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            return new JavaScriptSerializer().Serialize(recordInfos);
        }
    }
}