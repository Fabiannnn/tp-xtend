package testsJsons

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import static org.mockito.Mockito.*
import org.uqbar.updateService.UpdateService
import repositorio.RepositorioUsuarios
import jsons.JsonUsuario
import eventos.FixtureTest

@Accessors
class TestJsonUsuarioUpdatesMock extends FixtureTest {

	String jsonText
	String jsonText2
	RepositorioUsuarios repoUsuariosJson
	JsonUsuario jsonUsuario

	@Test
	def void testJsonUsuarioUpdateBasico() {
		jsonText = '''[  
		   {  
		      "nombreUsuario":"lucas_capo",
		      "nombreApellido":"Lucas Lopez",
		      "email":"lucas_93@hotmail.com",
		      "fechaNacimiento":"15/01/1993",
		      "direccion":{  
		         "calle":"25 de Mayo",
		         "numero":3918,
		         "localidad":"San Martín",
		         "provincia":"Buenos Aires",
		         "coordenadas":{  
		            "x":-34.572224,
		            "y":58.535651
		         }
		      }
		   }
		]'''

		var jsonUsuario = new JsonUsuario()
		val updateServiceTemp = mock(typeof(UpdateService))
		when(updateServiceTemp.getUserUpdates()).thenReturn(jsonText);
		jsonUsuario.deserializarJson(updateServiceTemp.getUserUpdates(), repoUsuario)
		Assert.assertEquals(1, repoUsuario.elementos.size(), 0)
	}

	@Test
	def void testJsonUsuarioUpdate2Usuarios() {
		jsonText = '''[  
		   {  
		      "nombreUsuario":"lucas_capo",
		      "nombreApellido":"Lucas Lopez",
		      "email":"lucas_93@hotmail.com",
		      "fechaNacimiento":"15/01/1993",
		      "direccion":{  
		         "calle":"25 de Mayo",
		         "numero":3918,
		         "localidad":"San Martín",
		         "provincia":"Buenos Aires",
		         "coordenadas":{  
		            "x":-34.572224,
		            "y":58.535651
		         }
		      }
		   },
		   {  
		      "nombreUsuario":"otro_lucas",
		      "nombreApellido":"Lucas Lopez",
		      "email":"lucas_93@hotmail.com",
		      "fechaNacimiento":"15/01/1993",
		      "direccion":{  
		         "calle":"25 de Mayo",
		         "numero":3918,
		         "localidad":"San Martín",
		         "provincia":"Buenos Aires",
		         "coordenadas":{  
		            "x":-34.572224,
		            "y":58.535651
		         }
		      }
		   }
		]'''
		var jsonUsuario = new JsonUsuario()
		val updateServiceTemp = mock(typeof(UpdateService))
		when(updateServiceTemp.getUserUpdates()).thenReturn(jsonText);
		jsonUsuario.deserializarJson(updateServiceTemp.getUserUpdates(), repoUsuario)
		Assert.assertEquals(2, repoUsuario.elementos.size(), 0)
	}

