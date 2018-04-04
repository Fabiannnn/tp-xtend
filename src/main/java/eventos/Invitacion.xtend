package eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Invitacion {
	EventoCerrado unEventoCerrado
	Usuario unUsuario
	int cantidadDeAcompañantes

	boolean aceptada = false
	boolean rechazada = false
	int cantidadAcompañantesConfirmados = 0

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
		cantidadDeAcompañantes = unaCantidadDeAcompañantes
	}

//	def invitacionAceptada(Usuario elUsuario, int unaCantidadDeAcompañantesConfirmados) {
//		if (this.unUsuario == elUsuario && unaCantidadDeAcompañantesConfirmados <= cantidadDeAcompañantes) {
//			this.aceptada = true
//			this.cantidadAcompañantesConfirmados = unaCantidadDeAcompañantesConfirmados
//		}
//	}

}
