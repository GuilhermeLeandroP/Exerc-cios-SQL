USE treinamento

--LISTA 7 

--PARTE A)Excluindo todos os pedidos que forem menores que R$ 1.000,00, que n�o possuam itens cadastrados e que sejam no m�s de junho/2003;				DELETE FROM REQUEST 		WHERE VLTOTAL < 1000 AND 		CDREQUEST NOT IN (SELECT CDREQUEST FROM PRODUCT) AND		MONTH(DTREQUEST) = 6 AND YEAR(DTREQUEST) = 2003--PARTE B) Atualizando o pre�o do produto como sendo a m�dia dos valores unit�rios de venda, somente para produtos que venderam menos que 800 unidades;				UPDATE PRODUCT SET VLPRICE = (SELECT AVG(VLUNITARY) FROM PRODUCTREQUEST WHERE CDPRODUCT = PRODUCT.CDPRODUCT) WHERE QTSTOCK < 800--PARTE C)Inserindo os fornecedores como clientes. Utilize como c�digo o valor m�ximo mais o c�digo do fornecedor para gerar o c�digo do novo cliente criado a partir do fornecedor;		UPDATE PRODUCT 		SET VLPRICE = (SELECT AVG(VLUNITARY) 		FROM PRODUCTREQUEST 		WHERE CDPRODUCT = PRODUCT.CDPRODUCT)		WHERE QTSTOCK < 800--PARTE D)Atualizando a data de entrega do pedido como sendo a data do pedido + 30 dias para pedidos em que a diferen�a entre essas duas datas seja menor que 10 dias e o cliente tenha comprado menos que R$ 10.000,00.		UPDATE REQUEST
		SET DTDELIVER=DATEADD(DAY,30,DTDELIVER)
		WHERE DATEDIFF(DAY, DTREQUEST, DTDELIVER) < 10 AND VLTOTAL < 10000
		