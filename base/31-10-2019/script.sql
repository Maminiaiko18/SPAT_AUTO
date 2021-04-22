create table consignataire(
  id varchar2(200) primary key,
  val varchar2(500),
  desce varchar2(500)
);

create table typeMvt(
  id varchar2(200) primary key,
  val varchar2(500),
  desce varchar2(500)
);

create table escale(
  id varchar2(200) primary key,
  val varchar2(500),
  desce varchar2(500)
);

create table pays(
  id varchar2(200) primary key,
  val varchar2(500),
  desce varchar2(500)
);

create table quais(
  id varchar2(200) primary key,
  val varchar2(500),
  desce varchar2(500)
);

create table postedestinataire(
  id varchar2(200) primary key,
  quai varchar2(500),
  interne varchar2(500),
  pays varchar2(500),
  longueur float(32),
  profondeur float(32),
  tirant float(32),
  foreign key(quai) references quais(id),
  foreign key(pays) references pays(id)
);

create table navire(
  id varchar2(500) primary key,
  reference varchar2(500),
  nom varchar2(500),
  pavillon varchar2(500),
  jnt float(32),
  jbt float(32),
  plt float(32),
  lht float(32),
  lm float(32),
  te float(32),
  volume float(32),
  remarque varchar2(500),
  foreign key(pavillon) references pays(id)
);

create table mouvement(
  id varchar2(500) primary key,
  daty date,
  escale varchar2(500),
  navire varchar2(500),
  consignataire varchar2(500),
  dateArrivee date,
  heure varchar2(500),
  provenance varchar2(500),
  destination varchar2(500),
  remarque varchar2(500),
  duree float(32),
  typeMvt varchar2(500),
  etat integer,
  foreign key(escale) references escale(id),
  foreign key(navire) references navire(id),
  foreign key(consignataire) references consignataire(id),
  foreign key(provenance) references postedestinataire(id),
  foreign key(destination) references postedestinataire(id),
  foreign key(typeMvt) references typeMvt(id)
);