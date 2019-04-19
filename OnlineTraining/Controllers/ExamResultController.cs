using OnlineTraining.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Script.Serialization;

namespace OnlineTraining.Controllers
{
    public class ExamResultController : ApiController
    {
        //取得學員考試紀錄
        // POST: api/ExamResult
        [HttpPost]
        public string Post(MemberExamParm parm)
        {
            string sErrMsg = string.Empty;
            MemberExamTitle title = new MemberExamTitle();
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberExam";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = parm.Account;
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = parm.ClassNo;
            sqlObj.SqlCmd.Parameters["@ExamID"].Value = parm.ExamID;
            sqlObj.SqlCmd.Parameters["@ExamNo"].Value = parm.ExamNo;
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = parm.XOLTP;
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                if (parm.XOLTP == 1 || parm.XOLTP == 3)
                {
                    title.ExamName = dt.Rows[0]["ExamName"].ToString();
                    title.ExamPaperName = dt.Rows[0]["ExamPaperName"].ToString();
                    title.ExamFinishTime = dt.Rows[0]["ExamFinishTime"].ToString();
                    title.ExamTime = dt.Rows[0]["ExamTime"].ToString();
                    title.ExamScore = dt.Rows[0]["ExamScore"].ToString();
                    title.Pass = dt.Rows[0]["Pass"].ToString();
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

            if (parm.XOLTP == 1 || parm.XOLTP == 3)
            {
                return new JavaScriptSerializer().Serialize(title);
            }
            else
            {
                return dt.Rows[0]["MemberAnswers"].ToString();
            }
        }
    }
}
