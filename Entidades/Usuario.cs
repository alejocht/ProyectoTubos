﻿using System;
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
            tipoUsuario = new TipoUsuario();
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
        public override string ToString()
        {
            return "USUARIO[ ID: "+ id + " USUARIO: "+ usuario +" PASSWORD: ********"+ contrasenia +" ID TIPO USUARIO: "+ tipoUsuario.Id +" TIPO USUARIO DESCR: "+ tipoUsuario.Descripcion +" ESTADO: "+ estado +" ]";
        }
    }
}
