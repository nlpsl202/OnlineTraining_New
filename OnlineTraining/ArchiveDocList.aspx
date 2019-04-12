<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArchiveDocList.aspx.cs" Inherits="OnlineTraining.ArchiveDocList" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#li_DocList').addClass("active");
        });
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
                    <span>目前頁面 》歸檔文件</span>
                </div>
            </div>

            <dx:BootstrapGridView ID="BootstrapGridView1" runat="server">
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
