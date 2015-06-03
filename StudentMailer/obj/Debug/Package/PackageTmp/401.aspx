    <%@ Page Title="Student Mailer-Basic Query" Language="C#" AutoEventWireup="true" CodeBehind="401.aspx.cs" Inherits="StudentMailer._401" %>

<% @Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head id="Head1" runat="server">
   <title>Welcome To Student Mailer Secure GateWay</title>
   <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    
   <style type="text/css">
        .center_marginLogIn
        { 
            margin-left:auto;
            margin-right:auto;
            padding: 10px;
            margin: auto;
            text-align:center;
            width: 404px;
        } 
    </style>
</head>
<body>
<form id="form1" runat="server" class="center_marginMaster" style="width: 68%; height: 376px"  >
<asp:ToolkitScriptManager ID="TSM" runat="server" EnablePartialRendering="true">
</asp:ToolkitScriptManager> 
    <asp:UpdateProgress ID="UP" runat="server">
        <ProgressTemplate>
            <asp:Panel ID="LoadingPanel" runat="server" CssClass="modalPopup" Width="439px">
                <table>
                    <tr> 
                     <td valign="middle">
                            <img src="images/progress.gif" alt="Progress" style="width: 72px; height: 69px" />
                        </td>
                        <td valign="middle">
                            <asp:Label ID="LoadingLabel" Text="Loading..." runat="server" />
                        </td>
                    </tr>
                </table> 
            </asp:Panel>
            <asp:ModalPopupExtender ID="LoadingPanel_ModalPopupExtender" runat="server" Enabled="True"
                TargetControlID="UP" PopupControlID="UP" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
    </ProgressTemplate>
    </asp:UpdateProgress>  
<table class="center_margin"  style="width: 71%; height: 245px;" >  
    <tr>  
     <td class="style2"> 
     <asp:ImageButton ID="LogoButton" runat="server" AlternateText="Logo" EnableViewState="false" 
                            ImageUrl="~/images/StudentMailerLogo1.png" PostBackUrl="~/Default.aspx" 
                            Width="157px" BackColor="White" BorderStyle="None" 
                            ImageAlign="Left"/> 
         <br />
        <table class="center_margin" 
             style="border: thick ridge #008000; width: 100%; height: 183px;" >
             <tr> 
             <td> 
               <asp:Label ID="Lb_FeedBack" runat="server" Text="Access Denied, Please contact ITNG" /> 
             </td>
             </tr>
             <tr>  
             </tr>
            </table>
           </td>
           </tr> 
        </table>
        </table>  
    </form>
</body>
</html>