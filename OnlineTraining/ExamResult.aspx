<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamResult.aspx.cs" Inherits="OnlineTraining.ExamResult" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Exam</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/vue.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#Back_btn").click(function () {
                window.location = "Classroom.aspx";
            });

            $.ajax({
                type: "POST",
                url: "ExamResult.aspx/GetExamResultInfo",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    new Vue({
                        el: '#examInfo',
                        data: {
                            examInfo: JSON.parse(response.d)
                        },
                    });
                }
            });

            $.ajax({
                type: "POST",
                url: "ExamResult.aspx/GetExamResultAnswer",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    new Vue({
                        el: '#examAnswer',
                        data: {
                            examAnswers: JSON.parse(response.d)
                        },
                    });
                }
            });
        });
    </script>
    <style>
        table > tbody > tr > td {
            width: 1000px;
            height: 50px;
        }

            table > tbody > tr > td > table > tbody > tr > td {
                width: 1900px;
            }

        .td-questionNo {
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            border-left: 1px solid #ddd;
        }

        .td-center{
            width: 100px;
            text-align:center;
        }
        
        .td-padding{
            padding-left:10px;
        }

        .asnwerTable {
            border-collapse: separate;
            border-spacing: 0 1em;
        }

        .examInfoTable > tbody > tr > td{
            text-align:center;
        }

        .navbar {
            min-height: 50px;
        }

            .navbar > div {
                padding-top: 10px;
                padding-bottom: 10px;
                line-height: 30px;
            }

        body {
            padding-top: 200px;
        }

        footer {
            background-color: #555;
            color: white;
            padding: 15px;
            margin-top: 20px;
        }

        @media (min-width: 1000px) {
            body {
                padding-top: 100px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container-fluid">
                <div class="col-md-12">
                    <div class="col-md-1 col-md-offset-10">
                        <button type="button" class="btn btn-default btn-block" id="Back_btn">關閉</button>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="col-md-12">
                <div class="col-md-12" id="examInfo">
                    <table class="table-bordered examInfoTable">
                        <tbody>
                            <tr>
                                <td>考試名稱</td>
                                <td>{{examInfo.ExamName}}</td>
                                <td>考卷名稱</td>
                                <td>{{examInfo.ExamPaperName}}</td>
                            </tr>
                            <tr>
                                <td>完成考試時間</td>
                                <td>{{examInfo.ExamFinishTime}}</td>
                                <td>實際作答時間</td>
                                <td>{{examInfo.ExamTime}}</td>
                            </tr>
                            <tr>
                                <td>考試成績</td>
                                <td>{{examInfo.ExamScore}}</td>
                                <td>及格狀態</td>
                                <td>{{examInfo.Pass}}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="col-md-12" id="examAnswer" style="margin-top: 50px;">
                    <table class="asnwerTable">
                        <tbody>
                            <tr v-for="item in examAnswers" class="question">
                                <td class="td-questionNo td-center">第{{item.QuestionNo}}題</td>
                                <td style="width: 1900px;">
                                    <table class="table-bordered asnwerTable2">
                                        <tbody>
                                            <tr>
                                                <td v-if="item.QuestionType ==1" colspan="2" class="td-padding">{{item.QuestionName}}</td>
                                                <td v-else colspan="2" class="td-padding">
                                                    <table style="width: 100%; height: 100%;">
                                                        <tbody>
                                                            <tr>
                                                                <td style="color: red;">{{item.QuestionName}}</td>
                                                            </tr>
                                                            <tr>
                                                                <td>{{item.OptionA}}</td>
                                                            </tr>
                                                            <tr>
                                                                <td>{{item.OptionB}}</td>
                                                            </tr>
                                                            <tr>
                                                                <td>{{item.OptionC}}</td>
                                                            </tr>
                                                            <tr>
                                                                <td>{{item.OptionD}}</td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="td-center">考生答案</td>
                                                <td class="td-padding">{{item.MemberAnswer}}</td>
                                            </tr>
                                            <tr>
                                                <td class="td-center">標準答案</td>
                                                <td class="td-padding">{{item.Answer}}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <footer class="container-fluid text-center">
            <p>© 2019 Powered by AVTECH</p>
        </footer>
    </form>
</body>
</html>
