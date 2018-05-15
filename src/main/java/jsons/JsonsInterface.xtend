package jsons

import repositorio.Repositorio

interface JsonsInterface {
	def void deserializarJson(String _json, Repositorio _repositorio)
}
