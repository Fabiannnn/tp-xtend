package testsJsons

import jsons.JsonLocacion
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import repositorio.RepositorioLocaciones
import excepciones.EventoException

@Accessors
class TestJsonLocacion {
	String jsonText
	RepositorioLocaciones repoLocacionJson
	RepositorioLocaciones repoDeLocaciones
	JsonLocacion jsonLocacion

	@Test(expected=EventoException)
	def void seAgrega2SalonesNoValidosySeActualizaConJson() {
		jsonText = '''[
		   {
		      "x":-44.603759,
		      "y":-68.31586,
		      "nombre":"Salón El Abierto"
		   },
		   {
		      "x":-44.603759,
		      "y":-68.381586,
		      "nombre":""
		   }
		]'''

		var jsonLocacion = new JsonLocacion()
		var RepositorioLocaciones repoDeLocaciones = new RepositorioLocaciones()
		jsonLocacion.deserializarJson(jsonText, repoDeLocaciones)
	}

	@Test
	def void seAgrega2SalonesValidosySeActualizaConJsonYSeVerificaQueNoVuelvaACargarIgualJson() {
		jsonText = '''[
		   {
		      "x":-34.603759,
		      "y":-58.381586,
		      "nombre":"Salón El Abierto"
		   },
		   {
		      "x":-44.603759,
		      "y":-68.381586,
		      "nombre":"Estadio Obras"
		   }
		]'''

		var jsonLocacion = new JsonLocacion()
		var RepositorioLocaciones repoDeLocaciones = new RepositorioLocaciones()
		jsonLocacion.deserializarJson(jsonText, repoDeLocaciones)
		jsonLocacion.deserializarJson(jsonText, repoDeLocaciones)
		Assert.assertEquals(2, repoDeLocaciones.elementos.size(), 0)
	}

	@Test
	def void seAgrega2SalonesValidosySeActualizaConJsonYSeotroJsonModificado() {
		var jsonLocacion = new JsonLocacion()
		var RepositorioLocaciones repoDeLocaciones = new RepositorioLocaciones()
		jsonText = '''[
		   {
		      "x":-34.603759,
		      "y":-58.381586,
		      "nombre":"Salón El Abierto"
		   },
		   {
		      "x":-34.572224,
		      "y":-58.535651,
		      "nombre":"Estadio Obras"
		   }
		]'''

		jsonLocacion.deserializarJson(jsonText, repoDeLocaciones)

		jsonText = '''[
		   {
		      "x":-84.603759,
		      "y":-88.388986,
		      "nombre":"Salón El Abierto Otro Lugar"
		   },
		   {
		      "x":-34.572224,
		      "y":-58.535651,
		      "nombre":"Estadio Obras Modificado"
		   }
		]'''

		jsonLocacion.deserializarJson(jsonText, repoDeLocaciones)

		Assert.assertEquals("Estadio Obras Modificado", repoDeLocaciones.searchById(2).nombre)
		Assert.assertEquals(3, repoDeLocaciones.elementos.size(), 0)
	}
}
