package eventos

interface Entidad {

	def boolean esValido()

	def int getId()

	def void agregarId(int _nextId)

	def boolean filtroPorTexto(String cadena)

}
