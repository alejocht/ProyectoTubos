using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Movimiento
    {
        public Movimiento()
        {
        }

        public int id { get; set; }
        public DateTime fechahora { get; set; }
        public Producto producto { get; set; }
        public TipoMovimiento tipoMovimiento { get; set; }
        public Deposito depositoOrigen {  get; set; }
        public Deposito depositoDestino {  get; set; }
        public bool estado {  get; set; }

        public Movimiento(int id, DateTime fechahora, Producto producto, TipoMovimiento tipoMovimiento, Deposito depositoOrigen, Deposito depositoDestino, bool estado)
        {
            this.id = id;
            this.fechahora = fechahora;
            this.producto = producto;
            this.tipoMovimiento = tipoMovimiento;
            this.depositoOrigen = depositoOrigen;
            this.depositoDestino = depositoDestino;
            this.estado = estado;
        }
    }
}
