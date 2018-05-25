package repositorio

import eventos.Locacion
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class RepositorioLocaciones extends Repositorio<Locacion> {

	override void recibirListaActualizacionJson(List<Locacion> locaciones) {
		locaciones.forEach[elemento|actualizarLocacionConJson(elemento)]// ver si pasa a repositorio abstracto
	}

	def actualizarLocacionConJson(Locacion _locacion) {// actualizarEntidadConJSon seria llamado desde repositorio general
		if ((!coordenadasIguales(_locacion.punto))) {
			create(_locacion)
		} else {
			elementos.findFirst(elemento|elemento.distancia(_locacion.punto) == 0).nombre = _locacion.nombre
		}
	}

	def coordenadasIguales(Point unPunto) {
		elementos.exists(elemento|elemento.distancia(unPunto) == 0)
	}
}
