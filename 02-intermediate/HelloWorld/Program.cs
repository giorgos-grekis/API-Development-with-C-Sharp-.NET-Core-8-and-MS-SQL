using HelloWorld.Models;


namespace HelloWorld
{
    internal class Program
    {
        static void Main(string[] args)
        {

            Computer myComputer = new Computer()
            {
                Motherboard = "Z690",
                HasWifi = true,
                HasLTE = false,
                ReleaseDate = DateTime.Now,
                Price = 943.84m,
                VideoCard = "RTX 2060"
            };


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


            // File.WriteAllText("log.txt", sql);
            using StreamWriter openFile = new("log.txt", append: true);

            openFile.WriteLine(sql + "\n");

            openFile.Close();

            string fileText = File.ReadAllText("log,txt");

            Console.WriteLine(File.ReadAllText("log.txt"));

        }
    }
}