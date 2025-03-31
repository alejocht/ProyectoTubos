using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dao
{
    public interface AccesoDatos
    {
        SqlDataReader Lector { get; }
        void setConsulta(String query);
        void setParametro(String nombre, Object valor);
        void execLectura();
        void execAccion();
        void cerrarConexion();

    }
}
