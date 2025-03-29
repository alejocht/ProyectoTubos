using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Deposito
    {
        public Deposito()
        {
        }

        public int id {  get; set; }
        public string nombre { get; set; }
        public string descripcion { get; set; }
        public TipoDeposito tipoDeposito { get; set; }
        public List<Producto> productos { get; set; }
        public bool estado {  get; set; }

        public Deposito(int id, string nombre, string descripcion, TipoDeposito tipoDeposito, List<Producto> productos, bool estado)
        {
            this.id = id;
            this.nombre = nombre;
            this.descripcion = descripcion;
            this.tipoDeposito = tipoDeposito;
            this.productos = productos;
            this.estado = estado;
        }

        
    }
}
