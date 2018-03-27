package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.time.Duration

@Accessors
class Evento {
	String nombre
	LocalDateTime fechaDeInicio
	LocalDateTime fechaFinalizacion

	def double duracion() {
		Duration.between(fechaDeInicio, fechaFinalizacion).getSeconds()/3600.0
	}

}
