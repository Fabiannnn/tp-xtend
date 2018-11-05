package app

import controller.AgendaController
import controller.PerfilController
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.xtrest.api.XTRest
import controller.EventoController

@Accessors
class EventoOSApp {

	def static void main(String[] args) {
		// FP Agregamos EventoController
		XTRest.start(9000, PerfilController, AgendaController, EventoController)
	}

}
