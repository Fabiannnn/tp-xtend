package eventos

import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Before
import org.junit.Test
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.JsonParser
import com.google.gson.JsonElement
import com.google.gson.JsonObject
import com.google.gson.JsonArray
import java.lang.reflect.Type
import org.junit.Assert

@Accessors
class testgson {
	LocacionBasica locacionbasica
	String jsonText
	String jsonlistalocaciones
	

	@Before
	def void init() {

//		jsonText = '''
//{  
//"x":-34.603759,
//"y":-58.381586,
//"nombre":"Salón El Abierto"
//}
///'''

	} // init()
//
	@Test
	def void lala() {
//
//var Gson g1 = new Gson();
//
//var LocacionBasica locacionbasica = g1.fromJson(jsonText, LocacionBasica)
//
//println(locacionbasica.x)
//println(locacionbasica.y)
//println(locacionbasica.nombre)
//
//println(g1.toJson(locacionbasica))

// ----

//jsonlistalocaciones = '''
//[  
//   {  
//      "x":-34.603759,
//      "y":-58.381586,
//      "nombre":"Salón El Abierto"
//   },
//   {  
//      "x":-34.572224,
//      "y":-58.535651,
//      "nombre":"Estadio Obras"
//   }
//]
//'''
//
//var Gson g2 = new Gson();
//
//var locacionesListType1 = new TypeToken<List<LocacionBasica>>(){}.getType();
//
//var List<LocacionBasica> listalocacionesbasicas1 = g2.fromJson(jsonlistalocaciones, locacionesListType1);  
//
//println(listalocacionesbasicas1.size())
//println(listalocacionesbasicas1)
//
//for (loc : listalocacionesbasicas1){
//	println(loc.x)
//	println(loc.y)
//	println(loc.nombre)
//}

// ---

//var Gson g3 = new Gson();

//var locacionesListType2 = new TypeToken<List<Locacion>>(){}.getType();

//var List<Locacion> listalocaciones2 = g3.fromJson(jsonlistalocaciones, locacionesListType2);
//var LocacionArray[] locacionArray = g3.fromJson(jsonlistalocaciones, locacion); 

//println(listalocaciones2.size())
//println(listalocaciones2)
//
//for (loc : listalocaciones2){
//	println(loc.punto)
////	println(loc.punto.y)
//	println(loc.nombre)
//}

// ---

//var String jsonString = '''
//   {  
//      "x":-34.603759,
//      "y":-58.381586,
//      "nombre":"Salón El Abierto"
//   }
//   '''
//      var JsonParser parser = new JsonParser();  
//      var JsonElement rootNode = parser.parse(jsonString);  
//      
//      if (rootNode.isJsonObject()) { 
//      	
//         var JsonObject details = rootNode.getAsJsonObject(); 
//          
//         var JsonElement xNode = details.get("x"); 
//         println("x " + xNode.getAsDouble());  
//         
//         var JsonElement yNode = details.get("y"); 
//         println("y " + yNode.getAsDouble());  
//         
//		var JsonElement nombreNode = details.get("nombre"); 
//         println("nombre " + nombreNode.getAsString());  
//
////         for (var int i = 0; i < marks.size(); i++) { 
////            JsonPrimitive value = marks.get(i).getAsJsonPrimitive(); 
////            System.out.print(value.getAsInt() + " ");  
//        // } 
//      } 

// ---


var String jsonString = '''
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
]
'''
  
 	var Gson gson = new Gson()
	var Type tipoListaLocacion = new TypeToken<List<LocacionBasica>>(){}.getType()
	var List<LocacionBasica> locacionbasica = gson.fromJson(jsonString, tipoListaLocacion)
	
	for (var int i; i < locacionbasica.size(); i++){
		var LocacionBasica locaciongenerica = locacionbasica.get(i)
		println(locaciongenerica.x)
		println(locaciongenerica.y)
		println(locaciongenerica.nombre)
	}
	
	Assert.assertNotNull(locacionbasica);
	Assert.assertEquals(2, locacionbasica.size());
	var LocacionBasica locacion1 = locacionbasica.get(0);
	var LocacionBasica locacion2 = locacionbasica.get(1);
	
	Assert.assertEquals(-34.603759, locacion1.getX(),0);
	Assert.assertEquals(-58.381586, locacion1.getY(),0);
	Assert.assertEquals("Salón El Abierto", locacion1.getNombre());
	Assert.assertEquals(-34.572224, locacion2.getX(),0);
	Assert.assertEquals(-58.535651, locacion2.getY(),0);
	Assert.assertEquals("Estadio Obras", locacion2.getNombre());


	} // lala()
} // testgson()

@Accessors
class LocacionBasica {
	double x
	double y
	String nombre
}
