CREATE DATABASE question1;
USE question1;

CREATE TABLE IF NOT EXISTS funcionario(
	cod_fun INTEGER PRIMARY KEY NOT NULL,
    nome VARCHAR(20) NOT NULL,
    depto CHAR(2),
    funcao CHAR(20),
    salario DECIMAL(10,2)
);

SELECT * FROM funcionario WHERE deptp = 'Vendas';