package repositorio

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import eventos.Locacion
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonValue
import com.eclipsesource.json.Json

@Accessors
class RepositorioLocaciones extends Repositorio<Locacion> {

	int i
	var String unNombre
	var double latitud
	var double longitud
	var Point unPunto

	def coordenadasIguales(Point unPunto) {
		elementos.filter(elemento|(elemento.punto.x == unPunto.x) && (elemento.punto.y == unPunto.y))
	}

	def actualizarLocacion(String texto) {
		var JsonArray datasets = Json.parse(texto).asArray()

		for (JsonValue locacion : datasets) { // (i = 0; i < datasets.size(); i++) 
			jsonLocacionAObjeto(locacion)
		}
	}

	def jsonLocacionAObjeto(JsonValue locacion) {       

		val locacionObject = locacion.asObject
		// var JsonObject dataset = datasets.get(i).asObject()
		latitud = locacionObject.get("x").asDouble()
		longitud = locacionObject.get("y").asDouble()
		unNombre = locacionObject.get("nombre").asString()
		unPunto = new Point(latitud, longitud)
		var Locacion locAuxiliar
		if ((coordenadasIguales(unPunto).size() == 0)) {
			locAuxiliar = new Locacion() => [
				nombre = unNombre
				punto = unPunto
			]
			create(locAuxiliar)
		} else {
			elementos.
				findFirst(elemento|(elemento.punto.x == unPunto.x) && (elemento.punto.y == unPunto.y)).nombre = unNombre
		}
	}

}