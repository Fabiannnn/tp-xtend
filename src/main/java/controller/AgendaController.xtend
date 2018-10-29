package controller

import org.uqbar.xtrest.api.annotation.Controller
import eventos.Usuario
import org.uqbar.xtrest.json.JSONUtils
import jsons.JsonUsuario
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.Result
import repositorio.RepositorioUsuarios
import eventos.Evento
import java.util.Set

@Controller
class AgendaController {
	Set<Evento> eventosAgenda = newHashSet

	extension JSONUtils = new JSONUtils
	JsonUsuario jsonUsuario
	Usuario usuarioBuscado

	@Get('/agendaUsuario/:id')
	def Result agendaUsuario() {
		val iId = Integer.valueOf(id)

		try {
			usuarioBuscado = RepositorioUsuarios.instance.searchById(iId)

			usuarioBuscado.eventosAgenda = RepositorioUsuarios.instance.agendaUsuario(iId)
			
			ok(usuarioBuscado.eventosAgenda.toJson)
		} catch (Exception e) {
			notFound("No existe el Usuario con id " + id + "")
		}
	}

}
