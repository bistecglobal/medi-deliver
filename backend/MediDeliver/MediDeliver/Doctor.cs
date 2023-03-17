using Microsoft.Azure.CosmosRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Medi_Deliver
{
    public class Doctor:Item
    {

        public string Name { get; set; }
        public string Description { get; set; }
    }
}
