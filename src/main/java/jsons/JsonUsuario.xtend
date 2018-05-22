package jsons

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonValue
import com.eclipsesource.json.Json
import java.util.List
import repositorio.Repositorio
import eventos.Usuario
import java.time.LocalDate
import java.time.format.DateTimeFormatter

@Accessors
class JsonUsuario extends JsonsInterface {

	var List<Usuario> usuarios = newArrayList
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d/MM/yyyy")

//	override deserializarJson(String texto, Repositorio _repositorio) {
//		var JsonArray jsonUsuarios = Json.parse(texto).asArray()
//		for (JsonValue usuario : jsonUsuarios) {
//			usuarios.add(jsonUsuarioAObjeto(usuario))
//		}
//		_repositorio.recibirListaActualizacionJson(usuarios)
//	}

	override jsonAObjetoFinal(JsonObject jsonUsuario) {
		var Usuario usuarioAuxiliar
//		var JsonObject jsonUsuario = _UsuarioJson.asObject()
		val String unNombreUsuario = jsonUsuario.get("nombreUsuario").asString()
		val String unNombreApellido = jsonUsuario.get("nombreApellido").asString()
		val String unEmail = jsonUsuario.get("email").asString()
		val String unaFechaNacimiento = jsonUsuario.get("fechaNacimiento").asString()
		val LocalDate unaFN = LocalDate.parse(unaFechaNacimiento, formatter)
		val JsonObject direccionUsuario = jsonUsuario.get("direccion").asObject()
		val JsonObject ubicacion = direccionUsuario.get("coordenadas").asObject()
		val double latitud = ubicacion.get("x").asDouble()
		val double longitud = ubicacion.get("y").asDouble()
		val Point unaCoordenada = new Point(latitud, longitud)
		usuarioAuxiliar = new Usuario() => [
			nombreUsuario = unNombreUsuario
			nombreApellido = unNombreApellido
			email = unEmail
			fechaNacimiento = unaFN
			coordenadas = unaCoordenada
			fechaNacimiento = LocalDate.now()
		]
		return usuarioAuxiliar
	}

}
