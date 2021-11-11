using System;

namespace DataGenerator.Models
{
    public class PhoneCall
    {
        public int Id { get; set; }
        public DateTime CallDate { get; set; }
        public bool Result { get; set; }

        public int ProductId { get; set; }
        public int AgentId { get; set; }
        public int ClientId { get; set; }
    }
}