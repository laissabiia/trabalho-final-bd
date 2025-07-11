--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 17.5

-- Started on 2025-06-09 22:30:46

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3143 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 610942)
-- Name: area; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.area (
    id_area integer NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE public.area OWNER TO siesu01;

--
-- TOC entry 219 (class 1259 OID 610940)
-- Name: area_id_area_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.area_id_area_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.area_id_area_seq OWNER TO siesu01;

--
-- TOC entry 3145 (class 0 OID 0)
-- Dependencies: 219
-- Name: area_id_area_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.area_id_area_seq OWNED BY public.area.id_area;


--
-- TOC entry 228 (class 1259 OID 611006)
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
-- TOC entry 227 (class 1259 OID 611004)
-- Name: blockchain_registro_id_registro_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.blockchain_registro_id_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.blockchain_registro_id_registro_seq OWNER TO siesu01;

--
-- TOC entry 3146 (class 0 OID 0)
-- Dependencies: 227
-- Name: blockchain_registro_id_registro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.blockchain_registro_id_registro_seq OWNED BY public.blockchain_registro.id_registro;


--
-- TOC entry 210 (class 1259 OID 610861)
-- Name: curso; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.curso (
    id_curso integer NOT NULL,
    nome character varying(100) NOT NULL,
    id_instituicao integer NOT NULL
);


ALTER TABLE public.curso OWNER TO siesu01;

--
-- TOC entry 209 (class 1259 OID 610859)
-- Name: curso_id_curso_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.curso_id_curso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.curso_id_curso_seq OWNER TO siesu01;

--
-- TOC entry 3147 (class 0 OID 0)
-- Dependencies: 209
-- Name: curso_id_curso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.curso_id_curso_seq OWNED BY public.curso.id_curso;


--
-- TOC entry 226 (class 1259 OID 610992)
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
-- TOC entry 225 (class 1259 OID 610990)
-- Name: documento_estagio_id_documento_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.documento_estagio_id_documento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.documento_estagio_id_documento_seq OWNER TO siesu01;

--
-- TOC entry 3148 (class 0 OID 0)
-- Dependencies: 225
-- Name: documento_estagio_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.documento_estagio_id_documento_seq OWNED BY public.documento_estagio.id_documento;


--
-- TOC entry 218 (class 1259 OID 610927)
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
-- TOC entry 217 (class 1259 OID 610925)
-- Name: escola_id_escola_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.escola_id_escola_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.escola_id_escola_seq OWNER TO siesu01;

--
-- TOC entry 3149 (class 0 OID 0)
-- Dependencies: 217
-- Name: escola_id_escola_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.escola_id_escola_seq OWNED BY public.escola.id_escola;


--
-- TOC entry 229 (class 1259 OID 611023)
-- Name: escola_modalidade; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.escola_modalidade (
    id_escola integer NOT NULL,
    id_modalidade integer NOT NULL
);


ALTER TABLE public.escola_modalidade OWNER TO siesu01;

--
-- TOC entry 212 (class 1259 OID 610874)
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
-- TOC entry 211 (class 1259 OID 610872)
-- Name: estagiario_id_estagiario_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.estagiario_id_estagiario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estagiario_id_estagiario_seq OWNER TO siesu01;

--
-- TOC entry 3150 (class 0 OID 0)
-- Dependencies: 211
-- Name: estagiario_id_estagiario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.estagiario_id_estagiario_seq OWNED BY public.estagiario.id_estagiario;


--
-- TOC entry 208 (class 1259 OID 610851)
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
-- TOC entry 207 (class 1259 OID 610849)
-- Name: instituicao_id_instituicao_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.instituicao_id_instituicao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instituicao_id_instituicao_seq OWNER TO siesu01;

--
-- TOC entry 3151 (class 0 OID 0)
-- Dependencies: 207
-- Name: instituicao_id_instituicao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.instituicao_id_instituicao_seq OWNED BY public.instituicao.id_instituicao;


--
-- TOC entry 222 (class 1259 OID 610950)
-- Name: modalidade; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.modalidade (
    id_modalidade integer NOT NULL,
    nome character varying(50) NOT NULL
);


ALTER TABLE public.modalidade OWNER TO siesu01;

--
-- TOC entry 221 (class 1259 OID 610948)
-- Name: modalidade_id_modalidade_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.modalidade_id_modalidade_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.modalidade_id_modalidade_seq OWNER TO siesu01;

--
-- TOC entry 3152 (class 0 OID 0)
-- Dependencies: 221
-- Name: modalidade_id_modalidade_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.modalidade_id_modalidade_seq OWNED BY public.modalidade.id_modalidade;


--
-- TOC entry 206 (class 1259 OID 610834)
-- Name: perfil_usuario; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.perfil_usuario (
    id_usuario integer NOT NULL,
    id_tipo integer NOT NULL
);


ALTER TABLE public.perfil_usuario OWNER TO siesu01;

--
-- TOC entry 214 (class 1259 OID 610899)
-- Name: professor; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.professor (
    id_professor integer NOT NULL,
    id_usuario integer NOT NULL,
    id_instituicao integer NOT NULL
);


ALTER TABLE public.professor OWNER TO siesu01;

--
-- TOC entry 230 (class 1259 OID 611038)
-- Name: professor_area; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.professor_area (
    id_professor integer NOT NULL,
    id_area integer NOT NULL
);


ALTER TABLE public.professor_area OWNER TO siesu01;

--
-- TOC entry 213 (class 1259 OID 610897)
-- Name: professor_id_professor_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.professor_id_professor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.professor_id_professor_seq OWNER TO siesu01;

--
-- TOC entry 3153 (class 0 OID 0)
-- Dependencies: 213
-- Name: professor_id_professor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.professor_id_professor_seq OWNED BY public.professor.id_professor;


--
-- TOC entry 224 (class 1259 OID 610958)
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
-- TOC entry 223 (class 1259 OID 610956)
-- Name: proposta_estagio_id_proposta_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.proposta_estagio_id_proposta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proposta_estagio_id_proposta_seq OWNER TO siesu01;

--
-- TOC entry 3154 (class 0 OID 0)
-- Dependencies: 223
-- Name: proposta_estagio_id_proposta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.proposta_estagio_id_proposta_seq OWNED BY public.proposta_estagio.id_proposta;


--
-- TOC entry 216 (class 1259 OID 610919)
-- Name: regional; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.regional (
    id_regional integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100)
);


