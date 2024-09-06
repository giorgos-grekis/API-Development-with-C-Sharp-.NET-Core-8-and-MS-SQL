using System.Text.Json;
using AutoMapper;
using HelloWorld.Data;
using HelloWorld.Models;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;


namespace HelloWorld
{
    internal class Program
    {
        static void Main(string[] args)
        {
            IConfiguration config = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build();

            DataContextDapper dapper = new DataContextDapper(config);

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
            // string sql = @"INSERT INTO TutorialAppSchema.Computer (
            //   Motherboard,
            //     HasWifi,
            //     HasLTE,
            //     ReleaseDate,
            //     Price,
            //     VideoCard
            // ) VALUES ('" + myComputer.Motherboard
            //             + "','" + myComputer.HasWifi
            //             + "','" + myComputer.HasLTE
            //             + "','" + myComputer.ReleaseDate
            //             + "','" + myComputer.Price
            //             + "','" + myComputer.VideoCard
            // + "')";


            // File.WriteAllText("log.txt", sql);
            // using StreamWriter openFile = new("log.txt", append: true);

            // openFile.WriteLine(sql + "\n");

            // openFile.Close();

            string computersJson = File.ReadAllText("ComputersSnake.json");

            // Mapper mapper = new Mapper(new MapperConfiguration((cfg) =>
            // {
            //     cfg.CreateMap<ComputersSnake, Computer>()
            //     .ForMember(destination => destination.ComputerId, options => options.MapFrom(source => source.computer_id))
            //     .ForMember(destination => destination.CPUCores, options => options.MapFrom(source => source.cpu_cores))
            //     .ForMember(destination => destination.HasLTE, options => options.MapFrom(source => source.has_lte))
            //     .ForMember(destination => destination.HasWifi, options => options.MapFrom(source => source.has_wifi))
            //     .ForMember(destination => destination.Motherboard, options => options.MapFrom(source => source.motherboard))
            //     .ForMember(destination => destination.ReleaseDate, options => options.MapFrom(source => source.release_date))
            //     .ForMember(destination => destination.Price, options => options.MapFrom(source => source.price));
            // }));

            //// deserialize
            // IEnumerable<ComputersSnake>? computersSystem = System.Text.Json.JsonSerializer.Deserialize<IEnumerable<ComputersSnake>>(computersJson);

            // if (computersSystem != null)
            // {
            //     // We don;t need to list out our source because we're going to be using our source as the argumant.
            //     IEnumerable<Computer> computerResult = mapper.Map<IEnumerable<Computer>>(computersSystem);

            //     foreach (var computer in computerResult)
            //     {
            //         Console.WriteLine(computer.Motherboard);
            //     }
            // }

            IEnumerable<Computer>? computersSystemJsonPropertyMapping = System.Text.Json.JsonSerializer.Deserialize<IEnumerable<Computer>>(computersJson);

            if (computersSystemJsonPropertyMapping != null)
            {
                System.Console.WriteLine(computersSystemJsonPropertyMapping.Count());

                // foreach (var computer in computersSystemJsonPropertyMapping)
                // {
                //     Console.WriteLine(computer.Motherboard);
                // }
            }


            //     IEnumerable<Computer>? computersNewtonsoft = JsonConvert.DeserializeObject<IEnumerable<Computer>>(computersJson);

            //     JsonSerializerOptions options = new JsonSerializerOptions()
            //     {
            //         PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            //     };

            //     IEnumerable<Computer>? computersSystem = System.Text.Json.JsonSerializer.Deserialize<IEnumerable<Computer>>(computersJson, options);


            //     if (computersNewtonsoft != null)
            //     {
            //         foreach (Computer computer in computersNewtonsoft)
            //         {
            //             // Console.WriteLine(computer.Motherboard);
            //             string sql = @"INSERT INTO TutorialAppSchema.Computer (
            //       Motherboard,
            //         HasWifi,
            //         HasLTE,
            //         ReleaseDate,
            //         Price,
            //         VideoCard
            //     ) VALUES ('" + EscapeSingleQuote(computer.Motherboard)
            //                 + "','" + computer.HasWifi
            //                 + "','" + computer.HasLTE
            //                 + "','" + computer.ReleaseDate
            //                 + "','" + computer.Price
            //                 + "','" + EscapeSingleQuote(computer.VideoCard)
            //     + "')";

            //             dapper.ExecuteSql(sql);
            //         }
            //     }

            //     JsonSerializerSettings settings = new JsonSerializerSettings()
            //     {
            //         ContractResolver = new CamelCasePropertyNamesContractResolver()
            //     };

            //     string computerCopyNewtonsoft = JsonConvert.SerializeObject(computersNewtonsoft, settings);

            //     File.WriteAllText("computersCopyNewtonsoft.txt", computerCopyNewtonsoft);

            //     string computerCopySystem = System.Text.Json.JsonSerializer.Serialize(computersSystem, options);

            //     File.WriteAllText("computerCopySystem.txt", computerCopySystem);
            // }

            // static string EscapeSingleQuote(string input)
            // {
            //     string output = input.Replace("'", "''");

            //     return output;
            // }
        }
    }
}