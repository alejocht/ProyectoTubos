using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Usuario
    {
        public Usuario()
        {
        }
        public int id {  get; set; }
        public string usuario { get; set; }
        public string contrasenia { get; set; }
        public TipoUsuario tipoUsuario { get; set; }
        public bool estado { get; set; }

        public Usuario(int id, string usuario, string contrasenia, TipoUsuario tipoUsuario, bool estado)
        {
            this.id = id;
            this.usuario = usuario;
            this.contrasenia = contrasenia;
            this.tipoUsuario = tipoUsuario;
            this.estado = estado;
        }
    }
}
