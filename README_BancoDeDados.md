# SIESU – Sistema para Gestão de Estágios Obrigatórios Supervisionado

**Banco de Dados Turma CIC0097 – 01/2025**
**Profa. Maristela Holanda**
**Integrantes:**

* Carlos Iunes – 22/2012738
* Laíssa Soares – 22/2032982
* Robson Bezerra da Silva – 22/2035661

---

## Introdução

O sistema **SIESU – Sistema de Estágio Supervisionado** visa facilitar a gestão de estágios obrigatórios, envolvendo instituições, estudantes, escolas, professores, documentos e registros em blockchain. Ele permite:

* Cadastro de orientadores, professores da rede de ensino e estagiários de quaisquer escolas ou faculdades cadastradas;
* Login e autenticação de usuários;
* Pesquisa e filtragem de dados (estagiários, instituições, propostas);
* Registro de etapas de estágio e acompanhamento da documentação necessária;
* Armazenamento de documentos e eventos na blockchain, garantindo integridade e histórico imutável.

## Documento final de entrega do trabalho:
[link - arquivo .docx](docs/Carlos_Laissa_Robson_Projeto_Final_08_07.docx)

## Modelo Entidade-Relacionamento (MER)

![MER do SIESU](docs/imagens/mer.png)

## Modelo Relacional (MR)

![Modelo Relacional](docs/imagens/mr.png)

## Modelagem Lógica

![Figura 3 - Modelagem Lógica](docs/imagens/modelagem_logica.png)

## Álgebra Relacional

**Consulta 1**: nome de cada estagiário, o nome do curso que faz e a instituição à qual pertence:

```sql
πnome_estagiario, nome_curso, nome_instituicao(
  (estagiario ⨝ estagiario.id_curso == curso.id_curso)
  ⨝ estagiario.id_instituicao == instituicao.id_instituicao
)
```

**Consulta 2**: apresenta um estágio, a escola onde acontece, sua modalidade e o nome do orientador:

```sql
πid_estagio, nome_escola, nome_modalidade, nome_orientador(
  ((estagio ⨝ estagio.id_escola == escola.id_escola)
   ⨝ estagio.id_modalidade == modalidade.id_modalidade)
   ⨝ estagio.id_orientador == orientador.id_orientador
)
```

**Consulta 3**: telefones das escolas e sua respectiva regional:

```sql
πnome_escola, numero_telefone, nome_regional(
  (telefone_escola ⨝ telefone_escola.id_escola == escola.id_escola)
  ⨝ escola.id_regional == regional.id_regional
)
```

**Consulta 4**: professores e suas áreas atuando em estágios:

```sql
πnome_professor, nome_area, id_estagio(
  ((estagio ⨝ estagio.id_professor == professor.id_professor)
   ⨝ professor.id_professor == professor_area.id_professor)
   ⨝ professor_area.id_area == area.id_area
)
```

**Consulta 5**: estágios e seus documentos registrados em blockchain:

```sql
πid_estagio, tipo_documento, hash_blockchain(
  (estagio ⨝ estagio.id_estagio == documento_estagio.id_estagio)
   ⨝ documento_estagio.id_documento == blockchain_registro.id_documento
)
```

## Formas Normais

### 1ª Forma Normal (1FN)

* **Regra**: Todos os campos contêm valores atômicos e não repetidos em uma única célula.
* **Conclusão**: A tabela `tb_estagiario_detalhado` atende à 1FN.

### 2ª Forma Normal (2FN)

* **Regra**: Estar em 1FN e todos os atributos não-chave dependem da chave primária inteira.
* **Conclusão**: Há apenas uma chave candidata (`id_estagiario`), e todos os atributos não-chave dependem dela. Portanto, atende à 2FN.

### 3ª Forma Normal (3FN)

* **Regra**: Estar em 2FN e nenhum atributo não-chave depende transitivamente da chave primária.
* **Observação**: Existem dependências transitivas:

  * `nome_usuario`, `email_usuario`, `senha_usuario`, `id_tipo_usuario` dependem de `id_usuario`;
  * `nome_tipo_usuario` depende de `id_tipo_usuario`;
  * `nome_curso` depende de `id_curso`;
  * `nome_instituicao`, `tipo_instituicao`, `cnpj` dependem de `id_instituicao`.
* **Solução**: Separar em entidades:

  * `tb_estagiario` (PK: `id_estagiario`)
  * `tb_usuario` (PK: `id_usuario`)
  * `tb_tipo_usuario` (PK: `id_tipo`)
  * `tb_curso` (PK: `id_curso`)
  * `tb_instituicao` (PK: `id_instituicao`)

