using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class ProductoEnFormula
    {
        public ProductoEnFormula() { }
        public ProductoEnFormula(Producto producto, decimal cantidad, bool estado) {
            this.producto = producto;
            this.cantidad = cantidad;
            this.estado = estado;
        }

        public Producto producto { get; set; }
        public decimal cantidad { get; set; }
        public bool estado {  get; set; }
    }
}
