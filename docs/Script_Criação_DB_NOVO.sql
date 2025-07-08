--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 17.5

-- Started on 2025-07-08 13:36:08

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
-- TOC entry 3136 (class 1262 OID 620862)
-- Name: siesudb; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE siesudb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';


\connect siesudb

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- TOC entry 239 (class 1255 OID 629140)
-- Name: sp_concluir_estagio(integer); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.sp_concluir_estagio(p_id_estagio integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_count_etapas INT;
BEGIN
    -- Verifica quantas etapas "Finalizado" existem para o estágio informado
    SELECT COUNT(*) INTO v_count_etapas
    FROM estagio_etapa
    WHERE id_estagio = p_id_estagio
      AND upper(etapa) = 'FINALIZADO';

    -- Se não encontrou nenhuma etapa finalizada, não atualiza
    IF v_count_etapas = 0 THEN
        RAISE NOTICE 'Nenhuma etapa finalizada encontrada. O estágio não pode ser concluído.';
        RETURN;
    END IF;

    -- Caso contrário, atualiza o status do estágio
    UPDATE estagio
    SET status = 'Concluído'
    WHERE id_estagio = p_id_estagio;

    RAISE NOTICE 'Estágio % concluído com sucesso.', p_id_estagio;
END;
$$;


SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 621007)
-- Name: area; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.area (
    id_area integer NOT NULL,
    nome character varying(100) NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 621005)
-- Name: area_id_area_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.area_id_area_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3137 (class 0 OID 0)
-- Dependencies: 221
-- Name: area_id_area_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.area_id_area_seq OWNED BY public.area.id_area;


