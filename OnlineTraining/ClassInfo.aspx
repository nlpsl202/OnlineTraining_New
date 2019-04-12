<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClassInfo.aspx.cs" Inherits="OnlineTraining.ClassInfo" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--<link rel="stylesheet" type="text/css" media="screen" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" />-->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <link href="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
    <script type="text/javascript" src="//code.jquery.com/jquery-2.1.1.min.js"></script>
    <!--<script type="text/javascript" src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>-->
    <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#li_ClassInfo').addClass("active");

            $('input[id*="Search_btn"]').click(function () {
                if (isValidDate($('input[id*="StartDate_txb"]').val()) && $('input[id*="EndDate_txb"]').val()) {
                    if ($('input[id*="StartDate_txb"]').val() > $('input[id*="EndDate_txb"]').val()) {
                        alert("開始日期不可大於結束日期！");
                        return false;
                    }
                } else {
                    alert("日期格式錯誤！");
                    return false;
                }
            });
        });

        function isValidDate(dateString) {
            // First check for the pattern
            if (!/^\d{4}\/\d{2}\/\d{2}$/.test(dateString))
                return false;

            // Parse the date parts to integers
            var parts = dateString.split("/");
            var day = parseInt(parts[2], 10);
            var month = parseInt(parts[1], 10);
            var year = parseInt(parts[0], 10);

            // Check the ranges of month and year
            if (year < 1000 || year > 3000 || month == 0 || month > 12)
                return false;

            var monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

            // Adjust for leap years
            if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
                monthLength[1] = 29;

            // Check the range of the day
            return day > 0 && day <= monthLength[month - 1];
        };

        $(function () {
            $('#datetimepickerS').datetimepicker({
                format: 'YYYY/MM/DD'
            });

            $('#datetimepickerE').datetimepicker({
                format: 'YYYY/MM/DD'
            });
        });

        function initMoreButton(s, e) {
            $(s.GetMainElement()).find(".into-classroom").click(function () {

                if (s.InCallback()) return;
                var $btn = $(this);
                s.GetRowValues($btn.attr("data-key"), 'ClassNo', function (values) {
                    var para = { 'ClassNo': values };
                    $.ajax({
                        type: "POST",
                        url: "ClassInfo.aspx/CheckStudent",
                        data: JSON.stringify(para),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d == "isStudent") {
                                para = { 'ClassNo': values, 'BackPage': "ClassInfo.aspx" };
                                $.ajax({
                                    type: "POST",
                                    url: "ClassInfo.aspx/IntoClassroom",
                                    data: JSON.stringify(para),
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        window.location = "Classroom.aspx";
                                    }
                                });
                            } else {
                                if (confirm('您尚未成為本課程學員，請問是否要成為學員?')) {
                                    para = { 'ClassNo': values, 'BackPage': "ClassInfo.aspx" };
                                    $.ajax({
                                        type: "POST",
                                        url: "ClassInfo.aspx/BecomeStudent",
                                        data: JSON.stringify(para),
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (response) {
                                            window.location = "Classroom.aspx";
                                        }
                                    });
                                } else {
                                    return false;
                                }
                            }
                        }
                    });

                });

            });
        }
    </script>
    <style>
        label {
            margin-top: 7px;
        }

        .hidden {
            display: none;
        }

        .row-bordered:after {
            content: "";
            display: block;
            border-bottom: 1px solid #ccc;
            margin: 0 15px;
        }
    </style>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group row row-bordered">
                <div class="col-sm-12">
                    <span>目前頁面 》開班申請報名--開班課程清單</span>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-4 row">
                    <div class="col-sm-5">
                        <label for="Phone_txb">開班名稱：</label>
                    </div>
                    <div class="col-sm-7">
                        <asp:TextBox ID="ClassName_txb" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                    </div>
                </div>

                <div class="col-sm-4 row">
                    <div class="col-sm-5">
                        <label for="Phone_txb">講師：</label>
                    </div>
                    <div class="col-sm-7">
                        <asp:TextBox ID="Instructor_txb" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                    </div>
                </div>

                <div class="col-sm-4 row">
                    <div class="col-sm-5">
                        <label for="Phone_txb">承辦人：</label>
                    </div>
                    <div class="col-sm-7">
                        <asp:TextBox ID="Organizer_txb" runat="server" CssClass="form-control" MaxLength="30"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-4 row">
                    <div class="col-sm-5">
                        <label for="Phone_txb">開班屬性：</label>
                    </div>
                    <div class="col-sm-7">
                        <asp:DropDownList ID="OpenType_ddl" CssClass="form-control" runat="server">
                            <asp:ListItem Value="ALL">全部</asp:ListItem>
                            <asp:ListItem Value="In">內訓</asp:ListItem>
                            <asp:ListItem Value="Out">外訓</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="col-sm-4 row">
                    <div class="col-sm-5">
                        <label for="Phone_txb">搜尋範圍：</label>
                    </div>
                    <div class="col-sm-7">
                        <asp:DropDownList ID="StartType_ddl" CssClass="form-control" runat="server">
                            <asp:ListItem Value="ALL">全部</asp:ListItem>
                            <asp:ListItem Value="apply">可申請報名</asp:ListItem>
                            <asp:ListItem Value="direct">可進入教室</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="col-sm-4 row">
                    <div class="col-sm-5">
                        <label>課程屬性：</label>
                    </div>
                    <div class="col-sm-7">
                        <asp:DropDownList ID="ClassType_ddl" CssClass="form-control" runat="server">
                            <asp:ListItem Value="ALL">全部</asp:ListItem>
                            <asp:ListItem Value="Off">面授課程</asp:ListItem>
                            <asp:ListItem Value="On">線上課程</asp:ListItem>
                            <asp:ListItem Value="Set">套裝課程</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-4 row">
                    <div class="col-sm-5">
                        <label>課程日期：</label>
                    </div>
                    <div class='col-sm-7'>
                        <div class="form-group">
                            <div class='input-group date' id='datetimepickerS'>
                                <asp:TextBox ID="StartDate_txb" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4 row">
                    <div class="col-sm-1 text-center">
                        <label for="to" style="margin-top: 8px">to</label>
                    </div>
                    <div class='col-sm-7'>
                        <div class="form-group">
                            <div class='input-group date' id='datetimepickerE'>
                                <asp:TextBox ID="EndDate_txb" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2 col-sm-offset-2">
                        <asp:Button ID="Search_btn" runat="server" Text="搜尋" CssClass="btn btn-primary" OnClick="Search_btn_Click" />
                    </div>

                </div>
            </div>

            <dx:BootstrapGridView ID="BootstrapGridView1" runat="server">
                <ClientSideEvents Init="initMoreButton" EndCallback="initMoreButton" />
                <Columns>
                    <dx:BootstrapGridViewDataColumn FieldName="ClassNo" Visible="false" />
                    <dx:BootstrapGridViewDataColumn FieldName="OpenType" Caption="開班屬性" />
                    <dx:BootstrapGridViewDataColumn FieldName="ClassName" Caption="開班名稱" />
                    <dx:BootstrapGridViewDataColumn FieldName="ClassType" Caption="課程屬性" />
                    <dx:BootstrapGridViewDataColumn FieldName="Date" Caption="課程日期" />
                    <dx:BootstrapGridViewDataColumn FieldName="Hours" Caption="時數" />
                    <dx:BootstrapGridViewDataColumn FieldName="Organizer" Caption="主辦單位" />
                    <dx:BootstrapGridViewDataColumn FieldName="StartType" Visible="false" />
                    <dx:BootstrapGridViewDataColumn Caption="">
                        <DataItemTemplate>
                            <button type="button" class='<%# DataBinder.Eval(Container.DataItem, "StartType").ToString() == "direct" ? "hidden" : String.Empty %> btn btn-default apply-class' data-key="<%# Container.VisibleIndex %>">申請</button>
                            <button type="button" class='<%# DataBinder.Eval(Container.DataItem, "StartType").ToString() == "apply" ? "hidden" : String.Empty %> btn btn-default into-classroom' data-key="<%# Container.VisibleIndex %>">進入教室</button>
                        </DataItemTemplate>
                    </dx:BootstrapGridViewDataColumn>
                </Columns>
                <SettingsPager PageSize="10" />
            </dx:BootstrapGridView>
        </div>
    </div>
</asp:Content>
