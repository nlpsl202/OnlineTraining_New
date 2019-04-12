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
    <style>
        table > tbody > tr > td {
            height: 50px;
            width: 300px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid text-center">
            <div class="row content well">
                <div class="col-md-12">
                    <div class="col-md-1 col-md-offset-2">
                        <p>姓名：</p>
                    </div>

                    <div class="col-md-2">
                        <p class="pull-left">jeff mike jack(nlpsl202)</p>
                    </div>

                    <div class="col-md-1">
                        <p>部門：</p>
                    </div>

                    <div class="col-md-2">
                        <p class="pull-left">jeff mike jack(nlpsl202)</p>
                    </div>
                </div>
            </div>

            <div class="row content">
                <div class="col-md-12">
                    <div class="col-md-12">
                        <ul class="nav nav-pills">
                            <li id="tab" class="active"><a>考試資訊</a></li>
                        </ul>

                        <div class="well">
                            <table class="table-bordered" id="PassInfoTb">
                                <tbody>
                                    <tr>
                                        <td>考試名稱</td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td>可考試次數</td>
                                        <td>{{passInfos[0].ExamPassScore}}</td>
                                    </tr>

                                    <tr>
                                        <td>作答時間</td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td>考試總分</td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td>及格分數</td>
                                        <td>{{item.PassCondition}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="col-md-2">
                        <button type="button" class="btn btn-primary btn-block" id="Submit_btn">開始考試</button>
                    </div>
                    <div class="col-md-2 ">
                        <button type="button" class="btn btn-default btn-block" id="Reset_btn">放棄考試</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
