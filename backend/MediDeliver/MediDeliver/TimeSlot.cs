using Microsoft.Azure.CosmosRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Medi_Deliver
{
    public class TimeSlot:Item
    {
        public string Title { get; set; }
        public string Selection { get; set; }
        public DateTime Time { get; set; }
    }
}
