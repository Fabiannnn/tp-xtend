package eventos

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import excepciones.EventoException
import eventos.Usuario
import eventos.Locacion
import eventos.Servicio
import java.util.ArrayList

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

	def int sizeElementos() { // /para empezar
		elementos.size()
	}

	def void delete(T elemento) {
		elementos.remove(elemento)
	}

	def void update(T elemento) {}

	def T searchById(int _id) {
		elementos.findFirst[elemento|elemento.getId() == _id]
	}

	def List<T> search(String value) {
		println(elementos.filter[elementoBuscado(value)].toList()) // despues sacar
		return elementos.filter[elementoBuscado(value)].toList()

	}

	def noEstaEnRepositorio(T elemento) {
		if (elementos.contains(elemento)) {
			throw new EventoException("El objeto " + elemento.toString() + "ya está en el repositorio")
		}
	}

	def validarElemento(T elemento) {
		if (!elemento.validar()) {
			println("El objeto " + elemento.toString() + " no cumple validación obligatoria") // sacar despues
			throw new EventoException("El objeto " + elemento.toString() + " no cumple validación obligatoria")
		}

	}
}

@Accessors
class RepositorioUsuario extends Repositorio<Usuario> {
	
	
}
@Accessors
class RepositorioLocacion extends Repositorio<Locacion> {
}

@Accessors
class RepositorioServicio extends Repositorio<Servicio> {

}
