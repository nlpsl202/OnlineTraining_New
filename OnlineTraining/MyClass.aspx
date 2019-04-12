<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyClass.aspx.cs" Inherits="OnlineTraining.MyClass" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<asp:Content ID="Content1" ContentPlaceHolderID="LeftContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".left-ul > li").removeClass("active");
            $("#li_Studying").addClass("active");

            $("#li_Studied").click(function () {
                window.location = "MyClass_End.aspx";
            });
        });
    </script>
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <ul class="nav nav-pills nav-stacked left-ul">
                <li id="li_Studying" class="active"><a href="MyClass.aspx">學習中課程列表</a></li>
                <li id="li_Studied"><a href="MyClass_End.aspx">學習後課程列表</a></li>
            </ul>
        </div>
    </div>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#li_MyClass').addClass("active");

            $("#li_Online").click(function () {
                $(".main-ul > li").removeClass("active");
                $("#li_Online").addClass("active");
                $(".gridview").css("display", "none")
                $("#Grdiview_Online").show();
            });

            $("#li_Face").click(function () {
                $(".main-ul > li").removeClass("active");
                $("#li_Face").addClass("active");
                $(".gridview").css("display", "none")
                $("#Grdiview_Face").show();
            });

            $("#li_Set").click(function () {
                $(".main-ul > li").removeClass("active");
                $("#li_Set").addClass("active");
                $(".gridview").css("display", "none")
                $("#Grdiview_Set").show();
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
                    <span>目前頁面 》學習中課程列表</span>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-md-4 row">
                    <div class="col-md-5">
                        <label for="Phone_txb">開班名稱：</label>
                    </div>
                    <div class="col-md-7">
                        <asp:TextBox ID="ClassName_txb" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="col-md-4 col-md-offset-2">
                    <asp:Button ID="Button1" runat="server" Text="搜尋" CssClass="btn btn-primary" OnClick="Button1_Click" />
                </div>
            </div>

            <ul class="nav nav-pills main-ul">
                <li id="li_Online" class="active"><a href="#">線上課程</a></li>
                <li id="li_Face"><a href="#">面授課程</a></li>
                <li id="li_Set"><a href="#">套裝課程</a></li>
            </ul>
            <div id="Grdiview_Online" class="gridview">
                <dx:BootstrapGridView ID="BootstrapGridView_Online" runat="server">
                    <ClientSideEvents Init="initMoreButton" EndCallback="initMoreButton" />
                    <Columns>
                        <dx:BootstrapGridViewDataColumn FieldName="ClassNo" Visible="false" />
                        <dx:BootstrapGridViewDataColumn FieldName="ClassName" Caption="開班名稱" />
                        <dx:BootstrapGridViewDataColumn FieldName="OpenType" Caption="開班屬性" />
                        <dx:BootstrapGridViewDataColumn FieldName="Date" Caption="課程日期" />
                        <dx:BootstrapGridViewDataColumn Caption="進入教室" CssClasses-DataCell="centerText">
                            <DataItemTemplate>
                                <a href="#"><span class="glyphicon glyphicon-log-in into-classroom" style="font-size: 25px;" data-key="<%# Container.VisibleIndex %>"></span></a>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewDataColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <div id="Grdiview_Face" class="gridview" style="display: none">
                <label>待上課課程</label>
                <dx:BootstrapGridView ID="BootstrapGridView_Face1" runat="server">
                    <ClientSideEvents Init="initMoreButton" EndCallback="initMoreButton" />
                    <Columns>
                        <dx:BootstrapGridViewDataColumn FieldName="ClassNo" Visible="false" />
                        <dx:BootstrapGridViewDataColumn FieldName="ClassName" Caption="開班名稱" />
                        <dx:BootstrapGridViewDataColumn FieldName="OpenType" Caption="開班屬性" />
                        <dx:BootstrapGridViewDataColumn FieldName="Date" Caption="課程日期" />
                        <dx:BootstrapGridViewDataColumn Caption="進入教室" CssClasses-DataCell="centerText">
                            <DataItemTemplate>
                                <a href="#"><span class="glyphicon glyphicon-log-in into-classroom" style="font-size: 25px;" data-key="<%# Container.VisibleIndex %>"></span></a>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewDataColumn>
                    </Columns>
                </dx:BootstrapGridView>
                <label>上課中課程</label>
                <dx:BootstrapGridView ID="BootstrapGridView_Face2" runat="server">
                    <ClientSideEvents Init="initMoreButton" EndCallback="initMoreButton" />
                    <Columns>
                        <dx:BootstrapGridViewDataColumn FieldName="ClassNo" Visible="false" />
                        <dx:BootstrapGridViewDataColumn FieldName="ClassName" Caption="開班名稱" />
                        <dx:BootstrapGridViewDataColumn FieldName="OpenType" Caption="開班屬性" />
                        <dx:BootstrapGridViewDataColumn FieldName="Date" Caption="課程日期" />
                        <dx:BootstrapGridViewDataColumn Caption="進入教室" CssClasses-DataCell="centerText">
                            <DataItemTemplate>
                                <a href="#"><span class="glyphicon glyphicon-log-in into-classroom" style="font-size: 25px;" data-key="<%# Container.VisibleIndex %>"></span></a>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewDataColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <div id="Grdiview_Set" class="gridview" style="display: none">
                <dx:BootstrapGridView ID="BootstrapGridView_Set" runat="server">
                    <ClientSideEvents Init="initMoreButton" EndCallback="initMoreButton" />
                    <Columns>
                        <dx:BootstrapGridViewDataColumn FieldName="ClassNo" Visible="false" />
                        <dx:BootstrapGridViewDataColumn FieldName="ClassName" Caption="開班名稱" />
                        <dx:BootstrapGridViewDataColumn FieldName="OpenType" Caption="開班屬性" />
                        <dx:BootstrapGridViewDataColumn FieldName="Date" Caption="課程日期" />
                        <dx:BootstrapGridViewDataColumn Caption="進入教室" CssClasses-DataCell="centerText">
                            <DataItemTemplate>
                                <a href="#"><span class="glyphicon glyphicon-log-in into-classroom" style="font-size: 25px;" data-key="<%# Container.VisibleIndex %>"></span></a>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewDataColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
        </div>
    </div>
</asp:Content>
