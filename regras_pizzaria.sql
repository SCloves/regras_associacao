
SELECT GetDiaSemana(data_pedido) as dia,
		GetPeriodoVenda(hora_pedido) as periodo,
		tipo_entrega,
		GetBorda(valor_borda) as borda,
		GetRefrigerante(valor_refrigerante) as refrigerante,
		GetFaixaValor(valor_total) as valor_total,
		GetFaixaTempo(minute(tempo)) as tempo
from pedidos;