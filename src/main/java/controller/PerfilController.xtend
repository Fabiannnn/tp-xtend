package controller

import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import repositorio.RepositorioUsuarios
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Put
import eventos.Usuario
import jsons.JsonUsuario
import org.uqbar.xtrest.api.annotation.Post
import java.time.LocalDate
import org.uqbar.geodds.Point

@Controller
class PerfilController {

	Usuario usuario1

	extension JSONUtils = new JSONUtils
	JsonUsuario jsonUsuario

// (usuarioIng.id + usuarioIng.nombreUsuario + usuarioIng.nombreApellido + usuarioIng.tipoDeUsuario.nom).toJson	}
	@Get('/usuarioPerfil/:id')
	def Result perfil() {
		val iId = Integer.valueOf(id)

		try {
			ok(RepositorioUsuarios.instance.searchById(iId).toJson)
		} catch (Exception e) {
			notFound("No existe la Usuario con id " + id + "")
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

/* @Put('/amigoEliminar')
 * def Result amigoEliminar(@Body String body) {
 * 	try {
 * 		//if (true) throw new RuntimeException("ACHALAY")
 * 		val actualizado = body.fromJson(Tarea)

 * 		actualizado.asignarFecha(body.getPropertyValue("fecha"))
 * 		
 * 		val asignadoA = body.getPropertyValue("asignadoA")
 * 		val asignatario = RepoUsuarios.instance.getAsignatario(asignadoA)
 * 		actualizado.asignarA(asignatario)

 * 		if (Integer.parseInt(id) != actualizado.id) {
 * 			return badRequest('{ "error" : "Id en URL distinto del cuerpo" }')
 * 		}

 * 		RepoTareas.instance.update(actualizado)
 * 		ok('{ "status" : "OK" }');
 * 	} catch (Exception e) {
 * 		badRequest(e.message)
 * 	}
 }*/
}
