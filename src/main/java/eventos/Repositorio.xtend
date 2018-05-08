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
			println(elementos.filter(elemento | elemento.punto == unPunto).size())
			return elementos.filter(elemento | elemento.punto == unPunto).size()
		
	}

	def actualizarLocacion(String texto) {
		var JsonArray datasets = Json.parse(texto).asArray()
		println(datasets)
		println(datasets.size())

		for (i = 0; i < datasets.size(); i++) {
			var JsonObject dataset = datasets.get(i).asObject()
			latitud = dataset.get("x").asDouble()
			longitud = dataset.get("y").asDouble()
			unNombre = dataset.get("nombre").asString()
			unPunto = new Point(latitud, longitud)
			
//			elementos.add(new Locacion() => [
//				nombre = unNombre
//				punto = unPunto
//
//			])
//			println(dataset)
//			println(unNombre)
//			println(latitud)
//			println(longitud)
//			println(unPunto)

			if (coordenadasIguales(unPunto)==0) {
				println("creo la locacion")
				create(new Locacion() => [
					nombre = unNombre
					punto = unPunto
				])
			} else {	(elementos.findFirst(elemento | elemento.punto == unPunto)).nombre = unNombre}
		}
	}

}

@Accessors
class RepositorioServicio extends Repositorio<Servicio> {
}
