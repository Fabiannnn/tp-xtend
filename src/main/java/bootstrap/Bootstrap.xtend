package bootstrap

import eventos.EventoAbierto
import eventos.EventoCerrado
import eventos.Invitacion
import eventos.Locacion
import eventos.Usuario
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.Period
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import repositorio.RepositorioLocaciones
import repositorio.RepositorioServicios
import repositorio.RepositorioUsuarios
import servicios.Servicio
import org.uqbar.geodds.Point
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap

@Accessors
class Bootstrap extends CollectionBasedBootstrap {

	new() {
		ApplicationContext.instance.configureSingleton(typeof(Locacion), new RepositorioLocaciones)
		ApplicationContext.instance.configureSingleton(typeof(Usuario), new RepositorioUsuarios)
		ApplicationContext.instance.configureSingleton(typeof(Servicio), new RepositorioServicios)
	}

	override run() {

		// LOCACIONES ##########################################################################################
		// val RepoLocaciones = ApplicationContext.instance.getSingleton(typeof(Locacion)) as RepositorioLocaciones
		val sanMartin1 = new Locacion => [
			nombre = "Calesita"
			punto = new Point(10.0, 20.0)
			superficie = 16
		]

		val sanMartin2 = new Locacion => [
			nombre = "La Estacion"
			punto = new Point(30.0, 40.0)
			superficie = 2.5
		]

		val sanMartin3 = new Locacion => [
			nombre = "M&M"
			punto = new Point(50.0, 60.0)
			superficie = 100
		]

		val salonCompleto = new Locacion => [
			nombre = "Girardot"
			punto = new Point(70.0, 80.0)
			superficie = 16
		]
		val salon_SM = new Locacion => [
			nombre = "Unsam"
			punto = new Point(35.0, 45.0)
			superficie = 16
		]
		val salon_2 = new Locacion => [
			nombre = "El Quijote"
			punto = new Point(35.5, 65.9)
			superficie = 45
		]
		val salon_3 = new Locacion => [
			nombre = "El Teatrito"
			punto = new Point(35.3, 65.2)
			superficie = 100
		]

		RepositorioLocaciones.instance.create(salon_SM)
		RepositorioLocaciones.instance.create(salon_2)
		RepositorioLocaciones.instance.create(salon_3)
		RepositorioLocaciones.instance.create(sanMartin1)
		RepositorioLocaciones.instance.create(sanMartin2)
		RepositorioLocaciones.instance.create(sanMartin3)
		RepositorioLocaciones.instance.create(salonCompleto)

		// USUARIOS #######################################################################################
		// val repoUsuarios = ApplicationContext.instance.getSingleton(typeof(Usuario)) as RepositorioUsuarios
		val usuario1 = new Usuario => [
			nombreUsuario = "Felipe"
			email = "Felipe_Quino@qwe.com"
			nombreApellido = "Felipe no se"
			fechaNacimiento = LocalDate.of(1950, 05, 15)
			punto = new Point(40.0, 50.0)
		]

		val usuario2 = new Usuario => [
			nombreUsuario = "Mafalda"
			email = "mafaldita@asd.org"
			nombreApellido = "Mario Argentina"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			punto = new Point(45.0, 60.0)
		]

		val usuario3 = new Usuario => [
			nombreUsuario = "Libertad"
			email = "libertad_Quino@zxc.qq"
			nombreApellido = "Libertad Gomez"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			punto = new Point(34.0, 45.0)
			esAntisocial = false
		]

		val usuario4 = new Usuario => [
			nombreUsuario = "manolito"
			email = "email4"
			nombreApellido = "aaamanolito otro"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(40.0, 50.0)
		]
		val usuario5 = new Usuario => [
			nombreUsuario = "susanita"
			email = "email4"
			nombreApellido = "susanitatro"
			fechaNacimiento = LocalDate.of(1991, 05, 15)
			punto = new Point(40.0, 50.0)
		]
		val usuario6 = new Usuario => [
			nombreUsuario = "Quino"
			email = "email4"
			nombreApellido = "Perez otro"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(40.0, 50.0)
		]
		/*
		val usuario7 = new Usuario => [
			nombreUsuario = "ArgPep"
			email = "email1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(40.0, 50.0)
		]

		val usuario8 = new Usuario => [
			nombreUsuario = "MaPerez"
			email = "email2@ma.Perez"
			nombreApellido = "Mario Perez"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			punto = new Point(45.0, 60.0)
		]

		val usuario9 = new Usuario => [
			nombreUsuario = "GomezMa"
			email = "email3@mariaGomez"
			nombreApellido = "María Gomez"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			punto = new Point(34.0, 45.0)
			esAntisocial = false
		]

		val usuario10 = new Usuario => [
			nombreUsuario = "DiegMessi"
			email = "email4@dieg.messi"
			nombreApellido = "Diego Messi"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(40.0, 50.0)
		]
		 */
		usuario1.setUsuarioProfesional()
		usuario2.setUsuarioProfesional()
		usuario3.setUsuarioProfesional()
		usuario4.setUsuarioProfesional()
		usuario5.setUsuarioFree()
		usuario6.setUsuarioAmateur()

		usuario1.agregarAmigoALaLista(usuario2)
		usuario1.agregarAmigoALaLista(usuario3)
		usuario1.agregarAmigoALaLista(usuario4)
		usuario1.agregarAmigoALaLista(usuario5)
		usuario1.agregarAmigoALaLista(usuario6)
		usuario2.agregarAmigoALaLista(usuario3)
		usuario2.agregarAmigoALaLista(usuario4)
		RepositorioUsuarios.instance.create(usuario1)
		RepositorioUsuarios.instance.create(usuario2)
		RepositorioUsuarios.instance.create(usuario3)
		RepositorioUsuarios.instance.create(usuario4)
		RepositorioUsuarios.instance.create(usuario5)
		RepositorioUsuarios.instance.create(usuario6)

		// EVENTOS ###########################################################################################
		val reunionProyecto = new EventoAbierto => [
			nombre = "Reunion Personal"
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			edadMinima = 17
			precioEntrada = 100
		]
		val cumple = new EventoAbierto => [
			nombre = "cumple"
			organizador = usuario3
			locacion = salon_3
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(5))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(6))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
			edadMinima = 1
			precioEntrada = 200
		]
		val reunionChica = new EventoCerrado => [
			nombre = "Reunion Chica"
			organizador = usuario1
			locacion = salon_3
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(2))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(1))
			capacidadMaxima = 50
		]
		val otroEvento = new EventoCerrado => [
			nombre = "Otra Reunion "
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(2))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(3))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(1))
			capacidadMaxima = 50
		]
		val reunionGrande = new EventoCerrado => [
			nombre = "Reunion++ "
			organizador = usuario3
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(2))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(1))
			capacidadMaxima = 20
		]

		val tercerEvento = new EventoCerrado => [
			nombre = "Reunion de nuevo"
			organizador = usuario2
			locacion = salon_2
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			capacidadMaxima = 10
		]
		val cuartoEvento = new EventoCerrado => [
			nombre = "los mafalditos"
			locacion = salon_SM
			organizador = usuario3
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(5))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(9))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
			capacidadMaxima = 50
		]

		val quintoEvento = new EventoAbierto => [
			nombre = "jeje Proyecto"
			organizador = usuario4
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(2))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(3))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(1))
			edadMinima = 1
			precioEntrada = 30
		]

		usuario1.organizarEventoAbierto(reunionProyecto)
		usuario3.organizarEventoAbierto(cumple)
		usuario1.organizarEventoCerrado(reunionChica)
		usuario1.organizarEventoCerrado(otroEvento)
		usuario2.organizarEventoCerrado(tercerEvento)
		usuario3.organizarEventoCerrado(cuartoEvento)
		usuario3.organizarEventoCerrado(reunionGrande)
		usuario4.organizarEventoAbierto(quintoEvento)
		// otroEvento.fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-1))
		// reunionChica.fechaDeInicio = LocalDateTime.now()
		// cumple.comprarEntrada(usuario3)
		
		// FP quintoEvento.comprarEntrada(usuario1)
		val invitacion = new Invitacion(cuartoEvento, usuario1, 3)
		usuario1.recibirInvitacion(invitacion)

		val invitacion2 = new Invitacion(tercerEvento, usuario1, 0)
		
		usuario1.recibirInvitacion(invitacion2)
