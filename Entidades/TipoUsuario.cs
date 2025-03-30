using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class TipoUsuario : TipoGenerico
    {
        public TipoUsuario() { }
        public TipoUsuario(int id, string descripcion, bool estado) : base(id, descripcion, estado) { }
    }
}