ALTER TABLE public.regional OWNER TO siesu01;

--
-- TOC entry 215 (class 1259 OID 610917)
-- Name: regional_id_regional_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.regional_id_regional_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regional_id_regional_seq OWNER TO siesu01;

--
-- TOC entry 3155 (class 0 OID 0)
-- Dependencies: 215
-- Name: regional_id_regional_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.regional_id_regional_seq OWNED BY public.regional.id_regional;


--
-- TOC entry 232 (class 1259 OID 611055)
-- Name: telefone_escola; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.telefone_escola (
    id_telefone integer NOT NULL,
    id_escola integer NOT NULL,
    numero character varying(20) NOT NULL
);


ALTER TABLE public.telefone_escola OWNER TO siesu01;

--
-- TOC entry 231 (class 1259 OID 611053)
-- Name: telefone_escola_id_telefone_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.telefone_escola_id_telefone_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.telefone_escola_id_telefone_seq OWNER TO siesu01;

--
-- TOC entry 3156 (class 0 OID 0)
-- Dependencies: 231
-- Name: telefone_escola_id_telefone_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.telefone_escola_id_telefone_seq OWNED BY public.telefone_escola.id_telefone;


--
-- TOC entry 234 (class 1259 OID 611068)
-- Name: telefone_regional; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.telefone_regional (
    id_telefone integer NOT NULL,
    id_regional integer NOT NULL,
    numero character varying(20) NOT NULL
);


ALTER TABLE public.telefone_regional OWNER TO siesu01;

--
-- TOC entry 233 (class 1259 OID 611066)
-- Name: telefone_regional_id_telefone_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.telefone_regional_id_telefone_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.telefone_regional_id_telefone_seq OWNER TO siesu01;

--
-- TOC entry 3157 (class 0 OID 0)
-- Dependencies: 233
-- Name: telefone_regional_id_telefone_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.telefone_regional_id_telefone_seq OWNED BY public.telefone_regional.id_telefone;


--
-- TOC entry 205 (class 1259 OID 610826)
-- Name: tipo_usuario; Type: TABLE; Schema: public; Owner: siesu01
--

