<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineTraining.Login" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <script type="text/javascript">
        $(document).ready(function () {
            var totalTxb = $('.txb').length;
            $("#Login_bt").click(function () {
                for (var i = 0; i < totalTxb; i++) {
                    if ($('.txb:eq(' + i + ')').val() == '') {
                        alert('請輸入帳號密碼!');
                        return false;
                    }
                }

                var para = { 'Account': $('#Account_txb').val(), 'Password': $('#Password_txb').val() };

                $.ajax({
                    type: "POST",
                    url: "Login.aspx/LoginCheck",
                    data: JSON.stringify(para),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.indexOf("成功") >= 0) {
                            window.location = "Default.aspx";
                        } else {
                            alert(response.d);
                        }
                    }
                });
            });
        });
    </script>
    <style>
        .vertical-center {
            min-height: 100%; /* Fallback for browsers do NOT support vh unit */
            min-height: 100vh; /* These two lines are counted as one :-)       */
            display: flex;
            align-items: center;
        }
    </style>
</head>
<body>
    <div class="jumbotron vertical-center">
        <div class="container">
            <div class="d-flex justify-content-center h-100">
                <div class="card">
                    <div class="card-header">
                        <h3>Sign In</h3>
                    </div>
                    <div class="card-body">
                        <form id="form1" runat="server">
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <asp:TextBox CssClass="form-control txb" ID="Account_txb" runat="server" placeholder="username"></asp:TextBox>
                            </div>

                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                </div>
                                <asp:TextBox CssClass="form-control txb" ID="Password_txb" runat="server" placeholder="password" TextMode="Password"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <button type="button" class="btn float-right login_btn" id="Login_bt">Login</button>
                                <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
                            </div>
                        </form>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-center links">
                            Don't have an account?<a href="SignUp.aspx">Sign Up</a>
                        </div>
                        <div class="d-flex justify-content-center">
                            <a href="ForgotPassword.aspx">Forgot your password?</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

