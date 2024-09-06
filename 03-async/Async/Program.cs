using System;

namespace Async
{

    internal class Program
    {
        static async Task Main(string[] args)
        {

            Task fisrtName = new Task(() =>
            {
                Thread.Sleep(100);
                System.Console.WriteLine("Task 1");
            });
            fisrtName.Start();
            await fisrtName;
            Console.WriteLine("After the Task was created");
        }


    }
}
