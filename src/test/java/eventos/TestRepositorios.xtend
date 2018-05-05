package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import excepciones.EventoException

@Accessors
class TestRepositorios extends FixtureTest {
	@Test
	def void pruebaDeQueSePuedeAgregarSMSeAgregaAlRepositorioSinValidar() {
		repoLocacion.elementos.add(salon_SM)
		Assert.assertEquals(1, repoLocacion.sizeElementos(), 0)
	}

	@Test
	def void pruebaDeQueSePuedeAgregarSMSeAgregaAlRepositorioValidando() {
		repoLocacion.create(salon_SM)
		Assert.assertEquals(1, repoLocacion.sizeElementos(), 0)
	}

	@Test
	def void seAgregoSalonSmConId1() {
		repoLocacion.create(salon_SM)
		Assert.assertEquals(1, salon_SM.id, 0)
	}

	@Test(expected=EventoException)
	def void seAgregoSalonSmConId1SeQuiereAgregarDeNUevoYException() {
		repoLocacion.create(salon_SM)
		repoLocacion.create(salon_SM)

	}

	@Test
	def void pruebaQueNoSeValidaDesdeLocacionSalonIncompleto() {
		Assert.assertFalse(salon_Incompleto.validar())
	}

	@Test(expected=EventoException)
	def void pruebaQueNoSePuedeAgregarSalonIncompletoAlRepositorioLocacion() {
		repoLocacion.validarElemento(salon_Incompleto)
	}

	@Test
	def void seAgrega3SalonesValidos() {
		repoLocacion.create(salon_SM)
		repoLocacion.create(salon_2)
		repoLocacion.create(salon_3)
		Assert.assertEquals(3, repoLocacion.sizeElementos(), 0)
	}

	@Test
	def void seAgrega3SalonesValidosyBuscamosPor_art() {
		repoLocacion.create(salon_SM)
		repoLocacion.create(salon_2)
		repoLocacion.create(salon_3)
		Assert.assertEquals(2, repoLocacion.search("art").size(), 0)
	}

	@Test
	def void seAgrega3SalonesValidosyBuscamosPor_id_2() {
		repoLocacion.create(salon_SM)
		repoLocacion.create(salon_2)
		repoLocacion.create(salon_3)
		Assert.assertEquals(45.0, repoLocacion.searchById(2).superficie, 0.0) // ver como comparar objeto
	}

	@Test
	def void seAgrega3SalonesValidosyborramosSalon_2() {
		repoLocacion.create(salon_SM)
		repoLocacion.create(salon_2)
		repoLocacion.create(salon_3)
		repoLocacion.delete(salon_2)
		Assert.assertEquals(2, repoLocacion.sizeElementos(), 0)
	}
}
