using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class TipoMovimiento : TipoGenerico
    {
        public TipoMovimiento() { }
        public TipoMovimiento(int id, string descripcion, bool estado) : base(id, descripcion, estado) { }
    }
   
}
