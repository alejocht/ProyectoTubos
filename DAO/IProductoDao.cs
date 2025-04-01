using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public interface IProductoDao
    {
        void agregarProducto(Producto producto, Usuario usuario);
        void modificarProducto(Producto producto, Usuario usuario);
        void eliminarProducto(Producto producto, Usuario usuario);
        List<Producto> listarProductos();
        Producto listarProducto(Producto producto);
    }
}
