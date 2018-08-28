package eventos


interface Entidad {

	def void esValido()

	def int getId()

	def void agregarId(int _nextId)

	def boolean filtroPorTexto(String cadena)

}
