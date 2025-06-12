-- 1. Usuário
CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL
);

-- 2. Tipo de Usuário (papel/perfil, ex: 'aluno', 'professor', 'gestor')
CREATE TABLE tipo_usuario (
    id_tipo SERIAL PRIMARY KEY,
    nome VARCHAR(30) NOT NULL UNIQUE
);

-- 3. Associação de Usuários e Tipos (um usuário pode ter vários perfis)
CREATE TABLE perfil_usuario (
    id_usuario INT NOT NULL,
    id_tipo INT NOT NULL,
    PRIMARY KEY (id_usuario, id_tipo),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo) REFERENCES tipo_usuario(id_tipo) ON DELETE CASCADE
);

-- 4. Instituição
CREATE TABLE instituicao (
    id_instituicao SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    cnpj VARCHAR(18) UNIQUE
);

-- 5. Curso
CREATE TABLE curso (
    id_curso SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_instituicao INT NOT NULL,
    FOREIGN KEY (id_instituicao) REFERENCES instituicao(id_instituicao)
);

-- 6. Estagiário (ajustado com id_instituicao)
CREATE TABLE estagiario (
    id_estagiario SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    id_curso INT NOT NULL,
    id_instituicao INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    FOREIGN KEY (id_instituicao) REFERENCES instituicao(id_instituicao)
);

-- 7. Professor
CREATE TABLE professor (
    id_professor SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    id_instituicao INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_instituicao) REFERENCES instituicao(id_instituicao)
);

-- 8. Regional
CREATE TABLE regional (
    id_regional SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

-- 9. Escola
CREATE TABLE escola (
    id_escola SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    endereco VARCHAR(200),
    id_regional INT,
    FOREIGN KEY (id_regional) REFERENCES regional(id_regional)
);

-- 10. Área
CREATE TABLE area (
    id_area SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- 11. Modalidade
CREATE TABLE modalidade (
    id_modalidade SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- 12. Proposta de Estágio
CREATE TABLE proposta_estagio (
    id_proposta SERIAL PRIMARY KEY,
    id_estagiario INT NOT NULL,
    id_professor INT NOT NULL,
    id_escola INT NOT NULL,
    id_area INT NOT NULL,
    id_modalidade INT NOT NULL,
    status VARCHAR(30) NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_estagiario) REFERENCES estagiario(id_estagiario),
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor),
    FOREIGN KEY (id_escola) REFERENCES escola(id_escola),
    FOREIGN KEY (id_area) REFERENCES area(id_area),
    FOREIGN KEY (id_modalidade) REFERENCES modalidade(id_modalidade)
);

-- 13. Documento de Estágio
CREATE TABLE documento_estagio (
    id_documento SERIAL PRIMARY KEY,
    id_proposta INT NOT NULL,
    tipo_documento VARCHAR(50) NOT NULL,
    caminho_pdf VARCHAR(200) NOT NULL,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_proposta) REFERENCES proposta_estagio(id_proposta)
);

-- 14. BlockchainRegistro
CREATE TABLE blockchain_registro (
    id_registro SERIAL PRIMARY KEY,
    id_proposta INT NOT NULL,
    id_documento INT,
    tipo_evento VARCHAR(50) NOT NULL,
    hash_blockchain VARCHAR(150) NOT NULL,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_proposta) REFERENCES proposta_estagio(id_proposta),
    FOREIGN KEY (id_documento) REFERENCES documento_estagio(id_documento)
);

-- 15. EscolaModalidade (N:M)
CREATE TABLE escola_modalidade (
    id_escola INT NOT NULL,
    id_modalidade INT NOT NULL,
    PRIMARY KEY (id_escola, id_modalidade),
    FOREIGN KEY (id_escola) REFERENCES escola(id_escola) ON DELETE CASCADE,
    FOREIGN KEY (id_modalidade) REFERENCES modalidade(id_modalidade) ON DELETE CASCADE
);

-- 16. ProfessorÁrea (N:M)
CREATE TABLE professor_area (
    id_professor INT NOT NULL,
    id_area INT NOT NULL,
    PRIMARY KEY (id_professor, id_area),
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor) ON DELETE CASCADE,
    FOREIGN KEY (id_area) REFERENCES area(id_area) ON DELETE CASCADE
);

-- 17. TelefoneEscola
CREATE TABLE telefone_escola (
    id_telefone SERIAL PRIMARY KEY,
    id_escola INT NOT NULL,
    numero VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_escola) REFERENCES escola(id_escola) ON DELETE CASCADE
);

-- 18. TelefoneRegional
CREATE TABLE telefone_regional (
    id_telefone SERIAL PRIMARY KEY,
    id_regional INT NOT NULL,
    numero VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_regional) REFERENCES regional(id_regional) ON DELETE CASCADE
);
