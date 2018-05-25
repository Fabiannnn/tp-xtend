package jsons

import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.JsonValue
import eventos.Entidad
import java.util.List
import repositorio.Repositorio

abstract class JsonsInterface<T extends Entidad> {
	def void deserializarJson(String _json, Repositorio _repositorio) {
		var List<T> elementos = newArrayList
		var JsonArray jsonArray = Json.parse(_json).asArray()
		for (JsonValue elemento : jsonArray) {
			elementos.add(jsonAObjeto(elemento))
		}
		_repositorio.recibirListaActualizacionJson(elementos)
	}

	
	def T jsonAObjeto(JsonValue _Json){
		var  JsonObject jsonObject = _Json.asObject
		jsonAObjetoFinal(jsonObject)//template method
	}
	
	def T jsonAObjetoFinal(JsonObject _Json)//template method
}
