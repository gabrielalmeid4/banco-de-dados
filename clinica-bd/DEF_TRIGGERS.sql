CREATE OR REPLACE TRIGGER VERIFICA_PAC_TG BEFORE
INSERT OR UPDATE OR DELETE ON PACIENTE FOR EACH ROW
EXECUTE FUNCTION VERIFICA_PAC();

CREATE OR REPLACE TRIGGER VERIFICA_MEDICAMENTO_TG
BEFORE INSERT OR UPDATE OR DELETE ON MEDICAMENTO
FOR EACH ROW
EXECUTE FUNCTION VERIFICA_MEDICAMENTO();

CREATE OR REPLACE TRIGGER VERIFICA_FUNCIONARIO_TG
BEFORE INSERT OR UPDATE OR DELETE ON FUNCIONARIO
FOR EACH ROW
EXECUTE FUNCTION VERIFICA_FUNCIONARIO();

CREATE OR REPLACE TRIGGER VERIFICA_ITEM_MED_TG
BEFORE INSERT OR UPDATE OR DELETE ON ITEM_MED
FOR EACH ROW
EXECUTE FUNCTION VERIFICA_ITEM_MED();

CREATE OR REPLACE TRIGGER VERIFICA_CARGO_TG
BEFORE INSERT OR UPDATE OR DELETE ON CARGO
FOR EACH ROW
EXECUTE FUNCTION VERIFICA_CARGO();

CREATE OR REPLACE TRIGGER VERIFICA_SERVICO_TG
BEFORE INSERT OR UPDATE OR DELETE ON SERVICO
FOR EACH ROW
EXECUTE FUNCTION VERIFICA_SERVICO();

CREATE OR REPLACE TRIGGER VERIFICA_MEDICO_TG
BEFORE INSERT OR UPDATE OR DELETE ON MEDICO
FOR EACH ROW
EXECUTE FUNCTION VERIFICA_MEDICO();

CREATE OR REPLACE TRIGGER VERIFICA_PLANO_TG
BEFORE INSERT OR UPDATE OR DELETE ON PLANO
FOR EACH ROW
EXECUTE FUNCTION VERIFICA_PLANO();

CREATE OR REPLACE TRIGGER VERIFICA_CONSULTA_TG
BEFORE INSERT OR UPDATE OR DELETE ON CONSULTA
FOR EACH ROW
EXECUTE FUNCTION VERIFICA_CONSULTA();

CREATE OR REPLACE TRIGGER VERIFICA_PM_TG
BEFORE INSERT OR UPDATE OR DELETE ON PM
FOR EACH ROW
EXECUTE FUNCTION VERIFICA_PM();

CREATE OR REPLACE TRIGGER VERIFICA_APARTAMENTO_TG
BEFORE INSERT OR UPDATE OR DELETE ON APARTAMENTO
FOR EACH ROW
EXECUTE FUNCTION VERIFICA_APARTAMENTO();

CREATE OR REPLACE TRIGGER VERIFICA_INTERNACAO_TG
BEFORE INSERT OR UPDATE OR DELETE ON INTERNACAO
FOR EACH ROW
EXECUTE FUNCTION VERIFICA_INTERNACAO();

CREATE OR REPLACE TRIGGER VERIFICA_SUPERVISAO_TG
BEFORE INSERT OR UPDATE OR DELETE ON SUPERVISAO
FOR EACH ROW
EXECUTE FUNCTION VERIFICA_SUPERVISAO();







