package testsJsons

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import jsons.JsonUsuario
import eventos.FixtureTest

@Accessors
class TestJsonUsuario extends FixtureTest {
	String jsonText
	String jsonText2
	JsonUsuario jsonUsuario

	@Test
	def void seActualizaConJsonUsuario1Usuario() {
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
		jsonUsuario.deserializarJson(jsonText, repoUsuario)

		Assert.assertEquals(1, repoUsuario.elementos.size(), 0)
	}

	@Test
	def void seActualizaConJsonUsuario2Usuarios() {
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
		jsonUsuario.deserializarJson(jsonText, repoUsuario)

		Assert.assertEquals(2, repoUsuario.elementos.size(), 0)
	}

	@Test
	def void seActualizaConJsonUsuario2UsuariosYseAplicaotroJsoncon2usuariosUnoexistenteQueSeModificaYOtroNOExistente() {
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
		jsonUsuario.deserializarJson(jsonText, repoUsuario)
		jsonUsuario.deserializarJson(jsonText2, repoUsuario)

		Assert.assertEquals(3, repoUsuario.elementos.size(), 0)
		Assert.assertEquals("Lucas Lopez", repoUsuario.searchById(1).nombreApellido)
		Assert.assertEquals("Lucas Otro", repoUsuario.searchById(2).nombreApellido)
		Assert.assertEquals("Lucas Perez", repoUsuario.searchById(3).nombreApellido)
	}

	// test con Json aplicado sobre repositorio con datos existentes
	@Test
	def void seAgrega3UsuariosValidosySeAplicaJsonDe2() {
		var jsonUsuario = new JsonUsuario()
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		usuario3.nombreUsuario = "MariGomez"
		repoUsuario.create(usuario3)
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

		jsonUsuario.deserializarJson(jsonText2, repoUsuario)

		Assert.assertEquals(5, repoUsuario.elementos.size(), 0)
	}

	@Test
	def void seAgrega2UsuariosValidosyAplicamosActualizJson2UnoExistente() {
		var jsonUsuario = new JsonUsuario()
		repoUsuario.create(usuario1)
		usuario3.nombreUsuario = "MariGomez"
		repoUsuario.create(usuario3)
		jsonText2 = '''[
		   {
		      "nombreUsuario":"MariGomez",
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

		jsonUsuario.deserializarJson(jsonText2, repoUsuario)

		Assert.assertEquals(3, repoUsuario.elementos.size(), 0)
		Assert.assertEquals("Diego Maradona", repoUsuario.searchById(2).nombreApellido)
	}
}
