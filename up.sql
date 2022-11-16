--
-- PostgreSQL database dump
--

-- Dumped from database version 12.12 (Debian 12.12-1.pgdg110+1)
-- Dumped by pg_dump version 12.12 (Debian 12.12-1.pgdg110+1)

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
-- Name: hdb_catalog; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA hdb_catalog;


ALTER SCHEMA hdb_catalog OWNER TO postgres;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: gen_hasura_uuid(); Type: FUNCTION; Schema: hdb_catalog; Owner: postgres
--

CREATE FUNCTION hdb_catalog.gen_hasura_uuid() RETURNS uuid
    LANGUAGE sql
    AS $$select gen_random_uuid()$$;


ALTER FUNCTION hdb_catalog.gen_hasura_uuid() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: hdb_action_log; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_action_log (
    id uuid DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    action_name text,
    input_payload jsonb NOT NULL,
    request_headers jsonb NOT NULL,
    session_variables jsonb NOT NULL,
    response_payload jsonb,
    errors jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    response_received_at timestamp with time zone,
    status text NOT NULL,
    CONSTRAINT hdb_action_log_status_check CHECK ((status = ANY (ARRAY['created'::text, 'processing'::text, 'completed'::text, 'error'::text])))
);


ALTER TABLE hdb_catalog.hdb_action_log OWNER TO postgres;

