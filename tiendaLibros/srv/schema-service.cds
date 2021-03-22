using {miLibrary as my} from '../db/schema';

service api {

    entity Books    as
        select from my.Books {
            *,
            author.name as author_name
        };

    entity Authors  as
        select from my.Authors {
            *
        };

    entity Editions as
        select from my.Editions {
            *
        };

    entity Log      as
        select from my.Log {
            *
        };
}
