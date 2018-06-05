package servicios

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ServicioMultiple extends TipoDeServicio {
	
	val descuento = 0d
	List<Servicio> serviciosMultiples = newArrayList
	
	override double costoDeTraslado(Servicio servicio) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
		// fijar como hace calcula el costo de traslado
	}
	
	override double costoTotal(Servicio servicio) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
		// fijar como recolecta el costo de cada servicio asociado 
		// suma el costo de traslado mas el costo total con el descuento aplicado
	}
	
	def double aplicarDescuento(Servicio servicio) {
		return servicio.costoTotal - (servicio.costoTotal * descuento)
	}
	
	def agregarServicio(Servicio servicio) {
		serviciosMultiples.add(servicio)
	}
	
}