using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace OnlineTraining.Model
{
    public class MemberModel
    {
        //會員資訊
        public struct MemberInfo
        {
            public string Account { get; set; }
            public string MemberName { get; set; }
            public string CompanyName { get; set; }
            public string Title { get; set; }
            public string Email { get; set; }
            public string Phone { get; set; }
        }

        //取得會員資訊
        public MemberInfo GetInfo(string Account)
        {
            MemberInfo memberInfo = new MemberInfo();
            string sErrMsg = string.Empty;
            DataTable dt = new DataTable();
            DBUtility sqlObj = null;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_Qry_MemberInfo";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = Account;
            try
            {
                sqlObj.SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlObj.SqlCmd);
                da.Fill(dt);
                memberInfo.Account = dt.Rows[0]["Account"].ToString();
                memberInfo.MemberName = dt.Rows[0]["MemberName"].ToString();
                memberInfo.CompanyName = dt.Rows[0]["CompanyName"].ToString();
                memberInfo.Title = dt.Rows[0]["Title"].ToString();
                memberInfo.Email = dt.Rows[0]["Email"].ToString();
                memberInfo.Phone = dt.Rows[0]["Phone"].ToString();
            }
            catch (Exception ex)
            {
                sErrMsg = ex.Message;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            return memberInfo;
        }
    }
}