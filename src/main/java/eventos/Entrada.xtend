package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import java.time.Period
import java.time.LocalDateTime
import org.uqbar.commons.model.annotations.Observable
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty

@Accessors
@Observable
class Entrada {
	//FP
	@JsonIgnore EventoAbierto unEventoAbierto
	@JsonIgnore Usuario unUsuario
	boolean vigente = true

	new(EventoAbierto elEventoAbierto, Usuario elUsuario) {
		unEventoAbierto = elEventoAbierto
		unUsuario = elUsuario
	}
	
	//FP
	@JsonProperty("unEventoAbierto")
	def nombreDelEvento() {
		unEventoAbierto.nombre
	}
	//FP
	@JsonProperty("unUsuario")
	def nombreDelUsuario() {
		unUsuario.nombreUsuario
	}
	
	def eventoAbierto() {
		return unEventoAbierto
	}

// Metodos para devolucion de entradas,   por cancelación o postergacion
	def void cancelacionDeEvento() {
		unUsuario.agregarMensaje("El Evento " + this.unEventoAbierto +
			" fue cancelado. El importe de la entrada le fue devuelto")
		vigente = false
		devolucionEntradaImporteTotal()
	}

	def void devolucionEntradaImporteTotal() {
		unUsuario.saldoCuenta = unUsuario.saldoCuenta + unEventoAbierto.precioEntrada
	}

	def mensajesPorPostergacion(LocalDateTime nuevaFechaInicio, LocalDateTime nuevaFechaFinalizacion,
		LocalDate NuevaFechaLimiteConfirmacion) {
		unUsuario.agregarMensaje(
			"El Evento " + this.unEventoAbierto + " fue Postergado.  Las nueva fechas son, Inicio " + nuevaFechaInicio +
				" Finalizacion: " + nuevaFechaFinalizacion + ", Confirmacion: " + NuevaFechaLimiteConfirmacion +
				". La entrada podrá ser devuelta al 100%")
	}

// Métodos relacionados con la devolución de entradas generales
	def devolucionEntrada() {
		vigente = false
		if (unEventoAbierto.postergado == true) {
			devolucionEntradaImporteTotal()
		} else {
			unUsuario.saldoCuenta = unUsuario.saldoCuenta + getImporteDevolucion()
		}
	}

	//FP
	@JsonIgnore def double getImporteDevolucion() {
		unEventoAbierto.precioEntrada * porcentajeDevolucion() / 100
	}

	def porcentajeDevolucion() {
		Math.min(porcentajeDevolucionSinLimite(), 80.0)
	}

	def porcentajeDevolucionSinLimite() {
		if (this.diasHastaEvento() > 0.0) {
			((diasHastaEvento() - 1.0) * 10.0 + 20.0)
		}
	}

	def double diasHastaEvento() {
		(Period.between(LocalDate.now(), LocalDate.from(unEventoAbierto.fechaDeInicio))).getDays() as double
	}
}
