package controller

import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import repositorio.RepositorioUsuarios
import repositorio.RepositorioLocaciones
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Put
import eventos.Usuario
import jsons.JsonUsuario
import org.uqbar.xtrest.api.annotation.Post
import java.time.LocalDate
import org.uqbar.geodds.Point
import eventos.Invitacion
import java.util.List
import java.util.Set
import java.time.LocalDateTime
import eventos.EventoCerrado

@Controller
class OrganizarEventosController {
	extension JSONUtils = new JSONUtils
	JsonUsuario jsonUsuario
	Usuario usuarioBuscado

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

		// nuevoEvento.fechaDeInicio=body.getPropertyValue("fechaDeInicio")
		// nuevoEvento.fechaDeInicio=body.getPropertyValue("fechaDeInicio")
		// nuevoEvento.fechafinalizacion=body.getPropertyValue("fechaDeInicio")
		// nuevoEvento.fechaLimiteConfirmacion=body.getPropertyValue("fechaDeInicio")
		// nuevoEvento.locacion=body.getPropertyValue("fechaDeInicio")	
		nuevoEvento.organizador = usuarioPerfil
nuevoEvento.locacion= RepositorioLocaciones.instance.elementos.findFirst(elemento | elemento.nombre == (body.getPropertyValue("locacionNombre")))
		nuevoEvento.asignarFechaDeInicio(body.getPropertyValue("fechaDeInicio"))
		nuevoEvento.asignarFechaFinalizacion(body.getPropertyValue("fechaFinalizacion"))
		nuevoEvento.asignarFechaLimiteConfirmacion(body.getPropertyValue("fechaLimiteConfirmacion"))
		println(nuevoEvento.nombre)
			println(nuevoEvento.organizador)
		// println(usuarioPerfil.id)
		/* 	println( usuarioPerfil.invitaciones.findFirst [ invit |
		 * 		invit.nombreDelEvento.equals(eventoCerradoNombre)
		 * 	])
		 * 	println(usuarioPerfil.invitaciones.findFirst [ elemento |
		 * 		elemento.nombreDelEvento.equals(eventoCerradoNombre)
		 ].toJson)*/
		try {

			// println(unaInvitacion)
//			usuarioPerfil.organizarEventoCerrado(nuevoEvento)
		nuevoEvento.organizador.organizarEventoCerrado(nuevoEvento)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

}