## Script SQL para `tb_estagiario_detalhado`

```sql
SELECT
  e.*,
  u.nome AS nome_usuario,
  u.email AS email_usuario,
  u.senha AS senha_usuario,
  u.id_tipo AS id_tipo_usuario,
  tu.nome AS nome_tipo_usuario,
  c.nome AS nome_curso,
  i.nome AS nome_instituicao,
  i.tipo AS tipo_instituicao,
  i.cnpj
FROM estagiario e
INNER JOIN usuario u ON e.id_usuario = u.id_usuario
INNER JOIN tipo_usuario tu ON u.id_tipo = tu.id_tipo
INNER JOIN curso c ON e.id_curso = c.id_curso
INNER JOIN instituicao i ON e.id_instituicao = i.id_instituicao
WHERE tu.nome = 'aluno';
```

![Figura 4 - Tabela tb\_estagiario\_detalhado](docs/imagens/tb_estagiario_detalhado.png)

## Pasta de Models

A pasta de models está em `back_node/src/models/`. Você pode acessá-la [clicando aqui](back_node/src/models/).

### Exemplo de Model

**Arquivo:** `back_node/src/models/estagiarioModel.js`

```js
const db = require('../config/db');

async function getEstagiariosDetalhados() {
  const query = `
    SELECT
      e.*,
      u.nome AS nome_usuario,
      u.email AS email_usuario,
      u.senha AS senha_usuario,
      u.id_tipo AS id_tipo_usuario,
      tu.nome AS nome_tipo_usuario,
      c.nome AS nome_curso,
      i.nome AS nome_instituicao,
      i.tipo AS tipo_instituicao,
      i.cnpj
    FROM estagiario e
    INNER JOIN usuario u ON e.id_usuario = u.id_usuario
    INNER JOIN tipo_usuario tu ON u.id_tipo = tu.id_tipo
    INNER JOIN curso c ON e.id_curso = c.id_curso
    INNER JOIN instituicao i ON e.id_instituicao = i.id_instituicao
    WHERE tu.nome = 'aluno';
  `;
  const { rows } = await db.query(query);
  return rows;
}

module.exports = { getEstagiariosDetalhados };
```

## Explicação do SELECT de Exemplo

O `SELECT` acima cria uma visão agregada com detalhes do estagiário, do usuário, do tipo, do curso e da instituição. Veja a explicação passo a passo:

1. **`FROM estagiario e`**
   Seleciona a tabela principal `estagiario` com o alias **`e`**, que contém os IDs de usuário, curso e instituição.

2. **`e.*`**
   Inclui todas as colunas de `estagiario` sem listá-las individualmente.

3. **`INNER JOIN usuario u ON e.id_usuario = u.id_usuario`**
   Conecta `estagiario` à tabela `usuario` (alias **`u`**), trazendo nome, e-mail, senha e o ID do tipo de usuário.

4. **`u.nome AS nome_usuario, u.email AS email_usuario, u.senha AS senha_usuario, u.id_tipo AS id_tipo_usuario`**
   Renomeia colunas da tabela `usuario` para indicar claramente sua origem.

5. **`INNER JOIN tipo_usuario tu ON u.id_tipo = tu.id_tipo`**
   Une com `tipo_usuario` (alias **`tu`**) para obter o nome descritivo do tipo de usuário.

6. **`tu.nome AS nome_tipo_usuario`**
   Renomeia o campo do tipo de usuário para `nome_tipo_usuario`.

7. **`INNER JOIN curso c ON e.id_curso = c.id_curso`**
   Junta com `curso` (alias **`c`**) para obter o nome do curso.

8. **`c.nome AS nome_curso`**
   Renomeia o campo do curso para `nome_curso`.

9. **`INNER JOIN instituicao i ON e.id_instituicao = i.id_instituicao`**
   Conecta com `instituicao` (alias **`i`**) para obter nome, tipo e CNPJ da instituição.

10. **`i.nome AS nome_instituicao, i.tipo AS tipo_instituicao, i.cnpj`**
    Renomeia e inclui os campos da instituição.

11. **`WHERE tu.nome = 'aluno'`**
    Filtra apenas os registros cujo tipo de usuário é “aluno”.

**Objetivo:**
Reunir, em uma única consulta, informações dispersas em várias tabelas, facilitando relatórios e consultas que precisem dos detalhes completos do estagiário.
