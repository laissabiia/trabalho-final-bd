--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: area; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.area (
    id_area integer NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE public.area OWNER TO siesu01;

--
-- Name: area_id_area_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.area_id_area_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.area_id_area_seq OWNER TO siesu01;

--
-- Name: area_id_area_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.area_id_area_seq OWNED BY public.area.id_area;


--
-- Name: blockchain_registro; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.blockchain_registro (
    id_registro integer NOT NULL,
    id_proposta integer NOT NULL,
    id_documento integer,
    tipo_evento character varying(50) NOT NULL,
    hash_blockchain character varying(150) NOT NULL,
    data_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.blockchain_registro OWNER TO siesu01;

--
-- Name: blockchain_registro_id_registro_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.blockchain_registro_id_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blockchain_registro_id_registro_seq OWNER TO siesu01;

--
-- Name: blockchain_registro_id_registro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.blockchain_registro_id_registro_seq OWNED BY public.blockchain_registro.id_registro;


--
-- Name: curso; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.curso (
    id_curso integer NOT NULL,
    nome character varying(100) NOT NULL,
    id_instituicao integer NOT NULL
);


ALTER TABLE public.curso OWNER TO siesu01;

--
-- Name: curso_id_curso_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.curso_id_curso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.curso_id_curso_seq OWNER TO siesu01;

--
-- Name: curso_id_curso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.curso_id_curso_seq OWNED BY public.curso.id_curso;


--
-- Name: documento_estagio; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.documento_estagio (
    id_documento integer NOT NULL,
    id_proposta integer NOT NULL,
    tipo_documento character varying(50) NOT NULL,
    caminho_pdf character varying(200) NOT NULL,
    data_envio timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.documento_estagio OWNER TO siesu01;

--
-- Name: documento_estagio_id_documento_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.documento_estagio_id_documento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documento_estagio_id_documento_seq OWNER TO siesu01;

--
-- Name: documento_estagio_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.documento_estagio_id_documento_seq OWNED BY public.documento_estagio.id_documento;


--
-- Name: escola; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.escola (
    id_escola integer NOT NULL,
    nome character varying(150) NOT NULL,
    cnpj character varying(18) NOT NULL,
    endereco character varying(200),
    id_regional integer
);


ALTER TABLE public.escola OWNER TO siesu01;

--
-- Name: escola_id_escola_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.escola_id_escola_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.escola_id_escola_seq OWNER TO siesu01;

--
-- Name: escola_id_escola_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.escola_id_escola_seq OWNED BY public.escola.id_escola;


--
-- Name: escola_modalidade; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.escola_modalidade (
    id_escola integer NOT NULL,
    id_modalidade integer NOT NULL
);


ALTER TABLE public.escola_modalidade OWNER TO siesu01;

--
-- Name: estagiario; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.estagiario (
    id_estagiario integer NOT NULL,
    id_usuario integer NOT NULL,
    id_curso integer NOT NULL,
    id_instituicao integer NOT NULL
);


ALTER TABLE public.estagiario OWNER TO siesu01;

--
-- Name: estagiario_id_estagiario_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.estagiario_id_estagiario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estagiario_id_estagiario_seq OWNER TO siesu01;

--
-- Name: estagiario_id_estagiario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.estagiario_id_estagiario_seq OWNED BY public.estagiario.id_estagiario;


--
-- Name: instituicao; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.instituicao (
    id_instituicao integer NOT NULL,
    nome character varying(150) NOT NULL,
    tipo character varying(50) NOT NULL,
    cnpj character varying(18)
);


ALTER TABLE public.instituicao OWNER TO siesu01;

--
-- Name: instituicao_id_instituicao_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.instituicao_id_instituicao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instituicao_id_instituicao_seq OWNER TO siesu01;

--
-- Name: instituicao_id_instituicao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.instituicao_id_instituicao_seq OWNED BY public.instituicao.id_instituicao;


--
-- Name: modalidade; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.modalidade (
    id_modalidade integer NOT NULL,
    nome character varying(50) NOT NULL
);


ALTER TABLE public.modalidade OWNER TO siesu01;

--
-- Name: modalidade_id_modalidade_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.modalidade_id_modalidade_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modalidade_id_modalidade_seq OWNER TO siesu01;

--
-- Name: modalidade_id_modalidade_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.modalidade_id_modalidade_seq OWNED BY public.modalidade.id_modalidade;


--
-- Name: perfil_usuario; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.perfil_usuario (
    id_usuario integer NOT NULL,
    id_tipo integer NOT NULL
);


ALTER TABLE public.perfil_usuario OWNER TO siesu01;

--
-- Name: professor; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.professor (
    id_professor integer NOT NULL,
    id_usuario integer NOT NULL,
    id_instituicao integer NOT NULL
);


ALTER TABLE public.professor OWNER TO siesu01;

--
-- Name: professor_area; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.professor_area (
    id_professor integer NOT NULL,
    id_area integer NOT NULL
);


ALTER TABLE public.professor_area OWNER TO siesu01;

--
-- Name: professor_id_professor_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.professor_id_professor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.professor_id_professor_seq OWNER TO siesu01;

--
-- Name: professor_id_professor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.professor_id_professor_seq OWNED BY public.professor.id_professor;


--
-- Name: proposta_estagio; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.proposta_estagio (
    id_proposta integer NOT NULL,
    id_estagiario integer NOT NULL,
    id_professor integer NOT NULL,
    id_escola integer NOT NULL,
    id_area integer NOT NULL,
    id_modalidade integer NOT NULL,
    status character varying(30) NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.proposta_estagio OWNER TO siesu01;

--
-- Name: proposta_estagio_id_proposta_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.proposta_estagio_id_proposta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proposta_estagio_id_proposta_seq OWNER TO siesu01;

--
-- Name: proposta_estagio_id_proposta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.proposta_estagio_id_proposta_seq OWNED BY public.proposta_estagio.id_proposta;


--
-- Name: regional; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.regional (
    id_regional integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100)
);


ALTER TABLE public.regional OWNER TO siesu01;

--
-- Name: regional_id_regional_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.regional_id_regional_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regional_id_regional_seq OWNER TO siesu01;

--
-- Name: regional_id_regional_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.regional_id_regional_seq OWNED BY public.regional.id_regional;


--
-- Name: telefone_escola; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.telefone_escola (
    id_telefone integer NOT NULL,
    id_escola integer NOT NULL,
    numero character varying(20) NOT NULL
);


ALTER TABLE public.telefone_escola OWNER TO siesu01;

--
-- Name: telefone_escola_id_telefone_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.telefone_escola_id_telefone_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.telefone_escola_id_telefone_seq OWNER TO siesu01;

--
-- Name: telefone_escola_id_telefone_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.telefone_escola_id_telefone_seq OWNED BY public.telefone_escola.id_telefone;


--
-- Name: telefone_regional; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.telefone_regional (
    id_telefone integer NOT NULL,
    id_regional integer NOT NULL,
    numero character varying(20) NOT NULL
);


ALTER TABLE public.telefone_regional OWNER TO siesu01;

--
-- Name: telefone_regional_id_telefone_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.telefone_regional_id_telefone_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.telefone_regional_id_telefone_seq OWNER TO siesu01;

--
-- Name: telefone_regional_id_telefone_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.telefone_regional_id_telefone_seq OWNED BY public.telefone_regional.id_telefone;


--
-- Name: tipo_usuario; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.tipo_usuario (
    id_tipo integer NOT NULL,
    nome character varying(30) NOT NULL
);


ALTER TABLE public.tipo_usuario OWNER TO siesu01;

--
-- Name: tipo_usuario_id_tipo_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.tipo_usuario_id_tipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_usuario_id_tipo_seq OWNER TO siesu01;

--
-- Name: tipo_usuario_id_tipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.tipo_usuario_id_tipo_seq OWNED BY public.tipo_usuario.id_tipo;


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    senha character varying(100) NOT NULL
);


ALTER TABLE public.usuario OWNER TO siesu01;

--
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_id_usuario_seq OWNER TO siesu01;

--
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- Name: area id_area; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.area ALTER COLUMN id_area SET DEFAULT nextval('public.area_id_area_seq'::regclass);


--
-- Name: blockchain_registro id_registro; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.blockchain_registro ALTER COLUMN id_registro SET DEFAULT nextval('public.blockchain_registro_id_registro_seq'::regclass);


--
-- Name: curso id_curso; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.curso ALTER COLUMN id_curso SET DEFAULT nextval('public.curso_id_curso_seq'::regclass);


--
-- Name: documento_estagio id_documento; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.documento_estagio ALTER COLUMN id_documento SET DEFAULT nextval('public.documento_estagio_id_documento_seq'::regclass);


--
-- Name: escola id_escola; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola ALTER COLUMN id_escola SET DEFAULT nextval('public.escola_id_escola_seq'::regclass);


--
-- Name: estagiario id_estagiario; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.estagiario ALTER COLUMN id_estagiario SET DEFAULT nextval('public.estagiario_id_estagiario_seq'::regclass);


--
-- Name: instituicao id_instituicao; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.instituicao ALTER COLUMN id_instituicao SET DEFAULT nextval('public.instituicao_id_instituicao_seq'::regclass);


--
-- Name: modalidade id_modalidade; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.modalidade ALTER COLUMN id_modalidade SET DEFAULT nextval('public.modalidade_id_modalidade_seq'::regclass);


--
-- Name: professor id_professor; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor ALTER COLUMN id_professor SET DEFAULT nextval('public.professor_id_professor_seq'::regclass);


--
-- Name: proposta_estagio id_proposta; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio ALTER COLUMN id_proposta SET DEFAULT nextval('public.proposta_estagio_id_proposta_seq'::regclass);


--
-- Name: regional id_regional; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.regional ALTER COLUMN id_regional SET DEFAULT nextval('public.regional_id_regional_seq'::regclass);


--
-- Name: telefone_escola id_telefone; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.telefone_escola ALTER COLUMN id_telefone SET DEFAULT nextval('public.telefone_escola_id_telefone_seq'::regclass);


--
-- Name: telefone_regional id_telefone; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.telefone_regional ALTER COLUMN id_telefone SET DEFAULT nextval('public.telefone_regional_id_telefone_seq'::regclass);


--
-- Name: tipo_usuario id_tipo; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.tipo_usuario ALTER COLUMN id_tipo SET DEFAULT nextval('public.tipo_usuario_id_tipo_seq'::regclass);


--
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.area (id_area, nome) FROM stdin;
1	Robótica
2	Algorítmos
3	Computação
\.


--
-- Data for Name: blockchain_registro; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.blockchain_registro (id_registro, id_proposta, id_documento, tipo_evento, hash_blockchain, data_registro) FROM stdin;
2	5	\N	proposta_submetida	000095de20a38c989503283178c53654b5531135580968503c7b13a3b99432a0	2025-06-09 22:44:04.532532
3	6	\N	proposta_submetida	0000e97f41c617cfc06044f7626ee8d80ac8d96a6155c584906821247b714bba	2025-06-09 22:57:57.991808
\.


--
-- Data for Name: curso; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.curso (id_curso, nome, id_instituicao) FROM stdin;
1	Licenciatura em Computação	1
2	Matemática	1
3	Português	1
4	Licenciatura em Computação	2
5	Matemática	2
6	Português	2
\.


--
-- Data for Name: documento_estagio; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.documento_estagio (id_documento, id_proposta, tipo_documento, caminho_pdf, data_envio) FROM stdin;
\.


--
-- Data for Name: escola; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.escola (id_escola, nome, cnpj, endereco, id_regional) FROM stdin;
1	Ced 01 do Itapoa	12.345.678/0001-90	\N	2
2	Cef 01 do Gama	23.456.789/0001-01	\N	2
3	Ec 08 de Taguatinga	34.567.890/0001-12	\N	2
4	Ec 106 Norte	45.678.901/0001-23	\N	1
\.


--
-- Data for Name: escola_modalidade; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.escola_modalidade (id_escola, id_modalidade) FROM stdin;
1	1
1	2
2	2
3	1
3	2
4	1
\.


--
-- Data for Name: estagiario; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.estagiario (id_estagiario, id_usuario, id_curso, id_instituicao) FROM stdin;
2	5	1	1
\.


--
-- Data for Name: instituicao; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.instituicao (id_instituicao, nome, tipo, cnpj) FROM stdin;
1	UnB	Universidade	00.000.000/0001-00
2	CeuB	Centro Universitário	11.111.111/0001-11
\.


--
-- Data for Name: modalidade; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.modalidade (id_modalidade, nome) FROM stdin;
1	Ensino Médio
2	Ensino Fundamental
3	EJA
\.


--
-- Data for Name: perfil_usuario; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.perfil_usuario (id_usuario, id_tipo) FROM stdin;
1	1
3	2
4	2
5	1
\.


--
-- Data for Name: professor; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.professor (id_professor, id_usuario, id_instituicao) FROM stdin;
1	3	1
2	4	1
\.


--
-- Data for Name: professor_area; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.professor_area (id_professor, id_area) FROM stdin;
1	1
1	2
2	3
\.


--
-- Data for Name: proposta_estagio; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.proposta_estagio (id_proposta, id_estagiario, id_professor, id_escola, id_area, id_modalidade, status, data_criacao) FROM stdin;
4	2	2	4	1	1	pendente	2025-06-09 22:41:00.069303
5	2	2	4	1	2	pendente	2025-06-09 22:44:04.377066
6	2	2	4	1	2	pendente	2025-06-09 22:57:57.839198
7	2	2	4	1	2	pendente	2025-06-09 23:15:24.102466
8	2	2	4	1	1	pendente	2025-06-09 23:18:09.160546
9	2	2	4	1	2	pendente	2025-06-09 23:21:47.789771
10	2	2	4	1	1	pendente	2025-06-09 23:24:24.711533
\.


--
-- Data for Name: regional; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.regional (id_regional, nome, email) FROM stdin;
1	Plano Piloto	ppiloto@edu.br
2	Taguatinga	tagua@edu.br
\.


--
-- Data for Name: telefone_escola; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.telefone_escola (id_telefone, id_escola, numero) FROM stdin;
\.


--
-- Data for Name: telefone_regional; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.telefone_regional (id_telefone, id_regional, numero) FROM stdin;
\.


--
-- Data for Name: tipo_usuario; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.tipo_usuario (id_tipo, nome) FROM stdin;
1	aluno
2	professor
3	gestor
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.usuario (id_usuario, nome, email, senha) FROM stdin;
1	CARLOS E I OLIVEIRA	carloseduardoiunes@gmail.com	$2b$10$J5IFN2lckM3cSRCxG9E4iOMxBjDq8olcM3kkmmyqH25WItuYewvw2
3	ladeira	ladeira@unb.br	$2b$10$VYiV6YWib/T9vz61qZpBo.gFeCJGU1nskPh5MQpJn/xMkGqIvPHSO
4	maristelaProf	maristela@unb.br	$2b$10$F3HfrK1QroyIlJ0uudiPRuIdHOWmWpvveBCBOjS6hZorIeFhYKCtG
5	robson	robson@gmail.com	$2b$10$sd9VNaylHE31PwkHc.gVyOS7fFqG5wSRiOqvSlAjbGxYDuSXov376
6	CARLOS E I OLIVEIRA	baraoiunes@gmail.com	$2b$10$Q2QL6pkV4Uf5tTUsM6RmR.R4IwVzGszS3ZQLcpgsI5bQomThdJpXi
9	CARLOS E I OLIVEIRA	edu@gmail.com	$2b$10$FPuIA0GaKx2RHInBpRuTxOER0RYVzFqlCngXRw0yVq9rAKaiLms1W
\.


--
-- Name: area_id_area_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.area_id_area_seq', 3, true);


--
-- Name: blockchain_registro_id_registro_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.blockchain_registro_id_registro_seq', 3, true);


--
-- Name: curso_id_curso_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.curso_id_curso_seq', 6, true);


--
-- Name: documento_estagio_id_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.documento_estagio_id_documento_seq', 1, false);


--
-- Name: escola_id_escola_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.escola_id_escola_seq', 4, true);


--
-- Name: estagiario_id_estagiario_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.estagiario_id_estagiario_seq', 2, true);


--
-- Name: instituicao_id_instituicao_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.instituicao_id_instituicao_seq', 2, true);


--
-- Name: modalidade_id_modalidade_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.modalidade_id_modalidade_seq', 3, true);


--
-- Name: professor_id_professor_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.professor_id_professor_seq', 2, true);


--
-- Name: proposta_estagio_id_proposta_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.proposta_estagio_id_proposta_seq', 10, true);


--
-- Name: regional_id_regional_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.regional_id_regional_seq', 1, false);


--
-- Name: telefone_escola_id_telefone_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.telefone_escola_id_telefone_seq', 1, false);


--
-- Name: telefone_regional_id_telefone_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.telefone_regional_id_telefone_seq', 1, false);


--
-- Name: tipo_usuario_id_tipo_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.tipo_usuario_id_tipo_seq', 3, true);


--
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 9, true);


--
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (id_area);


--
-- Name: blockchain_registro blockchain_registro_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_pkey PRIMARY KEY (id_registro);


--
-- Name: curso curso_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (id_curso);


--
-- Name: documento_estagio documento_estagio_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.documento_estagio
    ADD CONSTRAINT documento_estagio_pkey PRIMARY KEY (id_documento);


--
-- Name: escola escola_cnpj_key; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_cnpj_key UNIQUE (cnpj);


--
-- Name: escola_modalidade escola_modalidade_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_pkey PRIMARY KEY (id_escola, id_modalidade);


--
-- Name: escola escola_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_pkey PRIMARY KEY (id_escola);


--
-- Name: estagiario estagiario_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_usuario_key UNIQUE (id_usuario);


--
-- Name: estagiario estagiario_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_pkey PRIMARY KEY (id_estagiario);


--
-- Name: instituicao instituicao_cnpj_key; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.instituicao
    ADD CONSTRAINT instituicao_cnpj_key UNIQUE (cnpj);


--
-- Name: instituicao instituicao_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.instituicao
    ADD CONSTRAINT instituicao_pkey PRIMARY KEY (id_instituicao);


--
-- Name: modalidade modalidade_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.modalidade
    ADD CONSTRAINT modalidade_pkey PRIMARY KEY (id_modalidade);


--
-- Name: perfil_usuario perfil_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.perfil_usuario
    ADD CONSTRAINT perfil_usuario_pkey PRIMARY KEY (id_usuario, id_tipo);


--
-- Name: professor_area professor_area_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_pkey PRIMARY KEY (id_professor, id_area);


--
-- Name: professor professor_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_usuario_key UNIQUE (id_usuario);


--
-- Name: professor professor_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_pkey PRIMARY KEY (id_professor);


--
-- Name: proposta_estagio proposta_estagio_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio
    ADD CONSTRAINT proposta_estagio_pkey PRIMARY KEY (id_proposta);


--
-- Name: regional regional_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.regional
    ADD CONSTRAINT regional_pkey PRIMARY KEY (id_regional);


--
-- Name: telefone_escola telefone_escola_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.telefone_escola
    ADD CONSTRAINT telefone_escola_pkey PRIMARY KEY (id_telefone);


--
-- Name: telefone_regional telefone_regional_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.telefone_regional
    ADD CONSTRAINT telefone_regional_pkey PRIMARY KEY (id_telefone);


--
-- Name: tipo_usuario tipo_usuario_nome_key; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_nome_key UNIQUE (nome);


--
-- Name: tipo_usuario tipo_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_pkey PRIMARY KEY (id_tipo);


--
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- Name: blockchain_registro blockchain_registro_id_documento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_id_documento_fkey FOREIGN KEY (id_documento) REFERENCES public.documento_estagio(id_documento);


--
-- Name: blockchain_registro blockchain_registro_id_proposta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_id_proposta_fkey FOREIGN KEY (id_proposta) REFERENCES public.proposta_estagio(id_proposta);


--
-- Name: curso curso_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);


