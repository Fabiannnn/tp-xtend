package jsons

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import eventos.Locacion
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonValue
import com.eclipsesource.json.Json
import java.util.List
import repositorio.RepositorioServicios
import repositorio.Repositorio
import eventos.Servicio
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.Json

class JsonServicio implements JsonsInterface {

	var List<Servicio> servicios = newArrayList

//	override deserializarJson(String texto, Repositorio _repositorio) {
//		var JsonArray setServicios = Json.parse(texto).asArray()
//	}
	override deserializarJson(String texto, Repositorio _repositorio) {
		var JsonArray datasets = Json.parse(texto).asArray()
		for (JsonValue servicio : datasets) { // (i = 0; i < datasets.size(); i++) 
			servicios.add(jsonServicioAObjeto(servicio))
		}
		_repositorio.recibirListaActualizacionJson(servicios)
	}

	def jsonServicioAObjeto(JsonValue _ServicioJson) {
		//int iter
		//int iter2
		//var String unaDescripcion
//		var String unTipoTarifa
//		var double unValor = 0
//		var double unCostoFijo = 0
//		var double unPorcentajeMinimo = 0
//		var double unCostoPorHora = 0
//		var double unCostoPorPersona = 0
//		var double unMinimo = 0
		//var Point unPunto
		//var double unaTarifaTraslado = 0
//		var double x = 0.0
//		var double y = 0.0
//		var String  nombre
		var Servicio servAuxiliar

		//for (iter = 0; iter < setServicios.size(); iter++) { 
			var JsonObject dataset = _ServicioJson.asObject()
			val String unaDescripcion = dataset.get("descripcion").asString()
			val JsonObject tarifaServicio = dataset.get("tarifaServicio").asObject()
			val String unTipoTarifa = tarifaServicio.get("tipo").asString()
			val double unValor = tarifaServicio.get("valor").asDouble()
			val double unaTarifaTraslado = dataset.get("tarifaTraslado").asDouble()
			val JsonObject unaUbicacion = dataset.get("ubicacion").asObject()
			val double latitud = unaUbicacion.get("x").asDouble()
			val double longitud = unaUbicacion.get("y").asDouble()
			 val Point unPunto = new Point(latitud, longitud)
			 
			servAuxiliar = new Servicio() => [
				descripcion = unaDescripcion
				 ubicacion = unPunto
			]

			if (unTipoTarifa.toString.contains("TPP")) {
				servAuxiliar.porcentajeCostoMinimo = tarifaServicio.get("porcentajeParaMinimo").asDouble()
				servAuxiliar.costoPorPersona = unValor
				servAuxiliar.setTarifaPorPersona()
			}
			if (unTipoTarifa.toString.contains("TPH")) {
				servAuxiliar.costoPorHora = unValor
				servAuxiliar.costoMinimo = tarifaServicio.get("minimo").asDouble()
				servAuxiliar.setTarifaPorHora()
			}
			if (unTipoTarifa.toString().equals("TF")) {
				servAuxiliar.costoFijo = unValor
				servAuxiliar.setTarifaFija()
			}

			return servAuxiliar
		}
}

