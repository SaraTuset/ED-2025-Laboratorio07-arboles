program OrdenarPilaTest;

uses
  uPilaChar, uBinaryCharSearchTree;

var
  pila: tPilaChars;
  elemento: char;

{ Ejercicio 3 }
procedure mostrar_pila_en_orden(var p: tPilaChars);
var
  a: tBinarySearchTree;
  p_aux: tPilaChars;
begin
  uBinaryCharSearchTree.initialize(a);
  uPilaChar.initialize(p_aux);
  while not isEmpty(p) do   begin
        push(p_aux, peek(p));
        add(a, peek(p));
        pop(p);
  end;
  p := p_aux;
  inorder(a);
end;


begin
  // Inicializar la pila
  uPilaChar.initialize(pila);

  // Agregar elementos desordenados a la pila
  push(pila, 'd');
  push(pila, 'a');
  push(pila, 'c');
  push(pila, 'b');

  // Mostrar pila antes de ordenar
  writeln('Pila antes de ordenar: ', toString(pila));

  mostrar_pila_en_orden(pila);

  // Mostrar pila después de ordenar
  writeln('Pila después de ordenar: ', toString(pila));
end.
