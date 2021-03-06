﻿using System;
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
    public partial class _Default : Page
    {
        public class sessionClass
        {
            public bool sessionValue { set; get; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_News";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                BootstrapGridView_News.DataSource = dt;
                BootstrapGridView_News.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }

            dt = new DataTable();
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberStudyRecord";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = Session["Account"].ToString();
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                BootstrapGridView_Record.DataSource = dt;
                BootstrapGridView_Record.DataBind();
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

        [WebMethod]
        public static string checkSession()
        {
            sessionClass s = new sessionClass();
            if (HttpContext.Current.Session["Account"] != null)
            {
                s.sessionValue = true;
            }
            else
            {
                s.sessionValue = false;

            }
            return new JavaScriptSerializer().Serialize(s);
        }
    }
}