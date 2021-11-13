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
        // Time ranges
        public static DateTime T0 = new DateTime(2012,1,1); //  before T0
        public static DateTime T1 = new DateTime(2013,1,1); //  before T1

        // Upper data bounds
        public const double MaxMargin = 0.3;
        public const int TotalBonus = 300;
        public const int TotalBoughtProductCount = 20;
        public const int TotalMaxAgentCount = 10;

        public const int MaxHourlyRate = 30;
        public const int MaxMonthHours = 200;


        // Data row count
        public const int AgentCount = 100;
        public const int ClientCount = 100;
        public const int DepartmentCount = 100;
        public const int PhoneCallCount = 100;
        public const int ProducerCount = 100;
        public const int ProductCount = 100;
        public const int ExcelEntryCount = 100;

        static async Task<List<T>> Write<T>(string filename, Faker<T> faker, int count) where T : class
        {
            var data = faker.Generate(count);
            using (var writer = new StreamWriter(filename))
            using (var csv = new CsvWriter(writer, CultureInfo.InvariantCulture))
            {
                await csv.WriteRecordsAsync(data);
            }
            return data;
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
                .RuleFor(x => x.MaxAgentCount, f => random.Next() % TotalMaxAgentCount);
            await Write("departments.csv", testDepartments, DepartmentCount);

            var agentIds = 0;
            var agents = new List<Agent>();
            var testAgents = new Faker<Agent>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => agentIds++)
                .RuleFor(x => x.FirstName, f => f.Name.FirstName())
                .RuleFor(x => x.LastName, f => f.Name.LastName())
                .RuleFor(x => x.DepartmentId, f => random.Next() % DepartmentCount);
            using (var writer = new StreamWriter("agents.csv"))
            using (var csv = new CsvWriter(writer, CultureInfo.InvariantCulture))
            {
                agents = testAgents.Generate(AgentCount);
                await csv.WriteRecordsAsync(agents);
            }

            var testClients = new Faker<Client>()
                .StrictMode(true)
                .RuleFor(x => x.PhoneNumber, f => f.Person.Phone)
                .RuleFor(x => x.BoughtProductCount, f => random.Next() % TotalBoughtProductCount);
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
                .RuleFor(x => x.Margin, f => Math.Round(((decimal)(random.NextDouble() % MaxMargin)),2))
                .RuleFor(x => x.ProducerId, f => random.Next() % ProducerCount);
            await Write("products.csv", testProducts, ProductCount);

            var phoneCallIds = 0;
            var testCalls = new Faker<PhoneCall>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => phoneCallIds++)
                .RuleFor(x => x.Result, f => (random.Next() % 2) == 0 ? false : true)
                .RuleFor(x => x.CallDate, f => f.Date.Past(1,T0))
                .RuleFor(x => x.AgentId, f => random.Next() % AgentCount)
                .RuleFor(x => x.ProductId, f => random.Next() % ProductCount)
                .RuleFor(x => x.ClientId, f => random.Next() % ClientCount);
            await Write("calls.csv", testCalls, PhoneCallCount);

            var tempAgentId = random.Next() % AgentCount;
            var tempHourlyRate = random.Next() % MaxHourlyRate;
            var tempHourCount = random.Next() % MaxMonthHours;

            var testExcelEntries = new Faker<ExcelEntry>()
                .StrictMode(true)
                .RuleFor(x => x.Year, f => T0.Year-1)
                .RuleFor(x => x.Month,f => f.Date.Month())
                .RuleFor(x => x.AgentId, f => random.Next() % AgentCount)
                .RuleFor(x => x.FirstName, f => agents[tempAgentId].FirstName)
                .RuleFor(x => x.LastName, f => agents[tempAgentId].LastName)
                .RuleFor(x => x.DepartmentId, f => random.Next() % DepartmentCount)
                .RuleFor(x => x.HourlyRate, f => tempHourlyRate)
                .RuleFor(x => x.Bonus, f => random.Next() % TotalBonus)
                .RuleFor(x => x.HourCount, f => tempHourCount)
                .RuleFor(x => x.Salary, f => tempHourCount * tempHourlyRate)
                .FinishWith((x,y) => {
                    //  generate temp values for next round
                    tempAgentId = random.Next() % AgentCount;
                    tempHourlyRate = random.Next() % MaxHourlyRate;
                    tempHourCount = random.Next() % MaxMonthHours;
                });
            await Write("excel.csv", testExcelEntries, ExcelEntryCount);
        }
    }
}