CREATE TABLE public.tipo_usuario (
    id_tipo integer NOT NULL,
    nome character varying(30) NOT NULL
);


ALTER TABLE public.tipo_usuario OWNER TO siesu01;

--
-- TOC entry 204 (class 1259 OID 610824)
-- Name: tipo_usuario_id_tipo_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.tipo_usuario_id_tipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipo_usuario_id_tipo_seq OWNER TO siesu01;

--
-- TOC entry 3158 (class 0 OID 0)
-- Dependencies: 204
-- Name: tipo_usuario_id_tipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.tipo_usuario_id_tipo_seq OWNED BY public.tipo_usuario.id_tipo;


--
-- TOC entry 203 (class 1259 OID 610816)
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
-- TOC entry 202 (class 1259 OID 610814)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: siesu01
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_id_usuario_seq OWNER TO siesu01;

--
-- TOC entry 3159 (class 0 OID 0)
-- Dependencies: 202
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: siesu01
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 2898 (class 2604 OID 610945)
-- Name: area id_area; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.area ALTER COLUMN id_area SET DEFAULT nextval('public.area_id_area_seq'::regclass);


--
-- TOC entry 2904 (class 2604 OID 611009)
-- Name: blockchain_registro id_registro; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.blockchain_registro ALTER COLUMN id_registro SET DEFAULT nextval('public.blockchain_registro_id_registro_seq'::regclass);


--
-- TOC entry 2893 (class 2604 OID 610864)
-- Name: curso id_curso; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.curso ALTER COLUMN id_curso SET DEFAULT nextval('public.curso_id_curso_seq'::regclass);


--
-- TOC entry 2902 (class 2604 OID 610995)
-- Name: documento_estagio id_documento; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.documento_estagio ALTER COLUMN id_documento SET DEFAULT nextval('public.documento_estagio_id_documento_seq'::regclass);


--
-- TOC entry 2897 (class 2604 OID 610930)
-- Name: escola id_escola; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola ALTER COLUMN id_escola SET DEFAULT nextval('public.escola_id_escola_seq'::regclass);


--
-- TOC entry 2894 (class 2604 OID 610877)
-- Name: estagiario id_estagiario; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.estagiario ALTER COLUMN id_estagiario SET DEFAULT nextval('public.estagiario_id_estagiario_seq'::regclass);


--
-- TOC entry 2892 (class 2604 OID 610854)
-- Name: instituicao id_instituicao; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.instituicao ALTER COLUMN id_instituicao SET DEFAULT nextval('public.instituicao_id_instituicao_seq'::regclass);


--
-- TOC entry 2899 (class 2604 OID 610953)
-- Name: modalidade id_modalidade; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.modalidade ALTER COLUMN id_modalidade SET DEFAULT nextval('public.modalidade_id_modalidade_seq'::regclass);


--
-- TOC entry 2895 (class 2604 OID 610902)
-- Name: professor id_professor; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor ALTER COLUMN id_professor SET DEFAULT nextval('public.professor_id_professor_seq'::regclass);


--
-- TOC entry 2900 (class 2604 OID 610961)
-- Name: proposta_estagio id_proposta; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio ALTER COLUMN id_proposta SET DEFAULT nextval('public.proposta_estagio_id_proposta_seq'::regclass);


--
-- TOC entry 2896 (class 2604 OID 610922)
-- Name: regional id_regional; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.regional ALTER COLUMN id_regional SET DEFAULT nextval('public.regional_id_regional_seq'::regclass);


--
-- TOC entry 2906 (class 2604 OID 611058)
-- Name: telefone_escola id_telefone; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.telefone_escola ALTER COLUMN id_telefone SET DEFAULT nextval('public.telefone_escola_id_telefone_seq'::regclass);


--
-- TOC entry 2907 (class 2604 OID 611071)
-- Name: telefone_regional id_telefone; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.telefone_regional ALTER COLUMN id_telefone SET DEFAULT nextval('public.telefone_regional_id_telefone_seq'::regclass);


--
-- TOC entry 2891 (class 2604 OID 610829)
-- Name: tipo_usuario id_tipo; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.tipo_usuario ALTER COLUMN id_tipo SET DEFAULT nextval('public.tipo_usuario_id_tipo_seq'::regclass);


