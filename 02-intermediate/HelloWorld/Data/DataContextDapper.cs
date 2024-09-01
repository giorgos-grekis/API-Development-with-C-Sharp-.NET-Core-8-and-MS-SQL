using System.Data;
using Dapper;
using Microsoft.Data.SqlClient;

namespace HelloWorld.Data
{
    public class DataContextDapper
    {
        // create a connection
        private string _connectionString = @"Server=localhost\MSSQLSERVER01;Database=DotNetCourseDatabase;TrustServerCertificate=true;Trusted_Connection=true;";

        // string connectionStringLinuxMac = @"Server=localhost\MSSQLSERVER01;Database=DotNetCourseDatabase;TrustServerCertificate=true;Trusted_Connection=false;User_Id=sa;Password=SQLConnect1;";

        public IEnumerable<T> LoadData<T>(string sql)
        {
            IDbConnection dbConnection = new SqlConnection(_connectionString);
            return dbConnection.Query<T>(sql);
        }

        public T LoadDataSingle<T>(string sql)
        {
            IDbConnection dbConnection = new SqlConnection(_connectionString);
            return dbConnection.QuerySingle<T>(sql);
        }

        public bool ExecuteSql(string sql)
        {
            IDbConnection dbConnection = new SqlConnection(_connectionString);
            return dbConnection.Execute(sql) > 0;
        }

        public int ExecuteSqlWithRowCount(string sql)
        {
            IDbConnection dbConnection = new SqlConnection(_connectionString);
            return dbConnection.Execute(sql);
        }




    }
}