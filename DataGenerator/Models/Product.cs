namespace DataGenerator.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public decimal Margin { get; set; }

        public int ProducerId { get; set; }
    }
}