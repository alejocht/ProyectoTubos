using Dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
using System.Net;
using DaoImpl;
namespace DaoImpl
{
    public class UsuarioDao : IUsuarioDao
    {
        public UsuarioDao() { }

        private const string spAgregar = "EXEC SP_AgregarUsuario @usuario, @contrasenia, @id_tipo_usuario";
        private const string spEliminar = "EXEC SP_EliminarUsuario @idusuarioEliminar, @idusuarioAuditoria";
        private const string spListarUsuario = "EXEC SP_ObtenerUsuario @idusuario";
        private const string spListar = "EXEC SP_ObtenerUsuarios";
        private const string spModificar = "EXEC SP_ModificarUsuario @idusuarioModificar, @usuario, @id_tipo_usuario, @idusuarioAuditoria";

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

        public void eliminarUsuario(Usuario usuario, Usuario userLogged)
        {
            AccesoDatos datos = new AccesoDatosImpl();
            try
            {
                datos.setConsulta(spEliminar);
                datos.setParametro("@idusuarioEliminar", usuario.id);
                datos.setParametro("@idusuarioAuditoria", userLogged.id);
                datos.execAccion();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally { datos.cerrarConexion();}

        }

        public Usuario listarUsuario(int id)
        {
            AccesoDatos datos=new AccesoDatosImpl();
            Usuario usuario = new Usuario();
            try
            {
                datos.setConsulta(spListarUsuario);
                datos.setParametro("@idusuario", id);
                datos.execLectura();
                usuario.id = (int)datos.Lector["id"];
                usuario.usuario = (string)datos.Lector["usuario"];
                usuario.tipoUsuario.Id = (int)datos.Lector["id_tipo_usuario"];
                usuario.tipoUsuario.Descripcion = (string)datos.Lector["descripcion"];
                usuario.estado = (bool)datos.Lector["estado"];
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally { datos.cerrarConexion();} return usuario;
        }

        public List<Usuario> listarUsuarios()
        {
            AccesoDatos datos = new AccesoDatosImpl();
            List<Usuario> usuarios = new List<Usuario> ();
            try
            {
                datos.setConsulta(spListar);
                datos.execLectura();
                while(datos.Lector.Read())
                {
                    Usuario aux = new Usuario();
                    aux.id = (int)datos.Lector["id"];
                    aux.usuario = (string)datos.Lector["usuario"];
                    //aux.contrasenia = (string)datos.Lector["pass"];
                    aux.tipoUsuario.Id = (int)datos.Lector["id_tipo_usuario"];
                    aux.tipoUsuario.Descripcion = (string)datos.Lector["descripcion"];
                    aux.estado = (bool)datos.Lector["estado"];
                    usuarios.Add(aux);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally 
            { 
                datos.cerrarConexion();
                
            }
            return usuarios;
        }

        public void modificarUsuario(Usuario usuario, Usuario userLogged)
        {
            AccesoDatos datos = new AccesoDatosImpl();
            try
            {
                datos.setConsulta(spModificar);
                datos.setParametro("@idusuarioModificar", usuario.id);
                datos.setParametro("@usuario", usuario.usuario);
                //datos.setParametro("@contrasenia", usuario.contrasenia);
                datos.setParametro("@id_tipo_usuario", usuario.tipoUsuario.Id);
                datos.setParametro("@idusuarioAuditoria", userLogged.id);
                datos.execAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally { datos.cerrarConexion();}
        }
    }
}
