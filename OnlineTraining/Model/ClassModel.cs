using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace OnlineTraining.Model
{
    public class ClassModel
    {
        //課程資訊
        public struct ClassInfo
        {
            public string ClassName { get; set; }
            public string ClassType { get; set; }
            public string OpenType { get; set; }
            public string Organizer { get; set; }
            public string Date { get; set; }
            public string Hours { get; set; }
            public string Fee { get; set; }
        }

        //取得課程資訊
        public ClassInfo GetInfo(string ClassNo)
        {
            ClassInfo classInfo = new ClassInfo();
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_ClassInfo";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = ClassNo;
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                classInfo.ClassName = dt.Rows[0]["ClassName"].ToString();
                classInfo.ClassType = dt.Rows[0]["ClassType"].ToString();
                classInfo.OpenType = dt.Rows[0]["OpenType"].ToString();
                classInfo.Organizer = dt.Rows[0]["Organizer"].ToString();
                classInfo.Date = dt.Rows[0]["Date"].ToString();
                classInfo.Hours = dt.Rows[0]["Hours"].ToString();
                classInfo.Fee = dt.Rows[0]["Fee"].ToString();
            }
            catch (Exception ex)
            {
                sErrMsg = ex.Message;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            return classInfo;
        }
    }
}