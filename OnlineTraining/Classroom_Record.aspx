<%@ Page Language="C#" MasterPageFile="~/Site_Classroom.Master" AutoEventWireup="true" CodeBehind="Classroom_Record.aspx.cs" Inherits="OnlineTraining.Classroom_Record" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>
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
    <style>
        table > tbody > tr > td {
            height: 50px;
            width: 300px;
        }
    </style>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group row row-bordered">
                <div class="col-md-12">
                    <span>目前頁面 》學習紀錄</span>
                </div>
            </div>

            <div class="well form-group" id="RecordInfo">
                <p>學習紀錄清單</p>

                <table class="table-bordered">
                    <tbody>
                        <tr style="margin-top: 10px;">
                            <th>學習活動</th>
                            <th>成績</th>
                            <th>通過條件</th>
                            <th>佔總分比例</th>
                            <th>通過狀態</th>
                            <th>進行活動時間</th>
                        </tr>

                        <tr>
                            <td>課程總分</td>
                            <td></td>
                            <td></td>
                            <td>100%</td>
                            <td></td>
                            <td></td>
                        </tr>

                        <tr>
                            <td>{{recordInfos[0].ExamName}}</td>
                            <td>{{recordInfos[0].ExamScore}}</td>
                            <td>{{recordInfos[0].ExamPassScore}}</td>
                            <td></td>
                            <td>{{recordInfos[0].ClassPass}}</td>
                            <td>{{recordInfos[0].ExamFinishTime}}</td>
                        </tr>

                        <tr>
                            <td>上課表現</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>

                        <tr>
                            <td>總閱讀時數</td>
                            <td>{{recordInfos[0].TotalReadTime}}</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>

                        <tr v-for="item in recordInfos">
                            <td>{{item.ChapterName}}</td>
                            <td>{{item.ReadTime}}</td>
                            <td>{{item.PassCondition}}</td>
                            <td></td>
                            <td>{{item.ChapterPass}}</td>
                            <td>{{item.LastReadTime}}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
