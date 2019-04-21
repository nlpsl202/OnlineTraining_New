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
    public class ExamController : ApiController
    {
        //取得考試資訊
        // GET: api/Exam
        [HttpGet]
        public string GetInfo(string ClassNo)
        {
            ExamModel examModel = new ExamModel();
            //Session["ExamID"] = examModel.GetInfo(ClassNo).ExamID;
            return new JavaScriptSerializer().Serialize(examModel.GetInfo(ClassNo));
        }

        //取得題目
        // GET: api/Exam
        [HttpGet]
        public string GetQuestion(string ExamID)
        {
            ExamModel examModel = new ExamModel();
            return new JavaScriptSerializer().Serialize(examModel.GetQuestion(ExamID));
        }

        //交卷
        // POST: api/Exam
        [HttpPost]
        public void Post(ExamModel exam)
        {
            exam.Submit();
        }
    }
}
