# SIESU – Sistema de Estágio Unificado

# PROJETO UNIFICADO  

Este repositório reúne a documentação do **SIESU – Sistema de Estágio Unificado**, contemplando três entregas distintas para diferentes disciplinas. A seguir, apresentam-se a visão geral do projeto, a arquitetura adotada e os links para os README específicos de cada trabalho.

---

## Visão Geral do Projeto

O **SIESU** é um sistema web responsivo, desenvolvido em **Node.js** (backend com Express e PostgreSQL) e **HTML/JavaScript** (frontend), com os seguintes objetivos:

* **Gerenciar contas de usuários** (estagiários, professores, orientadores) com autenticação JWT;
* **Cadastrar e consultar** escolas, cursos, propostas de estágio e etapas de documentação;
* **Registrar etapas e documentos** em blockchain, garantindo a integridade e histórico imutável;

---

## Arquitetura

1. **Camada de Apresentação (Frontend)**

   * HTML, CSS e JavaScript puro;
   * Comunicação via fetch API (REST) e WebSockets;

2. **Camada de Negócio (Backend)**

   * **Node.js** com **Express**;
   * Autenticação e autorização JWT;
   * Separação em controllers, services e models;

3. **Banco de Dados**

   * **PostgreSQL**;
   * Modelagem em MER, MR e normalização até 3FN;

4. **Integração Blockchain**

   * Registro de eventos/documentos via smart contracts (externo);


---

## Entregas por Disciplina

1. **Banco de Dados**  (CIC0097 – 01/2025)

   * **Profª Maristela Holanda**
   * [README_BancoDeDados](README_BancoDeDados.md)

2. **Linguagem de Programação**  (CIC0093 – 01/2025)

   * **Prof. Marcelo Ladeira**
   * [README_LinguagemProg](README_LinguagemProg.md)


---

