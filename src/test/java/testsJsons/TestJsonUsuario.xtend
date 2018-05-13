package testsJsons

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import repositorio.RepositorioUsuarios
import jsons.JsonUsuario

@Accessors

class TestJsonUsuario {
	String jsonText
	RepositorioUsuarios repoUsuariosJson
	RepositorioUsuarios repoDeUsuarios
	JsonUsuario jsonUsuario

	@Test
	def void seActualizaConJsonUsuario1Usuario() {
		jsonText = '''[{"nombreUsuario":"lucas_capo","nombreApellido":"Lucas Lopez","email":"lucas_93@hotmail.com","fechaNacimiento":"15/01/1993","direccion":{"calle":"25 de Mayo","numero":3918,"localidad":"San Martín","provincia":"Buenos Aires","coordenadas":{"x":-34.572224,"y":58.535651}}},]'''
		var jsonUsuario = new JsonUsuario()
		var RepositorioUsuarios repoDeUsuarios = new RepositorioUsuarios()
		jsonUsuario.deserializarJson(jsonText, repoDeUsuarios)
		jsonUsuario.deserializarJson(jsonText, repoDeUsuarios)
		Assert.assertEquals(1, repoDeUsuarios.elementos.size(), 0)
	}
}