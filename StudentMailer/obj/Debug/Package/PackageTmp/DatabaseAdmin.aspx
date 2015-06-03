<%@ Page Title="Student Mailer-Database Admin" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master"
    CodeBehind="DatabaseAdmin.aspx.cs" Inherits="StudentMailer.DatabaseAdmin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .GridRight
        {
            width: 267px;
        }
    </style>

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
    
</asp:Content> 
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<asp:SqlDataSource ID="StudentMailer" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
                                SelectCommand="SELECT * FROM [AcademicYear]">
    </asp:SqlDataSource> 
    <asp:SqlDataSource ID="Degree" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="SELECT * FROM [Degree]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Module" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="SELECT * FROM [Module]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Tutor" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="SELECT * FROM [Tutor]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Level" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="SELECT * FROM [Level]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Programme" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="SELECT * FROM [Course]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Faculty" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="SELECT * FROM [Faculty]"></asp:SqlDataSource>
<asp:SqlDataSource ID="BasicQuery" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
        SelectCommand="Proc_BasicQuery" SelectCommandType="StoredProcedure" 
        DeleteCommand="Proc_DeleteStudentDataRow" DeleteCommandType="StoredProcedure" 
        UpdateCommand="Proc_UpdateStudentDataRow" UpdateCommandType="StoredProcedure">
                       
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
    <asp:UpdatePanel runat="server" ID="CategoryUpdatePanel1">
        <Triggers>
            <asp:PostBackTrigger ControlID="btn_LoadDatabase" />
            <asp:PostBackTrigger ControlID="ch_ViewData" />
        </Triggers>
        <ContentTemplate>
                <table class="center_margin" runat="server" >
                 <tr>
                        <td>
                            <asp:Label ID="lb_inst" runat="server" Text="Load Student Mailer Database" Font-Bold="true" Font-Size="Medium"
                                ForeColor="Black" />
                        </td>
                 </tr>
                 <tr>
                    <td>
                    <asp:Label ID="Label1" runat="server" Text="CSV File Type" />
                    <br />
                    <asp:DropDownList ID="ddl_fileType" runat="server" AutoPostBack="false">
                            <asp:ListItem Text="Select CSV File Type" Value="-1" />
                            <asp:ListItem Text="General ClassList" Value="1" Enabled="true" />
                            <asp:ListItem Text="SES ClassList" Value="2" Enabled="true" />
                     </asp:DropDownList>
                    </td> 
                 </tr>
                    <tr>
                        <td> 
                            <asp:Label ID="lblMsg" Text="Upload a CSV File" Font-Bold="false" runat="server"
                                BorderColor="#FFFFFF" Visible="true"></asp:Label>
                                <br />
                            <asp:FileUpload ID="fu_UploadFile" runat="server" Width="200" /> 
                        </td>
                    </tr> 
                    <tr>  
                      <td>
                       <asp:Label ID="lb_error" runat="server" Font-Bold="true" ForeColor="Red" /> 
                        <asp:CheckBox ID="ch_ViewData" runat="server" Text="View Data" 
                              AutoPostBack="True" oncheckedchanged="ch_ViewData_CheckedChanged" /> 
                      </td>
                    </tr>
                    <tr>
                        <td>
                         <asp:Label ID="lb_BackUp" Text="Upload a BackUp File" Font-Bold="false" runat="server"
                                BorderColor="#FFFFFF" Visible="false"></asp:Label>
                                <br />
                           <asp:FileUpload ID="fl_BackUp" runat="server" Visible="false" /> 
                        </td>
                    </tr>
                    <tr>
                    <td colspan="2"> 
                         <asp:Button ID="btn_LoadDatabase" runat="server" Text="Load" OnClick="LoadDatabase_Click"
                            CssClass="NavButton" Height="39px" Width="69px"/> &nbsp;&nbsp;
                         <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                             ConnectionString="<%$ ConnectionStrings:Student_Mailer %>" 
                             SelectCommand="SELECT * FROM [AcademicYear]"></asp:SqlDataSource>
                        </td>
                    </tr> 
                </table>
                &nbsp;&nbsp; &nbsp; &nbsp; 
                <br />
                <asp:Label ID="lb_ResultFeedback" runat="server" Font-Bold="True" 
                             ForeColor="Black" BorderStyle="Outset" Width="199px" 
                    BorderColor="#006600" Height="20px" Visible="false" ></asp:Label >
                <asp:Panel ID="gridPanel" runat="server" Height="290px" Width="510px" ScrollBars="Auto" CssClass="center_margin" Visible="false">
                <asp:GridView ID="gv_StudentData" runat="server" CssClass="Contracts_GridView" 
                        Width="510px" Height="175px" >
                   <RowStyle BackColor="#FFFFFE" ForeColor="#333333" />
                        <HeaderStyle Wrap="true" BackColor="#006600" ForeColor="#FFFFFF" Height="2px" Width="600px"
                            HorizontalAlign="Center" VerticalAlign="Top" />
                        <Columns>
                         <asp:TemplateField ControlStyle-Width="18">
                                <HeaderTemplate> 
                                </HeaderTemplate>
                                <EditItemTemplate>
                                </EditItemTemplate> 
                                <ControlStyle Width="18px"></ControlStyle>
                            </asp:TemplateField>
                        </Columns>
                        <AlternatingRowStyle BackColor="#BBCB97" />
                    </asp:GridView>
                    <br />
               </asp:Panel>
                 <%--Manage Database Panel  --%>
                <asp:Panel runat="server" ID="FilterPanelHeader" Style="margin-top: 10px;" BorderStyle="None"
                        BorderColor="White">
                        <asp:Button ID="Button1" runat="server" Text="Edit And Update Database" Width="300px" />
                </asp:Panel>
                <asp:Panel runat="server" ID="emailPanel" BorderStyle="None" Width="679px" 
                        CssClass="formLayout2" Height="493px" >
                  <table id="Table1" class="center_margin" runat="server">
                    <tr>
                        <td colspan="4"> <asp:Label runat="server" ID="lb_EmailFeedBack" /> </td>
                    </tr>
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
                            <asp:Label ID="Label2" runat="server" Text="Degree"></asp:Label>
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
                                DataTextField="ModuleCode" DataValueField="ModuleID">
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
               <asp:Panel ID="Panel1" runat="server" Height="306px" Width="670px" 
                     ScrollBars="Both" CssClass="center_margin"> 
              <asp:GridView ID="Gridview1" runat="server"  autogeneratecolumns="False"  
                       DataSourceID="BasicQuery" Height="305px" Width="739px" Da  
                       CssClass="Contracts_GridView" AllowSorting="True" DataKeyNames="UniEmail" OnDataBound="Gridview1_databound" 
                       onrowdeleting="Gridview1_RowDeleting"  
                       onrowupdated="Gridview1_RowUpdated" onrowupdating="Gridview1_RowUpdating"   >  
                        <HeaderStyle BackColor="#006600" ForeColor="#FFFFFF" />
                         <Columns> 
                             <asp:CommandField HeaderText="Edit" ShowEditButton="True" ShowHeader="True" 
                                 ButtonType="Button" />
                          <asp:TemplateField HeaderText="Delete">
                               <ItemTemplate>
                               <span onclick="return confirm('You are about to delete this row from database, Are you sure')"> 
                                  <asp:Button runat="server" ID="Btn_Delete" Text="Delete" CommandName="Delete" />
                               </span>
                               </ItemTemplate> 
                          </asp:TemplateField>
                            <asp:BoundField DataField="StudentName" HeaderText="Name" 
                                SortExpression="StudentName" ReadOnly="true" />
                            <asp:TemplateField HeaderText="Std Num">
                               <ItemTemplate>
                                  <asp:Label ID="lb_StdNum" runat="server" Text='<%# Eval("StudentNumber") %>'></asp:Label>
                               </ItemTemplate>
                             <EditItemTemplate>
                                    <asp:TextBox ID="txt_StdNum" runat="server" ReadOnly="true" Text='<%# Eval("StudentNumber") %>'></asp:TextBox>
                             </EditItemTemplate>
                           </asp:TemplateField> 
                             <asp:TemplateField HeaderText="Uni Email">
                               <ItemTemplate>
                                  <asp:Label ID="lb_UniEmail" runat="server" Text='<%# Eval("UniEmail") %>'></asp:Label>
                               </ItemTemplate>
                             <EditItemTemplate>
                                    <asp:TextBox ID="txt_UniEmail" runat="server" ReadOnly="true" Text='<%# Eval("UniEmail") %>'></asp:TextBox>
                             </EditItemTemplate>
                           </asp:TemplateField>  
                            <asp:TemplateField HeaderText="Faculty">
                               <ItemTemplate>
                                <%# Eval("Faculty") %>
                               </ItemTemplate>
                             <EditItemTemplate>
                                     <asp:DropDownList ID="faculty_dropdownlist" runat="server" AutoPostBack="False"
                                        Height="22px" Width="125px" DataSourceID="Faculty" 
                                        DataTextField="FacultyName" DataValueField="FacultyID" SelectedItem-Text='<%# Bind("Faculty")%>' AppendDataBoundItems="true"> 
                                         <asp:ListItem Enabled="true" Text="---Select---" Value="-1" />
                                     </asp:DropDownList>
                             </EditItemTemplate>
                           </asp:TemplateField>   
                           <asp:TemplateField HeaderText="Level">
                               <ItemTemplate>
                                  <asp:Label ID="lb_Level" runat="server" Text='<%# Eval("Level") %>'></asp:Label>
                               </ItemTemplate>
                               <EditItemTemplate>
                                    <asp:DropDownList ID="level_DropDownList" runat="server" AutoPostBack="False" 
                                        Height="22px" Width="125px" DataSourceID="Level" DataTextField="LevelName" 
                                        DataValueField="LevelID" SelectedItem-Text='<%# Bind("Level")%>' AppendDataBoundItems="true"> 
                                         <asp:ListItem Enabled="true" Text="---Select---" Value="-1" />
                                    </asp:DropDownList>
                            </EditItemTemplate>
                          </asp:TemplateField>
                          <asp:TemplateField HeaderText="Degree">
                               <ItemTemplate>
                                  <asp:Label ID="lb_Degreegv" runat="server" Text='<%# Eval("Degree Name") %>'></asp:Label>
                               </ItemTemplate>
                               <EditItemTemplate>
                                   <asp:DropDownList ID="degree_DropDownList" runat="server" AutoPostBack="False" 
                                    Height="22px" Width="125px" DataSourceID="Degree" DataTextField="DegreeCode" 
                                    DataValueField="DegreeID" SelectedItem-Text='<%# Eval("Degree Name")%>' AppendDataBoundItems="true">
                                    <asp:ListItem Enabled="true" Text="---Select---" Value="-1" />
                            </asp:DropDownList>
                              </EditItemTemplate>
                           </asp:TemplateField>  
                          <asp:TemplateField HeaderText="Programme">
                               <ItemTemplate>
                                  <asp:Label ID="lb_Coursegv" runat="server" Text='<%# Eval("Course") %>'></asp:Label>
                               </ItemTemplate>
                               <EditItemTemplate>
                                   <asp:DropDownList ID="programe_dropdownlist" runat="server" AutoPostBack="False" 
                                    Height="22px" Width="125px" DataSourceID="Programme"  
                                    DataTextField="CourseName" DataValueField="CourseID" AppendDataBoundItems="true" SelectedItem-Text='<%# Bind("Course")%>'> 
                                     <asp:ListItem Enabled="true" Text="---Select---" Value="-1"  />
                            </asp:DropDownList>
                              </EditItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="Tutor">
                               <ItemTemplate>
                                  <asp:Label ID="lb_Tutorgv" runat="server" Text='<%# Eval("Tutor") %>'></asp:Label>
                               </ItemTemplate>
                               <EditItemTemplate>
                                    <asp:DropDownList ID="Tutor_DropDownList" runat="server" AutoPostBack="False" 
                                        Height="22px" Width="125px" DataSourceID="Tutor" DataTextField="TutorName" 
                                        DataValueField="TutorID" SelectedItem-Text='<%# Bind("Tutor")%>' AppendDataBoundItems="true"> 
                                        <asp:ListItem Enabled="true" Text="---Select---" Value="-1"  />
                                    </asp:DropDownList>
                              </EditItemTemplate>
                           </asp:TemplateField> 
                           <asp:TemplateField HeaderText="Year">
                               <ItemTemplate>
                                  <asp:Label ID="lb_Yeargv" runat="server" Text='<%# Eval("Year") %>'></asp:Label>
                               </ItemTemplate>
                               <EditItemTemplate>
                                    <asp:DropDownList ID="Year_DropDownList" runat="server" AutoPostBack="False" 
                                        Height="22px" Width="125px" DataSourceID="StudentMailer" DataTextField="YearName" 
                                        DataValueField="YearID" SelectedItem-Text='<%# Bind("Year")%>' AppendDataBoundItems="true" > 
                                          <asp:ListItem Enabled="true" Text="---Select---" Value="-1"  />
                                    </asp:DropDownList>
                              </EditItemTemplate>
                           </asp:TemplateField>  
                        </Columns>
                        <RowStyle BackColor="#FFFFFE" ForeColor="#333333" />
                        <AlternatingRowStyle BackColor="#BBCB97" />
                    </asp:GridView>
                </asp:Panel>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </asp:Panel>
                    <asp:CollapsiblePanelExtender TargetControlID="emailPanel" ID="PanelExtender" runat="server"
                        CollapsedSize="0" Collapsed="True" ExpandControlID="FilterPanelHeader" CollapseControlID="FilterPanelHeader"
                        AutoCollapse="False" AutoExpand="False" ImageControlID="Buton" 
                        ExpandDirection="Vertical" /> 
            

        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
     <script type="text/javascript" language="javascript">
         function changeButton() {
             var btn = document.getElementById("Btn_DatabaseAdmin");
             if (btn) {
                 btn.className = "CurrentNavButton";
             } else {
                 console.log("didnt change");
             }
         }
         changeButton();
    </script>
</asp:Content>
