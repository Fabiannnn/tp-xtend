package app

import eventos.EventoAbierto
import eventos.EventoCerrado
import eventos.Invitacion
import eventos.Locacion
import eventos.Usuario
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.Period
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import repositorio.RepositorioUsuarios

@Accessors
class DatosIniciales {
	/* Singleton */
	static DatosIniciales datosIniciales

	def static DatosIniciales getInstance() {
		if (datosIniciales === null) {
			datosIniciales = new DatosIniciales
		}
		datosIniciales
	}

	new() {
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
			email = "libertad_Quino@zxc.org"
			nombreApellido = "Libertad Gomez"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			punto = new Point(34.0, 45.0)
			esAntisocial = false
		]

		val usuario4 = new Usuario => [
			nombreUsuario = "manolito"
			email = "email4"
			nombreApellido = "manolito otro"
			fechaNacimiento = LocalDate.of(1991, 05, 15) // FP
			punto = new Point(40.0, 50.0)
		]
		val usuario5 = new Usuario => [
			nombreUsuario = "susanita"
			email = "email4"
			nombreApellido = "susanitatro"
			fechaNacimiento = LocalDate.of(1993, 05, 15) // FP
			punto = new Point(40.0, 50.0)
		]
		val usuario6 = new Usuario => [
			nombreUsuario = "Quino"
			email = "email4"
			nombreApellido = "Perez otro"
			fechaNacimiento = LocalDate.of(1992, 05, 15) // FP
			punto = new Point(40.0, 50.0)
		]

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

		val RepositorioUsuarios repoUsuarios = new RepositorioUsuarios
		repoUsuarios.create(usuario1)
		repoUsuarios.create(usuario2)
		repoUsuarios.create(usuario3)
		repoUsuarios.create(usuario4)
		repoUsuarios.create(usuario5)
		repoUsuarios.create(usuario6)

		val salon_SM = new Locacion => [
			nombre = "San Martin"
			punto = new Point(35, 45)
			superficie = 16
		]
		val salon_2 = new Locacion => [
			nombre = "San Martin 2"
			punto = new Point(35, 65)
			superficie = 45
		]
		val salon_3 = new Locacion => [
			nombre = "salon_3"
			punto = new Point(35, 65)
			superficie = 100
		]

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
			organizador = usuario1
			locacion = salon_3
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(25))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(26))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(7))
			edadMinima = 1
			precioEntrada = 200
		]
		val reunionChica = new EventoCerrado => [
			nombre = "Reunion Chica"
			organizador = usuario1
			locacion = salon_3
			fechaDeInicio = LocalDateTime.now()
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-1))
			capacidadMaxima = 10
		]
		val otroEvento = new EventoCerrado => [
			nombre = "Otra Reunion"
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(2))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(3))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(1))
			capacidadMaxima = 50
		]
		val reunionGrande = new EventoCerrado => [
			nombre = "Reunion++"
			organizador = usuario2
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(2))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(1))
			capacidadMaxima = 20
		]

//		val primerEvento = new EventoCerrado => [
//			nombre = "por que a mi  Proyecto"
//			organizador = usuario3
//			locacion = salon_SM
//			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
//			capacidadMaxima = 10
//		]
//		val segundoEvento = new EventoCerrado => [
//			nombre = "otra cosa Proyecto"
//			organizador = usuario3
//			locacion = salon_SM
//			fechaDeInicio = LocalDateTime.now.plus(Period.ofDays(4))
//			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
//			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
//			capacidadMaxima = 10
//		]
		val tercerEvento = new EventoCerrado => [
			nombre = "Reunion de nuevo"
			organizador = usuario2
			locacion = salon_2
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(13))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(14))
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
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(1))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(2))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-1))
			edadMinima = 1
			precioEntrada = 30
		]

		usuario1.organizarEventoAbierto(reunionProyecto)
		usuario1.organizarEventoAbierto(cumple)
		usuario1.organizarEventoCerrado(reunionChica)
		usuario1.organizarEventoCerrado(otroEvento)
		usuario4.organizarEventoAbierto(quintoEvento)
		// otroEvento.fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-1))
		// reunionChica.fechaDeInicio = LocalDateTime.now()
		// cumple.comprarEntrada(usuario3)
		// FP quintoEvento.comprarEntrada(usuario1)
		val invitacion = new Invitacion(reunionGrande, usuario1, 3)
		usuario1.recibirInvitacion(invitacion)
		val invitacion2 = new Invitacion(tercerEvento, usuario1, 4)
		usuario1.recibirInvitacion(invitacion2)
		val invitacion3 = new Invitacion(cuartoEvento, usuario1, 5)
		usuario1.recibirInvitacion(invitacion3)
		// usuario1.rechazarInvitacion(invitacion3)
		// usuario1.rechazarInvitacion(invitacion3)
		// FP
		reunionProyecto.comprarEntrada(usuario5)
		reunionProyecto.comprarEntrada(usuario3)
		reunionProyecto.comprarEntrada(usuario2)
		otroEvento.crearInvitacion(usuario2, 3)
		usuario2.invitaciones.last.aceptada = true
		otroEvento.crearInvitacion(usuario3, 4)
		usuario3.invitaciones.last.aceptada = false
		otroEvento.crearInvitacion(usuario4, 5)
	// usuario4.invitaciones.last.aceptada = true 
	}
}
