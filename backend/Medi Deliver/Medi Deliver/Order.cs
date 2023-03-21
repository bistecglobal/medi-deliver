using Azure.Storage.Blobs.Models;
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
        //public string Id { get; set; }
        public DateTime Date { get; set; }
        public TimeOnly Time { get; set; }

        public string Address { get; set; }

        //public string Prescription { get; set; }
        public string Image { get; set; }
        //public float MedicineCost { get; set; }

        public string Status { get; set; }
    }
}
