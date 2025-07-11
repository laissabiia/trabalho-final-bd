PGDMP                      }            siesudb %   12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)    17.5 �    [           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            \           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            ]           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            ^           1262    620862    siesudb    DATABASE     o   CREATE DATABASE siesudb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';
    DROP DATABASE siesudb;
                     siesu01    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                     postgres    false            �            1259    621007    area    TABLE     e   CREATE TABLE public.area (
    id_area integer NOT NULL,
    nome character varying(100) NOT NULL
);
    DROP TABLE public.area;
       public         heap r       siesu01    false    6            �            1259    621005    area_id_area_seq    SEQUENCE     �   CREATE SEQUENCE public.area_id_area_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.area_id_area_seq;
       public               siesu01    false    6    222            _           0    0    area_id_area_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.area_id_area_seq OWNED BY public.area.id_area;
          public               siesu01    false    221            �            1259    621148    blockchain_registro    TABLE     7  CREATE TABLE public.blockchain_registro (
    id_registro integer NOT NULL,
    id_estagio integer NOT NULL,
    id_documento integer,
    tipo_evento character varying(50) NOT NULL,
    hash_blockchain character varying(150) NOT NULL,
    data_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 '   DROP TABLE public.blockchain_registro;
       public         heap r       siesu01    false    6            �            1259    621146 #   blockchain_registro_id_registro_seq    SEQUENCE     �   CREATE SEQUENCE public.blockchain_registro_id_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.blockchain_registro_id_registro_seq;
       public               siesu01    false    235    6            `           0    0 #   blockchain_registro_id_registro_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.blockchain_registro_id_registro_seq OWNED BY public.blockchain_registro.id_registro;
          public               siesu01    false    234            �            1259    620922    curso    TABLE     �   CREATE TABLE public.curso (
    id_curso integer NOT NULL,
    nome character varying(100) NOT NULL,
    id_instituicao integer NOT NULL
);
    DROP TABLE public.curso;
       public         heap r       siesu01    false    6            �            1259    620920    curso_id_curso_seq    SEQUENCE     �   CREATE SEQUENCE public.curso_id_curso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.curso_id_curso_seq;
       public               siesu01    false    6    209            a           0    0    curso_id_curso_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.curso_id_curso_seq OWNED BY public.curso.id_curso;
          public               siesu01    false    208            �            1259    621134    documento_estagio    TABLE       CREATE TABLE public.documento_estagio (
    id_documento integer NOT NULL,
    id_estagio integer NOT NULL,
    tipo_documento character varying(50) NOT NULL,
    caminho_pdf character varying(200) NOT NULL,
    data_envio timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 %   DROP TABLE public.documento_estagio;
       public         heap r       siesu01    false    6            �            1259    621132 "   documento_estagio_id_documento_seq    SEQUENCE     �   CREATE SEQUENCE public.documento_estagio_id_documento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.documento_estagio_id_documento_seq;
       public               siesu01    false    6    233            b           0    0 "   documento_estagio_id_documento_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.documento_estagio_id_documento_seq OWNED BY public.documento_estagio.id_documento;
          public               siesu01    false    232            �            1259    620943    escola    TABLE     �   CREATE TABLE public.escola (
    id_escola integer NOT NULL,
    nome character varying(150) NOT NULL,
    cnpj character varying(18) NOT NULL,
    endereco character varying(200),
    id_regional integer
);
    DROP TABLE public.escola;
       public         heap r       siesu01    false    6            �            1259    620941    escola_id_escola_seq    SEQUENCE     �   CREATE SEQUENCE public.escola_id_escola_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.escola_id_escola_seq;
       public               siesu01    false    213    6            c           0    0    escola_id_escola_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.escola_id_escola_seq OWNED BY public.escola.id_escola;
          public               siesu01    false    212            �            1259    620990    escola_modalidade    TABLE     n   CREATE TABLE public.escola_modalidade (
    id_escola integer NOT NULL,
    id_modalidade integer NOT NULL
);
 %   DROP TABLE public.escola_modalidade;
       public         heap r       siesu01    false    6            �            1259    621070 
   estagiario    TABLE     �   CREATE TABLE public.estagiario (
    id_estagiario integer NOT NULL,
    id_usuario integer NOT NULL,
    id_curso integer NOT NULL,
    id_instituicao integer NOT NULL
);
    DROP TABLE public.estagiario;
       public         heap r       siesu01    false    6            �            1259    621068    estagiario_id_estagiario_seq    SEQUENCE     �   CREATE SEQUENCE public.estagiario_id_estagiario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.estagiario_id_estagiario_seq;
       public               siesu01    false    229    6            d           0    0    estagiario_id_estagiario_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.estagiario_id_estagiario_seq OWNED BY public.estagiario.id_estagiario;
          public               siesu01    false    228            �            1259    621095    estagio    TABLE     �  CREATE TABLE public.estagio (
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
       public         heap r       siesu01    false    6            �            1259    621167    estagio_etapa    TABLE     r  CREATE TABLE public.estagio_etapa (
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
       public         heap r       siesu01    false    6            �            1259    621165    estagio_etapa_id_etapa_seq    SEQUENCE     �   CREATE SEQUENCE public.estagio_etapa_id_etapa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.estagio_etapa_id_etapa_seq;
       public               siesu01    false    237    6            e           0    0    estagio_etapa_id_etapa_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.estagio_etapa_id_etapa_seq OWNED BY public.estagio_etapa.id_etapa;
          public               siesu01    false    236            �            1259    621093    estagio_id_estagio_seq    SEQUENCE     �   CREATE SEQUENCE public.estagio_id_estagio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.estagio_id_estagio_seq;
       public               siesu01    false    6    231            f           0    0    estagio_id_estagio_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.estagio_id_estagio_seq OWNED BY public.estagio.id_estagio;
          public               siesu01    false    230            �            1259    620912    instituicao    TABLE     �   CREATE TABLE public.instituicao (
    id_instituicao integer NOT NULL,
    nome character varying(150) NOT NULL,
    tipo character varying(50) NOT NULL,
    cnpj character varying(18)
);
    DROP TABLE public.instituicao;
       public         heap r       siesu01    false    6            �            1259    620910    instituicao_id_instituicao_seq    SEQUENCE     �   CREATE SEQUENCE public.instituicao_id_instituicao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.instituicao_id_instituicao_seq;
       public               siesu01    false    6    207            g           0    0    instituicao_id_instituicao_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.instituicao_id_instituicao_seq OWNED BY public.instituicao.id_instituicao;
          public               siesu01    false    206            �            1259    620984 
   modalidade    TABLE     p   CREATE TABLE public.modalidade (
    id_modalidade integer NOT NULL,
    nome character varying(50) NOT NULL
);
    DROP TABLE public.modalidade;
       public         heap r       siesu01    false    6            �            1259    620982    modalidade_id_modalidade_seq    SEQUENCE     �   CREATE SEQUENCE public.modalidade_id_modalidade_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.modalidade_id_modalidade_seq;
       public               siesu01    false    6    219            h           0    0    modalidade_id_modalidade_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.modalidade_id_modalidade_seq OWNED BY public.modalidade.id_modalidade;
          public               siesu01    false    218            �            1259    621015 
   orientador    TABLE     �   CREATE TABLE public.orientador (
    id_orientador integer NOT NULL,
    id_usuario integer NOT NULL,
    id_instituicao integer NOT NULL
);
    DROP TABLE public.orientador;
       public         heap r       siesu01    false    6            �            1259    621013    orientador_id_orientador_seq    SEQUENCE     �   CREATE SEQUENCE public.orientador_id_orientador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.orientador_id_orientador_seq;
       public               siesu01    false    6    224            i           0    0    orientador_id_orientador_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.orientador_id_orientador_seq OWNED BY public.orientador.id_orientador;
          public               siesu01    false    223            �            1259    621035 	   professor    TABLE     �   CREATE TABLE public.professor (
    id_professor integer NOT NULL,
    id_usuario integer NOT NULL,
    id_escola integer NOT NULL
);
    DROP TABLE public.professor;
       public         heap r       siesu01    false    6            �            1259    621053    professor_area    TABLE     h   CREATE TABLE public.professor_area (
    id_professor integer NOT NULL,
    id_area integer NOT NULL
);
 "   DROP TABLE public.professor_area;
       public         heap r       siesu01    false    6            �            1259    621033    professor_id_professor_seq    SEQUENCE     �   CREATE SEQUENCE public.professor_id_professor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.professor_id_professor_seq;
       public               siesu01    false    226    6            j           0    0    professor_id_professor_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.professor_id_professor_seq OWNED BY public.professor.id_professor;
          public               siesu01    false    225            �            1259    620935    regional    TABLE     �   CREATE TABLE public.regional (
    id_regional integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100)
);
    DROP TABLE public.regional;
       public         heap r       siesu01    false    6            �            1259    620933    regional_id_regional_seq    SEQUENCE     �   CREATE SEQUENCE public.regional_id_regional_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.regional_id_regional_seq;
       public               siesu01    false    211    6            k           0    0    regional_id_regional_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.regional_id_regional_seq OWNED BY public.regional.id_regional;
          public               siesu01    false    210            �            1259    620958    telefone_escola    TABLE     �   CREATE TABLE public.telefone_escola (
    id_telefone integer NOT NULL,
    id_escola integer NOT NULL,
    numero character varying(20) NOT NULL
);
 #   DROP TABLE public.telefone_escola;
       public         heap r       siesu01    false    6            �            1259    620956    telefone_escola_id_telefone_seq    SEQUENCE     �   CREATE SEQUENCE public.telefone_escola_id_telefone_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.telefone_escola_id_telefone_seq;
       public               siesu01    false    215    6            l           0    0    telefone_escola_id_telefone_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.telefone_escola_id_telefone_seq OWNED BY public.telefone_escola.id_telefone;
          public               siesu01    false    214            �            1259    620971    telefone_regional    TABLE     �   CREATE TABLE public.telefone_regional (
    id_telefone integer NOT NULL,
    id_regional integer NOT NULL,
    numero character varying(20) NOT NULL
);
 %   DROP TABLE public.telefone_regional;
       public         heap r       siesu01    false    6            �            1259    620969 !   telefone_regional_id_telefone_seq    SEQUENCE     �   CREATE SEQUENCE public.telefone_regional_id_telefone_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.telefone_regional_id_telefone_seq;
       public               siesu01    false    217    6            m           0    0 !   telefone_regional_id_telefone_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.telefone_regional_id_telefone_seq OWNED BY public.telefone_regional.id_telefone;
          public               siesu01    false    216            �            1259    620887    tipo_usuario    TABLE     l   CREATE TABLE public.tipo_usuario (
    id_tipo integer NOT NULL,
    nome character varying(30) NOT NULL
);
     DROP TABLE public.tipo_usuario;
       public         heap r       siesu01    false    6            �            1259    620885    tipo_usuario_id_tipo_seq    SEQUENCE     �   CREATE SEQUENCE public.tipo_usuario_id_tipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.tipo_usuario_id_tipo_seq;
       public               siesu01    false    6    203            n           0    0    tipo_usuario_id_tipo_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.tipo_usuario_id_tipo_seq OWNED BY public.tipo_usuario.id_tipo;
          public               siesu01    false    202            �            1259    620897    usuario    TABLE     �   CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    senha character varying(100) NOT NULL,
    id_tipo integer NOT NULL
);
    DROP TABLE public.usuario;
       public         heap r       siesu01    false    6            �            1259    620895    usuario_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.usuario_id_usuario_seq;
       public               siesu01    false    6    205            o           0    0    usuario_id_usuario_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;
          public               siesu01    false    204            [           2604    621010    area id_area    DEFAULT     l   ALTER TABLE ONLY public.area ALTER COLUMN id_area SET DEFAULT nextval('public.area_id_area_seq'::regclass);
 ;   ALTER TABLE public.area ALTER COLUMN id_area DROP DEFAULT;
       public               siesu01    false    221    222    222            c           2604    621151    blockchain_registro id_registro    DEFAULT     �   ALTER TABLE ONLY public.blockchain_registro ALTER COLUMN id_registro SET DEFAULT nextval('public.blockchain_registro_id_registro_seq'::regclass);
 N   ALTER TABLE public.blockchain_registro ALTER COLUMN id_registro DROP DEFAULT;
       public               siesu01    false    235    234    235            U           2604    620925    curso id_curso    DEFAULT     p   ALTER TABLE ONLY public.curso ALTER COLUMN id_curso SET DEFAULT nextval('public.curso_id_curso_seq'::regclass);
 =   ALTER TABLE public.curso ALTER COLUMN id_curso DROP DEFAULT;
       public               siesu01    false    209    208    209            a           2604    621137    documento_estagio id_documento    DEFAULT     �   ALTER TABLE ONLY public.documento_estagio ALTER COLUMN id_documento SET DEFAULT nextval('public.documento_estagio_id_documento_seq'::regclass);
 M   ALTER TABLE public.documento_estagio ALTER COLUMN id_documento DROP DEFAULT;
       public               siesu01    false    232    233    233            W           2604    620946    escola id_escola    DEFAULT     t   ALTER TABLE ONLY public.escola ALTER COLUMN id_escola SET DEFAULT nextval('public.escola_id_escola_seq'::regclass);
 ?   ALTER TABLE public.escola ALTER COLUMN id_escola DROP DEFAULT;
       public               siesu01    false    213    212    213            ^           2604    621073    estagiario id_estagiario    DEFAULT     �   ALTER TABLE ONLY public.estagiario ALTER COLUMN id_estagiario SET DEFAULT nextval('public.estagiario_id_estagiario_seq'::regclass);
 G   ALTER TABLE public.estagiario ALTER COLUMN id_estagiario DROP DEFAULT;
       public               siesu01    false    228    229    229            _           2604    621098    estagio id_estagio    DEFAULT     x   ALTER TABLE ONLY public.estagio ALTER COLUMN id_estagio SET DEFAULT nextval('public.estagio_id_estagio_seq'::regclass);
 A   ALTER TABLE public.estagio ALTER COLUMN id_estagio DROP DEFAULT;
       public               siesu01    false    231    230    231            e           2604    621170    estagio_etapa id_etapa    DEFAULT     �   ALTER TABLE ONLY public.estagio_etapa ALTER COLUMN id_etapa SET DEFAULT nextval('public.estagio_etapa_id_etapa_seq'::regclass);
 E   ALTER TABLE public.estagio_etapa ALTER COLUMN id_etapa DROP DEFAULT;
       public               siesu01    false    237    236    237            T           2604    620915    instituicao id_instituicao    DEFAULT     �   ALTER TABLE ONLY public.instituicao ALTER COLUMN id_instituicao SET DEFAULT nextval('public.instituicao_id_instituicao_seq'::regclass);
 I   ALTER TABLE public.instituicao ALTER COLUMN id_instituicao DROP DEFAULT;
       public               siesu01    false    207    206    207            Z           2604    620987    modalidade id_modalidade    DEFAULT     �   ALTER TABLE ONLY public.modalidade ALTER COLUMN id_modalidade SET DEFAULT nextval('public.modalidade_id_modalidade_seq'::regclass);
 G   ALTER TABLE public.modalidade ALTER COLUMN id_modalidade DROP DEFAULT;
       public               siesu01    false    218    219    219            \           2604    621018    orientador id_orientador    DEFAULT     �   ALTER TABLE ONLY public.orientador ALTER COLUMN id_orientador SET DEFAULT nextval('public.orientador_id_orientador_seq'::regclass);
 G   ALTER TABLE public.orientador ALTER COLUMN id_orientador DROP DEFAULT;
       public               siesu01    false    224    223    224            ]           2604    621038    professor id_professor    DEFAULT     �   ALTER TABLE ONLY public.professor ALTER COLUMN id_professor SET DEFAULT nextval('public.professor_id_professor_seq'::regclass);
 E   ALTER TABLE public.professor ALTER COLUMN id_professor DROP DEFAULT;
       public               siesu01    false    225    226    226            V           2604    620938    regional id_regional    DEFAULT     |   ALTER TABLE ONLY public.regional ALTER COLUMN id_regional SET DEFAULT nextval('public.regional_id_regional_seq'::regclass);
 C   ALTER TABLE public.regional ALTER COLUMN id_regional DROP DEFAULT;
       public               siesu01    false    210    211    211            X           2604    620961    telefone_escola id_telefone    DEFAULT     �   ALTER TABLE ONLY public.telefone_escola ALTER COLUMN id_telefone SET DEFAULT nextval('public.telefone_escola_id_telefone_seq'::regclass);
 J   ALTER TABLE public.telefone_escola ALTER COLUMN id_telefone DROP DEFAULT;
       public               siesu01    false    214    215    215            Y           2604    620974    telefone_regional id_telefone    DEFAULT     �   ALTER TABLE ONLY public.telefone_regional ALTER COLUMN id_telefone SET DEFAULT nextval('public.telefone_regional_id_telefone_seq'::regclass);
 L   ALTER TABLE public.telefone_regional ALTER COLUMN id_telefone DROP DEFAULT;
       public               siesu01    false    217    216    217            R           2604    620890    tipo_usuario id_tipo    DEFAULT     |   ALTER TABLE ONLY public.tipo_usuario ALTER COLUMN id_tipo SET DEFAULT nextval('public.tipo_usuario_id_tipo_seq'::regclass);
 C   ALTER TABLE public.tipo_usuario ALTER COLUMN id_tipo DROP DEFAULT;
       public               siesu01    false    202    203    203            S           2604    620900    usuario id_usuario    DEFAULT     x   ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);
 A   ALTER TABLE public.usuario ALTER COLUMN id_usuario DROP DEFAULT;
       public               siesu01    false    205    204    205            �           2606    621012    area area_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (id_area);
 8   ALTER TABLE ONLY public.area DROP CONSTRAINT area_pkey;
       public                 siesu01    false    222            �           2606    621154 ,   blockchain_registro blockchain_registro_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_pkey PRIMARY KEY (id_registro);
 V   ALTER TABLE ONLY public.blockchain_registro DROP CONSTRAINT blockchain_registro_pkey;
       public                 siesu01    false    235            t           2606    620927    curso curso_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (id_curso);
 :   ALTER TABLE ONLY public.curso DROP CONSTRAINT curso_pkey;
       public                 siesu01    false    209            �           2606    621140 (   documento_estagio documento_estagio_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.documento_estagio
    ADD CONSTRAINT documento_estagio_pkey PRIMARY KEY (id_documento);
 R   ALTER TABLE ONLY public.documento_estagio DROP CONSTRAINT documento_estagio_pkey;
       public                 siesu01    false    233            x           2606    620950    escola escola_cnpj_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_cnpj_key UNIQUE (cnpj);
 @   ALTER TABLE ONLY public.escola DROP CONSTRAINT escola_cnpj_key;
       public                 siesu01    false    213            �           2606    620994 (   escola_modalidade escola_modalidade_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_pkey PRIMARY KEY (id_escola, id_modalidade);
 R   ALTER TABLE ONLY public.escola_modalidade DROP CONSTRAINT escola_modalidade_pkey;
       public                 siesu01    false    220    220            z           2606    620948    escola escola_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_pkey PRIMARY KEY (id_escola);
 <   ALTER TABLE ONLY public.escola DROP CONSTRAINT escola_pkey;
       public                 siesu01    false    213            �           2606    621077 $   estagiario estagiario_id_usuario_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_usuario_key UNIQUE (id_usuario);
 N   ALTER TABLE ONLY public.estagiario DROP CONSTRAINT estagiario_id_usuario_key;
       public                 siesu01    false    229            �           2606    621075    estagiario estagiario_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_pkey PRIMARY KEY (id_estagiario);
 D   ALTER TABLE ONLY public.estagiario DROP CONSTRAINT estagiario_pkey;
       public                 siesu01    false    229            �           2606    621173     estagio_etapa estagio_etapa_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_pkey PRIMARY KEY (id_etapa);
 J   ALTER TABLE ONLY public.estagio_etapa DROP CONSTRAINT estagio_etapa_pkey;
       public                 siesu01    false    237            �           2606    621101    estagio estagio_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_pkey PRIMARY KEY (id_estagio);
 >   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_pkey;
       public                 siesu01    false    231            p           2606    620919     instituicao instituicao_cnpj_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.instituicao
    ADD CONSTRAINT instituicao_cnpj_key UNIQUE (cnpj);
 J   ALTER TABLE ONLY public.instituicao DROP CONSTRAINT instituicao_cnpj_key;
       public                 siesu01    false    207            r           2606    620917    instituicao instituicao_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.instituicao
    ADD CONSTRAINT instituicao_pkey PRIMARY KEY (id_instituicao);
 F   ALTER TABLE ONLY public.instituicao DROP CONSTRAINT instituicao_pkey;
       public                 siesu01    false    207            �           2606    620989    modalidade modalidade_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.modalidade
    ADD CONSTRAINT modalidade_pkey PRIMARY KEY (id_modalidade);
 D   ALTER TABLE ONLY public.modalidade DROP CONSTRAINT modalidade_pkey;
       public                 siesu01    false    219            �           2606    621022 $   orientador orientador_id_usuario_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_id_usuario_key UNIQUE (id_usuario);
 N   ALTER TABLE ONLY public.orientador DROP CONSTRAINT orientador_id_usuario_key;
       public                 siesu01    false    224            �           2606    621020    orientador orientador_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_pkey PRIMARY KEY (id_orientador);
 D   ALTER TABLE ONLY public.orientador DROP CONSTRAINT orientador_pkey;
       public                 siesu01    false    224            �           2606    621057 "   professor_area professor_area_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_pkey PRIMARY KEY (id_professor, id_area);
 L   ALTER TABLE ONLY public.professor_area DROP CONSTRAINT professor_area_pkey;
       public                 siesu01    false    227    227            �           2606    621042 "   professor professor_id_usuario_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_usuario_key UNIQUE (id_usuario);
 L   ALTER TABLE ONLY public.professor DROP CONSTRAINT professor_id_usuario_key;
       public                 siesu01    false    226            �           2606    621040    professor professor_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_pkey PRIMARY KEY (id_professor);
 B   ALTER TABLE ONLY public.professor DROP CONSTRAINT professor_pkey;
       public                 siesu01    false    226            v           2606    620940    regional regional_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.regional
    ADD CONSTRAINT regional_pkey PRIMARY KEY (id_regional);
 @   ALTER TABLE ONLY public.regional DROP CONSTRAINT regional_pkey;
       public                 siesu01    false    211            |           2606    620963 $   telefone_escola telefone_escola_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.telefone_escola
    ADD CONSTRAINT telefone_escola_pkey PRIMARY KEY (id_telefone);
 N   ALTER TABLE ONLY public.telefone_escola DROP CONSTRAINT telefone_escola_pkey;
       public                 siesu01    false    215            ~           2606    620976 (   telefone_regional telefone_regional_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.telefone_regional
    ADD CONSTRAINT telefone_regional_pkey PRIMARY KEY (id_telefone);
 R   ALTER TABLE ONLY public.telefone_regional DROP CONSTRAINT telefone_regional_pkey;
       public                 siesu01    false    217            h           2606    620894 "   tipo_usuario tipo_usuario_nome_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_nome_key UNIQUE (nome);
 L   ALTER TABLE ONLY public.tipo_usuario DROP CONSTRAINT tipo_usuario_nome_key;
       public                 siesu01    false    203            j           2606    620892    tipo_usuario tipo_usuario_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_pkey PRIMARY KEY (id_tipo);
 H   ALTER TABLE ONLY public.tipo_usuario DROP CONSTRAINT tipo_usuario_pkey;
       public                 siesu01    false    203            l           2606    620904    usuario usuario_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_email_key;
       public                 siesu01    false    205            n           2606    620902    usuario usuario_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public                 siesu01    false    205            �           2606    621160 9   blockchain_registro blockchain_registro_id_documento_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_id_documento_fkey FOREIGN KEY (id_documento) REFERENCES public.documento_estagio(id_documento);
 c   ALTER TABLE ONLY public.blockchain_registro DROP CONSTRAINT blockchain_registro_id_documento_fkey;
       public               siesu01    false    233    235    2966            �           2606    621155 7   blockchain_registro blockchain_registro_id_estagio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blockchain_registro
    ADD CONSTRAINT blockchain_registro_id_estagio_fkey FOREIGN KEY (id_estagio) REFERENCES public.estagio(id_estagio);
 a   ALTER TABLE ONLY public.blockchain_registro DROP CONSTRAINT blockchain_registro_id_estagio_fkey;
       public               siesu01    false    235    231    2964            �           2606    620928    curso curso_id_instituicao_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);
 I   ALTER TABLE ONLY public.curso DROP CONSTRAINT curso_id_instituicao_fkey;
       public               siesu01    false    207    2930    209            �           2606    621141 3   documento_estagio documento_estagio_id_estagio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.documento_estagio
    ADD CONSTRAINT documento_estagio_id_estagio_fkey FOREIGN KEY (id_estagio) REFERENCES public.estagio(id_estagio);
 ]   ALTER TABLE ONLY public.documento_estagio DROP CONSTRAINT documento_estagio_id_estagio_fkey;
       public               siesu01    false    233    231    2964            �           2606    620951    escola escola_id_regional_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.escola
    ADD CONSTRAINT escola_id_regional_fkey FOREIGN KEY (id_regional) REFERENCES public.regional(id_regional);
 H   ALTER TABLE ONLY public.escola DROP CONSTRAINT escola_id_regional_fkey;
       public               siesu01    false    211    2934    213            �           2606    620995 2   escola_modalidade escola_modalidade_id_escola_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.escola_modalidade DROP CONSTRAINT escola_modalidade_id_escola_fkey;
       public               siesu01    false    2938    220    213            �           2606    621000 6   escola_modalidade escola_modalidade_id_modalidade_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.escola_modalidade
    ADD CONSTRAINT escola_modalidade_id_modalidade_fkey FOREIGN KEY (id_modalidade) REFERENCES public.modalidade(id_modalidade) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.escola_modalidade DROP CONSTRAINT escola_modalidade_id_modalidade_fkey;
       public               siesu01    false    220    2944    219            �           2606    621083 #   estagiario estagiario_id_curso_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_curso_fkey FOREIGN KEY (id_curso) REFERENCES public.curso(id_curso);
 M   ALTER TABLE ONLY public.estagiario DROP CONSTRAINT estagiario_id_curso_fkey;
       public               siesu01    false    2932    209    229            �           2606    621088 )   estagiario estagiario_id_instituicao_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);
 S   ALTER TABLE ONLY public.estagiario DROP CONSTRAINT estagiario_id_instituicao_fkey;
       public               siesu01    false    2930    207    229            �           2606    621078 %   estagiario estagiario_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagiario
    ADD CONSTRAINT estagiario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.estagiario DROP CONSTRAINT estagiario_id_usuario_fkey;
       public               siesu01    false    2926    229    205            �           2606    621184 -   estagio_etapa estagio_etapa_id_documento_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_id_documento_fkey FOREIGN KEY (id_documento) REFERENCES public.documento_estagio(id_documento);
 W   ALTER TABLE ONLY public.estagio_etapa DROP CONSTRAINT estagio_etapa_id_documento_fkey;
       public               siesu01    false    237    2966    233            �           2606    621174 +   estagio_etapa estagio_etapa_id_estagio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_id_estagio_fkey FOREIGN KEY (id_estagio) REFERENCES public.estagio(id_estagio);
 U   ALTER TABLE ONLY public.estagio_etapa DROP CONSTRAINT estagio_etapa_id_estagio_fkey;
       public               siesu01    false    231    237    2964            �           2606    621179 5   estagio_etapa estagio_etapa_id_usuario_assinante_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio_etapa
    ADD CONSTRAINT estagio_etapa_id_usuario_assinante_fkey FOREIGN KEY (id_usuario_assinante) REFERENCES public.usuario(id_usuario);
 _   ALTER TABLE ONLY public.estagio_etapa DROP CONSTRAINT estagio_etapa_id_usuario_assinante_fkey;
       public               siesu01    false    2926    237    205            �           2606    621122    estagio estagio_id_area_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_area_fkey FOREIGN KEY (id_area) REFERENCES public.area(id_area);
 F   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_id_area_fkey;
       public               siesu01    false    222    231    2948            �           2606    621117    estagio estagio_id_escola_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola);
 H   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_id_escola_fkey;
       public               siesu01    false    231    2938    213            �           2606    621102 "   estagio estagio_id_estagiario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_estagiario_fkey FOREIGN KEY (id_estagiario) REFERENCES public.estagiario(id_estagiario);
 L   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_id_estagiario_fkey;
       public               siesu01    false    2962    231    229            �           2606    621127 "   estagio estagio_id_modalidade_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_modalidade_fkey FOREIGN KEY (id_modalidade) REFERENCES public.modalidade(id_modalidade);
 L   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_id_modalidade_fkey;
       public               siesu01    false    231    2944    219            �           2606    621112 "   estagio estagio_id_orientador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_orientador_fkey FOREIGN KEY (id_orientador) REFERENCES public.orientador(id_orientador);
 L   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_id_orientador_fkey;
       public               siesu01    false    224    231    2952            �           2606    621107 !   estagio estagio_id_professor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estagio
    ADD CONSTRAINT estagio_id_professor_fkey FOREIGN KEY (id_professor) REFERENCES public.professor(id_professor);
 K   ALTER TABLE ONLY public.estagio DROP CONSTRAINT estagio_id_professor_fkey;
       public               siesu01    false    226    231    2956            �           2606    621028 )   orientador orientador_id_instituicao_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_id_instituicao_fkey FOREIGN KEY (id_instituicao) REFERENCES public.instituicao(id_instituicao);
 S   ALTER TABLE ONLY public.orientador DROP CONSTRAINT orientador_id_instituicao_fkey;
       public               siesu01    false    2930    224    207            �           2606    621023 %   orientador orientador_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orientador
    ADD CONSTRAINT orientador_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.orientador DROP CONSTRAINT orientador_id_usuario_fkey;
       public               siesu01    false    205    224    2926            �           2606    621063 *   professor_area professor_area_id_area_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_id_area_fkey FOREIGN KEY (id_area) REFERENCES public.area(id_area) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.professor_area DROP CONSTRAINT professor_area_id_area_fkey;
       public               siesu01    false    227    222    2948            �           2606    621058 /   professor_area professor_area_id_professor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.professor_area
    ADD CONSTRAINT professor_area_id_professor_fkey FOREIGN KEY (id_professor) REFERENCES public.professor(id_professor) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.professor_area DROP CONSTRAINT professor_area_id_professor_fkey;
       public               siesu01    false    226    227    2956            �           2606    621048 "   professor professor_id_escola_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola);
 L   ALTER TABLE ONLY public.professor DROP CONSTRAINT professor_id_escola_fkey;
       public               siesu01    false    2938    213    226            �           2606    621043 #   professor professor_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.professor DROP CONSTRAINT professor_id_usuario_fkey;
       public               siesu01    false    2926    205    226            �           2606    620964 .   telefone_escola telefone_escola_id_escola_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefone_escola
    ADD CONSTRAINT telefone_escola_id_escola_fkey FOREIGN KEY (id_escola) REFERENCES public.escola(id_escola) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.telefone_escola DROP CONSTRAINT telefone_escola_id_escola_fkey;
       public               siesu01    false    213    2938    215            �           2606    620977 4   telefone_regional telefone_regional_id_regional_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefone_regional
    ADD CONSTRAINT telefone_regional_id_regional_fkey FOREIGN KEY (id_regional) REFERENCES public.regional(id_regional) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.telefone_regional DROP CONSTRAINT telefone_regional_id_regional_fkey;
       public               siesu01    false    2934    211    217            �           2606    620905    usuario usuario_id_tipo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES public.tipo_usuario(id_tipo);
 F   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_id_tipo_fkey;
       public               siesu01    false    205    2922    203           