using {miLibrary as my} from '../db/schema';

@(path:'/gen')service general @(require:'scope'){

    entity Books    as
        select from my.Books {*};

    entity Authors  as
        select from my.Authors {*};
}
@(path:'/autenticado')service autenticado @(require:'authenticated-user'){

    entity Books    as
        select from my.Books {*};

    entity Authors  as
        select from my.Authors {*};
}
@(path:'/administrador')service administrador @(require:'admin'){

    entity Books    as
        select from my.Books {*};

    entity Authors  as
        select from my.Authors {*};
}