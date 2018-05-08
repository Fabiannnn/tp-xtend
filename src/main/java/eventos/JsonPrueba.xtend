package eventos

import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonValue
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonObject.Member

class JsonPrueba {
	def static void main(String[] reader) {

		var String locaciones = '''
[  
   {  
      "x":-34.603759,
      "y":-58.381586,
      "nombre":"Salón El Abierto"
   },
   {  
      "x":-34.572224,
      "y":-58.535651,
      "nombre":"Estadio Obras"
   }
]'''

		var JsonArray listado = Json.parse(locaciones).asArray()
		println(listado)
		println(listado.get(1))
		println(listado.size())
		

	}
	 
}
