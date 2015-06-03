<%@ Page Title="Student Mailer Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" Inherits="StudentMailer._Default" Codebehind="Default.aspx.cs" %>
<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="PageBoby" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page Functionality Summary Table --%>
    <asp:Panel ID="MainPanel" runat="server" Width="700px" BorderStyle="None" CssClass="center_margin">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>   
<asp:Label ID="Label1" runat="server" BackColor="#CFE3A4" ForeColor="#808080"/> <br />  <br />
   <table align="center">
       <tr> 
          <td align="left"> <asp:Label runat="server" Text="Build Basic Search Statement and Email Students "  /> </td>
          <td align="left">  <a href="Basic_Query.aspx">Basic Search</a>  </td>
       </tr>
        <tr> 
          <td align="left"><asp:Label runat="server" Text="Build Dynamic Search Statement, Save Search and Email Students " />  </td>
          <td align="left" class="style3"> <a href="Advanced_Query.aspx">Advance Search </a> </td>
       </tr>
        <tr> 
          <td align="left"> <asp:Label runat="server" Text="Build Combination Of Saved Search" /> </td>
          <td align="left"> <a href="UnionSearch.aspx">Merge Search</a>  </td>
       </tr>
        <tr> 
          <td align="left"> <asp:Label runat="server" Text="Manage StudentMailer Database,Upload,View and Load Data" />  </td>
          <td align="left"> <a href="DatabaseAdmin.aspx">Database Admin</a> </td>
       </tr> 
       <tr> 
          <td align="left">  <asp:Label runat="server" Text="Manage User Groups, View and Email Groups of Users" /> </td>
          <td align="left">  <a href="UserAdmin.aspx">User Admin</a> </td>
       </tr>
   </table>

     </ContentTemplate>
     </asp:UpdatePanel> 
     </asp:Panel>
     <script type="text/javascript" language="javascript">
         function changeButton() {
             var btn = document.getElementById("Btn_Home");
             if (btn) {
                 btn.className = "CurrentNavButton";
             } else {
                 console.log("didnt change");
             }
         }
         changeButton();
    </script>
</asp:Content>