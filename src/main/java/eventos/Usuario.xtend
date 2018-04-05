package eventos

import java.time.LocalDate
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Set
import java.time.Period

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
	Set<Entrada> entradaComprada = newHashSet
			LocalDate today = LocalDate.now();
	
	new(String unNombreYApellido, String unEMail, LocalDate unaFechaDeNacimiento, String unaDireccion,
		Point unaCoordenada) {
		this.nombreYApellido = unNombreYApellido
		this.eMail = unEMail
		this.fechaDeNacimiento = unaFechaDeNacimiento
		this.direccion = unaDireccion
		this.coordenadasDireccion = unaCoordenada

	}
	def edad(){
		Period.between(fechaDeNacimiento, today).getYears
	}
	def recibirInvitacion(Invitacion invitacion) {
		this.invitaciones.add(invitacion)
	}

	def recibirMensaje(String string) {
		this.mensajesInvitaciones.add(string)
	}

	def rechazarInvitacion(Invitacion invitacion) {
		if (this.equals(invitacion.unUsuario) && invitacion.unEventoCerrado.fechaAnteriorALaLimite())
			invitacion.rechazar()
	}

	def aceptarInvitacion(Invitacion invitacion, int cantidadAcompañantes) {
		if (this.equals(invitacion.unUsuario) && (invitacion.cantidadDeAcompañantes >= cantidadAcompañantes)  && invitacion.unEventoCerrado.fechaAnteriorALaLimite())
			invitacion.aceptar(cantidadAcompañantes)
	}
	def devolverEntrada(Entrada entrada){
		
	}
		

}
