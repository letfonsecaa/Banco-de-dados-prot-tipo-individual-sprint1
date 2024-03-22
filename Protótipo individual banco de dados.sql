drop database Windas;

create database Windas ;
use Windas;
    
#Usuário do sistema
create table hotel
(
    idHotel int auto_increment primary key,
    nomeFantasia varchar(100) not null,
    cnpj char (14) not null,
    proprietario varchar(60) not null,
    cidade varchar(60) not null,
    bairro varchar(60) not null,
    numero varchar(20) not null,
    cep char(9) not null
);


#SistemaWindas em si, equipamento que engloba 3 sensores e será acoplado na janela do cliente
create table sistemaWindas
(
	idSistemaWindas int auto_increment primary key,
    nome varchar(60),
    hotel int,
    localizacao varchar(60),
    foreign key (hotel) references hotel(idHotel)
);

#Sensores de umidade/temperatura e bloqueio
create table sensor 
(
	idSensor int auto_increment primary key,
    tipo varchar(50) check (tipo in ('umidade','temperatura', 'proximidade')),
    posicao varchar(50) check (posicao in ('interno', 'externo')),
    sistemaPertence int,
    foreign key (sistemaPertence) references sistemaWindas(idSistemaWindas)
);

#Registro dos dados coletados pelos sensores de umidade e temperatura
create table leituraTemperaturaUmidade
(
	idLeitura				int auto_increment	primary key,
	idSensor				int,
	temperatura				float not null,
	umidade					float not null,
	dataHora 				datetime not null,
	chovendo				varchar(40) not null,
	foreign key (idSensor) references sensor(idSensor)
);

#Dados coletados pelo sensor de bloqueio
create table proximidade(
	idproximidade	int auto_increment primary key,
	idSensor		int,
	statusjanela varchar(50) check (statusjanela in ('aberta','fechada')),
	foreign key (idSensor) references sensor(idSensor)
);

-- Inserir um hotel
INSERT INTO hotel (nomeFantasia, cnpj, proprietario, cidade, bairro, numero, cep) 
VALUES ('Hotel XYZ', '12345678901234', 'João Silva', 'São Paulo', 'Centro', '123', '01234-567');

-- Inserir um sistema Windas em um hotel específico
INSERT INTO sistemaWindas (nome, hotel, localizacao) 
VALUES ('Sistema Windas 1', 1, 'Janela 1');

-- Inserir sensores para o sistema Windas
INSERT INTO sensor (tipo, posicao, sistemaPertence) 
VALUES ('umidade', 'interno', 1),
       ('temperatura', 'interno', 1),
       ('proximidade', 'externo', 1);

-- Inserir leitura de temperatura e umidade
INSERT INTO leituraTemperaturaUmidade (idSensor, temperatura, umidade, dataHora, chovendo) 
VALUES (1, 25.5, 50.0, '2024-03-22 10:00:00', 'Não');

-- Inserir leitura de proximidade (sensor de bloqueio)
INSERT INTO proximidade (idSensor, statusjanela) 
VALUES (3, 'fechada');

-- Selecionar todos os hotéis
SELECT * FROM hotel;

-- Selecionar todos os sistemas Windas
SELECT * FROM sistemaWindas;

-- Selecionar todos os sensores pertencentes ao sistema Windas com ID 1
SELECT * FROM sensor WHERE sistemaPertence = 1;

-- Selecionar todas as leituras de temperatura e umidade
SELECT * FROM leituraTemperaturaUmidade;

-- Selecionar todas as leituras de proximidade (sensores de bloqueio)
SELECT * FROM proximidade;