drop table date_personale cascade constraints;
drop table cont_utilizator cascade constraints;
drop table categorie_produse cascade constraints;
drop table licitatii cascade constraints;
drop table lista_oferte cascade constraints;
drop table participare_licitatia cascade constraints;
drop table produse cascade constraints;

/*MOCK DATA is imported from the auxiliar excel attached in the repository*/


create table date_personale (
   id_date_personale integer primary key,
   nume              varchar2(255) not null,
   prenume           varchar2(255) not null,
   data_nasteri      date not null,
   nr_card_bancar    number(16) not null,
   constraint chk_validate_data_nastere check ( data_nasteri > '1 JAN 1950' )
);



create table cont_utilizator (
   id_utilizator     integer primary key,
   id_date_personale integer not null unique,
   nume_utilizator   varchar2(255) not null unique,
   email             varchar2(255) not null,
   parola            varchar2(255) not null,
   data_creeare_cont date not null,
   status_vanzator   number(1),
   constraint chk_valid_status_vanzator check ( status_vanzator = 1
       or status_vanzator = 0 )
);



create table categorie_produse (
   id_categorie_produs integer primary key,
   denumire_categorie  varchar2(100) unique not null
);


/*utilizatorul in tabela licitatii este vanzator*/
/*//status licitatie: 
// 1=activa | 2=incheiata | 3=inactiva | 4=anulata 
//status achitare:
// 1=achitata | 0=neachitata
//status livrare:
//1=in depozit | 2=preluata din depozit | 3=in curs de livrare | 4=livrata la domiciliu | 5=ridicare si verificare de vanzator
//metoda plata:
//1=card | 2= numerar*/

create table licitatii (
   id_licitatie                  integer primary key,
   id_utilizator                 integer,
   data_desfasurare_licitatie    date not null,
   durata_aproximativa_licitatie integer not null,
   conditii_speciale             varchar2(255),
   status_licitatie              number(1),
   status_achitare               number(1),
   status_livrare                number(1),
   metoda_plata                  number(1),
   constraint fk_licitatie_vanzator foreign key ( id_utilizator )
      references cont_utilizator ( id_utilizator )
);

/*//daca utilizatorul nu e vanzator faci flag de validare_produs 1 - adica probleme, */

create table produse (
   id_produs           integer primary key,
   id_categorie_produs integer,
   id_utilizator       integer,
   descriere_produs    varchar2(255),
   pret_pornire        integer not null,
   validare_produs     number(1),
   constraint fk_produs_vanzator foreign key ( id_utilizator )
      references cont_utilizator ( id_utilizator ),
   constraint fk_categorie_produs foreign key ( id_categorie_produs )
      references categorie_produse ( id_categorie_produs )
);



create table participare_licitatii (
   id_licitatie  integer,
   id_utilizator integer,
   constraint fk_licitatie_part foreign key ( id_licitatie )
      references licitatii ( id_licitatie ),
   constraint fk_ofertant_licitatie foreign key ( id_utilizator )
      references cont_utilizator ( id_utilizator ),
   constraint pk_part_lic primary key ( id_licitatie,
                                        id_utilizator )
);

/*aici utilizaotrul este cumparator*/
create table lista_oferte (
   id_oferta          integer primary key,
   id_utilizator      integer,
   id_licitatie       integer,
   id_produs          integer,
   pret_ofertat       number(14,2),
   ora_plasare_oferta varchar2(15) not null,
   status_oferta      integer,
   constraint fk_oferta_licitatie foreign key ( id_licitatie )
      references licitatii ( id_licitatie ),
   constraint fk_oferta_cumparator foreign key ( id_utilizator )
      references cont_utilizator ( id_utilizator ),
   constraint fk_oferta_produs foreign key ( id_produs )
      references produse ( id_produs )
);

prompt done;


/*=======================EXERCITII/FUNCTIONALITATI=================================*/
drop view vw_vanzatori;
drop view vw_cumparatori;
drop view vw_status_licitatii;
drop view vw_oferta_castigatoare;
drop view vw_monitorizare_plata;
drop view vw_monitorizare_livrare;

/*gestionare vw_vanzatori*/
create or replace view vw_vanzatori as
   select *
     from cont_utilizator
    where status_vanzator = 1;

/*gestionare cumparatori*/
create or replace view vw_cumparatori as
   select *
     from cont_utilizator
    where status_vanzator = 0;

/*afisare status licitatie*/
create or replace view vw_status_licitatii as
   select id_licitatie,
          status_licitatie
     from licitatii;

/*gasirea celor mai mari oferte = oferte castigatoare*/
create or replace view vw_oferta_castigatoare as
   select id_produs,
          max(pret_ofertat) as valoare_oferta
     from lista_oferte
    group by id_produs;

/*gasire id oferta cea mai mare(subquery ul) si update la status acele oferte ca fiind castigatoare restul raman pe 0 ca au pierdut*/
select *
  from lista_oferte;

update lista_oferte
   set
   status_oferta = 1
 where id_oferta in (
   select id_oferta
     from lista_oferte
    where id_produs in (
      select id_produs
        from vw_oferta_castigatoare
   )
      and pret_ofertat in (
      select valoare_oferta
        from vw_oferta_castigatoare
   )
);


/*monitorizare plata*/
create or replace view vw_monitorizare_plata as
   select lic.id_licitatie as nr_licitatie,
          lic.id_utilizator as id_vanzator,
          lstoft.id_utilizator as id_cumparator,
          lstoft.pret_ofertat as suma,
          lic.status_achitare as statut_achitare
     from licitatii lic
    inner join lista_oferte lstoft
   on lic.id_licitatie = lstoft.id_licitatie
    where status_oferta = 1;


/*monitorizare livrare*/
create or replace view vw_monitorizare_livrare as
   select lic.id_licitatie as nr_licitatie,
          lic.id_utilizator as id_vanzator,
          lstoft.id_utilizator as id_cumparator,
          lstoft.pret_ofertat as suma,
          lic.status_livrare as statut_livrare
     from licitatii lic
    inner join lista_oferte lstoft
   on lic.id_licitatie = lstoft.id_licitatie
    where status_oferta = 1;