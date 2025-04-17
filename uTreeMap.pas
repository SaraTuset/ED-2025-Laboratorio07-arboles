unit uTreeMap;

interface

uses uListaEnlazadaSimple;

type
  tTreeMap = ^tnode;
  tnode = record
    key: integer;
    value: tListaSimple;
    hi, hd: tTreeMap;
  end;

  // Basic methods
  procedure initialize(var a: tTreeMap);
  function is_empty(a: tTreeMap): boolean;
  procedure add(var a: tTreeMap; value: string);
  procedure get(a: tTreeMap; key: integer; var value: tListaSimple);
  function contains(a: tTreeMap; key: integer): boolean;
  procedure remove(var a: tTreeMap; x: integer);
  procedure remove_value(var a: tTreeMap; value: string);

  // Traversal algorithms
  procedure preorder(a: tTreeMap);
  procedure inorder(a: tTreeMap);
  procedure postorder(a: tTreeMap);

  // Other methods
  procedure get_hi(a: tTreeMap; var b: tTreeMap);
  procedure get_hd(a: tTreeMap; var b: tTreeMap);

implementation

uses
  Math;

procedure initialize(var a: tTreeMap);
begin
  a := NIL;
end;

function is_empty(a: tTreeMap): boolean;
begin
  is_empty := a = NIL;
end;

function in_tree(a: tTreeMap; clave: integer): boolean;
begin
  if a = NIL then
    in_tree := FALSE
  else if a^.key < clave then
    in_tree := in_tree(a^.hd, clave)
  else if a^.key > clave then
    in_tree := in_tree(a^.hi, clave)
  else
    in_tree := TRUE;
end;

procedure add(var a: tTreeMap; value: string);
var
  key: Integer;
begin
   key := Length(value);
  if a = NIL then
  begin
    new(a);
    a^.key := key;
    insert_at_end(a^.value, value);
    a^.hi := NIL;
    a^.hd := NIL;
  end
  else if a^.key < key then
    add(a^.hd, value)
  else if a^.key > key then
    add(a^.hi, value)
  else
    insert_at_end(a^.value, value);
end;

procedure get(a: tTreeMap; key: integer; var value: tListaSimple);
begin
  if a <> nil then
     if a^.key = key then
        value := a^.value
     else
     begin
       get(a^.hi, key, value);
       get(a^.hd, key, value);
     end;
end;

function contains(a: tTreeMap; key: integer): boolean;
begin
  if a = NIL then
     contains := False
  else if a^.key < key then
    contains := contains(a^.hd, key)
  else if a^.key > key then
    contains := contains(a^.hi, key)
  else
    contains := True;
end;

procedure remove(var a: tTreeMap; x: integer);
var
  aux, ant: tTreeMap;
begin
  if a <> NIL then
    if a^.key < x then
      remove(a^.hd, x)
    else if a^.key > x then
      remove(a^.hi, x)
    else
    begin
      clear(a^.value);
      aux := a;
      if a^.hi = NIL then
        a := a^.hd
      else if a^.hd = NIL then
        a := a^.hi
      else
      begin
        aux := a^.hi;
        while aux^.hd <> NIL do
        begin
          ant := aux;
          aux := aux^.hd;
        end;
        if a^.hi = aux then
          a^.hi := aux^.hi
        else
          ant^.hd := NIL;
        a^.key := aux^.key;
        a^.value := aux^.value;
      end;
      dispose(aux);
    end;
end;

procedure remove_value(var a: tTreeMap; value: string);
var
  x: Integer;
begin
  x := Length(value);
  if a <> NIL then
    if a^.key < x then
      remove_value(a^.hd, value)
    else if a^.key > x then
      remove_value(a^.hi, value)
    else
    begin
      delete(a^.value, value);
      if uListaEnlazadaSimple.is_empty(a^.value) then
         remove(a, x);
    end;
end;
// Traversal algorithms

procedure visit(x: tListaSimple);
begin
  writeln(to_string(x));
end;

procedure preorder(a: tTreeMap);
begin
  if (a <> NIL) then
  begin
    visit(a^.value);
    preorder(a^.hi);
    preorder(a^.hd);
  end;
end;

procedure inorder(a: tTreeMap);
begin
  if (a <> NIL) then
  begin
    inorder(a^.hi);
    visit(a^.value);
    inorder(a^.hd);
  end;
end;

procedure postorder(a: tTreeMap);
begin
  if (a <> NIL) then
  begin
    postorder(a^.hi);
    postorder(a^.hd);
    visit(a^.value);
  end;
end;

// Other methods

function get_info(a: tTreeMap): string;
begin
  get_info := to_string(a^.value);
end;

procedure get_hi(a: tTreeMap; var b: tTreeMap);
var
  hi: tTreeMap;
begin
  if a = nil then
    b := nil
  else
  begin
    hi := a^.hi;
    new(b);
    b^.key := hi^.key;
    b^.value := hi^.value;
    b^.hi := hi^.hi;
    b^.hd := hi^.hd;
  end;
end;

procedure get_hd(a: tTreeMap; var b: tTreeMap);
var
  hd: tTreeMap;
begin
  if a = nil then
    b := nil
  else
  begin
    hd := a^.hd;
    new(b);
    b^.key := hd^.key;
    b^.value := hd^.value;
    b^.hi := hd^.hi;
    b^.hd := hd^.hd;
  end;
end;


end.
