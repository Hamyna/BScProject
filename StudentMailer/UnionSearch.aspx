<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UnionSearch.aspx.cs" Inherits="StudentMailer.UnionSearch"
 MasterPageFile="~/Site.master" ValidateRequest="false"   %>
<% @Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
 
<asp:Content ID="PageBoby" runat="server" ContentPlaceHolderID="MainContent">
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
 <asp:SqlDataSource ID="GetSavedSearch" runat="server" 
             ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
             SelectCommand="Proc_GetSavedSearch" SelectCommandType="StoredProcedure">
             <SelectParameters>
                 <asp:ControlParameter ControlID="UserName" Name="UserName" PropertyName="Text" 
                     Type="String" />
</SelectParameters>
</asp:SqlDataSource>

 <asp:Panel ID="MainPanel" runat="server" CssClass="FilterPanelHeader" Width="700px" BorderStyle="None" >
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <Triggers> 
    </Triggers>
    <ContentTemplate> 
     <asp:Panel ID="Pn_BuildSearch" runat="server" Visible = "true" 
            CssClass="center_margin" Width="497px" BorderStyle="None">
     <asp:Label ID="lb_Error" runat="server" Visible="true" Font-Bold="true" ForeColor="Red"/> 
     <asp:Label ID="UserName" runat="server" Visible="false" Font-Bold="true" ForeColor="Red"/> <br />
      <asp:Label ID="lb_Header" runat="server" Visible="true" Font-Bold="true" ForeColor="Black" Text="Select And Merge Multiple Saved Searches" /> 
         <asp:CheckBoxList ID="cb_SavedSearchList" runat="server" AutoPostBack="True" 
                        BorderColor="#336600" BorderStyle="Solid" Font-Bold="True" Width="389px" 
                        CssClass="center_margin" Height="34px"  
             ToolTip="Display List Of Saved Searches" DataSourceID="GetSavedSearch" 
             DataTextField="SearchName" DataValueField="SearchID" />

         <asp:Button ID="Btn_UnionSearch" runat="server" Visible="true" Text="Merge"  
             CssClass="NavButton" Font-Size="Small" onclick="Btn_UnionSearch_Click" 
             Height="28px" Width="64px" ToolTip="Select To View A Combined Result of Saved Search" /> 
      </asp:Panel>  
      
       <%-- Display Data --%>
         <asp:Panel runat="server" ID="Panel2" Style="margin-top: 10px;" BorderStyle="None" BorderColor="White" ToolTip="Click to Expand Panel">
              <asp:Button ID="Bt_Select" runat="server" 
                  Text="Select Result Field" ToolTip="Click to Expand Panel" 
                  Width="389px" onclick="Bt_Select_Click"  />
          </asp:Panel> 

         <asp:Panel runat="server" ID="Panel3" BorderStyle="Ridge" 
            CssClass="formLayout2" Width="591px" Height="148px" 
            ToolTip="Tick Check Box List To View It In Gridview" >
                        <asp:Label ID="Label1" runat="server" Text="Select Data(s) to Display in Search Result" Font-Bold="true" />
                        <table class="center_margin"> 
                            <tr>
                                <td> <asp:CheckBox runat="server" ID="cb_StudentNumber" Text="Student Number" ToolTip="Check To View Student Number In Gridview" Width="143px" Checked="True"/></td>
                                <td> <asp:CheckBox runat="server" ID="cb_UniversityEmail" Text="Email" Width="58px" 
                                        Checked="True" ToolTip="Check To View Student Email In Gridview" /> </td>
                                <td> <asp:CheckBox runat="server" ID="cb_StudentName" Text="Name" Width="42px" Checked="True" ToolTip="Check To View Student Name In Gridview" /></td> 
                                <td> <asp:CheckBox runat="server" ID="cb_Level" Text="Level"  Width="51px" ToolTip="Check To View Student Level In Gridview"/> </td>
                                <td> <asp:CheckBox runat="server" ID="cb_Module" Text="Module"  Width="51px" ToolTip="Check To View Student Module In Gridview"/> </td>
                                <td> <asp:CheckBox runat="server" ID="cb_Course" Text="Course"  Width="67px" 
                                        ToolTip="Check To View Student Course In Gridview"/></td>
                            </tr>
                            <tr>
                                <td> <asp:CheckBox runat="server" ID="cb_AcademicYear" Text="Academic Year" Width="157px" ToolTip="Check To View Student Academic Year In Gridview"/> </td>
                                <td> <asp:CheckBox runat="server" ID="cb_Faculty" Text="Faculty"  Width="63px" ToolTip="Check To View Student Faculty In Gridview" /> </td>
                                <td> <asp:CheckBox runat="server" ID="cb_Degree" Text="Degree"  Width="84px"  
                                        ToolTip="Check To View Student Degree In Gridview"/> </td>
                                <td> <asp:CheckBox runat="server" ID="cb_Tutor" Text="Tutor"  Width="45px" ToolTip="Check To View Student Tutor In Gridview"/> </td>
                                <td>  <asp:CheckBox runat="server" ID="cb_Programme" Text="Programme"  Width="45px" ToolTip="Check To View Programme In Gridview"/></td> 
                                <td> </td>
                            </tr>
                        </table>
                    </asp:Panel>

         <asp:CollapsiblePanelExtender TargetControlID="Panel3" ID="CollapsiblePanelExtender2" runat="server"
                        CollapsedSize="0" Collapsed="True" ExpandControlID="Panel2" CollapseControlID="Panel2"
                        AutoCollapse="False" AutoExpand="False" ImageControlID="Buton" 
                        ExpandDirection="Vertical"/>

         <%--Result Panel --%> 
         <asp:Label ID="lb_ResultFeedback" runat="server" Font-Bold="True" 
                             ForeColor="Black" BorderStyle="Outset" Width="199px" 
                    BorderColor="#006600" Height="20px" Visible="false" ></asp:Label >

         <asp:Panel ID="gv_Result" runat="server"  Width="670px" ScrollBars="Auto" CssClass="center_margin" >
                 <asp:GridView ID="gv_StudentData" runat="server" CssClass="Contracts_GridView" 
                     Width="644px" Height="16px" AllowSorting="True" ToolTip="Click Header To Sort In Ascenting Or Decending Order" DataKeyNames="Email" >
                   <RowStyle BackColor="#FFFFFE" ForeColor="#333333" />
                        <HeaderStyle Wrap="true" BackColor="#006600" ForeColor="#FFFFFF" Height="2px" Width="600px"
                            HorizontalAlign="Center" VerticalAlign="Top"/>
                        <Columns>
                         <asp:TemplateField ControlStyle-Width="18">
                                <HeaderTemplate>
                                    <input ID="chkAll" onclick="javascript:SelectAllCheckboxes(this);" runat="server"
                                        type="checkbox" title="Check All" name="Check All" value="Check All"/>
                                </HeaderTemplate>
                                <EditItemTemplate>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cb_select" runat="server" ToolTip="Check To Select Email"/>
                                </ItemTemplate>
                                <ControlStyle Width="18px"></ControlStyle>
                            </asp:TemplateField>
                        </Columns>
                        <AlternatingRowStyle BackColor="#BBCB97" />
                    </asp:GridView>
                </asp:Panel> 
         
         <%-- Email Section --%>
         <asp:Panel runat="server" ID="FilterPanelHeader" Style="margin-top: 10px;" BorderStyle="None"
                        BorderColor="White">
              <asp:Button ID="Btn_Email" runat="server" Text="Email Students" 
                  onclick="Btn_Email_Click" ToolTip="Expand Panel To Email Selected Student" 
                  Width="389px" />
         </asp:Panel> 

         <asp:Panel runat="server" ID="emailPanel" BorderStyle="None" Width="600px" 
                        CssClass="formLayout2" Height="472px" >
                       <table  class="center_margin"> 
                       <tr> <td colspan="4"> <asp:Label ID="lb_EmailFeedBack" runat="server" /></td> </tr>
                               <tr>
                                   <td colspan="2">
                                       <asp:FileUpload ID="FileUpload2" runat="server" 
                                           ToolTip="Browse And Attach A File" Visible="false" />
                                       <asp:FileUpload ID="fileUpload1" runat="server" Visible="false"  ToolTip="Browse And Attach A File" />
                                       <asp:FileUpload ID="fileUpload3" runat="server" Visible="False"  ToolTip="Browse And Attach A File" />
                                   </td>
                               </tr>
                               <tr>
                                   <td colspan="2">
                                       <asp:ImageButton ID="ImgBtn_Attachment" runat="server" 
                                           AlternateText="Attach File" Height="24px" 
                                           ImageUrl="~/images/AttachmentIcon.jpg" OnClick="new_Attachment_OnClick" 
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
                                       <asp:TextBox ID="Tb_FROM" runat="server" Width="407px" ToolTip="User Address Is Set As Default Sender Address" />
                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <asp:Label ID="cb_TO" runat="server" Text="TO" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_To" runat="server" Font-Bold="True" ReadOnly="True" Width="407px" TextMode="MultiLine" ToolTip="Displays Selected Student Email" />
                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <asp:Label ID="cb_CC" runat="server" Text="CC" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_CC" runat="server" Width="407px" ToolTip="Add CC Email Address, Seperate Multiple Address By Semicolon - ; " />
                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <asp:Label ID="cb_BCC" runat="server" Text="BCC" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_BCC" runat="server" Width="407px" ToolTip="Add BCC Email Address, Seperate Multiple Address By Semicolon - ; " />
                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <asp:Label ID="lb_Subject" runat="server" Text="Subject" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_Subject" runat="server" Width="407px" ToolTip="Enter Email Subject " />
                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <asp:Label ID="lb_Body" runat="server" Text="Message" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_Body" runat="server" Height="210px" Width="407px" TextMode="MultiLine"  ToolTip="Enter Email Body Content"/>
                                   </td>
                               </tr>
                            </tr>
                       </table>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="sendButton" runat="server" Text="Send" OnClick="sendButton_OnClick" ToolTip="Click To Send Email" /> 
            </asp:Panel>  

         <asp:CollapsiblePanelExtender TargetControlID="emailPanel" ID="PanelExtender1" runat="server"
                        CollapsedSize="0" Collapsed="True" ExpandControlID="FilterPanelHeader" CollapseControlID="FilterPanelHeader"
                        AutoCollapse="False" AutoExpand="False" ImageControlID="Buton" 
                        ExpandDirection="Vertical"/>
    </ContentTemplate>
    </asp:UpdatePanel>
    </asp:Panel>

 <script type="text/javascript" language="javascript">
     function changeButton() {
         var btn = document.getElementById("Btn_MergeSearch");
         if (btn) {
             btn.className = "CurrentNavButton";
         } else {
             console.log("didnt change");
         }
     }
     changeButton();
    </script>
</asp:Content>
