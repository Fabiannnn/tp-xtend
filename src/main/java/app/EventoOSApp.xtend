package app

import org.uqbar.xtrest.api.XTRest
import controller.PerfilController
import controller.AgendaController
import org.eclipse.xtend.lib.annotations.Accessors
import app.DatosIniciales

@Accessors
class EventoOSApp {

	def static void main(String[] args) {


		XTRest.start(9000, PerfilController, AgendaController)
	}

}
