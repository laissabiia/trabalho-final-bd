-- Tabela de contas
CREATE TABLE conta ( 
  email_conta VARCHAR(50) PRIMARY KEY,  
  senha VARCHAR(10) NOT NULL,  
); 

-- Tabela de escolas
CREATE TABLE escola ( 
  cnpj VARCHAR(18) PRIMARY KEY,  
  nome VARCHAR(100) NOT NULL,  
  email VARCHAR(50),
  logradouro VARCHAR(150),  
  numero INT,   
  bairro VARCHAR(100),  
  cidade VARCHAR(100),  
  estado CHAR(2),  
  cep VARCHAR(9),  
  id_regional INT,  
); 

-- Tabela discentes da UnB
CREATE TABLE discente_unb ( 
  nome VARCHAR(100) NOT NULL,  
  mat_unb_discente VARCHAR(10) PRIMARY KEY,  
  mat_prof_unb VARCHAR(10),  
  cnpj_escola VARCHAR(18),  
  mat_prof_seedf VARCHAR(10),  
  email_conta VARCHAR(50),  
  cod_depo INT,  
); 

-- Tabela professores da UnB
CREATE TABLE professor_unb ( 
  nome VARCHAR(100) NOT NULL,  
  matricula_unb VARCHAR(10) PRIMARY KEY,  
  email_conta VARCHAR(50),  
  cod_depo INT,  
); 

-- Tabela professores da SEEDF
CREATE TABLE professor_seedf ( 
  matricula_seedf VARCHAR(10) PRIMARY KEY,  
  nome VARCHAR(100) NOT NULL,  
); 

-- Tabela de áreas
CREATE TABLE area ( 
  id_area INT PRIMARY KEY,  
  nome_area VARCHAR(100) NOT NULL,  
); 

-- Tabela de departamentos
CREATE TABLE departamento ( 
  cod_depo INT PRIMARY KEY,  
  nome_dep VARCHAR(100) NOT NULL,  
); 

-- Tabela de modalidade
CREATE TABLE modalidade ( 
  id_modalidade INT PRIMARY KEY,  
  nome_modal VARCHAR(100) NOT NULL,  
); 

-- Tabela de regional de ensino
CREATE TABLE regional_ensino ( 
  id_regional INT PRIMARY KEY,  
  nome VARCHAR(100) NOT NULL,  
  email VARCHAR(50),  
); 

-- Tabela de vínculo de professor SEEDF com escola
CREATE TABLE rel_escola_prof ( 
  data DATE NOT NULL,  
  matricula_seedf VARCHAR(10),  
  cnpj VARCHAR(18),
  PRIMARY KEY (matricula_seedf, cnpj)  
); 

-- Tabela de professores da SEEDF e suas respectivas áreas
CREATE TABLE rel_prof_area ( 
  id_area INT,  
  matricula_seedf VARCHAR(10),
  PRIMARY KEY (id_area, matricula_seedf)  
); 


-- Tabela de modalidades que uma escola possui
CREATE TABLE rel_escola_mod ( 
  cnpj VARCHAR(18),  
  id_modalidade INT, 
  PRIMARY KEY (cnpj, id_modalidade)
); 

-- Tabela de telefones das Regionais 
CREATE TABLE tel_regional ( 
  numero_reg VARCHAR(12) PRIMARY KEY,  
  id_regional INT NOT NULL,  
); 

-- Tabela de telefones das escolas
CREATE TABLE tel_escola ( 
  numero_esc VARCHAR(12) PRIMARY KEY,  
  cnpj VARCHAR(18) NOT NULL,  
); 

-- Relações de chave estrangeira
ALTER TABLE escola ADD FOREIGN KEY(id_regional) REFERENCES regional_ensino (id_regional);

ALTER TABLE discente_unb ADD FOREIGN KEY(mat_prof_unb) REFERENCES professor_unb (matricula_unb);
ALTER TABLE discente_unb ADD FOREIGN KEY(cnpj_escola) REFERENCES escola (cnpj);
ALTER TABLE discente_unb ADD FOREIGN KEY(mat_prof_seedf) REFERENCES professor_seedf (matricula_seedf);
ALTER TABLE discente_unb ADD FOREIGN KEY(email_conta) REFERENCES conta (email_conta);
ALTER TABLE discente_unb ADD FOREIGN KEY(cod_depo) REFERENCES departamento (cod_depo);

ALTER TABLE professor_unb ADD FOREIGN KEY(email_conta) REFERENCES conta (email_conta);
ALTER TABLE professor_unb ADD FOREIGN KEY(cod_depo) REFERENCES departamento (cod_depo);

ALTER TABLE trabalha ADD FOREIGN KEY(matricula_seedf) REFERENCES professor_seedf (matricula_seedf);
ALTER TABLE trabalha ADD FOREIGN KEY(cnpj) REFERENCES escola (cnpj);

ALTER TABLE ministra ADD FOREIGN KEY(id_area) REFERENCES area (id_area);
ALTER TABLE ministra ADD FOREIGN KEY(matricula_seedf) REFERENCES professor_seedf (matricula_seedf);

ALTER TABLE possui ADD FOREIGN KEY(cnpj) REFERENCES escola (cnpj);
ALTER TABLE possui ADD FOREIGN KEY(id_modalidade) REFERENCES modalidade (id_modalidade);

ALTER TABLE tel_regional ADD FOREIGN KEY(id_regional) REFERENCES regional_ensino (id_regional);

ALTER TABLE tel_escola ADD FOREIGN KEY(cnpj) REFERENCES escola (cnpj);