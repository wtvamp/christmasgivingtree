<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GivingTreeAdmin.aspx.cs" Inherits="ChristmasGivingTree.GivingTreeAdmin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        h3
        {
            font-family: "Adobe Caslon Pro";
            font-size: x-large;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h3>Children who need gifts:</h3>
        
        <asp:GridView ID="childGridView" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" AutoGenerateEditButton="True" DataKeyNames="giftID" 
            DataSourceID="childrenWhoNeedGiftsDataSource" CellPadding="4" 
            BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px">
            <Columns>
                <asp:BoundField DataField="giftID" HeaderText="ID" InsertVisible="False" 
                    ReadOnly="True" SortExpression="giftID" />
                <asp:BoundField DataField="gender" HeaderText="Gender" 
                    SortExpression="gender" />
                <asp:BoundField DataField="age" HeaderText="Age" SortExpression="age" />
                <asp:CheckBoxField DataField="giftGiven" HeaderText="Gift Given?" 
                    SortExpression="giftGiven" />
            </Columns>
            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
            <RowStyle BackColor="White" ForeColor="#330099" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <SortedAscendingCellStyle BackColor="#FEFCEB" />
            <SortedAscendingHeaderStyle BackColor="#AF0101" />
            <SortedDescendingCellStyle BackColor="#F6F0C0" />
            <SortedDescendingHeaderStyle BackColor="#7E0000" />
        </asp:GridView>
        <asp:SqlDataSource ID="childrenWhoNeedGiftsDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WebAppConnectionString %>" 
            SelectCommand="SELECT * FROM [givingTreeChildren]" 
            
            UpdateCommand="UPDATE givingTreeChildren SET gender = @gender, age = @age, giftGiven = @giftGiven WHERE giftID = @giftID" 
            InsertCommand="INSERT INTO givingTreeChildren (gender,age,giftGiven) VALUES (@gender,@age,0)">
            <InsertParameters>
                <asp:Parameter Name="gender" />
                <asp:Parameter Name="age" />
            </InsertParameters>
        </asp:SqlDataSource>

        <br />
        <h3>Add a new child who needs a gift:</h3>
        Gender 
        <asp:TextBox ID="newGender" runat="server"></asp:TextBox>
        Age
        <asp:TextBox ID="newAge" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="Add" onclick="Button1_Click" />
        <br />
        <br />
        <h3>People who have contributed gifts:</h3>
        <asp:GridView ID="giftGiversGridview" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
            DataKeyNames="givingTreeUserID" 
            DataSourceID="peopleWhoHaveGivenGiftsDataSource" BackColor="White" 
            BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px">
            <Columns>
                <asp:BoundField DataField="givingTreeUserID" HeaderText="ID" 
                    InsertVisible="False" ReadOnly="True" SortExpression="givingTreeUserID" />
                <asp:BoundField DataField="firstName" HeaderText="First Name" 
                    SortExpression="firstName" />
                <asp:BoundField DataField="lastName" HeaderText="Last Name" 
                    SortExpression="lastName" />
                <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
                <asp:BoundField DataField="workPhone" HeaderText="Work Phone" 
                    SortExpression="workPhone" />
                <asp:BoundField DataField="homePhone" HeaderText="Home Phone" 
                    SortExpression="homePhone" />
                <asp:BoundField DataField="givingTreeChildrenID" 
                    HeaderText="ID Number of Child Recieving Gift" 
                    SortExpression="givingTreeChildrenID">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
            <RowStyle BackColor="White" ForeColor="#330099" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <SortedAscendingCellStyle BackColor="#FEFCEB" />
            <SortedAscendingHeaderStyle BackColor="#AF0101" />
            <SortedDescendingCellStyle BackColor="#F6F0C0" />
            <SortedDescendingHeaderStyle BackColor="#7E0000" />
        </asp:GridView>

        <asp:SqlDataSource ID="peopleWhoHaveGivenGiftsDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WebAppConnectionString %>" 
            SelectCommand="SELECT * FROM [givingTreeGifts]"></asp:SqlDataSource>

    </div>
    </form>
</body>
</html>
