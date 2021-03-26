using {miLibrary as my} from '../db/schema';

service api @(require:'scope'){

    entity Books    as
        select from my.Books {*};

    entity Authors  as
        select from my.Authors {*};
}

service admin @(require:'scope2'){

    entity Books    as
        select from my.Books {*};

    entity Authors  as
        select from my.Authors {*};
}