--
-- Name: hdb_cron_event_invocation_logs; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_cron_event_invocation_logs (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    event_id text,
    status integer,
    request json,
    response json,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE hdb_catalog.hdb_cron_event_invocation_logs OWNER TO postgres;

--
-- Name: hdb_cron_events; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_cron_events (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    trigger_name text NOT NULL,
    scheduled_time timestamp with time zone NOT NULL,
    status text DEFAULT 'scheduled'::text NOT NULL,
    tries integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    next_retry_at timestamp with time zone,
    CONSTRAINT valid_status CHECK ((status = ANY (ARRAY['scheduled'::text, 'locked'::text, 'delivered'::text, 'error'::text, 'dead'::text])))
);


ALTER TABLE hdb_catalog.hdb_cron_events OWNER TO postgres;

--
-- Name: hdb_metadata; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_metadata (
    id integer NOT NULL,
    metadata json NOT NULL,
    resource_version integer DEFAULT 1 NOT NULL
);


ALTER TABLE hdb_catalog.hdb_metadata OWNER TO postgres;

--
-- Name: hdb_scheduled_event_invocation_logs; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_scheduled_event_invocation_logs (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    event_id text,
    status integer,
    request json,
    response json,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE hdb_catalog.hdb_scheduled_event_invocation_logs OWNER TO postgres;

--
-- Name: hdb_scheduled_events; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_scheduled_events (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    webhook_conf json NOT NULL,
    scheduled_time timestamp with time zone NOT NULL,
    retry_conf json,
    payload json,
    header_conf json,
    status text DEFAULT 'scheduled'::text NOT NULL,
    tries integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    next_retry_at timestamp with time zone,
    comment text,
    CONSTRAINT valid_status CHECK ((status = ANY (ARRAY['scheduled'::text, 'locked'::text, 'delivered'::text, 'error'::text, 'dead'::text])))
);


ALTER TABLE hdb_catalog.hdb_scheduled_events OWNER TO postgres;

--
-- Name: hdb_schema_notifications; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_schema_notifications (
    id integer NOT NULL,
    notification json NOT NULL,
    resource_version integer DEFAULT 1 NOT NULL,
    instance_id uuid NOT NULL,
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT hdb_schema_notifications_id_check CHECK ((id = 1))
);


ALTER TABLE hdb_catalog.hdb_schema_notifications OWNER TO postgres;

--
-- Name: hdb_version; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_version (
    hasura_uuid uuid DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    version text NOT NULL,
    upgraded_on timestamp with time zone NOT NULL,
    cli_state jsonb DEFAULT '{}'::jsonb NOT NULL,
    console_state jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE hdb_catalog.hdb_version OWNER TO postgres;

--
-- Name: migration_settings; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.migration_settings (
    setting text NOT NULL,
    value text NOT NULL
);


ALTER TABLE hdb_catalog.migration_settings OWNER TO postgres;

--
-- Name: schema_migrations; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.schema_migrations (
    version bigint NOT NULL,
    dirty boolean NOT NULL
);


ALTER TABLE hdb_catalog.schema_migrations OWNER TO postgres;

--
-- Name: pizza_toppings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pizza_toppings (
    id integer NOT NULL,
    pizza_id integer NOT NULL,
    topping_id integer NOT NULL
);


ALTER TABLE public.pizza_toppings OWNER TO postgres;

--
-- Name: TABLE pizza_toppings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.pizza_toppings IS 'bridge table between pizzas and toppings';


--
-- Name: pizza_toppings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pizza_toppings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pizza_toppings_id_seq OWNER TO postgres;

--
-- Name: pizza_toppings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pizza_toppings_id_seq OWNED BY public.pizza_toppings.id;


--
-- Name: pizzas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pizzas (
    id integer NOT NULL,
    name text NOT NULL,
    price integer NOT NULL,
    image text NOT NULL,
    crust text NOT NULL
);


ALTER TABLE public.pizzas OWNER TO postgres;

--
-- Name: TABLE pizzas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.pizzas IS 'just pizzas...';


--
-- Name: pizzas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pizzas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pizzas_id_seq OWNER TO postgres;

--
-- Name: pizzas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pizzas_id_seq OWNED BY public.pizzas.id;


--
-- Name: toppings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.toppings (
    id integer NOT NULL,
    name text NOT NULL,
    price integer NOT NULL,
    image text NOT NULL
);


ALTER TABLE public.toppings OWNER TO postgres;

--
-- Name: TABLE toppings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.toppings IS 'just toppings';


--
-- Name: toppings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.toppings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.toppings_id_seq OWNER TO postgres;

--
-- Name: toppings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.toppings_id_seq OWNED BY public.toppings.id;


--
-- Name: pizza_toppings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizza_toppings ALTER COLUMN id SET DEFAULT nextval('public.pizza_toppings_id_seq'::regclass);


--
-- Name: pizzas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizzas ALTER COLUMN id SET DEFAULT nextval('public.pizzas_id_seq'::regclass);


--
-- Name: toppings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.toppings ALTER COLUMN id SET DEFAULT nextval('public.toppings_id_seq'::regclass);


--
-- Data for Name: hdb_action_log; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_action_log (id, action_name, input_payload, request_headers, session_variables, response_payload, errors, created_at, response_received_at, status) FROM stdin;
\.


--
-- Data for Name: hdb_cron_event_invocation_logs; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_cron_event_invocation_logs (id, event_id, status, request, response, created_at) FROM stdin;
\.


--
-- Data for Name: hdb_cron_events; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_cron_events (id, trigger_name, scheduled_time, status, tries, created_at, next_retry_at) FROM stdin;
\.


--
-- Data for Name: hdb_metadata; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_metadata (id, metadata, resource_version) FROM stdin;
1	{"sources":[{"kind":"postgres","name":"default","tables":[{"object_relationships":[{"using":{"foreign_key_constraint_on":"pizza_id"},"name":"pizza"},{"using":{"foreign_key_constraint_on":"topping_id"},"name":"topping"}],"table":{"schema":"public","name":"pizza_toppings"}},{"table":{"schema":"public","name":"pizzas"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"pizza_id","table":{"schema":"public","name":"pizza_toppings"}}},"name":"pizza_toppings"}]},{"table":{"schema":"public","name":"toppings"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"topping_id","table":{"schema":"public","name":"pizza_toppings"}}},"name":"pizza_toppings"}]}],"configuration":{"connection_info":{"use_prepared_statements":true,"database_url":{"from_env":"HASURA_GRAPHQL_DATABASE_URL"},"isolation_level":"read-committed","pool_settings":{"connection_lifetime":600,"retries":1,"idle_timeout":180,"max_connections":50}}}}],"version":3}	15
\.


--
-- Data for Name: hdb_scheduled_event_invocation_logs; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_scheduled_event_invocation_logs (id, event_id, status, request, response, created_at) FROM stdin;
\.


--
-- Data for Name: hdb_scheduled_events; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_scheduled_events (id, webhook_conf, scheduled_time, retry_conf, payload, header_conf, status, tries, created_at, next_retry_at, comment) FROM stdin;
\.


--
-- Data for Name: hdb_schema_notifications; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_schema_notifications (id, notification, resource_version, instance_id, updated_at) FROM stdin;
1	{"metadata":false,"remote_schemas":[],"sources":[]}	15	dd1b250b-1293-4d00-a9b6-6d4741de3cb9	2022-11-15 09:52:56.520501+00
\.


