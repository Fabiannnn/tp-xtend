package repositorio

import eventos.Evento
import eventos.EventoAbierto
import eventos.EventoCerrado
//import eventos.Invitacion
import eventos.Locacion
import eventos.Usuario
import java.time.LocalDate
//import java.time.LocalDateTime
import java.time.Period
import java.util.List
import java.util.Set
import jsons.JsonUsuario
import org.eclipse.xtend.lib.annotations.Accessors

//import org.uqbar.geodds.Point
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

//	RepositorioLocaciones repoLocaciones
	new() {
//		
//		val salon_SM = new Locacion => [
//			nombre = "San Martin"
//			punto = new Point(35.0, 45.0)
//			superficie = 16
//		]
//		val salon_2 = new Locacion => [
//			nombre = "San Martin 2"
//			punto = new Point(35.5, 65.9)
//			superficie = 45
//		]
//		val salon_3 = new Locacion => [
//			nombre = "salon_3"
//			punto = new Point(35.3, 65.2)
//			superficie = 100
//		]
//
//		RepositorioLocaciones.instance.create(salon_SM)
//		RepositorioLocaciones.instance.create(salon_2)
//		RepositorioLocaciones.instance.create(salon_3)
//
//		
//		val usuario1 = new Usuario => [
//			nombreUsuario = "Felipe"
//			email = "Felipe_Quino@qwe.com"
//			nombreApellido = "Felipe no se"
//			fechaNacimiento = LocalDate.of(1950, 05, 15)
//			punto = new Point(40.0, 50.0)
//		]
//
//		val usuario2 = new Usuario => [
//			nombreUsuario = "Mafalda"
//			email = "mafaldita@asd.org"
//			nombreApellido = "Mario Argentina"
//			fechaNacimiento = LocalDate.of(1900, 04, 02)
//			punto = new Point(45.0, 60.0)
//		]
//
//		val usuario3 = new Usuario => [
//			nombreUsuario = "Libertad"
//			email = "libertad_Quino@zxc.qq"
//			nombreApellido = "Libertad Gomez"
//			fechaNacimiento = LocalDate.of(1900, 04, 02)
//			punto = new Point(34.0, 45.0)
//			esAntisocial = false
//		]
//
//		val usuario4 = new Usuario => [
//			nombreUsuario = "manolito"
//			email = "email4"
//			nombreApellido = "aaamanolito otro"
//			fechaNacimiento = LocalDate.of(2002, 05, 15)
//			punto = new Point(40.0, 50.0)
//		]
//		val usuario5 = new Usuario => [
//			nombreUsuario = "susanita"
//			email = "email4"
//			nombreApellido = "susanitatro"
//			fechaNacimiento = LocalDate.of(1991, 05, 15)
//			punto = new Point(40.0, 50.0)
//		]
//		val usuario6 = new Usuario => [
//			nombreUsuario = "Quino"
//			email = "email4"
//			nombreApellido = "Perez otro"
//			fechaNacimiento = LocalDate.of(2002, 05, 15)
//			punto = new Point(40.0, 50.0)
//		]
//
//		usuario1.setUsuarioProfesional()
//		usuario2.setUsuarioProfesional()
//		usuario3.setUsuarioProfesional()
//		usuario4.setUsuarioProfesional()
//		usuario5.setUsuarioFree()
//		usuario6.setUsuarioAmateur()
//
//		usuario1.agregarAmigoALaLista(usuario2)
//		usuario1.agregarAmigoALaLista(usuario3)
//		usuario1.agregarAmigoALaLista(usuario4)
//		usuario1.agregarAmigoALaLista(usuario5)
//		usuario1.agregarAmigoALaLista(usuario6)
//		usuario2.agregarAmigoALaLista(usuario3)
//		usuario2.agregarAmigoALaLista(usuario4)
//		this.create(usuario1)
//		this.create(usuario2)
//		this.create(usuario3)
//		this.create(usuario4)
//		this.create(usuario5)
//		this.create(usuario6)
//		val reunionProyecto = new EventoAbierto => [
//			nombre = "Reunion Personal"
//			organizador = usuario1
//			locacion = salon_SM
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
//			edadMinima = 17
//			precioEntrada = 100
//		]
//		val cumple = new EventoAbierto => [
//			nombre = "cumple"
//			organizador = usuario1
//			locacion = salon_3
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(25))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(26))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(7))
//			edadMinima = 1
//			precioEntrada = 200
//		]
//		val reunionChica = new EventoCerrado => [
//			nombre = "Reunion Chica"
//			organizador = usuario1
//			locacion = salon_3
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(1))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(0))
//			capacidadMaxima = 10
//		]
//		val otroEvento = new EventoCerrado => [
//			nombre = "Otra Reunion "
//			organizador = usuario1
//			locacion = salon_SM
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(2))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(3))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(1))
//			capacidadMaxima = 50
//		]
//		val reunionGrande = new EventoCerrado => [
//			nombre = "Reunion++ "
//			organizador = usuario2
//			locacion = salon_SM
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(2))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(1))
//			capacidadMaxima = 20
//		]
//
////		val primerEvento = new EventoCerrado => [
////			nombre = "por que a mi  Proyecto"
////			organizador = usuario3
////			locacion = salon_SM
////			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
////			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
////			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
////			capacidadMaxima = 10
////		]
////		val segundoEvento = new EventoCerrado => [
////			nombre = "otra cosa Proyecto"
////			organizador = usuario3
////			locacion = salon_SM
////			fechaDeInicio = LocalDateTime.now.plus(Period.ofDays(4))
////			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
////			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
////			capacidadMaxima = 10
////		]
//		val tercerEvento = new EventoCerrado => [
//			nombre = "Reunion de nuevo"
//			organizador = usuario2
//			locacion = salon_2
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(13))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(14))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
//			capacidadMaxima = 10
//		]
//		val cuartoEvento = new EventoCerrado => [
//			nombre = "los mafalditos"
//			locacion = salon_SM
//			organizador = usuario3
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(5))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(9))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
//			capacidadMaxima = 50
//		]
//
//		val quintoEvento = new EventoAbierto => [
//			nombre = "jeje Proyecto"
//			organizador = usuario4
//			locacion = salon_SM
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(1))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(2))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-1))
//			edadMinima = 1
//			precioEntrada = 30
//		]
//
//		usuario1.organizarEventoAbierto(reunionProyecto)
//		usuario1.organizarEventoAbierto(cumple)
//		usuario1.organizarEventoCerrado(reunionChica)
//		usuario1.organizarEventoCerrado(otroEvento)
//		usuario4.organizarEventoAbierto(quintoEvento)
//		// otroEvento.fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-1))
//		// reunionChica.fechaDeInicio = LocalDateTime.now()
//		// cumple.comprarEntrada(usuario3)
//		// FP quintoEvento.comprarEntrada(usuario1)
//		val invitacion = new Invitacion(reunionGrande, usuario1, 3)
//		usuario1.recibirInvitacion(invitacion)
//		val invitacion2 = new Invitacion(tercerEvento, usuario1, 4)
//		usuario1.recibirInvitacion(invitacion2)
//		val invitacion3 = new Invitacion(cuartoEvento, usuario1, 5)
//		usuario1.recibirInvitacion(invitacion3)
//		// usuario1.rechazarInvitacion(invitacion3)
//		// FP
//		reunionProyecto.comprarEntrada(usuario5)
//		reunionProyecto.comprarEntrada(usuario3)
//		reunionProyecto.comprarEntrada(usuario2)
//		otroEvento.crearInvitacion(usuario2, 3)
//		usuario2.invitaciones.last.aceptada = true
//		otroEvento.crearInvitacion(usuario3, 4)
//		usuario3.invitaciones.last.aceptada = true
//		otroEvento.crearInvitacion(usuario4, 5)
//		usuario4.invitaciones.last.aceptada = true
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

	}

	def agendaUsuario(int _id) {
		val Set<Evento> eventosAgenda = newHashSet
		var elUsuario = this.searchById(_id)
		elUsuario.eventosOrganizados.forEach [ evento |
			if (LocalDate.now() <= LocalDate.from(evento.fechaDeInicio)) {
				eventosAgenda.add(evento)
			}
		]
		elUsuario.invitaciones.forEach [ invitacion |
			if (LocalDate.now() <= LocalDate.from(invitacion.getEventoCerrado.fechaDeInicio) &&
				(invitacion.aceptada === true)) {
				eventosAgenda.add(invitacion.getEventoCerrado())
			}
		]
		elUsuario.entradaComprada.forEach [ entrada |
			if (LocalDate.now() <= LocalDate.from(entrada.eventoAbierto.fechaDeInicio)) {
				eventosAgenda.add(entrada.eventoAbierto())
			}
		]
		return eventosAgenda
	}

	/* metodos Agenda para el controller */
	def agendaHoy(int _id) {
		val Set<Evento> eventosAgenda = newHashSet
		this.agendaUsuario(_id).forEach [ unEvento |
			if (LocalDate.from(unEvento.fechaDeInicio) < LocalDate.now().plus(Period.ofDays(1))) {
				eventosAgenda.add(unEvento)
			}
		]
		return eventosAgenda
	}

	def agendaSemana(int _id) {
		val Set<Evento> eventosAgenda = newHashSet
		this.agendaUsuario(_id).forEach [ unEvento |
			if (LocalDate.from(unEvento.fechaDeInicio) > LocalDate.now() &&
				LocalDate.from(unEvento.fechaDeInicio) < LocalDate.now().plus(Period.ofDays(8))) {
				eventosAgenda.add(unEvento)
			}
		]

		return eventosAgenda
	}

	def agendaProximos(int _id) {
		val Set<Evento> eventosAgenda = newHashSet
		this.agendaUsuario(_id).forEach [ unEvento |
			if (LocalDate.from(unEvento.fechaDeInicio) > LocalDate.now().plus(Period.ofDays(7))) {
				eventosAgenda.add(unEvento)
			}
		]
		return eventosAgenda
	}

	def buscarIdconNombre(String value) { return elementos.findFirst[elemento|elemento.nombreApellido.equals(value)] }

	def organizadosUsuarioAbiertos(int _id) {
		val Set<Evento> organizadosPorUsuarioA = newHashSet
		var elUsuario = this.searchById(_id)
		elUsuario.eventosOrganizados.forEach [ evento |
			if (LocalDate.now() <= LocalDate.from(evento.fechaDeInicio) && (evento instanceof EventoAbierto )) {
				organizadosPorUsuarioA.add(evento)
			}
		]
		return organizadosPorUsuarioA
	}

	def organizadosUsuarioCerrados(int _id) {
		val Set<Evento> organizadosPorUsuarioC = newHashSet
		var elUsuario = this.searchById(_id)
		elUsuario.eventosOrganizados.forEach [ evento |
			if (LocalDate.now() <= LocalDate.from(evento.fechaDeInicio) && (evento instanceof EventoCerrado )) {
				organizadosPorUsuarioC.add(evento)
			}
		]
		return organizadosPorUsuarioC
	}

	// FP Obtenemos la lista de eventos abiertos del usuario.
	def Set<Evento> buscarEventosAbiertoUsuario(int _id) {
		val eventos = elementos.findFirst[elemento|elemento.getId() == _id].eventosOrganizados
		return eventos.filter[evento|evento instanceof EventoAbierto].toSet
	}

	// FP Obtenemos la lista de eventos cerrados del usuario.
	def Set<Evento> buscarEventosCerradosUsuario(int _id) {
		val eventos = elementos.findFirst[elemento|elemento.getId() == _id].eventosOrganizados
		return eventos.filter[evento|evento instanceof EventoCerrado].toSet
	}

	/* REACT OBTENEMOS TODOS LOS EVENTOS ABIERTOS. */
	def List<Evento> todosLosEventosOrganizadosAbiertos() {
		val eventos = elementos.map(elemento|elemento.eventosOrganizados).flatten().toList()
		return eventos.filter[evento|evento instanceof EventoAbierto].toList()
	}

	def eventosConArtistasFavoritos(List<Evento> eventos, Usuario usuario) {
		eventos.filter(evento|evento.artistas.exists(artista | usuario.fanArtistas.contains(artista))).toSet()
	}

	/*
	def eventosConAmigos(List<Evento> eventos, Usuario usuario) {
		eventos.filter(evento|evento.entradas.exists(amigo | amigo.unUsuario.esMiAmigo(usuario))).toSet()
	}
	 */
	 
	def eventosRadioCercania(List<Evento> eventos, Usuario usuario) {
		eventos.filter(evento|evento.usuariosCercanosAlEvento(usuario)).toSet()
	}
}
