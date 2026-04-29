
CREATE TABLE public.fornecedor(
    idfornecedor int4 NOT NULL,
    razao_social varchar(255) NOT NULL,
    CONSTRAINT fornecedor_pkey PRIMARY KEY (idfornecedor)
);



CREATE TABLE public.produtos_filial(
    filial_id int4 NOT NULL,
    produto_id varchar(255) NOT NULL,
    descricao varchar(255) NOT NULL,
    estoque float8 DEFAULT 0 NOT NULL,
    preco_unitario float8 DEFAULT 0 NOT NULL,
    preco_compra float8 DEFAULT 0 NOT NULL,
    preco_venda float8 DEFAULT 0 NOT NULL,
    idfornecedor int4,
    CONSTRAINT produtos_filial_pkey PRIMARY KEY (filial_id, produto_id),
    CONSTRAINT fk_produto_fornecedor 
        FOREIGN KEY (idfornecedor) 
        REFERENCES fornecedor(idfornecedor)
);



CREATE TABLE public.venda(
    venda_id int8 NOT NULL,
    data_emissao date NOT NULL,
    horariomov varchar(8) DEFAULT '00:00:00' NOT NULL,
    produto_id varchar(25) NOT NULL,
    qtde_vendida float8,
    valor_unitario numeric(12, 4) DEFAULT 0 NOT NULL,
    filial_id int8 DEFAULT 1 NOT NULL,
    item int4 DEFAULT 0 NOT NULL,
    unidade_medida varchar(3),
    CONSTRAINT pk_venda PRIMARY KEY 
        (filial_id, venda_id, data_emissao, produto_id, item, horariomov)
);


CREATE TABLE public.pedido_compra(
    pedido_id float8 NOT NULL,
    data_pedido date,
    item float8 NOT NULL,
    produto_id varchar(25) NOT NULL,
    descricao_produto varchar(255),
    ordem_compra float8 NOT NULL,
    qtde_pedida float8,
    filial_id int4,
    data_entrega date,
    qtde_entregue float8 DEFAULT 0 NOT NULL,
    qtde_pendente float8 DEFAULT 0 NOT NULL,
    preco_compra float8 DEFAULT 0,
    fornecedor_id int4,
    CONSTRAINT pedido_compra_pkey 
        PRIMARY KEY (pedido_id, produto_id, item)
);


CREATE TABLE public.entradas_mercadoria (
    ordem_compra float8 NOT NULL,
    data_entrada date,
    nro_nfe varchar(255) NOT NULL,
    item float8 NOT NULL,
    produto_id varchar(25) NOT NULL,
    descricao_produto varchar(255),
    qtde_recebida float8,
    filial_id int4,
    custo_unitario numeric(12, 4) DEFAULT 0 NOT NULL,
    CONSTRAINT entradas_mercadoria_pkey 
        PRIMARY KEY (ordem_compra, item, produto_id, nro_nfe)
);



-- pedido_compra -> fornecedor
ALTER TABLE pedido_compra
ADD CONSTRAINT fk_pedido_fornecedor
FOREIGN KEY (fornecedor_id)
REFERENCES fornecedor(idfornecedor);

