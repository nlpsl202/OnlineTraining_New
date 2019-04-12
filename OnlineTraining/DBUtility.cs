using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace OnlineTraining
{
    public class DBUtility
    {
        private readonly string connStr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        private string storeProcName = string.Empty;
        private DataTable dtStoreProcInfo;
        private SqlConnection conn;
        private SqlCommand cmd;

        //設定要執行的 store procdedure name
        public string StoreProcedureName
        {
            get { return storeProcName; }
            set { storeProcName = value; }
        }

        public SqlConnection SqlConn
        {
            get { return conn; }
        }

        public SqlCommand SqlCmd
        {
            get { return cmd; }
        }

        public DBUtility()
        {
            conn = new SqlConnection(this.connStr);
            dtStoreProcInfo = new DataTable();
        }

        private bool GetStoreProcInfo(ref string sErrMsg)
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.AppendLine("select sp.name as StoreProcName, typ.name as ParamType, parm.name as ParamName, parm.max_length as ParamLength,");
            sbSQL.AppendLine("       parm.precision, parm.scale, parm.is_output, parm.has_default_value, parm.default_value, typ.is_user_defined ");
            sbSQL.AppendLine("from sys.procedures sp ");
            sbSQL.AppendLine("join sys.parameters parm on sp.[object_id] = parm.[object_id] ");
            sbSQL.AppendLine("join sys.types typ ON parm.system_type_id = typ.system_type_id and parm.user_type_id = typ.user_type_id ");
            sbSQL.AppendLine("where sp.name = '" + storeProcName + "' ");
            sbSQL.AppendLine("order by sp.name, parm.parameter_id");
            try
            {
                using (SqlConnection objConn = new SqlConnection(connStr))
                {
                    using (SqlCommand objCmd = new SqlCommand(sbSQL.ToString(), objConn))
                    {
                        objConn.Open();
                        using (SqlDataReader objDR = objCmd.ExecuteReader(CommandBehavior.CloseConnection))
                        {
                            dtStoreProcInfo.Load(objDR);
                            sErrMsg = "找不到 [" + storeProcName + "] store procedure 的參數(或者沒有參數)";
                            return (dtStoreProcInfo.Rows.Count > 0);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sErrMsg = ex.Message;
                return false;
            }
        }

        //依傳入的 sType 設定 aParam.SqlDbType
        private bool SetupParamTypeWithText(string sType, ref SqlParameter aParam, ref string sErrMsg)
        {
            if ((sType == "nvarchar"))
            {
                aParam.SqlDbType = SqlDbType.NVarChar;
            }
            else if ((sType == "varchar"))
            {
                aParam.SqlDbType = SqlDbType.VarChar;
            }
            else if ((sType == "nchar"))
            {
                aParam.SqlDbType = SqlDbType.NChar;
            }
            else if ((sType == "char"))
            {
                aParam.SqlDbType = SqlDbType.Char;
            }
            else if ((sType == "int"))
            {
                aParam.SqlDbType = SqlDbType.Int;
            }
            else if ((sType == "smallint"))
            {
                aParam.SqlDbType = SqlDbType.SmallInt;
            }
            else if ((sType == "datetime"))
            {
                aParam.SqlDbType = SqlDbType.DateTime;
            }
            else if ((sType == "numeric"))
            {
                aParam.SqlDbType = SqlDbType.Int;
            }
            else if ((sType == "binary"))
            {
                aParam.SqlDbType = SqlDbType.Binary;
            }
            else if ((sType == "date"))
            {
                aParam.SqlDbType = SqlDbType.Date;
            }
            else if ((sType == "varbinary"))
            {
                aParam.SqlDbType = SqlDbType.VarBinary;
            }
            else
            {
                sErrMsg = "傳入的型態[" + sType + "]超出預期!";
                return false;
            }
            return true;
        }

        public bool SetupSqlCommand(ref string sErrMsg)
        {
            if ((storeProcName == string.Empty))
            {
                sErrMsg = "必需先指定 property[StoreProcedureName] 的值";
                return false;
            }

            if ((dtStoreProcInfo.Rows.Count > 0))
            {
                string sSPName = dtStoreProcInfo.Rows[0]["StoreProcName"].ToString();
                if ((sSPName != storeProcName))
                {
                    if ((!GetStoreProcInfo(ref sErrMsg)))
                    {
                        return false;
                    }
                }
            }
            else
            {
                if ((!GetStoreProcInfo(ref sErrMsg)))
                {
                    return false;
                }
            }
            //開始設定 store procedure
            if (((cmd == null)))
            {
                cmd = new SqlCommand(storeProcName, conn);
            }
            //
            cmd.CommandType = CommandType.StoredProcedure;
            //執行模式為 store procedcure 
            cmd.CommandText = storeProcName;
            //設定要執行的 store procedure name
            //設定 store procedure 的參數
            cmd.Parameters.Clear();
            SqlParameter aParam = null;
            string sParType = string.Empty;
            foreach (DataRow row in dtStoreProcInfo.Rows)
            {
                aParam = new SqlParameter();
                aParam.ParameterName = row["ParamName"].ToString();
                sParType = row["ParamType"].ToString();
                if (Convert.ToBoolean(row["is_user_defined"]) == false)
                {
                    if ((!SetupParamTypeWithText(sParType, ref aParam, ref sErrMsg)))
                    {
                        return false;
                    }
                }
                aParam.Size = Convert.ToInt32(row["ParamLength"]);
                if ((Convert.ToBoolean(row["is_output"]) == true))
                {
                    aParam.Direction = ParameterDirection.Output;
                }
                else
                {
                    aParam.Direction = ParameterDirection.Input;
                }
                cmd.Parameters.Add(aParam);
            }
            return true;
        }
    }
}