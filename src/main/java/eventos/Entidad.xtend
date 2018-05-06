package eventos

import org.eclipse.xtend.lib.annotations.Accessors

interface Entidad {

	def boolean validar()

	def int getId()

	def void agregarId(int _nextId)

	def boolean elementoBuscado(String cadena)

}
