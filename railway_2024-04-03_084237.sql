--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5 (Ubuntu 15.5-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.1

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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: Libraries; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Libraries" AS ENUM (
    'BIGDATA'
);


ALTER TYPE public."Libraries" OWNER TO postgres;

--
-- Name: Role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Role" AS ENUM (
    'MANAGER',
    'SUPPORT',
    'EMPLOYEE',
    'ADMIN',
    'CLIENT'
);


ALTER TYPE public."Role" OWNER TO postgres;

--
-- Name: Status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Status" AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'BLOCKED',
    'CREATED'
);


ALTER TYPE public."Status" OWNER TO postgres;

--
-- Name: StatusSecurityCode; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."StatusSecurityCode" AS ENUM (
    'ACTIVE',
    'CHECKED',
    'CANCELED'
);


ALTER TYPE public."StatusSecurityCode" OWNER TO postgres;

--
-- Name: TypeEmailConfirm; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TypeEmailConfirm" AS ENUM (
    'UNCONFIRMED',
    'CONFIRMED'
);


ALTER TYPE public."TypeEmailConfirm" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Categories" (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    created_id integer,
    custom_value double precision,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Categories" OWNER TO postgres;

--
-- Name: CategoriesOnModules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CategoriesOnModules" (
    id integer NOT NULL,
    "categoryId" integer NOT NULL,
    "moduleId" integer NOT NULL,
    "order" integer DEFAULT 0
);


ALTER TABLE public."CategoriesOnModules" OWNER TO postgres;

--
-- Name: CategoriesOnModules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CategoriesOnModules_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CategoriesOnModules_id_seq" OWNER TO postgres;

--
-- Name: CategoriesOnModules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CategoriesOnModules_id_seq" OWNED BY public."CategoriesOnModules".id;


--
-- Name: Categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Categories_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Categories_id_seq" OWNER TO postgres;

--
-- Name: Categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Categories_id_seq" OWNED BY public."Categories".id;


--
-- Name: Modules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Modules" (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    value double precision NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    path_make_function text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Modules" OWNER TO postgres;

--
-- Name: Modules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Modules_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Modules_id_seq" OWNER TO postgres;

--
-- Name: Modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Modules_id_seq" OWNED BY public."Modules".id;


--
-- Name: Resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Resources" (
    id integer NOT NULL,
    name text NOT NULL,
    path text NOT NULL,
    description text NOT NULL,
    value double precision NOT NULL,
    library public."Libraries" NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Resources" OWNER TO postgres;

--
-- Name: ResourcesOnModules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ResourcesOnModules" (
    id integer NOT NULL,
    "moduleId" integer NOT NULL,
    "resourceId" integer NOT NULL
);


ALTER TABLE public."ResourcesOnModules" OWNER TO postgres;

--
-- Name: ResourcesOnModules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ResourcesOnModules_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ResourcesOnModules_id_seq" OWNER TO postgres;

--
-- Name: ResourcesOnModules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ResourcesOnModules_id_seq" OWNED BY public."ResourcesOnModules".id;


--
-- Name: Resources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Resources_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Resources_id_seq" OWNER TO postgres;

--
-- Name: Resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Resources_id_seq" OWNED BY public."Resources".id;


--
-- Name: UsersOnCategories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UsersOnCategories" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "categoryId" integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."UsersOnCategories" OWNER TO postgres;

--
-- Name: UsersOnCategories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UsersOnCategories_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UsersOnCategories_id_seq" OWNER TO postgres;

--
-- Name: UsersOnCategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UsersOnCategories_id_seq" OWNED BY public."UsersOnCategories".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: security_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.security_code (
    id integer NOT NULL,
    id_user integer NOT NULL,
    code text NOT NULL,
    date_expiration timestamp(3) without time zone NOT NULL,
    status public."StatusSecurityCode" DEFAULT 'ACTIVE'::public."StatusSecurityCode" NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.security_code OWNER TO postgres;

--
-- Name: security_code_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.security_code_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.security_code_id_seq OWNER TO postgres;

--
-- Name: security_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.security_code_id_seq OWNED BY public.security_code.id;


