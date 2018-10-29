package app

import org.eclipse.xtend.lib.annotations.Accessors
import repositorio.RepositorioUsuarios
import eventos.Usuario
import java.time.LocalDate
import org.uqbar.geodds.Point
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext
import eventos.Locacion
import repositorio.RepositorioLocaciones
import repositorio.RepositorioServicios
import servicios.Servicio

@Accessors
class DatosIniciales {

	new() {
	val repoUsuarios= new RepositorioUsuarios
		val usuario1 = new Usuario => [
			nombreUsuario = "Felipe"
			email = "Felipe_Quino@maflada.mfq.mfq"
			nombreApellido = "Felipe no se "
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(40.0, 50.0)
		]

		val usuario2 = new Usuario => [
			nombreUsuario = "Mafalda"
			email = "mafaldita@mafalda.mfq.mfq"
			nombreApellido = "Mario Argentina"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			punto = new Point(45.0, 60.0)
		]

		val usuario3 = new Usuario => [
			nombreUsuario = "Libertad"
			email = "libertad_Quino@mafalda.mfq.mfq"
			nombreApellido = "Libertad Gomez"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			punto = new Point(34.0, 45.0)
			esAntisocial = false
		]

		val usuario4 = new Usuario => [
			nombreUsuario = "manolito"
			email = "email4"
			nombreApellido = "manolito otro"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(40.0, 50.0)
		]
		val usuario5 = new Usuario => [
			nombreUsuario = "susanita"
			email = "email4"
			nombreApellido = "susanitatro"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(40.0, 50.0)
		]
		val usuario6 = new Usuario => [
			nombreUsuario = "Quino"
			email = "email4"
			nombreApellido = "Perez otro"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(40.0, 50.0)
		]

		usuario1.setUsuarioProfesional()
		usuario2.setUsuarioProfesional()
		usuario3.setUsuarioProfesional()
		usuario4.setUsuarioProfesional()
		usuario5.setUsuarioFree()
		usuario6.setUsuarioAmateur()

		usuario1.agregarAmigoALaLista(usuario2)
		usuario1.agregarAmigoALaLista(usuario3)
		usuario1.agregarAmigoALaLista(usuario4)
		usuario1.agregarAmigoALaLista(usuario5)
		usuario1.agregarAmigoALaLista(usuario6)
		usuario2.agregarAmigoALaLista(usuario3)
		usuario2.agregarAmigoALaLista(usuario4)
		repoUsuarios.create(usuario1)
	/* repoUsuarios.create(usuario2)
		repoUsuarios.create(usuario3)
		repoUsuarios.create(usuario4)
		repoUsuarios.create(usuario5)
		repoUsuarios.create(usuario6)*/

	}

}
