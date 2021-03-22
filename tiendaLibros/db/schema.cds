using {
    cuid,
    managed
} from '@sap/cds/common';


namespace miLibrary;

entity Books : cuid {
    name     : String(111);
    author   : Association to Authors;
    editions : Composition of Editions;
}

entity Authors : cuid {
    name    : localized String(111);
    country : localized String(111);
    books   : Association to many Books
                  on books.author = $self;
}

@cds.autoexpose
entity Editions : cuid {
    year : Integer;
    name : String(50);
}

entity Log : cuid, managed {
    //libroCreado : Association to Books;
    metodo  : String(30);
    libroId : String(111);
    libroNombre : String(111);
}


/*Hacer un evento que capture la creacion, la actualizacion y el borrado
de las entidades libros y autores. After create, Before create (o delete,
o update)

Mostrar el id o algo de la entidad o req.
*/
