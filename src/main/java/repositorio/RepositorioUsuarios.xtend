package repositorio

import org.eclipse.xtend.lib.annotations.Accessors
import eventos.Usuario
import java.util.List

@Accessors
class RepositorioUsuarios extends Repositorio<Usuario> {

	def usuariosIguales(String _nombreUsuario) {
		elementos.exists(elemento|elemento.nombreUsuario.contentEquals(_nombreUsuario))
	}

	override void recibirListaActualizacionJson(List<Usuario> usuarios) {
		usuarios.forEach[elemento|actualizarElementoJson(elemento)]
	}

	def actualizarElementoJson(Usuario _usuarios) {

		if (usuariosIguales(_usuarios.nombreUsuario)) {
			var int idAux
			idAux = elementos.findFirst(elemento|(elemento.nombreUsuario.equals(_usuarios.nombreUsuario))).id
			_usuarios.id = idAux
			update(_usuarios)

		} else {
			this.create(_usuarios)
		}
	}
}
