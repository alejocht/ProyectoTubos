using Dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
namespace DaoImpl
{
    public class UsuarioDao : IUsuarioDao
    {
        public UsuarioDao() { }

        private const string spAgregar = "EXEC SP_AgregarUsuario @usuario, @contrasenia, @id_tipo_usuario";
        private const string spEliminar = "EXEC SP_EliminarUsuario ?, ?";
        private const string spListarUsuario = "EXEC SP_ListarUsuario ?";
        private const string spListar = "EXEC SP_ListarUsuarios";
        private const string spModificar = "EXEC SP_ModificarUsuario";

        public void agregarUsuario(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatosImpl();
            try
            {
                datos.setConsulta(spAgregar);
                datos.setParametro("@usuario", usuario.usuario);
                datos.setParametro("@contrasenia", usuario.contrasenia);
                datos.setParametro("@id_tipo_usuario", usuario.tipoUsuario.Id);
                datos.execAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void eliminarUsuario(Usuario usuario)
        {
            throw new NotImplementedException();
        }

        public Usuario listarUsuario(int id)
        {
            throw new NotImplementedException();
        }

        public List<Usuario> listarUsuarios()
        {
            throw new NotImplementedException();
        }

        public void modificarUsuario(Usuario usuario)
        {
            throw new NotImplementedException();
        }
    }
}
