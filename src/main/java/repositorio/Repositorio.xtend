package repositorio

import eventos.Entidad
import excepciones.EventoException
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.updateService.UpdateService
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
abstract class Repositorio<T extends Entidad> {

	List<T> elementos = newArrayList
	int proximoId = 1;
	UpdateService updateService

	def void updateAll()

	def void create(T elemento) {
		elemento.esValido()
		noEstaEnRepositorio(elemento)
		asignarId(elemento)
		agregarElemento(elemento)
	}

	def void recibirListaActualizacionJson(List<T> _objeto)

	def void asignarId(T elemento) {
		elemento.agregarId(proximoId)
		proximoId += 1
	}

	def void agregarElemento(T elemento) {
		elementos.add(elemento)
	}

	def void delete(T elemento) {
		elementos.remove(elemento)
	}

	def void update(T _elemento) {
		_elemento.esValido()
		existeElId(_elemento)
		reemplazarObjectoExistente(_elemento)
	}

	def existeElId(T _elemento) {
		if (!(estaEnRepo(_elemento))) {
			throw new EventoException("No existe el elemento que se quiere actualizar")
		}
	}

	def boolean estaEnRepo(T _elemento) {
		elementos.exists[elementoRepo|elementoRepo.id == _elemento.id]
	}

	def T searchById(int _id) {
		elementos.findFirst[elemento|elemento.getId() == _id]
	}

	def void reemplazarObjectoExistente(T _elemento) {
		var int indice = elementos.indexOf(searchById(_elemento.id))
		elementos.set(indice, _elemento)
	}

	def List<T> search(String value) {
		return elementos.filter[filtroPorTexto(value)].toList()
	}

	def noEstaEnRepositorio(T elemento) {
		if (elementos.contains(elemento)) {
			throw new EventoException("El objeto " + elemento.toString() + "ya está en el repositorio")
		}
	}
}