--
-- Data for Name: hdb_version; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_version (hasura_uuid, version, upgraded_on, cli_state, console_state) FROM stdin;
cf9621d8-d249-428d-9f22-cc9cf36c9832	47	2022-11-15 09:40:08.162378+00	{}	{"console_notifications": {"admin": {"date": "2022-11-15T12:44:54.147Z", "read": "default", "showBadge": false}}, "telemetryNotificationShown": true}
\.


--
-- Data for Name: migration_settings; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.migration_settings (setting, value) FROM stdin;
migration_mode	true
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.schema_migrations (version, dirty) FROM stdin;
1668517998034	f
\.


--
-- Data for Name: pizza_toppings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pizza_toppings (id, pizza_id, topping_id) FROM stdin;
1	1	1
2	1	10
3	2	2
4	2	3
5	2	7
6	4	11
7	5	5
8	5	4
9	5	3
10	6	5
11	6	9
12	6	7
13	7	1
14	7	2
19	7	7
20	7	9
21	7	10
\.


--
-- Data for Name: pizzas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pizzas (id, name, price, image, crust) FROM stdin;
1	Diesel Special	350	https://i.ibb.co/JRyCxSQ/expired-pizza-modified.png	thin
2	Presidential Supreme	1000	https://i.ibb.co/r6QdhVF/presidewntail-modified.png	Extra Thick
4	Strawberry Elite	500	https://i.ibb.co/qMkT6Fz/strawberry-pizza-modified.png	Fruity
5	Komo Special	400	https://i.ibb.co/WyrX4yV/ugly-pizza-modified.png	Thin
6	Ashtray	100	https://i.ibb.co/rb9Y7BW/netanya-modified.png	Thick
7	"All The Way"	650	https://i.ibb.co/DffmpZq/burnt-modified.png	Crispy
\.


--
-- Data for Name: toppings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.toppings (id, name, price, image) FROM stdin;
1	Glass	50	https://static.wikia.nocookie.net/gardenpaws/images/1/18/Ice_Shard.png
3	Black Olives	70	https://dtgxwmigmg3gc.cloudfront.net/imagery/assets/derivations/icon/256/256/true/eyJpZCI6IjdhMjc5ZmE0NTU5YWQwM2I3ZWI4MThjOWE2MDgwOGRlIiwic3RvcmFnZSI6InB1YmxpY19zdG9yZSJ9?signature=4ad209e117b50b357b016d600012f408bdbec6b62883163271bd0e667f19ebc6
4	Grapes	90	https://cdn-icons-png.flaticon.com/256/7439/7439309.png
5	Sand	20	https://oyster.ignimgs.com/mediawiki/apis.ign.com/ark-survival-evolved/5/5a/Sand_Icon.jpg
7	Animal Fat (unknown animal)	70	https://eip.gg/wp-content/uploads/2022/01/ITEM_AnimalFat.png
11	Strawberry	100	http://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/strawberry.png
9	Pineapple	120	https://dtgxwmigmg3gc.cloudfront.net/imagery/assets/derivations/icon/256/256/true/eyJpZCI6ImZjMzBjODNmOGFmNzU3Y2JjMTExZDgxMzU2NWRiZjkwIiwic3RvcmFnZSI6InB1YmxpY19zdG9yZSJ9?signature=0d6b374cfdd1e82a3ceff85b9a9a860d23656a9f50dab06c389da6af57568c3a
10	Pepperoni 	1000	data:image/jpeg;base64,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
2	Green Olives	1100	data:image/jpeg;base64,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
\.


--
-- Name: pizza_toppings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pizza_toppings_id_seq', 21, true);


--
-- Name: pizzas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pizzas_id_seq', 7, true);


--
-- Name: toppings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.toppings_id_seq', 11, true);


--
-- Name: hdb_action_log hdb_action_log_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_action_log
    ADD CONSTRAINT hdb_action_log_pkey PRIMARY KEY (id);


--
-- Name: hdb_cron_event_invocation_logs hdb_cron_event_invocation_logs_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_cron_event_invocation_logs
    ADD CONSTRAINT hdb_cron_event_invocation_logs_pkey PRIMARY KEY (id);


