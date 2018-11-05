package controller

import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import repositorio.RepositorioUsuarios

@Controller
class EventoController {
	extension JSONUtils = new JSONUtils

	@Get('/organizados-por-mi-abiertos/:id')
	// FP Transformamos la lista de eventos del usuario en Json.
	def Result eventosAbiertos() {
		val iId = Integer.valueOf(id)
		try {
			ok(RepositorioUsuarios.instance.buscarEventosAbiertoUsuario(iId).toJson)
		} catch (Exception e) {
			internalServerError(e.message)
			notFound("El usuario " + id + " no organizo eventos!")
		}
	}

	@Get('/organizados-por-mi-cerrados/:id')
	// FP Transformamos la lista de eventos del usuario en Json.
	def Result eventosCerrados() {
		val iId = Integer.valueOf(id)
		try {
			ok(RepositorioUsuarios.instance.buscarEventosCerradosUsuario(iId).toJson)
		} catch (Exception e) {
			internalServerError(e.message)
			notFound("El usuario " + id + " no organizo eventos!")
		}
	}
}
