toc.dat                                                                                             0000600 0004000 0002000 00000155367 15033245311 0014455 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP   $    +                }            siesudb %   12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)    17.5 �    a           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false         b           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false         c           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false         d           1262    620862    siesudb    DATABASE     o   CREATE DATABASE siesudb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';
    DROP DATABASE siesudb;
                     siesu01    false                     2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                     postgres    false         �            1255    629140    sp_concluir_estagio(integer) 	   PROCEDURE     1  CREATE PROCEDURE public.sp_concluir_estagio(p_id_estagio integer)
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
 A   DROP PROCEDURE public.sp_concluir_estagio(p_id_estagio integer);
       public               siesu01    false    6         �            1259    621007    area    TABLE     e   CREATE TABLE public.area (
    id_area integer NOT NULL,
    nome character varying(100) NOT NULL
);
    DROP TABLE public.area;
       public         heap r       siesu01    false    6         �            1259    621005    area_id_area_seq    SEQUENCE     �   CREATE SEQUENCE public.area_id_area_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.area_id_area_seq;
       public               siesu01    false    6    222         e           0    0    area_id_area_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.area_id_area_seq OWNED BY public.area.id_area;
          public               siesu01    false    221         �            1259    621148    blockchain_registro    TABLE     7  CREATE TABLE public.blockchain_registro (
    id_registro integer NOT NULL,
    id_estagio integer NOT NULL,
    id_documento integer,
    tipo_evento character varying(50) NOT NULL,
    hash_blockchain character varying(150) NOT NULL,
    data_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 '   DROP TABLE public.blockchain_registro;
       public         heap r       siesu01    false    6         �            1259    621146 #   blockchain_registro_id_registro_seq    SEQUENCE     �   CREATE SEQUENCE public.blockchain_registro_id_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.blockchain_registro_id_registro_seq;
       public               siesu01    false    235    6         f           0    0 #   blockchain_registro_id_registro_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.blockchain_registro_id_registro_seq OWNED BY public.blockchain_registro.id_registro;
          public               siesu01    false    234         �            1259    620922    curso    TABLE     �   CREATE TABLE public.curso (
    id_curso integer NOT NULL,
    nome character varying(100) NOT NULL,
    id_instituicao integer NOT NULL
);
    DROP TABLE public.curso;
       public         heap r       siesu01    false    6         �            1259    620920    curso_id_curso_seq    SEQUENCE     �   CREATE SEQUENCE public.curso_id_curso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.curso_id_curso_seq;
       public               siesu01    false    6    209         g           0    0    curso_id_curso_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.curso_id_curso_seq OWNED BY public.curso.id_curso;
          public               siesu01    false    208         �            1259    621134    documento_estagio    TABLE       CREATE TABLE public.documento_estagio (
    id_documento integer NOT NULL,
    id_estagio integer NOT NULL,
    tipo_documento character varying(50) NOT NULL,
    caminho_pdf character varying(200) NOT NULL,
    data_envio timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 %   DROP TABLE public.documento_estagio;
       public         heap r       siesu01    false    6         �            1259    621132 "   documento_estagio_id_documento_seq    SEQUENCE     �   CREATE SEQUENCE public.documento_estagio_id_documento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.documento_estagio_id_documento_seq;
       public               siesu01    false    233    6         h           0    0 "   documento_estagio_id_documento_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.documento_estagio_id_documento_seq OWNED BY public.documento_estagio.id_documento;
          public               siesu01    false    232         �            1259    620943    escola    TABLE     �   CREATE TABLE public.escola (
    id_escola integer NOT NULL,
    nome character varying(150) NOT NULL,
    cnpj character varying(18) NOT NULL,
    endereco character varying(200),
    id_regional integer
);
    DROP TABLE public.escola;
       public         heap r       siesu01    false    6         �            1259    620941    escola_id_escola_seq    SEQUENCE     �   CREATE SEQUENCE public.escola_id_escola_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.escola_id_escola_seq;
       public               siesu01    false    6    213         i           0    0    escola_id_escola_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.escola_id_escola_seq OWNED BY public.escola.id_escola;
          public               siesu01    false    212         �            1259    620990    escola_modalidade    TABLE     n   CREATE TABLE public.escola_modalidade (
    id_escola integer NOT NULL,
    id_modalidade integer NOT NULL
);
 %   DROP TABLE public.escola_modalidade;
       public         heap r       siesu01    false    6         �            1259    621070 
   estagiario    TABLE     �   CREATE TABLE public.estagiario (
    id_estagiario integer NOT NULL,
    id_usuario integer NOT NULL,
    id_curso integer NOT NULL,
    id_instituicao integer NOT NULL
);
    DROP TABLE public.estagiario;
       public         heap r       siesu01    false    6         �            1259    621068    estagiario_id_estagiario_seq    SEQUENCE     �   CREATE SEQUENCE public.estagiario_id_estagiario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.estagiario_id_estagiario_seq;
       public               siesu01    false    6    229         j           0    0    estagiario_id_estagiario_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.estagiario_id_estagiario_seq OWNED BY public.estagiario.id_estagiario;
          public               siesu01    false    228         �            1259    621095    estagio    TABLE     �  CREATE TABLE public.estagio (
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
    DROP TABLE public.estagio;
       public         heap r       siesu01    false    6         �            1259    621167    estagio_etapa    TABLE     r  CREATE TABLE public.estagio_etapa (
    id_etapa integer NOT NULL,
    id_estagio integer NOT NULL,
    etapa character varying(50) NOT NULL,
    data_inicio timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    data_fim timestamp without time zone,
    id_usuario_assinante integer,
    id_documento integer,
    hash_blockchain character varying(150)
);
 !   DROP TABLE public.estagio_etapa;
       public         heap r       siesu01    false    6         �            1259    621165    estagio_etapa_id_etapa_seq    SEQUENCE     �   CREATE SEQUENCE public.estagio_etapa_id_etapa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.estagio_etapa_id_etapa_seq;
       public               siesu01    false    6    237         k           0    0    estagio_etapa_id_etapa_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.estagio_etapa_id_etapa_seq OWNED BY public.estagio_etapa.id_etapa;
          public               siesu01    false    236         �            1259    621093    estagio_id_estagio_seq    SEQUENCE     �   CREATE SEQUENCE public.estagio_id_estagio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.estagio_id_estagio_seq;
       public               siesu01    false    231    6         l           0    0    estagio_id_estagio_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.estagio_id_estagio_seq OWNED BY public.estagio.id_estagio;
          public               siesu01    false    230         �            1259    620912    instituicao    TABLE     �   CREATE TABLE public.instituicao (
    id_instituicao integer NOT NULL,
    nome character varying(150) NOT NULL,
    tipo character varying(50) NOT NULL,
    cnpj character varying(18)
);
    DROP TABLE public.instituicao;
       public         heap r       siesu01    false    6         �            1259    620910    instituicao_id_instituicao_seq    SEQUENCE     �   CREATE SEQUENCE public.instituicao_id_instituicao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.instituicao_id_instituicao_seq;
       public               siesu01    false    6    207         m           0    0    instituicao_id_instituicao_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.instituicao_id_instituicao_seq OWNED BY public.instituicao.id_instituicao;
          public               siesu01    false    206         �            1259    620984 
   modalidade    TABLE     p   CREATE TABLE public.modalidade (
    id_modalidade integer NOT NULL,
    nome character varying(50) NOT NULL
);
    DROP TABLE public.modalidade;
       public         heap r       siesu01    false    6         �            1259    620982    modalidade_id_modalidade_seq    SEQUENCE     �   CREATE SEQUENCE public.modalidade_id_modalidade_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.modalidade_id_modalidade_seq;
       public               siesu01    false    6    219         n           0    0    modalidade_id_modalidade_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.modalidade_id_modalidade_seq OWNED BY public.modalidade.id_modalidade;
          public               siesu01    false    218         �            1259    621015 
   orientador    TABLE     �   CREATE TABLE public.orientador (
    id_orientador integer NOT NULL,
    id_usuario integer NOT NULL,
    id_instituicao integer NOT NULL
);
    DROP TABLE public.orientador;
       public         heap r       siesu01    false    6         �            1259    621013    orientador_id_orientador_seq    SEQUENCE     �   CREATE SEQUENCE public.orientador_id_orientador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.orientador_id_orientador_seq;
       public               siesu01    false    224    6         o           0    0    orientador_id_orientador_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.orientador_id_orientador_seq OWNED BY public.orientador.id_orientador;
          public               siesu01    false    223         �            1259    621035 	   professor    TABLE     �   CREATE TABLE public.professor (
    id_professor integer NOT NULL,
    id_usuario integer NOT NULL,
    id_escola integer NOT NULL
);
    DROP TABLE public.professor;
       public         heap r       siesu01    false    6         �            1259    621053    professor_area    TABLE     h   CREATE TABLE public.professor_area (
    id_professor integer NOT NULL,
    id_area integer NOT NULL
);
 "   DROP TABLE public.professor_area;
       public         heap r       siesu01    false    6         �            1259    621033    professor_id_professor_seq    SEQUENCE     �   CREATE SEQUENCE public.professor_id_professor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.professor_id_professor_seq;
       public               siesu01    false    226    6         p           0    0    professor_id_professor_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.professor_id_professor_seq OWNED BY public.professor.id_professor;
          public               siesu01    false    225         �            1259    620935    regional    TABLE     �   CREATE TABLE public.regional (
    id_regional integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100)
);
    DROP TABLE public.regional;
       public         heap r       siesu01    false    6         �            1259    620933    regional_id_regional_seq    SEQUENCE     �   CREATE SEQUENCE public.regional_id_regional_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.regional_id_regional_seq;
       public               siesu01    false    211    6         q           0    0    regional_id_regional_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.regional_id_regional_seq OWNED BY public.regional.id_regional;
          public               siesu01    false    210         �            1259    620958    telefone_escola    TABLE     �   CREATE TABLE public.telefone_escola (
    id_telefone integer NOT NULL,
    id_escola integer NOT NULL,
    numero character varying(20) NOT NULL
);
 #   DROP TABLE public.telefone_escola;
       public         heap r       siesu01    false    6         �            1259    620956    telefone_escola_id_telefone_seq    SEQUENCE     �   CREATE SEQUENCE public.telefone_escola_id_telefone_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.telefone_escola_id_telefone_seq;
       public               siesu01    false    215    6         r           0    0    telefone_escola_id_telefone_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.telefone_escola_id_telefone_seq OWNED BY public.telefone_escola.id_telefone;
          public               siesu01    false    214         �            1259    620971    telefone_regional    TABLE     �   CREATE TABLE public.telefone_regional (
    id_telefone integer NOT NULL,
    id_regional integer NOT NULL,
    numero character varying(20) NOT NULL
);
 %   DROP TABLE public.telefone_regional;
       public         heap r       siesu01    false    6         �            1259    620969 !   telefone_regional_id_telefone_seq    SEQUENCE     �   CREATE SEQUENCE public.telefone_regional_id_telefone_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.telefone_regional_id_telefone_seq;
       public               siesu01    false    217    6         s           0    0 !   telefone_regional_id_telefone_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.telefone_regional_id_telefone_seq OWNED BY public.telefone_regional.id_telefone;
          public               siesu01    false    216         �            1259    620887    tipo_usuario    TABLE     l   CREATE TABLE public.tipo_usuario (
    id_tipo integer NOT NULL,
    nome character varying(30) NOT NULL
);
     DROP TABLE public.tipo_usuario;
       public         heap r       siesu01    false    6         �            1259    620885    tipo_usuario_id_tipo_seq    SEQUENCE     �   CREATE SEQUENCE public.tipo_usuario_id_tipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.tipo_usuario_id_tipo_seq;
       public               siesu01    false    6    203         t           0    0    tipo_usuario_id_tipo_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.tipo_usuario_id_tipo_seq OWNED BY public.tipo_usuario.id_tipo;
          public               siesu01    false    202         �            1259    620897    usuario    TABLE     �   CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    senha character varying(100) NOT NULL,
    id_tipo integer NOT NULL
);
    DROP TABLE public.usuario;
       public         heap r       siesu01    false    6         �            1259    620895    usuario_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.usuario_id_usuario_seq;
       public               siesu01    false    205    6         u           0    0    usuario_id_usuario_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;
          public               siesu01    false    204         �            1259    629121    vw_estagios_pendentes    VIEW       CREATE VIEW public.vw_estagios_pendentes AS
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
 (   DROP VIEW public.vw_estagios_pendentes;
       public       v       siesu01    false    226    222    231    231    231    205    231    231    231    231    205    229    229    229    226    209    209    213    213    222    6         `           2604    621010    area id_area    DEFAULT     l   ALTER TABLE ONLY public.area ALTER COLUMN id_area SET DEFAULT nextval('public.area_id_area_seq'::regclass);
 ;   ALTER TABLE public.area ALTER COLUMN id_area DROP DEFAULT;
       public               siesu01    false    221    222    222         h           2604    621151    blockchain_registro id_registro    DEFAULT     �   ALTER TABLE ONLY public.blockchain_registro ALTER COLUMN id_registro SET DEFAULT nextval('public.blockchain_registro_id_registro_seq'::regclass);
 N   ALTER TABLE public.blockchain_registro ALTER COLUMN id_registro DROP DEFAULT;
       public               siesu01    false    234    235    235         Z           2604    620925    curso id_curso    DEFAULT     p   ALTER TABLE ONLY public.curso ALTER COLUMN id_curso SET DEFAULT nextval('public.curso_id_curso_seq'::regclass);
 =   ALTER TABLE public.curso ALTER COLUMN id_curso DROP DEFAULT;
       public               siesu01    false    209    208    209         f           2604    621137    documento_estagio id_documento    DEFAULT     �   ALTER TABLE ONLY public.documento_estagio ALTER COLUMN id_documento SET DEFAULT nextval('public.documento_estagio_id_documento_seq'::regclass);
 M   ALTER TABLE public.documento_estagio ALTER COLUMN id_documento DROP DEFAULT;
       public               siesu01    false    233    232    233         \           2604    620946    escola id_escola    DEFAULT     t   ALTER TABLE ONLY public.escola ALTER COLUMN id_escola SET DEFAULT nextval('public.escola_id_escola_seq'::regclass);
 ?   ALTER TABLE public.escola ALTER COLUMN id_escola DROP DEFAULT;
       public               siesu01    false    212    213    213         c           2604    621073    estagiario id_estagiario    DEFAULT     �   ALTER TABLE ONLY public.estagiario ALTER COLUMN id_estagiario SET DEFAULT nextval('public.estagiario_id_estagiario_seq'::regclass);
 G   ALTER TABLE public.estagiario ALTER COLUMN id_estagiario DROP DEFAULT;
       public               siesu01    false    229    228    229         d           2604    621098    estagio id_estagio    DEFAULT     x   ALTER TABLE ONLY public.estagio ALTER COLUMN id_estagio SET DEFAULT nextval('public.estagio_id_estagio_seq'::regclass);
 A   ALTER TABLE public.estagio ALTER COLUMN id_estagio DROP DEFAULT;
       public               siesu01    false    231    230    231         j           2604    621170    estagio_etapa id_etapa    DEFAULT     �   ALTER TABLE ONLY public.estagio_etapa ALTER COLUMN id_etapa SET DEFAULT nextval('public.estagio_etapa_id_etapa_seq'::regclass);
 E   ALTER TABLE public.estagio_etapa ALTER COLUMN id_etapa DROP DEFAULT;
       public               siesu01    false    237    236    237         Y           2604    620915    instituicao id_instituicao    DEFAULT     �   ALTER TABLE ONLY public.instituicao ALTER COLUMN id_instituicao SET DEFAULT nextval('public.instituicao_id_instituicao_seq'::regclass);
 I   ALTER TABLE public.instituicao ALTER COLUMN id_instituicao DROP DEFAULT;
       public               siesu01    false    207    206    207         _           2604    620987    modalidade id_modalidade    DEFAULT     �   ALTER TABLE ONLY public.modalidade ALTER COLUMN id_modalidade SET DEFAULT nextval('public.modalidade_id_modalidade_seq'::regclass);
 G   ALTER TABLE public.modalidade ALTER COLUMN id_modalidade DROP DEFAULT;
       public               siesu01    false    218    219    219         a           2604    621018    orientador id_orientador    DEFAULT     �   ALTER TABLE ONLY public.orientador ALTER COLUMN id_orientador SET DEFAULT nextval('public.orientador_id_orientador_seq'::regclass);
 G   ALTER TABLE public.orientador ALTER COLUMN id_orientador DROP DEFAULT;
       public               siesu01    false    224    223    224         b           2604    621038    professor id_professor    DEFAULT     �   ALTER TABLE ONLY public.professor ALTER COLUMN id_professor SET DEFAULT nextval('public.professor_id_professor_seq'::regclass);
 E   ALTER TABLE public.professor ALTER COLUMN id_professor DROP DEFAULT;
       public               siesu01    false    226    225    226         [           2604    620938    regional id_regional    DEFAULT     |   ALTER TABLE ONLY public.regional ALTER COLUMN id_regional SET DEFAULT nextval('public.regional_id_regional_seq'::regclass);
 C   ALTER TABLE public.regional ALTER COLUMN id_regional DROP DEFAULT;
       public               siesu01    false    210    211    211         ]           2604    620961    telefone_escola id_telefone    DEFAULT     �   ALTER TABLE ONLY public.telefone_escola ALTER COLUMN id_telefone SET DEFAULT nextval('public.telefone_escola_id_telefone_seq'::regclass);
 J   ALTER TABLE public.telefone_escola ALTER COLUMN id_telefone DROP DEFAULT;
       public               siesu01    false    214    215    215         ^           2604    620974    telefone_regional id_telefone    DEFAULT     �   ALTER TABLE ONLY public.telefone_regional ALTER COLUMN id_telefone SET DEFAULT nextval('public.telefone_regional_id_telefone_seq'::regclass);
 L   ALTER TABLE public.telefone_regional ALTER COLUMN id_telefone DROP DEFAULT;
       public               siesu01    false    216    217    217         W           2604    620890    tipo_usuario id_tipo    DEFAULT     |   ALTER TABLE ONLY public.tipo_usuario ALTER COLUMN id_tipo SET DEFAULT nextval('public.tipo_usuario_id_tipo_seq'::regclass);
 C   ALTER TABLE public.tipo_usuario ALTER COLUMN id_tipo DROP DEFAULT;
       public               siesu01    false    203    202    203         X           2604    620900    usuario id_usuario    DEFAULT     x   ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);
 A   ALTER TABLE public.usuario ALTER COLUMN id_usuario DROP DEFAULT;
       public               siesu01    false    205    204    205         O          0    621007    area 
   TABLE DATA           -   COPY public.area (id_area, nome) FROM stdin;
    public               siesu01    false    222       3151.dat \          0    621148    blockchain_registro 
   TABLE DATA           �   COPY public.blockchain_registro (id_registro, id_estagio, id_documento, tipo_evento, hash_blockchain, data_registro) FROM stdin;
    public               siesu01    false    235       3164.dat B          0    620922    curso 
   TABLE DATA           ?   COPY public.curso (id_curso, nome, id_instituicao) FROM stdin;
    public               siesu01    false    209       3138.dat Z          0    621134    documento_estagio 
   TABLE DATA           n   COPY public.documento_estagio (id_documento, id_estagio, tipo_documento, caminho_pdf, data_envio) FROM stdin;
    public               siesu01    false    233       3162.dat F          0    620943    escola 
   TABLE DATA           N   COPY public.escola (id_escola, nome, cnpj, endereco, id_regional) FROM stdin;
    public               siesu01    false    213       3142.dat M          0    620990    escola_modalidade 
   TABLE DATA           E   COPY public.escola_modalidade (id_escola, id_modalidade) FROM stdin;
    public               siesu01    false    220       3149.dat V          0    621070 
   estagiario 
   TABLE DATA           Y   COPY public.estagiario (id_estagiario, id_usuario, id_curso, id_instituicao) FROM stdin;
    public               siesu01    false    229       3158.dat X          0    621095    estagio 
   TABLE DATA           �   COPY public.estagio (id_estagio, id_estagiario, id_professor, id_orientador, id_escola, id_area, id_modalidade, status, data_criacao) FROM stdin;
    public               siesu01    false    231       3160.dat ^          0    621167    estagio_etapa 
   TABLE DATA           �   COPY public.estagio_etapa (id_etapa, id_estagio, etapa, data_inicio, data_fim, id_usuario_assinante, id_documento, hash_blockchain) FROM stdin;
    public               siesu01    false    237       3166.dat @          0    620912    instituicao 
   TABLE DATA           G   COPY public.instituicao (id_instituicao, nome, tipo, cnpj) FROM stdin;
    public               siesu01    false    207       3136.dat L          0    620984 
   modalidade 
   TABLE DATA           9   COPY public.modalidade (id_modalidade, nome) FROM stdin;
    public               siesu01    false    219       3148.dat Q          0    621015 
   orientador 
   TABLE DATA           O   COPY public.orientador (id_orientador, id_usuario, id_instituicao) FROM stdin;
    public               siesu01    false    224       3153.dat S          0    621035 	   professor 
   TABLE DATA           H   COPY public.professor (id_professor, id_usuario, id_escola) FROM stdin;
    public               siesu01    false    226       3155.dat T          0    621053    professor_area 
   TABLE DATA           ?   COPY public.professor_area (id_professor, id_area) FROM stdin;
    public               siesu01    false    227       3156.dat D          0    620935    regional 
   TABLE DATA           <   COPY public.regional (id_regional, nome, email) FROM stdin;
    public               siesu01    false    211       3140.dat H          0    620958    telefone_escola 
   TABLE DATA           I   COPY public.telefone_escola (id_telefone, id_escola, numero) FROM stdin;
    public               siesu01    false    215       3144.dat J          0    620971    telefone_regional 
   TABLE DATA           M   COPY public.telefone_regional (id_telefone, id_regional, numero) FROM stdin;
    public               siesu01    false    217       3146.dat <          0    620887    tipo_usuario 
   TABLE DATA           5   COPY public.tipo_usuario (id_tipo, nome) FROM stdin;
    public               siesu01    false    203       3132.dat >          0    620897    usuario 
   TABLE DATA           J   COPY public.usuario (id_usuario, nome, email, senha, id_tipo) FROM stdin;
    public               siesu01    false    205       3134.dat v           0    0    area_id_area_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.area_id_area_seq', 3, true);
          public               siesu01    false    221         w           0    0 #   blockchain_registro_id_registro_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.blockchain_registro_id_registro_seq', 5, true);
          public               siesu01    false    234         x           0    0    curso_id_curso_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.curso_id_curso_seq', 6, true);
          public               siesu01    false    208         y           0    0 "   documento_estagio_id_documento_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.documento_estagio_id_documento_seq', 17, true);
          public               siesu01    false    232         z           0    0    escola_id_escola_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.escola_id_escola_seq', 4, true);
          public               siesu01    false    212         {           0    0    estagiario_id_estagiario_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.estagiario_id_estagiario_seq', 2, true);
          public               siesu01    false    228         |           0    0    estagio_etapa_id_etapa_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.estagio_etapa_id_etapa_seq', 7, true);
          public               siesu01    false    236         }           0    0    estagio_id_estagio_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.estagio_id_estagio_seq', 20, true);
          public               siesu01    false    230         ~           0    0    instituicao_id_instituicao_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.instituicao_id_instituicao_seq', 2, true);
          public               siesu01    false    206                    0    0    modalidade_id_modalidade_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.modalidade_id_modalidade_seq', 3, true);
          public               siesu01    false    218         �           0    0    orientador_id_orientador_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.orientador_id_orientador_seq', 2, true);
          public               siesu01    false    223         �           0    0    professor_id_professor_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.professor_id_professor_seq', 4, true);
          public               siesu01    false    225         �           0    0    regional_id_regional_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.regional_id_regional_seq', 1, false);
          public               siesu01    false    210         �           0    0    telefone_escola_id_telefone_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.telefone_escola_id_telefone_seq', 1, false);
          public               siesu01    false    214         �           0    0 !   telefone_regional_id_telefone_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.telefone_regional_id_telefone_seq', 1, false);
          public               siesu01    false    216         �           0    0    tipo_usuario_id_tipo_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.tipo_usuario_id_tipo_seq', 3, true);
          public               siesu01    false    202         �           0    0    usuario_id_usuario_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 43, true);
          public               siesu01    false    204         �           2606    621012    area area_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (id_area);
 8   ALTER TABLE ONLY public.area DROP CONSTRAINT area_pkey;
       public                 siesu01    false    222         �           2606    621154 ,   blockchain_registro blockchain_registro_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_pkey PRIMARY KEY (id_registro);
 V   ALTER TABLE ONLY public.blockchain_registro DROP CONSTRAINT blockchain_registro_pkey;
       public                 siesu01    false    235         y           2606    620927    curso curso_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (id_curso);
 :   ALTER TABLE ONLY public.curso DROP CONSTRAINT curso_pkey;
       public                 siesu01    false    209         �           2606    621140 (   documento_estagio documento_estagio_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.documento_estagio
    ADD CONSTRAINT documento_estagio_pkey PRIMARY KEY (id_documento);
 R   ALTER TABLE ONLY public.documento_estagio DROP CONSTRAINT documento_estagio_pkey;
       public                 siesu01    false    233         }           2606    620950    escola escola_cnpj_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_cnpj_key UNIQUE (cnpj);
 @   ALTER TABLE ONLY public.escola DROP CONSTRAINT escola_cnpj_key;
       public                 siesu01    false    213         �           2606    620994 (   escola_modalidade escola_modalidade_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_pkey PRIMARY KEY (id_escola, id_modalidade);
 R   ALTER TABLE ONLY public.escola_modalidade DROP CONSTRAINT escola_modalidade_pkey;
       public                 siesu01    false    220    220                    2606    620948    escola escola_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_pkey PRIMARY KEY (id_escola);
 <   ALTER TABLE ONLY public.escola DROP CONSTRAINT escola_pkey;
       public                 siesu01    false    213         �           2606    621077 $   estagiario estagiario_id_usuario_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_usuario_key UNIQUE (id_usuario);
 N   ALTER TABLE ONLY public.estagiario DROP CONSTRAINT estagiario_id_usuario_key;
       public                 siesu01    false    229         �           2606    621075    estagiario estagiario_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_pkey PRIMARY KEY (id_estagiario);
 D   ALTER TABLE ONLY public.estagiario DROP CONSTRAINT estagiario_pkey;
       public                 siesu01    false    229         �           2606    621173     estagio_etapa estagio_etapa_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_pkey PRIMARY KEY (id_etapa);
 J   ALTER TABLE ONLY public.estagio_etapa DROP CONSTRAINT estagio_etapa_pkey;
       public                 siesu01    false    237         �           2606    621101    estagio estagio_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_pkey PRIMARY KEY (id_estagio);
 >   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_pkey;
       public                 siesu01    false    231         u           2606    620919     instituicao instituicao_cnpj_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.instituicao
    ADD CONSTRAINT instituicao_cnpj_key UNIQUE (cnpj);
 J   ALTER TABLE ONLY public.instituicao DROP CONSTRAINT instituicao_cnpj_key;
       public                 siesu01    false    207         w           2606    620917    instituicao instituicao_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.instituicao
    ADD CONSTRAINT instituicao_pkey PRIMARY KEY (id_instituicao);
 F   ALTER TABLE ONLY public.instituicao DROP CONSTRAINT instituicao_pkey;
       public                 siesu01    false    207         �           2606    620989    modalidade modalidade_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.modalidade
    ADD CONSTRAINT modalidade_pkey PRIMARY KEY (id_modalidade);
 D   ALTER TABLE ONLY public.modalidade DROP CONSTRAINT modalidade_pkey;
       public                 siesu01    false    219         �           2606    621022 $   orientador orientador_id_usuario_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_id_usuario_key UNIQUE (id_usuario);
 N   ALTER TABLE ONLY public.orientador DROP CONSTRAINT orientador_id_usuario_key;
       public                 siesu01    false    224         �           2606    621020    orientador orientador_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_pkey PRIMARY KEY (id_orientador);
 D   ALTER TABLE ONLY public.orientador DROP CONSTRAINT orientador_pkey;
       public                 siesu01    false    224         �           2606    621057 "   professor_area professor_area_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_pkey PRIMARY KEY (id_professor, id_area);
 L   ALTER TABLE ONLY public.professor_area DROP CONSTRAINT professor_area_pkey;
       public                 siesu01    false    227    227         �           2606    621042 "   professor professor_id_usuario_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_usuario_key UNIQUE (id_usuario);
 L   ALTER TABLE ONLY public.professor DROP CONSTRAINT professor_id_usuario_key;
       public                 siesu01    false    226         �           2606    621040    professor professor_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_pkey PRIMARY KEY (id_professor);
 B   ALTER TABLE ONLY public.professor DROP CONSTRAINT professor_pkey;
       public                 siesu01    false    226         {           2606    620940    regional regional_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.regional
    ADD CONSTRAINT regional_pkey PRIMARY KEY (id_regional);
 @   ALTER TABLE ONLY public.regional DROP CONSTRAINT regional_pkey;
       public                 siesu01    false    211         �           2606    620963 $   telefone_escola telefone_escola_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.telefone_escola
    ADD CONSTRAINT telefone_escola_pkey PRIMARY KEY (id_telefone);
 N   ALTER TABLE ONLY public.telefone_escola DROP CONSTRAINT telefone_escola_pkey;
       public                 siesu01    false    215         �           2606    620976 (   telefone_regional telefone_regional_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.telefone_regional
    ADD CONSTRAINT telefone_regional_pkey PRIMARY KEY (id_telefone);
 R   ALTER TABLE ONLY public.telefone_regional DROP CONSTRAINT telefone_regional_pkey;
       public                 siesu01    false    217         m           2606    620894 "   tipo_usuario tipo_usuario_nome_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_nome_key UNIQUE (nome);
 L   ALTER TABLE ONLY public.tipo_usuario DROP CONSTRAINT tipo_usuario_nome_key;
       public                 siesu01    false    203         o           2606    620892    tipo_usuario tipo_usuario_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_pkey PRIMARY KEY (id_tipo);
 H   ALTER TABLE ONLY public.tipo_usuario DROP CONSTRAINT tipo_usuario_pkey;
       public                 siesu01    false    203         q           2606    620904    usuario usuario_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_email_key;
       public                 siesu01    false    205         s           2606    620902    usuario usuario_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public                 siesu01    false    205         �           2606    621160 9   blockchain_registro blockchain_registro_id_documento_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_id_documento_fkey FOREIGN KEY (id_documento) REFERENCES public.documento_estagio(id_documento);
 c   ALTER TABLE ONLY public.blockchain_registro DROP CONSTRAINT blockchain_registro_id_documento_fkey;
       public               siesu01    false    235    233    2971         �           2606    621155 7   blockchain_registro blockchain_registro_id_estagio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_id_estagio_fkey FOREIGN KEY (id_estagio) REFERENCES public.estagio(id_estagio);
 a   ALTER TABLE ONLY public.blockchain_registro DROP CONSTRAINT blockchain_registro_id_estagio_fkey;
       public               siesu01    false    235    2969    231         �           2606    620928    curso curso_id_instituicao_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);
 I   ALTER TABLE ONLY public.curso DROP CONSTRAINT curso_id_instituicao_fkey;
       public               siesu01    false    2935    209    207         �           2606    621141 3   documento_estagio documento_estagio_id_estagio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.documento_estagio
    ADD CONSTRAINT documento_estagio_id_estagio_fkey FOREIGN KEY (id_estagio) REFERENCES public.estagio(id_estagio);
 ]   ALTER TABLE ONLY public.documento_estagio DROP CONSTRAINT documento_estagio_id_estagio_fkey;
       public               siesu01    false    231    233    2969         �           2606    620951    escola escola_id_regional_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_id_regional_fkey FOREIGN KEY (id_regional) REFERENCES public.regional(id_regional);
 H   ALTER TABLE ONLY public.escola DROP CONSTRAINT escola_id_regional_fkey;
       public               siesu01    false    213    2939    211         �           2606    620995 2   escola_modalidade escola_modalidade_id_escola_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.escola_modalidade DROP CONSTRAINT escola_modalidade_id_escola_fkey;
       public               siesu01    false    2943    213    220         �           2606    621000 6   escola_modalidade escola_modalidade_id_modalidade_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_id_modalidade_fkey FOREIGN KEY (id_modalidade) REFERENCES public.modalidade(id_modalidade) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.escola_modalidade DROP CONSTRAINT escola_modalidade_id_modalidade_fkey;
       public               siesu01    false    219    220    2949         �           2606    621083 #   estagiario estagiario_id_curso_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_curso_fkey FOREIGN KEY (id_curso) REFERENCES public.curso(id_curso);
 M   ALTER TABLE ONLY public.estagiario DROP CONSTRAINT estagiario_id_curso_fkey;
       public               siesu01    false    209    229    2937         �           2606    621088 )   estagiario estagiario_id_instituicao_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);
 S   ALTER TABLE ONLY public.estagiario DROP CONSTRAINT estagiario_id_instituicao_fkey;
       public               siesu01    false    229    2935    207         �           2606    621078 %   estagiario estagiario_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.estagiario DROP CONSTRAINT estagiario_id_usuario_fkey;
       public               siesu01    false    2931    229    205         �           2606    621184 -   estagio_etapa estagio_etapa_id_documento_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_id_documento_fkey FOREIGN KEY (id_documento) REFERENCES public.documento_estagio(id_documento);
 W   ALTER TABLE ONLY public.estagio_etapa DROP CONSTRAINT estagio_etapa_id_documento_fkey;
       public               siesu01    false    233    237    2971         �           2606    621174 +   estagio_etapa estagio_etapa_id_estagio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_id_estagio_fkey FOREIGN KEY (id_estagio) REFERENCES public.estagio(id_estagio);
 U   ALTER TABLE ONLY public.estagio_etapa DROP CONSTRAINT estagio_etapa_id_estagio_fkey;
       public               siesu01    false    2969    231    237         �           2606    621179 5   estagio_etapa estagio_etapa_id_usuario_assinante_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_id_usuario_assinante_fkey FOREIGN KEY (id_usuario_assinante) REFERENCES public.usuario(id_usuario);
 _   ALTER TABLE ONLY public.estagio_etapa DROP CONSTRAINT estagio_etapa_id_usuario_assinante_fkey;
       public               siesu01    false    237    205    2931         �           2606    621122    estagio estagio_id_area_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_area_fkey FOREIGN KEY (id_area) REFERENCES public.area(id_area);
 F   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_id_area_fkey;
       public               siesu01    false    2953    222    231         �           2606    621117    estagio estagio_id_escola_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola);
 H   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_id_escola_fkey;
       public               siesu01    false    213    231    2943         �           2606    621102 "   estagio estagio_id_estagiario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_estagiario_fkey FOREIGN KEY (id_estagiario) REFERENCES public.estagiario(id_estagiario);
 L   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_id_estagiario_fkey;
       public               siesu01    false    229    231    2967         �           2606    621127 "   estagio estagio_id_modalidade_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_modalidade_fkey FOREIGN KEY (id_modalidade) REFERENCES public.modalidade(id_modalidade);
 L   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_id_modalidade_fkey;
       public               siesu01    false    231    219    2949         �           2606    621112 "   estagio estagio_id_orientador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_orientador_fkey FOREIGN KEY (id_orientador) REFERENCES public.orientador(id_orientador);
 L   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_id_orientador_fkey;
       public               siesu01    false    231    224    2957         �           2606    621107 !   estagio estagio_id_professor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_professor_fkey FOREIGN KEY (id_professor) REFERENCES public.professor(id_professor);
 K   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_id_professor_fkey;
       public               siesu01    false    226    231    2961         �           2606    621028 )   orientador orientador_id_instituicao_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);
 S   ALTER TABLE ONLY public.orientador DROP CONSTRAINT orientador_id_instituicao_fkey;
       public               siesu01    false    2935    224    207         �           2606    621023 %   orientador orientador_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.orientador DROP CONSTRAINT orientador_id_usuario_fkey;
       public               siesu01    false    205    2931    224         �           2606    621063 *   professor_area professor_area_id_area_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_id_area_fkey FOREIGN KEY (id_area) REFERENCES public.area(id_area) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.professor_area DROP CONSTRAINT professor_area_id_area_fkey;
       public               siesu01    false    227    2953    222         �           2606    621058 /   professor_area professor_area_id_professor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_id_professor_fkey FOREIGN KEY (id_professor) REFERENCES public.professor(id_professor) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.professor_area DROP CONSTRAINT professor_area_id_professor_fkey;
       public               siesu01    false    227    226    2961         �           2606    621048 "   professor professor_id_escola_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola);
 L   ALTER TABLE ONLY public.professor DROP CONSTRAINT professor_id_escola_fkey;
       public               siesu01    false    2943    226    213         �           2606    621043 #   professor professor_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.professor DROP CONSTRAINT professor_id_usuario_fkey;
       public               siesu01    false    226    205    2931         �           2606    620964 .   telefone_escola telefone_escola_id_escola_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefone_escola
    ADD CONSTRAINT telefone_escola_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.telefone_escola DROP CONSTRAINT telefone_escola_id_escola_fkey;
       public               siesu01    false    215    2943    213         �           2606    620977 4   telefone_regional telefone_regional_id_regional_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefone_regional
    ADD CONSTRAINT telefone_regional_id_regional_fkey FOREIGN KEY (id_regional) REFERENCES public.regional(id_regional) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.telefone_regional DROP CONSTRAINT telefone_regional_id_regional_fkey;
       public               siesu01    false    211    217    2939         �           2606    620905    usuario usuario_id_tipo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES public.tipo_usuario(id_tipo);
 F   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_id_tipo_fkey;
       public               siesu01    false    203    2927    205                                                                                                                                                                                                                                                                                 3151.dat                                                                                            0000600 0004000 0002000 00000000101 15033245311 0014230 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Robótica
2	Algorítmos
3	Computação
4	Lógica
5	Python
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                               3164.dat                                                                                            0000600 0004000 0002000 00000001124 15033245311 0014242 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	13	7	proposta_submetida	0000db6ffcd7ef1a79aff6b2c507668879a91ec892f13706abbe250ee8c59370	2025-06-29 19:49:39.853511
2	14	8	proposta_submetida	0000bbca1d81e88f0c8c3c5a198fc76d46f95532c99e4ff313d8d3673a7397a8	2025-06-29 20:08:57.004758
3	15	9	proposta_submetida	00009192ff7c1ac1fbe7ac1020a05d34d2982a821a5ea4c41c29732c9cb6ed10	2025-06-29 20:10:48.750083
4	19	14	proposta_submetida	0000ed5b922d43b954321c47c2dd2167e8c8ce34d57f01e6084fa04f686cf314	2025-06-29 22:43:43.41116
5	20	16	proposta_submetida	0000de8998a5ae46c481076b72e00cf4dfed9d707a2802a3016962b045709002	2025-07-01 21:33:57.298716
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                            3138.dat                                                                                            0000600 0004000 0002000 00000000175 15033245311 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Licenciatura em Computação	1
2	Matemática	1
3	Português	1
4	Licenciatura em Física	2
5	Geografia	2
6	História	2
\.


                                                                                                                                                                                                                                                                                                                                                                                                   3162.dat                                                                                            0000600 0004000 0002000 00000002647 15033245311 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	4	proposta	uploads\\1751233379249-588309494-Fatura_Venc_26_06.pdf	2025-06-29 18:45:11.220535
2	5	proposta	uploads\\1751233483691-443429660-Fatura_Venc_26_06.pdf	2025-06-29 18:46:56.116681
3	6	proposta	uploads\\1751233534717-701500878-Proposta_CronogramaFinal_2025_1.pdf	2025-06-29 18:47:47.131114
4	7	proposta	uploads\\1751233963143-103777659-Proposta_CronogramaFinal_2025_1.pdf	2025-06-29 18:54:55.571271
6	12	proposta	D:\\Dev\\UnB\\2025_1\\SIESU\\back_node\\uploads\\proposta_1751236857283.pdf	2025-06-29 19:43:09.737182
7	13	proposta	D:\\Dev\\UnB\\2025_1\\SIESU\\back_node\\uploads\\proposta_1751237246619.pdf	2025-06-29 19:49:38.603986
8	14	proposta	D:\\Dev\\UnB\\2025_1\\SIESU\\back_node\\uploads\\proposta_1751238402843.pdf	2025-06-29 20:08:55.276191
9	15	proposta	D:\\Dev\\UnB\\2025_1\\SIESU\\back_node\\uploads\\proposta_1751238515909.pdf	2025-06-29 20:10:48.342451
10	15	acompanhamento	uploads/1751242654553.pdf	2025-06-29 21:19:46.239004
11	16	proposta	uploads\\1751244403037.pdf	2025-06-29 21:50:11.64731
12	17	proposta	uploads\\1751244464149.pdf	2025-06-29 21:50:16.083345
13	18	proposta	uploads\\1751245019461.pdf	2025-06-29 21:59:11.895035
14	19	proposta	uploads\\1751247690834.pdf	2025-06-29 22:43:42.824536
15	15	acompanhamento	uploads/1751251168083.pdf	2025-06-29 23:41:40.226478
16	20	proposta	uploads\\1751416296090.pdf	2025-07-01 21:33:53.769998
17	20	acompanhamento	uploads/1751417231716.pdf	2025-07-01 21:49:29.096776
\.


                                                                                         3142.dat                                                                                            0000600 0004000 0002000 00000000421 15033245311 0014235 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Ced 01 do Itapoa	12.345.678/0001-90	CEP 70.201-001	3
2	Cef 01 do Gama	23.456.789/0001-01	CEP 70.201-002	4
3	Ec 08 de Taguatinga	34.567.890/0001-12	CEP 70.201-003	5
4	Ec 106 Norte	45.678.901/0001-23	CEP 70.201-004	1
5	EC 102 Norte	22.555.888/0001-20	CEP 70.201-005	1
\.


                                                                                                                                                                                                                                               3149.dat                                                                                            0000600 0004000 0002000 00000000031 15033245311 0014241 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1
2	2
3	3
4	4
5	5
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       3158.dat                                                                                            0000600 0004000 0002000 00000000062 15033245312 0014246 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	29	1	1
2	30	2	1
3	35	3	2
4	36	4	3
5	40	5	3
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                              3160.dat                                                                                            0000600 0004000 0002000 00000001457 15033245312 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        3	1	2	2	1	1	2	pendente	2025-06-29 18:14:26.885597
4	1	1	1	4	3	3	pendente	2025-06-29 18:45:11.071334
5	1	1	1	4	3	3	pendente	2025-06-29 18:46:55.967316
6	1	1	2	4	3	2	pendente	2025-06-29 18:47:46.983144
7	1	1	2	4	3	2	pendente	2025-06-29 18:54:55.419155
10	1	1	2	4	3	2	pendente	2025-06-29 19:35:02.349649
11	1	2	2	1	1	3	pendente	2025-06-29 19:40:53.054982
12	1	2	2	1	1	3	pendente	2025-06-29 19:43:09.58531
13	1	2	2	1	1	3	pendente	2025-06-29 19:49:38.451626
14	1	1	1	4	3	3	pendente	2025-06-29 20:08:55.124038
15	1	1	1	4	3	3	pendente	2025-06-29 20:10:48.188126
16	1	2	2	1	1	3	pendente	2025-06-29 21:49:09.486132
17	1	2	2	1	1	3	pendente	2025-06-29 21:50:11.606382
18	2	1	2	4	3	2	pendente	2025-06-29 21:59:11.742495
19	1	1	1	4	3	3	pendente	2025-06-29 22:43:42.674009
20	2	4	1	3	1	2	pendente	2025-07-01 21:33:53.615313
\.


                                                                                                                                                                                                                 3166.dat                                                                                            0000600 0004000 0002000 00000001364 15033245312 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	15	inclusão	2025-06-29 20:10:48.89948	\N	29	9	00009192ff7c1ac1fbe7ac1020a05d34d2982a821a5ea4c41c29732c9cb6ed10
3	15	Mensagem e Documento Enviados	2025-06-29 21:19:49.209874	\N	\N	10	000053373e51febaa14b96b255f572bee5d3e69369252e08918eb8eed7eea49f
4	19	inclusão	2025-06-29 22:43:43.56054	\N	29	14	0000ed5b922d43b954321c47c2dd2167e8c8ce34d57f01e6084fa04f686cf314
5	15	Mensagem e Documento Enviados	2025-06-29 23:41:41.0432	\N	29	15	00007ae70bf68c983ce4d88def76e1883807ae9288d8db267b7f1ca1d5f3df15
6	20	inclusão	2025-07-01 21:33:57.447365	\N	30	16	0000de8998a5ae46c481076b72e00cf4dfed9d707a2802a3016962b045709002
7	20	Mensagem e Documento Enviados	2025-07-01 21:49:30.032817	\N	43	17	0000e67460bbb01157ddafe22bac5f09a9cdfcc9a50079de807fd192e142d0b5
\.


                                                                                                                                                                                                                                                                            3136.dat                                                                                            0000600 0004000 0002000 00000000323 15033245312 0014242 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	UnB	Universidade	00.000.000/0001-00
2	CeuB	Centro Universitário	11.111.111/0001-11
3	UNIP	Universidade	11.222.333/0001-12
4	UNIVASF	Universidade	22.111.333/0001-33
5	UFSC	Universidade	33.111.222/0001-25
\.


                                                                                                                                                                                                                                                                                                             3148.dat                                                                                            0000600 0004000 0002000 00000000150 15033245312 0014243 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Ensino Médio
3	EJA
2	Ensino Fundamental 1
4	Ensisno Fundamental 2
5	Ensino Fundamental e Médio
\.


                                                                                                                                                                                                                                                                                                                                                                                                                        3153.dat                                                                                            0000600 0004000 0002000 00000000050 15033245312 0014236 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	39	1
2	40	1
3	35	2
4	36	3
5	45	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        3155.dat                                                                                            0000600 0004000 0002000 00000000050 15033245313 0014241 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	35	4
2	36	1
4	43	3
3	27	5
5	28	2
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        3156.dat                                                                                            0000600 0004000 0002000 00000000031 15033245313 0014241 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	3
2	1
4	1
3	5
5	2
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       3140.dat                                                                                            0000600 0004000 0002000 00000000211 15033245313 0014232 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Asa Norte	asanorte@gov.br
2	Asa Sul	asasul@gov.br
3	Recanto	recanto@gov.br
4	Guará	guara@gov.br
5	Arniqueiras	arniqueiras@gov.br
\.


                                                                                                                                                                                                                                                                                                                                                                                       3144.dat                                                                                            0000600 0004000 0002000 00000000120 15033245313 0014235 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	6122334455
2	2	6133225533
3	3	6123235454
4	4	6132324545
5	5	6131324342
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                3146.dat                                                                                            0000600 0004000 0002000 00000000120 15033245313 0014237 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	6135366767
2	2	6137358787
3	3	6138767576
4	4	6139768789
5	5	6134373899
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                3132.dat                                                                                            0000600 0004000 0002000 00000000101 15033245313 0014231 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	aluno
2	professor
3	orientador
4	supervisor
5	coordenador
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                               3134.dat                                                                                            0000600 0004000 0002000 00000001673 15033245313 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        29	CARLOS E I OLIVEIRA	carloseduardoiunes@gmail.com	$2b$10$8J1QOTZ89CaekVNmRWVb2.s33yTNZH6xJdFFpCNeAbCocb4sSmfGK	1
30	Robson	robson@gmail.com	$2b$10$1SaSfuRW9SqB/nRfk1R55uz/LGvEs/hxtFXr3CTYkFFWrIxkYR326	1
35	Sergio	sergio@prof.edu.br	$2b$10$7qDOkvfepbFbJVpTvWUjuullB2wHAiVEBgFT.npGtSwj6qtSJwFOa	3
36	Joana	joana@prof.edu.br	$2b$10$Ohhwvza1pcazUol4TXs6TOPmiZZYeQcbbacJfQJM5p2Kkjhf3DLC.	3
39	Ladeira	ladeira@unb.br	$2b$10$FaMokSF3RTOmTTO8RftyEe8PFeswyHsgFRSmbWMECAKckEofdDJb6	3
40	Maristela	maristelaProf@unb.br	$2b$10$Fa5GV0tV2ycvCVZpyqpE0uUBmHlLspTupoO.mBedJNijsVQdXlf46	3
43	Pedro	pedro@gmail.com	$2b$10$6nH5P8IANAQsBZrgiamxcOuBfPRRjPow4GEb8wzL6Rs1Da6HVMu6S	2
45	Chacon	chacon@prof.unb.br	$2b$10$8J1QOTZ89CaekVNmRWVb2.s33yTNZH6xJdFFpCNeAbCocb4sSmfGK	3
28	Ana Maria	anamaria@ec102.gov.br	$2b$10$8J1QOTZ89CaekVNmRWVb2.s33yTNZH6xJdFFpCNeAbCocb4sSmfGK	3
27	José Fábio	jfabio@ec106.gov.br	$2b$10$8J1QOTZ89CaekVNmRWVb2.s33yTNZH6xJdFFpCNeAbCocb4sSmfGK	3
\.


                                                                     restore.sql                                                                                         0000600 0004000 0002000 00000113735 15033245313 0015375 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 17.5

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

DROP DATABASE siesudb;
--
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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
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
-- Name: area; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.area (
    id_area integer NOT NULL,
    nome character varying(100) NOT NULL
);


--
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
-- Name: area_id_area_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.area_id_area_seq OWNED BY public.area.id_area;


--
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
-- Name: blockchain_registro_id_registro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blockchain_registro_id_registro_seq OWNED BY public.blockchain_registro.id_registro;


--
-- Name: curso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.curso (
    id_curso integer NOT NULL,
    nome character varying(100) NOT NULL,
    id_instituicao integer NOT NULL
);


--
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
-- Name: curso_id_curso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.curso_id_curso_seq OWNED BY public.curso.id_curso;


--
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
-- Name: documento_estagio_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.documento_estagio_id_documento_seq OWNED BY public.documento_estagio.id_documento;


--
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
-- Name: escola_id_escola_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.escola_id_escola_seq OWNED BY public.escola.id_escola;


--
-- Name: escola_modalidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.escola_modalidade (
    id_escola integer NOT NULL,
    id_modalidade integer NOT NULL
);


--
-- Name: estagiario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estagiario (
    id_estagiario integer NOT NULL,
    id_usuario integer NOT NULL,
    id_curso integer NOT NULL,
    id_instituicao integer NOT NULL
);


--
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
-- Name: estagiario_id_estagiario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estagiario_id_estagiario_seq OWNED BY public.estagiario.id_estagiario;


--
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
-- Name: estagio_etapa_id_etapa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estagio_etapa_id_etapa_seq OWNED BY public.estagio_etapa.id_etapa;


--
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
-- Name: estagio_id_estagio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estagio_id_estagio_seq OWNED BY public.estagio.id_estagio;


--
-- Name: instituicao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.instituicao (
    id_instituicao integer NOT NULL,
    nome character varying(150) NOT NULL,
    tipo character varying(50) NOT NULL,
    cnpj character varying(18)
);


--
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
-- Name: instituicao_id_instituicao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.instituicao_id_instituicao_seq OWNED BY public.instituicao.id_instituicao;


--
-- Name: modalidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.modalidade (
    id_modalidade integer NOT NULL,
    nome character varying(50) NOT NULL
);


--
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
-- Name: modalidade_id_modalidade_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.modalidade_id_modalidade_seq OWNED BY public.modalidade.id_modalidade;


--
-- Name: orientador; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orientador (
    id_orientador integer NOT NULL,
    id_usuario integer NOT NULL,
    id_instituicao integer NOT NULL
);


--
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
-- Name: orientador_id_orientador_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orientador_id_orientador_seq OWNED BY public.orientador.id_orientador;


--
-- Name: professor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.professor (
    id_professor integer NOT NULL,
    id_usuario integer NOT NULL,
    id_escola integer NOT NULL
);


--
-- Name: professor_area; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.professor_area (
    id_professor integer NOT NULL,
    id_area integer NOT NULL
);


--
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
-- Name: professor_id_professor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.professor_id_professor_seq OWNED BY public.professor.id_professor;


--
-- Name: regional; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.regional (
    id_regional integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100)
);


--
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
-- Name: regional_id_regional_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.regional_id_regional_seq OWNED BY public.regional.id_regional;


--
-- Name: telefone_escola; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telefone_escola (
    id_telefone integer NOT NULL,
    id_escola integer NOT NULL,
    numero character varying(20) NOT NULL
);


--
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
-- Name: telefone_escola_id_telefone_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.telefone_escola_id_telefone_seq OWNED BY public.telefone_escola.id_telefone;


--
-- Name: telefone_regional; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telefone_regional (
    id_telefone integer NOT NULL,
    id_regional integer NOT NULL,
    numero character varying(20) NOT NULL
);


--
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
-- Name: telefone_regional_id_telefone_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.telefone_regional_id_telefone_seq OWNED BY public.telefone_regional.id_telefone;


--
-- Name: tipo_usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tipo_usuario (
    id_tipo integer NOT NULL,
    nome character varying(30) NOT NULL
);


--
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
-- Name: tipo_usuario_id_tipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tipo_usuario_id_tipo_seq OWNED BY public.tipo_usuario.id_tipo;


--
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
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
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
-- Name: area id_area; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area ALTER COLUMN id_area SET DEFAULT nextval('public.area_id_area_seq'::regclass);


--
-- Name: blockchain_registro id_registro; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blockchain_registro ALTER COLUMN id_registro SET DEFAULT nextval('public.blockchain_registro_id_registro_seq'::regclass);


--
-- Name: curso id_curso; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curso ALTER COLUMN id_curso SET DEFAULT nextval('public.curso_id_curso_seq'::regclass);


--
-- Name: documento_estagio id_documento; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documento_estagio ALTER COLUMN id_documento SET DEFAULT nextval('public.documento_estagio_id_documento_seq'::regclass);


--
-- Name: escola id_escola; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola ALTER COLUMN id_escola SET DEFAULT nextval('public.escola_id_escola_seq'::regclass);


--
-- Name: estagiario id_estagiario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagiario ALTER COLUMN id_estagiario SET DEFAULT nextval('public.estagiario_id_estagiario_seq'::regclass);


--
-- Name: estagio id_estagio; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio ALTER COLUMN id_estagio SET DEFAULT nextval('public.estagio_id_estagio_seq'::regclass);


--
-- Name: estagio_etapa id_etapa; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio_etapa ALTER COLUMN id_etapa SET DEFAULT nextval('public.estagio_etapa_id_etapa_seq'::regclass);


--
-- Name: instituicao id_instituicao; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituicao ALTER COLUMN id_instituicao SET DEFAULT nextval('public.instituicao_id_instituicao_seq'::regclass);


--
-- Name: modalidade id_modalidade; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modalidade ALTER COLUMN id_modalidade SET DEFAULT nextval('public.modalidade_id_modalidade_seq'::regclass);


--
-- Name: orientador id_orientador; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orientador ALTER COLUMN id_orientador SET DEFAULT nextval('public.orientador_id_orientador_seq'::regclass);


--
-- Name: professor id_professor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor ALTER COLUMN id_professor SET DEFAULT nextval('public.professor_id_professor_seq'::regclass);


--
-- Name: regional id_regional; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regional ALTER COLUMN id_regional SET DEFAULT nextval('public.regional_id_regional_seq'::regclass);


--
-- Name: telefone_escola id_telefone; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefone_escola ALTER COLUMN id_telefone SET DEFAULT nextval('public.telefone_escola_id_telefone_seq'::regclass);


--
-- Name: telefone_regional id_telefone; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefone_regional ALTER COLUMN id_telefone SET DEFAULT nextval('public.telefone_regional_id_telefone_seq'::regclass);


--
-- Name: tipo_usuario id_tipo; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_usuario ALTER COLUMN id_tipo SET DEFAULT nextval('public.tipo_usuario_id_tipo_seq'::regclass);


--
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.area (id_area, nome) FROM stdin;
\.
COPY public.area (id_area, nome) FROM '$$PATH$$/3151.dat';

--
-- Data for Name: blockchain_registro; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.blockchain_registro (id_registro, id_estagio, id_documento, tipo_evento, hash_blockchain, data_registro) FROM stdin;
\.
COPY public.blockchain_registro (id_registro, id_estagio, id_documento, tipo_evento, hash_blockchain, data_registro) FROM '$$PATH$$/3164.dat';

--
-- Data for Name: curso; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.curso (id_curso, nome, id_instituicao) FROM stdin;
\.
COPY public.curso (id_curso, nome, id_instituicao) FROM '$$PATH$$/3138.dat';

--
-- Data for Name: documento_estagio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.documento_estagio (id_documento, id_estagio, tipo_documento, caminho_pdf, data_envio) FROM stdin;
\.
COPY public.documento_estagio (id_documento, id_estagio, tipo_documento, caminho_pdf, data_envio) FROM '$$PATH$$/3162.dat';

--
-- Data for Name: escola; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.escola (id_escola, nome, cnpj, endereco, id_regional) FROM stdin;
\.
COPY public.escola (id_escola, nome, cnpj, endereco, id_regional) FROM '$$PATH$$/3142.dat';

--
-- Data for Name: escola_modalidade; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.escola_modalidade (id_escola, id_modalidade) FROM stdin;
\.
COPY public.escola_modalidade (id_escola, id_modalidade) FROM '$$PATH$$/3149.dat';

--
-- Data for Name: estagiario; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estagiario (id_estagiario, id_usuario, id_curso, id_instituicao) FROM stdin;
\.
COPY public.estagiario (id_estagiario, id_usuario, id_curso, id_instituicao) FROM '$$PATH$$/3158.dat';

--
-- Data for Name: estagio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estagio (id_estagio, id_estagiario, id_professor, id_orientador, id_escola, id_area, id_modalidade, status, data_criacao) FROM stdin;
\.
COPY public.estagio (id_estagio, id_estagiario, id_professor, id_orientador, id_escola, id_area, id_modalidade, status, data_criacao) FROM '$$PATH$$/3160.dat';

--
-- Data for Name: estagio_etapa; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estagio_etapa (id_etapa, id_estagio, etapa, data_inicio, data_fim, id_usuario_assinante, id_documento, hash_blockchain) FROM stdin;
\.
COPY public.estagio_etapa (id_etapa, id_estagio, etapa, data_inicio, data_fim, id_usuario_assinante, id_documento, hash_blockchain) FROM '$$PATH$$/3166.dat';

--
-- Data for Name: instituicao; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.instituicao (id_instituicao, nome, tipo, cnpj) FROM stdin;
\.
COPY public.instituicao (id_instituicao, nome, tipo, cnpj) FROM '$$PATH$$/3136.dat';

--
-- Data for Name: modalidade; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.modalidade (id_modalidade, nome) FROM stdin;
\.
COPY public.modalidade (id_modalidade, nome) FROM '$$PATH$$/3148.dat';

--
-- Data for Name: orientador; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orientador (id_orientador, id_usuario, id_instituicao) FROM stdin;
\.
COPY public.orientador (id_orientador, id_usuario, id_instituicao) FROM '$$PATH$$/3153.dat';

--
-- Data for Name: professor; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.professor (id_professor, id_usuario, id_escola) FROM stdin;
\.
COPY public.professor (id_professor, id_usuario, id_escola) FROM '$$PATH$$/3155.dat';

--
-- Data for Name: professor_area; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.professor_area (id_professor, id_area) FROM stdin;
\.
COPY public.professor_area (id_professor, id_area) FROM '$$PATH$$/3156.dat';

--
-- Data for Name: regional; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.regional (id_regional, nome, email) FROM stdin;
\.
COPY public.regional (id_regional, nome, email) FROM '$$PATH$$/3140.dat';

--
-- Data for Name: telefone_escola; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.telefone_escola (id_telefone, id_escola, numero) FROM stdin;
\.
COPY public.telefone_escola (id_telefone, id_escola, numero) FROM '$$PATH$$/3144.dat';

--
-- Data for Name: telefone_regional; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.telefone_regional (id_telefone, id_regional, numero) FROM stdin;
\.
COPY public.telefone_regional (id_telefone, id_regional, numero) FROM '$$PATH$$/3146.dat';

--
-- Data for Name: tipo_usuario; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tipo_usuario (id_tipo, nome) FROM stdin;
\.
COPY public.tipo_usuario (id_tipo, nome) FROM '$$PATH$$/3132.dat';

--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.usuario (id_usuario, nome, email, senha, id_tipo) FROM stdin;
\.
COPY public.usuario (id_usuario, nome, email, senha, id_tipo) FROM '$$PATH$$/3134.dat';

--
-- Name: area_id_area_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.area_id_area_seq', 3, true);


--
-- Name: blockchain_registro_id_registro_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blockchain_registro_id_registro_seq', 5, true);


--
-- Name: curso_id_curso_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.curso_id_curso_seq', 6, true);


--
-- Name: documento_estagio_id_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.documento_estagio_id_documento_seq', 17, true);


--
-- Name: escola_id_escola_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.escola_id_escola_seq', 4, true);


--
-- Name: estagiario_id_estagiario_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estagiario_id_estagiario_seq', 2, true);


--
-- Name: estagio_etapa_id_etapa_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estagio_etapa_id_etapa_seq', 7, true);


--
-- Name: estagio_id_estagio_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estagio_id_estagio_seq', 20, true);


--
-- Name: instituicao_id_instituicao_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.instituicao_id_instituicao_seq', 2, true);


--
-- Name: modalidade_id_modalidade_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.modalidade_id_modalidade_seq', 3, true);


--
-- Name: orientador_id_orientador_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orientador_id_orientador_seq', 2, true);


--
-- Name: professor_id_professor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.professor_id_professor_seq', 4, true);


--
-- Name: regional_id_regional_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.regional_id_regional_seq', 1, false);


--
-- Name: telefone_escola_id_telefone_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.telefone_escola_id_telefone_seq', 1, false);


--
-- Name: telefone_regional_id_telefone_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.telefone_regional_id_telefone_seq', 1, false);


--
-- Name: tipo_usuario_id_tipo_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tipo_usuario_id_tipo_seq', 3, true);


--
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 43, true);


--
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (id_area);


--
-- Name: blockchain_registro blockchain_registro_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_pkey PRIMARY KEY (id_registro);


--
-- Name: curso curso_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (id_curso);


--
-- Name: documento_estagio documento_estagio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documento_estagio
    ADD CONSTRAINT documento_estagio_pkey PRIMARY KEY (id_documento);


--
-- Name: escola escola_cnpj_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_cnpj_key UNIQUE (cnpj);


--
-- Name: escola_modalidade escola_modalidade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_pkey PRIMARY KEY (id_escola, id_modalidade);


--
-- Name: escola escola_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_pkey PRIMARY KEY (id_escola);


--
-- Name: estagiario estagiario_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_usuario_key UNIQUE (id_usuario);


--
-- Name: estagiario estagiario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_pkey PRIMARY KEY (id_estagiario);


--
-- Name: estagio_etapa estagio_etapa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_pkey PRIMARY KEY (id_etapa);


--
-- Name: estagio estagio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_pkey PRIMARY KEY (id_estagio);


--
-- Name: instituicao instituicao_cnpj_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituicao
    ADD CONSTRAINT instituicao_cnpj_key UNIQUE (cnpj);


--
-- Name: instituicao instituicao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituicao
    ADD CONSTRAINT instituicao_pkey PRIMARY KEY (id_instituicao);


--
-- Name: modalidade modalidade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modalidade
    ADD CONSTRAINT modalidade_pkey PRIMARY KEY (id_modalidade);


--
-- Name: orientador orientador_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_id_usuario_key UNIQUE (id_usuario);


--
-- Name: orientador orientador_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_pkey PRIMARY KEY (id_orientador);


--
-- Name: professor_area professor_area_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_pkey PRIMARY KEY (id_professor, id_area);


--
-- Name: professor professor_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_usuario_key UNIQUE (id_usuario);


--
-- Name: professor professor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_pkey PRIMARY KEY (id_professor);


--
-- Name: regional regional_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regional
    ADD CONSTRAINT regional_pkey PRIMARY KEY (id_regional);


--
-- Name: telefone_escola telefone_escola_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefone_escola
    ADD CONSTRAINT telefone_escola_pkey PRIMARY KEY (id_telefone);


--
-- Name: telefone_regional telefone_regional_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefone_regional
    ADD CONSTRAINT telefone_regional_pkey PRIMARY KEY (id_telefone);


--
-- Name: tipo_usuario tipo_usuario_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_nome_key UNIQUE (nome);


--
-- Name: tipo_usuario tipo_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_pkey PRIMARY KEY (id_tipo);


--
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- Name: blockchain_registro blockchain_registro_id_documento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_id_documento_fkey FOREIGN KEY (id_documento) REFERENCES public.documento_estagio(id_documento);


--
-- Name: blockchain_registro blockchain_registro_id_estagio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_id_estagio_fkey FOREIGN KEY (id_estagio) REFERENCES public.estagio(id_estagio);


--
-- Name: curso curso_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);


--
-- Name: documento_estagio documento_estagio_id_estagio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documento_estagio
    ADD CONSTRAINT documento_estagio_id_estagio_fkey FOREIGN KEY (id_estagio) REFERENCES public.estagio(id_estagio);


--
-- Name: escola escola_id_regional_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_id_regional_fkey FOREIGN KEY (id_regional) REFERENCES public.regional(id_regional);


--
-- Name: escola_modalidade escola_modalidade_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola) ON DELETE CASCADE;


--
-- Name: escola_modalidade escola_modalidade_id_modalidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_id_modalidade_fkey FOREIGN KEY (id_modalidade) REFERENCES public.modalidade(id_modalidade) ON DELETE CASCADE;


--
-- Name: estagiario estagiario_id_curso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_curso_fkey FOREIGN KEY (id_curso) REFERENCES public.curso(id_curso);


--
-- Name: estagiario estagiario_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);


--
-- Name: estagiario estagiario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- Name: estagio_etapa estagio_etapa_id_documento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_id_documento_fkey FOREIGN KEY (id_documento) REFERENCES public.documento_estagio(id_documento);


--
-- Name: estagio_etapa estagio_etapa_id_estagio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_id_estagio_fkey FOREIGN KEY (id_estagio) REFERENCES public.estagio(id_estagio);


--
-- Name: estagio_etapa estagio_etapa_id_usuario_assinante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_id_usuario_assinante_fkey FOREIGN KEY (id_usuario_assinante) REFERENCES public.usuario(id_usuario);


--
-- Name: estagio estagio_id_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_area_fkey FOREIGN KEY (id_area) REFERENCES public.area(id_area);


--
-- Name: estagio estagio_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola);


--
-- Name: estagio estagio_id_estagiario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_estagiario_fkey FOREIGN KEY (id_estagiario) REFERENCES public.estagiario(id_estagiario);


--
-- Name: estagio estagio_id_modalidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_modalidade_fkey FOREIGN KEY (id_modalidade) REFERENCES public.modalidade(id_modalidade);


--
-- Name: estagio estagio_id_orientador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_orientador_fkey FOREIGN KEY (id_orientador) REFERENCES public.orientador(id_orientador);


--
-- Name: estagio estagio_id_professor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_professor_fkey FOREIGN KEY (id_professor) REFERENCES public.professor(id_professor);


--
-- Name: orientador orientador_id_instituicao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);


--
-- Name: orientador orientador_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- Name: professor_area professor_area_id_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_id_area_fkey FOREIGN KEY (id_area) REFERENCES public.area(id_area) ON DELETE CASCADE;


--
-- Name: professor_area professor_area_id_professor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_id_professor_fkey FOREIGN KEY (id_professor) REFERENCES public.professor(id_professor) ON DELETE CASCADE;


--
-- Name: professor professor_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola);


--
-- Name: professor professor_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- Name: telefone_escola telefone_escola_id_escola_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefone_escola
    ADD CONSTRAINT telefone_escola_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola) ON DELETE CASCADE;


--
-- Name: telefone_regional telefone_regional_id_regional_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telefone_regional
    ADD CONSTRAINT telefone_regional_id_regional_fkey FOREIGN KEY (id_regional) REFERENCES public.regional(id_regional) ON DELETE CASCADE;


--
-- Name: usuario usuario_id_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES public.tipo_usuario(id_tipo);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   