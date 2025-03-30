using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Producto
    {
        public Producto()
        {
        }

        public int id {  get; set; }
        public string nombre { get; set; }
        public string codigo { get; set; }
        public string descripcion {  get; set; }
        public UnidadMedida unidadMedida { get; set; }
        public TipoProducto tipoProducto { get; set; }
        public bool estado { get; set; }

        public Producto(int id, string nombre, string codigo, string descripcion, UnidadMedida unidadMedida, TipoProducto tipoProducto, bool estado)
        {
            this.id = id;
            this.nombre = nombre;
            this.codigo = codigo;
            this.descripcion = descripcion;
            this.unidadMedida = unidadMedida;
            this.tipoProducto = tipoProducto;
            this.estado = estado;
        }
    }
}
