package eventos

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import excepciones.EventoException
import eventos.Usuario
import eventos.Locacion
import eventos.Servicio
import java.util.ArrayList
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonObject
import org.uqbar.geodds.Point
import java.time.LocalDate

@Accessors
abstract class Repositorio<T extends Entidad> {

	List<T> elementos = newArrayList
	int nextId = 1;

	def void create(T elemento) {
		validarElemento(elemento)
		noEstaEnRepositorio(elemento)
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

	def void update(T _elemento) {
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

		for (i = 0; i < datasets.size(); i++) {
			var JsonObject dataset = datasets.get(i).asObject()
			latitud = dataset.get("x").asDouble()
			longitud = dataset.get("y").asDouble()
			unNombre = dataset.get("nombre").asString()
			unPunto = new Point(latitud, longitud)

			if ((coordenadasIguales(unPunto).size() == 0)) {
				create(new Locacion() => [
					nombre = unNombre
					punto = unPunto
				])
			} else {
				elementos.
					findFirst(elemento|(elemento.punto.x == unPunto.x) && (elemento.punto.y == unPunto.y)).nombre = unNombre
			}
		}
	}

}

@Accessors
class RepositorioServicio extends Repositorio<Servicio> {

	int iter
	int iter2
	var String unaDescripcion
	var String unTipoTarifa
	var double unValor
	var double unPorcentajeMinimo
	var double unMinimo
	var Point unPunto
	var double unaTarifaTraslado
	var double x
	var double y

//	def coordenadasIguales(Point unPunto) {
//		elementos.filter(elemento|(elemento.punto.x == unPunto.x) && (elemento.punto.y == unPunto.y))
//	}
	def actualizarServicios(String texto) {
		var JsonArray setServicios = Json.parse(texto).asArray()

		for (iter = 0; iter < setServicios.size(); iter++) {

			var JsonObject dataset = setServicios.get(iter).asObject()

			unaDescripcion = dataset.get("descripcion").asString()
			
	println(unaDescripcion)
		var JsonArray tarifasServicios = dataset.get("tarifaServicio").asArray()
		var JsonObject tarifaTraslado = dataset.get("tarifaTraslado").asObject()
		var JsonObject tarifaServicio = tarifasServicios.asObject()
			unTipoTarifa = tarifaServicio.get("tipo").asString()
println(unTipoTarifa)
			unValor = tarifaServicio.get("valor").asDouble()
			if (unTipoTarifa == "TPP") {
				unPorcentajeMinimo = tarifaServicio.get("porcentajeParaMinimo").asDouble()
			}
			if (unTipoTarifa == "TPH") {
				unMinimo = tarifaServicio.get("minimo").asDouble()

			}
		//	var JsonObject tarifaTrasladoObj = tarifaTraslado.asObject()
			unaTarifaTraslado = tarifaTraslado.get("tarifaTraslado").asDouble()
			x = dataset.get("x").asDouble()
			y = dataset.get("y").asDouble()
			unPunto = new Point(x, y)
			
			println(unPunto)
//			println(tarifaServicio)
			println(unaTarifaTraslado)

		}
	}
}
