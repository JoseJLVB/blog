create database blog;

create table usuarios(
    id serial,
    email varchar(255) not null unique, 
    nombre varchar(255),
    primary key (id)

);

create table post(
    id serial,
    usuario_id integer not null,    
    titulo varchar(255) not null unique,    
    fecha timestamp default now(),
    primary key (id),
    foreign key (usuario_id) references usuarios(id) 

);

create table comentarios(
    id serial,        
    usuario_id integer not null,
    post_id integer not null,
    texto varchar(500),
    fecha timestamp default now(),
    primary key (id),
    foreign key (post_id) references post(id),
    foreign key (usuario_id) references usuarios(id)

);

\copy usuarios from 'usuarios.csv' csv header;

\copy post from 'posts.csv' csv header;

\copy comentarios from 'comentarios.csv' csv header;

select email, u.id, titulo from usuarios u join post p on u.id = p.usuario_id where u.id = 5;

select email, u.id, texto, fecha from usuarios u join comentarios c on u.id = c.usuario_id where u.email != 'usuario06@hotmail.com';

select * from usuarios u left join post p on u.id = p.usuario_id where p.id is null;

select * from post p full outer join comentarios c on p.id = c.post_id;

select distinct u.* from usuarios u inner join post p on u.id = p.usuario_id where p.fecha between '2020-06-01' and '2020-06-30';