--
-- Name: token_managements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_managements (
    id integer NOT NULL,
    id_user integer,
    origin text NOT NULL,
    token text NOT NULL,
    expiration timestamp(3) without time zone NOT NULL,
    data jsonb,
    status public."Status" DEFAULT 'INACTIVE'::public."Status" NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.token_managements OWNER TO postgres;

--
-- Name: token_managements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.token_managements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.token_managements_id_seq OWNER TO postgres;

--
-- Name: token_managements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.token_managements_id_seq OWNED BY public.token_managements.id;


--
-- Name: user_configuration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_configuration (
    id integer NOT NULL,
    id_user integer NOT NULL,
    pix_encoded_pixcopypaste text,
    pix_qrcode text,
    pix_transaction_id text,
    pix_key text,
    pix_validation_code text,
    twofactor_code text,
    fee_service_fixed numeric(16,2) DEFAULT 0.00 NOT NULL,
    fee_service_percent numeric(5,2) DEFAULT 0.00 NOT NULL,
    fee_pix numeric(16,2) DEFAULT 0.00 NOT NULL,
    baas_key text,
    baas_secret text,
    baas_name text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.user_configuration OWNER TO postgres;

--
-- Name: user_configuration_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_configuration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_configuration_id_seq OWNER TO postgres;

--
-- Name: user_configuration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_configuration_id_seq OWNED BY public.user_configuration.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    id_user integer,
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL,
    email text NOT NULL,
    password text,
    username text,
    role public."Role" NOT NULL,
    access_token text,
    seed text,
    integration_token text,
    onetime_token text,
    two_factor_active boolean DEFAULT false NOT NULL,
    access_allowed boolean DEFAULT false NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    email_code text,
    email_status public."TypeEmailConfirm" DEFAULT 'UNCONFIRMED'::public."TypeEmailConfirm" NOT NULL,
    password_code text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: Categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories" ALTER COLUMN id SET DEFAULT nextval('public."Categories_id_seq"'::regclass);


--
-- Name: CategoriesOnModules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CategoriesOnModules" ALTER COLUMN id SET DEFAULT nextval('public."CategoriesOnModules_id_seq"'::regclass);


--
-- Name: Modules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Modules" ALTER COLUMN id SET DEFAULT nextval('public."Modules_id_seq"'::regclass);


--
-- Name: Resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Resources" ALTER COLUMN id SET DEFAULT nextval('public."Resources_id_seq"'::regclass);


--
-- Name: ResourcesOnModules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ResourcesOnModules" ALTER COLUMN id SET DEFAULT nextval('public."ResourcesOnModules_id_seq"'::regclass);


--
-- Name: UsersOnCategories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsersOnCategories" ALTER COLUMN id SET DEFAULT nextval('public."UsersOnCategories_id_seq"'::regclass);


--
-- Name: security_code id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_code ALTER COLUMN id SET DEFAULT nextval('public.security_code_id_seq'::regclass);


--
-- Name: token_managements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_managements ALTER COLUMN id SET DEFAULT nextval('public.token_managements_id_seq'::regclass);


--
-- Name: user_configuration id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_configuration ALTER COLUMN id SET DEFAULT nextval('public.user_configuration_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: Categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Categories" (id, name, description, created_id, custom_value, created_at, updated_at) FROM stdin;
7	TESTE	teste	1	\N	2024-03-30 15:55:13.328	2024-03-30 15:55:13.328
\.


--
-- Data for Name: CategoriesOnModules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CategoriesOnModules" (id, "categoryId", "moduleId", "order") FROM stdin;
18	7	5	0
14	7	6	1
20	7	7	2
15	7	8	3
16	7	9	4
\.


--
-- Data for Name: Modules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Modules" (id, name, description, value, created_at, updated_at, path_make_function) FROM stdin;
5	Informações pessoais	Dados básicos, relacionamentos e histórico de telefones.	0.35	2023-12-23 06:05:03.276	2023-12-23 06:05:03.276	makePersonalInformation
6	Restrição financeira	Score e débitos	0.2	2023-12-23 06:53:31.376	2023-12-23 06:53:31.376	makeFinancialInformation
7	Antecedentes judiciais	Processos judiciais	0.2	2023-12-23 07:06:06.461	2023-12-23 07:06:06.461	makeJudicialBackground
8	Informações financeiras	Todos os valores apresentados são estimativas baseadas exclusivamente em dados públicos.	0.1	2023-12-25 05:18:32.083	2023-12-25 05:18:32.083	makeFinancialRestriction
9	Histórico profissional	Detalhes sobre o histórico profissional.	0.1	2023-12-25 05:22:54.493	2023-12-25 05:22:54.493	makeProfessionalHistory
10	Relacionamentos econômicos	Detalhes sobre os relacionamentos econômicos.	0.1	2023-12-25 05:28:15.289	2023-12-25 05:28:15.289	1
11	Servidores públicos	Buscamos o cliente consultado em várias bases de servidores públicos, com cobertura em nível federal e estadual	0.1	2023-12-25 05:33:02.562	2023-12-25 05:33:02.562	1
12	Endereços	informações gerais sobre características gerais dos endereços	0.1	2023-12-25 05:45:51.526	2023-12-25 05:45:51.526	1
\.


--
-- Data for Name: Resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Resources" (id, name, path, description, value, library, created_at, updated_at) FROM stdin;
3	Obter informações dos sites	getDomains	Obter informações dos sites e domínios que estão associados com a entidade consultada	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
4	Participação em entidades classistas	getClassCouncils	Retorna informações de participação da pessoa em entidades classistas ou associações profissionais relevantes.	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
5	Histórico de trabalho	getProfessionalData	Retorna informações agregadas relacionadas com o histórico de trabalho e/ou o trabalho atual da pessoa	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
6	Funcionários públicos	getPublicServants	Retorna informações agregadas e detalhadas dos funcionários públicos	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
7	Programas de benefícios	getBenefitsSocialAssistance	Retorna informações sobre diferentes programas de benefícios entregues pelos governos aos seus cidadãos	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
8	Notícias públicas da internet	getExposureProfileMedia	Retorna informações capturadas de fontes de notícias públicas da internet	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
9	KYC - Regulatorios e/ou Legais	getKYCCompliance	Engloba informações necessárias para atender a requisitos regulatórios e/ou legais relacionados com processos de know-your-client	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
10	KYC - News	getKYCNews	Retorna notícias relevantes que dão suporte a requisitos regulatórios e/ou legais relacionados principalmente com processos de KYC e PLD	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
11	Doações Realizadas	getElectoralDonations	Retorna informações detalhadas sobre as doações realizadas para campanhas eleitorais pela entidade consultada	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
12	Participação em eleições	getElectoralCandidates	informações detalhadas da participação dos indivíduos em eleições, atuais e históricas.	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
13	Presença em aplicativos	getPresenceAppsPlatforms	identificar a presença da entidade consultada em diferentes plataformas e aplicativos relevantes no universo online	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
14	Anúncios	getOnlineAds	Traz informações relacionadas com a totalidade dos anúncios postados pelo indivíduo consultado nos principais marketplaces e portais de anúncios da internet.	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
15	Certidão de Débitos - Tributários Federais e à Dívida Ativa da União	getCertificateNothingListed	Retorna o resultado da emissão de Certidão de Débitos Relativos a Créditos Tributários Federais e à Dívida Ativa da União	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
16	Sanções Administrativas do Banco Central	getCentralBankAdministrativeSanctions	Retorna os dados extraídos da consulta pública de pessoas sancionadas pelo BC por alguma razão	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
17	Antecedentes criminais - PF	getCriminalBackgroundCertificatePF	Retorna os dados referentes a emissão de uma certidão de antecedentes criminais junto a Polícia Federal Brasileira	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
18	Antecedentes criminais - PC	getCriminalBackgroundCertificatePC	Retorna os dados referentes à emissão de uma Certidão de Antecedentes Criminais junto à Polícia Civil do Estado consultado	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-11-22 06:55:46.888
19	Certidão de Débitos Relativos a Créditos Tributários Federais	getPGFNCertificate	Retorna o resultado da emissão de Certidão de Débitos Relativos a Créditos Tributários Federais e à Dívida Ativa da União	0.5	BIGDATA	2023-12-11 05:22:55.476	2023-12-11 05:22:55.476
20	Débitos estaduais associados	getNegativeCertificateStateDebts	Retorna, quando não existem débitos estaduais associados à entidade sendo consultada, uma certidão que comprova a não existência de débitos.	0.5	BIGDATA	2023-12-11 05:23:41.132	2023-12-11 05:23:41.132
21	Débitos trabalhistas	getNegativeCertificateLaborDebts	Retorna, quando não existem débitos trabalhistas associados a entidade sendo consultada, uma certidão que comprova a não existência desses débitos.	0.5	BIGDATA	2023-12-11 05:24:05.37	2023-12-11 05:24:05.37
22	Protestos de títulos	getNegativeProtestCertificate	Retorna, quando não existem protestos de títulos contra a entidade consultada, uma certidão confirmando esse fato, emitida pelo Instituto de Estudos de Protesto de Títulos do Brasil	0.5	BIGDATA	2023-12-11 05:24:45.396	2023-12-11 05:24:45.396
23	Ibama	getCertificateRegularityIbama	Retorna dados de um documento de acesso público atestado pelo Ibama	0.5	BIGDATA	2023-12-11 05:25:25.514	2023-12-11 05:25:25.514
24	Informações de pessoas relacionadas	getCirclesRelatives	Retornam informações agregadas de pessoas relacionadas a entidade consultada, de acordo com o tipo de relacionamento entre elas.	0.5	BIGDATA	2023-12-11 05:28:06.139	2023-12-11 05:28:06.139
25	Informações de pessoas de primeiro grau relacionadas	getCirclesRelatives1stDegree	retornam informações agregadas de pessoas de primero grau relacionadas a entidade consultada, de acordo com o tipo de relacionamento entre elas.	0.5	BIGDATA	2023-12-11 05:30:07.291	2023-12-11 05:30:07.291
26	Informações de membros do círculo	getCirclesMembers	retornam informações agregadas de pessoas relacionadas a entidade consultada, de acordo com o tipo de relacionamento entre elas	0.5	BIGDATA	2023-12-11 05:31:59.799	2023-12-11 05:31:59.799
27	Pessoas relacionadas no edifício	getCirclesNeighborsSameBuilding	retornam informações agregadas de pessoas relacionadas a entidade consultada, no mesmo edifício ou moradia 	0.5	BIGDATA	2023-12-11 05:33:05.468	2023-12-11 05:33:05.468
31	Envolvimento em ações judiciais de primeiro nível	getJudicialAdministrativeProceedingsFirstLevelRelatives	retorna informações, tanto atuais quanto históricas, do envolvimento da entidade consultada em primeiro nível, em ações judiciais de todos os tipos (civil, trabalhista, criminal, etc.)	0.5	BIGDATA	2023-12-11 05:39:01.842	2023-12-11 05:39:01.842
32	Comportamento de crédito	getQuodBusinessCreditScore	traz informações relevantes a respeito do comportamento de crédito de uma empresa no mercado.	0.5	BIGDATA	2023-12-11 05:39:19.342	2023-12-11 05:39:19.342
2	Obter dados completos	getRegistrationData	Obter informacoes pertinentes a procedimentos de cadastro de pessoas	0.12	BIGDATA	2023-11-22 06:55:46.888	2023-12-23 05:53:28.894
1	Obter dados basicos	getBasicRegistrationData	Retorna conjunto mais simples de informações de todos os datasets	0.5	BIGDATA	2023-11-22 06:55:46.888	2023-12-21 05:19:14.963
30	Envolvimento em ações judiciais	getJudicialAdministrativeProceedings	retorna informações, tanto atuais quanto históricas, do envolvimento da entidade consultada em ações judiciais de todos os tipos (civil, trabalhista, criminal, etc.)	0.1	BIGDATA	2023-12-11 05:37:29.925	2023-12-23 07:03:51.003
29	Relacionamentos econômicos	getEconomicRelationships	retorna a lista de entidades relacionadas com o indivíduo consultado em um escopo econômico, que inclui tipos de relacionamento	0.1	BIGDATA	2023-12-11 05:36:34.227	2023-12-25 05:27:18.837
34	Probabilidade de Negativação	getNegativeProbability	retorna um flag que diz se pessoa tem uma probabilidade alta (acima de 70%) de estar inadimplente com algum compromisso financeiro ou de estar negativada em algum serviço de proteção ao crédito	0.5	BIGDATA	2023-12-11 05:47:53.543	2023-12-11 05:47:53.543
36	cobrança de dívida	getPresenceBilling	traz informações que indicam a presença ou passagem de um indivíduo por algum processo de cobrança de dívida	0.5	BIGDATA	2023-12-11 05:50:29.075	2023-12-11 05:50:29.075
37	Indicadores BigData	getIndicatorsCharacteristics	reúne os resultados de diversos modelos desenvolvidos pela própria BigData Corp.	0.5	BIGDATA	2023-12-11 05:52:26.888	2023-12-11 05:52:26.888
38	Informações Financeiras	getFinancialInformation	retorna informações relacionadas com a vida financeira do indivíduo consultado	0.5	BIGDATA	2023-12-11 05:55:14.623	2023-12-11 05:55:14.623
39	Distribuição de processos judiciais	getCourtCaseDistributionData	entrega dados agregados sobre os processos judiciais nos quais a entidade consultada está envolvida, São retornados indicadores de distribuições baseados nos campos principais de retorno do dataset de Processos Judiciais.	0.5	BIGDATA	2023-12-11 05:57:30.617	2023-12-11 05:57:30.617
28	Relacionamentos	getPersonalRelationships	retornam informações agregadas de pessoas relacionadas a entidade consultada, de acordo com o tipo de relacionamento entre elas	0.1	BIGDATA	2023-12-11 05:33:56.639	2023-12-23 06:08:04.266
33	Telefones	getTelephones	retorna, além das informações contidas no dataset de Telefones, uma série de informações adicionais sobre características gerais do próprio telefone	0.1	BIGDATA	2023-12-11 05:39:42.975	2023-12-23 06:08:04.266
40	Presença em Cobrança	getPresenceBilling	traz informações que indicam a presença ou passagem de um indivíduo por algum processo de cobrança de dívida	0.1	BIGDATA	2023-12-23 06:16:45.332	2023-12-23 06:16:45.332
35	Risco de crédito	getFinancialRisk	retorna uma pontuação de risco de crédito de um indivíduo a partir da análise de seus dados financeiros	0.1	BIGDATA	2023-12-11 05:50:04.867	2023-12-23 06:53:16.44
41	Endereços	getAddressesExtended	retorna, além das informações contidas no dataset de Endereços, uma série de informações adicionais sobre características gerais do próprio endereço	0.1	BIGDATA	2023-12-25 05:42:21.264	2023-12-25 05:42:21.264
42	Obter dados financeiros	getFinancialData	contém informações relacionadas com a vida financeira do indivíduo consultado. Ele combina informações calculadas por diferentes mecanismos de inferência com dados concretos extraídos de fontes públicas para tentar apresentar uma visão mais completa do indivíduo	0.5	BIGDATA	2024-01-12 10:25:39.938	2024-01-12 10:25:39.938
\.


--
-- Data for Name: ResourcesOnModules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ResourcesOnModules" (id, "moduleId", "resourceId") FROM stdin;
7	5	28
8	5	33
9	5	2
10	6	35
11	7	30
12	8	38
13	9	5
14	10	29
15	11	6
16	12	41
\.


--
-- Data for Name: UsersOnCategories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UsersOnCategories" (id, "userId", "categoryId", created_at, updated_at) FROM stdin;
2	1	7	2024-03-30 15:55:13.734	2024-03-30 15:55:13.734
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
b950d8a1-dcfc-46c0-b839-68cd461163ae	3c76cbc1157c773a942a7e049cd55b68c9b5c604d4620ffff8b740a44c5b00b9	2024-03-30 15:41:15.943181+00	20240324204214_init	\N	\N	2024-03-30 15:41:14.874233+00	1
056c489e-fb79-448b-831d-93010b8cdfac	49d07ccda7ac0cf3c26ab723d8be8bf3ac5573373b5f70e17cefe416ed434ba7	2024-03-30 15:41:45.473914+00	20240330154143_order_modules	\N	\N	2024-03-30 15:41:44.485207+00	1
a1d897dd-f4e0-422d-be61-8b8f27fa9411	632bf3d45d2f49563ffdc4ae9202cd5d03785f7178f475c80cbbf6f3f2a93f75	2024-03-30 15:46:04.09721+00	20240330154601_change_order_default	\N	\N	2024-03-30 15:46:03.033681+00	1
e2c16b82-ce75-46e1-8ce2-a2b3997d39ee	95f20528dc411bd19999b09bd13ce1d4f310ffc228de101d40282558b8484b25	2024-03-30 15:47:06.085185+00	20240330154704_change_order	\N	\N	2024-03-30 15:47:05.084742+00	1
33196a36-6de6-4a85-a9c6-1951df365a98	41ae95cf3cf5670bcab23984770be67ccfb93b74616219da92113dbf7349a7d9	2024-01-10 22:02:54.135677+00	init		\N	2024-01-10 22:02:54.135677+00	0
4d556f7c-74a5-44cd-af21-39ce8bfbc738	f529354c37008998dce13ddd2edd6c41e2970199e76cb3b804ab4999d39a9e56	2024-01-14 06:44:14.589955+00	20240112013341_path_make_function		\N	2024-01-14 06:44:14.589955+00	1
\.


--
-- Data for Name: security_code; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.security_code (id, id_user, code, date_expiration, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: token_managements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token_managements (id, id_user, origin, token, expiration, data, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_configuration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_configuration (id, id_user, pix_encoded_pixcopypaste, pix_qrcode, pix_transaction_id, pix_key, pix_validation_code, twofactor_code, fee_service_fixed, fee_service_percent, fee_pix, baas_key, baas_secret, baas_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, id_user, status, email, password, username, role, access_token, seed, integration_token, onetime_token, two_factor_active, access_allowed, created_at, updated_at, email_code, email_status, password_code) FROM stdin;
1	\N	ACTIVE	email@mail.com	$2b$10$USZgfNfhAUVPHi0VERjnReJw6t8aPzIv5TBvfLxS0KLXTLXLznzcK	\N	ADMIN	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImVtYWlsIjoiZW1haWxAbWFpbC5jb20iLCJpYXQiOjE3MDM0ODE1MDEsImV4cCI6MTcwMzQ4ODcwMX0.mb229LIC3jnF_dMVI92owonOZ3bQHk896uMI17y08sE	c0538d11-58d0-421d-b19d-4d80a6ebb864	\N	\N	f	f	2023-11-22 05:56:59.121	2023-12-25 05:18:21.573	166734	CONFIRMED	\N
\.


--
-- Name: CategoriesOnModules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."CategoriesOnModules_id_seq"', 20, true);


--
-- Name: Categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Categories_id_seq"', 7, true);


--
-- Name: Modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Modules_id_seq"', 12, true);


--
-- Name: ResourcesOnModules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ResourcesOnModules_id_seq"', 16, true);


--
-- Name: Resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Resources_id_seq"', 42, true);


--
-- Name: UsersOnCategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UsersOnCategories_id_seq"', 2, true);


--
-- Name: security_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.security_code_id_seq', 1, false);


--
-- Name: token_managements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_managements_id_seq', 1, false);


--
-- Name: user_configuration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_configuration_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: CategoriesOnModules CategoriesOnModules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CategoriesOnModules"
    ADD CONSTRAINT "CategoriesOnModules_pkey" PRIMARY KEY (id);


--
-- Name: Categories Categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_pkey" PRIMARY KEY (id);


--
-- Name: Modules Modules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Modules"
    ADD CONSTRAINT "Modules_pkey" PRIMARY KEY (id);


--
-- Name: ResourcesOnModules ResourcesOnModules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ResourcesOnModules"
    ADD CONSTRAINT "ResourcesOnModules_pkey" PRIMARY KEY (id);


--
-- Name: Resources Resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Resources"
    ADD CONSTRAINT "Resources_pkey" PRIMARY KEY (id);


--
-- Name: UsersOnCategories UsersOnCategories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsersOnCategories"
    ADD CONSTRAINT "UsersOnCategories_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: security_code security_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_code
    ADD CONSTRAINT security_code_pkey PRIMARY KEY (id);


--
-- Name: token_managements token_managements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_managements
    ADD CONSTRAINT token_managements_pkey PRIMARY KEY (id);


--
-- Name: user_configuration user_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_configuration
    ADD CONSTRAINT user_configuration_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: user_configuration_id_user_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_configuration_id_user_key ON public.user_configuration USING btree (id_user);


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: users_seed_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_seed_key ON public.users USING btree (seed);


--
-- Name: users_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_username_key ON public.users USING btree (username);


--
-- Name: CategoriesOnModules CategoriesOnModules_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CategoriesOnModules"
    ADD CONSTRAINT "CategoriesOnModules_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Categories"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CategoriesOnModules CategoriesOnModules_moduleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CategoriesOnModules"
    ADD CONSTRAINT "CategoriesOnModules_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES public."Modules"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Categories Categories_created_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_created_id_fkey" FOREIGN KEY (created_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ResourcesOnModules ResourcesOnModules_moduleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ResourcesOnModules"
    ADD CONSTRAINT "ResourcesOnModules_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES public."Modules"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ResourcesOnModules ResourcesOnModules_resourceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ResourcesOnModules"
    ADD CONSTRAINT "ResourcesOnModules_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES public."Resources"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UsersOnCategories UsersOnCategories_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsersOnCategories"
    ADD CONSTRAINT "UsersOnCategories_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Categories"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UsersOnCategories UsersOnCategories_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsersOnCategories"
    ADD CONSTRAINT "UsersOnCategories_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: security_code security_code_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_code
    ADD CONSTRAINT security_code_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: token_managements token_managements_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_managements
    ADD CONSTRAINT token_managements_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: user_configuration user_configuration_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_configuration
    ADD CONSTRAINT user_configuration_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: users users_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

