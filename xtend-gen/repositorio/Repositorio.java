package repositorio;

import eventos.Entidad;

/* @Accessors
 */public abstract class Repositorio<T extends Entidad> {
  private /* List<T> */Object elementos /* Skipped initializer because of errors */;
  
  private int proximoId = 1;
  
  private /* UpdateService */Object updateService;
  
  public abstract void updateAll();
  
  public void create(final T elemento) {
    elemento.esValido();
    this.noEstaEnRepositorio(elemento);
    this.asignarId(elemento);
    this.agregarElemento(elemento);
  }
  
  public abstract void recibirListaActualizacionJson(final /* List<T> */Object _objeto);
  
  public void asignarId(final T elemento) {
    throw new Error("Unresolved compilation problems:"
      + "\n+= cannot be resolved.");
  }
  
  public void agregarElemento(final T elemento) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Repositorio.elementos refers to the missing type List"
      + "\nadd cannot be resolved");
  }
  
  public void delete(final T elemento) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Repositorio.elementos refers to the missing type List"
      + "\nremove cannot be resolved");
  }
  
  public void update(final T _elemento) {
    _elemento.esValido();
    this.existeElId(_elemento);
    this.reemplazarObjectoExistente(_elemento);
  }
  
  public void existeElId(final T _elemento) {
    throw new Error("Unresolved compilation problems:"
      + "\n! cannot be resolved."
      + "\nThe constructor EventoException(String) refers to the missing type String");
  }
  
  public boolean estaEnRepo(final T _elemento) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Repositorio.elementos refers to the missing type List"
      + "\nexists cannot be resolved"
      + "\nid cannot be resolved"
      + "\n== cannot be resolved");
  }
  
  public T searchById(final int _id) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Repositorio.elementos refers to the missing type List"
      + "\nfindFirst cannot be resolved"
      + "\ngetId cannot be resolved"
      + "\n== cannot be resolved");
  }
  
  public void reemplazarObjectoExistente(final T _elemento) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Repositorio.elementos refers to the missing type List"
      + "\nThe field Repositorio.elementos refers to the missing type List"
      + "\nindexOf cannot be resolved"
      + "\nset cannot be resolved");
  }
  
  public /* List<T> */Object search(final /* String */Object value) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method filtroPorTexto(String) is undefined"
      + "\nThe field Repositorio.elementos refers to the missing type List"
      + "\nfilter cannot be resolved"
      + "\ntoList cannot be resolved");
  }
  
  public void noEstaEnRepositorio(final T elemento) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method toString() is undefined for the type T"
      + "\nThe field Repositorio.elementos refers to the missing type List"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\ncontains cannot be resolved"
      + "\n+ cannot be resolved"
      + "\n+ cannot be resolved");
  }
}
