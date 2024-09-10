create table if not exists producers (
	p_id serial primary key,
	p_name varchar(30) not null,
	p_surname varchar(30) not null
);


create table if not exists serials (
	s_id serial primary key,
	s_idProducer integer references producers(p_id) not NULL,
	s_name varchar(100) not null,
	s_description text not null,
	s_year integer not null,
	s_rating numeric not null,
	s_seasons integer not null,
	s_state varchar(60) not null,
    s_genre varchar(100) not null,
	s_img varchar(100) not null,
	s_duration varchar(100) not null
);


create table if not exists seasons (
	ss_id serial primary key,
	ss_idSerial integer references serials(s_id) not null,
	ss_name varchar(100) not null,
	ss_num integer not null,
	ss_cntEpisodes integer not null,
	ss_date varchar(100) not null
);

create table if not exists episodes (
	e_id serial primary key,
	e_idSeason integer references seasons(ss_id) not null,
	e_name varchar(100) not null,
	e_num integer not null,
	e_cntEpisodes integer not null,
	e_duration varchar(100) not null,
	e_date varchar(100) not null
);

create table if not exists actors (
	a_id serial primary key,
	a_name varchar(100) not null,
	a_surname varchar(100) not null,
	a_gender varchar(100) not null,
	a_bdate varchar(100) not null
);

create table if not exists serials_actors (
	sa_id serial primary key,
	sa_idSerial integer references serials(s_id) not null,
	sa_idActor integer references actors(a_id) not null
);
create table if not exists favourites(
	f_id serial primary key,
	f_cntSerials integer not null
);

create table if not exists users(
	u_id serial primary key,
	u_idFavourites integer references favourites(f_id) not null,
	u_login varchar(100) not null,
	u_password varchar(100) not null,
	u_role varchar(100) not null,
	u_name varchar(100) not null,
	u_surname varchar(100) not null,
	u_gender varchar(100) not null,
	u_bdate varchar(100) not null
);

create table if not exists serials_users (
	su_id serial primary key,
	su_idSerial integer references serials(s_id) not null,
	su_iduser integer references users(u_id) not null,
	su_lastSeen varchar(100) not null
);

create table if not exists "comments" (
	c_id serial primary key,
	c_idUser integer references users(u_id) not null,
	c_text text not null,
	c_date varchar(100) not null,
	c_idSerial integer references serials(s_id) not null
);

create table if not exists serials_favourites (
	sf_id serial primary key,
	sf_idSerial integer references serials(s_id) not null,
	sf_idFavourite integer references favourites(f_id)
);

create table if not exists statistic(
		st_id serial primary key,
		st_gender_male integer default 0,
		st_gender_female integer default 0,
		st_role_user integer default 0,
		st_role_admin integer default 0,
		st_age_0_18 integer default 0,
		st_age_19_30 integer default 0,
		st_age_31_50 integer default 0,
		st_age_51_100 integer default 0
);
