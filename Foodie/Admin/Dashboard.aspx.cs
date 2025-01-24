using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "";
                if (Session["Admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    DashboardCount dashboard = new DashboardCount();
                    Session["category"] = dashboard.Count("Category");
                    Session["product"] = dashboard.Count("Product");
                    Session["order"] = dashboard.Count("Order");
                    Session["delivered"] = dashboard.Count("Delivered");
                    Session["pending"] = dashboard.Count("Pending");
                    Session["user"] = dashboard.Count("User");
                    Session["soldAmmount"] = dashboard.Count("SoldAmmount");
                    Session["contact"] = dashboard.Count("Contact");

                }
            }
        }
    }
}