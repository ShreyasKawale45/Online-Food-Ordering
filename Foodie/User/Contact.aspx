<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Foodie.User.Contact" %>
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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="book_section layout_padding">
    <div class="container">
      <div class="heading_container">
          <div class="align-self-end">
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </div>
        <h2>Send Your Query</h2>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="form_container">
           
              <div>
                  <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is Required" ControlToValidate="txtName"
                      ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
              </div>
              <div>
                  <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Your Email" TextMode="Email"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is Required" ControlToValidate="txtEmail"
    ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
              </div>
              <div>
               <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Your Subject"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvSubject" runat="server" ErrorMessage="Subject is Required" ControlToValidate="txtSubject"
    ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
              </div>
              <div>
                               <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" placeholder="Your Message"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvMessage" runat="server" ErrorMessage="Message is Required" ControlToValidate="txtMessage"
    ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
              </div>
              
              <div class="btn_box">
                  <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-warning pl-4 pr-4 text-white" OnClick="btnSubmit_Click"/>
              </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="map_container ">
            <div id="googleMap">
              <iframe src="https://www.google.com/maps/embed?pb=!1m17!1m12!1m3!1d2045.930332907995!2d72.86529973118652!3d18.709335991210438!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m2!1m1!2zMTjCsDQyJzMzLjUiTiA3MsKwNTEnNTUuMyJF!5e1!3m2!1sen!2sin!4v1730203088815!5m2!1sen!2sin" width="100%" height="300px" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
          </div>

          </div>
        </div>
      </div>
    </div>
  </section>
</asp:Content>
