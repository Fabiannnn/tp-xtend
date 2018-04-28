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
		elemento.validar()
//		validarElemento(elemento)
		noEstaEnRepositorio(elemento)
	//	agregar(elemento) como se le dice a que repositorio se agrega
	// falta que haga todo lo que sigue add setear id incrementar id
	}

	def void delete(T elemento) {
		delete(elemento)
	}

	def void update(T elemento) {}

	def T searchById(int id) {
//		find(id| claveId==id)
	}

	def List<T> search(String value) {}

	def noEstaEnRepositorio(T elemento) {
		true  //hay que cambiarlo
	}

	def validarElemento(T elemento) {
		if (!elemento.validar) {
			throw new EventoException("El objeto " + elemento.toString() + " no cumple validación obligatoria")
		}

	}
}

//
//class RepositorioUsuario extends Repositorio<Usuario> {
//}
class RepositorioLocacion extends Repositorio<Locacion> {
//	override create(Locacion locacion) {
//		locacion.validar()
//		noEstaEnRepositorio(locacion)
//		elementos.add(locacion)
//	}
	def void agregar(Locacion locacion) {
		elementos.add(locacion) //como se agrega el ID!!!!!!!
	}
}
@Accessors
class RepositorioServicio extends Repositorio<Servicio> {
	override create(Servicio servicio) {
		servicio.validar()
		noEstaEnRepositorio(servicio)
		elementos.add(servicio)
	}
}
