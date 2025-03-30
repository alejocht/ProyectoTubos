using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class StockProducto
    {
        public Producto producto { get; set; }
        public Deposito deposito { get; set; }
        public decimal cantidad { get; set; }
        public bool estado {  get; set; }
    }
}
