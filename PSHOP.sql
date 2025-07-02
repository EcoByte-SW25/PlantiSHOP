create database PSHOP;
-- create user 'Admin'@'127.0.0.1' identified by 'EcoByte.PlantiSHOP--IPN*Cecyt9/6im9*9++NIctJW.FWY';
-- grant all privileges on PSHOP.* to 'Admin'@'127.0.0.1';
-- create user 'Lector'@'127.0.0.1' identified by 'Abcd**12345';
-- grant select on PSHOP.* to 'Lector'@'127.0.0.1';
-- create user 'Crud'@'127.0.0.1' identified by 'PlantiSHOP-+CrUd*+*https:02468.!?';
-- grant insert, select, update, delete on PSHOP.* to 'Crud'@'127.0.0.1';

use PSHOP;
create table Usuario (
	CE varchar(100) not null,
    C1 longtext not null,
    C2 longtext not null,
    N varchar(25) not null,
    AP varchar(15) not null,
    AM varchar(15) not null,
    U varchar(200) not null,
    CV char(10),
    I1 tinyint not null default 5,
    FhN1 datetime,
    I2 tinyint not null default 2,
    FhN2 datetime,
    P boolean not null default false,
    FfS date,
    A float(2) not null default 0.00,
    primary key (CE)
);
create table Jardin (
	Id bigint not null auto_increment,
    CE varchar(100) not null,
    N varchar(25) not null,
    T varchar(2) not null,
    C varchar(250),
    L float(2) not null,
    P tinyint not null,
    primary key (Id),
    foreign key (CE) references Usuario(CE) on update cascade on delete cascade
);
create table Producto (
	Id bigint not null auto_increment,
    CE varchar(100) not null,
    N varchar(80) not null,
    D varchar(800),
    T varchar(2) not null,
    P float(2) not null,
    Img varchar(50) not null,
    Pop bigint not null default 0,
    Cupo mediumint not null default 1,
    primary key (Id),
    foreign key (CE) references Usuario(CE) on update cascade on delete cascade
);
create table Compra (
    Id bigint not null auto_increment,
    V varchar(100) not null,
    C varchar(100) not null,
    NP varchar(80) not null,
    DP varchar(800),
    PP float(2) not null,
    ImgP varchar(50) not null,
    X tinyint not null,
    LP tinyint not null default 0,
    TP float(2) not null default 0.00,
    U varchar(200),
    Fh datetime,
    BMsg boolean default false,
    primary key (Id),
    foreign key (V) references Usuario(CE) on update cascade on delete cascade,
    foreign key (C) references Usuario(CE) on update cascade on delete cascade
);
create table Notificacion (
    Id bigint not null auto_increment,
    V varchar(100) not null,
    C varchar(25) not null,
    APC varchar(15) not null,
    AMC varchar(15) not null,
    N boolean not null,
    P varchar(80) not null,
    LP tinyint,
    TP float(2),
    Fh datetime,
    U varchar(200),
    primary key (Id),
    foreign key (V) references Usuario(CE) on update cascade on delete cascade
);
create table Administracion (
	T varchar(12) not null,
	Ev tinyint not null,
    U tinytext not null,
    Id varchar(100),
    Fh timestamp not null
);

delimiter $
create trigger HalconU1 after insert on Usuario
for each row
begin
	insert into Administracion values ('Usuario',1,current_user(),new.CE,current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconU2 after update on Usuario
for each row
begin
	insert into Administracion values ('Usuario',2,current_user(),new.CE,current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconU3 after delete on Usuario
for each row
begin
	insert into Administracion values ('Usuario',3,current_user(),old.CE,current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconJ1 after insert on Jardin
for each row
begin
	insert into Administracion values ('Jardin',1,current_user(),convert(new.Id,char),current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconJ2 after update on Jardin
for each row
begin
	insert into Administracion values ('Jardin',2,current_user(),convert(new.Id,char),current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconJ3 after delete on Jardin
for each row
begin
	insert into Administracion values ('Jardin',3,current_user(),convert(old.Id,char),current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconP1 after insert on Producto
for each row
begin
	insert into Administracion values ('Producto',1,current_user(),convert(new.Id,char),current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconP2 after update on Producto
for each row
begin
	insert into Administracion values ('Producto',2,current_user(),convert(new.Id,char),current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconP3 after delete on Producto
for each row
begin
	insert into Administracion values ('Producto',3,current_user(),convert(old.Id,char),current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconC1 after insert on Compra
for each row
begin
	insert into Administracion values ('Compra',1,current_user(),convert(new.Id,char),current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconC2 after update on Compra
for each row
begin
	insert into Administracion values ('Compra',2,current_user(),convert(new.Id,char),current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconC3 after delete on Compra
for each row
begin
	insert into Administracion values ('Compra',3,current_user(),convert(old.Id,char),current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconN1 after insert on Notificacion
for each row
begin
	insert into Administracion values ('Notificacion',1,current_user(),convert(new.Id,char),current_timestamp());
end $
delimiter ;
delimiter $
create trigger HalconN3 after delete on Notificacion
for each row
begin
	insert into Administracion values ('Notificacion',3,current_user(),convert(old.Id,char),current_timestamp());
end $
delimiter ;