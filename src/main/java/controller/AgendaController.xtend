package controller

import org.uqbar.xtrest.api.annotation.Controller
import eventos.Usuario
import org.uqbar.xtrest.json.JSONUtils
//import jsons.JsonUsuario
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.Result
import repositorio.RepositorioUsuarios
//import eventos.Evento
//import java.util.Set
//import repositorio.RepositorioLocaciones

@Controller
class AgendaController {
	//FP Set<Evento> eventosAgenda = newHashSet

	extension JSONUtils = new JSONUtils
	//FP JsonUsuario jsonUsuario
	Usuario usuarioBuscado

	@Get('/agendaHoy/:id')
	def Result agendaHoy() {
		val iId = Integer.valueOf(id)
		try {
			usuarioBuscado = RepositorioUsuarios.instance.searchById(iId)
			usuarioBuscado.eventosAgenda = RepositorioUsuarios.instance.agendaHoy(iId)
			ok(usuarioBuscado.eventosAgenda.toJson)
		} catch (Exception e) {
			notFound("No existe el Usuario con id " + id + "")
		}
	}

	@Get('/agendaSemana/:id')
	def Result agendaSemana() {
		val iId = Integer.valueOf(id)
		try {
			usuarioBuscado = RepositorioUsuarios.instance.searchById(iId)
			usuarioBuscado.eventosAgenda = RepositorioUsuarios.instance.agendaSemana(iId)
			ok(usuarioBuscado.eventosAgenda.toJson)
		} catch (Exception e) {
			notFound("No existe el Usuario con id " + id + "")
		}
	}

	@Get('/agendaProximos/:id')
	def Result agendaProximos() {
		val iId = Integer.valueOf(id)
		try {
			usuarioBuscado = RepositorioUsuarios.instance.searchById(iId)
			usuarioBuscado.eventosAgenda = RepositorioUsuarios.instance.agendaProximos(iId)
			ok(usuarioBuscado.eventosAgenda.toJson)
		} catch (Exception e) {
			notFound("No existe el Usuario con id " + id + "")
		}
	}

	@Get('/agendaUsuario/:id')
	def Result agendaUsuario() {
		val iId = Integer.valueOf(id)
		try {
			usuarioBuscado = RepositorioUsuarios.instance.searchById(iId)
			usuarioBuscado.eventosAgenda = RepositorioUsuarios.instance.agendaUsuario(iId)
			ok(usuarioBuscado.eventosAgenda.toJson)
		} catch (Exception e) {
			notFound("No existe el Usuario con id " + id + " al buscar la agenda de usuario")
		}
	}

	@Get('/organizadosUsuarioAbiertos/:id')
	def Result organizadosUsuarioAbiertos() {
		val iId = Integer.valueOf(id)
		try {
			usuarioBuscado = RepositorioUsuarios.instance.searchById(iId)
			usuarioBuscado.eventosAgenda = RepositorioUsuarios.instance.organizadosUsuarioAbiertos(iId)
			ok(usuarioBuscado.eventosAgenda.toJson)
		} catch (Exception e) {
			notFound("No existe el Usuario con id " + id + "")
		}
	}

	@Get('/organizadosUsuarioCerrados/:id')
	def Result organizadosUsuarioCerrados() {
		val iId = Integer.valueOf(id)
		try {
			usuarioBuscado = RepositorioUsuarios.instance.searchById(iId)
			usuarioBuscado.eventosAgenda = RepositorioUsuarios.instance.organizadosUsuarioCerrados(iId)
			ok(usuarioBuscado.eventosAgenda.toJson)
		} catch (Exception e) {
			notFound("No existe el Usuario con id " + id + "")
		}
	}

}
