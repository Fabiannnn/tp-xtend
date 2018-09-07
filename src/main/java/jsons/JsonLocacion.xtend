package jsons

import com.eclipsesource.json.JsonObject
import eventos.Locacion
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class JsonLocacion extends JsonsInterface<Locacion> {
	var List<Locacion> locaciones = newArrayList

	override jsonAObjetoFinal(JsonObject locacionObject) {

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
