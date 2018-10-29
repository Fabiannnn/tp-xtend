package repositorio

import eventos.Locacion
import java.util.List
import jsons.JsonLocacion
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@Accessors
//@TransactionalAndObservable
class RepositorioLocaciones extends Repositorio<Locacion> {

	/* Singleton */
	static RepositorioLocaciones repoLocaciones

	def static RepositorioLocaciones getInstance() {
		if (repoLocaciones === null) {
			repoLocaciones = new RepositorioLocaciones
		}
		repoLocaciones
	}

	new() {
		// LOCACIONES ##########################################################################################
		/*val sanMartin1 = new Locacion => [
			nombre = "San Martin 1"
			punto = new Point(10.0, 20.0)
			superficie = 16
		]

		val sanMartin2 = new Locacion => [
			nombre = "San Martin 2"
			punto = new Point(30.0, 40.0)
			superficie = 2.5
		]

		val sanMartin3 = new Locacion => [
			nombre = "San Martin 3"
			punto = new Point(50.0, 60.0)
			superficie = 100
		]

		val salonCompleto = new Locacion => [
			nombre = "Salon Completo"
			punto = new Point(70.0, 80.0)
			superficie = 16
		]

		repoLocaciones.create(sanMartin1)
		repoLocaciones.create(sanMartin2)
		repoLocaciones.create(sanMartin3)
		repoLocaciones.create(salonCompleto)*/
	}

	override void recibirListaActualizacionJson(List<Locacion> locaciones) {
		locaciones.forEach[elemento|actualizarLocacionConJson(elemento)] // ver si pasa a repositorio abstracto
	}

	def actualizarLocacionConJson(Locacion _locacion) { // actualizarEntidadConJSon seria llamado desde repositorio general
		if ((!coordenadasIguales(_locacion.punto))) {
			create(_locacion)
		} else {
			elementos.findFirst(elemento|elemento.distancia(_locacion.punto) == 0).nombre = _locacion.nombre
		}
	}

	def coordenadasIguales(Point unPunto) {
		elementos.exists(elemento|elemento.distancia(unPunto) == 0)
	}

	override updateAll() {
		val JsonLocacion jsonLocacion = new JsonLocacion
		jsonLocacion.deserializarJson(updateService.getLocationUpdates(), this)

	}

}
