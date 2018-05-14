package testsJsons

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import repositorio.RepositorioUsuarios
import jsons.JsonUsuario

@Accessors
class TestJsonUsuario {
	String jsonText
	String jsonText2
	RepositorioUsuarios repoUsuariosJson
	RepositorioUsuarios repoDeUsuarios
	JsonUsuario jsonUsuario

	@Test
	def void seActualizaConJsonUsuario1Usuario() {
		jsonText = '''[ { "nombreUsuario" : "lucas_capo","nombreApellido":"Lucas Lopez","email":"lucas_93@hotmail.com","fechaNacimiento":"15/01/1993","direccion":{"calle":"25 de Mayo","numero":3918,"localidad":"San Martín","provincia":"Buenos Aires",  "coordenadas":{
								"x":-34.572224,
								"y":58.535651
							}  }}]'''
		var jsonUsuario = new JsonUsuario()
		var RepositorioUsuarios repoDeUsuarios = new RepositorioUsuarios()
		jsonUsuario.deserializarJson(jsonText, repoDeUsuarios)
		Assert.assertEquals(1, repoDeUsuarios.elementos.size(), 0)

	}

	@Test
	def void seActualizaConJsonUsuario2Usuarios() {
		jsonText = '''[{ "nombreUsuario" : "lucas_capo","nombreApellido":"Lucas Lopez","email":"lucas_93@hotmail.com","fechaNacimiento":"15/01/1993","direccion":{"calle":"25 de Mayo","numero":3918,"localidad":"San Martín","provincia":"Buenos Aires",  "coordenadas":{
										"x":-34.572224,
										"y":58.535651
									}  }}, { "nombreUsuario" : "otro_lucas","nombreApellido":"Lucas Lopez","email":"lucas_93@hotmail.com","fechaNacimiento":"15/01/1993","direccion":{"calle":"25 de Mayo","numero":3918,"localidad":"San Martín","provincia":"Buenos Aires",  "coordenadas":{
															"x":-34.572224,
															"y":58.535651
														}  }}]'''
		var jsonUsuario = new JsonUsuario()
		var RepositorioUsuarios repoDeUsuarios = new RepositorioUsuarios()
		jsonUsuario.deserializarJson(jsonText, repoDeUsuarios)
		Assert.assertEquals(2, repoDeUsuarios.elementos.size(), 0)
	}

	@Test
	def void seActualizaConJsonUsuario2UsuariosYseAplicaotroJsoncon2usuariosUnoexistenteQueSeModificaYOtroNOExistente() {
		jsonText ='''[{ "nombreUsuario" : "lucas_capo","nombreApellido":"Lucas Lopez","email":"lucas_93@hotmail.com","fechaNacimiento":"15/01/1993","direccion":{"calle":"25 de Mayo","numero":3918,"localidad":"San Martín","provincia":"Buenos Aires",  "coordenadas":{
										"x":-34.572224,
										"y":58.535651
									}  }}, { "nombreUsuario" : "otro_lucas","nombreApellido":"Lucas Lopez","email":"lucas_93@hotmail.com","fechaNacimiento":"15/01/1993","direccion":{"calle":"25 de Mayo","numero":3918,"localidad":"San Martín","provincia":"Buenos Aires",  "coordenadas":{
															"x":-34.572224,
															"y":58.535651
														}  }}]'''
		jsonText2 = '''[{ "nombreUsuario" : "lucas_lucas","nombreApellido":"Lucas Perez","email":"lucas_93@hotmail.com","fechaNacimiento":"15/01/1993","direccion":{"calle":"25 de Mayo","numero":3918,"localidad":"San Martín","provincia":"Buenos Aires",  "coordenadas":{
										"x":-34.572224,
										"y":58.535651
									}  }}, { "nombreUsuario" : "otro_lucas","nombreApellido":"Lucas Otro","email":"lucas_93@hotmail.com","fechaNacimiento":"15/01/1993","direccion":{"calle":"25 de Mayo","numero":3918,"localidad":"San Martín","provincia":"Buenos Aires",  "coordenadas":{
															"x":-34.572224,
															"y":58.535651
														}  }}]'''
		
		var jsonUsuario = new JsonUsuario()
		var RepositorioUsuarios repoDeUsuarios = new RepositorioUsuarios()
		jsonUsuario.deserializarJson(jsonText, repoDeUsuarios)
		jsonUsuario.deserializarJson(jsonText2, repoDeUsuarios)
		Assert.assertEquals(3, repoDeUsuarios.elementos.size(), 0)
		Assert.assertEquals("Lucas Lopez", repoDeUsuarios.searchById(1).nombreApellido)
		Assert.assertEquals("Lucas Otro", repoDeUsuarios.searchById(2).nombreApellido)
		Assert.assertEquals("Lucas Perez", repoDeUsuarios.searchById(3).nombreApellido)

	}
}
//   