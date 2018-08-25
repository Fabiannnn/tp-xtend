package repositorio

import java.util.List
import jsons.JsonServicio
import org.eclipse.xtend.lib.annotations.Accessors
import servicios.Servicio
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class RepositorioServicios extends Repositorio<Servicio> {

	def descripcionesIguales(String unaDescripcion) {
		elementos.exists(elemento|elemento.descripcion.contentEquals(unaDescripcion))
	}

	def actualizarElementoJson(Servicio _servicios) {
		if (descripcionesIguales(_servicios.descripcion)) {
			var int idAux
			idAux = elementos.findFirst(elemento|elemento.descripcion.contentEquals(_servicios.descripcion)).id
			_servicios.id = idAux
			update(_servicios)

		} else {
			this.create(_servicios)

		}
	}

	override void recibirListaActualizacionJson(List<Servicio> servicios) {
		servicios.forEach[elemento|actualizarElementoJson(elemento)]
	}

	override updateAll() {
		val JsonServicio jsonServicio = new JsonServicio
		jsonServicio.deserializarJson(updateService.getServiceUpdates(), this)

	}

}