--
-- TOC entry 2890 (class 2604 OID 610819)
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 3123 (class 0 OID 610942)
-- Dependencies: 220
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.area (id_area, nome) FROM stdin;
1	Robótica
2	Algorítmos
3	Computação
\.


--
-- TOC entry 3131 (class 0 OID 611006)
-- Dependencies: 228
-- Data for Name: blockchain_registro; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.blockchain_registro (id_registro, id_proposta, id_documento, tipo_evento, hash_blockchain, data_registro) FROM stdin;
\.


--
-- TOC entry 3113 (class 0 OID 610861)
-- Dependencies: 210
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
-- TOC entry 3129 (class 0 OID 610992)
-- Dependencies: 226
-- Data for Name: documento_estagio; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.documento_estagio (id_documento, id_proposta, tipo_documento, caminho_pdf, data_envio) FROM stdin;
\.


--
-- TOC entry 3121 (class 0 OID 610927)
-- Dependencies: 218
-- Data for Name: escola; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.escola (id_escola, nome, cnpj, endereco, id_regional) FROM stdin;
1	Ced 01 do Itapoa	12.345.678/0001-90	\N	\N
2	Cef 01 do Gama	23.456.789/0001-01	\N	\N
3	Ec 08 de Taguatinga	34.567.890/0001-12	\N	\N
4	Ec 106 Norte	45.678.901/0001-23	\N	\N
\.


--
-- TOC entry 3132 (class 0 OID 611023)
-- Dependencies: 229
-- Data for Name: escola_modalidade; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.escola_modalidade (id_escola, id_modalidade) FROM stdin;
\.


--
-- TOC entry 3115 (class 0 OID 610874)
-- Dependencies: 212
-- Data for Name: estagiario; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.estagiario (id_estagiario, id_usuario, id_curso, id_instituicao) FROM stdin;
2	5	1	1
\.


--
-- TOC entry 3111 (class 0 OID 610851)
-- Dependencies: 208
-- Data for Name: instituicao; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.instituicao (id_instituicao, nome, tipo, cnpj) FROM stdin;
1	UnB	Universidade	00.000.000/0001-00
2	CeuB	Centro Universitário	11.111.111/0001-11
\.


--
-- TOC entry 3125 (class 0 OID 610950)
-- Dependencies: 222
-- Data for Name: modalidade; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.modalidade (id_modalidade, nome) FROM stdin;
1	Ensino Médio
2	Ensino Fundamental
3	EJA
\.


--
-- TOC entry 3109 (class 0 OID 610834)
-- Dependencies: 206
-- Data for Name: perfil_usuario; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.perfil_usuario (id_usuario, id_tipo) FROM stdin;
1	1
3	2
4	2
5	1
\.


--
-- TOC entry 3117 (class 0 OID 610899)
-- Dependencies: 214
-- Data for Name: professor; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.professor (id_professor, id_usuario, id_instituicao) FROM stdin;
1	3	1
2	4	1
\.


--
-- TOC entry 3133 (class 0 OID 611038)
-- Dependencies: 230
-- Data for Name: professor_area; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.professor_area (id_professor, id_area) FROM stdin;
\.


--
-- TOC entry 3127 (class 0 OID 610958)
-- Dependencies: 224
-- Data for Name: proposta_estagio; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.proposta_estagio (id_proposta, id_estagiario, id_professor, id_escola, id_area, id_modalidade, status, data_criacao) FROM stdin;
\.


--
-- TOC entry 3119 (class 0 OID 610919)
-- Dependencies: 216
-- Data for Name: regional; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.regional (id_regional, nome, email) FROM stdin;
\.


--
-- TOC entry 3135 (class 0 OID 611055)
-- Dependencies: 232
-- Data for Name: telefone_escola; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.telefone_escola (id_telefone, id_escola, numero) FROM stdin;
\.


--
-- TOC entry 3137 (class 0 OID 611068)
-- Dependencies: 234
-- Data for Name: telefone_regional; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.telefone_regional (id_telefone, id_regional, numero) FROM stdin;
\.


--
-- TOC entry 3108 (class 0 OID 610826)
-- Dependencies: 205
-- Data for Name: tipo_usuario; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.tipo_usuario (id_tipo, nome) FROM stdin;
1	aluno
2	professor
3	gestor
\.


