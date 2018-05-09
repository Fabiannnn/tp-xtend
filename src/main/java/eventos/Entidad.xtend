package eventos

interface Entidad {

	def boolean validar()	//TODO esValido

	def int getId()

	def void agregarId(int _nextId)

	def boolean elementoBuscado(String cadena)//TODO cambiar nombre

}
