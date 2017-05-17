USE [ARAGON]
GO
/****** Object:  Trigger [dbo].[tg_historico_patrimonio]    Script Date: 12/09/2016 10:59:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[tg_historico_patrimonio]
    
    ON  [dbo].[sgph_patrimonio_movel]
    
    FOR INSERT, UPDATE    
    AS
    BEGIN
      DECLARE
      @fk_patrimonio int,
	    @fk_usuario int,
	    @fk_subsetor int,
	    @fk_setor int,
	    @pk_historico int = 1,
	    @fk_setor_antigo int
    
	  SELECT @fk_setor_antigo = fk_setor_int FROM DELETED
    
    SELECT @fk_patrimonio = pk_patrimonio_movel_int, @fk_usuario = fk_usuario_int, @fk_subsetor = fk_subsetor_int, @fk_setor = fk_setor_int FROM INSERTED
    
	/*SELECT @pk_historico = CASE  WHEN MAX(pk_historico_int) >= 1 THEN (MAX(pk_historico_int) + 1) 
	                             WHEN MAX(pk_historico_int) <= 0 THEN 1 END
	  FROM sgph_historico*/	
  
  if(SELECT MAX(pk_historico_int) FROM sgph_historico) >= 1
	BEGIN
	  SELECT  @pk_historico = MAX(pk_historico_int) + 1 FROM sgph_historico	 
	END
	
	  if @fk_setor <> @fk_setor_antigo
	  BEGIN
        INSERT INTO sgph_historico(pk_historico_int, fk_patrimonio_movel_int, fk_usuario_int, pk_subsetor_int, pk_setor_int, dt_lancamento)
	    VALUES(@pk_historico, @fk_patrimonio, @fk_usuario, @fk_subsetor, @fk_setor, GETDATE()) 
      END
    END
    
 --CRIA A TRIGGER   
 CREATE TRIGGER NOME_TRIGGER 
 --ONDE
 ON NOME_TABELA
  --QUANDO EXECUTA AÇÃO
 FOR INSERT, UPDATE, DELETE 
 AS
 BEGIN
   DECLARE
   @Id INT;
   
   --GUARDA O ID DA TABELA QUE INSERIU OU ALTEROU O REGISTRO
   SELECT @id = id FROM INSERTED 
   
    --PROXIMA AÇÃO 
 
 END