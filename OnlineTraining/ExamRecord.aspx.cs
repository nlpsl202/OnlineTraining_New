using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTraining
{
    public partial class ExamRecord : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridViewBind();
        }

        protected void Search_btn_Click(object sender, EventArgs e)
        {
            GridViewBind();
        }

        protected void GridViewBind()
        {
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberExam";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@ClassNo"].Value = Session["ClassNo"].ToString();
            sqlObj.SqlCmd.Parameters["@ExamPaperName"].Value = ExamPaperName_txb.Text;
            sqlObj.SqlCmd.Parameters["@Pass"].Value = Pass_ddl.SelectedValue;
            sqlObj.SqlCmd.Parameters["@StartDate"].Value = StartDate_txb.Text;
            sqlObj.SqlCmd.Parameters["@EndDate"].Value = EndDate_txb.Text;
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 5;
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            BootstrapGridView1.DataSource = dt;
            BootstrapGridView1.DataBind();
        }
    }
}