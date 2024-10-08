CREATE OR REPLACE FUNCTION INSERIR_LINHA( 
    NOME_TABELA TEXT,
    VALOR1 TEXT DEFAULT NULL,
    VALOR2 TEXT DEFAULT NULL,
    VALOR3 TEXT DEFAULT NULL,
    VALOR4 TEXT DEFAULT NULL,
    VALOR5 TEXT DEFAULT NULL,
    VALOR6 TEXT DEFAULT NULL,
	VALOR7 TEXT DEFAULT NULL,
	VALOR8 TEXT DEFAULT NULL,
	VALOR9 TEXT DEFAULT NULL,
	VALOR10 TEXT DEFAULT NULL
) RETURNS VOID AS $$
BEGIN 
    IF NOME_TABELA ILIKE 'PACIENTE' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_PAC(%L, %L, %L, %L)', VALOR1, VALOR2, VALOR3, VALOR4
        );
    END IF;

    IF NOME_TABELA ILIKE 'MEDICAMENTO' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_MEDICAMENTO(%L, %L)', VALOR1, VALOR2
        );
    END IF;
	
    IF NOME_TABELA ILIKE 'MEDICO' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_MEDICO(%L, %L, %L, %L, %L)', CAST(VALOR1 AS INT), VALOR2, VALOR3, VALOR4, VALOR5
        );
    END IF;
	
    IF NOME_TABELA ILIKE 'FUNCIONARIO' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_FUNC(%L, %L)', VALOR1, VALOR2
        );
    END IF;

    IF NOME_TABELA ILIKE 'CONSULTA' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_CONSULTA(%L, %L, %L, %L, %L, %L)', CAST(VALOR1 AS INT), CAST(VALOR2 AS INT), CAST(VALOR3 AS INT), 
                                                               VALOR4, CAST(VALOR5 AS DATE), CAST(VALOR6 AS VARCHAR(1))
        );
    END IF;

    IF NOME_TABELA ILIKE 'PROCEDIMENTO' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_PROC(%L, %L, %L, %L, %L)', CAST(VALOR1 AS INT), CAST(VALOR2 AS INT), CAST(VALOR3 AS INT), 
                                                               CAST(VALOR4 AS DATE), CAST(VALOR5 AS NUMERIC)
        );
    END IF;
	
    IF NOME_TABELA ILIKE 'ITEM_MED' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_ITEM_MED(%L, %L, %L, %L)', CAST(VALOR1 AS INT), CAST(VALOR2 AS INT), CAST(VALOR3 AS INT), CAST(VALOR4 AS VARCHAR(1))
        );
    END IF;

    IF NOME_TABELA ILIKE 'PLANO' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_PLANO(%L, %L, %L)', VALOR1, CAST(VALOR2 AS NUMERIC), CAST(VALOR3 AS NUMERIC)
        );
    END IF;

    IF NOME_TABELA ILIKE 'INTERNACAO' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_INTERNA(%L, %L, %L, %L, %L, %L)', CAST(VALOR1 AS INT), CAST(VALOR2 AS INT), CAST(VALOR3 AS INT), 
			CAST(VALOR4 AS INT), VALOR5, CAST(VALOR6 AS DATE)
        );
    END IF;

    IF NOME_TABELA ILIKE 'APARTAMENTO' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_APARTAMENTO(%L, %L)', CAST(VALOR1 AS INT), VALOR2
        );
    END IF;

    IF NOME_TABELA ILIKE 'PM' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_PM(%L, %L, %L)', CAST(VALOR1 AS INT), CAST(VALOR2 AS INT), CAST(VALOR3 AS NUMERIC)
        );
    END IF;

    IF NOME_TABELA ILIKE 'SUPERVISAO' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_SUPERVISAO(%L, %L)', CAST(VALOR1 AS INT), CAST(VALOR2 AS INT)
        );
    END IF;

    IF NOME_TABELA ILIKE 'CARGO' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_CARGO(%L, %L)', VALOR1, CAST(VALOR2 AS NUMERIC)
        );
    END IF;

    IF NOME_TABELA ILIKE 'SERVICO' THEN
        EXECUTE FORMAT(
            'SELECT INSERIR_SERVICO(%L, %L, %L)', VALOR1, VALOR2, CAST(VALOR3 AS NUMERIC)
        );
    END IF;

    IF NOT (NOME_TABELA ILIKE 'PACIENTE' OR NOME_TABELA ILIKE 'MEDICAMENTO' OR NOME_TABELA ILIKE 'FUNCIONARIO' OR 
            NOME_TABELA ILIKE 'CONSULTA' OR NOME_TABELA ILIKE 'PROCEDIMENTO' OR NOME_TABELA ILIKE 'PLANO' OR 
            NOME_TABELA ILIKE 'INTERNACAO' OR NOME_TABELA ILIKE 'MEDICO' OR NOME_TABELA ILIKE 'APARTAMENTO' OR
            NOME_TABELA ILIKE 'ITEM_MED' OR NOME_TABELA ILIKE 'PM' OR NOME_TABELA ILIKE 'SUPERVISAO' OR
            NOME_TABELA ILIKE 'CARGO' OR NOME_TABELA ILIKE 'SERVICO') THEN
        RAISE EXCEPTION 'Nenhuma tabela registrada no sistema corresponde à que você selecionou.';
    END IF;
	
	EXCEPTION
		WHEN insufficient_privilege THEN
        	RAISE EXCEPTION 'Você não tem permissão para realizar essa operação: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;


