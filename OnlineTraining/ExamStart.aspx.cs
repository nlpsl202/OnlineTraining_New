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
    public class Question
    {
        public string QuestionNo { get; set; }
        public string QuestionName { get; set; }
        public string QuestionType { get; set; }
        public string OptionA { get; set; }
        public string OptionB { get; set; }
        public string OptionC { get; set; }
        public string OptionD { get; set; }
        public string Answer { get; set; }
    }

    public partial class ExamStart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetQuestionInfo()
        {
            List<Question> questionInfos = new List<Question>();
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_ExamQuestion";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@ExamID"].Value = HttpContext.Current.Session["ExamID"].ToString();
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    questionInfos.Add(new Question
                    {
                        QuestionNo = dt.Rows[i]["QuestionNo"].ToString(),
                        QuestionName = dt.Rows[i]["QuestionName"].ToString(),
                        QuestionType = dt.Rows[i]["QuestionType"].ToString(),
                        OptionA = dt.Rows[i]["OptionA"].ToString(),
                        OptionB = dt.Rows[i]["OptionB"].ToString(),
                        OptionC = dt.Rows[i]["OptionC"].ToString(),
                        OptionD = dt.Rows[i]["OptionD"].ToString(),
                        Answer = dt.Rows[i]["Answer"].ToString()
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
            return new JavaScriptSerializer().Serialize(questionInfos);
        }

        [WebMethod]
        public static string SubmitExam(int ExamScore,string ExamTime,string MemberAnswers)
        {
            string sErrMsg = string.Empty;
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_UI_MemberExam";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = HttpContext.Current.Session["ClassNo"].ToString();
            sqlObj.SqlCmd.Parameters["@ExamID"].Value = HttpContext.Current.Session["ExamID"].ToString();
            sqlObj.SqlCmd.Parameters["@ExamScore"].Value = ExamScore;
            sqlObj.SqlCmd.Parameters["@ExamTime"].Value = ExamTime;
            sqlObj.SqlCmd.Parameters["@ExamStartTime"].Value = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
            sqlObj.SqlCmd.Parameters["@MemberAnswers"].Value = MemberAnswers;
            try
            {
                sqlObj.SqlConn.Open();
                sqlObj.SqlCmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            return "success";
        }
    }
}