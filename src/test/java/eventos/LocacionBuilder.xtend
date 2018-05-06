package eventos

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import excepciones.EventoException

@Accessors
class LocacionBuilder {
	String nombre
	Point punto
	double superficie

	new() {
	}

	def nombre(String _nombre) {
		this.nombre = _nombre
		this
	}

	def punto(Point _punto) {
		this.punto = _punto
		this
	}

	def superficie(double _superficie) {
		this.superficie = _superficie
		this
	}

	def build() {
		if (nombre !== null && punto !== null ) {
			new Locacion() => [
				it.nombre = nombre
				it.punto = punto
				it.superficie = superficie
			]
		} else {
			throw new EventoException("No crear la Locacion")
		}

	}
}
