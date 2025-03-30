using Dao;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DaoImpl
{
    public class AccesoDatosImpl : AccesoDatos
    {
        private SqlConnection conexion;
        private SqlCommand comando;
        private SqlDataReader lector;

        public SqlDataReader Lector
        {
            get { return lector; }
        }

        public AccesoDatosImpl()
        {
            conexion = new SqlConnection("");
            comando = new SqlCommand();
        }

        public void setConsulta(string query)
        {
            comando.CommandType = System.Data.CommandType.Text;
            comando.CommandText = query;
        }

        public void setParametro(string nombre, object valor)
        {
            comando.Parameters.AddWithValue(nombre, valor);
        }

        public void execLectura()
        {
            comando.Connection = conexion;
            try
            {
                conexion.Open();
                lector = comando.ExecuteReader();

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public void execAccion()
        {
            comando.Connection = conexion;
            try
            {
                conexion.Open();
                comando.ExecuteNonQuery();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public void cerrarConexion()
        {
            if (lector != null)
                lector.Close();
            conexion.Close();
        }
    }
}