	@Test
	def void testJsonUsuarioUpdate2UsuariosYSeAplicaOtroJsonConUnoQueModificaYOtroQueAgrega() {
		jsonText = '''[  
		   {  
		      "nombreUsuario":"lucas_capo",
		      "nombreApellido":"Lucas Lopez",
		      "email":"lucas_93@hotmail.com",
		      "fechaNacimiento":"15/01/1993",
		      "direccion":{  
		         "calle":"25 de Mayo",
		         "numero":3918,
		         "localidad":"San Martín",
		         "provincia":"Buenos Aires",
		         "coordenadas":{  
		            "x":-34.572224,
		            "y":58.535651
		         }
		      }
		   },
		   {  
		      "nombreUsuario":"otro_lucas",
		      "nombreApellido":"Lucas Lopez",
		      "email":"lucas_93@hotmail.com",
		      "fechaNacimiento":"15/01/1993",
		      "direccion":{  
		         "calle":"25 de Mayo",
		         "numero":3918,
		         "localidad":"San Martín",
		         "provincia":"Buenos Aires",
		         "coordenadas":{  
		            "x":-34.572224,
		            "y":58.535651
		         }
		      }
		   }
		]'''
		jsonText2 = '''[
		   {
		      "nombreUsuario":"lucas_lucas",
		      "nombreApellido":"Lucas Perez",
		      "email":"lucas_93@hotmail.com",
		      "fechaNacimiento":"15/01/1993",
		      "direccion":{
		         "calle":"25 de Mayo",
		         "numero":3918,
		         "localidad":"San Martín",
		         "provincia":"Buenos Aires",
		         "coordenadas":{
		            "x":-34.572224,
		            "y":58.535651
		         }
		      }
		   },
		   {
		      "nombreUsuario":"otro_lucas",
		      "nombreApellido":"Lucas Otro",
		      "email":"lucas_93@hotmail.com",
		      "fechaNacimiento":"15/01/1993",
		      "direccion":{
		         "calle":"25 de Mayo",
		         "numero":3918,
		         "localidad":"San Martín",
		         "provincia":"Buenos Aires",
		         "coordenadas":{
		            "x":-34.572224,
		            "y":58.535651
		         }
		      }
		   }
		]'''

		var jsonUsuario = new JsonUsuario()
		val updateServiceTemp = mock(typeof(UpdateService))
		when(updateServiceTemp.getUserUpdates()).thenReturn(jsonText);
		jsonUsuario.deserializarJson(updateServiceTemp.getUserUpdates(), repoUsuario)
		when(updateServiceTemp.getUserUpdates()).thenReturn(jsonText2);
		jsonUsuario.deserializarJson(updateServiceTemp.getUserUpdates(), repoUsuario)
		Assert.assertEquals(3, repoUsuario.elementos.size(), 0)
		Assert.assertEquals("Lucas Lopez", repoUsuario.searchById(1).nombreApellido)
		Assert.assertEquals("Lucas Otro", repoUsuario.searchById(2).nombreApellido)
		Assert.assertEquals("Lucas Perez", repoUsuario.searchById(3).nombreApellido)

	}

	@Test
	def void seAgrega2UsuariosValidosySeAplicaJsonDe2UnoQueModificaYOtroQueAgrega() {
		var jsonUsuario = new JsonUsuario()
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)

		jsonText2 = '''[
		   {
		      "nombreUsuario":"PrimerUsuario",
		      "nombreApellido":"Diego Maradona",
		      "email":"lucas_93@hotmail.com",
		      "fechaNacimiento":"15/01/1993",
		      "direccion":{
		         "calle":"25 de Mayo",
		         "numero":3918,
		         "localidad":"San Martín",
		         "provincia":"Buenos Aires",
		         "coordenadas":{
		            "x":-34.572224,
		            "y":58.535651
		         }
		      }
		   },
		   {
		      "nombreUsuario":"otro_lucas",
		      "nombreApellido":"Lucas Otro",
		      "email":"lucas_93@hotmail.com",
		      "fechaNacimiento":"15/01/1993",
		      "direccion":{
		         "calle":"25 de Mayo",
		         "numero":3918,
		         "localidad":"San Martín",
		         "provincia":"Buenos Aires",
		         "coordenadas":{
		            "x":-34.572224,
		            "y":58.535651
		         }
		      }
		   }
		]'''

		val updateServiceTemp = mock(typeof(UpdateService))
		when(updateServiceTemp.getUserUpdates()).thenReturn(jsonText2);
		jsonUsuario.deserializarJson(updateServiceTemp.getUserUpdates(), repoUsuario)

		Assert.assertEquals(3, repoUsuario.elementos.size(), 0)
		Assert.assertEquals("Diego Maradona", repoUsuario.searchById(1).nombreApellido)
		Assert.assertEquals("Lucas Otro", repoUsuario.searchById(3).nombreApellido)

	}

}
