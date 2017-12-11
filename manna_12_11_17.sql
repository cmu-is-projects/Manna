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
-- Name: attachments; Type: TABLE; Schema: public; Owner: stephen
--

CREATE TABLE attachments (
    id integer NOT NULL,
    name character varying,
    doc character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE attachments OWNER TO stephen;

--
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: stephen
--

CREATE SEQUENCE attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE attachments_id_seq OWNER TO stephen;

--
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stephen
--

ALTER SEQUENCE attachments_id_seq OWNED BY attachments.id;


--
-- Name: case_attachments; Type: TABLE; Schema: public; Owner: stephen
--

CREATE TABLE case_attachments (
    id integer NOT NULL,
    case_id integer,
    attachment_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE case_attachments OWNER TO stephen;

--
-- Name: case_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: stephen
--

CREATE SEQUENCE case_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE case_attachments_id_seq OWNER TO stephen;

--
-- Name: case_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stephen
--

ALTER SEQUENCE case_attachments_id_seq OWNED BY case_attachments.id;


--
-- Name: cases; Type: TABLE; Schema: public; Owner: stephen
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


ALTER TABLE cases OWNER TO stephen;

--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: public; Owner: stephen
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cases_id_seq OWNER TO stephen;

--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stephen
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: stephen
--

CREATE TABLE payments (
    id integer NOT NULL,
    payment_type character varying,
    payable_to character varying,
    amount double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    case_id integer,
    description character varying
);


ALTER TABLE payments OWNER TO stephen;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: stephen
--

CREATE SEQUENCE payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payments_id_seq OWNER TO stephen;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stephen
--

ALTER SEQUENCE payments_id_seq OWNED BY payments.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: stephen
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO stephen;

--
-- Name: users; Type: TABLE; Schema: public; Owner: stephen
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


ALTER TABLE users OWNER TO stephen;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: stephen
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO stephen;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stephen
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: stephen
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


ALTER TABLE votes OWNER TO stephen;

--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: stephen
--

CREATE SEQUENCE votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE votes_id_seq OWNER TO stephen;

--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stephen
--

ALTER SEQUENCE votes_id_seq OWNED BY votes.id;


--
-- Name: attachments id; Type: DEFAULT; Schema: public; Owner: stephen
--

ALTER TABLE ONLY attachments ALTER COLUMN id SET DEFAULT nextval('attachments_id_seq'::regclass);


--
-- Name: case_attachments id; Type: DEFAULT; Schema: public; Owner: stephen
--

ALTER TABLE ONLY case_attachments ALTER COLUMN id SET DEFAULT nextval('case_attachments_id_seq'::regclass);


--
-- Name: cases id; Type: DEFAULT; Schema: public; Owner: stephen
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: stephen
--

ALTER TABLE ONLY payments ALTER COLUMN id SET DEFAULT nextval('payments_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: stephen
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: votes id; Type: DEFAULT; Schema: public; Owner: stephen
--

ALTER TABLE ONLY votes ALTER COLUMN id SET DEFAULT nextval('votes_id_seq'::regclass);


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: stephen
--

COPY attachments (id, name, doc, created_at, updated_at) FROM stdin;
1	Attachment	Screen_Shot_2017-05-30_at_5.46.00_PM.png	2017-11-30 18:28:18.019012	2017-11-30 18:28:18.019012
\.


--
-- Name: attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stephen
--

SELECT pg_catalog.setval('attachments_id_seq', 1, true);


--
-- Data for Name: case_attachments; Type: TABLE DATA; Schema: public; Owner: stephen
--

COPY case_attachments (id, case_id, attachment_id, created_at, updated_at) FROM stdin;
1	1	1	2017-11-30 18:28:18.069893	2017-11-30 18:28:18.069893
\.


--
-- Name: case_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stephen
--

SELECT pg_catalog.setval('case_attachments_id_seq', 1, true);


--
-- Data for Name: cases; Type: TABLE DATA; Schema: public; Owner: stephen
--

COPY cases (id, client_name, client_first_name, date_submitted, summary, notes, recommendation, status, deacon_id, subject, created_at, updated_at, amount_requested, amount_approved) FROM stdin;
1	John Doe	\N	2017-11-30	SUmmary			submitted	2	Paying Medical Bill	2017-11-30 18:21:46.551167	2017-11-30 18:21:46.551167	500	500
\.


--
-- Name: cases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stephen
--

SELECT pg_catalog.setval('cases_id_seq', 1, true);


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: stephen
--

COPY payments (id, payment_type, payable_to, amount, created_at, updated_at, case_id, description) FROM stdin;
1	Medical	Anu Srikanth	500	2017-11-30 18:22:32.88005	2017-11-30 18:22:32.88005	1	
\.


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stephen
--

SELECT pg_catalog.setval('payments_id_seq', 1, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: stephen
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
20171129231818
20171129233928
20171130041939
20171130091622
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: stephen
--

COPY users (id, first_name, last_name, email, password_digest, phone, role, active, created_at, updated_at) FROM stdin;
1	Heidi	Dekkon	head_deacon@gmail.com	$2a$10$RZ2lLONKMi5aoFDulA0sZOaHQIXAiGoHeLZJcJO.VDG1MPXcwvoEm	9733074206	head_deacon	t	2017-11-30 18:10:10.718675	2017-11-30 18:10:10.718675
2	Jason	Chen	jason95014@gmail.com	$2a$10$M60ofIdia2Ir9S1r081Z2.KnqQyI784x9NggKhXDX5q23mAQy3VqS	9733074206	admin	t	2017-11-30 18:10:10.809805	2017-11-30 18:10:10.809805
3	Johnny	Wu	jwu@gmail.com	$2a$10$3RnAZeIawZcXXxluYy7B8O0KkQkKlbtSxi2EZYGxNE539tIRrrg0K	9733074206	care_deacon	t	2017-11-30 18:10:10.905786	2017-11-30 18:10:10.905786
4	Justin	Chen	jchen@gmail.com	$2a$10$okiJHzO0/rtx9hc0FlVRNuVBAYaARljSWVLCG/wfLYoSVw4NZq0Ly	9733074206	financial_deacon	t	2017-11-30 18:10:10.991188	2017-11-30 18:10:10.991188
5	Kane	Manage	staff@gmail.com	$2a$10$pEx.yHOmtjIQsVaFKFIFCem9k0bSpGtNrCtlje/qLF6xJD9g/b7LW	9733074206	staff	t	2017-11-30 18:10:11.065634	2017-11-30 18:10:11.065634
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stephen
--

SELECT pg_catalog.setval('users_id_seq', 5, true);


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: stephen
--

COPY votes (id, deacon_id, decision, case_id, date_submitted, created_at, updated_at) FROM stdin;
\.


--
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stephen
--

SELECT pg_catalog.setval('votes_id_seq', 1, false);


--
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: stephen
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: case_attachments case_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: stephen
--

ALTER TABLE ONLY case_attachments
    ADD CONSTRAINT case_attachments_pkey PRIMARY KEY (id);


--
-- Name: cases cases_pkey; Type: CONSTRAINT; Schema: public; Owner: stephen
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: stephen
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: stephen
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: stephen
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: stephen
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

