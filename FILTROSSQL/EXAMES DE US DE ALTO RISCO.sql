select no_procedimento, count(*) as Total
from V_GFA_TOMO_APAC 
where Exame LIKE '%ULTRA%'
and Data BETWEEN '2016-01-01' AND '2016-01-31'  and codigopaciente = (
SELECT   top 1  P.NumeroProntuario

FROM         dbo.PACIENTE_PacientesInternadosCirurgiados P INNER JOIN
                      dbo.PACIENTE_Clinicas C ON P.Clinica = C.CodigoDaClinica INNER JOIN
                      dbo.PACIENTE_Medicos ON P.MedicoDoTratamento = dbo.PACIENTE_Medicos.CRM INNER JOIN
                      dbo.PACIENTE_Medicos PACIENTE_Medicos_1 ON P.MedicoResponsavel = PACIENTE_Medicos_1.CRM INNER JOIN
                      dbo.PACIENTE_DATASUS_TB_CID ON P.Diagnostico = dbo.PACIENTE_DATASUS_TB_CID.CID_COD INNER JOIN
                      dbo.PACIENTE_DATASUS_TB_PROC ON P.ProcedimentoNovo = dbo.PACIENTE_DATASUS_TB_PROC.PROC_COD INNER JOIN
                      dbo.PACIENTE_Pacientes PAC ON P.NumeroProntuario = PAC.Matricula
WHERE    P.DataSaida between '2016-01-01' AND '2016-01-31' AND (P.Excluido = - 1) AND (P.CondicaoDeAlta IS NOT NULL) and CondicaoDeAlta like '6%'
AND dbo.PACIENTE_DATASUS_TB_PROC.PROC_DESCR LIKE '%RISCO%' and V_GFA_TOMO_APAC.codigopaciente = P.NumeroProntuario)
group by no_procedimento