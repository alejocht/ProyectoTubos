using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class ProductoEnDeposito
    {
        public Producto producto { get; set; }
        public Deposito deposito { get; set; }
        public decimal cantidad { get; set; }
        public bool estado {  get; set; }


        public ProductoEnDeposito(Producto producto, Deposito deposito, decimal cantidad, bool estado)
        {
            this.producto = producto;
            this.deposito = deposito;
            this.cantidad = cantidad;
            this.estado = estado;
        }

        public ProductoEnDeposito()
        {
        }
    }
}
