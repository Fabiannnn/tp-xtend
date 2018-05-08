package eventos

import org.junit.Test
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Before
import org.junit.Assert

@Accessors
class TestJsonLocacion {
	RepositorioLocacion repoLocacion
	String jsonText

	@Before
	def void init() {
		repoLocacion = new RepositorioLocacion()
	}

	@Test
	def void seAgrega2SalonesValidosySeActualizaConJson() {
		println(repoLocacion.elementos)
		jsonText = '''[{"x":-34.603759,"y":-58.381586, "nombre":"Salón El Abierto"}]''' //,{ "x":-34.572224,"y":-58.535651, "nombre":"Estadio Obras" }
		repoLocacion.actualizarLocacion(jsonText)
		repoLocacion.actualizarLocacion(jsonText)
		
		println(repoLocacion.elementos.size())
		println(repoLocacion.elementos)

		Assert.assertEquals("Salón El Abierto", repoLocacion.searchById(2).nombre)
	}
}
