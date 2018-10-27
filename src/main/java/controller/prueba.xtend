package controller

import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import repositorio.RepositorioUsuarios
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Put
import eventos.Usuario
import jsons.JsonUsuario
import org.uqbar.xtrest.api.annotation.Post

class prueba {
	
	val String json = '''
	   {
			   	"nombreUsuario": "Felipe",
			   	"nombreApellido": "Lucas Lopez",
			   	"email": "lucas_93@hotmail.com",
			   	"fechaNacimiento": "15/01/1993",
			   	"direccion": {
			   		"calle": "25 de Mayo",
			   		"numero": 3918,
			   		"localidad": "San Martín",
			   		"provincia": "Buenos Aires",
			   		"coordenadas": {
			   			"x": -34.572224,
			   			"y": 58.535651
			   		}
			   	}
			   }
			   '''

def imprimirBody(@Body String json){
	
println(json.getPropertyValue("fechaNacimiento"))
	
}
	
}