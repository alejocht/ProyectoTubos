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
            users = dao.listarUsuarios();
            Console.WriteLine("HOLA");
            foreach (Usuario usuario in users)
            {
                Console.WriteLine(usuario.ToString());
            }
            Console.ReadKey();
        }
    }
}
