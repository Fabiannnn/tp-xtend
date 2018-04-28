package repositorio

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import excepciones.EventoException
import eventos.Usuario
import eventos.Locacion
import eventos.Servicio

@Accessors

abstract class Repositorio<T extends Entidad> {

	List<T> elementos = newArrayList
	int nextId = 1;

	def void create(T elemento) {
		validarElemento(elemento)
		noEstaEnRepositorio(elemento)
	// falta que haga todo lo que sigue add setear id incrementar id
	}

	def void delete(T elemento) {
		delete(elemento)
	}

	def void update(T elemento) {}

	def T searchById(int id) {}

	def List<T> search(String value) {}

	def noEstaEnRepositorio(T elemento) {}

	def validarElemento(T elemento) {
		if (!elemento.validar) {
			throw new EventoException("El objeto " + elemento.toString() + " no cumple validación obligatoria")
		}

	}
}

class RepositorioUsuarios extends Repositorio<Usuario> {
}

class RepositorioLocacion extends Repositorio<Locacion> {
	override create(Locacion locacion) {
		locacion.validar()
		noEstaEnRepositorio(locacion)
		elementos.add(locacion)
	}
}

class RepositorioServicio extends Repositorio<Servicio> {
	override create(Servicio servicio) {
		servicio.validar()
		noEstaEnRepositorio(servicio)
		elementos.add(servicio)
	}
}
