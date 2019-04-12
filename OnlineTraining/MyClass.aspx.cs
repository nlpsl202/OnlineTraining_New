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
    public partial class MyClass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string sErrMsg = string.Empty;
            DataTable dataTable = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberClass";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 1;
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
            BootstrapGridView_Online.DataSource = dataTable; //告訴GridView資料來源為誰
            BootstrapGridView_Online.DataBind();//綁定     

            dataTable = new DataTable();
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberClass";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 2;
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
            BootstrapGridView_Face1.DataSource = dataTable; //告訴GridView資料來源為誰
            BootstrapGridView_Face1.DataBind();//綁定     

            dataTable = new DataTable();
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberClass";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 3;
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
            BootstrapGridView_Face2.DataSource = dataTable; //告訴GridView資料來源為誰
            BootstrapGridView_Face2.DataBind();//綁定     

            dataTable = new DataTable();
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberClass";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 4;
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
            BootstrapGridView_Set.DataSource = dataTable; //告訴GridView資料來源為誰
            BootstrapGridView_Set.DataBind();//綁定     
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string sErrMsg = string.Empty;
            DataTable dataTable = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberClass";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@ClassName"].Value = ClassName_txb.Text;
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 1;
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

            BootstrapGridView_Online.DataSource = dataTable; //告訴GridView資料來源為誰
            BootstrapGridView_Online.DataBind();//綁定     

            dataTable = new DataTable();
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberClass";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@ClassName"].Value = ClassName_txb.Text;
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 2;
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
            BootstrapGridView_Face1.DataSource = dataTable; //告訴GridView資料來源為誰
            BootstrapGridView_Face1.DataBind();//綁定    

            dataTable = new DataTable();
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberClass";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@ClassName"].Value = ClassName_txb.Text;
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 3;
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
            BootstrapGridView_Face2.DataSource = dataTable; //告訴GridView資料來源為誰
            BootstrapGridView_Face2.DataBind();//綁定   

            dataTable = new DataTable();
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberClass";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = HttpContext.Current.Session["Account"].ToString();
            sqlObj.SqlCmd.Parameters["@ClassName"].Value = ClassName_txb.Text;
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 4;
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
            BootstrapGridView_Set.DataSource = dataTable; //告訴GridView資料來源為誰
            BootstrapGridView_Set.DataBind();//綁定 
        }
    }
}