package repositorio

import org.eclipse.xtend.lib.annotations.Accessors
import eventos.Servicio
import org.uqbar.geodds.Point
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.Json

@Accessors
class RepositorioServicios extends Repositorio<Servicio> {

	int iter
	int iter2
	var String unaDescripcion
	var String unTipoTarifa
	var double unValor = 0
	var double unCostoFijo = 0
	var double unPorcentajeMinimo = 0
	var double unCostoPorHora = 0
	var double unCostoPorPersona = 0
	var double unMinimo = 0
	var Point unPunto
	var double unaTarifaTraslado = 0
	var double x = 0.0
	var double y = 0.0
	String nombre

	def descripcionesIguales(String unaDescripcion) {
		elementos.exists(elemento|elemento.descripcion.contentEquals(unaDescripcion))
	}

	def actualizarServicios(String texto) {
		var JsonArray setServicios = Json.parse(texto).asArray()
		var Servicio servAux
		for (iter = 0; iter < setServicios.size(); iter++) {
			var JsonObject dataset = setServicios.get(iter).asObject()
			unaDescripcion = dataset.get("descripcion").asString()
			var JsonObject tarifaServicio = dataset.get("tarifaServicio").asObject()
			unTipoTarifa = tarifaServicio.get("tipo").asString()
			unValor = tarifaServicio.get("valor").asDouble()
			unaTarifaTraslado = dataset.get("tarifaTraslado").asDouble()
			var JsonObject unaUbicacion = dataset.get("ubicacion").asObject()
			x = unaUbicacion.get("x").asDouble()
			y = unaUbicacion.get("y").asDouble()
			unPunto = new Point(x, y)	
			
			servAux = new Servicio() => [
				descripcion = unaDescripcion
				ubicacion = unPunto
			]		

			if (unTipoTarifa.toString.contains("TPP") ) {
				servAux.porcentajeCostoMinimo = tarifaServicio.get("porcentajeParaMinimo").asDouble()
				servAux.costoPorPersona = unValor
				servAux.setTarifaPorPersona()
			}
			if (unTipoTarifa.toString.contains("TPH")) {
				servAux.costoPorHora = unValor
				servAux.costoMinimo = tarifaServicio.get("minimo").asDouble()			
					servAux.setTarifaPorHora()
			}
			if (unTipoTarifa.toString().equals("TF")) {
				servAux.costoFijo = unValor
				servAux.setTarifaFija()
			}

			if (descripcionesIguales(unaDescripcion)) {
								var int idAux
				idAux = elementos.findFirst(elemento|elemento.descripcion.contentEquals(unaDescripcion)).id
				servAux.id = idAux
				update(servAux)

			} else {
				this.create(servAux)
				
			}

		}

	}
}