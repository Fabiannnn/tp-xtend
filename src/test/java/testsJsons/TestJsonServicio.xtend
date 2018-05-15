package testsJsons

import jsons.JsonServicio
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import repositorio.RepositorioServicios


@Accessors
class TestJsonServicio {
	RepositorioServicios repoDeServicios
	RepositorioServicios repoServicioJson
	String jsonText
	String jsonText2
	JsonServicio jsonServicio

	@Test
	def void actualizacionConJsondeServicio() {
		var jsonServicio = new JsonServicio()
		var RepositorioServicios repoDeServicios = new RepositorioServicios()
		jsonText = '''[
		   {
		      "descripcion":"Catering Food Party",
		      "tarifaServicio":{
		         "tipo":"TPH",
		         "valor":5000.00,
		         "minimo":3500.00
		      },
		      "tarifaTraslado":30.00,
		      "ubicacion":{
		         "x":-34.572224,
		         "y":58.535651
		      }
		   }
		]'''
		
		jsonServicio.deserializarJson(jsonText, repoDeServicios)
		
		Assert.assertEquals(1, repoDeServicios.elementos.size(), 0)
	}

	@Test
	def void jsondeServicioCon2Elementos() {
		var jsonServicio = new JsonServicio()
		var RepositorioServicios repoDeServicios = new RepositorioServicios()
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
		
		jsonServicio.deserializarJson(jsonText2, repoDeServicios)

		Assert.assertEquals(2, repoDeServicios.elementos.size(), 0)
	}

	@Test
	def void jsondeServicioCon2ElementosDeIgualDescripcion() {
		var jsonServicio = new JsonServicio()
		var RepositorioServicios repoDeServicios = new RepositorioServicios()
		jsonText2 = '''[
		   {
		      "descripcion":"Food Party",
		      "tarifaServicio":{
		         "tipo":"TF",
		         "valor":3000.00
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
		
		jsonServicio.deserializarJson(jsonText2, repoDeServicios)

		Assert.assertEquals(1, repoDeServicios.elementos.size(), 0)
		Assert.assertEquals(5000.00, repoDeServicios.searchById(1).costoPorPersona, 0)
		Assert.assertEquals(0.00, repoDeServicios.searchById(1).costoFijo, 0)
	}
}
