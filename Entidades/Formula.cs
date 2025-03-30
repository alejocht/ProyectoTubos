using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Formula
    {
        public Formula()
        {
        }

        public int id {  get; set; }
        public string nombre { get; set; }
        public string codigo { get; set; }
        public string descripcion {  get; set; }
        public List<ProductoEnFormula> productosEnFormula { get; set; }
        public bool estado { get; set; }

        public Formula(int id, string nombre, string codigo, string descripcion, List<ProductoEnFormula> productosEnFormula, bool estado)
        {
            this.id = id;
            this.nombre = nombre;
            this.codigo = codigo;
            this.descripcion = descripcion;
            this.productosEnFormula = productosEnFormula;
            this.estado = estado;
        }
    }
}
