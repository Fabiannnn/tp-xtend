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
class JsonUsuario implements JsonsInterface {

	var List<Usuario> usuarios = newArrayList
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d/MM/yyyy")

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
		val String unaFechaNacimiento = dataset.get("fechaNacimiento").asString()
		val LocalDate unaFN = LocalDate.parse(unaFechaNacimiento, formatter)
		val JsonObject direccionUsuario = dataset.get("direccion").asObject()
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
