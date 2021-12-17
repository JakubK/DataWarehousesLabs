using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Threading.Tasks;

using Bogus;
using CsvHelper;
using CsvHelper.Configuration;
using DataGenerator.Models;

namespace DataGenerator
{
    class Program
    {
        // Time ranges
        public static DateTime T0 = new DateTime(2012, 1, 1); //  before T0
        public static DateTime T1 = new DateTime(2013, 1, 1); //  before T1

        // Upper data bounds
        public const double MaxMargin = 0.3;
        public const int TotalBonus = 300;
        public const int TotalBoughtProductCount = 20;
        public const int TotalMaxAgentCount = 50;

        public const int MinHourlyRate = 15;
        public const int MaxHourlyRate = 40;
        public const int MaxMonthHours = 200;
        public const double BonusChance = 0.25;


        // Data row count
        public const int AgentCount = 500;
        public const int ClientCount = 1000;
        public const int DepartmentCount = 5;
        public const int PhoneCallCount = 5000;
        public const int ProducerCount = 10;
        public const int ProductCount = 100;
        public const int ExcelEntryCount = 100;
        public const double callSuccessChance = 0.3;


        // T1 change probabilities
        public const double AgentLaidOffProb = 0.10;

        public const double ClientChangeProbability = 0.15;

        public const double PriceAndMarginChangeProb = 0.25;
        public const double MaxPriceAndMarginChange = 0.30; // percentage, e.g. 0.3 means that change in price is 30%, should be less than 1
        public const double ProductChangeProb = 0.10;

        public const double SalaryRiseProb = 0.15;
        public const double MaxSalaryRise = 0.25;
        // TODO consider removing producer from T1 if none of his products exist

        // Generate data and write it to file
        static async Task<List<T>> Write<T>(string filename, Faker<T> faker, int count) where T : class
        {
            var data = faker.Generate(count);
            await WriteData(filename, data);
            return data;
        }

        // Write generated data to file
        static async Task WriteData<T>(string filename, List<T> data) where T : class
        {
            var config = new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                NewLine = Environment.NewLine,
                Delimiter = "|"
            };

            using (var writer = new StreamWriter(filename))
            using (var csv = new CsvWriter(writer,config))
            {
                await csv.WriteRecordsAsync(data);
            }
        }

        static T RandomObjectFromList<T>(List<T> list, Random random)
        {
            var randInd = random.Next(list.Count);
            return list[randInd];
        }

        static async Task Main(string[] args)
        {
            var random = new Random();

            var departmentIds = 0;
            var testDepartments = new Faker<Department>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => departmentIds++)
                .RuleFor(x => x.Name, f => f.Commerce.Department())
                .RuleFor(x => x.Country, f => f.Address.Country())
                .RuleFor(x => x.Location, f => f.Address.City()
                    .Replace(',',' ')
                    .Replace('"',' ')
                    .Trim())
                .RuleFor(x => x.MaxAgentCount, f => random.Next() % TotalMaxAgentCount);
            var departments = await Write("t0_departments.csv", testDepartments, DepartmentCount);

