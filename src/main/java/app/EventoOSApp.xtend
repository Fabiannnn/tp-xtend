package app

import org.uqbar.xtrest.api.XTRest
import controller.PerfilController

class EventoOSApp {

	def static void main(String[] args) {
		XTRest.start(9000, PerfilController)
	}

}
