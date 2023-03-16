using Microsoft.Azure.CosmosRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Medi_Deliver
{
    public class MedicalCenter:Item
    {
        public string M_Name { get; set; }
        public string M_Location { get; set; }
    }
}