--
-- TOC entry 235 (class 1259 OID 621148)
-- Name: blockchain_registro; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blockchain_registro (
    id_registro integer NOT NULL,
    id_estagio integer NOT NULL,
    id_documento integer,
    tipo_evento character varying(50) NOT NULL,
    hash_blockchain character varying(150) NOT NULL,
    data_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 234 (class 1259 OID 621146)
-- Name: blockchain_registro_id_registro_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blockchain_registro_id_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3138 (class 0 OID 0)
-- Dependencies: 234
-- Name: blockchain_registro_id_registro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blockchain_registro_id_registro_seq OWNED BY public.blockchain_registro.id_registro;


--
-- TOC entry 209 (class 1259 OID 620922)
-- Name: curso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.curso (
    id_curso integer NOT NULL,
    nome character varying(100) NOT NULL,
    id_instituicao integer NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 620920)
-- Name: curso_id_curso_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.curso_id_curso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3139 (class 0 OID 0)
-- Dependencies: 208
-- Name: curso_id_curso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.curso_id_curso_seq OWNED BY public.curso.id_curso;


--
-- TOC entry 233 (class 1259 OID 621134)
-- Name: documento_estagio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documento_estagio (
    id_documento integer NOT NULL,
    id_estagio integer NOT NULL,
    tipo_documento character varying(50) NOT NULL,
    caminho_pdf character varying(200) NOT NULL,
    data_envio timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 232 (class 1259 OID 621132)
-- Name: documento_estagio_id_documento_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.documento_estagio_id_documento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3140 (class 0 OID 0)
-- Dependencies: 232
-- Name: documento_estagio_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.documento_estagio_id_documento_seq OWNED BY public.documento_estagio.id_documento;


--
-- TOC entry 213 (class 1259 OID 620943)
-- Name: escola; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.escola (
    id_escola integer NOT NULL,
    nome character varying(150) NOT NULL,
    cnpj character varying(18) NOT NULL,
    endereco character varying(200),
    id_regional integer
);


--
-- TOC entry 212 (class 1259 OID 620941)
-- Name: escola_id_escola_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.escola_id_escola_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3141 (class 0 OID 0)
-- Dependencies: 212
-- Name: escola_id_escola_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.escola_id_escola_seq OWNED BY public.escola.id_escola;


--
-- TOC entry 220 (class 1259 OID 620990)
-- Name: escola_modalidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.escola_modalidade (
    id_escola integer NOT NULL,
    id_modalidade integer NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 621070)
-- Name: estagiario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estagiario (
    id_estagiario integer NOT NULL,
    id_usuario integer NOT NULL,
    id_curso integer NOT NULL,
    id_instituicao integer NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 621068)
-- Name: estagiario_id_estagiario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estagiario_id_estagiario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3142 (class 0 OID 0)
-- Dependencies: 228
-- Name: estagiario_id_estagiario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estagiario_id_estagiario_seq OWNED BY public.estagiario.id_estagiario;


--
-- TOC entry 231 (class 1259 OID 621095)
-- Name: estagio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estagio (
    id_estagio integer NOT NULL,
    id_estagiario integer NOT NULL,
    id_professor integer NOT NULL,
    id_orientador integer NOT NULL,
    id_escola integer NOT NULL,
    id_area integer NOT NULL,
    id_modalidade integer NOT NULL,
    status character varying(30) NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 237 (class 1259 OID 621167)
-- Name: estagio_etapa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estagio_etapa (
    id_etapa integer NOT NULL,
    id_estagio integer NOT NULL,
    etapa character varying(50) NOT NULL,
    data_inicio timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    data_fim timestamp without time zone,
    id_usuario_assinante integer,
    id_documento integer,
    hash_blockchain character varying(150)
);


--
-- TOC entry 236 (class 1259 OID 621165)
-- Name: estagio_etapa_id_etapa_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estagio_etapa_id_etapa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3143 (class 0 OID 0)
-- Dependencies: 236
-- Name: estagio_etapa_id_etapa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estagio_etapa_id_etapa_seq OWNED BY public.estagio_etapa.id_etapa;


--
-- TOC entry 230 (class 1259 OID 621093)
-- Name: estagio_id_estagio_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estagio_id_estagio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3144 (class 0 OID 0)
-- Dependencies: 230
-- Name: estagio_id_estagio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estagio_id_estagio_seq OWNED BY public.estagio.id_estagio;


--
-- TOC entry 207 (class 1259 OID 620912)
-- Name: instituicao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.instituicao (
    id_instituicao integer NOT NULL,
    nome character varying(150) NOT NULL,
    tipo character varying(50) NOT NULL,
    cnpj character varying(18)
);


--
-- TOC entry 206 (class 1259 OID 620910)
-- Name: instituicao_id_instituicao_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.instituicao_id_instituicao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3145 (class 0 OID 0)
-- Dependencies: 206
-- Name: instituicao_id_instituicao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.instituicao_id_instituicao_seq OWNED BY public.instituicao.id_instituicao;


--
-- TOC entry 219 (class 1259 OID 620984)
-- Name: modalidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.modalidade (
    id_modalidade integer NOT NULL,
    nome character varying(50) NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 620982)
-- Name: modalidade_id_modalidade_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.modalidade_id_modalidade_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3146 (class 0 OID 0)
-- Dependencies: 218
-- Name: modalidade_id_modalidade_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.modalidade_id_modalidade_seq OWNED BY public.modalidade.id_modalidade;


--
-- TOC entry 224 (class 1259 OID 621015)
-- Name: orientador; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orientador (
    id_orientador integer NOT NULL,
    id_usuario integer NOT NULL,
    id_instituicao integer NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 621013)
-- Name: orientador_id_orientador_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orientador_id_orientador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3147 (class 0 OID 0)
-- Dependencies: 223
-- Name: orientador_id_orientador_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orientador_id_orientador_seq OWNED BY public.orientador.id_orientador;


--
-- TOC entry 226 (class 1259 OID 621035)
-- Name: professor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.professor (
    id_professor integer NOT NULL,
    id_usuario integer NOT NULL,
    id_escola integer NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 621053)
-- Name: professor_area; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.professor_area (
    id_professor integer NOT NULL,
    id_area integer NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 621033)
-- Name: professor_id_professor_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.professor_id_professor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3148 (class 0 OID 0)
-- Dependencies: 225
-- Name: professor_id_professor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.professor_id_professor_seq OWNED BY public.professor.id_professor;


--
-- TOC entry 211 (class 1259 OID 620935)
-- Name: regional; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.regional (
    id_regional integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100)
);


--
-- TOC entry 210 (class 1259 OID 620933)
-- Name: regional_id_regional_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.regional_id_regional_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3149 (class 0 OID 0)
-- Dependencies: 210
-- Name: regional_id_regional_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.regional_id_regional_seq OWNED BY public.regional.id_regional;


--
-- TOC entry 215 (class 1259 OID 620958)
-- Name: telefone_escola; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telefone_escola (
    id_telefone integer NOT NULL,
    id_escola integer NOT NULL,
    numero character varying(20) NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 620956)
-- Name: telefone_escola_id_telefone_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.telefone_escola_id_telefone_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3150 (class 0 OID 0)
-- Dependencies: 214
-- Name: telefone_escola_id_telefone_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.telefone_escola_id_telefone_seq OWNED BY public.telefone_escola.id_telefone;


--
-- TOC entry 217 (class 1259 OID 620971)
-- Name: telefone_regional; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telefone_regional (
    id_telefone integer NOT NULL,
    id_regional integer NOT NULL,
    numero character varying(20) NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 620969)
-- Name: telefone_regional_id_telefone_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.telefone_regional_id_telefone_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3151 (class 0 OID 0)
-- Dependencies: 216
-- Name: telefone_regional_id_telefone_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.telefone_regional_id_telefone_seq OWNED BY public.telefone_regional.id_telefone;


--
-- TOC entry 203 (class 1259 OID 620887)
-- Name: tipo_usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tipo_usuario (
    id_tipo integer NOT NULL,
    nome character varying(30) NOT NULL
);


--
-- TOC entry 202 (class 1259 OID 620885)
-- Name: tipo_usuario_id_tipo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tipo_usuario_id_tipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3152 (class 0 OID 0)
-- Dependencies: 202
-- Name: tipo_usuario_id_tipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tipo_usuario_id_tipo_seq OWNED BY public.tipo_usuario.id_tipo;


--
-- TOC entry 205 (class 1259 OID 620897)
-- Name: usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    senha character varying(100) NOT NULL,
    id_tipo integer NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 620895)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3153 (class 0 OID 0)
-- Dependencies: 204
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 238 (class 1259 OID 629121)
-- Name: vw_estagios_pendentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_estagios_pendentes AS
 SELECT e.id_estagio,
    u_est.nome AS nome_estagiario,
    c.nome AS curso,
    u_prof.nome AS nome_professor,
    es.nome AS escola,
    a.nome AS area,
    e.status,
    e.data_criacao
   FROM (((((((public.estagio e
     JOIN public.estagiario estg ON ((e.id_estagiario = estg.id_estagiario)))
     JOIN public.usuario u_est ON ((estg.id_usuario = u_est.id_usuario)))
     JOIN public.curso c ON ((estg.id_curso = c.id_curso)))
     JOIN public.professor p ON ((e.id_professor = p.id_professor)))
     JOIN public.usuario u_prof ON ((p.id_usuario = u_prof.id_usuario)))
     JOIN public.escola es ON ((e.id_escola = es.id_escola)))
     JOIN public.area a ON ((e.id_area = a.id_area)))
  WHERE (upper((e.status)::text) = 'PENDENTE'::text);


--
-- TOC entry 2912 (class 2604 OID 621010)
-- Name: area id_area; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area ALTER COLUMN id_area SET DEFAULT nextval('public.area_id_area_seq'::regclass);


--
-- TOC entry 2920 (class 2604 OID 621151)
-- Name: blockchain_registro id_registro; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blockchain_registro ALTER COLUMN id_registro SET DEFAULT nextval('public.blockchain_registro_id_registro_seq'::regclass);


--
-- TOC entry 2906 (class 2604 OID 620925)
-- Name: curso id_curso; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curso ALTER COLUMN id_curso SET DEFAULT nextval('public.curso_id_curso_seq'::regclass);


--
-- TOC entry 2918 (class 2604 OID 621137)
-- Name: documento_estagio id_documento; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documento_estagio ALTER COLUMN id_documento SET DEFAULT nextval('public.documento_estagio_id_documento_seq'::regclass);


--
-- TOC entry 2908 (class 2604 OID 620946)
-- Name: escola id_escola; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola ALTER COLUMN id_escola SET DEFAULT nextval('public.escola_id_escola_seq'::regclass);


--
-- TOC entry 2915 (class 2604 OID 621073)
-- Name: estagiario id_estagiario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagiario ALTER COLUMN id_estagiario SET DEFAULT nextval('public.estagiario_id_estagiario_seq'::regclass);


--
-- TOC entry 2916 (class 2604 OID 621098)
-- Name: estagio id_estagio; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio ALTER COLUMN id_estagio SET DEFAULT nextval('public.estagio_id_estagio_seq'::regclass);


--
-- TOC entry 2922 (class 2604 OID 621170)
-- Name: estagio_etapa id_etapa; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio_etapa ALTER COLUMN id_etapa SET DEFAULT nextval('public.estagio_etapa_id_etapa_seq'::regclass);


--
-- TOC entry 2905 (class 2604 OID 620915)
-- Name: instituicao id_instituicao; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituicao ALTER COLUMN id_instituicao SET DEFAULT nextval('public.instituicao_id_instituicao_seq'::regclass);


--
-- TOC entry 2911 (class 2604 OID 620987)
-- Name: modalidade id_modalidade; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modalidade ALTER COLUMN id_modalidade SET DEFAULT nextval('public.modalidade_id_modalidade_seq'::regclass);


--
-- TOC entry 2913 (class 2604 OID 621018)
-- Name: orientador id_orientador; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orientador ALTER COLUMN id_orientador SET DEFAULT nextval('public.orientador_id_orientador_seq'::regclass);


--
-- TOC entry 2914 (class 2604 OID 621038)
-- Name: professor id_professor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor ALTER COLUMN id_professor SET DEFAULT nextval('public.professor_id_professor_seq'::regclass);


--
-- TOC entry 2907 (class 2604 OID 620938)
-- Name: regional id_regional; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regional ALTER COLUMN id_regional SET DEFAULT nextval('public.regional_id_regional_seq'::regclass);


--
-- TOC entry 2909 (class 2604 OID 620961)
-- Name: telefone_escola id_telefone; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefone_escola ALTER COLUMN id_telefone SET DEFAULT nextval('public.telefone_escola_id_telefone_seq'::regclass);


--
-- TOC entry 2910 (class 2604 OID 620974)
-- Name: telefone_regional id_telefone; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefone_regional ALTER COLUMN id_telefone SET DEFAULT nextval('public.telefone_regional_id_telefone_seq'::regclass);


--
-- TOC entry 2903 (class 2604 OID 620890)
-- Name: tipo_usuario id_tipo; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_usuario ALTER COLUMN id_tipo SET DEFAULT nextval('public.tipo_usuario_id_tipo_seq'::regclass);


--
-- TOC entry 2904 (class 2604 OID 620900)
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 2953 (class 2606 OID 621012)
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (id_area);


--
-- TOC entry 2973 (class 2606 OID 621154)
-- Name: blockchain_registro blockchain_registro_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_pkey PRIMARY KEY (id_registro);


--
-- TOC entry 2937 (class 2606 OID 620927)
-- Name: curso curso_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (id_curso);


--
-- TOC entry 2971 (class 2606 OID 621140)
-- Name: documento_estagio documento_estagio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documento_estagio
    ADD CONSTRAINT documento_estagio_pkey PRIMARY KEY (id_documento);


--
-- TOC entry 2941 (class 2606 OID 620950)
-- Name: escola escola_cnpj_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_cnpj_key UNIQUE (cnpj);


--
-- TOC entry 2951 (class 2606 OID 620994)
-- Name: escola_modalidade escola_modalidade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_pkey PRIMARY KEY (id_escola, id_modalidade);


--
-- TOC entry 2943 (class 2606 OID 620948)
-- Name: escola escola_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_pkey PRIMARY KEY (id_escola);


--
-- TOC entry 2965 (class 2606 OID 621077)
-- Name: estagiario estagiario_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_usuario_key UNIQUE (id_usuario);


--
-- TOC entry 2967 (class 2606 OID 621075)
-- Name: estagiario estagiario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_pkey PRIMARY KEY (id_estagiario);


--
-- TOC entry 2975 (class 2606 OID 621173)
-- Name: estagio_etapa estagio_etapa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_pkey PRIMARY KEY (id_etapa);


--
-- TOC entry 2969 (class 2606 OID 621101)
-- Name: estagio estagio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_pkey PRIMARY KEY (id_estagio);


--
-- TOC entry 2933 (class 2606 OID 620919)
-- Name: instituicao instituicao_cnpj_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituicao
    ADD CONSTRAINT instituicao_cnpj_key UNIQUE (cnpj);


--
-- TOC entry 2935 (class 2606 OID 620917)
-- Name: instituicao instituicao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituicao
    ADD CONSTRAINT instituicao_pkey PRIMARY KEY (id_instituicao);


--
-- TOC entry 2949 (class 2606 OID 620989)
-- Name: modalidade modalidade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modalidade
    ADD CONSTRAINT modalidade_pkey PRIMARY KEY (id_modalidade);


--
-- TOC entry 2955 (class 2606 OID 621022)
-- Name: orientador orientador_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_id_usuario_key UNIQUE (id_usuario);


--
-- TOC entry 2957 (class 2606 OID 621020)
-- Name: orientador orientador_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_pkey PRIMARY KEY (id_orientador);


--
-- TOC entry 2963 (class 2606 OID 621057)
-- Name: professor_area professor_area_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_pkey PRIMARY KEY (id_professor, id_area);


--
-- TOC entry 2959 (class 2606 OID 621042)
-- Name: professor professor_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_usuario_key UNIQUE (id_usuario);


--
-- TOC entry 2961 (class 2606 OID 621040)
-- Name: professor professor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_pkey PRIMARY KEY (id_professor);


--
-- TOC entry 2939 (class 2606 OID 620940)
-- Name: regional regional_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regional
    ADD CONSTRAINT regional_pkey PRIMARY KEY (id_regional);


--
-- TOC entry 2945 (class 2606 OID 620963)
-- Name: telefone_escola telefone_escola_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefone_escola
    ADD CONSTRAINT telefone_escola_pkey PRIMARY KEY (id_telefone);


--
-- TOC entry 2947 (class 2606 OID 620976)
-- Name: telefone_regional telefone_regional_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefone_regional
    ADD CONSTRAINT telefone_regional_pkey PRIMARY KEY (id_telefone);


--
-- TOC entry 2925 (class 2606 OID 620894)
-- Name: tipo_usuario tipo_usuario_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_nome_key UNIQUE (nome);


--
-- TOC entry 2927 (class 2606 OID 620892)
-- Name: tipo_usuario tipo_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_pkey PRIMARY KEY (id_tipo);


--
-- TOC entry 2929 (class 2606 OID 620904)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 2931 (class 2606 OID 620902)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 2999 (class 2606 OID 621160)
-- Name: blockchain_registro blockchain_registro_id_documento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_id_documento_fkey FOREIGN KEY (id_documento) REFERENCES public.documento_estagio(id_documento);


--
-- TOC entry 3000 (class 2606 OID 621155)
-- Name: blockchain_registro blockchain_registro_id_estagio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_id_estagio_fkey FOREIGN KEY (id_estagio) REFERENCES public.estagio(id_estagio);


--
-- TOC entry 2977 (class 2606 OID 620928)
-- Name: curso curso_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);


