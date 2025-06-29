-- Criação das principais tabelas de domínio

CREATE TABLE tipo_usuario (
    id_tipo SERIAL PRIMARY KEY,
    nome VARCHAR(30) NOT NULL UNIQUE -- aluno, professor, orientador
);

CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    id_tipo INTEGER NOT NULL REFERENCES tipo_usuario(id_tipo)
);

CREATE TABLE instituicao (
    id_instituicao SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    cnpj VARCHAR(18) UNIQUE
);

CREATE TABLE curso (
    id_curso SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_instituicao INTEGER NOT NULL REFERENCES instituicao(id_instituicao)
);

CREATE TABLE regional (
    id_regional SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE escola (
    id_escola SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    endereco VARCHAR(200),
    id_regional INTEGER REFERENCES regional(id_regional)
);

-- Tabelas de telefone (mantendo)
CREATE TABLE telefone_escola (
    id_telefone SERIAL PRIMARY KEY,
    id_escola INTEGER NOT NULL REFERENCES escola(id_escola) ON DELETE CASCADE,
    numero VARCHAR(20) NOT NULL
);

CREATE TABLE telefone_regional (
    id_telefone SERIAL PRIMARY KEY,
    id_regional INTEGER NOT NULL REFERENCES regional(id_regional) ON DELETE CASCADE,
    numero VARCHAR(20) NOT NULL
);

CREATE TABLE modalidade (
    id_modalidade SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE escola_modalidade (
    id_escola INTEGER NOT NULL REFERENCES escola(id_escola) ON DELETE CASCADE,
    id_modalidade INTEGER NOT NULL REFERENCES modalidade(id_modalidade) ON DELETE CASCADE,
    PRIMARY KEY (id_escola, id_modalidade)
);

CREATE TABLE area (
    id_area SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela de Orientador (instituição)
CREATE TABLE orientador (
    id_orientador SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL UNIQUE REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    id_instituicao INTEGER NOT NULL REFERENCES instituicao(id_instituicao)
);

-- Professor agora vinculado à escola
CREATE TABLE professor (
    id_professor SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL UNIQUE REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    id_escola INTEGER NOT NULL REFERENCES escola(id_escola)
);

CREATE TABLE professor_area (
    id_professor INTEGER NOT NULL REFERENCES professor(id_professor) ON DELETE CASCADE,
    id_area INTEGER NOT NULL REFERENCES area(id_area) ON DELETE CASCADE,
    PRIMARY KEY (id_professor, id_area)
);

-- Estagiário
CREATE TABLE estagiario (
    id_estagiario SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL UNIQUE REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    id_curso INTEGER NOT NULL REFERENCES curso(id_curso),
    id_instituicao INTEGER NOT NULL REFERENCES instituicao(id_instituicao)
);

-- Tabela Estágio (substitui proposta_estagio)
CREATE TABLE estagio (
    id_estagio SERIAL PRIMARY KEY,
    id_estagiario INTEGER NOT NULL REFERENCES estagiario(id_estagiario),
    id_professor INTEGER NOT NULL REFERENCES professor(id_professor),
    id_orientador INTEGER NOT NULL REFERENCES orientador(id_orientador),
    id_escola INTEGER NOT NULL REFERENCES escola(id_escola),
    id_area INTEGER NOT NULL REFERENCES area(id_area),
    id_modalidade INTEGER NOT NULL REFERENCES modalidade(id_modalidade),
    status VARCHAR(30) NOT NULL, -- exemplo: pendente, em_andamento, concluido, etc
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Documentos do estágio
CREATE TABLE documento_estagio (
    id_documento SERIAL PRIMARY KEY,
    id_estagio INTEGER NOT NULL REFERENCES estagio(id_estagio),
    tipo_documento VARCHAR(50) NOT NULL, -- proposta, termo_compromisso, relatorio, etc
    caminho_pdf VARCHAR(200) NOT NULL,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Registro no blockchain (associado a estágio/documento)
CREATE TABLE blockchain_registro (
    id_registro SERIAL PRIMARY KEY,
    id_estagio INTEGER NOT NULL REFERENCES estagio(id_estagio),
    id_documento INTEGER REFERENCES documento_estagio(id_documento),
    tipo_evento VARCHAR(50) NOT NULL, -- proposta_submetida, doc_assinado, etapa_concluida, etc
    hash_blockchain VARCHAR(150) NOT NULL,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Histórico de etapas do estágio (cada transição, assinatura, documento, etc)
CREATE TABLE estagio_etapa (
    id_etapa SERIAL PRIMARY KEY,
    id_estagio INTEGER NOT NULL REFERENCES estagio(id_estagio),
    etapa VARCHAR(50) NOT NULL, -- exemplo: proposta_submetida, termo_compromisso, avaliação, conclusão
    data_inicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_fim TIMESTAMP,
    id_usuario_assinante INTEGER REFERENCES usuario(id_usuario), -- quem assinou (professor/orientador/estagiário)
    id_documento INTEGER REFERENCES documento_estagio(id_documento), -- documento da etapa
    hash_blockchain VARCHAR(150) -- se etapa registrada no blockchain
);

-- Dados iniciais (exemplo para perfis)
INSERT INTO tipo_usuario (nome) VALUES ('aluno'), ('professor'), ('orientador');
