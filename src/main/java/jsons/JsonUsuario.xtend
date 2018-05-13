package jsons

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonValue
import com.eclipsesource.json.Json
import java.util.List
import repositorio.Repositorio
import eventos.Usuario
import java.time.LocalDate
import com.eclipsesource.json.JsonObject

@Accessors
class JsonUsuario implements JsonsInterface {
	var List<Usuario> usuarios = newArrayList

	override deserializarJson(String texto, Repositorio _repositorio) {
		var JsonArray datasets = Json.parse(texto).asArray()

		for (JsonValue usuario : datasets) { // (i = 0; i < datasets.size(); i++) 
			usuarios.add(jsonUsuarioAObjeto(usuario))
		}
		_repositorio.recibirListaActualizacionJson(usuarios)
	}

	def jsonUsuarioAObjeto(JsonValue _UsuarioJson) {
		var Usuario usuarioAuxiliar
		var JsonObject dataset = _UsuarioJson.asObject()
		val String unNombreUsuario = dataset.get("nombreUsuario").asString()
		val String unNombreApellido = dataset.get("nombreApellido").asString()
		val String unEmail = dataset.get("email").asString()
		// val LocalDate unaFechaNacimiento = usuarioObject.get("unaFechaNacimiento").asString()
		val JsonObject direccionUsuario = dataset.get("direccion").asObject()
		val JsonObject coordenadasUsuario = direccionUsuario.get("coordenadas").asObject()
		val double latitud = coordenadasUsuario.get("x").asDouble()
		val double longitud = coordenadasUsuario.get("y").asDouble()
		val Point unaCoordenada = new Point(latitud, longitud)

		usuarioAuxiliar = new Usuario() => [
			nombreUsuario = unNombreUsuario
			nombreApellido = unNombreApellido
			email = unEmail
			// fechaNacimiento = unaFechaNacimiento
			coordenadas = unaCoordenada

		]
		return usuarioAuxiliar
	}

}
