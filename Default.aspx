﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestión de Prioridades</title>
    <link rel="stylesheet" href="styles/prioridades.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="header" class="header">
        <h2>GESTIÓN DE PRIORIDADES</h2>
        Localidad:
        <asp:DropDownList ID="ddlInmuebles" runat="server" DataSourceID="SqlDataSource1" DataTextField="Localidad" DataValueField="idLocalidad" AutoPostBack="True"></asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TurnosConnectionString %>" SelectCommand="SELECT Cat_Servidores_Localidad.IpVirtual, Cat_Servidores_Localidad.idLocalidad, CL.Localidad FROM Cat_Servidores_Localidad INNER JOIN Cat_Localidad AS CL ON Cat_Servidores_Localidad.idLocalidad = CL.Id ORDER BY CL.Localidad"></asp:SqlDataSource>
        &nbsp;&nbsp;IP:
        <asp:DropDownList ID="ddlIP" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource4" DataTextField="IpVirtual" DataValueField="Inmueble"></asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:TurnosConnectionString %>" SelectCommand="SELECT * FROM [Cat_Servidores_Localidad] WHERE ([idLocalidad] = @idLocalidad)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlInmuebles" Name="idLocalidad" PropertyName="SelectedValue" Type="Double" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br /><br />
    </div>
    <div id="master" class="master">
        <asp:GridView ID="gvMaestro" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" PageSize="15" AllowPaging="True" AllowSorting="True" DataKeyNames="IdFuncion" OnPreRender="gvMaestro_PreRender">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" ButtonType="Button" SelectText="Seleccionar" />
                <asp:BoundField DataField="IdFuncion" HeaderText="idFunción" InsertVisible="False" ReadOnly="True" SortExpression="IdFuncion" />
                <asp:BoundField DataField="Funcion" HeaderText="Función" SortExpression="Funcion" />
                <asp:BoundField DataField="textoPlano" HeaderText="textoPlano" SortExpression="textoPlano" />
                <asp:BoundField DataField="IdLocalidad" HeaderText="idLocalidad" SortExpression="IdLocalidad" />
                <asp:BoundField DataField="Descripcion" HeaderText="Descripción" SortExpression="Descripcion" />
                <asp:CheckBoxField DataField="Activo" HeaderText="Activo" SortExpression="Activo" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TurnosConnectionString %>" SelectCommand="SELECT [IdFuncion], [Funcion], [textoPlano], [IdLocalidad], [Descripcion], [Activo] FROM [Cat_Funciones] WHERE ([IdLocalidad] = @IdLocalidad) ORDER BY [IdFuncion] DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlInmuebles" Name="IdLocalidad" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <div id="detail" class="detail">

        <asp:DetailsView ID="dvDetalle" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="IdFuncion" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None" Height="50px" Width="125px" OnItemCreated="dvDetalle_ItemCreated">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="IdFuncion" HeaderText="idFunción" InsertVisible="False" ReadOnly="True" SortExpression="IdFuncion" />
                <asp:BoundField DataField="Funcion" HeaderText="Función" SortExpression="Funcion" />
                <asp:BoundField DataField="textoPlano" HeaderText="textoPlano" SortExpression="textoPlano" />
                <asp:BoundField DataField="IdLocalidad" HeaderText="idLocalidad" SortExpression="IdLocalidad" />
                <asp:BoundField DataField="Descripcion" HeaderText="Descripción" SortExpression="Descripcion" />
                <asp:CheckBoxField DataField="Activo" HeaderText="Activo" SortExpression="Activo" />
                <asp:CommandField ShowDeleteButton="True" ShowInsertButton="True" ButtonType="Button" CancelText="Salir" DeleteText="Borrar" InsertText="Insertar" NewText="Agregar" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TurnosConnectionString %>" DeleteCommand="DELETE FROM [Cat_Funciones] WHERE [IdFuncion] = @original_IdFuncion" InsertCommand="INSERT INTO [Cat_Funciones] ([Funcion], [textoPlano], [IdLocalidad], [Descripcion], [Activo]) VALUES (@Funcion, @textoPlano, @IdLocalidad, @Descripcion, @Activo)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [IdFuncion], [Funcion], [textoPlano], [IdLocalidad], [Descripcion], [Activo] FROM [Cat_Funciones] WHERE ([IdFuncion] = @IdFuncion)" UpdateCommand="UPDATE [Cat_Funciones] SET [Funcion] = @Funcion, [textoPlano] = @textoPlano, [IdLocalidad] = @IdLocalidad, [Descripcion] = @Descripcion, [Activo] = @Activo WHERE [IdFuncion] = @original_IdFuncion">
            <DeleteParameters>
                <asp:Parameter Name="original_IdFuncion" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Funcion" Type="String" />
                <asp:Parameter Name="textoPlano" Type="String" />
                <asp:Parameter Name="IdLocalidad" Type="Int32" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="Activo" Type="Boolean" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="gvMaestro" Name="IdFuncion" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Funcion" Type="String" />
                <asp:Parameter Name="textoPlano" Type="String" />
                <asp:Parameter Name="IdLocalidad" Type="Int32" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="Activo" Type="Boolean" />
                <asp:Parameter Name="original_IdFuncion" />
            </UpdateParameters>
        </asp:SqlDataSource>

    </div>
    </form>
</body>
</html>
