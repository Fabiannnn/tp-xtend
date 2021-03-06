package jsons

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import com.eclipsesource.json.JsonObject
import java.util.List
import eventos.Usuario
import java.time.LocalDate
import java.time.format.DateTimeFormatter

@Accessors
class JsonUsuario extends JsonsInterface<Usuario> {

	var List<Usuario> usuarios = newArrayList
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d/MM/yyyy")

	override jsonAObjetoFinal(JsonObject jsonUsuario) {
		var Usuario usuarioAuxiliar
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
			punto = unaCoordenada
			fechaNacimiento = LocalDate.now()
		]
		return usuarioAuxiliar
	}

}
