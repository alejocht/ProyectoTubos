using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Producto
    {
		private int id;
		private string nombre;
		private string codigo;
		private string descripcion;
		private UnidadMedida unidadMedida; 
		private TipoProducto tipoProducto;
        private bool estado;
    }
}
