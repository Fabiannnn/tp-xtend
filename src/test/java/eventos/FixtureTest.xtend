package eventos

import java.time.LocalDate
import java.time.LocalDateTime
import java.time.Period
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Before
import org.uqbar.geodds.Point
import repositorio.RepositorioLocaciones
import repositorio.RepositorioServicios
import repositorio.RepositorioUsuarios

@Accessors
abstract class FixtureTest {
	EventoCerrado reunionGrande
	EventoCerrado reunionChica
	EventoCerrado otroEvento
	Locacion salon_SM
	Locacion salon_2
	Locacion salon_3
	Locacion salon_Incompleto
	Usuario usuario1
	Usuario usuario2
	Usuario usuario3
	UsuarioFree usuarioFree
	Usuario unUsuario
	EventoCerrado primerEvento
	EventoCerrado segundoEvento
	EventoCerrado tercerEvento
	EventoCerrado cuartoEvento
	EventoCerrado quintoEvento
	EventoCerrado eventoPrueba
	EventoAbierto reunionAbierta
	EventoAbierto cumple
	Entrada entradaPrueba
	RepositorioLocaciones repoLocacion
	RepositorioServicios repoServicio
	RepositorioUsuarios repoUsuario
	int cantMaxDeEventos = 20
	int contador

	@Before
	def void init() {

		salon_SM = new Locacion => [
			nombre = "San Martin"
			punto = new Point(35, 45)
			superficie = 16
		]
		salon_2 = new Locacion => [
			nombre = "San Martin 2"
			punto = new Point(35, 65)
			superficie = 45
		]
		salon_3 = new Locacion => [
			nombre = "Sanse"
			punto = new Point(35, 65)
			superficie = 100
		]

		salon_Incompleto = new Locacion => [
			nombre = "San Martin incompleto"
			superficie = 16
		]

		repoLocacion = new RepositorioLocaciones()
		repoServicio = new RepositorioServicios()
		repoUsuario = new RepositorioUsuarios()

		usuario1 = new Usuario => [
			nombreUsuario = "PrimerUsuario"
			email = "mail1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			coordenadas = new Point(40, 50)
		]

		usuario2 = new Usuario => [
			nombreUsuario = "SegundoUsuario"
			email = "mail2"
			nombreApellido = "Mario Perez"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			coordenadas = new Point(45, 60)
		]
		usuario3 = new Usuario => [
			email = "mail3"
			nombreApellido = "María Gomez"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			coordenadas = new Point(34, 45)
			esAntisocial = false
		]
		reunionAbierta = new EventoAbierto => [
			nombre = "Reunion Proyecto"
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
		]
		cumple = new EventoAbierto => [
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(25))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(26))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(7))
			edadMinima = 17
			precioEntrada = 200
		]
		reunionChica = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now()
			capacidadMaxima = 10
		]
		otroEvento = new EventoCerrado => [
			nombre = "Otra Reunion "
			organizador = usuario2
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(-1))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(1))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-2))
			capacidadMaxima = 50
		]
		reunionGrande = new EventoCerrado => [
			nombre = "Reunion++ "
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			capacidadMaxima = 20
		]
		usuarioFree = new UsuarioFree()
		usuario1.setUsuarioFree()

// mis variables para los tests
		unUsuario = new Usuario => [
			nombreUsuario = "Usuario"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			coordenadas = new Point(40, 50)
		]
		primerEvento = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			organizador = unUsuario
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			capacidadMaxima = 10
		]
		segundoEvento = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			organizador = unUsuario
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			capacidadMaxima = 10
		]
		tercerEvento = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			organizador = unUsuario
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			capacidadMaxima = 10
		]
		cuartoEvento = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(8))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(9))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(7))
			capacidadMaxima = 50
		]

		quintoEvento = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			organizador = unUsuario
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(2))
			capacidadMaxima = 10
		]
		eventoPrueba = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
			capacidadMaxima = 10
		]
		entradaPrueba = new Entrada(cumple, usuario1)
	}
}
