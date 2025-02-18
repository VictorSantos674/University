-- Criar & Usar o banco de dados
CREATE DATABASE Hotel;
USE Hotel;

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS cliente(
	id_cliente INT PRIMARY KEY,
    nome VARCHAR(50),
	idade INT,
    sexo ENUM('m','f','o'),
    endereco VARCHAR(100),
    renda FLOAT
);

-- Tabela Funcionario
CREATE TABLE IF NOT EXISTS funcionario(
	id_funcionario INT PRIMARY KEY,
    nome VARCHAR(50),
	idade INT,
    sexo ENUM('m','f','o'),
    endereco VARCHAR(100),
    renda FLOAT,
    cargo ENUM('Atendente','Faxineiro','Gestor','Cozinheiro')
);

-- Tabela Quarto
CREATE TABLE IF NOT EXISTS quarto(
	id_quarto INT PRIMARY KEY,
    numero INT,
	andar INT,
    tipo VARCHAR(20),
    id_cli INT,
    entrada DATE,
    saida DATE,
    diaria FLOAT,
    ocupado BOOLEAN,
    FOREIGN KEY (id_cli) REFERENCES cliente(id_cliente)
);

-- Tabela Faxina
CREATE TABLE IF NOT EXISTS faxina(
	id_faxina INT PRIMARY KEY,
    nome VARCHAR(50),
	dia DATE,
    hora TIME,
    id_fun INT,
    id_quarto INT,
    observacao TEXT,
    foreign key(id_fun) REFERENCES funcionario(id_funcionario),
    FOREIGN KEY(id_quarto) REFERENCES quarto(id_quarto)
);

-- Visão Faxina
CREATE VIEW visao_faxina AS 
SELECT
	f.nome AS nome_faxineiro,
    q.numero AS numero_quarto,
    q.andar,
    c.nome AS nome_ocupante
FROM faxina f
INNER JOIN quarto q ON f.id_quarto = q.id_quarto
INNER JOIN cliente c ON q.id_cli = c.id_cliente;

-- Visão Corredores
CREATE VIEW visao_corredores AS 
SELECT
	q.andar,
    SUM(q.diaria) AS receita
FROM quarto q
WHERE q.ocupado=1 GROUP BY q.andar;

-- Visão Funcionario
CREATE VIEW visao_funcionario AS
SELECT
	id_funcionario,
	nome,
    salario,
    cargo
FROM funcionario;

-- Consulta1: salário total por cada cargo de funcionários
select SUM(salario) AS salario_total, cargo 
FROM funcionario 
GROUP BY cargo;

-- Consulta2: quantos quartos estão ocupados por andar
select andar, COUNT(*) AS quartos_ocupados
FROM quarto
WHERE ocupado = 1
GROUP BY andar;

-- Consulta3: quantidade e o valor arrecadado por cada quarto agrupado pelo mês
SELECT YEAR(entrada) AS ano, MONTH(entrada) AS mes, SUM(diaria) AS valor_arrecadado, COUNT(*) AS quantidade_quartos
FROM quarto
where ocupado = 1
group by year(entrada), month(entrada);

-- Consulta4:  renda média dos clientes por sexo
SELECT AVG(salario) AS renda_media, sexo
FROM cliente
GROUP BY sexo;

-- Adicionar tabela 'observação' na tabela cliente
ALTER TABLE cliente ADD COLUMN observacao TEXT;

-- Criando o usuário 'responsavellimpeza'
CREATE USER 'responsavellimpeza'@'%' IDENTIFIED BY 'sua_senha';
GRANT SELECT, INSERT ON Hotel.visao_faxina TO 'responsavellimpeza'@'%';

-- Criando o usuário 'analistacontas'
CREATE USER 'analistacontas'@'%' IDENTIFIED BY 'sua_senha';
GRANT SELECT ON Hotel.visao_corredores to 'analistacontas'@'%';
GRANT SELECT, UPDATE, INSERT ON Hotel.visao_funcionario TO 'analistacontas'@'%';

DROP DATABASE Hotel;
