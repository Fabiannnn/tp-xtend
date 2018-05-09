package repositorio

import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.JsonValue
import eventos.Entidad
import eventos.Locacion
import eventos.Servicio
import eventos.Usuario
import excepciones.EventoException
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.geodds.Point

@Accessors

abstract class Repositorio<T extends Entidad> {

	List<T> elementos = newArrayList
	int nextId = 1;

	def void create(T elemento) {
		validarElemento(elemento)
		noEstaEnRepositorio(elemento)//TODO hay que refactorizarlo ver mail julian
		asignarId(elemento)
		agregarElemento(elemento)

	}

	def void asignarId(T elemento) {
		elemento.agregarId(nextId)
		nextId += 1
	}

	def void agregarElemento(T elemento) {
		elementos.add(elemento)
	}

	def void delete(T elemento) {
		elementos.remove(elemento)
	}

	def void update(T _elemento) {//TODO delegar en objeto la act
		this.validarElemento(_elemento) // si no es valido la excepcion la llama la validacion
		if (this.searchById(_elemento.getId()) === null) {
			throw new EventoException("No existe el elemento que se quiere actualizar")
		} else {
			delete(this.searchById(_elemento.getId()))
			elementos.add(_elemento)
		}
	}

	def T searchById(int _id) {
		elementos.findFirst[elemento|elemento.getId() == _id]
	}

	def List<T> search(String value) {
		return elementos.filter[elementoBuscado(value)].toList()
	}

	def noEstaEnRepositorio(T elemento) {
		if (elementos.contains(elemento)) {
			throw new EventoException("El objeto " + elemento.toString() + "ya está en el repositorio")
		}
	}

	def validarElemento(T elemento) {
		if (!elemento.validar()) {
			throw new EventoException("El objeto " + elemento.toString() + " no cumple validación obligatoria")
		}
	}
}

@Accessors
class RepositorioUsuario extends Repositorio<Usuario> {
}

@Accessors
class RepositorioLocacion extends Repositorio<Locacion> {

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

@Accessors
class RepositorioServicio extends Repositorio<Servicio> {

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

