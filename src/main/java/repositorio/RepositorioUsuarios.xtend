package repositorio

import eventos.Usuario
import java.util.List
import jsons.JsonUsuario
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepositorioUsuarios extends Repositorio<Usuario> {

	def usuariosIguales(String _nombreUsuario) {
		elementos.exists(elemento|elemento.nombreUsuario.contentEquals(_nombreUsuario))
	}

	override void recibirListaActualizacionJson(List<Usuario> usuarios) {
		usuarios.forEach[elemento|actualizarUsuarioConJson(elemento)]
	}

	def actualizarUsuarioConJson(Usuario _usuario) {

		if (usuariosIguales(_usuario.nombreUsuario)) {
			_usuario.id = elementos.findFirst(e|(e.nombreUsuario.equals(_usuario.nombreUsuario))).id
			update(_usuario)

		} else {
			this.create(_usuario)
		}
	}

	override updateAll() {
		val JsonUsuario jsonUsuario = new JsonUsuario
		jsonUsuario.deserializarJson(updateService.getUserUpdates(), this)

	}
}
