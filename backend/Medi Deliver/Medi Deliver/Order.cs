using Microsoft.Azure.CosmosRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata;
using System.Text;
using System.Threading.Tasks;

namespace Medi_Deliver
{
    public  class Order:Item
    {
        public string Id { get; set; }
        public string Details { get; set; }
        public DateTime Date { get; set; }
        public DateTime Time { get; set; }

        public string Address { get; set; }

        public Blob Prescription { get; set; }
        public float MedicineCost { get; set; }

        public Status Status { get; set; }
    }
}
