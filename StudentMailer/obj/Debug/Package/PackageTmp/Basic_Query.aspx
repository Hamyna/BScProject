<%@ Page Title="Student Mailer-Basic Query" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master"
    CodeBehind="Basic_Query.aspx.cs" Inherits="StudentMailer.Basic_Query"%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">
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
<asp:SqlDataSource ID="StudentMailer" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
                                SelectCommand="SELECT * FROM [AcademicYear]">
    </asp:SqlDataSource> 
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
        SelectCommand="Proc_GetFaculty" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="BasicQuery" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="Proc_BasicQuery" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="level_DropDownList" DefaultValue="-1" 
                                Name="DegreelevelID" PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="module_DropDownList" DefaultValue="-1" 
                                Name="ModuleID" PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="degree_DropDownList" DefaultValue="-1" 
                                Name="DegreeID" PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="Tutor_DropDownList" DefaultValue="-1" 
                                Name="TutorID" PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="programe_dropdownlist" DefaultValue="-1" 
                                Name="CourseID" PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="faculty_dropdownlist" DefaultValue="-1" 
                                Name="FacultyID" PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="year_ddl" DefaultValue="1" Name="YearID" 
                                PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
    </asp:SqlDataSource>
<asp:Panel ID="Panel2" runat="server" Width="700px" CssClass="FilterPanelHeader" BorderStyle="None">
<asp:UpdatePanel runat="server" ID="CategoryUpdatePanel1">

            <Triggers>
                <asp:PostBackTrigger ControlID="sendButton" />
            </Triggers>
            <ContentTemplate> 
            <asp:Label runat="server" ID="lb_Header" Text="Select Search Parameter to Update Result" Font-Bold="true" />
            <table class="center_margin" runat="server">
                    <tr>
                        <td colspan="2" align="center"><asp:Label ID="Label7" runat="server" Text="Academic Year "></asp:Label>
                            <asp:DropDownList ID="year_ddl" runat="server" AutoPostBack="True" DataSourceID="StudentMailer"
                                DataTextField="YearName" DataValueField="YearID" Width="125px" 
                                Height="22px">
                                <asp:ListItem Text="---Select---" Value="-1" Enabled="true" />
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Degree"></asp:Label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:DropDownList ID="degree_DropDownList" runat="server" AutoPostBack="True" 
                                Height="22px" Width="125px" DataSourceID="Degree" DataTextField="DegreeCode" 
                                DataValueField="DegreeID">
                                <asp:ListItem Enabled="true" Text="---Select---" Value="-1" />
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Module"></asp:Label>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:DropDownList ID="module_DropDownList" runat="server" AutoPostBack="True" 
                                Height="22px" Width="125px" DataSourceID="Module" 
                                DataTextField="ModuleName" DataValueField="ModuleID">
                                <asp:ListItem Enabled="true" Text="---Select---" Value="-1" />
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            <asp:Label ID="Label5" runat="server" Text="Tutor"></asp:Label>
                            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:DropDownList ID="Tutor_DropDownList" runat="server" AutoPostBack="True" 
                                Height="22px" Width="125px" DataSourceID="Tutor" DataTextField="TutorName" 
                                DataValueField="TutorID">
                                <asp:ListItem Enabled="true" Text="---Select---" Value="-1" />
                            </asp:DropDownList>
                        </td>
                        <td class="style2">
                            <asp:Label ID="Label4" runat="server" Text="Level"></asp:Label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:DropDownList ID="level_DropDownList" runat="server" AutoPostBack="True" 
                                Height="22px" Width="125px" DataSourceID="Level" DataTextField="LevelName" 
                                DataValueField="LevelID">
                                <asp:ListItem Enabled="true" Text="---Select---" Value="-1" />
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Programme_Label" runat="server" Text="Programme"></asp:Label>
                            &nbsp;
                            <asp:DropDownList ID="programe_dropdownlist" runat="server" AutoPostBack="True" 
                                Height="22px" Width="125px" DataSourceID="Programme"  
                                DataTextField="CourseName" DataValueField="CourseID">
                                <asp:ListItem Enabled="true" Text="---Select---" Value="-1" />
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="Label6" runat="server" Text="Faculty"></asp:Label>
                            &nbsp;&nbsp; &nbsp;<asp:DropDownList ID="faculty_dropdownlist" runat="server" AutoPostBack="True"
                                Height="22px" Width="125px" DataSourceID="Faculty" 
                                DataTextField="FacultyName" DataValueField="FacultyID">
                                <asp:ListItem Enabled="true" Text="---Select---" Value="-1" />
                            </asp:DropDownList>
                        </td>
                    </tr> 
                </table>

            <asp:Label ID="lb_recordsFeedback" runat="server" Font-Bold="True" 
                             ForeColor="Black" BorderStyle="Outset" Width="199px" 
                    BorderColor="#006600" Height="20px" ></asp:Label >

            <asp:Panel ID="Panel1" runat="server" Height="247px" Width="679px" 
                     ScrollBars="Both" CssClass="center_margin"> 
                    <asp:GridView ID="Gridview1" runat="server" AutoGenerateColumns="False"
                        DataSourceID="BasicQuery" Height="247px" Width="679px" 
                            CssClass="Contracts_GridView" AllowSorting="True" 
                             ondatabound="Gridview1_DataBound" DataKeyNames="UniEmail">  
                        <HeaderStyle BackColor="#006600" ForeColor="#FFFFFF" />
                         <Columns>
                         <asp:TemplateField ControlStyle-Width="18">
                                <HeaderTemplate>
                                    <input id="chkAll" onclick="javascript:SelectAllCheckboxes(this);" runat="server"
                                        type="checkbox" />
                                </HeaderTemplate>
                                <EditItemTemplate>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cb_select" runat="server" />
                                </ItemTemplate>
                                <ControlStyle Width="18px"></ControlStyle>
                            </asp:TemplateField>
                            <asp:BoundField DataField="StudentName" HeaderText="Name" 
                                SortExpression="StudentName" />
                            <asp:BoundField DataField="UniEmail" HeaderText="Email" 
                                SortExpression="UniEmail" />
                            <asp:BoundField DataField="StudentNumber" HeaderText="Std Num" 
                                SortExpression="StudentNumber" />
                            <asp:BoundField DataField="Year" HeaderText="Year" 
                                SortExpression="Year" /> 
                            <asp:BoundField DataField="Faculty" HeaderText="Faculty" 
                                SortExpression="Faculty" />
                            <asp:BoundField DataField="Level" HeaderText="Level" 
                                SortExpression="Level" />
                            <asp:BoundField DataField="Degree Name" HeaderText="Degree" 
                                SortExpression="Degree Name" />
                            <asp:BoundField DataField="Course" HeaderText="Programme" 
                                SortExpression="Course" />
                            <asp:BoundField DataField="Module" HeaderText="Module" 
                                SortExpression="Module" />
                            <asp:BoundField DataField="Tutor" HeaderText="Tutor" 
                                SortExpression="Tutor" />
                        </Columns>
                        <RowStyle BackColor="#FFFFFE" ForeColor="#333333" />
                        <AlternatingRowStyle BackColor="#BBCB97" />
                    </asp:GridView>
                </asp:Panel> 
                    <asp:Panel runat="server" ID="FilterPanelHeader" Style="margin-top: 10px;" BorderStyle="None"
                        BorderColor="White">
                        <asp:Button ID="Button1" runat="server" Text="Email Students" 
                            OnClick="Button3_Click" Width="620px" />
                    </asp:Panel>
                    <%--email panel  --%> 
                    <asp:Panel runat="server" ID="emailPanel" BorderStyle="None" Width="600px" 
                        CssClass="formLayout2" Height="493px" >
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
                                <asp:TextBox ID="Tb_FROM" runat="server" Width="407px" AutoPostBack="True" /> 
                             </td>
                           </tr>
                           <tr> 
                                <td align="left"> 
                                     <asp:Label ID="cb_TO" runat="server"  Text=" TO" /> 
                                </td>
                                <td>
                                    <asp:TextBox ID="Tb_To" runat="server" Width="407px" Font-Bold="True" 
                                        ReadOnly="True" AutoPostBack="True" TextMode="MultiLine" />
                                </td>
                           </tr>
                           <tr> 
                               <td align="left">
                                   <asp:Label ID="cb_CC" runat="server"  Text=" CC" /> 
                               </td>  
                               <td> 
                                    <asp:TextBox ID="Tb_CC" runat="server" Width="407px" />
                               </td>
                           </tr>
                           <tr>
                               <td align="left">
                                    <asp:Label ID="cb_BCC" runat="server"  Text=" BCC" /> 
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
                                    <asp:TextBox runat="server" ID="Tb_Subject" Width="407px" /> 
                              </td>
                           </tr>
                           <tr>
                               <td align="left">
                                    <asp:Label ID="lb_Body" runat="server" Text="Message" /> 
                               </td>
                               <td>
                                    <asp:TextBox ID="Tb_Body" runat="server" Height="210px" Width="407px"  TextMode="MultiLine" /> 
                               </td>
                           </tr>
                           <tr> 
                              <td colspan="5">
                                    <asp:Button ID="sendButton" runat="server" Text="Send" OnClick="sendButton_OnClick"/>  
                              </td>
                           </tr>
                       </table> 
                    </asp:Panel> 
                    <asp:CollapsiblePanelExtender TargetControlID="emailPanel" ID="PanelExtender" runat="server"
                        CollapsedSize="0" Collapsed="True" ExpandControlID="FilterPanelHeader" CollapseControlID="FilterPanelHeader"
                        AutoCollapse="False" AutoExpand="False" ImageControlID="Buton" 
                        ExpandDirection="Vertical" /> 
            </ContentTemplate>
         
</asp:UpdatePanel>   
    </asp:Panel>
    <br /> 
    <br /> 
    <script type="text/javascript" language="javascript">
        function changeButton() {
            var btn = document.getElementById("Btn_BasicSearch");
            if (btn) {
                btn.className = "CurrentNavButton";
            } else {
                console.log("didnt change");
            }
        }
        changeButton();
    </script>
</asp:Content>

