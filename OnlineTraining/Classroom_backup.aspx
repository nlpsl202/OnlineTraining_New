<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Classroom_backup.aspx.cs" Inherits="OnlineTraining.Classroom_backup" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="Content/mobile-navbar.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/bootsnipp.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
        function initMoreButton(s, e) {
            $(s.GetMainElement()).find(".more-info").click(function () {
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
</head>
<body>
    <nav class="navbar navbar-fixed-top navbar-bootsnipp animate" role="navigation" style="z-index: 9999999">
        <div class="row">

            <div class="col-sm-10">
                <ul class="nav navbar-nav pull-right">
                    <li class="li">
                        <a href="Classroom.aspx" style="text-align: center">
                            <span class="menu-icon glyphicon glyphicon-home"></span>
                            <p>課程首頁</p>
                        </a>
                    </li>
                    <li class="li">
                        <a href="Classroom.aspx" style="text-align: center">
                            <span class="menu-icon fa fa-info-circle"></span>
                            <p>開班資訊</p>
                        </a>
                    </li>
                    <li class="li">
                        <a href="Classroom.aspx" style="text-align: center">
                            <span class="menu-icon fa fa-user"></span>
                            <p>學習紀錄</p>
                        </a>
                    </li>
                    <li class="text-center">
                        <a href="<%:Session["ClassroomBackPage"]%>">
                            <span class="menu-icon glyphicon glyphicon-log-out"></span>
                            <p>離開</p>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="row">
        <div class="col-sm-offset-1 col-sm-11">
            <h3>開班名稱：[English] VIVOTEK ONLINE TRAINING</h3>
        </div>

        <div class="col-sm-offset-1 col-sm-11">
            <p>學習活動 (課程日期:2015/05/28~2130/05/31)</p>
        </div>

        <div class="col-sm-offset-1 col-sm-10">
            <form runat="server">
                <dx:BootstrapGridView ID="BootstrapGridView1" runat="server">
                    <ClientSideEvents Init="initMoreButton" EndCallback="initMoreButton" />
                    <Columns>
                        <dx:BootstrapGridViewDataColumn FieldName="ClassNo" Visible="false" />
                        <dx:BootstrapGridViewDataColumn FieldName="ChapterNo" Visible="false" />
                        <dx:BootstrapGridViewDataColumn FieldName="ChapterName" Caption="活動名稱" />
                        <dx:BootstrapGridViewDataColumn Caption="進行活動">
                            <DataItemTemplate>
                                <div style="height: 50px; width: 100%; text-align: center">
                                    <a href="#"><span class="glyphicon glyphicon-play-circle more-info" style="font-size: 50px;" data-key="<%# Container.VisibleIndex %>"></span></a>
                                </div>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewDataColumn>
                        <dx:BootstrapGridViewDataColumn FieldName="StartDateType" Caption="活動期間" />
                        <dx:BootstrapGridViewDataColumn FieldName="PassCondition" Caption="通過條件" />
                        <dx:BootstrapGridViewDataColumn FieldName="StudyResult" Caption="學習成果" />
                        <dx:BootstrapGridViewDataColumn FieldName="VideoPath" Visible="false" />
                    </Columns>
                </dx:BootstrapGridView>
            </form>
        </div>
    </div>
</body>
</html>
