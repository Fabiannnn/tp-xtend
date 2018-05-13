package repositorio

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import eventos.Locacion
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonValue
import com.eclipsesource.json.Json
import java.util.List

@Accessors
class RepositorioLocaciones extends Repositorio<Locacion> {

//	int i
//	var String unNombre
//	var double latitud
//	var double longitud
//	var Point unPunto

//	def coordenadasIguales(Point unPunto) {
//		elementos.filter(elemento|(elemento.punto.x == unPunto.x) && (elemento.punto.y == unPunto.y))
//	}

//	def actualizarLocacion(String texto) {
//		var JsonArray datasets = Json.parse(texto).asArray()

//		for (JsonValue asdasd : datasets) { // (i = 0; i < datasets.size(); i++) 
			//jsonLocacionAObjeto(asdasd)
//		}
//	}

//	def jsonLocacionAObjeto(JsonValue locacion) {       
//
//		val locacionObject = locacion.asObject
//		// var JsonObject dataset = datasets.get(i).asObject()
//		latitud = locacionObject.get("x").asDouble()
//		longitud = locacionObject.get("y").asDouble()
//		unNombre = locacionObject.get("nombre").asString()
//		unPunto = new Point(latitud, longitud)
//		var Locacion locAuxiliar
//		
//			locAuxiliar = new Locacion() => [
//				nombre = unNombre
//				punto = unPunto
//			]
//			create(locAuxiliar)
//		} else {
//			elementos.
//				findFirst(elemento|(elemento.punto.x == unPunto.x) && (elemento.punto.y == unPunto.y)).nombre = unNombre
//		}
//	}
	override void recibirListaActualizacionJson(List<Locacion> locaciones) {
		locaciones.forEach[elemento | actualizarElementoJson(elemento)]
	}
	def actualizarElementoJson(Locacion _locacion){
		if ((coordenadasIguales(_locacion.punto ).size() == 0)) {
			create(_locacion)
	}else{
			elementos.findFirst(elemento|(elemento.punto.x == _locacion.punto.x) && (elemento.punto.y == _locacion.punto.y)).nombre = _locacion.nombre
	}
	
	}
	def coordenadasIguales(Point unPunto) {
		elementos.filter(elemento|(elemento.punto.x == unPunto.x) && (elemento.punto.y == unPunto.y))
	}
}