--
-- TOC entry 3106 (class 0 OID 610816)
-- Dependencies: 203
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: siesu01
--

COPY public.usuario (id_usuario, nome, email, senha) FROM stdin;
1	CARLOS E I OLIVEIRA	carloseduardoiunes@gmail.com	$2b$10$J5IFN2lckM3cSRCxG9E4iOMxBjDq8olcM3kkmmyqH25WItuYewvw2
3	ladeira	ladeira@unb.br	$2b$10$VYiV6YWib/T9vz61qZpBo.gFeCJGU1nskPh5MQpJn/xMkGqIvPHSO
4	maristelaProf	maristela@unb.br	$2b$10$F3HfrK1QroyIlJ0uudiPRuIdHOWmWpvveBCBOjS6hZorIeFhYKCtG
5	robson	robson@gmail.com	$2b$10$sd9VNaylHE31PwkHc.gVyOS7fFqG5wSRiOqvSlAjbGxYDuSXov376
\.


--
-- TOC entry 3160 (class 0 OID 0)
-- Dependencies: 219
-- Name: area_id_area_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.area_id_area_seq', 3, true);


--
-- TOC entry 3161 (class 0 OID 0)
-- Dependencies: 227
-- Name: blockchain_registro_id_registro_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.blockchain_registro_id_registro_seq', 1, false);


--
-- TOC entry 3162 (class 0 OID 0)
-- Dependencies: 209
-- Name: curso_id_curso_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.curso_id_curso_seq', 6, true);


--
-- TOC entry 3163 (class 0 OID 0)
-- Dependencies: 225
-- Name: documento_estagio_id_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.documento_estagio_id_documento_seq', 1, false);


--
-- TOC entry 3164 (class 0 OID 0)
-- Dependencies: 217
-- Name: escola_id_escola_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.escola_id_escola_seq', 4, true);


--
-- TOC entry 3165 (class 0 OID 0)
-- Dependencies: 211
-- Name: estagiario_id_estagiario_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.estagiario_id_estagiario_seq', 2, true);


--
-- TOC entry 3166 (class 0 OID 0)
-- Dependencies: 207
-- Name: instituicao_id_instituicao_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.instituicao_id_instituicao_seq', 2, true);


--
-- TOC entry 3167 (class 0 OID 0)
-- Dependencies: 221
-- Name: modalidade_id_modalidade_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.modalidade_id_modalidade_seq', 3, true);


--
-- TOC entry 3168 (class 0 OID 0)
-- Dependencies: 213
-- Name: professor_id_professor_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.professor_id_professor_seq', 2, true);


--
-- TOC entry 3169 (class 0 OID 0)
-- Dependencies: 223
-- Name: proposta_estagio_id_proposta_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.proposta_estagio_id_proposta_seq', 2, true);


--
-- TOC entry 3170 (class 0 OID 0)
-- Dependencies: 215
-- Name: regional_id_regional_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.regional_id_regional_seq', 1, false);


--
-- TOC entry 3171 (class 0 OID 0)
-- Dependencies: 231
-- Name: telefone_escola_id_telefone_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.telefone_escola_id_telefone_seq', 1, false);


--
-- TOC entry 3172 (class 0 OID 0)
-- Dependencies: 233
-- Name: telefone_regional_id_telefone_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.telefone_regional_id_telefone_seq', 1, false);


--
-- TOC entry 3173 (class 0 OID 0)
-- Dependencies: 204
-- Name: tipo_usuario_id_tipo_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.tipo_usuario_id_tipo_seq', 3, true);


--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 202
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: siesu01
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 5, true);


--
-- TOC entry 2939 (class 2606 OID 610947)
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (id_area);


--
-- TOC entry 2947 (class 2606 OID 611012)
-- Name: blockchain_registro blockchain_registro_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_pkey PRIMARY KEY (id_registro);


--
-- TOC entry 2923 (class 2606 OID 610866)
-- Name: curso curso_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (id_curso);


--
-- TOC entry 2945 (class 2606 OID 610998)
-- Name: documento_estagio documento_estagio_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.documento_estagio
    ADD CONSTRAINT documento_estagio_pkey PRIMARY KEY (id_documento);


