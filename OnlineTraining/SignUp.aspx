<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="OnlineTraining.SignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#Reset_btn").click(function () {
                $(this).closest('form').find("input[type=text], textarea,input[type=password],input[type=email]").val("");
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

                if ($('#Password_txb').val() != $('#PasswordConfirm_txb').val()) {
                    alert('密碼與確認密碼不相符!');
                    return false;
                }

                var para =
                    {
                        'Account': $('#Account_txb').val(), 'Password': $('#Password_txb').val(),
                        'FirstName': $('#FirstName_txb').val(), 'MidName': $('#MidName_txb').val(),
                        'LastName': $('#LastName_txb').val(), 'Email': $('#Email_txb').val(),
                        'Gender': $("input:radio[name='Gender_rdo']:checked").val(), 'CompanyType': $('#CompanyType_ddl :selected').val(),
                        'CompanyName': $('#CompanyName_txb').val(), 'Division': $('#Division_txb').val(),
                        'Country': $('#Country_ddl :selected').val(), 'Address': $('#Address_txb').val(),
                        'Title': $('#Title_txb').val(), 'Phone': $('#Phone_txb').val()
                    };

                $.ajax({
                    type: "POST",
                    url: "SignUp.aspx/InsertToMember",
                    data: JSON.stringify(para),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        alert(response.d);
                        if (response.d.indexOf("成功") >= 0) {
                            window.location = "Login.aspx";
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <h1>帳號申請</h1>
            </div>
        </div>
    </div>

    <div class="container">
        <form class="form-horizontal" id="form1" runat="server">
            <div class="form-group">
                <div class="col-md-2 col-md-offset-6">
                    <button type="button" class="btn btn-primary btn-block" id="Back_btn">返回</button>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="Account_lbl" runat="server" Text="帳號：" AssociatedControlID="Account_txb"></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox CssClass="form-control txb" ID="Account_txb" runat="server" placeholder="帳號"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="Password_lbl" runat="server" Text="密碼：" AssociatedControlID="Password_txb"></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox CssClass="form-control txb" ID="Password_txb" runat="server" TextMode="Password" placeholder="密碼"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="PasswordConfirm_lbl" runat="server" Text="確認密碼：" AssociatedControlID="PasswordConfirm_txb"></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox CssClass="form-control txb" ID="PasswordConfirm_txb" runat="server" TextMode="Password" placeholder="確認密碼"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="Name_lbl" runat="server" Text="姓名：" AssociatedControlID="FirstName_txb"></asp:Label>
                <div class="col-md-4">
                    <div style="margin-top: 5px">
                        <asp:TextBox CssClass="form-control txb" ID="FirstName_txb" runat="server" placeholder="FirstName"></asp:TextBox>
                    </div>
                    <div style="margin-top: 5px">
                        <asp:TextBox CssClass="form-control txb" ID="MidName_txb" runat="server" placeholder="MidName"></asp:TextBox>
                    </div>
                    <div style="margin-top: 5px">
                        <asp:TextBox CssClass="form-control txb" ID="LastName_txb" runat="server" placeholder="LastName"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="Email_lbl" runat="server" AssociatedControlID="Email_txb" Text="EMail："></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox CssClass="form-control txb" ID="Email_txb" runat="server" placeholder="Email" TextMode="Email"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="Gender_lbl" runat="server" AssociatedControlID="Gender_rdo" Text="性別："></asp:Label>
                <div class="col-md-4">
                    <asp:RadioButtonList ID="Gender_rdo" RepeatLayout="Flow" RepeatDirection="Horizontal" runat="server">
                        <asp:ListItem class="radio-inline" Value="M" Text="男" Selected="True"></asp:ListItem>
                        <asp:ListItem class="radio-inline" Value="W" Text="女"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="CompanyType_lbl" runat="server" AssociatedControlID="CompanyType_ddl" Text="公司種類："></asp:Label>
                <div class="col-md-4">
                    <asp:DropDownList CssClass="form-control" ID="CompanyType_ddl" runat="server">
                        <asp:ListItem Value="a">a</asp:ListItem>
                        <asp:ListItem Value="b">b</asp:ListItem>
                        <asp:ListItem Value="c">c</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="CompanyName_lbl" runat="server" AssociatedControlID="CompanyName_txb" Text="公司名稱："></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox CssClass="form-control txb" ID="CompanyName_txb" runat="server" placeholder="公司名稱"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="Division_lbl" runat="server" AssociatedControlID="Division_txb" Text="部門："></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox CssClass="form-control txb" ID="Division_txb" placeholder="部門" runat="server"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="Country" runat="server" AssociatedControlID="Country_ddl" Text="國家："></asp:Label>
                <div class="col-md-4">
                    <asp:DropDownList CssClass="form-control" ID="Country_ddl" runat="server">
                        <asp:ListItem Value="Taiwan">Taiwan</asp:ListItem>
                        <asp:ListItem Value="America">America</asp:ListItem>
                        <asp:ListItem Value="Japan">Japan</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="Address_lbl" runat="server" AssociatedControlID="Address_txb" Text="聯絡地址："></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox CssClass="form-control txb" ID="Address_txb" placeholder="聯絡地址" runat="server"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="Title_lbl" runat="server" AssociatedControlID="Title_txb" Text="職稱："></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox CssClass="form-control txb" ID="Title_txb" placeholder="聯絡地址" runat="server"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <asp:Label CssClass="col-md-2 control-label col-md-offset-2" ID="Phone_lbl" runat="server" AssociatedControlID="Phone_txb" Text="聯絡電話："></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox CssClass="form-control txb" ID="Phone_txb" placeholder="聯絡電話" runat="server"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-offset-4 col-md-2">
                    <button type="button" class="btn btn-primary btn-block" id="Submit_btn">送出申請</button>
                </div>
                <div class="col-md-2 ">
                    <button type="button" class="btn btn-default btn-block" id="Reset_btn">重置</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
