USE treinamento

--PARTE A)O nome e telefone de todos os clientes em que o telefone começa com o dígito 4;
		SELECT CUSTOMER.NMCUSTOMER, IDFONE 
		FROM CUSTOMER 
		WHERE IDFONE LIKE '4%'


--PARTE B)Todas as colunas dos clientes que não possuem telefone cadastrado;
		SELECT *
		FROM CUSTOMER 
		WHERE IDFONE IS NULL


--PARTE C)O nome e o telefone dos fornecedores em que o DDD não foi cadastrado;
		SELECT SUPPLIER.NMSUPPLIER, SUPPLIER.IDFONE
		FROM SUPPLIER 
		WHERE IDFONE  NOT LIKE '%(___)%'

--PARTE D)O nome, quantidade em estoque e o preço com desconto de 10% dos produtos que tem mais de 2000 unidades em estoque;
		SELECT NMPRODUCT,QTSTOCK, (VLPRICE * 0.9) AS PRICE  
		FROM PRODUCT 
		WHERE QTSTOCK > 2000


 --PARTE E)O nome e o preço dos produtos com preço entre 10 e 20 reais;
		 SELECT NMPRODUCT,VLPRICE 
		 FROM PRODUCT 
		 WHERE VLPRICE<20 AND VLPRICE>10


 --PARTE F)O nome do produto, o preço e o preço total do estoque dos produtos com preço acima de 50 reais;

		 select  NMPRODUCT,VLPRICE, (VLPRICE * QTSTOCK) AS PRECOESTOQUE 
		 from PRODUCT 
		 WHERE VLPRICE > 50 


 --PARTE G)O nome do produto, o nome do fornecedor e o telefone do fornecedor dos produtos com preço acima de 20 reais e que tenham mais de 1500 unidades em estoque;
		 SELECT PRODUCT.NMPRODUCT,SUPPLIER.NMSUPPLIER,SUPPLIER.IDFONE 
		 FROM PRODUCT 
		 INNER JOIN SUPPLIER ON SUPPLIER.CDSUPPLIER = PRODUCT.CDSUPPLIER 
		 WHERE PRODUCT.VLPRICE > 20 AND PRODUCT.QTSTOCK>1500


 --PARTE H) O nome do cliente, a data do pedido e o valor total do pedido para pedidosfeitos entre junho e julho de 2003;
        SELECT CUSTOMER.NMCUSTOMER,REQUEST.DTREQUEST,VLTOTAL
		FROM REQUEST 
		INNER JOIN CUSTOMER ON CUSTOMER.CDCUSTOMER= REQUEST.CDCUSTOMER 
		WHERE REQUEST.DTREQUEST between '20030601' and '20030731';


--PARTE I)O nome do cliente, o nome do produto, a data do pedido, a quantidade pedida, o valor unitário de venda dos produtos e o valor total do produto pedido, cujas unidades pedidas por pedido seja maior que 500.
		SELECT c.NMCUSTOMER, p.NMPRODUCT, r.DTREQUEST, pr.QTAMOUNT, pr.VLUNITARY, pr.QTAMOUNT * pr.VLUNITARY AS VLTOTAL
		FROM CUSTOMER c, PRODUCT p, REQUEST r, PRODUCTREQUEST pr
		WHERE c.CDCUSTOMER = r.CDCUSTOMER AND p.CDPRODUCT = pr.CDPRODUCT AND r.CDREQUEST = pr.CDREQUEST AND pr.QTAMOUNT > 500;