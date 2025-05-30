# Sistema para Localização e Consulta de Escolas para Estágio Obrigatório Supervisionado

## 📌 Descrição

Este projeto tem como objetivo facilitar o acesso e a gestão de informações sobre escolas públicas do Distrito Federal que oferecem oportunidades de **estágio obrigatório supervisionado** para estudantes da **Licenciatura em Computação da Universidade de Brasília (UnB)**.

Atualmente, os discentes enfrentam dificuldades para encontrar escolas com disciplinas de Computação ou Informática, tornando o processo exaustivo e descentralizado. O sistema proposto visa centralizar essas informações, permitindo que apenas membros da UnB possam **consultar, filtrar, adicionar e localizar** escolas disponíveis para a realização de estágio supervisionado.

Este projeto está sendo desenvolvido no contexto da disciplina **CIC0097 - Banco de Dados** da UnB, sob orientação da professora **PhD Maristela Terto de Holanda**.

## 🧱 Estrutura do Banco de Dados

O banco de dados foi modelado para representar os principais agentes e relações envolvidas no processo de estágio. A estrutura inclui:

- Cadastro de contas de acesso (usuários da UnB);
- Escolas e regionais de ensino do DF;
- Discentes e professores da UnB;
- Professores da SEEDF vinculados às escolas;
- Áreas de atuação e modalidades de ensino;
- Tabelas auxiliares de telefone e relacionamento.

Neste repositório, encontra-se:
- A modelagem Conceitual e Lógica na pasta [`diagramas`](diagramas);
- A modelagem Física, *script* de criação do banco de dados, no arquivo [`modelo_fisico.sql`](modelo_fisico.sql).

## 🛠️ Tecnologias Utilizadas

- **SQL** – para modelagem e criação do banco de dados relacional.
- **BRModelo** – ferramenta utilizada para a modelagem conceitual e geração automática do script SQL.

## 📁 Arquivos do Projeto

- `modelo_fisico.sql` – script SQL com a criação de tabelas, chaves primárias e estrangeiras.

## 🚧 Futuras Etapas

- Desenvolvimento da interface web para consulta e cadastro de escolas.
- Integração com autenticação via conta institucional da UnB.
- Funcionalidades de busca e filtros personalizados (por regional, modalidade, área, etc).

## 👨‍🏫 Público-Alvo

- Estudantes da Licenciatura em Computação da UnB
- Professores orientadores de estágio
- Coordenadores e responsáveis pela prática pedagógica

## 📄 Licença

Este projeto está sob a Licença MIT. Veja o arquivo [`LICENSE`](LICENSE).

---

> Desenvolvido com 💻 por Carlos Iunes e Robson Silva.
