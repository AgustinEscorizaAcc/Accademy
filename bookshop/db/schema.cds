using {
    cuid,
    managed
} from '@sap/cds/common';


namespace miLibrary;

entity Books {
    key ID : Integer;
    name     : String(111);
    author   : Association to Authors;
}

entity Authors : cuid {
    name    : localized String(111);
    country : localized String(111);
    books   : Association to Books;
}