--
-- TOC entry 2935 (class 2606 OID 610934)
-- Name: escola escola_cnpj_key; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_cnpj_key UNIQUE (cnpj);


--
-- TOC entry 2949 (class 2606 OID 611027)
-- Name: escola_modalidade escola_modalidade_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_pkey PRIMARY KEY (id_escola, id_modalidade);


--
-- TOC entry 2937 (class 2606 OID 610932)
-- Name: escola escola_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_pkey PRIMARY KEY (id_escola);


--
-- TOC entry 2925 (class 2606 OID 610881)
-- Name: estagiario estagiario_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_usuario_key UNIQUE (id_usuario);


--
-- TOC entry 2927 (class 2606 OID 610879)
-- Name: estagiario estagiario_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_pkey PRIMARY KEY (id_estagiario);


--
-- TOC entry 2919 (class 2606 OID 610858)
-- Name: instituicao instituicao_cnpj_key; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.instituicao
    ADD CONSTRAINT instituicao_cnpj_key UNIQUE (cnpj);


--
-- TOC entry 2921 (class 2606 OID 610856)
-- Name: instituicao instituicao_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.instituicao
    ADD CONSTRAINT instituicao_pkey PRIMARY KEY (id_instituicao);


--
-- TOC entry 2941 (class 2606 OID 610955)
-- Name: modalidade modalidade_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.modalidade
    ADD CONSTRAINT modalidade_pkey PRIMARY KEY (id_modalidade);


--
-- TOC entry 2917 (class 2606 OID 610838)
-- Name: perfil_usuario perfil_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.perfil_usuario
    ADD CONSTRAINT perfil_usuario_pkey PRIMARY KEY (id_usuario, id_tipo);


--
-- TOC entry 2951 (class 2606 OID 611042)
-- Name: professor_area professor_area_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_pkey PRIMARY KEY (id_professor, id_area);


--
-- TOC entry 2929 (class 2606 OID 610906)
-- Name: professor professor_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_usuario_key UNIQUE (id_usuario);


--
-- TOC entry 2931 (class 2606 OID 610904)
-- Name: professor professor_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_pkey PRIMARY KEY (id_professor);


--
-- TOC entry 2943 (class 2606 OID 610964)
-- Name: proposta_estagio proposta_estagio_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio
    ADD CONSTRAINT proposta_estagio_pkey PRIMARY KEY (id_proposta);


--
-- TOC entry 2933 (class 2606 OID 610924)
-- Name: regional regional_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.regional
    ADD CONSTRAINT regional_pkey PRIMARY KEY (id_regional);


--
-- TOC entry 2953 (class 2606 OID 611060)
-- Name: telefone_escola telefone_escola_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.telefone_escola
    ADD CONSTRAINT telefone_escola_pkey PRIMARY KEY (id_telefone);


--
-- TOC entry 2955 (class 2606 OID 611073)
-- Name: telefone_regional telefone_regional_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.telefone_regional
    ADD CONSTRAINT telefone_regional_pkey PRIMARY KEY (id_telefone);


--
-- TOC entry 2913 (class 2606 OID 610833)
-- Name: tipo_usuario tipo_usuario_nome_key; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_nome_key UNIQUE (nome);


--
-- TOC entry 2915 (class 2606 OID 610831)
-- Name: tipo_usuario tipo_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_pkey PRIMARY KEY (id_tipo);


--
-- TOC entry 2909 (class 2606 OID 610823)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 2911 (class 2606 OID 610821)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 2971 (class 2606 OID 611018)
-- Name: blockchain_registro blockchain_registro_id_documento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_id_documento_fkey FOREIGN KEY (id_documento) REFERENCES public.documento_estagio(id_documento);


--
-- TOC entry 2972 (class 2606 OID 611013)
-- Name: blockchain_registro blockchain_registro_id_proposta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_id_proposta_fkey FOREIGN KEY (id_proposta) REFERENCES public.proposta_estagio(id_proposta);


--
-- TOC entry 2958 (class 2606 OID 610867)
-- Name: curso curso_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);


--
-- TOC entry 2970 (class 2606 OID 610999)
-- Name: documento_estagio documento_estagio_id_proposta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.documento_estagio
    ADD CONSTRAINT documento_estagio_id_proposta_fkey FOREIGN KEY (id_proposta) REFERENCES public.proposta_estagio(id_proposta);