--
-- Name: hdb_cron_events hdb_cron_events_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_cron_events
    ADD CONSTRAINT hdb_cron_events_pkey PRIMARY KEY (id);


--
-- Name: hdb_metadata hdb_metadata_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_metadata
    ADD CONSTRAINT hdb_metadata_pkey PRIMARY KEY (id);


--
-- Name: hdb_metadata hdb_metadata_resource_version_key; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_metadata
    ADD CONSTRAINT hdb_metadata_resource_version_key UNIQUE (resource_version);


--
-- Name: hdb_scheduled_event_invocation_logs hdb_scheduled_event_invocation_logs_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_scheduled_event_invocation_logs
    ADD CONSTRAINT hdb_scheduled_event_invocation_logs_pkey PRIMARY KEY (id);


--
-- Name: hdb_scheduled_events hdb_scheduled_events_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_scheduled_events
    ADD CONSTRAINT hdb_scheduled_events_pkey PRIMARY KEY (id);


--
-- Name: hdb_schema_notifications hdb_schema_notifications_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_schema_notifications
    ADD CONSTRAINT hdb_schema_notifications_pkey PRIMARY KEY (id);


--
-- Name: hdb_version hdb_version_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_version
    ADD CONSTRAINT hdb_version_pkey PRIMARY KEY (hasura_uuid);


--
-- Name: migration_settings migration_settings_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.migration_settings
    ADD CONSTRAINT migration_settings_pkey PRIMARY KEY (setting);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: pizza_toppings pizza_toppings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizza_toppings
    ADD CONSTRAINT pizza_toppings_pkey PRIMARY KEY (id);


--
-- Name: pizzas pizzas_image_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizzas
    ADD CONSTRAINT pizzas_image_key UNIQUE (image);


--
-- Name: pizzas pizzas_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizzas
    ADD CONSTRAINT pizzas_name_key UNIQUE (name);


--
-- Name: pizzas pizzas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizzas
    ADD CONSTRAINT pizzas_pkey PRIMARY KEY (id);


--
-- Name: toppings toppings_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.toppings
    ADD CONSTRAINT toppings_name_key UNIQUE (name);


--
-- Name: toppings toppings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.toppings
    ADD CONSTRAINT toppings_pkey PRIMARY KEY (id);


--
-- Name: hdb_cron_event_invocation_event_id; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE INDEX hdb_cron_event_invocation_event_id ON hdb_catalog.hdb_cron_event_invocation_logs USING btree (event_id);


--
-- Name: hdb_cron_event_status; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE INDEX hdb_cron_event_status ON hdb_catalog.hdb_cron_events USING btree (status);


--
-- Name: hdb_cron_events_unique_scheduled; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE UNIQUE INDEX hdb_cron_events_unique_scheduled ON hdb_catalog.hdb_cron_events USING btree (trigger_name, scheduled_time) WHERE (status = 'scheduled'::text);


--
-- Name: hdb_scheduled_event_status; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE INDEX hdb_scheduled_event_status ON hdb_catalog.hdb_scheduled_events USING btree (status);


--
-- Name: hdb_version_one_row; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE UNIQUE INDEX hdb_version_one_row ON hdb_catalog.hdb_version USING btree (((version IS NOT NULL)));


--
-- Name: hdb_cron_event_invocation_logs hdb_cron_event_invocation_logs_event_id_fkey; Type: FK CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_cron_event_invocation_logs
    ADD CONSTRAINT hdb_cron_event_invocation_logs_event_id_fkey FOREIGN KEY (event_id) REFERENCES hdb_catalog.hdb_cron_events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hdb_scheduled_event_invocation_logs hdb_scheduled_event_invocation_logs_event_id_fkey; Type: FK CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_scheduled_event_invocation_logs
    ADD CONSTRAINT hdb_scheduled_event_invocation_logs_event_id_fkey FOREIGN KEY (event_id) REFERENCES hdb_catalog.hdb_scheduled_events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pizza_toppings pizza_toppings_pizza_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizza_toppings
    ADD CONSTRAINT pizza_toppings_pizza_id_fkey FOREIGN KEY (pizza_id) REFERENCES public.pizzas(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: pizza_toppings pizza_toppings_topping_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizza_toppings
    ADD CONSTRAINT pizza_toppings_topping_id_fkey FOREIGN KEY (topping_id) REFERENCES public.toppings(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

