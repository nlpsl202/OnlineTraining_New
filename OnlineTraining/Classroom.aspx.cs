using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTraining
{
    public partial class Classroom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string sErrMsg = string.Empty;
            DataTable dataTable = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_ClassSub";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = Session["ClassNo"].ToString();
            sqlObj.SqlCmd.Parameters["@Account"].Value = Session["Account"].ToString();
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dataTable);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            BootstrapGridView1.DataSource = dataTable; //告訴GridView資料來源為誰
            BootstrapGridView1.DataBind();//綁定     
        }

        [WebMethod]
        public static string StartStudy(string ClassNo, string ChapterNo, string VideoPath,string BackPage)
        {
            HttpContext.Current.Session["VideoPath"] = VideoPath;
            HttpContext.Current.Session["ClassVideoBackPage"] = BackPage;
            HttpContext.Current.Session["ClassNo"] = ClassNo;
            HttpContext.Current.Session["ChapterNo"] = ChapterNo;
            string sErrMsg = string.Empty;
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_UI_MemberStudyRecord";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = ClassNo;
            sqlObj.SqlCmd.Parameters["@ChapterNo"].Value = ChapterNo;
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

        [WebMethod]
        public static string SetSession(string VideoPath)
        {
            try
            {
                HttpContext.Current.Session["VideoPath"] = VideoPath;
                return "success";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
    }
}