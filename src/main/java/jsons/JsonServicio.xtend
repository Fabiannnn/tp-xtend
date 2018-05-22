package jsons

import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.JsonValue
import eventos.Servicio
import java.util.List
import org.uqbar.geodds.Point
import repositorio.Repositorio

class JsonServicio extends JsonsInterface {

	var List<Servicio> servicios = newArrayList


//	override deserializarJson(String texto, Repositorio _repositorio) {
//		var JsonArray jsonServicios = Json.parse(texto).asArray()
//		for (JsonValue servicio : jsonServicios) { // reemplaza a la iteracion... (i = 0; i < datasets.size(); i++) 
//			servicios.add(jsonServicioAObjeto(servicio))
//		}
//		_repositorio.recibirListaActualizacionJson(servicios)
//	}

	override jsonAObjetoFinal(JsonObject jsonServicio) {
		var Servicio servAuxiliar
//		var JsonObject jsonServicio = _ServicioJson.asObject()
		val String unaDescripcion = jsonServicio.get("descripcion").asString()
		val JsonObject tarifaServicio = jsonServicio.get("tarifaServicio").asObject()
		val String unTipoTarifa = tarifaServicio.get("tipo").asString()
		val double unValor = tarifaServicio.get("valor").asDouble()
		val double unaTarifaTraslado = jsonServicio.get("tarifaTraslado").asDouble()
		val JsonObject unaUbicacion = jsonServicio.get("ubicacion").asObject()
		val double latitud = unaUbicacion.get("x").asDouble()
		val double longitud = unaUbicacion.get("y").asDouble()
		val Point unPunto = new Point(latitud, longitud)

		servAuxiliar = new Servicio() => [
			descripcion = unaDescripcion
			ubicacion = unPunto
			costoPorKm = unaTarifaTraslado
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
