package jsons

import com.eclipsesource.json.JsonValue
import java.util.List
import repositorio.*

interface JsonsInterface {
	def void deserializarJson(String _json, Repositorio _repositorio)

}
