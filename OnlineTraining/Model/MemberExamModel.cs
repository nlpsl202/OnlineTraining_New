using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace OnlineTraining.Model
{
    public class MemberExamModel
    {
        //會員考試紀錄
        public struct MemberExamInfo
        {
            public string ExamName { get; set; }
            public string ExamPaperName { get; set; }
            public string ExamFinishTime { get; set; }
            public string ExamTime { get; set; }
            public string ExamScore { get; set; }
            public string Pass { get; set; }
        }

        public string Account { get; set; }
        public string ClassNo { get; set; }
        public string ExamID { get; set; }
        public int ExamNo { get; set; }
        public int XOLTP { get; set; }

        //取得會員考試紀錄
        public string GetMemberExam()
        {
            string sErrMsg = string.Empty;
            MemberExamInfo info = new MemberExamInfo();
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberExam";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = Account;
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = ClassNo;
            sqlObj.SqlCmd.Parameters["@ExamID"].Value = ExamID;
            sqlObj.SqlCmd.Parameters["@ExamNo"].Value = ExamNo;
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = XOLTP;
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                if (XOLTP == 1 || XOLTP == 3)
                {
                    info.ExamName = dt.Rows[0]["ExamName"].ToString();
                    info.ExamPaperName = dt.Rows[0]["ExamPaperName"].ToString();
                    info.ExamFinishTime = dt.Rows[0]["ExamFinishTime"].ToString();
                    info.ExamTime = dt.Rows[0]["ExamTime"].ToString();
                    info.ExamScore = dt.Rows[0]["ExamScore"].ToString();
                    info.Pass = dt.Rows[0]["Pass"].ToString();
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

            if (XOLTP == 1 || XOLTP == 3)
            {
                return new JavaScriptSerializer().Serialize(info);
            }
            else
            {
                return dt.Rows[0]["MemberAnswers"].ToString();
            }
        }
    }
}