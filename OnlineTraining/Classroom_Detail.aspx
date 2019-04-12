<%@ Page Language="C#" MasterPageFile="~/Site_Classroom.Master" AutoEventWireup="true" CodeBehind="Classroom_Detail.aspx.cs" Inherits="OnlineTraining.Classroom_Detail" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#tab").click(function () {
                $("#tab").addClass("active")
                $("#tab2").removeClass("active")
                $("#PassInfo").css("display", "none")
                $("#ClassInfo").show();
            });

            $("#tab2").click(function () {
                $("#tab").removeClass("active")
                $("#tab2").addClass("active")
                $("#ClassInfo").css("display", "none")
                $("#PassInfo").show();
            });

            $.ajax({
                type: "POST",
                url: "Classroom_Detail.aspx/GetClassInfo",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    new Vue({
                        el: '#ClassInfo',
                        data: {
                            classInfo: JSON.parse(response.d)
                        },
                    });
                }
            });

            $.ajax({
                type: "POST",
                url: "Classroom_Detail.aspx/GetPassInfo",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    new Vue({
                        el: '#PassInfo',
                        data: {
                            passInfos: JSON.parse(response.d)
                        },
                    });
                }
            });
        });
    </script>
    <style>
        .nav-tabs {
            border-bottom: none;
        }

            .nav-tabs > li {
                margin-bottom: 0;
            }

        table > tbody > tr > td{
            height:50px;
            width:300px;
        }
    </style>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group row row-bordered">
                <div class="col-md-12">
                    <span>目前頁面 》開班資訊</span>
                </div>
            </div>

            <ul class="nav nav-tabs">
                <li id="tab" class="active"><a href="#">開班資訊</a></li>
                <li id="tab2"><a href="#">通過條件</a></li>
            </ul>

            <div class="well form-group" id="ClassInfo">
                <div class="form-group row">
                    <label class="col-md-1">開班名稱：</label>
                    <label class="col-md-3">{{classInfo.ClassName}}</label>
                </div>

                <div class="form-group row">
                    <label class="col-md-1">開班屬性：</label>
                    <label class="col-md-3">{{classInfo.ClassType}}</label>
                </div>

                <div class="form-group row">
                    <label class="col-md-1">課程屬性：</label>
                    <label class="col-md-3">{{classInfo.OpenType}}</label>
                </div>

                <div class="form-group row">
                    <label class="col-md-1">主辦單位：</label>
                    <label class="col-md-3">{{classInfo.Organizer}}</label>
                </div>

                <div class="form-group row">
                    <label class="col-md-1">講師：</label>
                    <label class="col-md-3">{{classInfo.Instructor}}</label>
                </div>

                <div class="form-group row">
                    <label class="col-md-1">課程日期：</label>
                    <label class="col-md-3">{{classInfo.Date}}</label>
                </div>

                <div class="form-group row">
                    <label class="col-md-1">課程時數：</label>
                    <label class="col-md-3">{{classInfo.Hours}}</label>
                </div>

                <div class="form-group row">
                    <label class="col-md-1">課程費用：</label>
                    <label class="col-md-3">{{classInfo.Fee}}</label>
                </div>

                <div class="form-group row">
                    <label class="col-md-1">承辦人：</label>
                    <label class="col-md-3">{{classInfo.Contact}}</label>
                </div>
            </div>

            <div class="well form-group" id="PassInfo" style="display: none">
                <p>以下為本線上教室的通過條件，請務必詳細閱讀。</p>

                <table class="table-bordered" id="PassInfoTb">
                    <tbody>
                        <tr style="margin-top:10px;">
                            <th>學習活動</th>
                            <th>通過條件</th>
                            <th>佔總分比例</th>
                        </tr>

                        <tr>
                            <td>課程總分</td>
                            <td></td>
                            <td>100%</td>
                        </tr>

                        <tr>
                            <td>{{passInfos[0].ExamName}}</td>
                            <td>{{passInfos[0].ExamPassScore}}</td>
                            <td></td>
                        </tr>

                        <tr>
                            <td>上課表現</td>
                            <td></td>
                            <td></td>
                        </tr>

                        <tr>
                            <td>總閱讀時數</td>
                            <td></td>
                            <td></td>
                        </tr>

                        <tr v-for="item in passInfos">
                            <td>{{item.ChapterName}}</td>
                            <td>{{item.PassCondition}}</td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
