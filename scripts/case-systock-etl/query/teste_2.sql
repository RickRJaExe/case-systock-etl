SELECT * FROM fornecedor;
select * from produtos_filial pf;
select * from entradas_mercadoria;
select * from pedido_compra;
select * from venda;

SELECT 
    produto_id,
    SUM(qtde_vendida) AS total_quantidade,
    SUM(qtde_vendida * valor_unitario) AS total_valor
FROM venda
WHERE data_emissao BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY produto_id
ORDER BY produto_id;


SELECT 
    pc.produto_id,
    pc.qtde_pedida,
    pc.qtde_entregue
FROM pedido_compra pc
WHERE pc.qtde_entregue < pc.qtde_pedida;


SELECT 
    pc.produto_id,
    pc.qtde_pedida,
    pc.qtde_entregue,
    (pc.qtde_pedida - pc.qtde_entregue) AS pendente
FROM pedido_compra pc
WHERE pc.qtde_entregue < pc.qtde_pedida;


SELECT 
    pc.produto_id,
    pc.qtde_pedida,
    pc.qtde_entregue,
    COALESCE(em.total_recebido, 0) AS total_recebido_entrada
FROM pedido_compra pc
LEFT JOIN (
    SELECT 
        produto_id,
        SUM(qtde_recebida) AS total_recebido
    FROM entradas_mercadoria
    GROUP BY produto_id
) em
ON pc.produto_id = em.produto_id
ORDER BY pc.produto_id;



SELECT 
    pc.produto_id,
    SUM(pc.qtde_pedida) AS total_pedido,
    SUM(pc.qtde_entregue) AS total_entregue,
    COALESCE(em.total_recebido, 0) AS total_recebido
FROM pedido_compra pc
LEFT JOIN (
    SELECT 
        produto_id,
        SUM(qtde_recebida) AS total_recebido
    FROM entradas_mercadoria
    GROUP BY produto_id
) em
ON pc.produto_id = em.produto_id
GROUP BY pc.produto_id, em.total_recebido
ORDER BY pc.produto_id;