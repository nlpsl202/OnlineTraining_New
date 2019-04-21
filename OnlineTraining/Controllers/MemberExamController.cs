using OnlineTraining.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Script.Serialization;

namespace OnlineTraining.Controllers
{
    public class MemberExamController : ApiController
    {
        //取得學員考試紀錄
        // POST: api/MemberExam
        [HttpPost]
        public string MemberAnswer(MemberExamModel exam)
        {
            return exam.GetMemberExam();
        }
    }
}
