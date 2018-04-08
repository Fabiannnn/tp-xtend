package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import java.time.Period

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


// métodos relacionados con la devolución de entradas
	def devolucionEntrada() {
		
		this.importeDevuelto = determinacionImporteDevolucion()
		this.vigente = false

	}
	//desdelacancelaciondeeventos debe llamarse indicando la entrada
	def devolucionEntradaPorCancelacion(){
		this.importeDevuelto= unEventoAbierto.precioEntrada
		vigente=false
	}

	def double determinacionImporteDevolucion() {
		this.unEventoAbierto.precioEntrada * porcentajeDevolucion() / 100
	}

	def porcentajeDevolucion() {
		if (this.porcentajeDevolucionSinLimite() > 80.0) {
			80.0
		} else {
			this.porcentajeDevolucionSinLimite()
		}
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
