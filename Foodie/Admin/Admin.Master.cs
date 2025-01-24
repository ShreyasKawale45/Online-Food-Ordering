using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        //SqlConnection con;
        protected void Page_Load(object sender, EventArgs e)
        {
            //con = new SqlConnection("Data Source=DESKTOP-O9HUJ4F\\SQLEXPRESS;Initial Catalog=foodieDB;Integrated Security=True;Trust Server Certificate=True");
            //con.Open();
        }

        protected void lblLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("../User/Login.aspx");
        }
    }
}