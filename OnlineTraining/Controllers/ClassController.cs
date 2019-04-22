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
    public class ClassController : ApiController
    {
        //取得課程資訊
        // GET: api/Class
        [HttpGet]
        public string GetInfo(string ClassNo)
        {
            ClassModel classModel = new ClassModel();
            return new JavaScriptSerializer().Serialize(classModel.GetInfo(ClassNo));
        }
    }
}
