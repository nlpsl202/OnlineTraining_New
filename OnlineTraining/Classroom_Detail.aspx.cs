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
    public partial class Classroom_Detail : System.Web.UI.Page
    {
        public class ClassInfo
        {
            public string ClassName { get; set; }
            public string ClassType { get; set; }
            public string OpenType { get; set; }
            public string Organizer { get; set; }
            public string Instructor { get; set; }
            public string Date { get; set; }
            public string Hours { get; set; }
            public string Fee { get; set; }
            public string Contact { get; set; }
        }

        public class PassInfo
        {
            public string ExamName { get; set; }
            public string ExamPassScore { get; set; }
            public string ChapterName { get; set; }
            public string PassCondition { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetClassInfo()
        {
            ClassInfo classInfo = new ClassInfo();
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_ClassDetail";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = HttpContext.Current.Session["ClassNo"].ToString();
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 0;
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                classInfo.ClassName = dt.Rows[0]["ClassName"].ToString();
                classInfo.ClassType = dt.Rows[0]["ClassType"].ToString();
                classInfo.OpenType = dt.Rows[0]["OpenType"].ToString();
                classInfo.Organizer = dt.Rows[0]["Organizer"].ToString();
                classInfo.Instructor = dt.Rows[0]["Instructor"].ToString();
                classInfo.Date = dt.Rows[0]["Date"].ToString();
                classInfo.Hours = dt.Rows[0]["Hours"].ToString();
                classInfo.Fee = dt.Rows[0]["Fee"].ToString();
                classInfo.Contact = dt.Rows[0]["Contact"].ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            return new JavaScriptSerializer().Serialize(classInfo);
        }

        [WebMethod]
        public static string GetPassInfo()
        {
            List<PassInfo> PassInfos = new List<PassInfo>();
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_ClassDetail";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = HttpContext.Current.Session["ClassNo"].ToString();
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 1;
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    PassInfos.Add(new PassInfo
                    {
                        ExamName = dt.Rows[i]["ExamName"].ToString(),
                        ExamPassScore = dt.Rows[i]["ExamPassScore"].ToString(),
                        ChapterName = dt.Rows[i]["ChapterName"].ToString(),
                        PassCondition = dt.Rows[i]["PassCondition"].ToString()
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
            return new JavaScriptSerializer().Serialize(PassInfos);
        }
    }
}