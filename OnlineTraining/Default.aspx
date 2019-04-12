<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="OnlineTraining._Default" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#li_Default').addClass("active");
        });

        function initMoreButton(s, e) {
            $(s.GetMainElement()).find(".play-video").click(function () {
                if (s.InCallback()) return;
                var $btn = $(this);
                s.GetRowValues($btn.attr("data-key"), 'ClassNo;ChapterNo;VideoPath', function (values) {
                    var para = { 'ClassNo': values[0], 'ChapterNo': values[1], 'VideoPath': values[2], 'BackPage': "Default.aspx" };
                    $.ajax({
                        type: "POST",
                        url: "Classroom.aspx/StartStudy",
                        data: JSON.stringify(para),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            window.location = "ClassVideo.aspx";
                        }
                    });

                });
            });

            $(s.GetMainElement()).find(".into-classroom").click(function () {
                if (s.InCallback()) return;
                var $btn = $(this);
                s.GetRowValues($btn.attr("data-key"), 'ClassNo', function (values) {
                    var para = { 'ClassNo': values, 'BackPage': "Default.aspx" };
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
        p {
            font-size: 15px;
        }

        .centerText {
            text-align: center;
        }

        .gridview > .panel > table > tbody > tr > td {
            border-style: none;
            box-shadow: none;
        }

        .nav-tabs {
            border-bottom: none;
        }

            .nav-tabs > li {
                margin-bottom: 0;
            }
    </style>
    <div class="row">
        <div class="col-md-12">
            <p><%:Session["MemberName"]%>  您好!</p>

            <ul class="nav nav-tabs">
                <li class="active"><a>最新消息</a></li>
            </ul>
            <div>
                <dx:BootstrapGridView ID="BootstrapGridView_News" runat="server">
                    <Columns>
                        <dx:BootstrapGridViewDataColumn FieldName="NewsTitle" Visible="false" />
                        <dx:BootstrapGridViewDataColumn FieldName="NewsLink" Visible="false" />
                        <dx:BootstrapGridViewDataColumn CssClasses-DataCell="centerText">
                            <DataItemTemplate>
                                <dx:BootstrapImage ID="BootstrapImage_Dot" runat="server" ImageUrl="img/dot.png" Height="10px" Width="10px"></dx:BootstrapImage>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewDataColumn>
                        <dx:BootstrapGridViewDataColumn>
                            <DataItemTemplate>
                                <a href="<%# DataBinder.Eval(Container.DataItem, "NewsLink").ToString()%>"><%# DataBinder.Eval(Container.DataItem, "NewsTitle").ToString()%></a>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewDataColumn>
                    </Columns>
                    <Settings ShowColumnHeaders="false" />
                    <CssClasses Row="gridRows" Control="gridview" PreviewRow="gridview" />
                </dx:BootstrapGridView>
            </div>

            <ul class="nav nav-tabs">
                <li class="active"><a>最近閱讀課程</a></li>
            </ul>
            <div>
                <dx:BootstrapGridView ID="BootstrapGridView_Record" runat="server">
                    <ClientSideEvents Init="initMoreButton" EndCallback="initMoreButton" />
                    <Columns>
                        <dx:BootstrapGridViewDataColumn FieldName="ClassNo" Visible="false" />
                        <dx:BootstrapGridViewDataColumn FieldName="ChapterNo" Visible="false" />
                        <dx:BootstrapGridViewDataColumn FieldName="VideoPath" Visible="false" />
                        <dx:BootstrapGridViewDataColumn Caption="播放課程" CssClasses-DataCell="centerText">
                            <DataItemTemplate>
                                <a href="#"><span class="glyphicon glyphicon-play-circle play-video" style="font-size: 25px;" data-key="<%# Container.VisibleIndex %>"></span></a>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewDataColumn>
                        <dx:BootstrapGridViewDataColumn Caption="進入教室" CssClasses-DataCell="centerText">
                            <DataItemTemplate>
                                <a href="#"><span class="glyphicon glyphicon-log-in into-classroom" style="font-size: 25px;" data-key="<%# Container.VisibleIndex %>"></span></a>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewDataColumn>
                        <dx:BootstrapGridViewDataColumn FieldName="ClassName" Caption="最近閱讀課程名稱" CssClasses-HeaderCell="centerText" />
                    </Columns>
                    <SettingsBehavior AllowSort="false" />
                </dx:BootstrapGridView>
            </div>
        </div>
    </div>
</asp:Content>
