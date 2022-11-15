SET check_function_bodies = false;
CREATE TABLE public.pizza_toppings (
    id integer NOT NULL,
    pizza_id integer NOT NULL,
    topping_id integer NOT NULL
);
COMMENT ON TABLE public.pizza_toppings IS 'bridge table between pizzas and toppings';
CREATE SEQUENCE public.pizza_toppings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.pizza_toppings_id_seq OWNED BY public.pizza_toppings.id;
CREATE TABLE public.pizzas (
    id integer NOT NULL,
    name text NOT NULL,
    price integer NOT NULL,
    image text NOT NULL,
    crust text NOT NULL
);
COMMENT ON TABLE public.pizzas IS 'just pizzas...';
CREATE SEQUENCE public.pizzas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.pizzas_id_seq OWNED BY public.pizzas.id;
CREATE TABLE public.toppings (
    id integer NOT NULL,
    name text NOT NULL,
    price integer NOT NULL,
    image text NOT NULL
);
COMMENT ON TABLE public.toppings IS 'just toppings';
CREATE SEQUENCE public.toppings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.toppings_id_seq OWNED BY public.toppings.id;
ALTER TABLE ONLY public.pizza_toppings ALTER COLUMN id SET DEFAULT nextval('public.pizza_toppings_id_seq'::regclass);
ALTER TABLE ONLY public.pizzas ALTER COLUMN id SET DEFAULT nextval('public.pizzas_id_seq'::regclass);
ALTER TABLE ONLY public.toppings ALTER COLUMN id SET DEFAULT nextval('public.toppings_id_seq'::regclass);
ALTER TABLE ONLY public.pizza_toppings
    ADD CONSTRAINT pizza_toppings_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.pizzas
    ADD CONSTRAINT pizzas_image_key UNIQUE (image);
ALTER TABLE ONLY public.pizzas
    ADD CONSTRAINT pizzas_name_key UNIQUE (name);
ALTER TABLE ONLY public.pizzas
    ADD CONSTRAINT pizzas_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.toppings
    ADD CONSTRAINT toppings_name_key UNIQUE (name);
ALTER TABLE ONLY public.toppings
    ADD CONSTRAINT toppings_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.pizza_toppings
    ADD CONSTRAINT pizza_toppings_pizza_id_fkey FOREIGN KEY (pizza_id) REFERENCES public.pizzas(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.pizza_toppings
    ADD CONSTRAINT pizza_toppings_topping_id_fkey FOREIGN KEY (topping_id) REFERENCES public.toppings(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
