package eventos

import org.junit.Assert
import org.junit.Test
import java.time.LocalDateTime
import java.time.LocalDate
import java.time.Period
import org.uqbar.geodds.Point
import org.junit.Before

class TestServicios {
	EventoCerrado reunionChica
	EventoAbierto otroEvento
	Locacion salon_SM
	Usuario usuario1
	Usuario usuario2
	Usuario usuario3
	Invitacion invitacion
	Servicio servicioCatering
	Servicio servicioAnimacion
	Entrada entradaPrueba
	Entrada entradaPrueba2
	Entrada entradaPrueba3

	@Before
	def void init() {

		salon_SM = new Locacion => [
			nombreLugar = "San Martin"
			punto = new Point(35, 45)
			superficie = 12
		]
		usuario1 = new Usuario => [
			fechaDeNacimiento = LocalDate.of(2002, 05, 15)
			coordenadasDireccion = new Point(60, 80)
		]
		usuario2 = new Usuario => [
			fechaDeNacimiento = LocalDate.of(1900, 04, 02)
			coordenadasDireccion = new Point(34, 45)
			esAntisocial = false
		]
		usuario3 = new Usuario => [
			fechaDeNacimiento = LocalDate.of(1900, 04, 02)
			coordenadasDireccion = new Point(34, 45)
			esAntisocial = false
		]
		reunionChica = new EventoCerrado => [
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
			capacidadMaxima = 10
		]
		otroEvento = new EventoAbierto => [
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(5))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-1))

		]
		servicioCatering = new Servicio => [
			ubicacion = new Point(34.910067, 45) // distancia a reunion chica aproximada 10 km
			costoFijo = 100
			costoPorKm = 2
		]
		servicioAnimacion = new Servicio => [
			ubicacion = new Point(35, 45) // distancia a reunion chica 0
			costoFijo = 200
			costoPorKm = 2
			costoMinimo = 100
			costoPorHora = 1
			costoPorPersona = 400
			porcentajeCostoMinimo = 20
		]
		entradaPrueba = new Entrada(otroEvento, usuario1)
		entradaPrueba2 = new Entrada(otroEvento, usuario2)
		entradaPrueba3 = new Entrada(otroEvento, usuario3)

	}

	@Test
	def distanciaEntreServicioYEvento10Km() {
		Assert.assertEquals(10, reunionChica.distancia(servicioCatering.ubicacion), 0.3)
	}

	@Test
	def costoTotalServicioCatering120() {
		servicioCatering.setTarifaFija()
		Assert.assertEquals(120, servicioCatering.costoTotal(reunionChica), 0.3)
	}

	@Test
	def costoTotalServicioAnimacion200() {
		servicioAnimacion.setTarifaFija()
		Assert.assertEquals(200, servicioAnimacion.costoTotal(reunionChica), 0.0)
	}

	@Test
	def costoTotalServicioAnimacionTarifaPorHora124() { // 24 horas a 1 +costo minimo de 100
		servicioAnimacion.setTarifaPorHora()
		Assert.assertEquals(124, servicioAnimacion.costoTotal(reunionChica), 0.0)
	}

	@Test
	def costoTotalServicioCateringTarifaPorHora() { // 24 horas a 2 + costoTraslado 20
		servicioCatering.setTarifaPorHora()
		servicioCatering.costoMinimo = 0
		servicioCatering.costoPorHora = 2
		Assert.assertEquals(68, servicioCatering.costoTotal(reunionChica), 0.3)
	}

	@Test
	def costoTotalServicioAnimacionTarifaPorPersonaTarifaBase800EnEventoCerrado() { // costoTraslado 0 noAsistenPresonas solo el costo base por capacidad 2 *400
		servicioAnimacion.setTarifaPorPersona()
		Assert.assertEquals(800, servicioAnimacion.costoTotal(reunionChica), 0.0)
	}

	@Test
	def costoTotalServicioAnimacionTarifaPorPersonaEventoCerrado() { // costoTraslado 0  costo base por capacidad 2 *400 pero 5 posibles asist 400*5
		servicioAnimacion.setTarifaPorPersona()
		invitacion = new Invitacion(reunionChica, usuario2, 4)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		Assert.assertEquals(2000, servicioAnimacion.costoTotal(reunionChica), 0.0)
	}
	@Test
	def costoTotalServicioAnimacionTarifaPorPersonaAbiertoSinAsistentes() { // capacidad 9 por 20%base 2 *$400
		servicioAnimacion.setTarifaPorPersona()
		Assert.assertEquals(800, servicioAnimacion.costoTotal(otroEvento), 0.0)
	}
	@Test
	def costoTotalServicioAnimacionTarifaPorPersonaAbiertoConTresAsistentes1200() { // costoTraslado 0  costo base por capacidad 2 *400 pero 3 asist s*400 1200
		servicioAnimacion.setTarifaPorPersona()
		otroEvento.registrarCompraEnEvento(entradaPrueba)
		otroEvento.registrarCompraEnEvento(entradaPrueba2)
		otroEvento.registrarCompraEnEvento(entradaPrueba3)
		Assert.assertEquals(1200, servicioAnimacion.costoTotal(otroEvento), 0.0)
	}
}
