USE treinamento

--TÓPICO 1 

--PARTE A)Excluindo todos os clientes que não compraram nada ainda;
		DELETE FROM CUSTOMER
		WHERE CDCUSTOMER NOT IN (SELECT CDCUSTOMER FROM REQUEST)

--PARTE B)Excluindo todos os fornecedores que não forneceram nenhum produto;


		DELETE FROM SUPPLIER
		WHERE CDSUPPLIER NOT IN (SELECT CDSUPPLIER FROM PRODUCT)

--PARTE C)Atualizando o valor de venda pelo preço original do produto;
		UPDATE PRODUCTREQUEST
		SET VLUNITARY = p.VLPRICE
		FROM PRODUCT p
		WHERE PRODUCTREQUEST.CDPRODUCT = p.CDPRODUCT

--PARTE D)Acrescentando a tabela do fornecedor o campo dsstatus (10);

		ALTER TABLE SUPPLIER
		ADD DSSTATUS VARCHAR(10)

		SELECT DSSTATUS FROM SUPPLIER

--PARTE E)Atualizando o status do fornecedor para ‘INATIVO’ nos fornecedores que não forneceram nenhum produto.
		
		UPDATE SUPPLIER
		SET DSSTATUS = 'INATIVO'
		WHERE CDSUPPLIER NOT IN (SELECT CDSUPPLIER FROM PRODUCT)

--PARTE F)Faça o script que atualize o campo endereço do cliente para ‘DESCONHECIDO’ onde o endereço for NULO.


		UPDATE CUSTOMER
		SET NMADRESS = 'DESCONHECIDO'
		WHERE NMADRESS IS NULL

--PARTE G)
		


--TÓPICO 2)

--PARTE A)Todos os produtos comprados por cliente (nome), com o número de vezes que foi comprado, a quantidade total comprada e o valor total já pago por aquele produto;

		SELECT c.NMCUSTOMER, p.NMPRODUCT, COUNT(*) AS QTDCOMPRADO, SUM(qtamount) AS QTDTOTAL, SUM(qtamount * vlunitary) AS VALOR
		FROM CUSTOMER c
		INNER JOIN REQUEST r ON c.CDCUSTOMER = r.CDCUSTOMER
		INNER JOIN PRODUCTREQUEST pr ON r.CDREQUEST = pr.CDREQUEST
		INNER JOIN PRODUCT p ON pr.CDPRODUCT = p.CDPRODUCT
		GROUP BY c.NMCUSTOMER, p.NMPRODUCT
		ORDER BY C.NMCUSTOMER


--PARTE B) O número de pedidos e o total comprado por cliente (nome) no ano de 2003;
		
		SELECT C.NMCUSTOMER, COUNT(PR.CDREQUEST),SUM(PR.QTAMOUNT)
		FROM PRODUCTREQUEST PR
		INNER JOIN REQUEST R ON R.CDREQUEST=PR.CDREQUEST
		INNER JOIN CUSTOMER C ON C.CDCUSTOMER=R.CDCUSTOMER
		WHERE R.DTREQUEST BETWEEN '20030101' AND '20031231'
		GROUP BY C.NMCUSTOMER


--PARTE C)O nome do fornecedor, seu telefone, o nome do produto, seu preço e a quantidade em estoque, o fornecedor deve aparecer mesmo que não tenha nenhum produto;

		SELECT S.NMSUPPLIER,S.IDFONE,P.NMPRODUCT,P.VLPRICE,P.QTSTOCK
		FROM PRODUCT P 
		LEFT JOIN SUPPLIER S ON S.CDSUPPLIER=P.CDSUPPLIER

--PARTE D) O nome do cliente, a data do pedido e o valor total, o cliente deve aparecer	mesmo que não tenha feito nenhum pedido.

		SELECT C.NMCUSTOMER, R.DTREQUEST,SUM(PR.QTAMOUNT * PR.VLUNITARY) AS 'VALOR TOTAL'
		FROM CUSTOMER C
		LEFT JOIN REQUEST R ON C.CDCUSTOMER=R.CDCUSTOMER
		LEFT JOIN PRODUCTREQUEST PR ON PR.CDREQUEST=R.CDREQUEST
		GROUP BY c.NMCUSTOMER, r.DTREQUEST