package eventos

import java.time.LocalDate
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Set

@Accessors
class Usuario {
	String nombreDeUsuario
	String nombreYApellido
	String eMail
	LocalDate fechaDeNacimiento
	String direccion // es necesario??
	Point coordenadasDireccion
	boolean esAntisocial
	Set<Usuario> amigos
	double radioDeCercania
	Set<Invitacion> invitaciones = newHashSet
	Set<String> mensajesInvitaciones = newHashSet

	new(String unNombreYApellido, String unEMail, LocalDate unaFechaDeNacimiento, String unaDireccion,
		Point unaCoordenada) {
		this.nombreYApellido = unNombreYApellido
		this.eMail = unEMail
		this.fechaDeNacimiento = unaFechaDeNacimiento
		this.direccion = unaDireccion
		this.coordenadasDireccion = unaCoordenada

	}

	def recibirInvitacion(Invitacion invitacion) {
		this.invitaciones.add(invitacion)
	}

	def recibirMensaje(String string) {
		this.mensajesInvitaciones.add(string)
	}

	def rechazarInvitacion(Invitacion invitacion) {
		if (this.equals(invitacion.unUsuario))
			invitacion.rechazar()
	}

	def aceptarInvitacion(Invitacion invitacion, int cantidadAcompañantes) {
		if (this.equals(invitacion.unUsuario) && (invitacion.cantidadDeAcompañantes >= cantidadAcompañantes))
			invitacion.aceptar(cantidadAcompañantes)
	}

}
