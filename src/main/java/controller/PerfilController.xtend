package controller

import eventos.Usuario
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import repositorio.RepositorioUsuarios

@Controller
class PerfilController {
	Usuario usuarioBuscado
	extension JSONUtils = new JSONUtils

	// JsonUsuario jsonUsuario
	// (usuarioIng.id + usuarioIng.nombreUsuario + usuarioIng.nombreApellido + usuarioIng.tipoDeUsuario.nom).toJson	}
	@Get('/usuarioPerfil/:id')
	def Result perfil() {
		val iId = Integer.valueOf(id)
		try {
			usuarioBuscado = RepositorioUsuarios.instance.searchById(iId)
			ok(usuarioBuscado.toJson)
		// ok((RepositorioUsuarios.instance.searchById(iId).toJson))
		} catch (Exception e) {
			notFound("No existe el Usuario con id " + id + "")
		}
	}

	@Get('/usuarios')
	def Result usuarios() {
		try {
			val usuarios = RepositorioUsuarios.getInstance.elementos
			ok(usuarios.toJson)
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	@Get('/amigosUsuario/:id')
	def Result amigosUsuario() {
		val iId = Integer.valueOf(id)

		try {
			usuarioBuscado = RepositorioUsuarios.instance.searchById(iId)

		ok(usuarioBuscado.amigos.sortBy[nombreApellido].toJson)
		// ok((RepositorioUsuarios.instance.searchById(iId).toJson))
		} catch (Exception e) {
			notFound("No existe el Usuario con id " + id + "")
		}
	}

	/*Para eliminar amigos*/
	@Put('/eliminarAmigo/:id')
	def Result eliminarAmigo(@Body String body) {
		val idPerfil = Integer.valueOf(id)

		val idExAmigo = Integer.valueOf(body.getPropertyValue("idAmigo"))

		try {
			val usuarioPerfil = RepositorioUsuarios.instance.searchById(idPerfil)
			val usuarioExAmigo = RepositorioUsuarios.instance.searchById(idExAmigo)
			usuarioPerfil.amigos.remove(usuarioExAmigo)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get('/eventosAgendaUsuario/:id')
	def Result eventosAgendaUsuario() {
		val iId = Integer.valueOf(id)

		try {
			usuarioBuscado = RepositorioUsuarios.instance.searchById(iId)

			usuarioBuscado.eventosAgenda = RepositorioUsuarios.instance.agendaUsuario(iId)
			println(" en perfil controller   " + usuarioBuscado.eventosAgenda)
			ok(usuarioBuscado.eventosAgenda.toJson)
		} catch (Exception e) {
			notFound("No existe el Usuario con id " + id)
		}
	}

	@Get('/invitacionesPendientes/:id')
	def Result invitacionesPendientes() {
		val iId = Integer.valueOf(id)
		try {
			usuarioBuscado = RepositorioUsuarios.instance.searchById(iId)
			//estos println son para chequear por consola el estado de las invitaciones segun lo que se pida desde angular
			 println("<<<<<    Rechazadas   >>>>>>\n" +usuarioBuscado.invitaciones.filter[invitacion|invitacion.aceptada ===false].toList.toJson)			
			 println("<<<<<    Aceptadas   >>>>>>\n" +usuarioBuscado.invitaciones.filter[invitacion|invitacion.aceptada ===true].toList.toJson)
			 println("<<<<<    Pendientes   >>>>>>\n"+ usuarioBuscado.invitaciones.filter[invitacion|invitacion.aceptada === null].toList.toJson)
			ok(usuarioBuscado.invitaciones.filter[invitacion|invitacion.aceptada === null].toList.toJson)

		} catch (Exception e) {
			notFound("No existe el Usuario con id " + id)
		}
	}

	/*Para RECHAZAR INVITACION    Confirmado por postman*/
	@Put('/rechazarInvitacion/:id')
	def Result rechazarInvitacion(@Body String body) {
	println(body)

	val idPerfil = Integer.valueOf(id)
			val usuarioPerfil = RepositorioUsuarios.instance.searchById(idPerfil)
			val eventoCerradoNombre = String.valueOf(body.getPropertyValue("unEventoCerrado"))

			/*	
			 * 	println(usuarioPerfil)
			 * 	println(eventoCerradoNombre)
			 * 	println(usuarioPerfil.id)
			 * 	println(usuarioPerfil.invitaciones)
			 * 	println( usuarioPerfil.invitaciones.findFirst [ invit |
			 * 		invit.nombreDelEvento.equals(eventoCerradoNombre)
			 * 	])
			 * 	println(usuarioPerfil.invitaciones.findFirst [ elemento |
			 * 		elemento.nombreDelEvento.equals(eventoCerradoNombre)
			 ].toJson)*/

		try {
		
			val unaInvitacion = usuarioPerfil.invitaciones.findFirst [ elemento |
				elemento.unEventoCerrado.nombre.equals(eventoCerradoNombre)
			]
			println(unaInvitacion)

			unaInvitacion.rechazar()
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}
	/*Para Aceptar INVITACION    */
	@Put('/aceptarInvitacion/:id')
	def Result aceptarInvitacion(@Body String body) {
	println("<<<<<< body aceptar invitacion >>>>\n" + body)

	val idPerfil = Integer.valueOf(id)
			val usuarioPerfil = RepositorioUsuarios.instance.searchById(idPerfil)
			val eventoCerradoNombre = String.valueOf(body.getPropertyValue("unEventoCerrado"))
			val cantidadDeAcompanantesConfirmados = Integer.valueOf(body.getPropertyValue("cantidadDeAcompanantesConfirmados"))
			/*	
			 * 	println(usuarioPerfil)
			 * 	println(eventoCerradoNombre)
			 * 	println(usuarioPerfil.id)
			 * 	println(usuarioPerfil.invitaciones)
			 * 	println( usuarioPerfil.invitaciones.findFirst [ invit |
			 * 		invit.nombreDelEvento.equals(eventoCerradoNombre)
			 * 	])
			 * 	println(usuarioPerfil.invitaciones.findFirst [ elemento |
			 * 		elemento.nombreDelEvento.equals(eventoCerradoNombre)
			 ].toJson)*/

		try {
		
			val unaInvitacion = usuarioPerfil.invitaciones.findFirst [ elemento |
				elemento.unEventoCerrado.nombre.equals(eventoCerradoNombre)
			]
			println(unaInvitacion)

			unaInvitacion.verificaAceptacion(usuarioPerfil, cantidadDeAcompanantesConfirmados)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}
	
	/* REACT */
	@Get('/usuario/:id')
	def Result usuarioLogueado() {
		val iId = Integer.valueOf(id)
		try {
			usuarioBuscado = RepositorioUsuarios.instance.searchById(iId)
			ok(usuarioBuscado.toJson)
		} catch (Exception e) {
			notFound("No existe el Usuario con id " + id + "")
		}
	}
}
