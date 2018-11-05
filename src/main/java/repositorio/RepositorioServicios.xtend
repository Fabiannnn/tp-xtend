package repositorio

import java.util.List
import jsons.JsonServicio
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import servicios.Servicio
//import org.uqbar.geodds.Point

@Accessors
@TransactionalAndObservable
class RepositorioServicios extends Repositorio<Servicio> {

	/* Singleton */
	static RepositorioServicios repoServicios

	def static RepositorioServiciosgetInstance() {
		if (repoServicios === null) {
			repoServicios = new RepositorioServicios
		}
		repoServicios
	}


new(){
		// SERVICIOS #########################################################################################
/*
		val servicioCatering = new Servicio => [
			punto = new Point(35, 45)
			descripcion = "Catering"
			costoFijo = 200
			costoPorKm = 2
			costoMinimo = 100
			porcentajeCostoMinimo = 20
		]

		val servicioAnimacion = new Servicio => [
			punto = new Point(35, 45)
			descripcion = "Animacion"
			costoFijo = 300
			costoPorKm = 2
			costoMinimo = 100
			costoPorHora = 1
			costoPorPersona = 400
			porcentajeCostoMinimo = 20
		]

		servicioAnimacion.setTarifaPorHora
		servicioCatering.setTarifaFija

		repoServicios.create(servicioAnimacion)
		repoServicios.create(servicioCatering)
*/	
}




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
