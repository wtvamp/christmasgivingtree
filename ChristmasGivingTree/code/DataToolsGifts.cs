using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace ChristmasGivingTree
{
    public class DataToolsGifts : DataToolsBase
    {
        public DataToolsGifts(string connectionString) : base(connectionString) { }


        // Adds the children  to the database.  
        public void addChild(string gender, int age)
        {
            SqlCommand insertAppCmd = null;

            insertAppCmd = new SqlCommand(
                  "INSERT INTO givingTreeGift (gender,age) VALUES (@gender,@age)"
            );

            insertAppCmd.Parameters.AddWithValue("@firstName", gender);
            insertAppCmd.Parameters.AddWithValue("@lastName", age);

            this.ExecuteNonQuery(insertAppCmd);
        }


        // Adds the gift to the database.  
        public void addGift(string firstName, string lastName, string email, string workPhone, string homePhone, int childID)
        {
            SqlCommand insertAppCmd = null;

            insertAppCmd = new SqlCommand(
                  "INSERT INTO givingTreeGifts (firstName,lastName,email,workPhone,homePhone,givingTreeChildrenID) VALUES (@firstName,@lastName,@email,@workPhone,@homePhone,@givingTreeChildrenID)"
            );

            insertAppCmd.Parameters.AddWithValue("@firstName", firstName);
            insertAppCmd.Parameters.AddWithValue("@lastName", lastName);
            insertAppCmd.Parameters.AddWithValue("@email", email);
            insertAppCmd.Parameters.AddWithValue("@workPhone", workPhone);
            insertAppCmd.Parameters.AddWithValue("@homePhone", homePhone);
            insertAppCmd.Parameters.AddWithValue("@givingTreeChildrenID", childID);

            this.ExecuteNonQuery(insertAppCmd);

            

            SqlCommand updateGiftCmd = null;

            updateGiftCmd = new SqlCommand("UPDATE givingTreeChildren SET giftGiven = 1 WHERE giftID = @childID");
            updateGiftCmd.Parameters.AddWithValue("@childID", childID);

            this.ExecuteNonQuery(updateGiftCmd);

            
        }


     
        // Gets the names of all the children who need gifts.  
        public DataTable getGifts()
        {
            SqlCommand selectGiftsCmd = null;
            DataTable giftsDataTable = null;
                       
            try
            {
                selectGiftsCmd = new SqlCommand("SELECT * FROM givingTreeChildren WHERE giftGiven = 0");

                giftsDataTable = this.FillDataTable(selectGiftsCmd);

                return giftsDataTable;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}