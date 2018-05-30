package testsJsons

import jsons.JsonServicio
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import repositorio.RepositorioServicios
import org.junit.Before
import static org.mockito.Mockito.*
import org.uqbar.updateService.UpdateService

@Accessors
class TestJsonServicioUpdatesMock {

	RepositorioServicios repoDeServicios
	RepositorioServicios repoServicioJson
	String jsonText
	String jsonText2
	JsonServicio jsonServicio

	@Before
	def void init() {
		jsonText = '''[
		   {
		      "descripcion":"Catering Food Party",
		      "tarifaServicio":{
		         "tipo":"TPH",
		         "valor":2000.00,
		         "minimo":3500.00
		      },
		      "tarifaTraslado":30.00,
		      "ubicacion":{
		         "x":-34.572224,
		         "y":58.535651
		      }
		   }
		]'''

		jsonText2 = '''[
		   {
		      "descripcion":"Catering Food Party",
		      "tarifaServicio":{
		         "tipo":"TF",
		         "valor":5000.00
		      },
		      "tarifaTraslado":30.00,
		      "ubicacion":{
		         "x":-34.572224,
		         "y":58.535651
		      }
		   },
		   {
		      "descripcion":"Food Party",
		      "tarifaServicio":{
		         "tipo":"TPP",
		         "valor":5000.00,
		         "porcentajeParaMinimo":70.00
		      },
		      "tarifaTraslado":30.00,
		      "ubicacion":{
		         "x":-34.572224,
		         "y":58.535651
		      }
		   }
		]'''

	}

	@Test
	def void testJsonServicioUpdateBasico() {
		val updateService = mock(typeof(UpdateService))
		var jsonServicio = new JsonServicio()
		when(updateService.getServiceUpdates()).thenReturn(jsonText);
		var RepositorioServicios repoDeServicios = new RepositorioServicios()
		jsonServicio.deserializarJson(updateService.getServiceUpdates(), repoDeServicios)// no puedo invocar directamente updateAll
		Assert.assertEquals(1, repoDeServicios.elementos.size(), 0)
	}

	@Test
	def void testJsonServicioUpdatesobreelUpdateInicialOtroUpdatecon1queModificaYUnoNuevo() {
		val updateService = mock(typeof(UpdateService))
		var jsonServicio = new JsonServicio()
		var RepositorioServicios repoDeServicios = new RepositorioServicios()
		when(updateService.getServiceUpdates()).thenReturn(jsonText);
		jsonServicio.deserializarJson(updateService.getServiceUpdates(), repoDeServicios)
		when(updateService.getServiceUpdates()).thenReturn(jsonText2);
		jsonServicio.deserializarJson(updateService.getServiceUpdates(), repoDeServicios)
		Assert.assertEquals(2, repoDeServicios.elementos.size(), 0)
		Assert.assertEquals(0.00, repoDeServicios.searchById(1).costoPorHora, 0)
		Assert.assertEquals(5000.00, repoDeServicios.searchById(1).costoFijo, 0)
		Assert.assertEquals(5000.00, repoDeServicios.searchById(2).costoPorPersona, 0)
	}

}
