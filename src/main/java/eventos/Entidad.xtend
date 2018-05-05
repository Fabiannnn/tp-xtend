package eventos
import org.eclipse.xtend.lib.annotations.Accessors

interface Entidad {
	def void agregarId(int _nextId)
	def boolean validar()
	def int getId()
	def boolean elementoBuscado(String cadena)
}
