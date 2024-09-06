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

            Task secondTask = ConsoleAfterDelayAsync("Task 2", 150);
            Task thirdTask = ConsoleAfterDelayAsync("Task 3", 50);

            await fisrtName;
            Console.WriteLine("After the Task was created");

            await secondTask;
            await thirdTask;

            static async Task ConsoleAfterDelayAsync(string text, int delayTime)
            {
                // Thread.Sleep(delayTime);
                await Task.Delay(delayTime);
                Console.WriteLine(text);
            }

        }


    }
}