-- SELECT INSERIR_LINHA('MEDICAMENTO', 'NOME', 'BULA')
-- SELECT * FROM MEDICAMENTO;

CREATE OR REPLACE FUNCTION REMOVER_LINHA( 
    NOME_TABELA TEXT,
    CHAVE TEXT
) RETURNS VOID AS $$
BEGIN

    IF NOME_TABELA ILIKE 'PACIENTE' THEN
        EXECUTE FORMAT('DELETE FROM PACIENTE WHERE COD_PAC = %L', CHAVE);
    END IF;

    IF NOME_TABELA ILIKE 'MEDICAMENTO' THEN
        EXECUTE FORMAT('DELETE FROM MEDICAMENTO WHERE COD_MED = %L', CHAVE);
    END IF;

    IF NOME_TABELA ILIKE 'FUNCIONARIO' THEN
        EXECUTE FORMAT('DELETE FROM FUNCIONARIO WHERE COD_FUNC = %L', CHAVE);
    END IF;

    IF NOME_TABELA ILIKE 'CONSULTA' THEN
        EXECUTE FORMAT('DELETE FROM CONSULTA WHERE COD_CONSUL = %L', CHAVE);
    END IF;

    IF NOME_TABELA ILIKE 'PROCEDIMENTO' THEN
        EXECUTE FORMAT('DELETE FROM PROCEDIMENTO WHERE COD_PROCED = %L', CHAVE);
    END IF;

    IF NOME_TABELA ILIKE 'ITEM_MED' THEN
        EXECUTE FORMAT('DELETE FROM ITEM_MED WHERE COD_ITEM_MED = %L AND COD_MED = %L', CHAVE);
    END IF;

    IF NOME_TABELA ILIKE 'PLANO' THEN
        EXECUTE FORMAT('DELETE FROM PLANO WHERE COD_PLANO = %L', CHAVE);
    END IF;
	
	IF NOME_TABELA ILIKE 'MEDICO' THEN
        EXECUTE FORMAT('DELETE FROM MEDICO WHERE CRM = %L', CHAVE);
    END IF;

    IF NOME_TABELA ILIKE 'INTERNACAO' THEN
        EXECUTE FORMAT('DELETE FROM INTERNACAO WHERE COD_INTERNA = %L', CHAVE);
    END IF;
    
    IF NOME_TABELA ILIKE 'APARTAMENTO' THEN
        EXECUTE FORMAT('DELETE FROM APARTAMENTO WHERE COD_APARTAMENTO = %L', CHAVE);
    END IF;

    IF NOME_TABELA ILIKE 'PM' THEN
        EXECUTE FORMAT('DELETE FROM PM WHERE COD_PM = %L', CHAVE);
    END IF;

    IF NOME_TABELA ILIKE 'SUPERVISAO' THEN
        EXECUTE FORMAT('DELETE FROM SUPERVISAO WHERE COD_SUPERVISAO = %L', CHAVE);
    END IF;

    IF NOME_TABELA ILIKE 'CARGO' THEN
        EXECUTE FORMAT('DELETE FROM CARGO WHERE COD_CARGO = %L', CHAVE);
    END IF;

    IF NOME_TABELA ILIKE 'SERVICO' THEN
        EXECUTE FORMAT('DELETE FROM SERVICO WHERE COD_SERVICO = %L', CHAVE);
    END IF;

    IF NOT (NOME_TABELA ILIKE 'PACIENTE' OR NOME_TABELA ILIKE 'MEDICAMENTO' OR NOME_TABELA ILIKE 'FUNCIONARIO' OR 
            NOME_TABELA ILIKE 'CONSULTA' OR NOME_TABELA ILIKE 'PROCEDIMENTO' OR NOME_TABELA ILIKE 'ITEM_MED' OR 
            NOME_TABELA ILIKE 'PLANO' OR NOME_TABELA ILIKE 'INTERNACAO' OR NOME_TABELA ILIKE 'APARTAMENTO' OR NOME_TABELA ILIKE 'MEDICO' OR
			NOME_TABELA ILIKE 'PM' OR NOME_TABELA ILIKE 'SUPERVISAO' OR NOME_TABELA ILIKE 'CARGO' OR NOME_TABELA ILIKE 'SERVICO') THEN
        RAISE EXCEPTION 'Nenhuma tabela registrada no sistema corresponde à que você selecionou.';
    END IF;

	EXCEPTION
		WHEN insufficient_privilege THEN
        	RAISE EXCEPTION 'Você não tem permissão para realizar essa operação: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;


