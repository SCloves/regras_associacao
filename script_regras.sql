SELECT * FROM pizzaria.pedidos;

ALTER TABLE pizzaria.pedidos DROP numero;
ALTER TABLE pizzaria.pedidos DROP cliente;
ALTER TABLE pizzaria.pedidos DROP telefone;
ALTER TABLE pizzaria.pedidos DROP endereco;
ALTER TABLE pizzaria.pedidos DROP valor_pizza;
ALTER TABLE pizzaria.pedidos DROP valor_entrega;
ALTER TABLE pizzaria.pedidos DROP hora_entrega;


SELECT MIN(data_pedido), MAX(data_pedido) from pizzaria.pedidos;

DELETE FROM pedidos WHERE YEAR(data_pedido) >= 2015;

SELECT DAYNAME(data_pedido) from pedidos

SELECT @@lc_time_names

set lc_time_names = 'pt_BR'

delimiter $$
CREATE FUNCTION GetDiaSemana(data_pedido date) RETURNS VARCHAR(10)
BEGIN
	RETURN DAYNAME(data_pedido);
END
delimiter $$ ;

SELECT data_pedido, GetDiaSemana(data_pedido) from pedidos;

SELECT max(hora_pedido), min(hora_pedido) from pedidos

DELIMITER $$

	CREATE FUNCTION GetPeriodoVenda(hora_pedido time) RETURNS VARCHAR(10)
	BEGIN
		DECLARE periodo VARCHAR(10);
		IF (hora_pedido < '20:00:00') THEN
			set periodo = 'Inicio';
		ELSEIF (hora_pedido >= '20:00:00' AND hora_pedido < '22:00:00') THEN
			set periodo = 'Pico';
		ELSE 
			set periodo = 'Final';
		END IF;

		RETURN periodo;

	END
	
DELIMITER $$;

SELECT hora_pedido, GetPeriodoVenda(hora_pedido) from pedidos;

SELECT valor_borda, valor_refrigerante from pedidos;

DELIMITER $$

CREATE FUNCTION GetBorda(valor_borda FLOAT) RETURNS VARCHAR(10)
BEGIN
	DECLARE borda VARCHAR(10);
	IF (valor_borda > 0) THEN
		SET borda = 'Borda sim';
	ELSE
		SET borda = 'Borda não';
	END IF;
	
	RETURN borda;
END 

DELIMITER $$

DELIMITER $$

CREATE FUNCTION GetRefrigerante(valor_refrigerante FLOAT) RETURNS VARCHAR(20)
BEGIN
	DECLARE refrigerante VARCHAR(20);
	IF (valor_refrigerante > 0) THEN
		SET refrigerante = 'Refrigerante sim';
	ELSE
		SET refrigerante = 'Refrigerante não';
	END IF;
	
	RETURN refrigerante;
END 

DELIMITER $$


SELECT valor_borda, GetBorda(valor_borda),
		valor_refrigerante, GetRefrigerante(valor_refrigerante)
from pedidos;




