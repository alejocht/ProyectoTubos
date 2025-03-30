using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Tubo : Producto
    {
        Tubo() {}

        public decimal peso_x_metro;

        public Tubo(int id, string nombre, string codigo, string descripcion, UnidadMedida unidadMedida, TipoProducto tipoProducto, bool estado, decimal peso_x_metro)
            : base (id, nombre, codigo, descripcion, unidadMedida, tipoProducto, estado)
        {
            this.peso_x_metro = peso_x_metro;
        }
    }
}
