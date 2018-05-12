package repositorio

import eventos.Entidad
import excepciones.EventoException
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
abstract class Repositorio<T extends Entidad> {

	List<T> elementos = newArrayList
	int nextId = 1;

	def void create(T elemento) {
		elemento.esValido()
		noEstaEnRepositorio(elemento) // TODO hay que refactorizarlo ver mail julian
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
		if (_elemento.esValido() && existeElId(_elemento)) {
			reemplazarObjectoExistente(_elemento)
		}
	}

	def boolean existeElId(T _elemento) {
		if (elementos.exists[elementoRepo|elementoRepo.id == _elemento.id]) {
			true
		} else {
			throw new EventoException("No existe el elemento que se quiere actualizar")
		}
	}

	def T searchById(int _id) {
		elementos.findFirst[elemento|elemento.getId() == _id]
	}

	def void reemplazarObjectoExistente(T _elemento) {
		var int indice = elementos.indexOf(searchById(_elemento.id))
		elementos.set(indice, _elemento)
	}

	def List<T> search(String value) {
		return elementos.filter[elementoBuscado(value)].toList()
	}

	def noEstaEnRepositorio(T elemento) {
		if (elementos.contains(elemento)) {
			throw new EventoException("El objeto " + elemento.toString() + "ya está en el repositorio")
		}
	}
}
