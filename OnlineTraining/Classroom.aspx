<%@ Page Language="C#" MasterPageFile="~/Site_Classroom.Master" AutoEventWireup="true" CodeBehind="Classroom.aspx.cs" Inherits="OnlineTraining.Classroom" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function initMoreButton(s, e) {
            $(s.GetMainElement()).find(".into-video").click(function () {
                if (s.InCallback()) return;
                var $btn = $(this);
                s.GetRowValues($btn.attr("data-key"), 'ClassNo;ChapterNo;VideoPath', function (values) {
                    var para = { 'ClassNo': values[0], 'ChapterNo': values[1], 'VideoPath': values[2], 'BackPage': "Classroom.aspx" };
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
        }
    </script>
    <style>
        .hidden {
            display: none;
        }
    </style>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-offset-2 col-sm-8">
                <span>開班名稱：[English] VIVOTEK ONLINE TRAINING</span>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-offset-2 col-sm-8">
                <span>學習活動 (課程日期:2015/05/28~2130/05/31)</span>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-offset-2 col-sm-8">
                <dx:BootstrapGridView ID="BootstrapGridView1" runat="server">
                    <ClientSideEvents Init="initMoreButton" EndCallback="initMoreButton" />
                    <Columns>
                        <dx:BootstrapGridViewDataColumn FieldName="ClassNo" Visible="false" />
                        <dx:BootstrapGridViewDataColumn FieldName="ChapterNo" Visible="false" />
                        <dx:BootstrapGridViewDataColumn FieldName="ChapterName" Caption="活動名稱" />
                        <dx:BootstrapGridViewDataColumn Caption="進行活動">
                            <DataItemTemplate>
                                <div style="height: 50px; width: 100%; text-align: center">
                                    <a href="#"><span class="<%# DataBinder.Eval(Container.DataItem, "Sort").ToString() == "2" ? "hidden" : String.Empty %> glyphicon glyphicon-play-circle into-video" style="font-size: 30px;" data-key="<%# Container.VisibleIndex %>"></span></a>
                                    <a href="Exam.aspx"><span class="<%# DataBinder.Eval(Container.DataItem, "Sort").ToString() == "1" ? "hidden" : String.Empty %> glyphicon glyphicon-pencil" style="font-size: 30px;" data-key="<%# Container.VisibleIndex %>"></span></a>
                                </div>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewDataColumn>
                        <dx:BootstrapGridViewDataColumn FieldName="StartDateType" Caption="活動期間" />
                        <dx:BootstrapGridViewDataColumn FieldName="PassCondition" Caption="通過條件" />
                        <dx:BootstrapGridViewDataColumn FieldName="ReadTime" Caption="學習成果" />
                        <dx:BootstrapGridViewDataColumn FieldName="Pass" Caption="通過狀態" />
                        <dx:BootstrapGridViewDataColumn FieldName="VideoPath" Visible="false" />
                    </Columns>
                </dx:BootstrapGridView>
            </div>
        </div>
    </div>
</asp:Content>
