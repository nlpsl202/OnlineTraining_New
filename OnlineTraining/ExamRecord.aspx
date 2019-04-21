<%@ Page Language="C#" MasterPageFile="~/Site_Classroom.Master" AutoEventWireup="true" CodeBehind="ExamRecord.aspx.cs" Inherits="OnlineTraining.ExamRecord" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function initMoreButton(s, e) {
            $(s.GetMainElement()).find(".to-result").click(function () {
                if (s.InCallback()) return;
                var $btn = $(this);
                s.GetRowValues($btn.attr("data-key"), 'ExamID;ExamNo', function (values) {
                    sessionStorage.setItem("ExamID", values[0]);
                    sessionStorage.setItem("ExamNo", values[1]);
                    location.href = "ExamRecordResult.aspx";
                });
            });
        };

        $(function () {
            $('#datetimepickerS').datetimepicker({
                format: 'YYYY/MM/DD'
            });

            $('#datetimepickerE').datetimepicker({
                format: 'YYYY/MM/DD'
            });
        });
    </script>
    <style>
        label {
            margin-top: 7px;
        }

        .hidden {
            display: none;
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
                <div class="col-sm-12">
                    <span>目前頁面 》測驗結果 - 學員考試紀錄</span>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-4 row">
                    <div class="col-sm-5">
                        <label for="Phone_txb">考卷名稱：</label>
                    </div>
                    <div class="col-sm-7">
                        <asp:TextBox ID="ExamPaperName_txb" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                    </div>
                </div>

                <div class="col-sm-4 row">
                    <div class="col-sm-5">
                        <label for="Phone_txb">及格狀態：</label>
                    </div>
                    <div class="col-sm-7">
                        <asp:DropDownList ID="Pass_ddl" CssClass="form-control" runat="server">
                            <asp:ListItem Value="ALL">全部</asp:ListItem>
                            <asp:ListItem Value="Y">及格</asp:ListItem>
                            <asp:ListItem Value="N">不及格</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-4 row">
                    <div class="col-sm-5">
                        <label>考試完成日期：</label>
                    </div>
                    <div class='col-sm-7'>
                        <div class="form-group">
                            <div class='input-group date' id='datetimepickerS'>
                                <asp:TextBox ID="StartDate_txb" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4 row">
                    <div class="col-sm-1 text-center">
                        <label for="to" style="margin-top: 8px">to</label>
                    </div>
                    <div class='col-sm-7'>
                        <div class="form-group">
                            <div class='input-group date' id='datetimepickerE'>
                                <asp:TextBox ID="EndDate_txb" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-1">
                    <asp:Button ID="Search_btn" runat="server" Text="搜尋" CssClass="btn btn-primary" OnClick="Search_btn_Click" />
                </div>
            </div>

            <dx:BootstrapGridView ID="BootstrapGridView1" runat="server">
                <ClientSideEvents Init="initMoreButton" EndCallback="initMoreButton" />
                <Columns>
                    <dx:BootstrapGridViewDataColumn FieldName="ExamID" Visible="false" />
                    <dx:BootstrapGridViewDataColumn FieldName="ExamNo" Visible="false" />
                    <dx:BootstrapGridViewDataColumn FieldName="ExamPaperName" Caption="考卷名稱">
                        <DataItemTemplate>
                            <button type="button" class='btn btn-link to-result' data-key="<%# Container.VisibleIndex%>"><%# DataBinder.Eval(Container.DataItem, "ExamPaperName").ToString()%></button>
                        </DataItemTemplate>
                    </dx:BootstrapGridViewDataColumn>
                    <dx:BootstrapGridViewDateColumn FieldName="ExamStartTime" Caption="考試開始時間"/>
                    <dx:BootstrapGridViewDateColumn FieldName="ExamFinishTime" Caption="考試完成時間" />
                    <dx:BootstrapGridViewDataColumn FieldName="ExamTime" Caption="實際作答時間" />
                    <dx:BootstrapGridViewDataColumn FieldName="ExamScore" Caption="考試成績" />
                    <dx:BootstrapGridViewDataColumn FieldName="Pass" Caption="及格狀態" />
                </Columns>
                <SettingsPager PageSize="10" />
            </dx:BootstrapGridView>
        </div>
    </div>
</asp:Content>
