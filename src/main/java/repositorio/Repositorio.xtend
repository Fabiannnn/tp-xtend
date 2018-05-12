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



