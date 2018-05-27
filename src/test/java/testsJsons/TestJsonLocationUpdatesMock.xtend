package testsJsons

import jsons.JsonLocacion
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import repositorio.RepositorioLocaciones
import static org.mockito.Mockito.*
import org.uqbar.updateService.UpdateService

@Accessors
class TestJsonLocationUpdatesMock {
	String jsonText
	String jsonText2
	RepositorioLocaciones repoLocacionJson

//	UpdateService updateServiceTemp
//	RepositorioLocaciones repoDeLocaciones
//	JsonLocacion jsonLocacion
//	UpdateService UpdateLocationServices
// UpdateService  Mockito(UpdateService.class)
	@Before
	def void init() {

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

		jsonText2 = '''[
		   {
		      "x":-84.603759,
		      "y":-88.388986,
		      "nombre":"Salón El Abierto Otro Lugar"
		   },
		   {
		      "x":-44.603759,
		      "y":-68.381586,
		      "nombre":"Estadio Obras Modificado"
		   }
		]'''
	}

	@Test
	def void testJsonLocacionUpdate() {
		var jsonLocacion = new JsonLocacion()
		val updateServiceTemp = mock(typeof(UpdateService))
		when(updateServiceTemp.getLocationUpdates()).thenReturn(jsonText);
		var RepositorioLocaciones repoDeLocaciones = new RepositorioLocaciones()
		jsonLocacion.deserializarJson(updateServiceTemp.getLocationUpdates(), repoDeLocaciones)
		Assert.assertEquals(2, repoDeLocaciones.elementos.size(), 0)
	}

	@Test
	def void testJsonLocacionUpdate2() {
		var jsonLocacion = new JsonLocacion()
		var RepositorioLocaciones repoDeLocaciones = new RepositorioLocaciones()
		val updateServiceTemp = mock(typeof(UpdateService))
		when(updateServiceTemp.getLocationUpdates()).thenReturn(jsonText);
		jsonLocacion.deserializarJson(updateServiceTemp.getLocationUpdates(), repoDeLocaciones)

		when(updateServiceTemp.getLocationUpdates()).thenReturn(jsonText2);
		jsonLocacion.deserializarJson(updateServiceTemp.getLocationUpdates(), repoDeLocaciones)
		Assert.assertEquals("Estadio Obras Modificado", repoDeLocaciones.searchById(2).nombre)
		Assert.assertEquals(3, repoDeLocaciones.elementos.size(), 0)
	}

}
