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
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "Classroom_Record.aspx/GetRecordInfo",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    new Vue({
                        el: '#RecordInfo',
                        data: {
                            recordInfos: JSON.parse(response.d)
                        },
                    });
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid text-center">
            <div class="row content well">
                <div class="col-md-12">
                    <div class="col-md-1 col-md-offset-2">
                        <p>作答時間：</p>
                    </div>

                    <div class="col-md-2">
                        <p class="pull-left">01:30:00</p>
                    </div>

                    <div class="col-md-1">
                        <p>剩餘時間：</p>
                    </div>

                    <div class="col-md-2">
                        <p class="pull-left">01:30:00</p>
                    </div>
                </div>
            </div>

            <div class="row content">
                <div class="col-md-12">
                    <div class="col-md-12 well" id="RecordInfo">
                        <table>
                            <tbody>
                                <tr v-for="item in recordInfos" id="question">
                                    <td>
                                        <table class="table-bordered">
                                            <tr>
                                                <th>題號</th>
                                                <th>題目</th>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px; height: 50px;">1</td>
                                                <td style="width: 1000px; height: 50px;">{{item.ChapterName}} {{item.ChapterName}} {{item.ChapterName}} {{item.ChapterName}} {{item.ChapterName}} {{item.ChapterName}} {{item.ChapterName}} {{item.ChapterName}} {{item.ChapterName}}</td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px; height: 50px;">作答區</td>
                                                <td style="width: 1000px; height: 50px;">
                                                    <label class="radio-inline">
                                                        <input type="radio" :name="item.ChapterName">A</label>
                                                    <label class="radio-inline">
                                                        <input type="radio" :name="item.ChapterName">B</label>
                                                    <label class="radio-inline">
                                                        <input type="radio" :name="item.ChapterName">C</label>
                                                    <label class="radio-inline">
                                                        <input type="radio" :name="item.ChapterName">D</label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

