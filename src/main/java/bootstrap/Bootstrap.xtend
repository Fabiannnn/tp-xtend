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
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.Entity
import org.uqbar.geodds.Point

@Accessors
class Bootstrap 
 {
/* 
	new() {
		ApplicationContext.instance.configureSingleton(typeof(Locacion), new RepositorioLocaciones)
		ApplicationContext.instance.configureSingleton(typeof(Usuario), new RepositorioUsuarios)
		ApplicationContext.instance.configureSingleton(typeof(Servicio), new RepositorioServicios)
	}
	
	override protected getCriterio(T example) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
		override protected getCriterio(T example) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	override getEntityType() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override createExample() {
throw new UnsupportedOperationException("TODO: auto-generated method stub")
}	

def run() {
		// LOCACIONES ##########################################################################################
		val RepoLocaciones = ApplicationContext.instance.getSingleton(typeof(Locacion)) as RepositorioLocaciones

		val sanMartin1 = new Locacion => [
			nombre = "San Martin 1"
			punto = new Point(10.0, 20.0)
			superficie = 16
		]

		val sanMartin2 = new Locacion => [
			nombre = "San Martin 2"
			punto = new Point(30.0, 40.0)
			superficie = 2.5
		]

		val sanMartin3 = new Locacion => [
			nombre = "San Martin 3"
			punto = new Point(50.0, 60.0)
			superficie = 100
		]

		val salonCompleto = new Locacion => [
			nombre = "Salon Completo"
			punto = new Point(70.0, 80.0)
			superficie = 16
		]

		RepoLocaciones.create(sanMartin1)
		RepoLocaciones.create(sanMartin2)
		RepoLocaciones.create(sanMartin3)
		RepoLocaciones.create(salonCompleto)

		// USUARIOS #######################################################################################
		val repoUsuarios = ApplicationContext.instance.getSingleton(typeof(Usuario)) as RepositorioUsuarios

		val usuario1 = new Usuario => [
			nombreUsuario = "usuario1"
			email = "email1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(40.0, 50.0)
		]

		val usuario2 = new Usuario => [
			nombreUsuario = "usuario2"
			email = "email2"
			nombreApellido = "Mario Perez"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			punto = new Point(45.0, 60.0)
		]

		val usuario3 = new Usuario => [
			nombreUsuario = "usuario3"
			email = "email3"
			nombreApellido = "María Gomez"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			punto = new Point(34.0, 45.0)
			esAntisocial = false
		]

		val usuario4 = new Usuario => [
			nombreUsuario = "usuario4"
			email = "email4"
			nombreApellido = "Perez otro"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(40.0, 50.0)
		]

		usuario1.setUsuarioProfesional()
		usuario2.setUsuarioProfesional()
		usuario3.setUsuarioProfesional()
		usuario4.setUsuarioProfesional()

		// EVENTOS ###########################################################################################
		val reunionAbierta1 = new EventoAbierto => [
			nombre = "Evento Abierto 1"
			organizador = usuario1
			locacion = sanMartin3
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			edadMinima = 10
			precioEntrada = 100
		]

		val reunionAbierta2 = new EventoAbierto => [
			nombre = "Evento Abierto 2"
			organizador = usuario1
			locacion = sanMartin2
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(25))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(26))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(7))
			edadMinima = 10
			precioEntrada = 200
		]

		val reunionChicaCe1 = new EventoCerrado => [
			nombre = "Evento Cerrado 1"
			organizador = usuario1
			locacion = sanMartin1
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			capacidadMaxima = 10
		]

		val otroEventoCe2 = new EventoCerrado => [
			nombre = "Evento Cerrado 2"
			organizador = usuario2
			locacion = sanMartin3
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(4))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(5))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			capacidadMaxima = 50
		]

		val reunionGrandeAb3 = new EventoAbierto => [
			nombre = "Evento Abierto 3"
			organizador = usuario1
			locacion = salonCompleto
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			edadMinima = 8
			precioEntrada = 100
		]

		val primerEventoCe3 = new EventoCerrado => [
			nombre = "Evento Cerrado 3"
			organizador = usuario4
			locacion = sanMartin2
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			capacidadMaxima = 10
		]

		val segundoEventoCe4 = new EventoCerrado => [
			nombre = "Evento Cerrado 4"
			organizador = usuario4
			locacion = sanMartin3
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			capacidadMaxima = 10
		]

		val quintoEventoCe5 = new EventoCerrado => [
			nombre = "Evento Cerrado 5"
			organizador = usuario1
			locacion = sanMartin3
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(-4))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(-3))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-5))
			capacidadMaxima = 10
		]

		repoUsuarios.create(usuario1)
		repoUsuarios.create(usuario2)
		repoUsuarios.create(usuario3)
		repoUsuarios.create(usuario4)
		usuario1.organizarEventoAbierto(reunionAbierta1)
		usuario1.organizarEventoAbierto(reunionAbierta2)
		usuario1.organizarEventoCerrado(reunionChicaCe1)
		usuario2.organizarEventoCerrado(otroEventoCe2)
		usuario4.organizarEventoCerrado(primerEventoCe3)
		usuario4.organizarEventoCerrado(segundoEventoCe4)
		usuario1.organizarEventoCerrado(quintoEventoCe5)
		usuario1.organizarEventoAbierto(reunionGrandeAb3)

		// SERVICIOS #########################################################################################
		val repoServicios = ApplicationContext.instance.getSingleton(typeof(Servicio)) as RepositorioServicios

		val servicioCatering = new Servicio => [
			punto = new Point(35, 45)
			descripcion = "Catering"
			costoFijo = 200
			costoPorKm = 2
			costoMinimo = 100
			porcentajeCostoMinimo = 20
		]

		val servicioAnimacion = new Servicio => [
			punto = new Point(35, 45)
			descripcion = "Animacion"
			costoFijo = 300
			costoPorKm = 2
			costoMinimo = 100
			costoPorHora = 1
			costoPorPersona = 400
			porcentajeCostoMinimo = 20
		]

		servicioAnimacion.setTarifaPorHora
		servicioCatering.setTarifaFija

		repoServicios.create(servicioAnimacion)
		repoServicios.create(servicioCatering)

		usuario2.comprarEntradaAUnEventoAbierto(reunionAbierta2)
		usuario2.comprarEntradaAUnEventoAbierto(reunionAbierta1)
		usuario4.comprarEntradaAUnEventoAbierto(reunionGrandeAb3)
		usuario4.comprarEntradaAUnEventoAbierto(reunionAbierta2)
		usuario1.invitarAUnEventoCerrado(reunionChicaCe1, usuario2, 8)
		val unaInvitacion = new Invitacion(otroEventoCe2, usuario1, 8)
		usuario1.aceptarInvitacion(unaInvitacion, 8)

	}
	

	

*/
}