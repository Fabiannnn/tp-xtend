package controller

import eventos.EventoCerrado
import eventos.Usuario
import jsons.JsonUsuario
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils
import repositorio.RepositorioLocaciones
import repositorio.RepositorioUsuarios
import eventos.EventoAbierto

@Controller
class OrganizarEventosController {
	extension JSONUtils = new JSONUtils

	// JsonUsuario jsonUsuario
	// Usuario usuarioBuscado
// toma las locaciones para los modales de organizar eventos
	@Get('/locaciones')
	def Result Locaciones() {
		try {
			val locaciones = RepositorioLocaciones.instance.elementos
			ok(locaciones.toJson)
		} catch (Exception e) {
			notFound("error al pedir locaciones ")
		}
	}

	/*Para OrganizarEventoCerrado  */
	@Post('/organizarEventoCerrado/:id')
	def Result organizarEventoCerrado(@Body String body) {
		println("<<<<<< body organizarEventoCerrado>>>>\n" + body)

		val idPerfil = Integer.valueOf(id)
		val usuarioPerfil = RepositorioUsuarios.instance.searchById(idPerfil)

		val nuevoEvento = body.fromJson(EventoCerrado)

		nuevoEvento.organizador = usuarioPerfil
		nuevoEvento.locacion = RepositorioLocaciones.instance.elementos.findFirst( elemento |
			elemento.nombre == (body.getPropertyValue("locacionNombre"))
		)
		nuevoEvento.asignarFechaDeInicio(body.getPropertyValue("fechaDeInicio"))
		nuevoEvento.asignarFechaFinalizacion(body.getPropertyValue("fechaFinalizacion"))
		nuevoEvento.asignarFechaLimiteConfirmacion(body.getPropertyValue("fechaLimiteConfirmacion"))
		println(nuevoEvento.nombre)
		println(nuevoEvento.organizador)
		try {
			usuarioPerfil.organizarEventoCerrado(nuevoEvento)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	/*Para OrganizarEventoAbierto  */
	@Post('/organizarEventoAbierto/:id')
	def Result organizarEventoAbierto(@Body String body) {
		println("<<<<<< body organizarEventoAbierto>>>>\n" + body)

		val idPerfil = Integer.valueOf(id)
		val usuarioPerfil = RepositorioUsuarios.instance.searchById(idPerfil)
		println(usuarioPerfil.nombreApellido)
		val nuevoEvento = body.fromJson(EventoAbierto)
		println(nuevoEvento.nombre)
		// nuevoEvento.fechaDeInicio=body.getPropertyValue("fechaDeInicio")
		// nuevoEvento.fechaDeInicio=body.getPropertyValue("fechaDeInicio")
		// nuevoEvento.fechafinalizacion=body.getPropertyValue("fechaDeInicio")
		// nuevoEvento.fechaLimiteConfirmacion=body.getPropertyValue("fechaDeInicio")
		// nuevoEvento.locacion=body.getPropertyValue("fechaDeInicio")	
//		nuevoEvento.organizador = usuarioPerfil
		nuevoEvento.asignarFechaDeInicio(body.getPropertyValue("fechaDeInicio"))
		nuevoEvento.asignarFechaFinalizacion(body.getPropertyValue("fechaFinalizacion"))
		nuevoEvento.asignarFechaLimiteConfirmacion(body.getPropertyValue("fechaLimiteConfirmacion"))

		println(nuevoEvento.fechaDeInicio.toString())
		println(nuevoEvento.fechaFinalizacion.toString())
		println(nuevoEvento.fechaLimiteConfirmacion.toString())

		nuevoEvento.locacion = RepositorioLocaciones.instance.elementos.findFirst( elemento |
			elemento.nombre == (body.getPropertyValue("locacionNombre"))
		)
		println(nuevoEvento.organizador)
		// println(usuarioPerfil.id)
		/* 	println( usuarioPerfil.invitaciones.findFirst [ invit |
		 * 		invit.nombreDelEvento.equals(eventoCerradoNombre)
		 * 	])
		 * 	println(usuarioPerfil.invitaciones.findFirst [ elemento |
		 * 		elemento.nombreDelEvento.equals(eventoCerradoNombre)
		 ].toJson)*/
		try {

			println("dentro del try")

			usuarioPerfil.organizarEventoAbierto(nuevoEvento)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}
}