//		usuario1.aceptarInvitacion(invitacion2, 2)
		// val invitacion3 = new Invitacion(cuartoEvento, usuario1, 5)
		// usuario1.recibirInvitacion(invitacion3)
		val invitacion7 = new Invitacion(reunionGrande, usuario1, 2)
		usuario1.recibirInvitacion(invitacion7)
//Usuario1 invita a evento reunionChica Aceptan Rechazan y pendiente
		val invitacion4 = new Invitacion(reunionChica, usuario2, 10)

		usuario2.recibirInvitacion(invitacion4)
		usuario2.aceptarInvitacion(invitacion4, 2)
		// usuario2.invitaciones.last.aceptada = true
		val invitacion5 = new Invitacion(reunionChica, usuario3, 5)
		usuario3.recibirInvitacion(invitacion5)
		usuario3.rechazarInvitacion(invitacion5)
		// usuario3.invitaciones.last.aceptada = false
		val invitacion6 = new Invitacion(reunionChica, usuario4, 6)
		usuario4.recibirInvitacion(invitacion6)

		// usuario1.rechazarInvitacion(invitacion3)
		// FP
		cumple.comprarEntrada(usuario1)
		reunionProyecto.comprarEntrada(usuario5)
		reunionProyecto.comprarEntrada(usuario3)
		reunionProyecto.comprarEntrada(usuario2)

		otroEvento.crearInvitacion(usuario2, 3)
		usuario2.invitaciones.last.aceptada = true
		otroEvento.crearInvitacion(usuario3, 4)
		usuario3.invitaciones.last.aceptada = false
		otroEvento.crearInvitacion(usuario4, 5)
	// usuario4.invitaciones.last.aceptada= false
