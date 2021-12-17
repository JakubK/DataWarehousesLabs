using System;

namespace DataGenerator.Models
{
    public class PhoneCall
    {
        public int Id { get; set; }
        public DateTime CallDate { get; set; }
        public int Result { get; set; }

        public int ProductId { get; set; }
        public int AgentId { get; set; }
        public string ClientId { get; set; }
    }
}