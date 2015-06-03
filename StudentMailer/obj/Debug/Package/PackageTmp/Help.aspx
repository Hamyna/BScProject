<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="StudentMailer.Help"  MasterPageFile="~/Site.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="RadPdf" Namespace="RadPdf.Web.UI" TagPrefix="radPdf" %> 


<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server"> 
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
 </asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <radPdf:PdfWebControl ID="HelPdfDocument" runat="server" width="100%" MaxPdfPages="20" 
         HideEditMenu="True" HideFileMenu="True" HideFocusOutline="True" 
            HideObjectPropertiesBar="True" EnablePrintSettingsDialog="True" Height="600px" 
            HideBookmarks="True" HideRightClickMenu="True" HideThumbnails="True" 
            HideToggleHighlightsButton="True" HideToolsTabs="True" /> 
</asp:Content>