//		
//		val reunionAbierta1 = new EventoAbierto => [
//			nombre = "Evento Abierto 1"
//			organizador = usuario1
//			locacion = sanMartin3
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
//			edadMinima = 10
//			precioEntrada = 100
//		]
//
//		val reunionAbierta2 = new EventoAbierto => [
//			nombre = "Evento Abierto 2"
//			organizador = usuario1
//			locacion = sanMartin2
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(25))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(26))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(7))
//			edadMinima = 10
//			precioEntrada = 200
//		]
//
//		val reunionChicaCe1 = new EventoCerrado => [
//			nombre = "Evento Cerrado 1"
//			organizador = usuario1
//			locacion = sanMartin1
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
//			capacidadMaxima = 10
//		]
//
//		val otroEventoCe2 = new EventoCerrado => [
//			nombre = "Evento Cerrado 2"
//			organizador = usuario2
//			locacion = sanMartin3
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(4))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(5))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
//			capacidadMaxima = 50
//		]
//
//		val reunionGrandeAb3 = new EventoAbierto => [
//			nombre = "Evento Abierto 3"
//			organizador = usuario1
//			locacion = salonCompleto
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
//			edadMinima = 8
//			precioEntrada = 100
//		]
//
//		val primerEventoCe3 = new EventoCerrado => [
//			nombre = "Evento Cerrado 3"
//			organizador = usuario4
//			locacion = sanMartin2
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
//			capacidadMaxima = 10
//		]
//
//		val segundoEventoCe4 = new EventoCerrado => [
//			nombre = "Evento Cerrado 4"
//			organizador = usuario4
//			locacion = sanMartin3
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
//			capacidadMaxima = 10
//		]
//
//		val quintoEventoCe5 = new EventoCerrado => [
//			nombre = "Evento Cerrado 5"
//			organizador = usuario1
//			locacion = sanMartin3
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(-4))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(-3))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-5))
//			capacidadMaxima = 10
//		]
//
//		RepositorioUsuarios.instance.create(usuario1)
//		RepositorioUsuarios.instance.create(usuario2)
//		RepositorioUsuarios.instance.create(usuario3)
//		RepositorioUsuarios.instance.create(usuario4)
//		usuario1.organizarEventoAbierto(reunionAbierta1)
//		usuario1.organizarEventoAbierto(reunionAbierta2)
//		usuario1.organizarEventoCerrado(reunionChicaCe1)
//		usuario2.organizarEventoCerrado(otroEventoCe2)
//		usuario4.organizarEventoCerrado(primerEventoCe3)
//		usuario4.organizarEventoCerrado(segundoEventoCe4)
//		usuario1.organizarEventoCerrado(quintoEventoCe5)
//		usuario1.organizarEventoAbierto(reunionGrandeAb3)
//
//		// SERVICIOS #########################################################################################
//		val repoServicios = ApplicationContext.instance.getSingleton(typeof(Servicio)) as RepositorioServicios
//
//		val servicioCatering = new Servicio => [
//			punto = new Point(35, 45)
//			descripcion = "Catering"
//			costoFijo = 200
//			costoPorKm = 2
//			costoMinimo = 100
//			porcentajeCostoMinimo = 20
//		]
//
//		val servicioAnimacion = new Servicio => [
//			punto = new Point(35, 45)
//			descripcion = "Animacion"
//			costoFijo = 300
//			costoPorKm = 2
//			costoMinimo = 100
//			costoPorHora = 1
//			costoPorPersona = 400
//			porcentajeCostoMinimo = 20
//		]
//
//		servicioAnimacion.setTarifaPorHora
//		servicioCatering.setTarifaFija
//
//		repoServicios.create(servicioAnimacion)
//		repoServicios.create(servicioCatering)
//
//		usuario2.comprarEntradaAUnEventoAbierto(reunionAbierta2)
//		usuario2.comprarEntradaAUnEventoAbierto(reunionAbierta1)
//		usuario4.comprarEntradaAUnEventoAbierto(reunionGrandeAb3)
//		usuario4.comprarEntradaAUnEventoAbierto(reunionAbierta2)
//		usuario1.invitarAUnEventoCerrado(reunionChicaCe1, usuario2, 8)
//		val unaInvitacion = new Invitacion(otroEventoCe2, usuario1, 8)
//		usuario1.aceptarInvitacion(unaInvitacion, 8)
	}

}
