using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Deposito
    {
        private int id;
        private string nombre;
        private string descripcion;
        private TipoDeposito tipoDeposito;
        private List<ElementoContable> elementosDeDeposito;
    }
}
