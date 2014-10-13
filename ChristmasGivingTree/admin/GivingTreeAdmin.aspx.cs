using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ChristmasGivingTree
{
    public partial class GivingTreeAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            childrenWhoNeedGiftsDataSource.InsertParameters["gender"].DefaultValue = newGender.Text;
            childrenWhoNeedGiftsDataSource.InsertParameters["age"].DefaultValue = newAge.Text;

            childrenWhoNeedGiftsDataSource.Insert();
        }

    }
}