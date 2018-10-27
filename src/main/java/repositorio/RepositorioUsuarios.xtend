package repositorio

import eventos.Evento
import eventos.Locacion
import eventos.Usuario
import java.util.List
import java.util.Set
import org.uqbar.geodds.Point
import jsons.JsonUsuario
import org.eclipse.xtend.lib.annotations.Accessors
//import org.uqbar.commons.model.annotations.TransactionalAndObservable
import java.time.LocalDate
import com.fasterxml.jackson.annotation.JsonProperty

@Accessors
//@TransactionalAndObservable
class RepositorioUsuarios extends Repositorio<Usuario> {

	/* Singleton */
	static RepositorioUsuarios repoUsuarios

	def static RepositorioUsuarios getInstance() {
		if (repoUsuarios === null) {
			repoUsuarios = new RepositorioUsuarios
		}
		repoUsuarios
	}

	new() {
		val usuario1 = new Usuario => [
			nombreUsuario = "Felipe"
			email = "Felipe_Quino@maflada.mfq.mfq"
			nombreApellido = "Felipe no se "
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(40.0, 50.0)
		]

		val usuario2 = new Usuario => [
			nombreUsuario = "Mafalda"
			email = "mafaldita@mafalda.mfq.mfq"
			nombreApellido = "Mario Argentina"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			punto = new Point(45.0, 60.0)
		]

		val usuario3 = new Usuario => [
			nombreUsuario = "Libertad"
			email = "libertad_Quino@mafalda.mfq.mfq"
			nombreApellido = "Libertad Gomez"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			punto = new Point(34.0, 45.0)
			esAntisocial = false
		]

		val usuario4 = new Usuario => [
			nombreUsuario = "user4"
			email = "email4"
			nombreApellido = "Perez otro"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(40.0, 50.0)
		]

		usuario1.setUsuarioProfesional()
		usuario2.setUsuarioProfesional()
		usuario3.setUsuarioProfesional()
		usuario4.setUsuarioProfesional()
		this.create(usuario1)
		usuario1.agregarAmigoALaLista(usuario2)
		usuario1.agregarAmigoALaLista(usuario3)
		usuario1.agregarAmigoALaLista(usuario4)
		this.create(usuario2)
		usuario2.agregarAmigoALaLista(usuario3)
		this.create(usuario3)
		this.create(usuario4)

	}

	def int eventosPorLocacionTotal(Locacion _locacion) {
		elementos.fold(0)[acum, usuario|usuario.eventosPorLocacion(_locacion) + acum]
	}

	def usuariosIguales(String _nombreUsuario) {
		elementos.exists(elemento|elemento.nombreUsuario.contentEquals(_nombreUsuario))
	}

	override void recibirListaActualizacionJson(List<Usuario> usuarios) {
		usuarios.forEach[elemento|actualizarUsuarioConJson(elemento)]
	}

	def actualizarUsuarioConJson(Usuario _usuario) {

		if (usuariosIguales(_usuario.nombreUsuario)) {
			println(_usuario)
			_usuario.id = elementos.findFirst(e|(e.nombreUsuario.equals(_usuario.nombreUsuario))).id
			update(_usuario)

		} else {
			this.create(_usuario)
		}
	}

	override updateAll() {
		val JsonUsuario jsonUsuario = new JsonUsuario
		jsonUsuario.deserializarJson(updateService.getUserUpdates(), this)

	}

	
	def listadoDeMisAmigos(Usuario _usuario) {
		elementos.filter[unUsuario|unUsuario.esMiAmigo(_usuario)].toSet
	}

	def listadoUsuariosCercanosEvento(Evento unEvento) {
		var unaLista = elementos.filter[usuario|unEvento.usuariosCercanosAlEvento(usuario)]
		return unaLista
	}

	def listadoUsuariosFansDeArtistasDeUnEvento(Set<String> artistas) {
		// Tiene que traer una lista con los usuarios que son fans de algun artista del evento.
		elementos.filter[usuario|usuario.soyFanDeAlgunoDeLosArtistas(artistas)]

	}}