--
-- TOC entry 2998 (class 2606 OID 621141)
-- Name: documento_estagio documento_estagio_id_estagio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documento_estagio
    ADD CONSTRAINT documento_estagio_id_estagio_fkey FOREIGN KEY (id_estagio) REFERENCES public.estagio(id_estagio);


--
-- TOC entry 2978 (class 2606 OID 620951)
-- Name: escola escola_id_regional_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_id_regional_fkey FOREIGN KEY (id_regional) REFERENCES public.regional(id_regional);


--
-- TOC entry 2981 (class 2606 OID 620995)
-- Name: escola_modalidade escola_modalidade_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola) ON DELETE CASCADE;


--
-- TOC entry 2982 (class 2606 OID 621000)
-- Name: escola_modalidade escola_modalidade_id_modalidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_id_modalidade_fkey FOREIGN KEY (id_modalidade) REFERENCES public.modalidade(id_modalidade) ON DELETE CASCADE;


--
-- TOC entry 2989 (class 2606 OID 621083)
-- Name: estagiario estagiario_id_curso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_curso_fkey FOREIGN KEY (id_curso) REFERENCES public.curso(id_curso);


--
-- TOC entry 2990 (class 2606 OID 621088)
-- Name: estagiario estagiario_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);


--
-- TOC entry 2991 (class 2606 OID 621078)
-- Name: estagiario estagiario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 3001 (class 2606 OID 621184)
-- Name: estagio_etapa estagio_etapa_id_documento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_id_documento_fkey FOREIGN KEY (id_documento) REFERENCES public.documento_estagio(id_documento);


