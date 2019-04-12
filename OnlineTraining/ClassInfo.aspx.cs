using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace OnlineTraining
{
    public partial class ClassInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DateTime dt = DateTime.Now;
                StartDate_txb.Text = dt.ToString("yyyy/MM/dd");
                EndDate_txb.Text = dt.ToString("yyyy/MM/dd");
            }
            string sErrMsg = string.Empty;
            DataTable dataTable = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_ClassInfo";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@StartDate"].Value = StartDate_txb.Text;
            sqlObj.SqlCmd.Parameters["@EndDate"].Value = EndDate_txb.Text;
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
        public static string IntoClassroom(string ClassNo, string BackPage)
        {
            try
            {
                HttpContext.Current.Session["ClassNo"] = ClassNo;
                HttpContext.Current.Session["ClassroomBackPage"] = BackPage;
                return "success";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        [WebMethod]
        public static string BecomeStudent(string ClassNo, string BackPage)
        {
            string sErrMsg = string.Empty;
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_UI_MemberClass";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = ClassNo;
            try
            {
                sqlObj.SqlConn.Open();
                sqlObj.SqlCmd.ExecuteNonQuery();
                HttpContext.Current.Session["ClassNo"] = ClassNo;
                HttpContext.Current.Session["ClassroomBackPage"] = BackPage;
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
        public static string CheckStudent(string ClassNo)
        {
            string sErrMsg = string.Empty;
            DataTable dataTable = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberClass";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = ClassNo;
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 0;
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

            if (dataTable.Rows.Count > 0)
            {
                return "isStudent";
            }
            else
            {
                return "notStudent";
            }
        }

        protected void Search_btn_Click(object sender, EventArgs e)
        {
            string sErrMsg = string.Empty;
            DataTable dataTable = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_ClassInfo";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@ClassName"].Value = ClassName_txb.Text;
            sqlObj.SqlCmd.Parameters["@Instructor"].Value = Instructor_txb.Text;
            sqlObj.SqlCmd.Parameters["@Organizer"].Value = Organizer_txb.Text;
            sqlObj.SqlCmd.Parameters["@OpenType"].Value = OpenType_ddl.SelectedValue;
            sqlObj.SqlCmd.Parameters["@StartType"].Value = StartType_ddl.SelectedValue;
            sqlObj.SqlCmd.Parameters["@ClassType"].Value = ClassType_ddl.SelectedValue;
            sqlObj.SqlCmd.Parameters["@StartDate"].Value = StartDate_txb.Text;
            sqlObj.SqlCmd.Parameters["@EndDate"].Value = EndDate_txb.Text;
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
    }
}