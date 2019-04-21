<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Exam.aspx.cs" Inherits="OnlineTraining.Exam" %>

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

            $("#Submit_btn").click(function () {
                window.location = "ExamStart.aspx";
            });

            $.ajax({
                type: "GET",
                url: "api/Exam",
                data: { ClassNo:"<%:Session["ClassNo"]%>" },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    new Vue({
                        el: '#examInfo',
                        data: {
                            examInfos: JSON.parse(response)
                        },
                    });
                    $("#info").css("visibility", 'visible');
                    $("#loading").hide();
                    sessionStorage.setItem("ExamTimeString", JSON.parse(response).ExamTimeString);
                    sessionStorage.setItem("ExamTimeInt", JSON.parse(response).ExamTimeInt);
                }
            });
        });
    </script>
    <style>
        table > tbody > tr > td {
            height: 50px;
            width: 300px;
        }

            table > tbody > tr > td:nth-child(2) {
                height: 50px;
                width: 800px;
            }

            table > tbody > tr > td:nth-child(1) {
                background-color: #999999;
                color: #ffffff;
            }

        .navbar {
            min-height: 50px;
        }

            .navbar > div {
                padding-top: 10px;
                padding-bottom: 10px;
                line-height: 30px;
            }

        .nav-tabs {
            border-bottom: none;
        }

            .nav-tabs > li {
                margin-bottom: 0;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="col-md-12">
                    <div class="col-md-4 col-md-offset-2">
                        <label class="col-md-3">姓名：</label>
                        <label class="col-md-8"><%:Session["MemberName"]%>(<%:Session["Account"]%>)</label>
                    </div>

                    <div class="col-md-4">
                        <label class="col-md-3">部門：</label>
                        <label class="col-md-8"><%:Session["Division"]%></label>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container-fluid text-center">
            <div class="col-md-12 text-center" id="loading">
                <img src="img/loading.gif" />
            </div>

            <div class="col-md-12" id="info" style="visibility: hidden;">
                <div class="form-group row">
                    <ul class="nav nav-tabs">
                        <li id="tab" class="active"><a>考試資訊</a></li>
                    </ul>
                    <div id="examInfo">
                        <table class="table-bordered" id="PassInfoTb">
                            <tbody>
                                <tr>
                                    <td>考試名稱</td>
                                    <td>{{examInfos.ExamName}}</td>
                                </tr>

                                <tr>
                                    <td>可考試次數</td>
                                    <td>{{examInfos.ExamCount}}</td>
                                </tr>

                                <tr>
                                    <td>作答時間</td>
                                    <td>{{examInfos.ExamTime}}</td>
                                </tr>

                                <tr>
                                    <td>考試總分</td>
                                    <td>{{examInfos.ExamTotalScore}}</td>
                                </tr>

                                <tr>
                                    <td>及格分數</td>
                                    <td>{{examInfos.ExamPassScore}}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-md-2">
                        <button type="button" class="btn btn-primary btn-block" id="Submit_btn">開始考試</button>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default btn-block" id="Back_btn">放棄考試</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
