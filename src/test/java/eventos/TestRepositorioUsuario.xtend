package eventos

import excepciones.EventoException
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test

@Accessors
class TestRepositorioUsuario extends FixtureTest {
	@Test
	def void sePuedeAgregarUsuarioValidoyPasaValidacion() {
		repoUsuario.create(usuario1)
		Assert.assertEquals(1, repoUsuario.elementos.size(), 0)
	}

	@Test(expected=EventoException)
	def void noSePuedeAgregarUnSUsuarioSinNombreDeUsuario() {
		repoUsuario.create(usuario3)
	}

	@Test(expected=EventoException)
	def void noSePuedeAgregarUnUsuarioSinNombreApellido() {
		usuario1.nombreApellido = null
		repoUsuario.create(usuario1)
	}

	@Test(expected=EventoException)
	def void noSePuedeAgregarUnUsuarioSinCoordenadas() {
		usuario1.coordenadas = null
		repoUsuario.create(usuario1)
	}

	@Test(expected=EventoException)
	def void noSePuedeAgregarUnUsuarioSinFechaDeNacimiento() {
		usuario1.fechaNacimiento = null
		repoUsuario.create(usuario1)
	}

	@Test(expected=EventoException)
	def void noSePuedeAgregarUnUsuarioSinMail() {
		usuario1.email = null
		repoUsuario.create(usuario1)
	}

	@Test(expected=EventoException)
	def void noSePuedeAgregar2VecesElMismoUsuario() {
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario1)
	}

	@Test
	def void seAgregan2ServiciosValidos() {
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		Assert.assertEquals(2, repoUsuario.elementos.size(), 0)
	}

	@Test
	def void seAgrega3UsuariosValidosyBuscamosPor_artQueNoEsta() {
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		usuario3.nombreUsuario = "MariGomez"
		repoUsuario.create(usuario3)
		Assert.assertEquals(0, repoUsuario.search("art").size(), 0)
	}

	@Test
	def void seAgrega3UsuariosValidosyBuscamosPor_arQueSon2() {
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		usuario3.nombreUsuario = "MariGomez"
		repoUsuario.create(usuario3)
		Assert.assertEquals(2, repoUsuario.search("ar").size(), 0)
	}

	@Test
	def void seAgrega3UsuariosValidosyBuscamosPor_SegundoUsuario() {
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		usuario3.nombreUsuario = "MariGomez"
		repoUsuario.create(usuario3)
		Assert.assertEquals(1, repoUsuario.search("SegundoUsuario").size(), 0)
	}

	@Test
	def void seAgrega3UsuariosValidosyBuscamosPorSegundo() { // para corroborar que solo toma nombre de usuario completo
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		usuario3.nombreUsuario = "MariGomez"
		repoUsuario.create(usuario3)
		Assert.assertEquals(0, repoUsuario.search("Segundo").size(), 0)
	}

	@Test
	def void seAgrega3UsuariosValidosYeliminamos1() {
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		usuario3.nombreUsuario = "MariGomez"
		repoUsuario.create(usuario3)
		repoUsuario.delete(usuario2)
		Assert.assertEquals(2, repoUsuario.elementos.size(), 0)
	}

	@Test
	def void seAgrega2UsuariosValidosyBuscamosPor_id_2() {
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		usuario3.nombreUsuario = "MariGomez"
		repoUsuario.create(usuario3)
		Assert.assertEquals(usuario2, repoUsuario.searchById(2))
	}

	@Test
	def void seAgregan3UsuariosValidosSeBorraElPrimeroNoSeEncuentraId1() {
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		usuario3.nombreUsuario = "MariGomez"
		repoUsuario.create(usuario3)
		repoUsuario.delete(usuario1)
		Assert.assertNull(repoUsuario.searchById(1))
	}

	@Test
	def void seAgregan3UsuariosValidosSeBorraElPrimeroYSeVuelveACrearVerificoId4() {
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		usuario3.nombreUsuario = "MariGomez"
		repoUsuario.create(usuario3)
		repoUsuario.delete(usuario1)
		repoUsuario.create(usuario1)
		Assert.assertEquals(usuario1, repoUsuario.searchById(4))
	}

	// Tests de updates
	@Test
	def void seAgrega1UsuarioValidoSeReemplazaId1ConOtro() {
		repoUsuario.create(usuario1)
		usuario2.id = 1
		repoUsuario.update(usuario2)
		Assert.assertEquals(usuario2, repoUsuario.searchById(1))
	}

	@Test(expected=EventoException)
	def void seAgregas2UsuariosValidoSeQuiereReemplazarId3yDaExcepcion() {
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		usuario3.nombreUsuario = "MariGomez"
		usuario3.id = 4
		repoUsuario.update(usuario3)
	}

}
