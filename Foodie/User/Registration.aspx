<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Foodie.User.Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
    //For disappearing alert meassage
    window.onload = function () {
        var seconds = 5;
        setTimeout(function () {
            document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
        }, seconds * 1000);
    };
</script>
<script>
    function ImagePreview(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#<%=imgUser.ClientID%>').prop('src', e.target.result)
                    .width(200)
                    .height(200);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <asp:Label ID="lblHeaderMsg" runat="server" Text="<h2>User Registration</h2>"></asp:Label>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-container">
                        <div>
                            <asp:RequiredFieldValidator ID="rvfvName" runat="server" ErrorMessage="Name is Required" ControlToValidate="txtName" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revName" runat="server" ErrorMessage="Name must be in characters only" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="txtName"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter full Name" ToolTip="Full Name"></asp:TextBox>
                        </div>
                        <br />

                        <div>
                            <asp:RequiredFieldValidator ID="rvfUsername" runat="server" ErrorMessage="Username is Required" ControlToValidate="txtUsername" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter Username" ToolTip="Username"></asp:TextBox>
                        </div>
                        <br />

                        <div>
                            <asp:RequiredFieldValidator ID="rvfEmail" runat="server" ErrorMessage="Email is Required" ControlToValidate="txtEmail" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter Email" ToolTip="Email" TextMode="Email"></asp:TextBox>
                        </div>
                        <br />

                        <div>
                            <asp:RequiredFieldValidator ID="rvfMobile" runat="server" ErrorMessage="No is Required" ControlToValidate="txtMobile" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revMobile" runat="server" ErrorMessage="No must be 10 Digits" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[0-9]{10}$" ControlToValidate="txtMobile"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Enter Mobile No" ToolTip=" Mobile No" TextMode="Number"></asp:TextBox>
                        </div>

                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-container">
                        <div>
                            <asp:RequiredFieldValidator ID="rvfAdress" runat="server" ErrorMessage="Address is Required" ControlToValidate="txtAddress" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter Address" ToolTip="Address" TextMode="MultiLine"></asp:TextBox>
                        </div>
                        <br />

                        <div>
                            <asp:RequiredFieldValidator ID="rvfPostCode" runat="server" ErrorMessage="Post/Zip Code is Required" ControlToValidate="txtPostCode" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revPostCode" runat="server" ErrorMessage=" Must be 6 Digits" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[0-9]{6}$" ControlToValidate="txtPostCode"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtPostCode" runat="server" CssClass="form-control" placeholder="Enter Post/Zip Code" ToolTip="Post/Zip Code" TextMode="Number"></asp:TextBox>

                        </div>
                        <br />

                        <div>
                            <asp:FileUpload ID="fuUserImage" runat="server" CssClass="form-control" ToolTip="User Image" onchange="ImagePreview(this);" />
                        </div>
                        <br />

                        <div>
                            <asp:RequiredFieldValidator ID="rvfPassword" runat="server" ErrorMessage="Password is Required" ControlToValidate="txtPassword" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter Password" ToolTip="Password" TextMode="Password"></asp:TextBox><br />
                        </div>
                    </div>
                </div>
                


                <div class="row pl-4">
                    <div class="btn-box">
                        <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white" OnClick="btnRegister_Click"/>

                        <asp:Label ID="lblAlreadyUser" runat="server" CssClass="pl-3 text-black-100" Text="Already Registered <a href='Login.aspx' class='badge badge-info'>Login here...</a>"></asp:Label>
                    </div>
                </div>

                <div class="row p-5">
                    <div style="align-items:center">
                        <asp:Image ID="imgUser" runat="server" CssClass="img-thumbnail" />
                    </div>
                </div>

            </div>
        </div>
    </section>

</asp:Content>
