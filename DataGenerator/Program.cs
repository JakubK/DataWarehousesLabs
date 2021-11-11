using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Threading.Tasks;
using Bogus;
using CsvHelper;
using DataGenerator.Models;

namespace DataGenerator
{
    class Program
    {
        public static int AgentCount = 100;
        public static int ClientCount = 100;

        public static int DepartmentCount = 100;

        public static int PhoneCallCount = 100;

        public static int ProducerCount = 100;
        public static int ProductCount = 100;

        static async Task Write<T>(string filename, Faker<T> faker, int count) where T : class
        {
            using (var writer = new StreamWriter(filename))
            using (var csv = new CsvWriter(writer, CultureInfo.InvariantCulture))
            {
                await csv.WriteRecordsAsync(faker.Generate(count));
            }
        }
        static async Task Main(string[] args)
        {
            var random = new Random();

            var departmentIds = 0;
            var testDepartments = new Faker<Department>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => departmentIds++)
                .RuleFor(x => x.Name, f => f.Commerce.Department())
                .RuleFor(x => x.Location, f => f.Address.City())
                .RuleFor(x => x.MaxAgentCount, f => random.Next() % 10);
            await Write("departments.csv", testDepartments, DepartmentCount);

            var agentIds = 0;
            var testAgents = new Faker<Agent>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => agentIds++)
                .RuleFor(x => x.Name, f => f.Name.FirstName())
                .RuleFor(x => x.Surname, f => f.Name.LastName())
                .RuleFor(x => x.DepartmentId, f => random.Next() % DepartmentCount);
            await Write("agents.csv", testAgents, AgentCount);

            var testClients = new Faker<Client>()
                .StrictMode(true)
                .RuleFor(x => x.PhoneNumber, f => f.Person.Phone)
                .RuleFor(x => x.BoughtProductCount, f => random.Next() % 20);
            await Write("clients.csv", testClients, ClientCount);

            var producerIds = 0;
            var testProducers = new Faker<Producer>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => producerIds++)
                .RuleFor(x => x.Name, f => f.Company.CompanyName());
            await Write("producers.csv", testProducers, ProducerCount);

            var productIds = 0;
            var testProducts = new Faker<Product>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => productIds++)
                .RuleFor(x => x.Name, f => f.Commerce.ProductName())
                .RuleFor(x => x.Price, f => decimal.Parse(f.Commerce.Price()))
                .RuleFor(x => x.Margin, f => Math.Round(((decimal)random.NextDouble()),2))
                .RuleFor(x => x.ProducerId, f => random.Next() % ProducerCount);
            await Write("products.csv", testProducts, ProductCount);

            var phoneCallIds = 0;
            var testCalls = new Faker<PhoneCall>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => phoneCallIds++)
                .RuleFor(x => x.Result, (random.Next() % 2) == 0 ? false : true)
                .RuleFor(x => x.CallDate, f => f.Date.Past())
                .RuleFor(x => x.AgentId, f => random.Next() % AgentCount)
                .RuleFor(x => x.ProductId, f => random.Next() % ProductCount)
                .RuleFor(x => x.ClientId, f => random.Next() % ClientCount);
            await Write("calls.csv", testProducts, ProductCount);
        }
    }
}
