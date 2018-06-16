package eventos

import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import servicios.Servicio

@Accessors
class TestServiciosMultiples extends FixtureTest {

	Usuario usuario3
	Invitacion invitacion
	Servicio servicioCatering
	Servicio servicioAnimacion
	Entrada entradaPrueba
	Entrada entradaPrueba2
	Entrada entradaPrueba3
	Servicio cateringAnimacion

	@Before
	def void initTest() {

		new Usuario => [
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			coordenadas = new Point(34, 45)
			esAntisocial = false
		]
		cateringAnimacion = new Servicio

		servicioCatering = new Servicio => [
			ubicacion = new Point(34.910067, 45) // distancia a reunion chica aproximada 10 km
			costoFijo = 100
			costoPorKm = 2
		]
		servicioAnimacion = new Servicio => [
			ubicacion = new Point(34.55, 45) // distancia a reunion chica 0
			costoFijo = 200
			costoPorKm = 2
			costoMinimo = 100
			costoPorHora = 5
			costoPorPersona = 400
			porcentajeCostoMinimo = 20
		]
		entradaPrueba = new Entrada(reunionAbierta, usuario1)
		entradaPrueba2 = new Entrada(reunionAbierta, usuario2)
		entradaPrueba3 = new Entrada(reunionAbierta, usuario3)

	}

	@Test
	def costoTotalServicioCatering120() {
		servicioCatering.setTarifaFija()
		Assert.assertEquals(120, servicioCatering.costoTotal(reunionChica), 0.3)
	}

	@Test
	def costoTotalServicioMultipleDist50Kmx2_100_200() {
		servicioAnimacion.setTarifaFija()
		servicioCatering.setTarifaFija()
		cateringAnimacion.setServicioMultiple()
		cateringAnimacion.agregarServicio(servicioAnimacion)
		cateringAnimacion.agregarServicio(servicioCatering)
		Assert.assertEquals(400, cateringAnimacion.costoTotal(reunionChica), 0.5)
	}

	@Test
	def costoTotalServicioMultipleDist10kmx110_100_200() {
		servicioAnimacion.setTarifaFija()
		servicioCatering.setTarifaFija()
		servicioCatering.costoPorKm = 110
		cateringAnimacion.setServicioMultiple()
		cateringAnimacion.agregarServicio(servicioAnimacion)
		cateringAnimacion.agregarServicio(servicioCatering)
		Assert.assertEquals(1400, cateringAnimacion.costoTotal(reunionChica), 0.5)
	}

	@Test
	def costoTotalServicioMultipleDist10kmx110_100_496() {
		servicioAnimacion.setTarifaPorHora()
		servicioCatering.setTarifaFija()
		servicioCatering.costoPorKm = 110
		cateringAnimacion.setServicioMultiple()
		cateringAnimacion.agregarServicio(servicioAnimacion)
		cateringAnimacion.agregarServicio(servicioCatering)
		Assert.assertEquals(1420, cateringAnimacion.costoTotal(reunionChica), 0.5)
	}

	@Test
	def costoTotalServicioMultipleDist10kmx110_100_220_menos64DeDescuento() {
		servicioAnimacion.setTarifaPorHora()
		servicioCatering.setTarifaFija()
		servicioCatering.costoPorKm = 110
		cateringAnimacion.setServicioMultiple()
		cateringAnimacion.agregarServicio(servicioAnimacion)
		cateringAnimacion.agregarServicio(servicioCatering)
		cateringAnimacion.tipoDeServicio.setDescuento(20.0)
		Assert.assertEquals(1356.0, cateringAnimacion.costoTotal(reunionChica), 0.5)
	}

}
