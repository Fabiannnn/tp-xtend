package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import excepciones.EventoException

@Accessors
class TestsRepositorioLocacion extends FixtureTest {
	String jsonText
	@Test
	def void pruebaDeQueSePuedeAgregarSMSeAgregaAlRepositorioValidando() {
		repoLocacion.create(salon_SM)
		Assert.assertEquals(1, repoLocacion.elementos.size(), 0)
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

	@Test(expected=EventoException)
	def void pruebaQueNoSeValidaDesdeLocacionSalonIncompleto() {
		salon_Incompleto.validar()
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
		Assert.assertEquals(3, repoLocacion.elementos.size(), 0)
	}

	@Test
	def void seAgrega3SalonesValidosyBuscamosPorCadenaArt() {
		repoLocacion.create(salon_SM)
		repoLocacion.create(salon_2)
		repoLocacion.create(salon_3)
		Assert.assertEquals(2, repoLocacion.search("art").size(), 0)
	}

	@Test
	def void seAgrega3SalonesValidosyBuscamosPorId2() {
		repoLocacion.create(salon_SM)
		repoLocacion.create(salon_2)
		repoLocacion.create(salon_3)
		Assert.assertEquals(45.0, repoLocacion.searchById(2).superficie, 0.0)
	}

	@Test
	def void seAgrega3SalonesValidosyborramosSalon2() {
		repoLocacion.create(salon_SM)
		repoLocacion.create(salon_2)
		repoLocacion.create(salon_3)
		repoLocacion.delete(salon_2)
		Assert.assertEquals(2, repoLocacion.elementos.size(), 0)
	}

//Test de update
	@Test
	def void seAgrega2SalonesValidosyReemplazamosElId2PorSalon3() {
		repoLocacion.create(salon_SM)
		repoLocacion.create(salon_2)
		salon_3.id = 2
		repoLocacion.update(salon_3)
		Assert.assertEquals(100, repoLocacion.searchById(2).superficie, 0)
	}

	@Test(expected=EventoException)
	def void seAgrega2SalonesValidosySeQuiereActualizarUnIdQueNoExiste() {
		repoLocacion.create(salon_SM)
		repoLocacion.create(salon_2)
		salon_3.id = 4
		repoLocacion.update(salon_3)
	}
		@Test
	def void seAgrega2SalonesValidosySeActualizaConJson() {
		repoLocacion.create(salon_SM)
		repoLocacion.create(salon_2)
		jsonText = '''[{"x":-34.603759,"y":-58.381586, "nombre":"Salón El Abierto"},{ "x":-34.572224,"y":-58.535651, "nombre":"Estadio Obras" }]'''
		repoLocacion.actualizarLocacion(jsonText)
		Assert.assertEquals(4, repoLocacion.elementos.size(),0)
		
	}
		@Test
	def void seAgrega2SalonesValidosySeActualizaConJsonYSeotroJsonModificado() {
		jsonText = '''[{"x":-34.603759,"y":-58.381586, "nombre":"Salón El Abierto"},{ "x":-34.572224,"y":-58.535651, "nombre":"Estadio Obras" }]'''
		repoLocacion.actualizarLocacion(jsonText)
		jsonText = '''[{"x":-34.603759,"y":-58.388986, "nombre":"Salón El Abierto Otro Lugar"},{ "x":-34.572224,"y":-58.535651, "nombre":"Estadio Obras Modificado" }]'''
		repoLocacion.actualizarLocacion(jsonText)
	Assert.assertEquals("Estadio Obras Modificado", repoLocacion.searchById(2).nombre)
	Assert.assertEquals(3, repoLocacion.elementos.size(),0)
	}
}
