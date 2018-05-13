package jsons

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import eventos.Locacion
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonValue
import com.eclipsesource.json.Json
import java.util.List
import repositorio.RepositorioLocaciones
import repositorio.Repositorio

@Accessors
class JsonLocacion implements JsonsInterface {
	var List<Locacion> locaciones = newArrayList
	//var RepositorioLocaciones repo

	override deserializarJson(String texto, Repositorio _repositorio) {
		var JsonArray datasets = Json.parse(texto).asArray()

		for (JsonValue locacion : datasets) { // (i = 0; i < datasets.size(); i++) 
			locaciones.add(jsonLocacionAObjeto(locacion))
		}
		_repositorio.recibirListaActualizacionJson(locaciones)
	}

	def jsonLocacionAObjeto(JsonValue _LocacionJson) {

		var locacionObject = _LocacionJson.asObject
		var double latitud = locacionObject.get("x").asDouble()
		var double longitud = locacionObject.get("y").asDouble()
		val String unNombre = locacionObject.get("nombre").asString()
		val Point unPunto = new Point(latitud, longitud)
		var Locacion locAuxiliar
		locAuxiliar = new Locacion() => [
			nombre = unNombre
			punto = unPunto
		]
		return locAuxiliar
	}
}
