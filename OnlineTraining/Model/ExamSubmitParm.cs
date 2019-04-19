using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OnlineTraining.Model
{
    public class ExamSubmitParm
    {
        public string Account { get; set; }
        public string ClassNo { get; set; }
        public string ExamID { get; set; }
        public int ExamScore { get; set; }
        public string ExamTime { get; set; }
        public string ExamStartTime { get; set; }
        public string MemberAnswers { get; set; }
    }
}