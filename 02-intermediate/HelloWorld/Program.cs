using HelloWorld.Data;
using HelloWorld.Models;
using Microsoft.Extensions.Configuration;


namespace HelloWorld
{
    internal class Program
    {
        static void Main(string[] args)
        {

            IConfiguration config = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json")
                .Build();

            DataContextDapper dapper = new DataContextDapper(config);
            DataContextEF entityFramework = new DataContextEF(config);


            string sqlCommand = "SELECT GETDATE()";

            IEnumerable<DateTime> rightNowObj = dapper.LoadData<DateTime>(sqlCommand);
            DateTime rightNowRead = dapper.LoadDataSingle<DateTime>(sqlCommand);

            Console.WriteLine(rightNowRead);
            Console.WriteLine(rightNowObj);

            DateTime rightNow = dapper.LoadDataSingle<DateTime>("SELECT GETDATE()");


            Computer myComputer = new Computer()
            {
                Motherboard = "Z690",
                HasWifi = true,
                HasLTE = false,
                ReleaseDate = DateTime.Now,
                Price = 943.84m,
                VideoCard = "RTX 2060"
            };

            entityFramework.Add(myComputer);
            entityFramework.SaveChanges();


            //This is usually because in some areas of the world that use a comma( , ) instead of a period( . ) as a decimal point, and MS SQL Server doesn't understand that format.

            // myComputer.Price.ToString("0.00", CultureInfo.InvariantCulture);

            /*In the same piece of code we will attempt to insert a date to our table, some people will receive a different error: "Conversion failed when converting date and/or time from character string".

            This is because in some areas the date format is not recognized by MS SQL Server.*/

            // myComputer.Price.ToString("0.00", CultureInfo.InvariantCulture)
            string sql = @"INSERT INTO TutorialAppSchema.Computer (
              Motherboard,
                HasWifi,
                HasLTE,
                ReleaseDate,
                Price,
                VideoCard
            ) VALUES ('" + myComputer.Motherboard
                        + "','" + myComputer.HasWifi
                        + "','" + myComputer.HasLTE
                        + "','" + myComputer.ReleaseDate
                        + "','" + myComputer.Price
                        + "','" + myComputer.VideoCard
            + "')";


            // Console.WriteLine(sql);
            // bool result = dapper.ExecuteSql(sql);
            // Console.WriteLine(result);


            string sqlSelect = @"
            SELECT 
                Computer.ComputerId,
                Computer.Motherboard,
                Computer.HasWifi,
                Computer.HasLTE,
                Computer.ReleaseDate,
                Computer.Price,
                Computer.VideoCard 
            FROM TutorialAppSchema.Computer";


            IEnumerable<Computer> computers = dapper.LoadData<Computer>(sqlSelect);

            foreach (Computer singleComputer in computers)
            {
                Console.WriteLine("'" + singleComputer.ComputerId
                                        + singleComputer.Motherboard
                                        + "','" + myComputer.HasWifi
                                        + "','" + myComputer.HasLTE
                                        + "','" + myComputer.ReleaseDate
                                        + "','" + myComputer.Price
                                        + "','" + myComputer.VideoCard
                            + "'");
            }


            IEnumerable<Computer>? computerEf = entityFramework.Computer?.ToList<Computer>();

            if (computerEf != null)
            {
                foreach (Computer singleComputer in computerEf)
                {
                    Console.WriteLine("'" + singleComputer.ComputerId
                                         + singleComputer.Motherboard
                                            + "','" + myComputer.HasWifi
                                            + "','" + myComputer.HasLTE
                                            + "','" + myComputer.ReleaseDate
                                            + "','" + myComputer.Price
                                            + "','" + myComputer.VideoCard
                                + "'");
                }
            }



        }
    }
}