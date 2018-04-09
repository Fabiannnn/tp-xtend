package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import java.time.Period
import java.time.LocalDateTime

@Accessors
class Entrada {
	EventoAbierto unEventoAbierto
	Usuario unUsuario
	boolean vigente = true
	double importeDevuelto = 0

	new(EventoAbierto elEventoAbierto, Usuario elUsuario) {
		unEventoAbierto = elEventoAbierto
		unUsuario = elUsuario
	}

// desdelacancelaciondeeventos debe llamarse indicando la entrada
	def void devolucionEntradaImporteTotal() {
		this.importeDevuelto = unEventoAbierto.precioEntrada
	}

	def void mensajesYDevolucionEntradasPorCancelacion() {
		unUsuario.mensajesGenerales.add("El Evento " + this.unEventoAbierto +
			" fue cancelado. El importe de la entrada le fue devuelto")
		vigente = false
		devolucionEntradaImporteTotal()
	}

	def mensajesPorPostergacion(LocalDateTime nuevaFechaInicio, LocalDateTime nuevaFechaFinalizacion,
		LocalDate NuevaFechaLimiteConfirmacion) {
		this.unUsuario.mensajesGenerales.add(
			"El Evento " + this.unEventoAbierto + " fue Postergado.  Las nueva fechas son, Inicio " + nuevaFechaInicio +
				" Finalizacion: " + nuevaFechaFinalizacion + ", Confirmacion: " + NuevaFechaLimiteConfirmacion +
				". La entrada podrá ser devuelta al 100%")

	}

// métodos relacionados con la devolución de entradas
	def devolucionEntrada() {
		this.vigente = false
		if (unEventoAbierto.postergado == true) {
			devolucionEntradaImporteTotal()
		} else {
			importeDevuelto = determinacionImporteDevolucion()
		}
	}

	def double determinacionImporteDevolucion() { unEventoAbierto.precioEntrada * porcentajeDevolucion() / 100 }

	def porcentajeDevolucion() {
		Math.min(porcentajeDevolucionSinLimite(), 80.0)
	}

	def porcentajeDevolucionSinLimite() {
		if (this.diasHastaEvento() > 0.0) {
			((diasHastaEvento() - 1.0) * 10.0 + 20.0)
		}
	}

	def double diasHastaEvento() {
		(Period.between(LocalDate.now(), LocalDate.from(this.unEventoAbierto.fechaDeInicio))).getDays() as double

	}
}