--
-- TOC entry 3002 (class 2606 OID 621174)
-- Name: estagio_etapa estagio_etapa_id_estagio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_id_estagio_fkey FOREIGN KEY (id_estagio) REFERENCES public.estagio(id_estagio);


--
-- TOC entry 3003 (class 2606 OID 621179)
-- Name: estagio_etapa estagio_etapa_id_usuario_assinante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_id_usuario_assinante_fkey FOREIGN KEY (id_usuario_assinante) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 2992 (class 2606 OID 621122)
-- Name: estagio estagio_id_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_area_fkey FOREIGN KEY (id_area) REFERENCES public.area(id_area);


--
-- TOC entry 2993 (class 2606 OID 621117)
-- Name: estagio estagio_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola);


--
-- TOC entry 2994 (class 2606 OID 621102)
-- Name: estagio estagio_id_estagiario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_estagiario_fkey FOREIGN KEY (id_estagiario) REFERENCES public.estagiario(id_estagiario);


--
-- TOC entry 2995 (class 2606 OID 621127)
-- Name: estagio estagio_id_modalidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_modalidade_fkey FOREIGN KEY (id_modalidade) REFERENCES public.modalidade(id_modalidade);


--
-- TOC entry 2996 (class 2606 OID 621112)
-- Name: estagio estagio_id_orientador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_orientador_fkey FOREIGN KEY (id_orientador) REFERENCES public.orientador(id_orientador);


