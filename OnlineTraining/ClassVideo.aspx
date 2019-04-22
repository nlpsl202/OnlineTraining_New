<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClassVideo.aspx.cs" Inherits="OnlineTraining.ClassVideo" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>OnlineTraining</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <style>
        form {
            margin: 0 auto;
            width: 800px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#Back_btn").click(function () {
                var para = { 'ReadTime': $('#Label1').text() };
                $.ajax({
                    type: "POST",
                    url: "ClassVideo.aspx/ExitVideo",
                    data: JSON.stringify(para),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        window.location = "<%:Session["ClassVideoBackPage"]%>";
                    }
                });
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6 col-sm-offset-3" id="myNavbar">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick"></asp:Timer>
                                閱讀時間：<asp:Label ID="Label1" runat="server" Text="00:00:00" Width="95px"></asp:Label>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <button type="button" class="btn btn-primary btn-block" id="Back_btn">結束閱讀並紀錄時數</button>
                    </div>
                </div>
            </div>
        </nav>

        <object width="800" height="600" id="player">
            <param name="movie" value='<%:Session["VideoPath"]%>'>
            <param name="allowFullScreen" value="true" />
            <param name="allowscriptaccess" value="always" />
        </object>
    </form>
</body>
</html>
