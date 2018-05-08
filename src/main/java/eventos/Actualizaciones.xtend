package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.Json

@Accessors
class Actualizaciones {
	def actualizarLocacion(String texto){
			var JsonArray listado = Json.parse(texto).asArray()
			listado.forEach[ ]
	}
	}