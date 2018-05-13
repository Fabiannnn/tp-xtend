package repositorio

import eventos.Locacion
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class RepositorioLocaciones extends Repositorio<Locacion> {

	override void recibirListaActualizacionJson(List<Locacion> locaciones) {
		locaciones.forEach[elemento | actualizarElementoJson(elemento)]
	}
	def actualizarElementoJson(Locacion _locacion){
		if ((coordenadasIguales(_locacion.punto ).size() == 0)) {
			create(_locacion)}
			else{elementos.findFirst(elemento|(elemento.punto.x == _locacion.punto.x) && (elemento.punto.y == _locacion.punto.y)).nombre = _locacion.nombre
	}
	}
	def coordenadasIguales(Point unPunto) {
		elementos.filter(elemento|(elemento.punto.x == unPunto.x) && (elemento.punto.y == unPunto.y))
	}
}