--
-- Name: documento_estagio documento_estagio_id_proposta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.documento_estagio
    ADD CONSTRAINT documento_estagio_id_proposta_fkey FOREIGN KEY (id_proposta) REFERENCES public.proposta_estagio(id_proposta);


--
-- Name: escola escola_id_regional_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_id_regional_fkey FOREIGN KEY (id_regional) REFERENCES public.regional(id_regional);


--
-- Name: escola_modalidade escola_modalidade_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola) ON DELETE CASCADE;


--
-- Name: escola_modalidade escola_modalidade_id_modalidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_id_modalidade_fkey FOREIGN KEY (id_modalidade) REFERENCES public.modalidade(id_modalidade) ON DELETE CASCADE;


--
-- Name: estagiario estagiario_id_curso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_curso_fkey FOREIGN KEY (id_curso) REFERENCES public.curso(id_curso);


--
-- Name: estagiario estagiario_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);


--
-- Name: estagiario estagiario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- Name: perfil_usuario perfil_usuario_id_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.perfil_usuario
    ADD CONSTRAINT perfil_usuario_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES public.tipo_usuario(id_tipo) ON DELETE CASCADE;


--
-- Name: perfil_usuario perfil_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.perfil_usuario
    ADD CONSTRAINT perfil_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- Name: professor_area professor_area_id_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_id_area_fkey FOREIGN KEY (id_area) REFERENCES public.area(id_area) ON DELETE CASCADE;


