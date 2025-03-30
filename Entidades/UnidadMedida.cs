using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class UnidadMedida : TipoGenerico
    {
        public UnidadMedida(){ }
        public UnidadMedida(int id,  string descripcion, bool estado) : base(id, descripcion, estado) { }
    }
}
