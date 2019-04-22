using OnlineTraining.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Script.Serialization;

namespace OnlineTraining.Controllers
{
    public class MemberController : ApiController
    {
        //取得會員資訊
        // GET: api/Member
        [HttpGet]
        public string GetInfo(string Account)
        {
            MemberModel memberModel = new MemberModel();
            return new JavaScriptSerializer().Serialize(memberModel.GetInfo(Account));
        }
    }
}