--
-- Name: professor_area professor_area_id_professor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_id_professor_fkey FOREIGN KEY (id_professor) REFERENCES public.professor(id_professor) ON DELETE CASCADE;


--
-- Name: professor professor_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);


--
-- Name: professor professor_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- Name: proposta_estagio proposta_estagio_id_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio
    ADD CONSTRAINT proposta_estagio_id_area_fkey FOREIGN KEY (id_area) REFERENCES public.area(id_area);


--
-- Name: proposta_estagio proposta_estagio_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio
    ADD CONSTRAINT proposta_estagio_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola);


--
-- Name: proposta_estagio proposta_estagio_id_estagiario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio
    ADD CONSTRAINT proposta_estagio_id_estagiario_fkey FOREIGN KEY (id_estagiario) REFERENCES public.estagiario(id_estagiario);


--
-- Name: proposta_estagio proposta_estagio_id_modalidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio
    ADD CONSTRAINT proposta_estagio_id_modalidade_fkey FOREIGN KEY (id_modalidade) REFERENCES public.modalidade(id_modalidade);


--
-- Name: proposta_estagio proposta_estagio_id_professor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio
    ADD CONSTRAINT proposta_estagio_id_professor_fkey FOREIGN KEY (id_professor) REFERENCES public.professor(id_professor);


--
-- Name: telefone_escola telefone_escola_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.telefone_escola
    ADD CONSTRAINT telefone_escola_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola) ON DELETE CASCADE;


--
-- Name: telefone_regional telefone_regional_id_regional_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.telefone_regional
    ADD CONSTRAINT telefone_regional_id_regional_fkey FOREIGN KEY (id_regional) REFERENCES public.regional(id_regional) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

