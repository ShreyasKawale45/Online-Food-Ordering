using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.User
{
    public partial class Payment : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr, dr1;
        SqlTransaction transaction = null;
        DataTable dt;
        string _name=string.Empty; string _cardNo = string.Empty; string _expiryDate = string.Empty; string _cvv = string.Empty; 
        string _address = string.Empty; string _paymentMode = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }
    

        protected void lbCardSubmit_Click(object sender, EventArgs e)
        {
            _name = txtName.Text.Trim();
            _cardNo = txtCardNo.Text.Trim();
            _cardNo = string.Format("***********{0}", txtCardNo.Text.Trim().Substring(12, 4));
            _expiryDate = txtExpMonth.Text.Trim() +" / "+ txtExpYear.Text.Trim();
            _cvv=txtCvv.Text.Trim();
            _address = txtAddress.Text.Trim();
            _paymentMode = "card";
            if(Session["UserId"] != null)
            {
                OrderPayment(_name, _cardNo, _expiryDate, _cvv, _address, _paymentMode);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }


        protected void lbCodSubmit_Click(object sender, EventArgs e)
        {
            _address = txtCODAddress.Text.Trim();
            _paymentMode = "cod";
            if (Session["UserId"] != null)
            {
                OrderPayment(_name, _cardNo, _expiryDate, _cvv, _address, _paymentMode);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        void OrderPayment(string name, string cardNo, string expiryDate, string cvv, string address, string paymentMode)
        {
            int paymentId;
            int productId;
            int quantity;
            dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[7]
            {
        new DataColumn("OrderNo", typeof(string)),
        new DataColumn("ProductId", typeof(int)),
        new DataColumn("Quantity", typeof(int)),
        new DataColumn("UserId", typeof(int)),
        new DataColumn("Status", typeof(string)),
        new DataColumn("PaymentId", typeof(int)),
        new DataColumn("OrderDate", typeof(DateTime)),
            });

            using (SqlConnection con = new SqlConnection(Connection.GetConnectionString()))
            {
                con.Open(); // Open connection before starting transaction
                using (SqlTransaction transaction = con.BeginTransaction())
                {
                    try
                    {
                        // Save Payment
                        using (SqlCommand cmd = new SqlCommand("Save_Payment", con, transaction))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@Name", name);
                            cmd.Parameters.AddWithValue("@CardNo", cardNo);
                            cmd.Parameters.AddWithValue("@ExpiryDate", expiryDate);
                            cmd.Parameters.AddWithValue("@Cvv", cvv);
                            cmd.Parameters.AddWithValue("@Address", address);
                            cmd.Parameters.AddWithValue("@PaymentMode", paymentMode);
                            cmd.Parameters.Add("@InsertedId", SqlDbType.Int).Direction = ParameterDirection.Output;

                            cmd.ExecuteNonQuery();
                            paymentId = Convert.ToInt32(cmd.Parameters["@InsertedId"].Value);
                        }

                        // Fetch Cart Items
                        using (SqlCommand cmd = new SqlCommand("Cart_Crud", con, transaction))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@Action", "Select");
                            cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);

                            using (SqlDataReader dr = cmd.ExecuteReader())
                            {
                                while (dr.Read())
                                {
                                    productId = (int)dr["ProductId"];
                                    quantity = (int)dr["Qty"];

                                    UpdateQuantity(productId, quantity, transaction, con);
                                    DeleteCartItem(productId, transaction, con);

                                    dt.Rows.Add(Utils.GetUniqueId(), productId, quantity, (int)Session["UserId"], "Pending", paymentId, DateTime.Now);
                                }
                            }
                        }

                        // Save Orders
                        if (dt.Rows.Count > 0)
                        {
                            using (SqlCommand cmd = new SqlCommand("Save_Orders", con, transaction))
                            {
                                cmd.Parameters.AddWithValue("@tblOrders", dt);
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.ExecuteNonQuery();
                            }
                        }

                        transaction.Commit();
                        lblMsg.Visible = true;
                        lblMsg.Text = "Your item ordered successfully!";
                        lblMsg.CssClass = "alert alert-success";
                        Response.AddHeader("REFRESH", "1;URL=Invoice.aspx?id=" + paymentId);
                    }
                    catch (Exception e)
                    {
                        transaction.Rollback();
                        lblMsg.Visible = true;
                        lblMsg.Text = "Transaction failed: " + e.Message;
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }
            }
        }


        void UpdateQuantity(int _productId, int _quantity, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
        {
            int dbQuantity;
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Product_Curd", sqlConnection, sqlTransaction);
            cmd.Parameters.AddWithValue("@Action", "GetByID");
            cmd.Parameters.AddWithValue("@ProductId", _productId);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                dr1 = cmd.ExecuteReader();
                while (dr1.Read())
                {
                    dbQuantity = (int)dr1["Quantity"];
                    if(dbQuantity > _quantity && dbQuantity > 2)
                    {
                        dbQuantity = dbQuantity - _quantity;                      
                        cmd = new SqlCommand("Product_Curd", sqlConnection, sqlTransaction);
                        cmd.Parameters.AddWithValue("@Action", "QTYUpdate");
                        cmd.Parameters.AddWithValue("@Quantity", dbQuantity);
                        cmd.Parameters.AddWithValue("@ProductId", _productId);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                    }
                }
                dr1.Close();
            }
            catch(Exception ex)
            {
                Response.Write("<sript>alert('" + ex.Message + "');</script>");
            }
            
        }

        void DeleteCartItem( int _productId, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
        {
            cmd = new SqlCommand("Cart_Crud", sqlConnection, sqlTransaction);
            cmd.Parameters.AddWithValue("@Action", "Delete");
            cmd.Parameters.AddWithValue("@ProductId", _productId);
            cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write("<sript>alert('" + ex.Message + "');</script>");
            }
        }

    }
}