<%@ Page Language="C#" MasterPageFile="~/Site_Classroom.Master" AutoEventWireup="true" CodeBehind="ExamRecordResult.aspx.cs" Inherits="OnlineTraining.ExamRecordResult" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var ExamNo = parseInt(sessionStorage.getItem("ExamNo"), 10);

            var title = {
                Account: "<%:Session["Account"]%>", ClassNo: "<%:Session["ClassNo"]%>",
                ExamID: "<%:Session["ExamID"]%>", ExamNo: ExamNo,
                XOLTP: 3
            };

            $("#Submit_btn").click(function () {
                window.location = 'ExamRecord.aspx';
            });

            $.ajax({
                type: "POST",
                url: "api/MemberExam",
                data: JSON.stringify(title),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    new Vue({
                        el: '#examInfo',
                        data: {
                            examInfo: JSON.parse(response)
                        },
                    });
                }
            });

            var answer = {
                Account: "<%:Session["Account"]%>", ClassNo: "<%:Session["ClassNo"]%>",
                ExamID: "<%:Session["ExamID"]%>", ExamNo: ExamNo,
                XOLTP: 4
            };

            $.ajax({
                type: "POST",
                url: "api/MemberExam",
                data: JSON.stringify(answer),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    new Vue({
                        el: '#examAnswer',
                        data: {
                            examAnswers: JSON.parse(response)
                        },
                    });
                    $("#dataConent").css("visibility", 'visible');
                    $("#loading").hide();
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

        .td-center {
            width: 100px;
            text-align: center;
        }

        .td-padding {
            padding-left: 10px;
        }

        .asnwerTable {
            border-collapse: separate;
            border-spacing: 0 1em;
        }

        .examInfoTable > tbody > tr > td {
            text-align: center;
        }

        .hidden {
            display: none;
        }
    </style>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group row row-bordered">
                <div class="col-md-4">
                    <span>目前頁面 》測驗結果 - 學員測驗答題明細</span>
                </div>

                <div class="col-md-offset-3 col-md-5">
                    <div class="col-md-offset-6 col-md-6">
                        <button type="button" class="btn btn-primary btn-block" id="Submit_btn">查看所有考試紀錄</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-12 text-center" id="loading">
            <img src="img/loading.gif" />
        </div>

        <div class="col-md-12" style="overflow: scroll; height: 700px; visibility: hidden;" id="dataConent">
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
</asp:Content>