            var agentIds = 0;
            var agents = new List<Agent>();
            var testAgents = new Faker<Agent>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => agentIds++)
                .RuleFor(x => x.FirstName, f => f.Name.FirstName())
                .RuleFor(x => x.LastName, f => f.Name.LastName())
                .RuleFor(x => x.DepartmentId, f => random.Next() % DepartmentCount);

            agents = testAgents.Generate(AgentCount);
            await WriteData("t0_agents.csv", agents);

            var testClients = new Faker<Client>()
                .StrictMode(true)
                .RuleFor(x => x.PhoneNumber, f => f.Person.Phone)
                .RuleFor(x => x.BoughtProductCount, f => random.Next() % TotalBoughtProductCount);
            var clients = await Write("t0_clients.csv", testClients, ClientCount);

            var producerIds = 0;
            var testProducers = new Faker<Producer>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => producerIds++)
                .RuleFor(x => x.Name, f => f.Company.CompanyName());
            var producers = await Write("t0_producers.csv", testProducers, ProducerCount);

            var productIds = 0;
            var testProducts = new Faker<Product>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => productIds++)
                .RuleFor(x => x.Name, f => f.Commerce.ProductName())
                .RuleFor(x => x.Price, f => decimal.Parse(f.Commerce.Price()))
                .RuleFor(x => x.Margin, f => Math.Round(((decimal)(random.NextDouble() % MaxMargin)), 2))
                .RuleFor(x => x.ProducerId, f => random.Next() % ProducerCount);
            var products = await Write("t0_products.csv", testProducts, ProductCount);

            var phoneCallIds = 0;
            var testCalls = new Faker<PhoneCall>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => phoneCallIds++)
                .RuleFor(x => x.Result, f => (callSuccessChance >= random.NextDouble() ? 1 : 0))
                .RuleFor(x => x.CallDate, f => f.Date.Past(1, T0))
                .RuleFor(x => x.AgentId, f => random.Next() % AgentCount)
                .RuleFor(x => x.ProductId, f => random.Next() % ProductCount)
                .RuleFor(x => x.ClientId,f => RandomObjectFromList(clients, random).PhoneNumber);
            await Write("t0_calls.csv", testCalls, PhoneCallCount);

            var wages = new Dictionary<int, decimal>();
            foreach (Agent agent in agents)
            {
                wages.Add(agent.Id, (decimal)Math.Round(MinHourlyRate + (MaxHourlyRate - MinHourlyRate) * random.NextDouble(), 2));
            }

            var tempHourCount = random.Next() % MaxMonthHours;
            List<ExcelEntry> entries = new List<ExcelEntry>();
            foreach(Agent a in agents)
            {
                for(int j = 0;j < 12;j++) {
                    entries.Add(new ExcelEntry {
                        Year = T0.Year - 1,
                        Month = CultureInfo.InvariantCulture.DateTimeFormat.MonthNames[j],
                        AgentId = a.Id,
                        FirstName = a.FirstName,
                        LastName = a.LastName,
                        DepartmentId = a.DepartmentId,
                        HourlyRate = wages[a.Id],
                        Bonus = random.NextDouble() <= BonusChance ? random.Next() % TotalBonus : 0,
                        HourCount = tempHourCount,
                        Salary = tempHourCount * wages[a.Id]
                    });
                }
                tempHourCount = random.Next() % MaxMonthHours;
            }
            await WriteData("t0_excel.csv", entries);


            ///////////////////////////////////////////////////////////////////////////////
            // T1 code //
            ///////////////////////////////////////////////////////////////////////////////
            await WriteData("t1_departments.csv", departments);

            for (int i = 0; i < agents.Count; i++)
            {
                if (random.NextDouble() <= AgentLaidOffProb)
                {
                    agents[i] = testAgents.Generate(1)[0];
                    wages.Add(agents[i].Id, (decimal)Math.Round(MinHourlyRate + (MaxHourlyRate - MinHourlyRate) * random.NextDouble(), 2));
                }
            }
            await WriteData("t1_agents.csv", agents);


            for (int i = 0; i < clients.Count; i++)
            {
                if (random.NextDouble() <= ClientChangeProbability)
                {
                    clients[i] = testClients.Generate(1)[0];
                }
            }
            await WriteData("t1_clients.csv", clients);

            await WriteData("t1_producers.csv", producers);

            for (int i = 0; i < products.Count; i++)
            {
                if (random.NextDouble() <= PriceAndMarginChangeProb)
                {
                    var priceChange = (2 * random.NextDouble() - 1) * MaxPriceAndMarginChange * (double)products[i].Price;
                    priceChange = Math.Round(priceChange, 2);
                    products[i].Price += (decimal)priceChange;

                    var marginChange = (2 * random.NextDouble() - 1) * MaxPriceAndMarginChange * (double)products[i].Margin;
                    marginChange = Math.Round(marginChange, 2);
                    products[i].Margin += (decimal)marginChange;
                }

                if (random.NextDouble() <= ProductChangeProb)
                {
                    products[i] = testProducts.Generate(1)[0];
                }
            }
            await WriteData("t1_products.csv", products);

            phoneCallIds = 0;
            testCalls = new Faker<PhoneCall>()
                .StrictMode(true)
                .RuleFor(x => x.Id, f => phoneCallIds++)
                .RuleFor(x => x.Result, f => (callSuccessChance >= random.NextDouble() ? 1 : 0))
                .RuleFor(x => x.CallDate, f => f.Date.Past(1, T1))
                .RuleFor(x => x.AgentId, f => RandomObjectFromList(agents, random).Id)
                .RuleFor(x => x.ProductId, f => RandomObjectFromList(products, random).Id)
                .RuleFor(x => x.ClientId, f => RandomObjectFromList(clients, random).PhoneNumber);
            await Write("t1_calls.csv", testCalls, PhoneCallCount);

            foreach (Agent a in agents)
            {
                if (SalaryRiseProb <= random.NextDouble())
                {
                    wages[a.Id] *= (decimal)(MaxSalaryRise * random.NextDouble());
                }
            }
            
            tempHourCount = random.Next() % MaxMonthHours;
            entries = new List<ExcelEntry>();
            foreach(Agent a in agents)
            {
                for(int j = 0;j < 12;j++) {
                    entries.Add(new ExcelEntry {
                        Year = T1.Year - 1,
                        Month = CultureInfo.InvariantCulture.DateTimeFormat.MonthNames[j],
                        AgentId = a.Id,
                        FirstName = a.FirstName,
                        LastName = a.LastName,
                        DepartmentId = a.DepartmentId,
                        HourlyRate = wages[a.Id],
                        Bonus = random.NextDouble() <= BonusChance ? random.Next() % TotalBonus : 0,
                        HourCount = tempHourCount,
                        Salary = tempHourCount * wages[a.Id]
                    });
                }
                tempHourCount = random.Next() % MaxMonthHours;
            }
            await WriteData("t1_excel.csv", entries);
        }
    }
}
