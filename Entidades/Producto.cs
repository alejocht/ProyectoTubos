using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Producto
    {
		int id;
		string nombre;
		string codigo;
		string descripcion;
		int id_unidad_medida; //tiene que ser clase unidad medida
		int id_tipo_producto; //tiene que ser clase tipo producto
        bool estado;
    }
}
