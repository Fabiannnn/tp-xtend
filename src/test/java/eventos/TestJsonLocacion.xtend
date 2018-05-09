package eventos

import org.junit.Test
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Before
import org.junit.Assert
import repositorio.RepositorioLocacion

@Accessors
class TestJsonLocacion {
	RepositorioLocacion repoLocacion
	String jsonText

	@Before
	def void init() {
		repoLocacion = new RepositorioLocacion()
	}

	@Test
	def void seAgrega2SalonesValidosySeActualizaConJsonYSeVerificaQueNoVuelvaACargarIgualJson() {
		jsonText = '''[{"x":-34.603759,"y":-58.381586, "nombre":"Salón El Abierto"},{ "x":-34.572224,"y":-58.535651, "nombre":"Estadio Obras" }]'''
		repoLocacion.actualizarLocacion(jsonText)
		repoLocacion.actualizarLocacion(jsonText)
	Assert.assertEquals("Estadio Obras", repoLocacion.searchById(2).nombre)
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
