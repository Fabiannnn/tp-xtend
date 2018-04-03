package eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Invitacion {
	EventoCerrado unEventoCerrado
	Usuario unUsuario
	int cantidadDeAcompañantes
	boolean aceptado = false
	
	new (EventoCerrado elEventoCerrado, Usuario elUsuario, int laCantidadDeAcompañantes){
		unEventoCerrado = elEventoCerrado
		unUsuario = elUsuario
		cantidadDeAcompañantes = laCantidadDeAcompañantes
		
	}
	/*def int acompañantesMasUno(){
		this.cantidadDeAcompañantes+1
	}*/

	}