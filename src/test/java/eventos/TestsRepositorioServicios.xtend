package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import excepciones.EventoException
import org.junit.Before
import java.time.LocalDate
import org.uqbar.geodds.Point

@Accessors
class TestsRepositorioServicios extends FixtureTest {
	Usuario usuario3
	Invitacion invitacion
	Servicio servicioCatering
	Servicio servicioAnimacion
	Entrada entradaPrueba
	Entrada entradaPrueba2
	Entrada entradaPrueba3

	@Before
	def void initTest() {

		servicioCatering = new Servicio => [
			ubicacion = new Point(34.910067, 45) // distancia a reunion chica aproximada 10 km
			descripcion = "Catering"
			ubicacion = new Point(34.910067, 45)
			costoFijo = 200
			costoPorKm = 2
			costoMinimo = 100
			porcentajeCostoMinimo = 20
		]
		servicioAnimacion = new Servicio => [
			ubicacion = new Point(35, 45) // distancia a reunion chica 0
			descripcion = "Animacion"
			ubicacion = new Point(34.910067, 45)
			costoFijo = 300
			costoPorKm = 2
			costoMinimo = 100
			costoPorHora = 1
			costoPorPersona = 400
			porcentajeCostoMinimo = 20
		]

	}

	@Test
	def void sePuedeAgregarServicioValidoyPasaValidacion() {
		servicioAnimacion.setTarifaPorPersona()
		repoServicio.create(servicioAnimacion)
		Assert.assertEquals(1, repoServicio.elementos.size(), 0)
	}

	@Test(expected=EventoException)
	def void noSePuedeAgregarUnSegundoServicioDeAnimacion() {
		repoServicio.create(servicioAnimacion)
		repoServicio.create(servicioAnimacion)
	}

	@Test(expected=EventoException)
	def void unaTarifaSinCostoNoValidaTarifa() {
		servicioAnimacion.setTarifaPorPersona()
		servicioAnimacion.costoPorPersona = 0
		servicioAnimacion.validarTarifa()
	}

	@Test
	def void unaTarifaConCostoValidaTarifa() {
		servicioAnimacion.setTarifaPorPersona()
		Assert.assertTrue(servicioAnimacion.validarTarifa())
	}

	@Test(expected=EventoException)
	def void noSePuedeValidarServicioAnimacionIncompleto() {
		repoServicio.validarElemento(servicioAnimacion)
	}

	@Test
	def void seAgregan2ServiciosValidos() {
		servicioCatering.setTarifaFija()
		servicioAnimacion.setTarifaPorPersona()
		repoServicio.create(servicioAnimacion)
		repoServicio.create(servicioCatering)
		Assert.assertEquals(2, repoServicio.elementos.size(), 0)
	}

	@Test
	def void seAgrega3SalonesValidosyBuscamosPor_artQueNoEsta() {
		servicioCatering.setTarifaFija()
		servicioAnimacion.setTarifaPorPersona()
		repoServicio.create(servicioAnimacion)
		repoServicio.create(servicioCatering)
		Assert.assertEquals(0, repoServicio.search("art").size(), 0)
	}

	@Test
	def void seAgrega2ServiciosValidosyBuscamosPor_CatQueEstaEn1() {
		servicioCatering.setTarifaFija()
		servicioAnimacion.setTarifaPorPersona()
		repoServicio.create(servicioAnimacion)
		repoServicio.create(servicioCatering)
		Assert.assertEquals(1, repoServicio.search("Cat").size(), 0)
	}

	@Test
	def void seAgrega2ServiciosValidosyBuscamosPor_erinQueNoEstaAlInicio() {
		servicioCatering.setTarifaFija()
		servicioAnimacion.setTarifaPorPersona()
		repoServicio.create(servicioAnimacion)
		repoServicio.create(servicioCatering)
		Assert.assertEquals(0, repoServicio.search("erin").size(), 0)
	}

	@Test
	def void seAgrega2ServiciosValidosyBuscamosPor_id_2() {
		servicioCatering.setTarifaFija()
		servicioAnimacion.setTarifaPorPersona()
		repoServicio.create(servicioAnimacion)
		repoServicio.create(servicioCatering)
		Assert.assertEquals(200.0, repoServicio.searchById(2).costoFijo, 0.0)
	}

	@Test
	def void seAgrega2ServiciosValidosyborramosServicioAnimacion() {
		servicioCatering.setTarifaFija()
		servicioAnimacion.setTarifaPorPersona()
		repoServicio.create(servicioAnimacion)
		repoServicio.create(servicioCatering)
		repoServicio.delete(servicioAnimacion)
		Assert.assertEquals(1, repoServicio.elementos.size(), 0)
	}

	@Test
	def void seAgrega2ServiciosValidosSeBorraServicioAnimacionNoSeEncuentraId1() {
		servicioCatering.setTarifaFija()
		servicioAnimacion.setTarifaPorPersona()
		repoServicio.create(servicioAnimacion)
		repoServicio.create(servicioCatering)
		repoServicio.delete(servicioAnimacion)
		Assert.assertNull(repoServicio.searchById(1))
	}

	@Test
	def void seAgrega2ServiciosValidosSeBorraServicioAnimacionSeEncuentraId2() {
		servicioCatering.setTarifaFija()
		servicioAnimacion.setTarifaPorPersona()
		repoServicio.create(servicioAnimacion)
		repoServicio.create(servicioCatering)
		repoServicio.delete(servicioAnimacion)
		Assert.assertNotNull(repoServicio.searchById(2))
	}

	// Tests de updates
	@Test
	def void seAgrega1ServicioValidoSeReemplazaId1ConOtro() {
		servicioCatering.setTarifaFija()
		servicioAnimacion.setTarifaPorPersona()
		repoServicio.create(servicioAnimacion)
		servicioCatering.id = 1
		repoServicio.update(servicioCatering)
		Assert.assertTrue(repoServicio.elementos.exists[elemento|elemento == servicioCatering])
	}

	@Test(expected=EventoException)
	def void seAgrega1ServicioValidoSeQuiereReemplazarId3yDaExcepcion() {
		servicioCatering.setTarifaFija()
		servicioAnimacion.setTarifaPorPersona()
		repoServicio.create(servicioAnimacion)
		servicioCatering.id = 3
		repoServicio.update(servicioCatering)
	}

}
