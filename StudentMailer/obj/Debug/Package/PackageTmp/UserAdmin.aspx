<%@ Page Title="Student Mailer-User Admin " Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master"
    CodeBehind="UserAdmin.aspx.cs" Inherits="StudentMailer.UserAdmin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">

<script type="text/javascript" language="javascript">
    function SelectAllCheckboxes(spanChk) {
        var oItem = spanChk.children;
        var theBox = (spanChk.type == "checkbox") ?
        spanChk : spanChk.children.item[0];
        xState = theBox.checked;
        elm = theBox.form.elements;
        for (i = 0; i < elm.length; i++)
            if (elm[i].type == "checkbox" &&
              elm[i].id != theBox.id) {
                if (elm[i].checked != xState)
                    elm[i].click();
            }
    }   
    </script>

    <style type="text/css">
        .GridRight
        {
            width: 267px;
        }
        
        #chkAll
        {
            width: 92px;
        }
        
    </style>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server" ID="CategoryUpdatePanel1">
        <ContentTemplate>
             <asp:Panel ID="user_Panel" runat="server" Width="600px" BorderColor="Silver"
                 BorderStyle="None" Visible="true" CssClass="FilterPanelHeader">
                 <asp:Label ID="lb_goups" runat="server" Text="Select A Group To View Its Users"
                    Font-Bold="True"></asp:Label>
                &nbsp;<br />
                 <asp:DropDownList ID="Groups_dropdownlist" runat="server" AutoPostBack="True" Height="23px"
                    Width="121px" OnSelectedIndexChanged="OnSelectedIndexChanged_Groups_dropdownlist" ToolTip="Operator Users are displayed in default View">
                    <asp:ListItem Text="--Select Roles--" Value="3" Enabled="true" />
                    <asp:ListItem Text="Staff" Value="1" Enabled="true" />
                    <asp:ListItem Text="Admin" Value="2" Enabled="true" />
                    <asp:ListItem Text="Operator" Value="3" Enabled="true" />
                 </asp:DropDownList>
                 <br />
                 <br />
               <asp:Label ID="lb_ResultFeedback" runat="server" Font-Bold="True" 
                             ForeColor="Black" BorderStyle="Outset" Width="199px" 
                    BorderColor="#006600" Height="20px" Visible="false" ></asp:Label >
                <asp:Panel ID="gridPanel" runat="server" Height="290px"
                     ScrollBars="Auto" CssClass="center_margin" Width="582px">
                 <asp:GridView ID="gv_UserInRoles" runat="server" CssClass="Contracts_GridView" 
                        Width="568px" Height="290px"  DataKeyNames="Email">
                   <RowStyle BackColor="#FFFFFE" ForeColor="#333333" />
                        <HeaderStyle Wrap="true" BackColor="#006600" ForeColor="#FFFFFF" Height="2px" Width="600px"
                            HorizontalAlign="Center" VerticalAlign="Top" />
                        <Columns>
                        <asp:TemplateField ControlStyle-Width="18">
                                <HeaderTemplate> 
                                    <asp:Label ID="Label1" runat="server" ToolTip="Check Box To Email All User" />
                                    <input ID="chkAll" onclick="javascript:SelectAllCheckboxes(this);" runat="server"
                                        type="checkbox" title="Check Box To Email All User" />
                                </HeaderTemplate>
                                <EditItemTemplate>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cb_select" runat="server" ToolTip="Check Box To Individually Email User" Width="20" />
                                </ItemTemplate>
                                <ControlStyle Width="18px"></ControlStyle>
                            </asp:TemplateField>
                            </Columns>
                        <AlternatingRowStyle BackColor="#BBCB97" />
                    </asp:GridView>
                    </asp:Panel>
               <asp:Panel runat="server" ID="FilterPanelHeader" Style="margin-top: 10px;" BorderStyle="None"
                        BorderColor="White" Width="586px" CssClass="center_margin">
                        <asp:Button ID="Btn_EmailStaff" runat="server" Text="Email Staff" 
                            OnClick="Btn_EmailStaff_Click" Width="560px" />
                    </asp:Panel>   
                <asp:Panel runat="server" ID="emailPanel" BorderStyle="None" Width="550px" CssClass="formLayout2" Height="691px" >

                <table  class="center_margin"> 
                <tr> 
                    <td colspan="4"> <asp:Label ID="lb_EmailFeedBack" runat="server" />  </td>
                </tr> 
                       <tr>
                        <td>
                          <asp:FileUpload ID="FileUpload2" runat="server" ToolTip="Browse and attach a file" Visible="false" />
                          <asp:FileUpload ID="fileUpload1" runat="server" Visible="false" /> 
                          <asp:FileUpload ID="fileUpload3" runat="server" Visible="False" /> 
                        <td>
                        </tr>
                               <tr>
                                   <td colspan="2">
                                       <asp:ImageButton ID="ImgBtn_Attachment" runat="server" 
                                           AlternateText="Attach File" Height="24px" 
                                           ImageUrl="~/images/AttachmentIcon.jpg" OnClick="Button2_OnClick" 
                                           ToolTip="Attachment" />
                                       <asp:ImageButton ID="ImgBtn_NewAttachment1" runat="server" 
                                           AlternateText="Attach File" Height="24px" 
                                           ImageUrl="~/images/AttachmentIcon.jpg" OnClick="new_attachment_OnClick" 
                                           ToolTip="Attachment" />
                                       <asp:ImageButton ID="ImgBtn_NewAttachment2" runat="server" 
                                           AlternateText="Attach File" Height="24px" 
                                           ImageUrl="~/images/AttachmentIcon.jpg" OnClick="new_attachment1_OnClick" 
                                           ToolTip="Attachment" />
                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <asp:Label ID="lb_FROM" runat="server" Text="FROM" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_FROM" runat="server" Width="407px" />
                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <asp:Label ID="cb_TO" runat="server" Text="TO" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_To" runat="server" Font-Bold="True" Width="407px" 
                                           ToolTip="List of Selected Emails" Wrap="false" ReadOnly="True" 
                                           TextMode="MultiLine" />
                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <asp:Label ID="cb_CC" runat="server" Text=" CC" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_CC" runat="server" Width="407px" />
                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <asp:Label ID="cb_BCC" runat="server" Text="BCC" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_BCC" runat="server" Width="407px" />
                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <asp:Label ID="lb_Subject" runat="server" Text="Subject" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_Subject" runat="server" Width="407px" />
                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <asp:Label ID="lb_Body" runat="server" Text="Message" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_Body" runat="server" Height="210px" Width="407px" TextMode="MultiLine" />
                                   </td>
                               </tr>
                            </tr>
                       </table>

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="sendButton" runat="server" Text="Send Email" OnClick="sendButton_OnClick" />
                </asp:Panel>
                <asp:CollapsiblePanelExtender TargetControlID="emailPanel" ID="PanelExtender" runat="server"
                        CollapsedSize="0" Collapsed="True" ExpandControlID="FilterPanelHeader" CollapseControlID="FilterPanelHeader"
                        AutoCollapse="False" AutoExpand="False" ImageControlID="Buton" 
                        ExpandDirection="Vertical" />
                </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
<script type="text/javascript" language="javascript">
            function changeButton() {
                var btn = document.getElementById("Btn_UserAdmin");
                if (btn) {
                    btn.className = "CurrentNavButton";
                } else {
                    console.log("didnt change");
                }
            }
            changeButton();
    </script>
</asp:Content>