--
-- TOC entry 2997 (class 2606 OID 621107)
-- Name: estagio estagio_id_professor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_professor_fkey FOREIGN KEY (id_professor) REFERENCES public.professor(id_professor);


--
-- TOC entry 2983 (class 2606 OID 621028)
-- Name: orientador orientador_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);


--
-- TOC entry 2984 (class 2606 OID 621023)
-- Name: orientador orientador_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 2987 (class 2606 OID 621063)
-- Name: professor_area professor_area_id_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_id_area_fkey FOREIGN KEY (id_area) REFERENCES public.area(id_area) ON DELETE CASCADE;


--
-- TOC entry 2988 (class 2606 OID 621058)
-- Name: professor_area professor_area_id_professor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_id_professor_fkey FOREIGN KEY (id_professor) REFERENCES public.professor(id_professor) ON DELETE CASCADE;


--
-- TOC entry 2985 (class 2606 OID 621048)
-- Name: professor professor_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola);


--
-- TOC entry 2986 (class 2606 OID 621043)
-- Name: professor professor_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 2979 (class 2606 OID 620964)
-- Name: telefone_escola telefone_escola_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefone_escola
    ADD CONSTRAINT telefone_escola_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola) ON DELETE CASCADE;


--
-- TOC entry 2980 (class 2606 OID 620977)
-- Name: telefone_regional telefone_regional_id_regional_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefone_regional
    ADD CONSTRAINT telefone_regional_id_regional_fkey FOREIGN KEY (id_regional) REFERENCES public.regional(id_regional) ON DELETE CASCADE;


--
-- TOC entry 2976 (class 2606 OID 620905)
-- Name: usuario usuario_id_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES public.tipo_usuario(id_tipo);


-- Completed on 2025-07-08 13:36:21

--
-- PostgreSQL database dump complete
--

