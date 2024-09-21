CREATE OR REPLACE FUNCTION LIBERAR_ALTA(CODIGO_INTERNA INT) 
RETURNS VOID AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM INTERNACAO WHERE INTERNACAO.COD_INTERNA = CODIGO_INTERNA 
				   AND DT_CONCLUSAO IS NULL) THEN
        RAISE EXCEPTION 'A internação já foi concluída.';
    END IF;

    UPDATE INTERNACAO SET DT_CONCLUSAO = CURRENT_DATE, CONCLUSAO = 'Alta'
    WHERE INTERNACAO.COD_INTERNA = CODIGO_INTERNA;

    RAISE NOTICE 'Paciente recebeu alta com sucesso.';
	EXCEPTION
		WHEN insufficient_privilege THEN
        	RAISE EXCEPTION 'Você não tem permissão para realizar essa operação: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;

SELECT LIBERAR_ALTA(1)

CREATE OR REPLACE FUNCTION REGISTRAR_SUPERVISAO(
    COD_SUPERVISOR INT,
    COD_SUPERVISIONA INT
) RETURNS VOID AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM SUPERVISAO WHERE COD_SUPERVISOR = COD_SUPERVISOR AND COD_SUPERVISIONA = COD_SUPERVISIONA) THEN
        RAISE EXCEPTION 'Supervisão já registrada.';
    END IF;

    INSERT INTO SUPERVISAO (COD_SUPERVISOR, COD_SUPERVISIONA)
    VALUES (COD_SUPERVISOR, COD_SUPERVISIONA);
	EXCEPTION
		WHEN insufficient_privilege THEN
        	RAISE EXCEPTION 'Você não tem permissão para realizar essa operação: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION GERAR_FATURA_INTERNA(CODIGO_INTERNA INT) 
RETURNS NUMERIC
AS $$
DECLARE
VALOR_POR_PLANO NUMERIC;
VALOR_POR_MEDICAMENTOS NUMERIC;
VALOR_TOTAL NUMERIC;
BEGIN
    SELECT PLANO.VALOR_INT * (INTERNACAO.DT_CONCLUSAO - INTERNACAO.DT_INTERNA) INTO VALOR_POR_PLANO 
	FROM INTERNACAO JOIN PLANO ON INTERNACAO.COD_PLANO = PLANO.COD_PLANO 
	WHERE INTERNACAO.COD_INTERNA = CODIGO_INTERNA;
	
	SELECT SUM(PM.PRECO * ITEM_MED.QUANTIDADE) INTO VALOR_POR_MEDICAMENTOS FROM INTERNACAO 
	JOIN ITEM_MED ON INTERNACAO.COD_INTERNA = ITEM_MED.COD_INTERNA JOIN
	PM ON ITEM_MED.COD_MED = PM.COD_MED WHERE
	INTERNACAO.COD_INTERNA = CODIGO_INTERNA;
	
	VALOR_TOTAL := VALOR_POR_MEDICAMENTOS + VALOR_POR_PLANO;
	
	UPDATE INTERNACAO SET VALOR = VALOR_TOTAL WHERE INTERNACAO.COD_INTERNA = CODIGO_INTERNA;
	
	RETURN VALOR_TOTAL;
	EXCEPTION
		WHEN insufficient_privilege THEN
        	RAISE EXCEPTION 'Você não tem permissão para realizar essa operação: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;

SELECT PLANO.VALOR_INT * (INTERNACAO.DT_CONCLUSAO - INTERNACAO.DT_INTERNA)
	FROM INTERNACAO JOIN PLANO ON INTERNACAO.COD_PLANO = PLANO.COD_PLANO 
	WHERE COD_INTERNA = 1;
SELECT GERAR_FATURA_INTERNA(1)
SELECT * FROM INTERNACAO;
UPDATE INTERNACAO SET DT_CONCLUSAO = '1999-01-10' WHERE COD_INTERNA = 1;

CREATE OR REPLACE FUNCTION GERAR_FATURA_CONSULTA(CODIGO_CONSUL INT) 
RETURNS NUMERIC
AS $$
DECLARE 
VALOR_CONSULTA NUMERIC;
BEGIN
	SELECT VALOR_CON INTO VALOR_CONSULTA FROM CONSULTA JOIN PLANO ON 
	CONSULTA.COD_PLANO = PLANO.COD_PLANO WHERE CONSULTA.COD_CONSUL = CODIGO_CONSUL;
	
	UPDATE CONSULTA SET VALOR = VALOR_CONSULTA WHERE CONSULTA.COD_CONSUL = CODIGO_CONSUL;

	RETURN VALOR_CONSULTA;
	EXCEPTION
		WHEN insufficient_privilege THEN
        	RAISE EXCEPTION 'Você não tem permissão para realizar essa operação: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM CONSULTA;
SELECT GERAR_FATURA_CONSULTA(3);

CREATE OR REPLACE FUNCTION CONCEDER_CARGO_FUNCIONARIO(NOME_FUNCIONARIO TEXT, NOME_CARGO TEXT) 
RETURNS VOID
AS $$
DECLARE
CODIGO_CARGO INT;
BEGIN
	SELECT COD_CARGO INTO CODIGO_CARGO FROM CARGO WHERE CARGO.NOME ILIKE NOME_CARGO;
	UPDATE FUNCIONARIO SET COD_CARGO = CODIGO_CARGO WHERE FUNCIONARIO.NOME ILIKE NOME_FUNCIONARIO;
	EXCEPTION
		WHEN insufficient_privilege THEN
        	RAISE EXCEPTION 'Você não tem permissão para realizar essa operação: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM FUNCIONARIO;
SELECT INSERIR_LINHA('FUNCIONARIO', 'JOSÉ', '098')
SELECT CONCEDER_CARGO_FUNCIONARIO('JOSÉ', 'FUNC')
SELECT * FROM CARGO;
SELECT INSERIR_LINHA('CARGO', 'FUNC', '10.5')

CREATE OR REPLACE FUNCTION ATUALIZAR_STATUS_CONSULTA(
    CODIGO_CONSUL INT,
    NOVO_STATUS BOOLEAN
) RETURNS VOID
AS $$
BEGIN
    UPDATE CONSULTA SET STATUS = NOVO_STATUS WHERE COD_CONSUL = CODIGO_CONSUL;
	EXCEPTION
		WHEN insufficient_privilege THEN
        	RAISE EXCEPTION 'Você não tem permissão para realizar essa operação: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION ATUALIZAR_SUPERVISAO(
    COD_SUPERVISOR INT,
    COD_SUPERVISIONA INT,
    NOVO_COD_SUPERVISOR INT
) RETURNS VOID
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM SUPERVISAO WHERE COD_SUPERVISOR = NOVO_COD_SUPERVISOR AND COD_SUPERVISIONA = COD_SUPERVISIONA) THEN
        RAISE EXCEPTION 'O novo supervisor já está supervisionando este funcionário.';
    END IF;
    
    UPDATE SUPERVISAO SET COD_SUPERVISOR = NOVO_COD_SUPERVISOR
    WHERE COD_SUPERVISOR = COD_SUPERVISOR AND COD_SUPERVISIONA = COD_SUPERVISIONA;
	EXCEPTION
		WHEN insufficient_privilege THEN
        	RAISE EXCEPTION 'Você não tem permissão para realizar essa operação: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;












