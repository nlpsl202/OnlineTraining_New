using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTraining
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string InsertToMember(string Account, string Password, string FirstName, string MidName,
            string LastName, string Email, string Gender, string CompanyType, string CompanyName, string Division,
            string Country, string Address, string Title, string Phone)
        {
            DBUtility sqlObj = null;
            string sErrMsg = string.Empty;
            sqlObj = new DBUtility();
            sqlObj.StoreProcedureName = "SP_UI_Member";
            sqlObj.SetupSqlCommand(ref sErrMsg);
            sqlObj.SqlCmd.Parameters["@Account"].Value = Account;
            sqlObj.SqlCmd.Parameters["@Password"].Value = Password;
            sqlObj.SqlCmd.Parameters["@FirstName"].Value = FirstName;
            sqlObj.SqlCmd.Parameters["@MidName"].Value = MidName;
            sqlObj.SqlCmd.Parameters["@LastName"].Value = LastName;
            sqlObj.SqlCmd.Parameters["@Email"].Value = Email;
            sqlObj.SqlCmd.Parameters["@Gender"].Value = Gender;
            sqlObj.SqlCmd.Parameters["@CompanyType"].Value = CompanyType;
            sqlObj.SqlCmd.Parameters["@CompanyName"].Value = CompanyName;
            sqlObj.SqlCmd.Parameters["@Division"].Value = Division;
            sqlObj.SqlCmd.Parameters["@Country"].Value = Country;
            sqlObj.SqlCmd.Parameters["@Address"].Value = Address;
            sqlObj.SqlCmd.Parameters["@Title"].Value = Title;
            sqlObj.SqlCmd.Parameters["@Phone"].Value = Phone;
            sqlObj.SqlCmd.Parameters["@XOLTP"].Value = 0;
            sqlObj.SqlCmd.Parameters["@ReturnMsg"].Value = DBNull.Value;
            try
            {
                sqlObj.SqlConn.Open();
                sqlObj.SqlCmd.ExecuteNonQuery();
                sErrMsg = sqlObj.SqlCmd.Parameters["@ReturnMsg"].Value.ToString();
            }
            catch (Exception ex)
            {
                sErrMsg = "申請帳號失敗:" + ex.Message;
            }
            finally
            {
                sqlObj.SqlConn.Close();
            }
            if (sErrMsg.IndexOf("成功") >= 0)
            {
                sErrMsg = "申請帳號成功!";
            }
            return sErrMsg;
        }
    }
}