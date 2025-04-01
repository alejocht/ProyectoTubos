using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
using DaoImpl;
namespace ConsoleApp
{
    internal class Program
    {
        static void Main(string[] args)
        {
            List<Usuario> users = new List<Usuario>();
            UsuarioDao dao = new UsuarioDao();
            Usuario usuarioLog = new Usuario();
            Usuario usuarioNuevo2 = new Usuario();
            usuarioNuevo2 = dao.listarUsuario(3);
            usuarioNuevo2.usuario = "nombreCambiado";
            usuarioLog.id = 1;
            dao.modificarUsuario(usuarioNuevo2, usuarioLog);
            users = dao.listarUsuarios();
            foreach (Usuario usuario in users)
            {
                Console.WriteLine(usuario.ToString());
            }
            Console.ReadKey();
        }
    }
}
