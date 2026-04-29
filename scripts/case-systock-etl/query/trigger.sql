ALTER TABLE produtos_filial
ADD COLUMN fornecedor_id INT;

CREATE OR REPLACE FUNCTION fn_set_fornecedor_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.fornecedor_id := CAST(REPLACE(UPPER(NEW.idfornecedor), 'F', '') AS INT);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER trg_set_fornecedor_id
BEFORE INSERT ON produtos_filial
FOR EACH ROW
EXECUTE FUNCTION fn_set_fornecedor_id();

