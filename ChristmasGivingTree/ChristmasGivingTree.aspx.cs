using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Windows;

namespace ChristmasGivingTree
{
    public partial class ChristmasGivingTree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataToolsGifts loadGifts = new DataToolsGifts(System.Configuration.ConfigurationManager.ConnectionStrings["WebAppConnectionString"].ConnectionString);
            DataTable allGifts = loadGifts.getGifts();
            foreach (DataRow row in allGifts.Rows) {
                
                //Create the larger tree ornament divs
                HtmlGenericControl newDiv = new HtmlGenericControl("div");
                newDiv.Style["position"] = "absolute";
                newDiv.ID = "ornament" + row["giftID"].ToString();

                int seed = (int)System.DateTime.Now.Ticks;
                Random random = new Random(seed);
                int bottom = 0;
                int left = 0;

                while (!(inTree(left, bottom)))
                {
                    bottom = random.Next(1112);
                    left = random.Next(900);
                    System.Threading.Thread.Sleep(10);    
                }

                newDiv.Style["bottom"] = bottom.ToString() + "px";
                newDiv.Style["left"] = left.ToString() + "px";
                newDiv.Style["z-index"] = "500";


                bottom = Convert.ToInt32(bottom * .53);
                left = Convert.ToInt32(left * .53);

                //Create the smaller tree ornament divs
                HtmlGenericControl smallNewDiv = new HtmlGenericControl("div");
                smallNewDiv.Style["position"] = "absolute";
                smallNewDiv.Style["bottom"] = bottom.ToString() + "px";
                smallNewDiv.Style["left"] = left.ToString() + "px";
                smallNewDiv.ID = "smallornament" + row["giftID"].ToString();

                // Create the ornament image
                HtmlGenericControl imageDiv = new HtmlGenericControl("div");
                imageDiv.Style["width"] = "35px";
                imageDiv.Style["height"] = "40px";
                imageDiv.Style["background-image"] = "url('images/snowflake.png')";
                imageDiv.ID = "ornamentimage" + row["giftID"].ToString();

                /*Image newImg = new Image();                            
                newImg.ImageUrl = "images/snowflake.png";
                newImg.Height = Unit.Pixel(35);
                newImg.Width = Unit.Pixel(35);*/

                // Create the small ornament image
                Image smallNewImg = new Image();
                smallNewImg.ImageUrl = "images/small_flake_03.png";
                smallNewImg.Height = Unit.Pixel(17);
                smallNewImg.Width = Unit.Pixel(17);
                
                //Create the span with the child's gender
                HtmlGenericControl newGender = new HtmlGenericControl("span");
                newGender.InnerHtml = row["gender"].ToString();
                newGender.Style["display"] = "none";
                newGender.ID = "giftGender" + row["giftID"].ToString();

                // Create the span with the child's age
                HtmlGenericControl newAge = new HtmlGenericControl("span"); 
                newAge.InnerHtml = row["age"].ToString();
                newAge.Style["display"] = "none";
                newAge.ID = "giftAge" + row["giftID"].ToString();

                // Add everything to the tree
                newDiv.Controls.Add(imageDiv);
                newDiv.Controls.Add(newGender);
                newDiv.Controls.Add(newAge);
                treecontainer.Controls.Add(newDiv);

                // Add everything to the small tree
                smallNewDiv.Controls.Add(smallNewImg);
                smalltreecontainer.Controls.Add(smallNewDiv);  
            }
        }

        
        // these functions are to test a point inside a triangle, used to make sure the ornaments stay within the tree.  
        protected bool inTree(int X, int Y) {
            double fABint = fAB(X, Y, 420, 1027, 100, 150);
            double fBCint = fBC(X, Y, 100, 150, 805, 150);
            double fCAint = fCA(X, Y, 420, 1027, 805, 150);
            double test = fABint * fBCint;
            if ((fABint * fBCint) > 0 &&
                (fBCint * fCAint > 0))
            {
                return true;
            }
            else
            {
                return false;
            }

            
        }

        protected int fAB(int X, int Y, int X1, int Y1,int X2, int Y2) {
            return (
            (Y - Y1) *
            (X2 - X1) -
            (X - X1) * 
            (Y2 - Y1));
        }

        protected int fBC(int X, int Y, int X2, int Y2, int X3, int Y3)
        {
            return (
            (Y - Y2) *
            (X3 - X2) -
            (X - X2) * 
            (Y3 - Y2));
        }
  
        protected int fCA(int X, int Y, int X1, int Y1, int X3, int Y3)
        {
            return (
            (Y - Y3) *
            (X1 - X3) -
            (X - X3) *
            (Y1 - Y3));
        }

        protected void submitGift_Click(object sender, EventArgs e)
        {
            string _firstName;
            string _lastName;
            string _email;
            string _workPhone;
            string _homePhone;
            int _childID;

            _firstName = firstName.Text;
            _lastName = lastName.Text;
            _email = email.Text;
            _workPhone = workPhone.Text;
            _homePhone = homePhone.Text;
            _childID = Convert.ToInt32(hiddenChildID.Value);

            DataToolsGifts addGifts = new DataToolsGifts(System.Configuration.ConfigurationManager.ConnectionStrings["WebAppConnectionString"].ConnectionString);
            addGifts.addGift(_firstName, _lastName, _email, _workPhone, _homePhone, _childID);

            givingFormContent.Controls.Clear();
            Label thanksMessage = new Label();
            thanksMessage.Text = "Thank you for submitting your gift!";
            givingFormContent.Controls.Add(thanksMessage);
        }

    }

}