--
-- TOC entry 2964 (class 2606 OID 610935)
-- Name: escola escola_id_regional_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_id_regional_fkey FOREIGN KEY (id_regional) REFERENCES public.regional(id_regional);


--
-- TOC entry 2973 (class 2606 OID 611028)
-- Name: escola_modalidade escola_modalidade_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola) ON DELETE CASCADE;


--
-- TOC entry 2974 (class 2606 OID 611033)
-- Name: escola_modalidade escola_modalidade_id_modalidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_id_modalidade_fkey FOREIGN KEY (id_modalidade) REFERENCES public.modalidade(id_modalidade) ON DELETE CASCADE;


--
-- TOC entry 2959 (class 2606 OID 610887)
-- Name: estagiario estagiario_id_curso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_curso_fkey FOREIGN KEY (id_curso) REFERENCES public.curso(id_curso);


--
-- TOC entry 2960 (class 2606 OID 610892)
-- Name: estagiario estagiario_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);


--
-- TOC entry 2961 (class 2606 OID 610882)
-- Name: estagiario estagiario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 2956 (class 2606 OID 610844)
-- Name: perfil_usuario perfil_usuario_id_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.perfil_usuario
    ADD CONSTRAINT perfil_usuario_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES public.tipo_usuario(id_tipo) ON DELETE CASCADE;


--
-- TOC entry 2957 (class 2606 OID 610839)
-- Name: perfil_usuario perfil_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.perfil_usuario
    ADD CONSTRAINT perfil_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 2975 (class 2606 OID 611048)
-- Name: professor_area professor_area_id_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_id_area_fkey FOREIGN KEY (id_area) REFERENCES public.area(id_area) ON DELETE CASCADE;


--
-- TOC entry 2976 (class 2606 OID 611043)
-- Name: professor_area professor_area_id_professor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_id_professor_fkey FOREIGN KEY (id_professor) REFERENCES public.professor(id_professor) ON DELETE CASCADE;


--
-- TOC entry 2962 (class 2606 OID 610912)
-- Name: professor professor_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);


--
-- TOC entry 2963 (class 2606 OID 610907)
-- Name: professor professor_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 2965 (class 2606 OID 610980)
-- Name: proposta_estagio proposta_estagio_id_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio
    ADD CONSTRAINT proposta_estagio_id_area_fkey FOREIGN KEY (id_area) REFERENCES public.area(id_area);


--
-- TOC entry 2966 (class 2606 OID 610975)
-- Name: proposta_estagio proposta_estagio_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio
    ADD CONSTRAINT proposta_estagio_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola);


--
-- TOC entry 2967 (class 2606 OID 610965)
-- Name: proposta_estagio proposta_estagio_id_estagiario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio
    ADD CONSTRAINT proposta_estagio_id_estagiario_fkey FOREIGN KEY (id_estagiario) REFERENCES public.estagiario(id_estagiario);


--
-- TOC entry 2968 (class 2606 OID 610985)
-- Name: proposta_estagio proposta_estagio_id_modalidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio
    ADD CONSTRAINT proposta_estagio_id_modalidade_fkey FOREIGN KEY (id_modalidade) REFERENCES public.modalidade(id_modalidade);


--
-- TOC entry 2969 (class 2606 OID 610970)
-- Name: proposta_estagio proposta_estagio_id_professor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.proposta_estagio
    ADD CONSTRAINT proposta_estagio_id_professor_fkey FOREIGN KEY (id_professor) REFERENCES public.professor(id_professor);


--
-- TOC entry 2977 (class 2606 OID 611061)
-- Name: telefone_escola telefone_escola_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.telefone_escola
    ADD CONSTRAINT telefone_escola_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola) ON DELETE CASCADE;


--
-- TOC entry 2978 (class 2606 OID 611074)
-- Name: telefone_regional telefone_regional_id_regional_fkey; Type: FK CONSTRAINT; Schema: public; Owner: siesu01
--

ALTER TABLE ONLY public.telefone_regional
    ADD CONSTRAINT telefone_regional_id_regional_fkey FOREIGN KEY (id_regional) REFERENCES public.regional(id_regional) ON DELETE CASCADE;


--
-- TOC entry 3144 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-06-09 22:31:04

--
-- PostgreSQL database dump complete
--

