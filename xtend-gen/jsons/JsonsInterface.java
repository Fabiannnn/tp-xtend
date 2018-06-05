package jsons;

import eventos.Entidad;
import repositorio.Repositorio;

public abstract class JsonsInterface<T extends Entidad> {
  public void deserializarJson(final /* String */Object _json, final Repositorio _repositorio) {
    throw new Error("Unresolved compilation problems:"
      + "\nList cannot be resolved to a type."
      + "\nJsonArray cannot be resolved to a type."
      + "\nJsonValue cannot be resolved to a type."
      + "\nThe method or field newArrayList is undefined"
      + "\nThe method or field Json is undefined"
      + "\nThe method jsonAObjeto(JsonValue) from the type JsonsInterface refers to the missing type JsonValue"
      + "\nThe method recibirListaActualizacionJson(List) from the type Repositorio refers to the missing type List"
      + "\nparse cannot be resolved"
      + "\nasArray cannot be resolved"
      + "\nadd cannot be resolved");
  }
  
  public T jsonAObjeto(final /* JsonValue */Object _Json) {
    throw new Error("Unresolved compilation problems:"
      + "\nJsonObject cannot be resolved to a type."
      + "\nThe method jsonAObjetoFinal(JsonObject) from the type JsonsInterface refers to the missing type JsonObject"
      + "\nasObject cannot be resolved");
  }
  
  public abstract T jsonAObjetoFinal(final /* JsonObject */Object _Json);
}
