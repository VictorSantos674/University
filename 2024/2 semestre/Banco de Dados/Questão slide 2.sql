CREATE DATABASE empresa;
USE empresa;

CREATE TABLE funcionario(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20),
    sexo ENUM('f','m','o'),
    cargo CHAR,
    salario DECIMAL(10,2)
);

CREATE TABLE fornecedor(
	id INT(6) PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20),
    cidade VARCHAR(20),
    produto VARCHAR(10)
);

CREATE TABLE pedido(
	id INT(6) PRIMARY KEY AUTO_INCREMENT,
    id_funcionario INT(6),
    id_cliente INT(6),
    descricao TEXT,
    observacao TEXT,
    cidade VARCHAR(20),
    produto VARCHAR(20),
    data DATE
);

CREATE TABLE cliente(
	id INT(6) PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20),
    sexo ENUM('f','m','o'),
    renda FLOAT,
    cidade VARCHAR(20)
);

-- Quantidade de pedidos por funcionário
SELECT f.nome, COUNT(p.id) AS quantidade_pedidos
FROM funcionario f
JOIN pedido p ON f.id = funcionario
GROUP BY f.nome;

-- Quantidade de clientes por país e cidade (assumindo que 'cidade' representa o país)
SELECT cidade, COUNT(*) AS quantidade_clientes
FROM cliente
GROUP BY cidade;

-- Código do Fornecedor, código da Categoria, média de preço, preço máximo e mínimo
-- (assumindo que a tabela de produtos está faltando e adaptando a consulta)
SELECT f.id AS codigor_fornecedor,
	p.produto AS categoria,
    AVG(p.preco) AS media_preco,
    MAX(p.preco) AS preco_max,
    MIN(p.preco) AS preco_min
FROM fornecedor f
JOIN pedido p ON f.id = p.id_fornecedor
GROUP BY f.id, p.produto;

-- Quantidade de pedidos por ano e mês
SELECT YEAR(data) AS ano, MONTH(data) AS mes, COUNT(*) AS quantidade_pedidos
FROM pedido
GROUP BY YEAR(data), MONTH(data);

-- Quantidade de pedidos feitos por funcionários de 20 à 30 anos
SELECT COUNT(*) AS quantidade_pedidos
FROM pedidos p
JOIN funcionario f ON p.id_funcionario = f.id
WHERE f.idade BETWEEN 20 AND 20;

