using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace OnlineTraining.Model
{
    public class ExamModel
    {
        public struct ExamQuestion
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

        public struct ExamInfo
        {
            public string ExamID { get; set; }
            public string ExamName { get; set; }
            public string ExamPaperName { get; set; }
            public string ExamTotalScore { get; set; }
            public string ExamPassScore { get; set; }
            public string ExamTime { get; set; }
            public string ExamCount { get; set; }
            public string ExamTimeString { get; set; }
            public int ExamTimeInt { get; set; }
        }

        public string Account { get; set; }
        public string ClassNo { get; set; }
        public string ExamID { get; set; }
        public int ExamScore { get; set; }
        public string ExamTime { get; set; }
        public string ExamStartTime { get; set; }
        public string MemberAnswers { get; set; }

        //取得考試資訊
        public ExamInfo GetInfo(string ClassNo)
        {
            ExamInfo examInfo = new ExamInfo();
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_Exam";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = ClassNo;
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                examInfo.ExamID = dt.Rows[0]["ExamID"].ToString();
                examInfo.ExamName = dt.Rows[0]["ExamName"].ToString();
                examInfo.ExamPaperName = dt.Rows[0]["ExamPaperName"].ToString();
                examInfo.ExamTotalScore = dt.Rows[0]["ExamTotalScore"].ToString();
                examInfo.ExamPassScore = dt.Rows[0]["ExamPassScore"].ToString();
                examInfo.ExamTime = dt.Rows[0]["ExamTime"].ToString();
                examInfo.ExamCount = dt.Rows[0]["ExamCount"].ToString();
                int time = Convert.ToInt32(dt.Rows[0]["ExamTimeInt"]) * 60;
                examInfo.ExamTimeString = (time / 3600).ToString("00") + ":" + (time % 3600 / 60).ToString("00") + ":" + (time % 3600 % 60).ToString("00");
                examInfo.ExamTimeInt = Convert.ToInt32(dt.Rows[0]["ExamTimeInt"]);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            return examInfo;
        }

        //取得考試題目
        public List<ExamQuestion> GetQuestion(string ExamID)
        {
            List<ExamQuestion> questions = new List<ExamQuestion>();
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_ExamQuestion";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@ExamID"].Value = ExamID;
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    questions.Add(new ExamQuestion
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
            return questions;
        }

        //交卷
        public void Submit()
        {
            string sErrMsg = string.Empty;
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_UI_MemberExam";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = Account;
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = ClassNo;
            sqlObj.SqlCmd.Parameters["@ExamID"].Value = ExamID;
            sqlObj.SqlCmd.Parameters["@ExamScore"].Value = ExamScore;
            sqlObj.SqlCmd.Parameters["@ExamTime"].Value = ExamTime;
            sqlObj.SqlCmd.Parameters["@ExamStartTime"].Value = ExamStartTime;
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
        }
    }
}