using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;

namespace Dao
{
    public interface IUsuarioDao
    {
        void agregarUsuario(Usuario usuario);
        void modificarUsuario(Usuario usuario);
        void eliminarUsuario(Usuario usuario);
        Usuario listarUsuario(int id);
        List<Usuario> listarUsuarios();

    }
}
