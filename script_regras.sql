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

SELECT valor_total from pedidos;

delimiter $$
create function GetFaixaValor(valor_total float) returns varchar (10)
begin
  declare faixa varchar(10);
  if (valor_total >= 10 and valor_total < 14) then
    set faixa = '10-14';
  elseif (valor_total >= 14 and valor_total < 18) then
    set faixa = '14-18';
  elseif (valor_total >= 18 and valor_total < 22) then
    set faixa = '18-22';
  elseif (valor_total >= 22 and valor_total < 26) then
    set faixa = '22-26';
  elseif (valor_total >= 26 and valor_total < 30) then
    set faixa = '26-30';
  elseif (valor_total >= 30 and valor_total < 34) then
    set faixa = '30-34';
  elseif (valor_total >= 34 and valor_total < 38) then
    set faixa = '34-38';
  elseif (valor_total >= 38 and valor_total < 42) then
    set faixa = '38-42';
  elseif (valor_total >= 42 and valor_total < 46) then
    set faixa = '42-46';
  elseif (valor_total >= 46 and valor_total <= 50) then
    set faixa = '46-50';
  end if;

  return faixa;
end
delimiter $$;

SELECT count(valor_total), GetFaixaValor(valor_total) from pedidos
GROUP BY GetFaixaValor(valor_total);

SELECT MAX(tempo), min(tempo) from pedidos

SELECT MINUTE(tempo) from pedidos

delimiter $$
create function GetFaixaTempo(minutos float) returns varchar (10)
begin
  declare faixa varchar(10);
  if (minutos >= 10 and minutos < 22) then
    set faixa = '10-22';
  elseif (minutos >= 22 and minutos < 33) then
    set faixa = '22-33';
  elseif (minutos >= 33 and minutos < 44) then
    set faixa = '33-44';
  elseif (minutos >= 44 and minutos <= 55) then
    set faixa = '44-55';
  end if;

  return faixa;
end 
delimiter $$;

SELECT tempo,
	GetFaixaTempo(MINUTE(tempo))
from pedidos;





