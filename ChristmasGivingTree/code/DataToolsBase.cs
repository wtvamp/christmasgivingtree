using System;
using System.Collections.Generic;

using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace ChristmasGivingTree
{
    /// <summary>
    /// This is the base class with tools for accessing SQL servers.
    /// </summary>
    public class DataToolsBase
    {
        private string _connectionString = string.Empty;
        private SqlConnection _sqlConnection = null;

        public DataToolsBase(string connectionString)
        {
            this._connectionString = connectionString;
        }

        public DataTable FillDataTable(SqlCommand sqlCmd)
        {
            DataTable tempDataTable = null;
            SqlDataAdapter sqlAdapter = null;

            try
            {
                if (this._sqlConnection == null)
                    this._sqlConnection = new SqlConnection(this._connectionString);

                if (this._sqlConnection.State == ConnectionState.Closed)
                    this._sqlConnection.Open();

                sqlCmd.Connection = this._sqlConnection;
                tempDataTable = new DataTable();
                sqlAdapter = new SqlDataAdapter(sqlCmd);

                sqlAdapter.Fill(tempDataTable);

                return tempDataTable;
            }
            catch (Exception ex)
            {
                throw new Exception("Error filling data table! " + ex.Message, ex);
            }
        }

        public SqlDataAdapter FillDataAdapter(SqlCommand sqlCmd)
        {
            SqlDataAdapter sqlAdapter = null;
            SqlCommandBuilder sqlBuilder = null;

            try
            {
                if (this._sqlConnection == null)
                    this._sqlConnection = new SqlConnection(this._connectionString);

                if (this._sqlConnection.State == ConnectionState.Closed)
                    this._sqlConnection.Open();

                sqlCmd.Connection = this._sqlConnection;
                sqlAdapter = new SqlDataAdapter(sqlCmd);
                sqlBuilder = new SqlCommandBuilder(sqlAdapter);


                return sqlAdapter;
            }
            catch (Exception ex)
            {
                throw new Exception("Error filling data adapter! " + ex.Message, ex);
            }
        }


        public object ExecuteScalar(SqlCommand sqlCmd)
        {
            object tempValue = null;

            try
            {
                if (this._sqlConnection == null)
                    this._sqlConnection = new SqlConnection(this._connectionString);

                if (this._sqlConnection.State == ConnectionState.Closed)
                    this._sqlConnection.Open();

                sqlCmd.Connection = this._sqlConnection;
                tempValue = sqlCmd.ExecuteScalar();


                return tempValue;
            }
            catch (Exception ex)
            {
                throw new Exception("Error executing scalar! " + ex.Message, ex);
            }
        }

        public int ExecuteNonQuery(SqlCommand sqlCmd)
        {

            try
            {

                if (this._sqlConnection == null)
                    this._sqlConnection = new SqlConnection(this._connectionString);

                if (this._sqlConnection.State == ConnectionState.Closed)
                    this._sqlConnection.Open();

                sqlCmd.Connection = this._sqlConnection;
                return sqlCmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                throw new Exception("Error executing scalar! " + ex.Message, ex);
            }
        }

        public void Dispose()
        {
            // Cleanup
            try { this._sqlConnection.Close(); }
            catch { }

            try { this._sqlConnection.Dispose(); }
            catch { }

            this._sqlConnection = null;
        }

    }
}
