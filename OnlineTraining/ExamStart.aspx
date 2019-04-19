<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamStart.aspx.cs" Inherits="OnlineTraining.ExamStart" %>

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
    <script src="Scripts/moment.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#Back_btn").click(function () {
                window.location = "Exam.aspx";
            });

            var StartTime = moment().format('YYYY/MM/DD HH:mm:ss');

            $("#Submit_btn").click(function () {
                var question_count = $(".question").length;
                var question_right_count = 0;
                var answersJson = "[";
                for (var i = 1; i <= question_count; i++) {
                    if ($($("input[name='" + i + "']:checked").prop("labels")).text() == $("input[name='" + i + "']").val()) {
                        question_right_count++;
                    }

                    if (i != 1) {
                        answersJson = answersJson + ",";
                    }

                    if ($(".questionName" + i).hasClass('OX')) {
                        answersJson = answersJson + '{"QuestionNo":"' + i + '",' +
                            '"QuestionName":"' + $(".questionName" + i).html() + '",' +
                            '"QuestionType":"1",' +
                            '"Answer":"' + $("input[name='" + i + "']").val() + '",' +
                            '"MemberAnswer":"' + $($("input[name='" + i + "']:checked").prop("labels")).text() + '"}'
                    } else {
                        answersJson = answersJson + '{"QuestionNo":"' + i + '",' +
                            '"QuestionName":"' + $(".questionName" + i).html() + '",' +
                            '"QuestionType":"2",' +
                            '"Answer":"' + $("input[name='" + i + "']").val() + '",' +
                            '"MemberAnswer":"' + $($("input[name='" + i + "']:checked").prop("labels")).text() + '",' +
                            '"OptionA":"' + $(".optionA" + i).html() + '",' +
                            '"OptionB":"' + $(".optionB" + i).html() + '",' +
                            '"OptionC":"' + $(".optionC" + i).html() + '",' +
                            '"OptionD":"' + $(".optionD" + i).html() + '"}'
                    }
                }
                answersJson = answersJson + "]";

                var parm = {
                    'ExamScore': 4 * question_right_count,
                    'ExamTime': paddingLeft(parseInt(spendSeconds / 3600).toString(), 2) + ':' + paddingLeft(parseInt(spendSeconds % 3600 / 60).toString(), 2) + ':' + paddingLeft((spendSeconds % 3600 % 60).toString(), 2),
                    'MemberAnswers': answersJson
                };

                $.ajax({
                    type: "POST",
                    url: "ExamStart.aspx/SubmitExam",
                    data: JSON.stringify(para),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        window.location = "ExamResult.aspx";
                    }
                });
            });

            $.ajax({
                type: "POST",
                url: "ExamStart.aspx/GetQuestionInfo",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    new Vue({
                        el: '#questionInfo',
                        data: {
                            questionInfos: JSON.parse(response.d)
                        },
                    });
                }
            });

            var seconds = <%:Session["ExamTimeInt"]%> * 60;
            var spendSeconds = 0;
            setInterval(function () {
                seconds--;
                spendSeconds++;
                $("#LeftTime").text(paddingLeft(parseInt(seconds / 3600).toString(), 2) + ':' + paddingLeft(parseInt(seconds % 3600 / 60).toString(), 2) + ':' + paddingLeft((seconds % 3600 % 60).toString(), 2));
                if (seconds == 0) {
                    $('#Submit_btn').trigger('click');
                }
            }, 1000);

            function paddingLeft(str, lenght) {
                if (str.length >= lenght)
                    return str;
                else
                    return paddingLeft("0" + str, lenght);
            }
        });
    </script>
    <style>
        table > tbody > tr > td > table > tbody > tr > th {
            text-align: center;
            background-color: #999999;
            color: #ffffff;
        }

        table > tbody > tr > td > table > tbody > tr > td {
            width: 1000px;
            height: 50px;
            text-align: center;
        }

            table > tbody > tr > td > table > tbody > tr > td:nth-child(1) {
                width: 100px;
                height: 50px;
            }

            table > tbody > tr > td > table > tbody > tr > td > table > tbody > tr > td {
                height: 40px;
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
                    <div class="col-md-3 col-md-offset-2">
                        <label class="col-md-6">作答時間：</label>
                        <label class="col-md-6"><%:Session["ExamTime"]%></label>
                    </div>

                    <div class="col-md-3">
                        <label class="col-md-6">剩餘時間：</label>
                        <label class="col-md-6" id="LeftTime"><%:Session["ExamTime"]%></label>
                    </div>

                    <div class="col-md-4">
                        <div class="col-md-5">
                            <button type="button" class="btn btn-primary btn-block" id="Submit_btn">交卷</button>
                        </div>
                        <div class="col-md-5">
                            <button type="button" class="btn btn-default btn-block" id="Back_btn">放棄考試</button>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="col-md-12">
                <div class="col-md-12" id="questionInfo">
                    <table>
                        <tbody>
                            <tr v-for="item in questionInfos" class="question">
                                <td>
                                    <table class="table-bordered">
                                        <tbody>
                                            <tr>
                                                <th>題號</th>
                                                <th>題目</th>
                                            </tr>
                                            <tr>
                                                <td>{{item.QuestionNo}}</td>
                                                <td v-if="item.QuestionType ==1" :class="'questionName'+item.QuestionNo+' OX'">{{item.QuestionName}}</td>
                                                <td v-else>
                                                    <table style="width: 100%; height: 100%;">
                                                        <tbody>
                                                            <tr>
                                                                <td style="color: red;" :class="'questionName'+item.QuestionNo">{{item.QuestionName}}</td>
                                                            </tr>
                                                            <tr>
                                                                <td :class="'optionA'+item.QuestionNo">A.{{item.OptionA}}</td>
                                                            </tr>
                                                            <tr>
                                                                <td :class="'optionB'+item.QuestionNo">B.{{item.OptionB}}</td>
                                                            </tr>
                                                            <tr>
                                                                <td :class="'optionC'+item.QuestionNo">C.{{item.OptionC}}</td>
                                                            </tr>
                                                            <tr>
                                                                <td :class="'optionD'+item.QuestionNo">D.{{item.OptionD}}</td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>作答區</td>
                                                <td v-if="item.QuestionType ==1">
                                                    <label class="radio-inline">
                                                        <input type="radio" :name="item.QuestionNo" :value="item.Answer">O</label>
                                                    <label class="radio-inline">
                                                        <input type="radio" :name="item.QuestionNo" :value="item.Answer">X</label>
                                                </td>
                                                <td v-else>
                                                    <label class="radio-inline">
                                                        <input type="radio" :name="item.QuestionNo" :value="item.Answer">A</label>
                                                    <label class="radio-inline">
                                                        <input type="radio" :name="item.QuestionNo" :value="item.Answer">B</label>
                                                    <label class="radio-inline">
                                                        <input type="radio" :name="item.QuestionNo" :value="item.Answer">C</label>
                                                    <label class="radio-inline">
                                                        <input type="radio" :name="item.QuestionNo" :value="item.Answer">D</label>
                                                </td>
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

