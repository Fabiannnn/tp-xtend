package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.time.Duration

@Accessors
class Evento {
	String nombre
	LocalDateTime fechaDeInicio
	LocalDateTime fechaFinalizacion

	def long duracion() {
		Duration.between(fechaDeInicio, fechaFinalizacion).getSeconds()
	}

}
