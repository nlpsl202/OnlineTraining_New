<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClassApply.aspx.cs" Inherits="OnlineTraining.ClassApply" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var ApplyTime = moment().format('YYYY/MM/DD');
            $("#applyDate").html(ApplyTime);

            $.ajax({
                type: "GET",
                url: "api/Member",
                data: { Account:"<%:Session["Account"]%>" },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    new Vue({
                        el: '#memberInfo',
                        data: {
                            info: JSON.parse(response)
                        },
                    });
                }
            });

            $.ajax({
                type: "GET",
                url: "api/Class",
                data: { ClassNo: sessionStorage.getItem("ClassNo") },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    new Vue({
                        el: '#classInfo',
                        data: {
                            info: JSON.parse(response)
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

        table > tbody > tr > td:nth-child(1) {
            height: 30px;
            width: 200px;
        }

        table > tbody > tr > td:nth-child(2) {
            height: 30px;
            width: 1000px;
        }

        table > tbody > tr > td {
            padding-left: 10px;
        }
    </style>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group row row-bordered">
                <div class="col-md-12">
                    <span>目前頁面 》課程申請報名-內訓申請單</span>
                </div>
            </div>

            <div class="form-group">
                <ul class="nav nav-tabs">
                    <li id="tab" class="active"><a>課程申請單</a></li>
                </ul>

                <table class="table-bordered" id="memberInfo">
                    <tbody>
                        <tr style="margin-top: 10px;">
                            <td>申請人</td>
                            <td><%:Session["MemberName"]%>(<%:Session["Account"]%>)</td>
                        </tr>

                        <tr>
                            <td>部門</td>
                            <td>
                                <select class="selectpicker">
                                    <option value="O">外部客戶</option>
                                    <option value="I">內部員工</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td>電話</td>
                            <td>{{info.Phone}}</td>
                        </tr>

                        <tr>
                            <td>電子郵件</td>
                            <td>{{info.Email}}</td>
                        </tr>
                    </tbody>
                </table>
                <table class="table-bordered" id="classInfo">
                    <tbody>
                        <tr>
                            <td>開班名稱</td>
                            <td>{{info.ClassName}}</td>
                        </tr>

                        <tr>
                            <td>開班屬性</td>
                            <td>{{info.OpenType}}</td>
                        </tr>

                        <tr>
                            <td>課程屬性</td>
                            <td>{{info.ClassType}}</td>
                        </tr>

                        <tr>
                            <td>主辦單位</td>
                            <td>{{info.Organizer}}</td>
                        </tr>

                        <tr>
                            <td>課程日期</td>
                            <td>{{info.Date}}</td>
                        </tr>

                        <tr>
                            <td>課程時數</td>
                            <td>{{info.Hours}}小時</td>
                        </tr>

                        <tr>
                            <td>課程費用</td>
                            <td>{{info.Fee}}元</td>
                        </tr>

                        <tr>
                            <td>實際費用</td>
                            <td>{{info.Fee}}元</td>
                        </tr>

                        <tr>
                            <td>申請日期</td>
                            <td id="applyDate"></td>
                        </tr>

                        <tr>
                            <td>申請理由</td>
                            <td>
                                <textarea class="form-control" id="ApplyReason" rows="3" style="width: 500px"></textarea></td>
                        </tr>

                        <tr>
                            <td>備註</td>
                            <td>
                                <textarea class="form-control" id="ApplyMemo" rows="3" style="width: 500px"></textarea></td>
                        </tr>

                        <tr>
                            <td>附件</td>
                            <td>
                                <input type="file" id="AttachFilePath" name="AttachFilePath"></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="form-group">
                <div class="col-md-2">
                    <button type="button" class="btn btn-primary btn-block" id="Submit_btn">送出申請單</button>
                </div>
                <div class="col-md-2 ">
                    <button type="button" class="btn btn-default btn-block" id="Reset_btn">重置</button>
                </div>
                <div class="col-md-2 ">
                    <button type="button" class="btn btn-default btn-block" id="Back_btn">返回</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
