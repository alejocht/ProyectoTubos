using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class TipoGenerico
    {
        public int Id { get; set; }
        public string Descripcion { get; set; }
        public bool Estado { get; set;}

        public TipoGenerico() { }

        public TipoGenerico(int id, string descripcion, bool estado)
        {
            Id = id;
            Descripcion = descripcion;
            Estado = estado;
        }
    }
}
