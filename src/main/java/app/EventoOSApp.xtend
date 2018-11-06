package app

import controller.AgendaController
import controller.OrganizarEventosController
import controller.PerfilController
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.xtrest.api.XTRest
import controller.EventoController
import org.uqbar.commons.model.application.Application
import org.uqbar.commons.model.Entity
import bootstrap.Bootstrap

@Accessors
class EventoOSApp {

	new() {
	}

	def static void main(String[] args) {

		val Bootstrap bootstrap = new Bootstrap
		bootstrap.run()

		// FP Agregamos EventoController
		XTRest.start(9000, PerfilController, AgendaController, OrganizarEventosController, EventoController)
	}

}
