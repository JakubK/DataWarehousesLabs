namespace DataGenerator.Models
{
    public class ExcelEntry
    {
        public int Year { get; set; }
        public string Month { get; set; }
        public int AgentId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int DepartmentId { get; set; }
        public decimal HourlyRate { get; set; }
        public decimal Bonus { get; set; }
        public int HourCount { get; set; }
        public decimal Salary { get; set; }

    }
}