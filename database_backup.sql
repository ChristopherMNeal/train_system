--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9
-- Dumped by pg_dump version 12.9

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
-- Name: cities; Type: TABLE; Schema: public; Owner: christopherneal
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying,
    station_name character varying
);


ALTER TABLE public.cities OWNER TO christopherneal;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: christopherneal
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_id_seq OWNER TO christopherneal;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: christopherneal
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: stops; Type: TABLE; Schema: public; Owner: christopherneal
--

CREATE TABLE public.stops (
    id integer NOT NULL,
    city_id integer,
    train_id integer,
    "time" time without time zone
);


ALTER TABLE public.stops OWNER TO christopherneal;

--
-- Name: stops_id_seq; Type: SEQUENCE; Schema: public; Owner: christopherneal
--

CREATE SEQUENCE public.stops_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stops_id_seq OWNER TO christopherneal;

--
-- Name: stops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: christopherneal
--

ALTER SEQUENCE public.stops_id_seq OWNED BY public.stops.id;


--
-- Name: trains; Type: TABLE; Schema: public; Owner: christopherneal
--

CREATE TABLE public.trains (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.trains OWNER TO christopherneal;

--
-- Name: trains_id_seq; Type: SEQUENCE; Schema: public; Owner: christopherneal
--

CREATE SEQUENCE public.trains_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trains_id_seq OWNER TO christopherneal;

--
-- Name: trains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: christopherneal
--

ALTER SEQUENCE public.trains_id_seq OWNED BY public.trains.id;


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: christopherneal
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: stops id; Type: DEFAULT; Schema: public; Owner: christopherneal
--

ALTER TABLE ONLY public.stops ALTER COLUMN id SET DEFAULT nextval('public.stops_id_seq'::regclass);


--
-- Name: trains id; Type: DEFAULT; Schema: public; Owner: christopherneal
--

ALTER TABLE ONLY public.trains ALTER COLUMN id SET DEFAULT nextval('public.trains_id_seq'::regclass);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: christopherneal
--

COPY public.cities (id, name, station_name) FROM stdin;
3	Boston	Red line
4	Portland	Union Station
6	Boston	Red line
7	Boston	Red line
8	Boston	Red line
9	Boston	Red line
10	Portland	Union Station
11	Boston	Red line
1	Real City	Real Station
\.


--
-- Data for Name: stops; Type: TABLE DATA; Schema: public; Owner: christopherneal
--

COPY public.stops (id, city_id, train_id, "time") FROM stdin;
27	3	7	15:22:00
28	3	4	15:30:00
29	4	4	06:27:00
30	3	9	15:31:00
31	3	9	15:30:00
32	1	9	15:31:00
\.


--
-- Data for Name: trains; Type: TABLE DATA; Schema: public; Owner: christopherneal
--

COPY public.trains (id, name) FROM stdin;
4	Choo choo choooose you!
7	Train 6
8	Choo choo
9	fast train
\.


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: christopherneal
--

SELECT pg_catalog.setval('public.cities_id_seq', 11, true);


--
-- Name: stops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: christopherneal
--

SELECT pg_catalog.setval('public.stops_id_seq', 32, true);


--
-- Name: trains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: christopherneal
--

SELECT pg_catalog.setval('public.trains_id_seq', 9, true);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: christopherneal
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: stops stops_pkey; Type: CONSTRAINT; Schema: public; Owner: christopherneal
--

ALTER TABLE ONLY public.stops
    ADD CONSTRAINT stops_pkey PRIMARY KEY (id);


--
-- Name: trains trains_pkey; Type: CONSTRAINT; Schema: public; Owner: christopherneal
--

ALTER TABLE ONLY public.trains
    ADD CONSTRAINT trains_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

