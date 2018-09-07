package jsons

import com.eclipsesource.json.JsonObject
import org.uqbar.geodds.Point
import servicios.Servicio

class JsonServicio extends JsonsInterface<Servicio> {

	override jsonAObjetoFinal(JsonObject jsonServicio) {
		var Servicio servAuxiliar
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
