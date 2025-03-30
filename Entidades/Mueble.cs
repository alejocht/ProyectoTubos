using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Mueble : Producto
    {
        public Mueble() { }

        public string familia { get; set; }

        public Mueble(int id, string nombre, string codigo, string descripcion, UnidadMedida unidadMedida, TipoProducto tipoProducto, bool estado, string familia)
            : base(id, nombre, codigo, descripcion, unidadMedida, tipoProducto, estado)
        {
            this.familia = familia;
        }
    }
}
