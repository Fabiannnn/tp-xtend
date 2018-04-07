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
	LocalDate today = LocalDate.now()
	TipoUsuario tipoDeUsuario


	new(String unNombreYApellido, String unEMail, LocalDate unaFechaDeNacimiento, String unaDireccion,
		Point unaCoordenada) {
		this.nombreYApellido = unNombreYApellido
		this.eMail = unEMail
		this.fechaDeNacimiento = unaFechaDeNacimiento
		this.direccion = unaDireccion
		this.coordenadasDireccion = unaCoordenada

	}
 //Métodos relacionados con Invitaciones a Eventos Cerrados

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
		if (this.equals(invitacion.unUsuario) && (invitacion.cantidadDeAcompañantes >= cantidadAcompañantes) &&
			invitacion.unEventoCerrado.fechaAnteriorALaLimite()){
			invitacion.aceptar(cantidadAcompañantes)}
	}
 //Métodos relacionados con Entradas  a Eventos Abiertos
 
	def edad() {
		Period.between(fechaDeNacimiento, today).getYears
	}
	
	def devolverEntrada(Entrada entrada){
		if (entrada.unEventoAbierto.fechaAnteriorALaLimite()){
			entrada.devolucionEntrada()
		}
	}

}

@Accessors
abstract class TipoUsuario {
	int cantidadEventosSimultaneos
	int cantidadEventosMensuales
	int cantidadMaximaDeInvitacionesPorEvento
	Set<Evento> eventos = newHashSet

	new(int unaCantidadDeEventosSimultaneos) {
		cantidadEventosSimultaneos = unaCantidadDeEventosSimultaneos
	}

	def organizarEvento() {
	}

	def entregarInvitacion() {
	}
}

@Accessors
class Free extends TipoUsuario {

	new(int unaCantidadDeEventosSimultaneos, int unaCantidadDeEventosMensuales, int unaCantidadMaximaDeInvitaciones) {
		super(1)
		this.cantidadEventosMensuales = 3
		this.cantidadMaximaDeInvitacionesPorEvento = 50
	}

	override organizarEvento() {
	}

	override entregarInvitacion() {
	}

}

@Accessors
class Amateur extends TipoUsuario {
	new(int unaCantidadDeEventosSimultaneos, int unaCantidadMaximaDeInvitaciones) {
		super(5)
		this.cantidadMaximaDeInvitacionesPorEvento = 50
	}

	override organizarEvento() {
	}

	override entregarInvitacion() {
	}

}

@Accessors
class Profesional extends TipoUsuario {
	new(int unaCantidadDeEventosSimultaneos) {
		super(5)
	}

	override organizarEvento() {
	}

	override entregarInvitacion() {
	}
}
