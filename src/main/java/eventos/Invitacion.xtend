package eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Invitacion {
	EventoCerrado unEventoCerrado
	Usuario unUsuario
	int cantidadDeAcompañantes

	boolean aceptada = false
	boolean rechazada = false
	int cantidadDeAcompañantesConfirmados = 0

	new(EventoCerrado elEventoCerrado, Usuario elUsuario, int laCantidadDeAcompañantes) {
		unEventoCerrado = elEventoCerrado
		unUsuario = elUsuario
		cantidadDeAcompañantes = laCantidadDeAcompañantes

	}

	def rechazar() {
		this.rechazada = true
	}

	def aceptar(int unaCantidadDeAcompañantes) {
		this.aceptada = true
		cantidadDeAcompañantesConfirmados = unaCantidadDeAcompañantes
	}

	def posiblesAsistentes() {
		if (aceptada) {
			(cantidadDeAcompañantesConfirmados + 1)
		} else if (rechazada) {
			0
		} else {
			(cantidadDeAcompañantes + 1)
		}

	}

}