-- SELECT REMOVER_LINHA('MEDICAMENTO', '1')

CREATE OR REPLACE FUNCTION ATUALIZAR_LINHA(
    NOME_TABELA TEXT,
    CHAVE TEXT,
    VALOR1 TEXT DEFAULT NULL,
    VALOR2 TEXT DEFAULT NULL,
    VALOR3 TEXT DEFAULT NULL,
    VALOR4 TEXT DEFAULT NULL,
    VALOR5 TEXT DEFAULT NULL,
    VALOR6 TEXT DEFAULT NULL,
    VALOR7 TEXT DEFAULT NULL,
    VALOR8 TEXT DEFAULT NULL,
    VALOR9 TEXT DEFAULT NULL,
	VALOR10 TEXT DEFAULT NULL
) RETURNS VOID AS $$
BEGIN

    IF NOME_TABELA ILIKE 'PACIENTE' THEN
        EXECUTE FORMAT(
            'UPDATE PACIENTE SET CPF = %L, NOME = %L, CONTATO = %L, ENDERECO = %L WHERE COD_PAC = %L',
            VALOR1, VALOR2, VALOR3, VALOR4, CHAVE
        );
    END IF;

    IF NOME_TABELA ILIKE 'MEDICAMENTO' THEN
        EXECUTE FORMAT(
            'UPDATE MEDICAMENTO SET NOME = %L, BULA = %L WHERE COD_MED = %L',
            VALOR1, VALOR2, CHAVE
        );
    END IF;

    IF NOME_TABELA ILIKE 'FUNCIONARIO' THEN
        EXECUTE FORMAT(
            'UPDATE FUNCIONARIO SET NOME = %L, CPF = %L, COD_CARGO = %L WHERE COD_FUNC = %L',
            VALOR1, VALOR2, CAST(VALOR3 AS INT), CHAVE
        );
    END IF;
	
	IF NOME_TABELA ILIKE 'MEDICO' THEN
        EXECUTE FORMAT(
            'UPDATE MEDICO SET NOME = %L, CPF = %L, CONTATO = %L, ENDERECO = %L WHERE CRM = %L',
            VALOR1, VALOR2, VALOR3, VALOR4, CHAVE
        );
    END IF;

    IF NOME_TABELA ILIKE 'CONSULTA' THEN
        EXECUTE FORMAT(
            'UPDATE CONSULTA SET COD_PAC = %L, CRM = %L, COD_PLANO = %L, MOTIVO = %L, DT_PREV_CONSULTA = %L, DT_CONSUL = %L, VALOR = %L, STATUS = %L WHERE COD_CONSUL = %L',
            CAST(VALOR1 AS INT), CAST(VALOR2 AS INT), CAST(VALOR3 AS INT), VALOR4, CAST(VALOR5 AS DATE), 
			CAST(VALOR6 AS DATE), CAST(VALOR7 AS NUMERIC), CAST(VALOR8 AS BOOLEAN), CHAVE
        );
    END IF;

    IF NOME_TABELA ILIKE 'PROCEDIMENTO' THEN
        EXECUTE FORMAT(
            'UPDATE PROCEDIMENTO SET COD_FUNC = %L, COD_SERVICO = %L, COD_PAC = %L, DT_ATEND = %L, VALOR = %L WHERE COD_PROCED = %L',
            CAST(VALOR1 AS INT), CAST(VALOR2 AS INT), CAST(VALOR3 AS INT), CAST(VALOR4 AS DATE), CAST(VALOR5 AS NUMERIC), CHAVE
        );
    END IF;

    IF NOME_TABELA ILIKE 'ITEM_MED' THEN
        EXECUTE FORMAT(
        	'UPDATE ITEM_MED SET QUANTIDADE = %L WHERE COD_ITEM_MED = %L AND COD_MED = %L',
            CAST(VALOR1 AS INT), CHAVE
         );
    END IF;

    IF NOME_TABELA ILIKE 'PLANO' THEN
        EXECUTE FORMAT(
            'UPDATE PLANO SET NOME = %L, VALOR_CON = %L, VALOR_INT = %L WHERE COD_PLANO = %L',
            VALOR1, CAST(VALOR2 AS NUMERIC), CAST(VALOR3 AS NUMERIC), CHAVE
        );
    END IF;

    IF NOME_TABELA ILIKE 'INTERNACAO' THEN
        EXECUTE FORMAT(
            'UPDATE INTERNACAO SET COD_PAC = %L, COD_PLANO = %L, COD_PM = %L, CRM = %L, NUMERO = %L, DT_INTERNA = %L, VALOR = %L, DT_CONCLUSAO = %L, MOTIVO = %L, CONCLUSAO = %L WHERE COD_INTERNA = %L',
            CAST(VALOR1 AS INT), CAST(VALOR2 AS INT), CAST(VALOR3 AS INT), CAST(VALOR4 AS INT), CAST(VALOR5 AS INT), 
			CAST(VALOR6 AS DATE), CAST(VALOR7 AS NUMERIC), CAST(VALOR8 AS DATE), VALOR9, VALOR10, CHAVE
        );
    END IF;
	
	SELECT * FROM INTERNACAO;

    IF NOME_TABELA ILIKE 'APARTAMENTO' THEN
        EXECUTE FORMAT(
            'UPDATE APARTAMENTO SET NUMERO = %L, ANDAR = %L, DESCRICAO = %L WHERE COD_APARTAMENTO = %L',
            VALOR1, CAST(VALOR2 AS INT), VALOR3, CHAVE
        );
    END IF;

    IF NOME_TABELA ILIKE 'PM' THEN
        EXECUTE FORMAT(
            'UPDATE PM SET DESCRICAO = %L WHERE COD_PM = %L',
            VALOR1, CHAVE
        );
    END IF;

    IF NOME_TABELA ILIKE 'SUPERVISAO' THEN
        EXECUTE FORMAT(
            'UPDATE SUPERVISAO SET COD_MEDICO = %L, COD_FUNC = %L, DT_INICIO = %L, DT_FIM = %L WHERE COD_SUPERVISAO = %L',
            CAST(VALOR1 AS INT), CAST(VALOR2 AS INT), CAST(VALOR3 AS DATE), CAST(VALOR4 AS DATE), CHAVE
        );
    END IF;

    IF NOME_TABELA ILIKE 'CARGO' THEN
        EXECUTE FORMAT(
            'UPDATE CARGO SET DESCRICAO = %L WHERE COD_CARGO = %L',
            VALOR1, CHAVE
        );
    END IF;

    IF NOME_TABELA ILIKE 'SERVICO' THEN
        EXECUTE FORMAT(
            'UPDATE SERVICO SET DESCRICAO = %L WHERE COD_SERVICO = %L',
            VALOR1, CHAVE
        );
    END IF;

    IF NOT (NOME_TABELA ILIKE 'PACIENTE' OR NOME_TABELA ILIKE 'MEDICAMENTO' OR NOME_TABELA ILIKE 'FUNCIONARIO' OR 
            NOME_TABELA ILIKE 'CONSULTA' OR NOME_TABELA ILIKE 'PROCEDIMENTO' OR NOME_TABELA ILIKE 'ITEM_MED' OR 
            NOME_TABELA ILIKE 'PLANO' OR NOME_TABELA ILIKE 'INTERNACAO' OR NOME_TABELA ILIKE 'APARTAMENTO' OR NOME_TABELA ILIKE 'MEDICO' OR
            NOME_TABELA ILIKE 'PM' OR NOME_TABELA ILIKE 'SUPERVISAO' OR NOME_TABELA ILIKE 'CARGO' OR NOME_TABELA ILIKE 'SERVICO') THEN
        RAISE EXCEPTION 'Nenhuma tabela registrada no sistema corresponde à que você selecionou.';
    END IF;
	
	EXCEPTION
		WHEN insufficient_privilege THEN
        	RAISE EXCEPTION 'Você não tem permissão para realizar essa operação: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;



-- SELECT ATUALIZAR_LINHA('MEDICAMENTO', '2', NULL, 'Novo Nome', 'Nova Bula');
-- SELECT * FROM MEDICAMENTO;
