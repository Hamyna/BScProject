<%@Page Title="Student Mailer-Advance Query"  Language="C#" AutoEventWireup="true" CodeBehind="Advanced_Query.aspx.cs" Inherits="StudentMailer.Advanced_Query" MasterPageFile="~/Site.master"  %>
<% @Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style3
        {
            width: 77px;
        }
    </style>
</asp:Content>

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

    <script type="text/javascript" language="javascript">
        function changeButton() {
            var btn = document.getElementById("Btn_AdvanceSearch");
            if (btn) {
                btn.className = "CurrentNavButton";
            } else {
                console.log("didnt change");
            }
        }
        changeButton();
    </script>       

    <asp:SqlDataSource ID="Degree" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="Proc_GetDegree" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <asp:SqlDataSource ID="Module" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="Proc_GetModule" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <asp:SqlDataSource ID="Tutor" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="Proc_GetTutor" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <asp:SqlDataSource ID="Level" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="Proc_GetLevel" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <asp:SqlDataSource ID="Programme" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="Proc_GetCourse" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <asp:SqlDataSource ID="Faculty" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="SELECT * FROM [Faculty]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="Year" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="SELECT * FROM [AcademicYear]">
   </asp:SqlDataSource> 

    <asp:SqlDataSource ID="GroupList" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="Proc_GetGroupsByUser" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lb_userName" Name="UserName" 
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="GetSavedSearchByUser" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="Proc_GetSavedSearch" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lb_userName" Name="UserName" 
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Panel ID="MainPanel" runat="server" Width="714px" CssClass="center_margin" 
        BorderStyle="None" >
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>  
        <asp:Panel ID="Pn_BuildSearch" runat="server" Visible = "true" 
            BorderStyle="Ridge"  CssClass="center_margin" Width="477px"> 
        <asp:Label ID="lb_err" runat="server" Visible="false" Font-Bold="true" ForeColor="Red" /> 
        <asp:Label ID="lb_feedback" runat="server" Visible="false" Font-Bold="true" ForeColor="Black" /> 
    <br /> 
        <table ID="Table1" runat="server" class="center_margin">
          <tr>  
                <td colspan="12">  
                <asp:Label ID="lb_Header" runat="server" Visible="true" Font-Bold="true" ForeColor="Black" Text="Build Dynamic Search Statement" />
                    <asp:CheckBoxList ID="cb_Query" runat="server" AutoPostBack="True" 
                        BorderColor="#336600" BorderStyle="Solid" Font-Bold="True" Width="389px" 
                        CssClass="center_margin" Height="34px" 
                        onselectedindexchanged="cb_Query_SelectedIndexChanged" ToolTip="Click To Alter Sub Search" />
                </td>
            </tr> 
             <tr>  
                <td colspan="3"> 
                    <asp:Button ID="Btn_Change" runat="server" AutoPostBack="True" 
                        CssClass="NavButton" Font-Size="Small" Height="29px" 
                        Text="Change" Visible="false" ToolTip="Click Change Sub Query" 
                        onclick="Btn_Change_Click" /> 
                        &nbsp;<asp:Button ID="Btn_Delete" runat="server" AutoPostBack="True" 
                        CssClass="NavButton" Font-Size="Small" Height="29px" 
                        Text="Remove" Visible="false" ToolTip="Click To Remove Selected Search" 
                        onclick="Btn_Delete_Click" />
                </td>
            </tr>
          <tr>
          <td>
            <asp:Label ID="lb_LogicalLink" runat="server" Text="Criteria" Visible="false"  ToolTip="Select A Logical Link" />  <br />
                     <asp:DropDownList ID="ddl_LogicalLink" runat="server" Width="100px" AutoPostBack="True" 
                      onselectedindexchanged="ddl_LogicalLink_SelectedIndexChanged" ToolTip="Select A Logical Link" 
                        Visible="false"  Font-Size="Small" Height="20px">
                        <asp:ListItem Enabled="true" Text="--Select--" Value="-1" />
                        <asp:ListItem Enabled="true" Text="AND" Value="1" />  
                        <asp:ListItem Enabled="true" Text="EXCEPT" Value="2" />
                        <asp:ListItem Enabled="true" Text="IN" Value="3" />
                    </asp:DropDownList>
          </td>
                <td>
                    <asp:Label ID="lb_TaleOptions1" runat="server" Content="Category" 
                        Text="Category" Visible="true" /> <br />
                    <asp:DropDownList ID="ddl_TableOptions1" runat="server" AutoPostBack="True" 
                         onselectedindexchanged="ddl_TableOptions_SelectedIndexChanged" ToolTip="Click To Select A Category" 
                         Width="100px"  Height="20px">
                        <asp:ListItem Enabled="true" Text="---Select---" Value="-1" />
                        <asp:ListItem Enabled="true" Text="Academic Year" Value="1" />
                        <asp:ListItem Enabled="true" Text="Tutor" Value="2" />
                        <asp:ListItem Enabled="true" Text="Degree" Value="3" />
                        <asp:ListItem Enabled="true" Text="Module" Value="4" />
                        <asp:ListItem Enabled="true" Text="Faculty" Value="5" />
                        <asp:ListItem Enabled="true" Text="Level" Value="6" />
                        <asp:ListItem Enabled="true" Text="Programme" Value="7" />
                    </asp:DropDownList>
                </td> 
                <td>
                    <asp:Label ID="lb_SelectedTableName1" runat="server" Visiible="false" Text=" "  /> <br />
                    <asp:DropDownList ID="ddl_SelectedTable" runat="server" AutoPostBack="True" 
                        Height="20px" Visible="true" Width="100px" ToolTip="Select Query Option">
                        <asp:ListItem Enabled="true" Text="---Select---" Value="-1" />
                    </asp:DropDownList>
                </td> 
                 <td>
                    <asp:Label ID="lb_AddQuery" runat="server" Visiible="false" 
                        Width="37px" /> 
                     <br />
                    <asp:Button ID="btn_AddQuery1" runat="server" AutoPostBack="True" 
                        CssClass="NavButton" Font-Size="Small" Height="29px" 
                        onclick="btn_AddQuery_Click" Text="Add" Visible="true" ToolTip="Click To Add New Query" /> 
                </td>
            </tr>
          <tr>
                <td colspan="3">
                    <asp:Button ID="btn_Query" runat="server" AutoPostBack="True" 
                        CssClass="NavButton" Font-Size="Small" Height="29px" onclick="btn_Query_Click" 
                        Text="Search" Visible="true" Width="92px" ToolTip="Click To View Query Result" />
                    &nbsp;<asp:Button ID="bt_ClearQuery" runat="server" AutoPostBack="True" 
                        CssClass="NavButton" Font-Size="Small" Height="29px" 
                        onclick="btn_ClearQuery_Click" Text="Re-Start" Visible="true" ToolTip="Click to Restart Search" />
                </td>
            </tr>

        </table>   
         </asp:Panel>

         <%-- Display Data --%>
         <asp:Panel runat="server" ID="Panel2" Style="margin-top: 10px;" BorderStyle="None" BorderColor="White">
              <asp:Button ID="Bt_Select" runat="server" 
                  Text="Select Result Field"  Width="477px" 
                  onclick="Bt_Select_Click"/>
          </asp:Panel> 

         <asp:Panel runat="server" ID="Panel3" BorderStyle="Ridge" 
            CssClass="formLayout2" Height="94px" Width="578px">
                        <asp:Label runat="server" Text="Select Data(s) to Display in Search Result" Font-Bold="true" />
                        <table class="center_margin"> 
                            <tr>
                                <td align="left"> <asp:CheckBox runat="server" ID="cb_StudentNumber" Text="Student Number"  Width="143px" Checked="True"/></td>
                                <td  align="left" class="style3"> <asp:CheckBox runat="server" ID="cb_UniversityEmail" Text="Email" Width="54px" 
                                        Checked="True"/> </td>
                                <td  align="left"> <asp:CheckBox runat="server" ID="cb_StudentName" Text="Name" Width="61px" 
                                        Checked="True" /></td> 
                                <td  align="left"> <asp:CheckBox runat="server" ID="cb_Level" Text="Level"  Width="65px"/> </td>
                                <td  align="left"> <asp:CheckBox runat="server" ID="cb_Module" Text="Module"  Width="74px"/> </td>
                                <td  align="left"> <asp:CheckBox runat="server" ID="cb_Course" Text="Course"  Width="68px"/></td>
                            </tr>
                            <tr>
                                <td  align="left"> <asp:CheckBox runat="server" ID="cb_AcademicYear" Text="Academic Year" Width="157px"/> </td>
                                <td  align="left" class="style3"> <asp:CheckBox runat="server" ID="cb_Faculty" Text="Faculty"  Width="77px"/> </td>
                                <td  align="left"> <asp:CheckBox runat="server" ID="cb_Degree" Text="Degree"  
                                        Width="80px"/> </td>
                                <td align="left"> <asp:CheckBox runat="server" ID="cb_Tutor" Text="Tutor"  Width="64px"/> </td>
                                <td  align="left">  <asp:CheckBox runat="server" ID="cb_Programme" Text="Programme"  
                                        Width="106px"/></td> 
                                <td> </td>
                            </tr>
                        </table>
                    </asp:Panel>

         <asp:CollapsiblePanelExtender TargetControlID="Panel3" ID="CollapsiblePanelExtender2" runat="server"
                        CollapsedSize="0" Collapsed="True" ExpandControlID="Panel2" CollapseControlID="Panel2"
                        AutoCollapse="False" AutoExpand="False" ImageControlID="Buton" 
                        ExpandDirection="Vertical"/>
 
         <%--Save Search Panel--%>
         <asp:Panel runat="server" ID="SaveSearch_FilterPanelHeader" BorderStyle="None"
                        BorderColor="White">
         <asp:Button ID="btn_SaveSearch" runat="server" Text="Save Search" onclick="btn_SaveSearch_Click" Visible="true"  Width="477px"  />
         </asp:Panel> 

         <asp:Panel runat="server" ID="savesearchPanel" BorderStyle="Ridge"  
            CssClass="formLayout2" Width="414px">
                        <table id="tb_f1" class="center_margin"> 
                            <tr> 
                                <td align="center" colspan="3">
                                     <asp:Label ID="lb_fileerror" runat="server" Font-Bold="True" ForeColor="#FF3300" />
                                  </td>
                            </tr>  
                            <tr> 
                                <td align="left">   
                                     <asp:Label runat="server" ID="LB_saveSearchAs" Font-Bold="false" Text="Name" ToolTip="Type In A Name To Save Search As" /> 
                                   </td>
                                   <td> 
                                   <asp:TextBox ID="Txt_fileName" runat="server"
                                        ToolTip="Type In A Name To Save Search As" Width="150px" />
                                    </td>
                                    <td align="right"> 
                                        <asp:Button ID="Btn_Save" runat="server" CssClass="NavButton" 
                                        Font-Size="Small" Height="27px" onclick="Btn_Save_Click" Text="Save" 
                                        ToolTip="ClicK To Save Search" ValidationGroup="String" Width="66px" />
                                    </td>
                            </tr> 
                            <tr> 
                                <td align="left">
                                    <asp:Label runat="server" ID="lb_savesearch" Font-Bold="false" Text="Saved Searches" ToolTip="Expand dropdownlist to view a list of saved search" />
                                 </td> 
                                 <td>  
                                 <asp:DropDownList ID="ddl_SavedSearch" runat="server" AutoPostBack="True"
                                         onselectedindexchanged="ddl_SavedSearch_SelectedIndexChanged" 
                                        Width="156px" 
                                         ToolTip="Expand dropdownlist to view a list of saved search,select a search to view or update" 
                                         Height="26px" DataSourceID="GetSavedSearchByUser" 
                                         DataTextField="SearchName" DataValueField="SearchID" > 
                                            <asp:ListItem Enabled="true" Text="---Select---" Value="-1" />
                                     </asp:DropDownList></td> 
                                <td align="right">
                                  <asp:Button ID="Btn_DeleteSaveSavedSearch" runat="server" CssClass="NavButton" 
                                        Text="Delete" Visible="false" Font-Size="Small"  Height="27px" 
                                        Width="66px" onclick="Btn_DeleteSaveSavedSearch_Click" 
                                        ToolTip="Click To Delete Selected Search" />
                               </td> 
                            </tr> 
                            </table>  
                    </asp:Panel>

         <asp:CollapsiblePanelExtender TargetControlID="savesearchPanel" ID="CollapsiblePanelExtender1" runat="server"
                        CollapsedSize="0" Collapsed="True" ExpandControlID="SaveSearch_FilterPanelHeader" CollapseControlID="SaveSearch_FilterPanelHeader"
                        AutoCollapse="False" AutoExpand="False" ImageControlID="Buton" 
                        ExpandDirection="Vertical"/>  
        
        <%--  Group Panel --%>
         <asp:Panel runat="server" ID="GroupsFiterHeader" BorderStyle="None"
                        BorderColor="White">
         <asp:Button ID="Btn_Groups" runat="server" Text="Groups" Visible="true" 
                 Width="477px" onclick="Btn_Groups_Click" />
         </asp:Panel> 

         <asp:Panel runat="server" ID="Pn_CreateGroups" BorderStyle="Ridge"  
            CssClass="formLayout2" Width="400px" Height="206px" >
                        <table id="tbl_CreateGroup" class="center_margin"> 
                        <tr> 
                         <td colspan="2" align="centre"> 
                                     <asp:Label runat="server"  ID="lb_UserName" Visible="false" /> 
                                     <asp:Label runat="server" ID="lb_errorFeedback" Font-Bold="true" Text=" " ForeColor="#FF3300" />
                                     <asp:Label runat="server" ID="lb_groupFeedback" Font-Bold="true" Text=" " />

                                </td>
                                
                            </tr>  
                            <tr> 
                                <td align="left">   
                                   <asp:Label runat="server" ID="lb_create" Font-Bold="false" Text="Name " ToolTip="Type In Groups Name" />
                                </td> 
                                <td align="left"> 
                                   <asp:TextBox ID="Txt_GroupName" runat="server" ToolTip="Type In A Name To Save Group As" Width="150px" /> 
                                </td>
                            </tr> 
                            <tr> 
                             <td align="left"> 
                                <asp:Label runat="server" ID="ddl_VisibilityStatus" Text="Accessibility State" ToolTip="Who do you want to see your group" /> 
                             </td>
                             <td align="left"> 
                                    <asp:RadioButtonList ID="RBL_Visibility" runat="server" AppendDataBoundItem="true" 
                                    BorderColor="#336600" BorderStyle="None" Font-Bold="false" Width="171px"
                                    ToolTip="Check Public if you want all user to view your group, Private otherwise" 
                                    RepeatDirection="Horizontal">
                                  <asp:ListItem Text="Private" Value="0" />
                                  <asp:ListItem Text="Public" Value="1" /> 
                                    </asp:RadioButtonList>
                             </td>
                            </tr>
                            <tr>
                             <td colspan="3" align="center"> 
                                <asp:Button ID="Btn_Group" runat="server" CssClass="NavButton" 
                                        Font-Size="Small" Height="27px" Text="Create" 
                                        ToolTip="ClicK To Create Group" ValidationGroup="String" Width="71px" 
                                     onclick="Btn_Group_Click" />
                              </td> 
                            </tr>
                            <tr> 
                                <td  colspan="3" align="centre"> 
                                     <asp:Label runat="server" Font-Bold="true" ID="lb_ManageGroup" Text="Mange Group" ToolTip="Assign students, delete and update group" /> 
                                </td>
                            </tr>
                            <tr> 
                                <td align="left">
                                    <asp:Label runat="server" ID="lb_groupList" Font-Bold="false" Text="Group List"/>
                                </td>  
                                <td  align="left">  
                                <asp:RadioButtonList ID="rb_ListOfGroup" runat="server" AppendDataBoundItem="true" 
                                    DataSourceID="GroupList" DataTextField="GroupName" CssClass="center_margin" 
                                    DataValueField="GroupID" BorderColor="#336600" BorderStyle="Solid" Width="223px"
                                    ToolTip="List of Groups">
                                    </asp:RadioButtonList> 
                                </td>
                             <tr>
                              <td colspan="3"> 
                               <asp:Button ID="Btn_DeleteGroup" runat="server" CssClass="NavButton" 
                                        Text="Delete Group" Visible="true" Font-Size="Small"  Height="27px" 
                                        Width="106px" ToolTip="Click To Delete Selected Groups" 
                                      onclick="Btn_DeleteGroup_Click" /> 
                                  &nbsp;&nbsp; 
                                <asp:Button ID="Btn_AssignStudentToGroup" runat="server" CssClass="NavButton" 
                                        Text="Add Student" Visible="true" Font-Size="Small"  Height="27px" 
                                        Width="102px" ToolTip="Click To Delete Selected Groups" 
                                      onclick="Btn_AssignStudentToGroup_Click" />
                                  &nbsp;&nbsp;
                                <asp:Button ID="Btn_ViewStudent" runat="server" CssClass="NavButton" 
                                        Text="View Student" Visible="true" Font-Size="Small"  Height="27px" 
                                        Width="102px" ToolTip="Click To Delete Selected Groups" 
                                      onclick="Btn_ViewStudent_Click" />
                                  
                              </td>
                             </tr> 
                            </table>  
                    </asp:Panel>

         <asp:CollapsiblePanelExtender TargetControlID="Pn_CreateGroups" ID="GroupsCollapsiblePanelExtender" runat="server"
                        CollapsedSize="0" Collapsed="True" ExpandControlID="GroupsFiterHeader" CollapseControlID="GroupsFiterHeader"
                        AutoCollapse="False" AutoExpand="False" ImageControlID="Buton" 
                        ExpandDirection="Vertical"/>  


         <asp:Label ID="lb_ResultFeedback" runat="server" Font-Bold="True" 
                             ForeColor="Black" BorderStyle="Outset" Width="199px" 
                    BorderColor="#006600" Height="20px" Visible="false" ></asp:Label >
         <%--Result Panel --%> 
         <asp:Panel ID="gv_Result" runat="server"  Width="670px" ScrollBars="Auto" CssClass="center_margin"  >
                 <asp:GridView ID="gv_StudentData" runat="server" CssClass="Contracts_GridView" 
                     Width="644px" Height="16px" AllowSorting="True" 
                     ToolTip="Click Header To Sort In Ascenting Or Decending Order" 
                     DataKeyNames="Email,StudentID">
                   <RowStyle BackColor="#FFFFFE" ForeColor="#333333" />
                        <HeaderStyle Wrap="true" BackColor="#006600" ForeColor="#FFFFFF" Height="2px" Width="600px"
                            HorizontalAlign="Center" VerticalAlign="Top" CssClass="Freezing"  />
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
                 &nbsp;</asp:Panel> 
  
          <%--Email Section--%>
         <asp:Panel runat="server" ID="FilterPanelHeader" Style="margin-top: 10px;" BorderStyle="None"
                        BorderColor="White">
              <asp:Button ID="Btn_Email" runat="server" Text="Email Students" 
                  onclick="Btn_Email_Click"  Width="477px" />
         </asp:Panel> 

         <asp:Panel runat="server" ID="emailPanel" BorderStyle="None" Width="600px" 
                        CssClass="formLayout2" Height="472px" >
                       <table  class="center_margin"> 
                     <tr>
                        <td colspan="4"> <asp:Label runat="server" ID="lb_EmailFeedBack" /> </td>
                    </tr>
                       <tr>
                            <td colspan="2">
                                    <asp:ImageButton ID="ImgBtn_Attachment" runat="server" 
                                        AlternateText="Attach File" ToolTip="Attachment" 
                                        ImageUrl="~/images/AttachmentIcon.jpg" Height="24px" 
                                        OnClick="Button2_OnClick" />
                                    <asp:ImageButton ID="ImgBtn_NewAttachment1" runat="server" 
                                        AlternateText="Attach File"  Height="24px"
                                        ImageUrl="~/images/AttachmentIcon.jpg" OnClick="new_attachment_OnClick" 
                                        ToolTip="Attachment"  />
                                    <asp:ImageButton ID="ImgBtn_NewAttachment2" runat="server" 
                                        AlternateText="Attach File"  Height="24px" 
                                        ImageUrl="~/images/AttachmentIcon.jpg" OnClick="new_attachment1_OnClick" 
                                        ToolTip="Attachment"  />
                                </td>
                               <td colspan="2"> 
                                    <asp:FileUpload ID="FileUpload2" runat="server" ToolTip="Browse and attach a file" Visible="false" Width="191px" />  
                                    <asp:FileUpload ID="fileUpload1" runat="server" Visible="false" Width="182px" ToolTip="Browse and attach a file" />
                                    <asp:FileUpload ID="fileUpload3" runat="server" Visible="False" Width="113px" ToolTip="Browse and attach a file" />
                                </td> 
                                
                            </tr> 
                               <tr>
                                   <td align="left">
                                       <asp:Label ID="lb_FROM" runat="server" Text="FROM" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_FROM" runat="server" Width="407px" />
                                   </td>
                               </tr>
                               <tr>
                                   <td align="left">
                                       <asp:Label ID="cb_TO" runat="server" Text="TO" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_To" runat="server" Font-Bold="True" ReadOnly="True" Width="407px" TextMode="MultiLine" />
                                   </td>
                               </tr>
                               <tr>
                                   <td align="left">
                                       <asp:Label ID="cb_CC" runat="server" Text=" CC" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_CC" runat="server" Width="407px" />
                                   </td>
                               </tr>
                               <tr>
                                   <td align="left">
                                       <asp:Label ID="cb_BCC" runat="server" Text="BCC" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_BCC" runat="server" Width="407px" />
                                   </td>
                               </tr>
                               <tr>
                                   <td align="left">
                                       <asp:Label ID="lb_Subject" runat="server" Text="Subject" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_Subject" runat="server" Width="407px" />
                                   </td>
                               </tr>
                               <tr>
                                   <td align="left">
                                       <asp:Label ID="lb_Body" runat="server" Text="Message" />
                                   </td>
                                   <td>
                                       <asp:TextBox ID="Tb_Body" runat="server" Height="153px" Width="407px" 
                                           TextMode="MultiLine" />
                                   </td>
                               </tr>
                            </tr>
                       </table>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="sendButton" runat="server" Text="Send" 
                           OnClick="sendButton_OnClick" style="margin-top: 0px" /> 
            </asp:Panel>  
             
         <asp:CollapsiblePanelExtender TargetControlID="emailPanel" ID="PanelExtender1" runat="server"
                        CollapsedSize="0" Collapsed="True" ExpandControlID="FilterPanelHeader" CollapseControlID="FilterPanelHeader"
                        AutoCollapse="False" AutoExpand="False" ImageControlID="Buton" 
                        ExpandDirection="Vertical"/>

     </ContentTemplate>
    </asp:UpdatePanel> 
  </asp:Panel> 


</asp:Content> 
 



