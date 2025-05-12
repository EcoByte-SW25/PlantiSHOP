create database PSHOP;
create user 'Admin'@'' identified by 'EcoByte.PlantiSHOP--IPN*Cecyt9/6im9*9++NIctJW.FWY';
grant all privileges on PSHOP.* to 'Admin'@'';
create user 'Lector'@'' identified by 'Abcd**12345';
grant select on PSHOP.* to 'Lector'@'';
create user 'Crud'@'' identified by 'PlantiSHOP-+CrUd*/https:02468.!?';
grant insert, select, update, delete on PSHOP.* to 'Crud'@'';
use PSHOP;
create table Usuario (
	CE varchar(100) not null,
    C1 varchar(65535) not null,
    C2 varchar(65535) not null,
    N varchar(25) not null,
    AP varchar(15) not null,
    AM varchar(15) not null,
    U longtext not null,
    CV char(10),
    I1 tinyint(1) not null default 5,
    FhN1 datetime,
    I2 tinyint(1) not null default 2,
    FhN2 datetime,
    P boolean not null default false,
    FfS date,
    primary key (CE)
);
create or replace view Usuarios as select * from Usuario;
create table Jardin (
	Id bigint not null auto_increment,
    CE varchar(100) not null,
    N varchar(25) not null,
    T varchar(2) not null,
    C varchar(250),
    L decimal(3,2) not null,
    P tinyint(2) not null,
    primary key (Id),
    foreign key (CE) references Usuario(CE)
);
create or replace view Jardines as select * from Jardin;
create table Producto (
	Id bigint not null auto_increment,
    CE varchar(100) not null,
    N varchar(80) not null,
    D varchar(800),
    T varchar(2) not null,
    P decimal(7,2) not null,
    Img varchar(50) not null,
    Pop bigint not null default 0,
    primary key (Id),
    foreign key (CE) references Usuario(CE)
);
create or replace view Productos as select * from Producto;
create table Compra (
    Id bigint not null auto_increment,
    V varchar(100) not null,
    C varchar(100) not null,
    NP varchar(80) not null,
    DP varchar(800),
    PP decimal(7,2) not null,
    ImgP varchar(50) not null,
    X tinyint(1) not null,
    LP tinyint(3) not null default 0,
    TP decimal(9,2) not null default 0.00,
    U longtext,
    Fh datetime,
    BMsg boolean default false,
    primary key (Id),
    foreign key (V) references Usuario(CE),
    foreign key (C) references Usuario(CE)
);
create or replace view Compras as select * from Compra;
create table Notificacion (
    Id bigint not null auto_increment,
    V varchar(100) not null,
    C varchar(25) not null,
    APC varchar(15) not null,
    AMC varchar(15) not null,
    N boolean not null,
    P varchar(80) not null,
    LP tinyint(3),
    TP decimal(9,2),
    Fh datetime,
    U longtext,
    primary key (Id),
    foreign key (V) references Usuario(CE)
);
create or replace view Notificaciones as select * from Notificacion;
create table Administracion (
	T varchar(12) not null,
	Ev tinyint(1) not null,
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
	insert into Administracion values ('Usuario',3,current_user(),new.CE,current_timestamp());
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
	insert into Administracion values ('Jardin',3,current_user(),convert(new.Id,char),current_timestamp());
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
	insert into Administracion values ('Producto',3,current_user(),convert(new.Id,char),current_timestamp());
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
	insert into Administracion values ('Compra',3,current_user(),convert(new.Id,char),current_timestamp());
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
	insert into Administracion values ('Notificacion',3,current_user(),convert(new.Id,char),current_timestamp());
end $
delimiter ;