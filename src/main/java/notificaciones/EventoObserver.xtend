package notificaciones

import eventos.Evento

interface EventoObserver {
		def void notificar (Evento unEvento)
}