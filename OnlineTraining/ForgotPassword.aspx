<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="OnlineTraining.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#Reset_btn").click(function () {
                $(".txb").val("");
            });
            $("#Back_btn").click(function () {
                window.location = 'Login.aspx';
            });
            var totalTxb = $('.txb').length;
            $("#Submit_btn").click(function () {
                for (var i = 0; i < totalTxb; i++) {
                    if ($('.txb:eq(' + i + ')').val() == '') {
                        alert('尚有未輸入的資料!');
                        return false;
                    }
                }
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <h1>忘記密碼</h1>
            </div>
        </div>
    </div>

    <div class="container">
        <form class="form-horizontal" id="form1" runat="server">
            <div class="form-group">
                <div class="col-md-2 col-md-offset-6">
                    <input class="btn btn-primary btn-block" id="Back_btn" type="button" value="返回" />
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="Account_lbl" runat="server" Text="帳號：" AssociatedControlID="Account_txb"></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox CssClass="form-control txb" ID="Account_txb" runat="server" placeholder="帳號"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="Email_lbl" runat="server" AssociatedControlID="Email_txb" Text="EMail："></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox CssClass="form-control txb" ID="Email_txb" runat="server" placeholder="Email" TextMode="Email"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-offset-4 col-md-2">
                    <asp:Button CssClass="btn btn-primary btn-block" ID="Submit_btn" runat="server" Text="確定" OnClick="Submit_btn_Click" />
                </div>
                <div class="col-md-2 ">
                    <input class="btn btn-default btn-block" id="Reset_btn" type="button" value="重置" />
                </div>
            </div>
        </form>
    </div>
</body>
</html>


