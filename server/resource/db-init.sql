
create table if not exists tb_pedido (
    id              INTEGER        NOT NULL
                                   PRIMARY KEY AUTOINCREMENT,
    dt_pedido       TIMESTAMP      NOT NULL,
    dt_entrega      TIMESTAMP,
    nr_tempopedido  INTEGER        NOT NULL,
    vl_pedido       DECIMAL (9, 2) NOT NULL,
    cd_cliente      INTEGER        NOT NULL,
    tx_tamanhopizza STRING (15),
    tx_saborpizza   STRING (15) 
);


create table if not exists tb_cliente (
  
    id integer not null primary key autoincrement,
  
    nr_documento varchar(15) not null
);