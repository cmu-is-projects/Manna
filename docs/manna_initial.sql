--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: attachments; Type: TABLE; Schema: public; Owner: anuradhasrikanth
--

CREATE TABLE attachments (
    id integer NOT NULL,
    name character varying,
    doc character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE attachments OWNER TO anuradhasrikanth;

--
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: anuradhasrikanth
--

CREATE SEQUENCE attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE attachments_id_seq OWNER TO anuradhasrikanth;

--
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anuradhasrikanth
--

ALTER SEQUENCE attachments_id_seq OWNED BY attachments.id;


--
-- Name: case_attachments; Type: TABLE; Schema: public; Owner: anuradhasrikanth
--

CREATE TABLE case_attachments (
    id integer NOT NULL,
    case_id integer,
    attachment_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE case_attachments OWNER TO anuradhasrikanth;

--
-- Name: case_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: anuradhasrikanth
--

CREATE SEQUENCE case_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE case_attachments_id_seq OWNER TO anuradhasrikanth;

--
-- Name: case_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anuradhasrikanth
--

ALTER SEQUENCE case_attachments_id_seq OWNED BY case_attachments.id;


--
-- Name: cases; Type: TABLE; Schema: public; Owner: anuradhasrikanth
--

CREATE TABLE cases (
    id integer NOT NULL,
    client_name character varying,
    client_first_name character varying,
    date_submitted date,
    summary character varying,
    notes text,
    recommendation text,
    status character varying,
    deacon_id integer,
    subject character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    amount_requested double precision,
    amount_approved double precision
);


ALTER TABLE cases OWNER TO anuradhasrikanth;

--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: public; Owner: anuradhasrikanth
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cases_id_seq OWNER TO anuradhasrikanth;

--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anuradhasrikanth
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: anuradhasrikanth
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO anuradhasrikanth;

--
-- Name: users; Type: TABLE; Schema: public; Owner: anuradhasrikanth
--

CREATE TABLE users (
    id integer NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying,
    password_digest character varying,
    phone character varying,
    role character varying,
    active boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE users OWNER TO anuradhasrikanth;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: anuradhasrikanth
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO anuradhasrikanth;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anuradhasrikanth
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: anuradhasrikanth
--

CREATE TABLE votes (
    id integer NOT NULL,
    deacon_id integer,
    decision character varying,
    case_id integer,
    date_submitted date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE votes OWNER TO anuradhasrikanth;

--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: anuradhasrikanth
--

CREATE SEQUENCE votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE votes_id_seq OWNER TO anuradhasrikanth;

--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anuradhasrikanth
--

ALTER SEQUENCE votes_id_seq OWNED BY votes.id;


--
-- Name: attachments id; Type: DEFAULT; Schema: public; Owner: anuradhasrikanth
--

ALTER TABLE ONLY attachments ALTER COLUMN id SET DEFAULT nextval('attachments_id_seq'::regclass);


--
-- Name: case_attachments id; Type: DEFAULT; Schema: public; Owner: anuradhasrikanth
--

ALTER TABLE ONLY case_attachments ALTER COLUMN id SET DEFAULT nextval('case_attachments_id_seq'::regclass);


--
-- Name: cases id; Type: DEFAULT; Schema: public; Owner: anuradhasrikanth
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: anuradhasrikanth
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: votes id; Type: DEFAULT; Schema: public; Owner: anuradhasrikanth
--

ALTER TABLE ONLY votes ALTER COLUMN id SET DEFAULT nextval('votes_id_seq'::regclass);


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: anuradhasrikanth
--

COPY attachments (id, name, doc, created_at, updated_at) FROM stdin;
\.


--
-- Name: attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anuradhasrikanth
--

SELECT pg_catalog.setval('attachments_id_seq', 1, false);


--
-- Data for Name: case_attachments; Type: TABLE DATA; Schema: public; Owner: anuradhasrikanth
--

COPY case_attachments (id, case_id, attachment_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: case_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anuradhasrikanth
--

SELECT pg_catalog.setval('case_attachments_id_seq', 1, false);


--
-- Data for Name: cases; Type: TABLE DATA; Schema: public; Owner: anuradhasrikanth
--

COPY cases (id, client_name, client_first_name, date_submitted, summary, notes, recommendation, status, deacon_id, subject, created_at, updated_at, amount_requested, amount_approved) FROM stdin;
1	Gregorio Schmeler I	Miss Reva Walsh	2017-11-06	Sunt quis eum explicabo ut quo impedit. Voluptatem earum hic corporis quidem possimus voluptatem neque. Aut labore omnis ut similique saepe facere doloremque. Sit aperiam sed totam. Est fugiat sequi cum et esse facilis aspernatur. Saepe cumque doloremque dolorem et rerum labore. Fuga occaecati iste consequuntur delectus vel aut.	Quo quasi est et explicabo sit.	Illo architecto porro voluptatem.	submitted	2	Voluptate quasi repellendus similique non quis.	2017-11-06 03:36:19.625806	2017-11-06 03:36:19.625806	98.4399999999999977	48.8900000000000006
2	Gianni Langworth	Vena Stehr	2017-11-06	Ut distinctio quia officia necessitatibus aperiam iure. Dicta voluptas aut et perferendis nam. Ad dolorem impedit omnis. Est velit nobis sit tempora dolor. Dolorum dolorem et architecto sunt perspiciatis qui non. Eos est tenetur fugiat voluptatum. Ipsum dolorem et. Voluptas enim et aspernatur est officiis et quas.	Iusto autem quia blanditiis delectus.	Nihil consequuntur rerum quis.	submitted	2	Modi tempore et.	2017-11-06 03:36:20.261804	2017-11-06 03:36:20.261804	6.08000000000000007	41.5600000000000023
3	Peggie Klein IV	Krista Huels	2017-11-06	Non culpa quae sunt doloremque velit. Aut at molestiae consequuntur recusandae rerum est unde. Omnis nemo enim adipisci eos. Aut in aut. Eum accusamus possimus facere et adipisci qui et. Non aut dolores tenetur enim corrupti. A ut velit voluptatem unde quibusdam beatae. Molestiae optio enim.	Sed id delectus.	Qui accusantium dolorum asperiores.	submitted	2	Temporibus quisquam.	2017-11-06 03:36:20.845121	2017-11-06 03:36:20.845121	18.1799999999999997	3.22999999999999998
4	Mrs. Okey Parker	Mr. Devin Goyette	2017-11-06	Eligendi numquam ut voluptatem libero veritatis. Aut similique perspiciatis deleniti voluptatem vel repellendus aut. Ex explicabo animi aperiam et. Qui sint magni. Dolorum dolores magnam qui quia. Consequatur qui autem aut animi. Ex enim et nostrum natus at. Ullam voluptas molestiae dolorem sint dolor velit id. Omnis ullam est perspiciatis occaecati a nemo.	Labore et neque.	At et porro mollitia blanditiis aut.	submitted	2	In temporibus eveniet.	2017-11-06 03:36:21.520322	2017-11-06 03:36:21.520322	8.60999999999999943	61.8500000000000014
5	Elza Schimmel PhD	Alexie Tillman	2017-11-06	Quas et blanditiis sequi. Omnis esse culpa aut sunt doloribus. Nulla optio aut aut qui eius illo. Molestiae in quod enim. Natus praesentium earum est omnis. Error velit saepe alias debitis. Earum ea facere illo et sequi.	Consequatur sunt sapiente illo eveniet.	Dolore blanditiis recusandae excepturi quia.	submitted	2	Qui.	2017-11-06 03:36:22.108252	2017-11-06 03:36:22.108252	24.8399999999999999	63.0700000000000003
6	Amanda Lindgren	Marion Weimann	2017-11-06	Et ut in distinctio. Pariatur vel dolor architecto. Sapiente est mollitia fugit nemo debitis nam accusamus. Repellat excepturi et et quam. Dolores reiciendis ab cumque delectus enim corrupti asperiores. Dolor et quia iusto optio. Est aut tempora eaque labore quia.	Ex vitae voluptatem sed odio illo rerum est.	Aut et cum quia occaecati.	submitted	2	Recusandae voluptatem.	2017-11-06 03:36:22.677099	2017-11-06 03:36:22.677099	60.5499999999999972	29.3500000000000014
7	Dalton Heathcote	Brandt Kilback	2017-11-06	Dicta possimus consequatur. Assumenda officiis sed minima quo. Sunt qui omnis distinctio provident dolorem voluptatum. Inventore laboriosam velit omnis iure rerum. Eveniet asperiores minima voluptatem et. Voluptas voluptatem ipsum et exercitationem eligendi est. Est rerum dolores et cum pariatur ea. Molestiae velit autem facilis sit rerum.	Est culpa commodi voluptas reprehenderit laborum vel.	Sed quis modi et est.	approved	2	Et ea optio.	2017-11-06 03:36:23.25909	2017-11-06 03:36:23.25909	31.3200000000000003	37.5799999999999983
8	Haylie Kreiger	Julien Crist	2017-11-06	Omnis qui aperiam omnis sunt. Adipisci et rem. Reiciendis atque beatae eius optio totam cum dicta. Ut eos quidem temporibus quis aut. Temporibus quia aperiam autem quae et. Cum dicta ullam optio et. Rerum nam ad voluptatibus voluptatem et perferendis magnam. Eaque quasi doloribus et voluptatem et. Eos ipsam harum esse est velit architecto illo.	Qui qui et ut et voluptatum.	Ut cupiditate sequi vitae molestiae.	approved	2	Qui totam qui neque.	2017-11-06 03:36:23.827582	2017-11-06 03:36:23.827582	66.1899999999999977	58.0799999999999983
9	Karen Abshire	Ms. Julian Herzog	2017-11-06	Molestias voluptatum velit consequuntur quos aut eveniet ut. Enim reprehenderit iure aut ut aut sit tempore. Earum quos architecto recusandae reiciendis amet laborum. Amet aut iusto sit voluptatem nisi. Rerum vero ipsam id. Enim voluptatem non non autem. Et et animi dignissimos distinctio dolor.	Neque esse nihil.	Reiciendis eum minus.	approved	2	Sint.	2017-11-06 03:36:24.432116	2017-11-06 03:36:24.432116	15.1699999999999999	34.1599999999999966
\.


--
-- Name: cases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anuradhasrikanth
--

SELECT pg_catalog.setval('cases_id_seq', 9, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: anuradhasrikanth
--

COPY schema_migrations (version) FROM stdin;
20170215003102
20170215003136
20170215003212
20170215003232
20170215003253
20171025155220
20171025155608
20171025155633
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: anuradhasrikanth
--

COPY users (id, first_name, last_name, email, password_digest, phone, role, active, created_at, updated_at) FROM stdin;
1	Heidi	Dekkon	head_deacon@gmail.com	$2a$10$NfEjBW1ewz6r3aWyTsF8luIsYzpDI.HTDfpj2qO2we/gy4mET3WZi	9733074206	head_deacon	t	2017-11-06 03:36:18.580291	2017-11-06 03:36:18.580291
2	Jason	Chen	jason95014@gmail.com	$2a$10$Ofs6/27RYhi.F58MAG0BHuM3W1Fq4JeCoPPGOtG.RFZvA09.qHh6W	9733074206	admin	t	2017-11-06 03:36:18.659884	2017-11-06 03:36:18.659884
3	Johnny	Wu	jwu@gmail.com	$2a$10$c6U4uw4D7m8KY8SyjXigYuj.M0jXDs1aEhDOkgtva2hPqxsjGKxQ.	9733074206	care_deacon	t	2017-11-06 03:36:18.750656	2017-11-06 03:36:18.750656
4	Justin	Chen	jchen@gmail.com	$2a$10$XdavPp/k.yh8vzPJIGzqAuLeUv91zj1v95UD18pwHRamH5Q3/NcwG	9733074206	financial_deacon	t	2017-11-06 03:36:18.839997	2017-11-06 03:36:18.839997
5	Kane	Manage	staff@gmail.com	$2a$10$V1JR8bX9GWr3BXK3X.eLt.MCyCu.ZqTHkpXl.kcKZXihnzEi1NqyC	9733074206	staff	t	2017-11-06 03:36:18.917664	2017-11-06 03:36:18.917664
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anuradhasrikanth
--

SELECT pg_catalog.setval('users_id_seq', 5, true);


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: anuradhasrikanth
--

COPY votes (id, deacon_id, decision, case_id, date_submitted, created_at, updated_at) FROM stdin;
\.


--
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anuradhasrikanth
--

SELECT pg_catalog.setval('votes_id_seq', 1, false);


--
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: anuradhasrikanth
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: case_attachments case_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: anuradhasrikanth
--

ALTER TABLE ONLY case_attachments
    ADD CONSTRAINT case_attachments_pkey PRIMARY KEY (id);


--
-- Name: cases cases_pkey; Type: CONSTRAINT; Schema: public; Owner: anuradhasrikanth
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: anuradhasrikanth
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: anuradhasrikanth
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: anuradhasrikanth
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

