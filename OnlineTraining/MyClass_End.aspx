<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyClass_End.aspx.cs" Inherits="OnlineTraining.MyClass_End" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<asp:Content ID="Content1" ContentPlaceHolderID="LeftContent" runat="server">
    <!--<link rel="stylesheet" type="text/css" media="screen" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" />-->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <link href="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
    <script type="text/javascript" src="//code.jquery.com/jquery-2.1.1.min.js"></script>
    <!--<script type="text/javascript" src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>-->
    <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".left-ul > li").removeClass("active");
            $("#li_Studied").addClass("active");

            $("#li_Studying").click(function () {
                window.location = "MyClass.aspx";
            });
    </script>
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <ul class="nav nav-pills nav-stacked left-ul">
                <li id="li_Studying"><a href="MyClass.aspx">學習中課程列表</a></li>
                <li id="li_Studied" class="active"><a href="MyClass_End.aspx">學習後課程列表</a></li>
            </ul>
        </div>

    </div>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
            $(document).ready(function () {
                $('#li_MyClass').addClass("active");

                $("#Submit_btn").click(function () {
                    var para = { 'ClassName': $('#ClassName_txb').val() };
                    $.ajax({
                        type: "POST",
                        url: "MyClass.aspx/Search",
                        data: JSON.stringify(para),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            alert(response.d);
                        }
                    });
                });
            });

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
                        var para = { 'ClassNo': values, 'BackPage': "MyClass.aspx" };
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

                    });
                });
            }
    </script>
    <style>
        label {
            margin-top: 7px;
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
                <div class="col-md-12">
                    <span>目前頁面 》學習後課程列表</span>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-md-4 row">
                    <div class="col-md-5">
                        <label for="Phone_txb">開班名稱：</label>
                    </div>
                    <div class="col-md-7">
                        <asp:TextBox ID="ClassName_txb" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-md-4 row">
                    <div class="col-md-5">
                        <label for="Phone_txb">通過狀態：</label>
                    </div>
                    <div class="col-md-7">
                        <asp:DropDownList CssClass="form-control" ID="Pass_ddl" runat="server">
                            <asp:ListItem Value="All">全部</asp:ListItem>
                            <asp:ListItem Value="Y">通過</asp:ListItem>
                            <asp:ListItem Value="N">未通過</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-md-4 row">
                    <div class="col-md-5">
                        <label for="Phone_txb">課程日期：</label>
                    </div>
                    <div class="form-group col-md-7">
                        <div class='input-group date' id='datetimepickerS'>
                            <asp:TextBox ID="StartDate_txb" runat="server" CssClass="form-control"></asp:TextBox>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 row">
                    <div class="col-md-1">
                        <label for="Phone_txb">to</label>
                    </div>
                    <div class="form-group col-md-7">
                        <div class='input-group date' id='datetimepickerE'>
                            <asp:TextBox ID="EndDate_txb" runat="server" CssClass="form-control"></asp:TextBox>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-md-2">
                    <asp:Button ID="Button1" runat="server" Text="搜尋" CssClass="btn btn-primary" OnClick="Button1_Click" />
                </div>
            </div>

            <dx:BootstrapGridView ID="BootstrapGridView" runat="server">
                <Columns>
                    <dx:BootstrapGridViewDataColumn FieldName="ClassNo" Visible="false" />
                    <dx:BootstrapGridViewDataColumn FieldName="ClassName" Caption="開班名稱" />
                    <dx:BootstrapGridViewDataColumn FieldName="OpenType" Caption="開班屬性" />
                    <dx:BootstrapGridViewDataColumn FieldName="ClassType" Caption="課程屬性" />
                    <dx:BootstrapGridViewDataColumn FieldName="Date" Caption="課程日期" />
                    <dx:BootstrapGridViewDataColumn FieldName="Pass" Caption="通過狀態" />
                </Columns>
            </dx:BootstrapGridView>
        </div>
    </div>
</asp:Content>
