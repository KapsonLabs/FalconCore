--
-- PostgreSQL database dump
--

-- Dumped from database version 12.20 (Ubuntu 12.20-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.20 (Ubuntu 12.20-0ubuntu0.20.04.1)

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
-- Name: accounts_branch; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.accounts_branch (
    id integer NOT NULL,
    branch_name character varying(250) NOT NULL,
    branch_location character varying(250) NOT NULL,
    branch_description text,
    created_on timestamp with time zone NOT NULL,
    created_by_id integer NOT NULL,
    status boolean NOT NULL
);


ALTER TABLE public.accounts_branch OWNER TO djangoappguy;

--
-- Name: accounts_branch_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.accounts_branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_branch_id_seq OWNER TO djangoappguy;

--
-- Name: accounts_branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.accounts_branch_id_seq OWNED BY public.accounts_branch.id;


--
-- Name: accounts_client; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.accounts_client (
    id integer NOT NULL,
    client_type integer NOT NULL,
    registration_date date,
    sex character varying(12),
    address character varying(50),
    area_parish character varying(50),
    area_village character varying(50),
    area_county character varying(50),
    area_subcounty character varying(50),
    area_district character varying(50),
    bank_verification_no character varying(50),
    national_id_number character varying(50),
    signature_mandate text NOT NULL,
    added_on timestamp with time zone NOT NULL,
    added_by_id integer NOT NULL,
    client_branch_id integer NOT NULL,
    related_user_id integer NOT NULL,
    signatory_loans_officer_id integer NOT NULL,
    signatory_sales_officer_id integer NOT NULL,
    signatory_savings_officer_id integer NOT NULL,
    client_account_number character varying(250),
    status boolean NOT NULL
);


ALTER TABLE public.accounts_client OWNER TO djangoappguy;

--
-- Name: accounts_client_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.accounts_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_client_id_seq OWNER TO djangoappguy;

--
-- Name: accounts_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.accounts_client_id_seq OWNED BY public.accounts_client.id;


--
-- Name: accounts_clientbackgroundinformation; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.accounts_clientbackgroundinformation (
    id integer NOT NULL,
    outstanding_portfolio numeric(20,2) NOT NULL,
    portfolio_at_risk numeric(20,2) NOT NULL,
    operating_cost_ratio numeric(20,2) NOT NULL,
    debt_equity_ratio numeric(20,2) NOT NULL,
    operating_self_sufficiency numeric(20,2) NOT NULL,
    related_client_id integer NOT NULL
);


ALTER TABLE public.accounts_clientbackgroundinformation OWNER TO djangoappguy;

--
-- Name: accounts_clientbackgroundinformation_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.accounts_clientbackgroundinformation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_clientbackgroundinformation_id_seq OWNER TO djangoappguy;

--
-- Name: accounts_clientbackgroundinformation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.accounts_clientbackgroundinformation_id_seq OWNED BY public.accounts_clientbackgroundinformation.id;


--
-- Name: accounts_group; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.accounts_group (
    id integer NOT NULL,
    group_name character varying(250) NOT NULL,
    created_on timestamp with time zone NOT NULL,
    related_branch_id integer NOT NULL,
    group_type integer,
    status boolean NOT NULL
);


ALTER TABLE public.accounts_group OWNER TO djangoappguy;

--
-- Name: accounts_group_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.accounts_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_group_id_seq OWNER TO djangoappguy;

--
-- Name: accounts_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.accounts_group_id_seq OWNED BY public.accounts_group.id;


--
-- Name: accounts_groupclients; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.accounts_groupclients (
    id integer NOT NULL,
    added_on timestamp with time zone NOT NULL,
    related_client_id integer NOT NULL,
    related_group_id integer NOT NULL,
    status boolean NOT NULL
);


ALTER TABLE public.accounts_groupclients OWNER TO djangoappguy;

--
-- Name: accounts_groupclients_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.accounts_groupclients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_groupclients_id_seq OWNER TO djangoappguy;

--
-- Name: accounts_groupclients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.accounts_groupclients_id_seq OWNED BY public.accounts_groupclients.id;


--
-- Name: accounts_notificationmessages; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.accounts_notificationmessages (
    id integer NOT NULL,
    message text,
    unread boolean NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    object_id integer,
    content_type_id integer,
    recipient_id integer,
    title character varying(250),
    CONSTRAINT accounts_notificationmessages_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE public.accounts_notificationmessages OWNER TO djangoappguy;

--
-- Name: accounts_notificationmessages_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.accounts_notificationmessages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_notificationmessages_id_seq OWNER TO djangoappguy;

--
-- Name: accounts_notificationmessages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.accounts_notificationmessages_id_seq OWNED BY public.accounts_notificationmessages.id;


--
-- Name: accounts_roles; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.accounts_roles (
    id integer NOT NULL,
    can_add_user integer NOT NULL,
    can_only_list_users integer NOT NULL,
    can_manage_users integer NOT NULL,
    can_add_products integer NOT NULL,
    can_only_list_products integer NOT NULL,
    can_manage_products integer NOT NULL,
    can_add_savings integer NOT NULL,
    can_only_list_savings integer NOT NULL,
    can_manage_savings integer NOT NULL,
    can_add_loan_types integer NOT NULL,
    can_only_list_loan_types integer NOT NULL,
    can_manage_loan_types integer NOT NULL,
    can_add_loan_request integer NOT NULL,
    can_only_list_loan_requests integer NOT NULL,
    can_manage_loan_requests integer NOT NULL,
    related_user_id integer NOT NULL
);


ALTER TABLE public.accounts_roles OWNER TO djangoappguy;

--
-- Name: accounts_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.accounts_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_roles_id_seq OWNER TO djangoappguy;

--
-- Name: accounts_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.accounts_roles_id_seq OWNED BY public.accounts_roles.id;


--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.accounts_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    phone_number character varying(12) NOT NULL,
    status boolean NOT NULL
);


ALTER TABLE public.accounts_user OWNER TO djangoappguy;

--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.accounts_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_user_groups OWNER TO djangoappguy;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.accounts_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_groups_id_seq OWNER TO djangoappguy;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.accounts_user_groups_id_seq OWNED BY public.accounts_user_groups.id;


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.accounts_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_id_seq OWNER TO djangoappguy;

--
-- Name: accounts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.accounts_user_id_seq OWNED BY public.accounts_user.id;


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.accounts_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_user_user_permissions OWNER TO djangoappguy;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.accounts_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_user_permissions_id_seq OWNER TO djangoappguy;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.accounts_user_user_permissions_id_seq OWNED BY public.accounts_user_user_permissions.id;


--
-- Name: accounts_userdetails; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.accounts_userdetails (
    id integer NOT NULL,
    role character varying(250),
    role_description text,
    transfered_on timestamp with time zone,
    assigned_on timestamp with time zone NOT NULL,
    created_by_id integer NOT NULL,
    current_branch_id integer NOT NULL,
    previous_branch_id integer NOT NULL,
    related_user_id integer NOT NULL
);


ALTER TABLE public.accounts_userdetails OWNER TO djangoappguy;

--
-- Name: accounts_userdetails_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.accounts_userdetails_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_userdetails_id_seq OWNER TO djangoappguy;

--
-- Name: accounts_userdetails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.accounts_userdetails_id_seq OWNED BY public.accounts_userdetails.id;


--
-- Name: accounts_userroleschangetracker; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.accounts_userroleschangetracker (
    id integer NOT NULL,
    changed_roles text,
    date_changed timestamp with time zone NOT NULL,
    related_role_id integer NOT NULL
);


ALTER TABLE public.accounts_userroleschangetracker OWNER TO djangoappguy;

--
-- Name: accounts_userroleschangetracker_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.accounts_userroleschangetracker_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_userroleschangetracker_id_seq OWNER TO djangoappguy;

--
-- Name: accounts_userroleschangetracker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.accounts_userroleschangetracker_id_seq OWNED BY public.accounts_userroleschangetracker.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO djangoappguy;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO djangoappguy;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO djangoappguy;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO djangoappguy;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO djangoappguy;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO djangoappguy;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO djangoappguy;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO djangoappguy;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO djangoappguy;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO djangoappguy;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO djangoappguy;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO djangoappguy;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO djangoappguy;

--
-- Name: ledgers_categoryclass; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.ledgers_categoryclass (
    id integer NOT NULL,
    category_name character varying(250) NOT NULL,
    category_class character varying(250) NOT NULL,
    date_created timestamp with time zone NOT NULL
);


ALTER TABLE public.ledgers_categoryclass OWNER TO djangoappguy;

--
-- Name: ledgers_categoryclass_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.ledgers_categoryclass_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_categoryclass_id_seq OWNER TO djangoappguy;

--
-- Name: ledgers_categoryclass_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.ledgers_categoryclass_id_seq OWNED BY public.ledgers_categoryclass.id;


--
-- Name: ledgers_chartlevelledger; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.ledgers_chartlevelledger (
    id integer NOT NULL,
    ledger_entry_type character varying(250) NOT NULL,
    amount numeric(20,2) NOT NULL,
    date_entered timestamp with time zone NOT NULL,
    related_chart_transaction_id integer NOT NULL
);


ALTER TABLE public.ledgers_chartlevelledger OWNER TO djangoappguy;

--
-- Name: ledgers_chartlevelledger_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.ledgers_chartlevelledger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_chartlevelledger_id_seq OWNER TO djangoappguy;

--
-- Name: ledgers_chartlevelledger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.ledgers_chartlevelledger_id_seq OWNED BY public.ledgers_chartlevelledger.id;


--
-- Name: ledgers_chartofaccounts; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.ledgers_chartofaccounts (
    id integer NOT NULL,
    account_code character varying(250) NOT NULL,
    account_name character varying(250) NOT NULL,
    chart_level integer NOT NULL,
    is_final_level boolean NOT NULL,
    date_created timestamp with time zone NOT NULL,
    related_category_id integer NOT NULL
);


ALTER TABLE public.ledgers_chartofaccounts OWNER TO djangoappguy;

--
-- Name: ledgers_chartofaccounts_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.ledgers_chartofaccounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_chartofaccounts_id_seq OWNER TO djangoappguy;

--
-- Name: ledgers_chartofaccounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.ledgers_chartofaccounts_id_seq OWNED BY public.ledgers_chartofaccounts.id;


--
-- Name: ledgers_endofperiod; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.ledgers_endofperiod (
    id integer NOT NULL,
    period_start timestamp with time zone NOT NULL,
    period_end timestamp with time zone NOT NULL,
    period_ended_by_id integer NOT NULL,
    period_started_by_id integer NOT NULL
);


ALTER TABLE public.ledgers_endofperiod OWNER TO djangoappguy;

--
-- Name: ledgers_endofperiod_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.ledgers_endofperiod_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_endofperiod_id_seq OWNER TO djangoappguy;

--
-- Name: ledgers_endofperiod_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.ledgers_endofperiod_id_seq OWNED BY public.ledgers_endofperiod.id;


--
-- Name: ledgers_productledger; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.ledgers_productledger (
    id integer NOT NULL,
    ledger_entry_type character varying(250) NOT NULL,
    amount numeric(20,2) NOT NULL,
    date_entered timestamp with time zone NOT NULL,
    related_ledger_transaction_id integer NOT NULL
);


ALTER TABLE public.ledgers_productledger OWNER TO djangoappguy;

--
-- Name: ledgers_productledger_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.ledgers_productledger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_productledger_id_seq OWNER TO djangoappguy;

--
-- Name: ledgers_productledger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.ledgers_productledger_id_seq OWNED BY public.ledgers_productledger.id;


--
-- Name: ledgers_transaction; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.ledgers_transaction (
    id integer NOT NULL,
    transaction_id character varying(250) NOT NULL,
    transaction_description character varying(250),
    transaction_category integer NOT NULL,
    transaction_amount numeric(20,2) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    transaction_cleared_by_id integer NOT NULL,
    transaction_completed_by_id integer NOT NULL,
    transaction_related_product_id integer NOT NULL
);


ALTER TABLE public.ledgers_transaction OWNER TO djangoappguy;

--
-- Name: ledgers_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.ledgers_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_transaction_id_seq OWNER TO djangoappguy;

--
-- Name: ledgers_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.ledgers_transaction_id_seq OWNED BY public.ledgers_transaction.id;


--
-- Name: ledgers_trialbalanceledger; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.ledgers_trialbalanceledger (
    id integer NOT NULL,
    ledger_entry_type character varying(250) NOT NULL,
    amount numeric(20,2) NOT NULL,
    date_entered timestamp with time zone NOT NULL,
    related_trial_transaction_id integer NOT NULL
);


ALTER TABLE public.ledgers_trialbalanceledger OWNER TO djangoappguy;

--
-- Name: ledgers_trialbalanceledger_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.ledgers_trialbalanceledger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_trialbalanceledger_id_seq OWNER TO djangoappguy;

--
-- Name: ledgers_trialbalanceledger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.ledgers_trialbalanceledger_id_seq OWNED BY public.ledgers_trialbalanceledger.id;


--
-- Name: products_loans; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_loans (
    id integer NOT NULL,
    loan_amount numeric(20,2) NOT NULL,
    status integer NOT NULL,
    date_cleared timestamp with time zone,
    date_declined timestamp with time zone,
    date_requested timestamp with time zone NOT NULL,
    loan_cleared_by_id integer,
    loan_received_by_id integer NOT NULL,
    related_loan_subscription_id integer NOT NULL,
    payment_duration integer NOT NULL,
    payment_period character varying(10) NOT NULL,
    related_loan_type_loans_id integer NOT NULL
);


ALTER TABLE public.products_loans OWNER TO djangoappguy;

--
-- Name: products_loans_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_loans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_loans_id_seq OWNER TO djangoappguy;

--
-- Name: products_loans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_loans_id_seq OWNED BY public.products_loans.id;


--
-- Name: products_loansdisbursementfeeslevied; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_loansdisbursementfeeslevied (
    id integer NOT NULL,
    amount_levied numeric(20,2) NOT NULL,
    date_levied timestamp with time zone NOT NULL,
    disbursement_related_fee_id integer NOT NULL,
    disbursement_related_loan_id integer NOT NULL
);


ALTER TABLE public.products_loansdisbursementfeeslevied OWNER TO djangoappguy;

--
-- Name: products_loansdisbursementfeeslevied_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_loansdisbursementfeeslevied_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_loansdisbursementfeeslevied_id_seq OWNER TO djangoappguy;

--
-- Name: products_loansdisbursementfeeslevied_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_loansdisbursementfeeslevied_id_seq OWNED BY public.products_loansdisbursementfeeslevied.id;


--
-- Name: products_loansdisbursements; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_loansdisbursements (
    id integer NOT NULL,
    amount_disbursed numeric(20,2) NOT NULL,
    disbursement_method integer NOT NULL,
    loan_status integer NOT NULL,
    disbursed_on timestamp with time zone NOT NULL,
    date_completed timestamp with time zone,
    date_extended timestamp with time zone,
    date_written_off timestamp with time zone,
    disbursed_by_id integer NOT NULL,
    disbursement_cleared_by_id integer NOT NULL,
    related_loan_disbursement_id integer NOT NULL
);


ALTER TABLE public.products_loansdisbursements OWNER TO djangoappguy;

--
-- Name: products_loansdisbursements_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_loansdisbursements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_loansdisbursements_id_seq OWNER TO djangoappguy;

--
-- Name: products_loansdisbursements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_loansdisbursements_id_seq OWNED BY public.products_loansdisbursements.id;


--
-- Name: products_loansguarantors; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_loansguarantors (
    id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    guarantor_id integer NOT NULL,
    related_loan_guaranted_id integer NOT NULL
);


ALTER TABLE public.products_loansguarantors OWNER TO djangoappguy;

--
-- Name: products_loansguarantors_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_loansguarantors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_loansguarantors_id_seq OWNER TO djangoappguy;

--
-- Name: products_loansguarantors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_loansguarantors_id_seq OWNED BY public.products_loansguarantors.id;


--
-- Name: products_loansrepayments; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_loansrepayments (
    id integer NOT NULL,
    amount_paid numeric(20,2) NOT NULL,
    payment_method integer NOT NULL,
    paid_on timestamp with time zone NOT NULL,
    related_loan_repayment_id integer NOT NULL
);


ALTER TABLE public.products_loansrepayments OWNER TO djangoappguy;

--
-- Name: products_loansrepayments_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_loansrepayments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_loansrepayments_id_seq OWNER TO djangoappguy;

--
-- Name: products_loansrepayments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_loansrepayments_id_seq OWNED BY public.products_loansrepayments.id;


--
-- Name: products_loansrepaymentsfeeslevied; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_loansrepaymentsfeeslevied (
    id integer NOT NULL,
    amount_levied numeric(20,2) NOT NULL,
    date_levied timestamp with time zone NOT NULL,
    related_repayment_fee_id integer NOT NULL
);


ALTER TABLE public.products_loansrepaymentsfeeslevied OWNER TO djangoappguy;

--
-- Name: products_loansrepaymentsfeeslevied_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_loansrepaymentsfeeslevied_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_loansrepaymentsfeeslevied_id_seq OWNER TO djangoappguy;

--
-- Name: products_loansrepaymentsfeeslevied_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_loansrepaymentsfeeslevied_id_seq OWNED BY public.products_loansrepaymentsfeeslevied.id;


--
-- Name: products_loantype; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_loantype (
    id integer NOT NULL,
    loan_type_name character varying(250) NOT NULL,
    loan_type_description text NOT NULL,
    loan_type_code character varying(250) NOT NULL,
    loan_type_added_on timestamp with time zone NOT NULL,
    loan_type_added_by_id integer NOT NULL,
    related_product_id integer NOT NULL
);


ALTER TABLE public.products_loantype OWNER TO djangoappguy;

--
-- Name: products_loantype_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_loantype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_loantype_id_seq OWNER TO djangoappguy;

--
-- Name: products_loantype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_loantype_id_seq OWNED BY public.products_loantype.id;


--
-- Name: products_loantypefeesapplicable; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_loantypefeesapplicable (
    id integer NOT NULL,
    related_loan_fee_category integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    added_by_id integer NOT NULL,
    related_loan_type_id integer NOT NULL,
    amount numeric(20,2) NOT NULL
);


ALTER TABLE public.products_loantypefeesapplicable OWNER TO djangoappguy;

--
-- Name: products_loantypefeesapplicable_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_loantypefeesapplicable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_loantypefeesapplicable_id_seq OWNER TO djangoappguy;

--
-- Name: products_loantypefeesapplicable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_loantypefeesapplicable_id_seq OWNED BY public.products_loantypefeesapplicable.id;


--
-- Name: products_product; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_product (
    id integer NOT NULL,
    product_name character varying(250) NOT NULL,
    product_description character varying(250) NOT NULL,
    product_category integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    created_by_id integer NOT NULL,
    product_code character varying(250)
);


ALTER TABLE public.products_product OWNER TO djangoappguy;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_product_id_seq OWNER TO djangoappguy;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products_product.id;


--
-- Name: products_productfeeslevied; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_productfeeslevied (
    id integer NOT NULL,
    fee_category integer NOT NULL,
    percentage_levied numeric(20,2) NOT NULL,
    fee_levied numeric(20,2) NOT NULL,
    frequency_levied integer NOT NULL,
    added_on timestamp with time zone NOT NULL,
    fees_added_by_id integer NOT NULL,
    related_product_fees_id integer NOT NULL
);


ALTER TABLE public.products_productfeeslevied OWNER TO djangoappguy;

--
-- Name: products_productfeeslevied_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_productfeeslevied_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_productfeeslevied_id_seq OWNER TO djangoappguy;

--
-- Name: products_productfeeslevied_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_productfeeslevied_id_seq OWNED BY public.products_productfeeslevied.id;


--
-- Name: products_productsubscriptions; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_productsubscriptions (
    id integer NOT NULL,
    account_number character varying(25) NOT NULL,
    subscription_status boolean NOT NULL,
    date_subscribed timestamp with time zone NOT NULL,
    added_by_id integer NOT NULL,
    related_client_subscription_id integer NOT NULL,
    related_product_subscription_id integer NOT NULL
);


ALTER TABLE public.products_productsubscriptions OWNER TO djangoappguy;

--
-- Name: products_productsubscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_productsubscriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_productsubscriptions_id_seq OWNER TO djangoappguy;

--
-- Name: products_productsubscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_productsubscriptions_id_seq OWNED BY public.products_productsubscriptions.id;


--
-- Name: products_savings; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_savings (
    id integer NOT NULL,
    account_balance numeric(20,2) NOT NULL,
    account_status integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    related_savings_subscription_id integer NOT NULL
);


ALTER TABLE public.products_savings OWNER TO djangoappguy;

--
-- Name: products_savings_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_savings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_savings_id_seq OWNER TO djangoappguy;

--
-- Name: products_savings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_savings_id_seq OWNED BY public.products_savings.id;


--
-- Name: products_savingsdeposits; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_savingsdeposits (
    id integer NOT NULL,
    amount_deposited numeric(20,2) NOT NULL,
    fee_charged numeric(20,2) NOT NULL,
    deposit_method integer NOT NULL,
    date_deposited timestamp with time zone NOT NULL,
    deposit_cleared_by_id integer NOT NULL,
    deposit_received_by_id integer NOT NULL,
    related_savings_account_id integer NOT NULL
);


ALTER TABLE public.products_savingsdeposits OWNER TO djangoappguy;

--
-- Name: products_savingsdeposits_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_savingsdeposits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_savingsdeposits_id_seq OWNER TO djangoappguy;

--
-- Name: products_savingsdeposits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_savingsdeposits_id_seq OWNED BY public.products_savingsdeposits.id;


--
-- Name: products_savingswithdrawal; Type: TABLE; Schema: public; Owner: djangoappguy
--

CREATE TABLE public.products_savingswithdrawal (
    id integer NOT NULL,
    amount_withdrawn numeric(20,2) NOT NULL,
    fee_charged numeric(20,2) NOT NULL,
    withdraw_method integer NOT NULL,
    withdraw_comment text,
    date_withdrawn timestamp with time zone NOT NULL,
    related_savings_account_withdrawal_id integer NOT NULL,
    withdrawal_authorized_by_id integer NOT NULL,
    withdrawal_cleared_by_id integer NOT NULL
);


ALTER TABLE public.products_savingswithdrawal OWNER TO djangoappguy;

--
-- Name: products_savingswithdrawal_id_seq; Type: SEQUENCE; Schema: public; Owner: djangoappguy
--

CREATE SEQUENCE public.products_savingswithdrawal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_savingswithdrawal_id_seq OWNER TO djangoappguy;

--
-- Name: products_savingswithdrawal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: djangoappguy
--

ALTER SEQUENCE public.products_savingswithdrawal_id_seq OWNED BY public.products_savingswithdrawal.id;


--
-- Name: accounts_branch id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_branch ALTER COLUMN id SET DEFAULT nextval('public.accounts_branch_id_seq'::regclass);


--
-- Name: accounts_client id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_client ALTER COLUMN id SET DEFAULT nextval('public.accounts_client_id_seq'::regclass);


--
-- Name: accounts_clientbackgroundinformation id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_clientbackgroundinformation ALTER COLUMN id SET DEFAULT nextval('public.accounts_clientbackgroundinformation_id_seq'::regclass);


--
-- Name: accounts_group id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_group ALTER COLUMN id SET DEFAULT nextval('public.accounts_group_id_seq'::regclass);


--
-- Name: accounts_groupclients id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_groupclients ALTER COLUMN id SET DEFAULT nextval('public.accounts_groupclients_id_seq'::regclass);


--
-- Name: accounts_notificationmessages id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_notificationmessages ALTER COLUMN id SET DEFAULT nextval('public.accounts_notificationmessages_id_seq'::regclass);


--
-- Name: accounts_roles id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_roles ALTER COLUMN id SET DEFAULT nextval('public.accounts_roles_id_seq'::regclass);


--
-- Name: accounts_user id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_id_seq'::regclass);


--
-- Name: accounts_user_groups id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user_groups ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_groups_id_seq'::regclass);


--
-- Name: accounts_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_user_permissions_id_seq'::regclass);


--
-- Name: accounts_userdetails id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_userdetails ALTER COLUMN id SET DEFAULT nextval('public.accounts_userdetails_id_seq'::regclass);


--
-- Name: accounts_userroleschangetracker id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_userroleschangetracker ALTER COLUMN id SET DEFAULT nextval('public.accounts_userroleschangetracker_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: ledgers_categoryclass id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_categoryclass ALTER COLUMN id SET DEFAULT nextval('public.ledgers_categoryclass_id_seq'::regclass);


--
-- Name: ledgers_chartlevelledger id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_chartlevelledger ALTER COLUMN id SET DEFAULT nextval('public.ledgers_chartlevelledger_id_seq'::regclass);


--
-- Name: ledgers_chartofaccounts id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_chartofaccounts ALTER COLUMN id SET DEFAULT nextval('public.ledgers_chartofaccounts_id_seq'::regclass);


--
-- Name: ledgers_endofperiod id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_endofperiod ALTER COLUMN id SET DEFAULT nextval('public.ledgers_endofperiod_id_seq'::regclass);


--
-- Name: ledgers_productledger id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_productledger ALTER COLUMN id SET DEFAULT nextval('public.ledgers_productledger_id_seq'::regclass);


--
-- Name: ledgers_transaction id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_transaction ALTER COLUMN id SET DEFAULT nextval('public.ledgers_transaction_id_seq'::regclass);


--
-- Name: ledgers_trialbalanceledger id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_trialbalanceledger ALTER COLUMN id SET DEFAULT nextval('public.ledgers_trialbalanceledger_id_seq'::regclass);


--
-- Name: products_loans id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loans ALTER COLUMN id SET DEFAULT nextval('public.products_loans_id_seq'::regclass);


--
-- Name: products_loansdisbursementfeeslevied id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansdisbursementfeeslevied ALTER COLUMN id SET DEFAULT nextval('public.products_loansdisbursementfeeslevied_id_seq'::regclass);


--
-- Name: products_loansdisbursements id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansdisbursements ALTER COLUMN id SET DEFAULT nextval('public.products_loansdisbursements_id_seq'::regclass);


--
-- Name: products_loansguarantors id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansguarantors ALTER COLUMN id SET DEFAULT nextval('public.products_loansguarantors_id_seq'::regclass);


--
-- Name: products_loansrepayments id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansrepayments ALTER COLUMN id SET DEFAULT nextval('public.products_loansrepayments_id_seq'::regclass);


--
-- Name: products_loansrepaymentsfeeslevied id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansrepaymentsfeeslevied ALTER COLUMN id SET DEFAULT nextval('public.products_loansrepaymentsfeeslevied_id_seq'::regclass);


--
-- Name: products_loantype id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loantype ALTER COLUMN id SET DEFAULT nextval('public.products_loantype_id_seq'::regclass);


--
-- Name: products_loantypefeesapplicable id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loantypefeesapplicable ALTER COLUMN id SET DEFAULT nextval('public.products_loantypefeesapplicable_id_seq'::regclass);


--
-- Name: products_product id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_product ALTER COLUMN id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Name: products_productfeeslevied id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_productfeeslevied ALTER COLUMN id SET DEFAULT nextval('public.products_productfeeslevied_id_seq'::regclass);


--
-- Name: products_productsubscriptions id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_productsubscriptions ALTER COLUMN id SET DEFAULT nextval('public.products_productsubscriptions_id_seq'::regclass);


--
-- Name: products_savings id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savings ALTER COLUMN id SET DEFAULT nextval('public.products_savings_id_seq'::regclass);


--
-- Name: products_savingsdeposits id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savingsdeposits ALTER COLUMN id SET DEFAULT nextval('public.products_savingsdeposits_id_seq'::regclass);


--
-- Name: products_savingswithdrawal id; Type: DEFAULT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savingswithdrawal ALTER COLUMN id SET DEFAULT nextval('public.products_savingswithdrawal_id_seq'::regclass);


--
-- Data for Name: accounts_branch; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.accounts_branch (id, branch_name, branch_location, branch_description, created_on, created_by_id, status) FROM stdin;
1	Entebbe	Entebbe	This is the main Branch	2020-01-20 20:37:30.898466+03	2	t
2	Kampala	Kampala	This branch is bloody	2020-01-20 21:48:25.530646+03	2	t
\.


--
-- Data for Name: accounts_client; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.accounts_client (id, client_type, registration_date, sex, address, area_parish, area_village, area_county, area_subcounty, area_district, bank_verification_no, national_id_number, signature_mandate, added_on, added_by_id, client_branch_id, related_user_id, signatory_loans_officer_id, signatory_sales_officer_id, signatory_savings_officer_id, client_account_number, status) FROM stdin;
1	1	2000-02-02	M	Kampala	Makindye	Luwafu	Makerere	Kyadondo	Kampala	0987654321	NIN12345678	Credible client	2020-01-21 06:59:23.10197+03	2	2	9	2	2	2	\N	t
2	1	2000-02-02	M	Kampala	Makindye	Luwafu	Makerere	Kyadondo	Kampala	0987654321	NIN12345678	Credible client	2020-02-18 18:58:49.309275+03	2	2	14	2	2	2	\N	t
3	1	2000-02-02	M	Kampala	Makindye	Luwafu	Makerere	Kyadondo	Kampala	0987654321	NIN12345678	Credible client	2020-02-18 18:59:33.117523+03	2	2	15	2	2	2	\N	t
4	1	2000-02-02	M	Kampala	Makindye	Luwafu	Makerere	Kyadondo	Kampala	0987654321	NIN12345678	Credible client	2020-02-18 19:00:46.905261+03	2	2	16	2	2	2	\N	t
5	1	2000-02-02	M	Kampala	Makindye	Luwafu	Makerere	Kyadondo	Kampala	0987654321	NIN12345678	Credible client	2020-02-18 19:01:16.805109+03	2	2	17	2	2	2	\N	t
6	1	2000-02-02	M	Kampala	Makindye	Luwafu	Makerere	Kyadondo	Kampala	0987654321	NIN12345678	Credible client	2020-02-18 19:03:49.75794+03	2	2	18	2	2	2	\N	t
7	1	2000-02-02	M	Kampala	Makindye	Luwafu	Makerere	Kyadondo	Kampala	0987654321	NIN12345678	Credible client	2020-02-18 19:04:46.533649+03	2	2	19	2	2	2	\N	t
8	1	2000-02-02	M	Kampala	Makindye	Luwafu	Makerere	Kyadondo	Kampala	0987654321	NIN12345678	Credible client	2020-02-18 19:05:58.704262+03	2	2	20	2	2	2	\N	t
9	1	2000-02-02	M	Kampala	Makindye	Luwafu	Makerere	Kyadondo	Kampala	0987654321	NIN12345678	Credible client	2020-02-18 19:07:22.530129+03	2	2	21	2	2	2	\N	t
10	1	2000-02-02	M	Kampala	Makindye	Luwafu	Makerere	Kyadondo	Kampala	0987654321	NIN12345678	Credible client	2020-02-18 19:07:25.248771+03	2	2	22	2	2	2	FAL0999810GAH	t
11	1	2000-02-02	M	Kampala	Makindye	Luwafu	Makerere	Kyadondo	Kampala	0987654321	NIN12345678	Credible client	2020-02-20 15:21:29.22659+03	1	2	23	2	2	2	FAL75314140GAH	t
\.


--
-- Data for Name: accounts_clientbackgroundinformation; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.accounts_clientbackgroundinformation (id, outstanding_portfolio, portfolio_at_risk, operating_cost_ratio, debt_equity_ratio, operating_self_sufficiency, related_client_id) FROM stdin;
\.


--
-- Data for Name: accounts_group; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.accounts_group (id, group_name, created_on, related_branch_id, group_type, status) FROM stdin;
\.


--
-- Data for Name: accounts_groupclients; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.accounts_groupclients (id, added_on, related_client_id, related_group_id, status) FROM stdin;
\.


--
-- Data for Name: accounts_notificationmessages; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.accounts_notificationmessages (id, message, unread, "timestamp", object_id, content_type_id, recipient_id, title) FROM stdin;
1	There as been a new SavingsDeposits added recently with fee 0.00	t	2022-11-02 23:27:35.858221+03	1	21	\N	New SavingsDeposits Created
\.


--
-- Data for Name: accounts_roles; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.accounts_roles (id, can_add_user, can_only_list_users, can_manage_users, can_add_products, can_only_list_products, can_manage_products, can_add_savings, can_only_list_savings, can_manage_savings, can_add_loan_types, can_only_list_loan_types, can_manage_loan_types, can_add_loan_request, can_only_list_loan_requests, can_manage_loan_requests, related_user_id) FROM stdin;
1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	1
\.


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.accounts_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, phone_number, status) FROM stdin;
17	default123	\N	f	CLT7845582	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-02-18 19:01:16.79173+03	256780820744	t
20	default123	\N	f	CLT6362641	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-02-18 19:05:58.688804+03	256780820744	t
21	default123	\N	f	CLT2579362	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-02-18 19:07:22.519273+03	256780820744	t
22	default123	\N	f	CLT9547650	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-02-18 19:07:25.23908+03	256780820744	t
23	default123	\N	f	CLT722969	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-02-20 15:21:29.216291+03	256780820744	t
24	pbkdf2_sha256$180000$13brjO2bzp8y$mo3MRA1wcTSQr/jH2zbmjjgPBq8TwxCGmElfYQWeR2k=	2020-07-30 23:46:39.45591+03	f	Newuser	Kapson	Allan	kapsonkatongole@gmail.com	f	t	2020-07-30 23:45:57.623652+03	256780820744	t
25	12345657866	\N	f	roler	Allan	Roler	roler@gmail.com	f	t	2020-09-09 06:15:21.02487+03	098765456	t
26	12345657866	\N	f	roler2	Allan	Roler	roler@gmail.com	f	t	2020-09-09 06:20:27.196429+03	098765456	t
27	12345657866	\N	f	roler3	Allan	Roler	roler@gmail.com	f	t	2020-09-09 06:25:37.889971+03	098765456	t
3	default123	\N	f	A002	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-01-21 06:52:28.335533+03	256780820744	t
4	default123	\N	f	A003	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-01-21 06:54:37.407883+03	256780820744	t
5	default123	\N	f	A005	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-01-21 06:56:16.195461+03	256780820744	t
6	default123	\N	f	A007	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-01-21 06:57:28.368979+03	256780820744	t
7	default123	\N	f	A008	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-01-21 06:58:01.592062+03	256780820744	t
8	default123	\N	f	A009	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-01-21 06:58:40.091278+03	256780820744	t
9	default123	\N	f	A010	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-01-21 06:59:23.091681+03	256780820744	t
10	hall65536	\N	f	Kapson2	Kapson	Allan	kapsonkatongole@gmail.com	f	t	2020-01-21 08:01:29.913386+03	256780820744	t
11	hall65536	\N	f	Kapson22	Kapson	Allan	kapsonkatongole@gmail.com	f	t	2020-01-21 08:01:53.083736+03	256780820744	t
12	hall65536	\N	f	Kapson222	Kapson	Allan	kapsonkatongole@gmail.com	f	t	2020-01-21 08:02:18.164292+03	256780820744	t
13	hall65536	\N	f	Kapson2221	Kapson	Allan	kapsonkatongole@gmail.com	f	t	2020-01-21 08:03:39.290633+03	256780820744	t
2	pbkdf2_sha256$180000$YZxIeHsMXRZE$seOgvcUpVDcPaWhN3P04qKTfmBdU8We8O26RW3HvP1A=	2020-02-13 13:06:10.589714+03	f	kapson	Katongole	Allan	kapsonkatongole@gmail.com	f	t	2020-01-20 20:34:41+03	256780820744	t
14	default123	\N	f	CLT8905729	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-02-18 18:58:49.297149+03	256780820744	t
15	default123	\N	f	CLT2042167	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-02-18 18:59:33.10811+03	256780820744	t
16	default123	\N	f	CLT1609906	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-02-18 19:00:46.896088+03	256780820744	t
18	default123	\N	f	CLT4640039	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-02-18 19:03:49.74588+03	256780820744	t
19	default123	\N	f	CLT9332901	Allan	Katongole	kapsonkatongole@gmail.com	f	t	2020-02-18 19:04:46.523287+03	256780820744	t
1	pbkdf2_sha256$180000$EdDYQvkbHDQu$h4qL/L+yJKUkiwHzRsswnlHdwyfJQKdDcSGlZZr4pnI=	2022-11-02 22:15:03.293761+03	t	Allan			kapsonkatongole@gmail.com	t	t	2022-11-02 12:10:49.553934+03		t
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: accounts_userdetails; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.accounts_userdetails (id, role, role_description, transfered_on, assigned_on, created_by_id, current_branch_id, previous_branch_id, related_user_id) FROM stdin;
1	1	Hard guy hard guy	2020-01-20 20:38:06+03	2020-01-20 20:38:08.063918+03	1	1	1	2
3	2	This guy can do basic things like adding users.	\N	2020-01-21 08:03:39.298463+03	2	2	2	13
4	2	This guy can do basic things like adding users.	\N	2020-07-30 23:45:57.73295+03	1	2	2	24
5	Wanainchi	This role does somethings	\N	2020-09-09 06:15:21.03747+03	1	1	1	25
6	Wanainchi	This role does somethings	\N	2020-09-09 06:20:27.204662+03	1	1	1	26
7	Wanainchi	This role does somethings	\N	2020-09-09 06:25:37.897978+03	1	1	1	27
\.


--
-- Data for Name: accounts_userroleschangetracker; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.accounts_userroleschangetracker (id, changed_roles, date_changed, related_role_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_user
22	Can change user	6	change_user
23	Can delete user	6	delete_user
24	Can view user	6	view_user
25	Can add branch	7	add_branch
26	Can change branch	7	change_branch
27	Can delete branch	7	delete_branch
28	Can view branch	7	view_branch
29	Can add client	8	add_client
30	Can change client	8	change_client
31	Can delete client	8	delete_client
32	Can view client	8	view_client
33	Can add group	9	add_group
34	Can change group	9	change_group
35	Can delete group	9	delete_group
36	Can view group	9	view_group
37	Can add user details	10	add_userdetails
38	Can change user details	10	change_userdetails
39	Can delete user details	10	delete_userdetails
40	Can view user details	10	view_userdetails
41	Can add group clients	11	add_groupclients
42	Can change group clients	11	change_groupclients
43	Can delete group clients	11	delete_groupclients
44	Can view group clients	11	view_groupclients
45	Can add client background information	12	add_clientbackgroundinformation
46	Can change client background information	12	change_clientbackgroundinformation
47	Can delete client background information	12	delete_clientbackgroundinformation
48	Can view client background information	12	view_clientbackgroundinformation
49	Can add notification messages	13	add_notificationmessages
50	Can change notification messages	13	change_notificationmessages
51	Can delete notification messages	13	delete_notificationmessages
52	Can view notification messages	13	view_notificationmessages
53	Can add roles	14	add_roles
54	Can change roles	14	change_roles
55	Can delete roles	14	delete_roles
56	Can view roles	14	view_roles
57	Can add user roles change tracker	15	add_userroleschangetracker
58	Can change user roles change tracker	15	change_userroleschangetracker
59	Can delete user roles change tracker	15	delete_userroleschangetracker
60	Can view user roles change tracker	15	view_userroleschangetracker
61	Can add loans	16	add_loans
62	Can change loans	16	change_loans
63	Can delete loans	16	delete_loans
64	Can view loans	16	view_loans
65	Can add product	17	add_product
66	Can change product	17	change_product
67	Can delete product	17	delete_product
68	Can view product	17	view_product
69	Can add product subscriptions	18	add_productsubscriptions
70	Can change product subscriptions	18	change_productsubscriptions
71	Can delete product subscriptions	18	delete_productsubscriptions
72	Can view product subscriptions	18	view_productsubscriptions
73	Can add savings	19	add_savings
74	Can change savings	19	change_savings
75	Can delete savings	19	delete_savings
76	Can view savings	19	view_savings
77	Can add savings withdrawal	20	add_savingswithdrawal
78	Can change savings withdrawal	20	change_savingswithdrawal
79	Can delete savings withdrawal	20	delete_savingswithdrawal
80	Can view savings withdrawal	20	view_savingswithdrawal
81	Can add savings deposits	21	add_savingsdeposits
82	Can change savings deposits	21	change_savingsdeposits
83	Can delete savings deposits	21	delete_savingsdeposits
84	Can view savings deposits	21	view_savingsdeposits
85	Can add product fees levied	22	add_productfeeslevied
86	Can change product fees levied	22	change_productfeeslevied
87	Can delete product fees levied	22	delete_productfeeslevied
88	Can view product fees levied	22	view_productfeeslevied
89	Can add loans repayments fees levied	23	add_loansrepaymentsfeeslevied
90	Can change loans repayments fees levied	23	change_loansrepaymentsfeeslevied
91	Can delete loans repayments fees levied	23	delete_loansrepaymentsfeeslevied
92	Can view loans repayments fees levied	23	view_loansrepaymentsfeeslevied
93	Can add loans repayments	24	add_loansrepayments
94	Can change loans repayments	24	change_loansrepayments
95	Can delete loans repayments	24	delete_loansrepayments
96	Can view loans repayments	24	view_loansrepayments
97	Can add loans guarantors	25	add_loansguarantors
98	Can change loans guarantors	25	change_loansguarantors
99	Can delete loans guarantors	25	delete_loansguarantors
100	Can view loans guarantors	25	view_loansguarantors
101	Can add loans disbursements	26	add_loansdisbursements
102	Can change loans disbursements	26	change_loansdisbursements
103	Can delete loans disbursements	26	delete_loansdisbursements
104	Can view loans disbursements	26	view_loansdisbursements
105	Can add loans disbursement fees levied	27	add_loansdisbursementfeeslevied
106	Can change loans disbursement fees levied	27	change_loansdisbursementfeeslevied
107	Can delete loans disbursement fees levied	27	delete_loansdisbursementfeeslevied
108	Can view loans disbursement fees levied	27	view_loansdisbursementfeeslevied
109	Can add loan type	28	add_loantype
110	Can change loan type	28	change_loantype
111	Can delete loan type	28	delete_loantype
112	Can view loan type	28	view_loantype
113	Can add loan type fees applicable	29	add_loantypefeesapplicable
114	Can change loan type fees applicable	29	change_loantypefeesapplicable
115	Can delete loan type fees applicable	29	delete_loantypefeesapplicable
116	Can view loan type fees applicable	29	view_loantypefeesapplicable
117	Can add category class	30	add_categoryclass
118	Can change category class	30	change_categoryclass
119	Can delete category class	30	delete_categoryclass
120	Can view category class	30	view_categoryclass
121	Can add trial balance ledger	31	add_trialbalanceledger
122	Can change trial balance ledger	31	change_trialbalanceledger
123	Can delete trial balance ledger	31	delete_trialbalanceledger
124	Can view trial balance ledger	31	view_trialbalanceledger
125	Can add transaction	32	add_transaction
126	Can change transaction	32	change_transaction
127	Can delete transaction	32	delete_transaction
128	Can view transaction	32	view_transaction
129	Can add product ledger	33	add_productledger
130	Can change product ledger	33	change_productledger
131	Can delete product ledger	33	delete_productledger
132	Can view product ledger	33	view_productledger
133	Can add end of period	34	add_endofperiod
134	Can change end of period	34	change_endofperiod
135	Can delete end of period	34	delete_endofperiod
136	Can view end of period	34	view_endofperiod
137	Can add chart of accounts	35	add_chartofaccounts
138	Can change chart of accounts	35	change_chartofaccounts
139	Can delete chart of accounts	35	delete_chartofaccounts
140	Can view chart of accounts	35	view_chartofaccounts
141	Can add chart level ledger	36	add_chartlevelledger
142	Can change chart level ledger	36	change_chartlevelledger
143	Can delete chart level ledger	36	delete_chartlevelledger
144	Can view chart level ledger	36	view_chartlevelledger
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2022-11-02 22:14:54.435374+03	1	Roles object (1)	1	[{"added": {}}]	14	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	accounts	user
7	accounts	branch
8	accounts	client
9	accounts	group
10	accounts	userdetails
11	accounts	groupclients
12	accounts	clientbackgroundinformation
13	accounts	notificationmessages
14	accounts	roles
15	accounts	userroleschangetracker
16	products	loans
17	products	product
18	products	productsubscriptions
19	products	savings
20	products	savingswithdrawal
21	products	savingsdeposits
22	products	productfeeslevied
23	products	loansrepaymentsfeeslevied
24	products	loansrepayments
25	products	loansguarantors
26	products	loansdisbursements
27	products	loansdisbursementfeeslevied
28	products	loantype
29	products	loantypefeesapplicable
30	ledgers	categoryclass
31	ledgers	trialbalanceledger
32	ledgers	transaction
33	ledgers	productledger
34	ledgers	endofperiod
35	ledgers	chartofaccounts
36	ledgers	chartlevelledger
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-11-02 12:09:29.921454+03
2	contenttypes	0002_remove_content_type_name	2022-11-02 12:09:29.929092+03
3	auth	0001_initial	2022-11-02 12:09:29.96077+03
4	auth	0002_alter_permission_name_max_length	2022-11-02 12:09:29.997324+03
5	auth	0003_alter_user_email_max_length	2022-11-02 12:09:30.003551+03
6	auth	0004_alter_user_username_opts	2022-11-02 12:09:30.009545+03
7	auth	0005_alter_user_last_login_null	2022-11-02 12:09:30.015859+03
8	auth	0006_require_contenttypes_0002	2022-11-02 12:09:30.018469+03
9	auth	0007_alter_validators_add_error_messages	2022-11-02 12:09:30.024683+03
10	auth	0008_alter_user_username_max_length	2022-11-02 12:09:30.031321+03
11	auth	0009_alter_user_last_name_max_length	2022-11-02 12:09:30.037463+03
12	auth	0010_alter_group_name_max_length	2022-11-02 12:09:30.043676+03
13	auth	0011_update_proxy_permissions	2022-11-02 12:09:30.050651+03
14	accounts	0001_initial	2022-11-02 12:09:30.180804+03
15	accounts	0002_auto_20200120_1755	2022-11-02 12:09:30.328789+03
16	accounts	0003_remove_branch_branch_manager	2022-11-02 12:09:30.351688+03
17	accounts	0004_group_group_type	2022-11-02 12:09:30.363603+03
18	accounts	0005_remove_client_phone_number	2022-11-02 12:09:30.375729+03
19	accounts	0006_auto_20200121_0503	2022-11-02 12:09:30.387584+03
20	accounts	0007_client_client_account_number	2022-11-02 12:09:30.399255+03
21	accounts	0008_notificationmessages	2022-11-02 12:09:30.421632+03
22	accounts	0009_notificationmessages_title	2022-11-02 12:09:30.448656+03
23	accounts	0010_remove_notificationmessages_tilte	2022-11-02 12:09:30.461016+03
24	accounts	0011_auto_20200909_0119	2022-11-02 12:09:30.519761+03
25	accounts	0012_auto_20200909_1352	2022-11-02 12:09:30.579996+03
26	admin	0001_initial	2022-11-02 12:09:30.604126+03
27	admin	0002_logentry_remove_auto_add	2022-11-02 12:09:30.645924+03
28	admin	0003_logentry_add_action_flag_choices	2022-11-02 12:09:30.656772+03
29	products	0001_initial	2022-11-02 12:09:30.927982+03
30	ledgers	0001_initial	2022-11-02 12:09:31.195933+03
31	ledgers	0002_auto_20200218_1439	2022-11-02 12:09:31.266922+03
32	products	0002_auto_20200218_0819	2022-11-02 12:09:31.293068+03
33	products	0003_auto_20200218_0828	2022-11-02 12:09:31.343592+03
34	products	0004_product_product_code	2022-11-02 12:09:31.366255+03
35	products	0005_auto_20200630_2248	2022-11-02 12:09:31.442037+03
36	products	0006_loantype_related_product	2022-11-02 12:09:31.482893+03
37	products	0007_loantypefeesapplicable_amount	2022-11-02 12:09:31.508746+03
38	products	0008_auto_20200720_1916	2022-11-02 12:09:31.580876+03
39	products	0009_auto_20200720_1944	2022-11-02 12:09:31.601265+03
40	products	0010_auto_20200909_0117	2022-11-02 12:09:31.69323+03
41	sessions	0001_initial	2022-11-02 12:09:31.710586+03
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
utq51tlbre7np7qvfeesna7i3mwryclp	OGM5MTFhNmIxNTBiYjZjZTlhNTUwNzhkYTQ0NTZjZjE3ZTFhOTAzOTp7fQ==	2022-11-16 12:24:30.559212+03
8m5l7mxe4h8hgtrg28m2y9x4gmjndbuu	YzRhNzdhYjIyZTlkZWViMzYxYjcyODIxNjcwZWNiOTM1MGIwZTQxZTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4NTEwOGZiZTMwMTYyMTVkMjlhYjNiZWYzMTg1N2U3ZjVkYTYxODUyIn0=	2022-11-16 21:42:10.487125+03
4x44ixd868nrru1p2ycqqq1azlutk0ha	OGM5MTFhNmIxNTBiYjZjZTlhNTUwNzhkYTQ0NTZjZjE3ZTFhOTAzOTp7fQ==	2022-11-16 22:10:09.673566+03
nsg6n7qh5pc08ryqtvuxti48fyov43h3	OGM5MTFhNmIxNTBiYjZjZTlhNTUwNzhkYTQ0NTZjZjE3ZTFhOTAzOTp7fQ==	2022-11-16 22:10:11.098739+03
xl2gi0puvs5n3rsf3y5shhfm4cc68edt	OGM5MTFhNmIxNTBiYjZjZTlhNTUwNzhkYTQ0NTZjZjE3ZTFhOTAzOTp7fQ==	2022-11-16 22:10:22.934411+03
dbzorxyhkf9ugpqyb8wpf009croifwm6	YzRhNzdhYjIyZTlkZWViMzYxYjcyODIxNjcwZWNiOTM1MGIwZTQxZTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4NTEwOGZiZTMwMTYyMTVkMjlhYjNiZWYzMTg1N2U3ZjVkYTYxODUyIn0=	2022-11-16 22:15:03.314322+03
\.


--
-- Data for Name: ledgers_categoryclass; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.ledgers_categoryclass (id, category_name, category_class, date_created) FROM stdin;
\.


--
-- Data for Name: ledgers_chartlevelledger; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.ledgers_chartlevelledger (id, ledger_entry_type, amount, date_entered, related_chart_transaction_id) FROM stdin;
\.


--
-- Data for Name: ledgers_chartofaccounts; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.ledgers_chartofaccounts (id, account_code, account_name, chart_level, is_final_level, date_created, related_category_id) FROM stdin;
\.


--
-- Data for Name: ledgers_endofperiod; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.ledgers_endofperiod (id, period_start, period_end, period_ended_by_id, period_started_by_id) FROM stdin;
\.


--
-- Data for Name: ledgers_productledger; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.ledgers_productledger (id, ledger_entry_type, amount, date_entered, related_ledger_transaction_id) FROM stdin;
1	DR	100000.00	2022-11-02 23:27:35.894702+03	1
\.


--
-- Data for Name: ledgers_transaction; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.ledgers_transaction (id, transaction_id, transaction_description, transaction_category, transaction_amount, date_created, transaction_cleared_by_id, transaction_completed_by_id, transaction_related_product_id) FROM stdin;
1	7871769	\N	0	100000.00	2022-11-02 23:27:35.878605+03	1	1	21
\.


--
-- Data for Name: ledgers_trialbalanceledger; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.ledgers_trialbalanceledger (id, ledger_entry_type, amount, date_entered, related_trial_transaction_id) FROM stdin;
1	CR	100000.00	2022-11-02 23:27:35.904556+03	1
\.


--
-- Data for Name: products_loans; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_loans (id, loan_amount, status, date_cleared, date_declined, date_requested, loan_cleared_by_id, loan_received_by_id, related_loan_subscription_id, payment_duration, payment_period, related_loan_type_loans_id) FROM stdin;
\.


--
-- Data for Name: products_loansdisbursementfeeslevied; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_loansdisbursementfeeslevied (id, amount_levied, date_levied, disbursement_related_fee_id, disbursement_related_loan_id) FROM stdin;
\.


--
-- Data for Name: products_loansdisbursements; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_loansdisbursements (id, amount_disbursed, disbursement_method, loan_status, disbursed_on, date_completed, date_extended, date_written_off, disbursed_by_id, disbursement_cleared_by_id, related_loan_disbursement_id) FROM stdin;
\.


--
-- Data for Name: products_loansguarantors; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_loansguarantors (id, date_added, guarantor_id, related_loan_guaranted_id) FROM stdin;
\.


--
-- Data for Name: products_loansrepayments; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_loansrepayments (id, amount_paid, payment_method, paid_on, related_loan_repayment_id) FROM stdin;
\.


--
-- Data for Name: products_loansrepaymentsfeeslevied; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_loansrepaymentsfeeslevied (id, amount_levied, date_levied, related_repayment_fee_id) FROM stdin;
\.


--
-- Data for Name: products_loantype; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_loantype (id, loan_type_name, loan_type_description, loan_type_code, loan_type_added_on, loan_type_added_by_id, related_product_id) FROM stdin;
1	DEFAULT	Default loan type created by the system	DEF0001	2020-07-01 02:20:15.012184+03	1	8
2	DEFAULT	Default loan type created by the system	DEF0001	2020-07-01 02:21:58.23604+03	1	8
8	DEFAULT	Default loan type created by the system	DEF0001	2020-07-01 02:52:56.252648+03	1	17
9	Salary Loan	Advanced salary loan	SA0887	2020-07-01 03:48:27.260604+03	1	17
10	Salary Loan	Advanced salary loan	SA08871	2020-07-01 03:59:45.45571+03	1	17
11	Salary Loan	Advanced salary loan	SA0887124	2020-07-01 04:33:33.147934+03	1	17
\.


--
-- Data for Name: products_loantypefeesapplicable; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_loantypefeesapplicable (id, related_loan_fee_category, date_added, added_by_id, related_loan_type_id, amount) FROM stdin;
1	1	2020-07-01 04:33:33.157321+03	1	11	0.00
2	0	2020-07-01 04:33:33.168125+03	1	11	5000.00
\.


--
-- Data for Name: products_product; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_product (id, product_name, product_description, product_category, date_created, created_by_id, product_code) FROM stdin;
1	Sassula	Savings product for the sacco	0	2020-01-30 22:57:25.749167+03	2	\N
2	Wewole	Loans product for the sacco	1	2020-01-30 22:57:55.169948+03	2	\N
3	Twasasudde	Savings product for the sacco	0	2020-01-31 02:46:21.370726+03	2	\N
4	Wewole	Loans product for the sacco	0	2020-02-20 14:50:39.72506+03	1	\N
5	Wewole	Loans product for the sacco	0	2020-02-20 14:51:27.00205+03	1	S00045
6	Wewole	Loans product for the sacco	0	2020-02-20 15:05:55.930543+03	1	S000456
7	Wewole	Loans product for the sacco	1	2020-07-01 02:18:05.045578+03	1	S00045678
8	Wewole	Loans product for the sacco	1	2020-07-01 02:21:58.228335+03	1	S000
9	Wewole	Loans product for the sacco	1	2020-07-01 02:43:37.48653+03	1	S0001
10	Wewole	Loans product for the sacco	1	2020-07-01 02:44:49.434517+03	1	S00012
11	Wewole	Loans product for the sacco	1	2020-07-01 02:46:36.593808+03	1	S000123
12	Wewole	Loans product for the sacco	1	2020-07-01 02:48:31.928361+03	1	S0001234
13	Wewole	Loans product for the sacco	1	2020-07-01 02:50:21.945632+03	1	S00012345
14	Wewole	Loans product for the sacco	1	2020-07-01 02:50:43.939104+03	1	S000123456
15	Wewole	Loans product for the sacco	1	2020-07-01 02:51:18.181554+03	1	S0001234567
16	Wewole	Loans product for the sacco	1	2020-07-01 02:52:19.832615+03	1	S00012345678
17	Wewole	Loans product for the sacco	1	2020-07-01 02:52:56.239915+03	1	S000123456789
\.


--
-- Data for Name: products_productfeeslevied; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_productfeeslevied (id, fee_category, percentage_levied, fee_levied, frequency_levied, added_on, fees_added_by_id, related_product_fees_id) FROM stdin;
2	0	10.00	0.00	1	2020-01-31 00:00:39.012522+03	2	1
3	0	10.00	0.00	1	2020-01-31 00:02:11.835648+03	2	1
\.


--
-- Data for Name: products_productsubscriptions; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_productsubscriptions (id, account_number, subscription_status, date_subscribed, added_by_id, related_client_subscription_id, related_product_subscription_id) FROM stdin;
19	ACM21009	t	2020-02-13 13:10:33.307177+03	2	1	2
20	ACM59749	t	2020-02-13 13:10:47.100849+03	2	1	3
21	ACM38498	t	2020-02-20 15:28:41.770866+03	1	11	3
22	ACM22592	t	2020-02-20 15:28:51.831479+03	1	11	2
23	ACM96468	t	2020-02-20 15:29:08.677697+03	1	11	1
\.


--
-- Data for Name: products_savings; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_savings (id, account_balance, account_status, date_created, related_savings_subscription_id) FROM stdin;
8	50000.00	0	2020-02-20 15:29:08.68354+03	23
6	230000.00	0	2020-02-13 13:10:47.109983+03	20
7	100000.00	0	2020-02-20 15:28:41.776751+03	21
\.


--
-- Data for Name: products_savingsdeposits; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_savingsdeposits (id, amount_deposited, fee_charged, deposit_method, date_deposited, deposit_cleared_by_id, deposit_received_by_id, related_savings_account_id) FROM stdin;
6	10000.00	0.00	0	2020-02-13 13:11:34.049929+03	2	2	6
7	10000.00	0.00	0	2020-02-15 03:35:12.323483+03	2	2	6
8	10000.00	0.00	0	2020-02-15 03:36:27.673907+03	2	2	6
9	10000.00	0.00	0	2020-02-15 03:38:05.823053+03	2	2	6
10	10000.00	0.00	0	2020-02-15 03:38:25.85767+03	2	2	6
11	10000.00	0.00	0	2020-02-15 03:38:27.338537+03	2	2	6
12	10000.00	0.00	0	2020-02-15 03:45:32.695205+03	2	2	6
13	10000.00	0.00	0	2020-02-15 03:45:34.217405+03	2	2	6
14	10000.00	0.00	0	2020-02-15 03:45:57.329778+03	2	2	6
15	10000.00	0.00	0	2020-02-15 03:50:59.793533+03	2	2	6
16	10000.00	0.00	0	2020-02-15 03:51:05.594798+03	2	2	6
17	10000.00	0.00	0	2020-02-15 03:52:46.428166+03	2	2	6
18	10000.00	0.00	0	2020-02-15 03:55:33.031426+03	2	2	6
19	10000.00	0.00	0	2020-02-15 03:56:12.456111+03	2	2	6
20	10000.00	0.00	0	2020-02-15 03:58:07.775163+03	2	2	6
21	10000.00	0.00	0	2020-02-15 03:58:09.368281+03	2	2	6
22	10000.00	0.00	0	2020-02-15 03:59:23.745038+03	2	2	6
23	10000.00	0.00	0	2020-02-15 03:59:58.185334+03	2	2	6
24	10000.00	0.00	0	2020-02-15 04:00:27.441775+03	2	2	6
25	10000.00	0.00	0	2020-02-15 04:06:37.207543+03	2	2	6
26	10000.00	0.00	0	2020-02-15 04:09:24.500364+03	2	2	6
27	10000.00	0.00	0	2020-02-15 04:09:27.362838+03	2	2	6
28	10000.00	0.00	0	2020-02-15 04:26:48.627947+03	2	2	6
29	10000.00	0.00	0	2020-02-15 04:28:45.608544+03	2	2	6
30	10000.00	0.00	0	2020-02-15 04:31:33.309512+03	2	2	6
31	10000.00	0.00	0	2020-02-15 04:32:27.595668+03	2	2	6
32	10000.00	0.00	0	2020-02-15 04:35:45.676616+03	2	2	6
33	10000.00	0.00	0	2020-02-15 04:36:20.636954+03	2	2	6
34	10000.00	0.00	0	2020-02-15 04:36:21.515458+03	2	2	6
35	10000.00	0.00	0	2020-02-15 04:36:22.326028+03	2	2	6
36	10000.00	0.00	0	2020-02-18 10:18:15.846945+03	2	2	6
37	10000.00	0.00	0	2020-02-18 10:24:39.337568+03	2	2	6
38	10000.00	0.00	0	2020-02-18 10:24:40.008351+03	2	2	6
39	10000.00	0.00	0	2020-02-18 10:27:23.02309+03	2	2	6
40	10000.00	0.00	0	2020-02-18 10:38:14.567055+03	2	2	6
41	10000.00	0.00	0	2020-02-18 10:41:20.680609+03	2	2	6
42	10000.00	0.00	0	2020-02-18 10:56:40.782837+03	2	2	6
43	10000.00	0.00	0	2020-02-18 16:24:45.840876+03	2	2	6
44	10000.00	0.00	0	2020-02-18 16:25:04.620251+03	2	2	6
45	10000.00	0.00	0	2020-02-18 16:25:59.402461+03	2	2	6
46	10000.00	0.00	0	2020-02-18 16:26:06.937404+03	2	2	6
47	10000.00	0.00	0	2020-02-18 16:26:47.431542+03	2	2	6
48	10000.00	0.00	0	2020-02-18 16:27:32.408254+03	2	2	6
49	10000.00	0.00	0	2020-02-18 16:27:45.535967+03	2	2	6
50	10000.00	0.00	0	2020-02-18 16:37:22.231008+03	2	2	6
51	10000.00	0.00	0	2020-02-18 16:39:55.493349+03	2	2	6
52	10000.00	0.00	0	2020-02-18 16:40:49.060836+03	2	2	6
53	10000.00	0.00	0	2020-02-18 17:29:14.545696+03	2	2	6
54	10000.00	0.00	0	2020-02-18 17:33:36.766648+03	2	2	6
55	10000.00	0.00	0	2020-02-18 17:34:25.122546+03	2	2	6
56	10000.00	0.00	0	2020-02-18 17:35:09.537497+03	2	2	6
57	10000.00	0.00	0	2020-02-18 17:36:57.08358+03	2	2	6
58	10000.00	0.00	0	2020-02-18 17:38:17.766001+03	2	2	6
59	10000.00	0.00	0	2020-02-18 17:39:48.027735+03	2	2	6
60	10000.00	0.00	0	2020-02-18 17:39:55.612843+03	2	2	6
61	10000.00	0.00	0	2020-02-23 18:21:05.763999+03	1	1	8
62	10000.00	0.00	0	2020-02-23 18:22:21.409242+03	1	1	8
63	10000.00	0.00	0	2020-02-23 18:28:35.68344+03	1	1	8
64	10000.00	0.00	0	2020-02-23 18:30:16.441077+03	1	1	8
65	10000.00	0.00	0	2020-02-23 18:31:08.886215+03	1	1	8
66	10000.00	0.00	0	2020-02-23 19:07:41.360868+03	1	1	8
1	100000.00	0.00	0	2022-11-02 23:27:35.850029+03	1	1	7
\.


--
-- Data for Name: products_savingswithdrawal; Type: TABLE DATA; Schema: public; Owner: djangoappguy
--

COPY public.products_savingswithdrawal (id, amount_withdrawn, fee_charged, withdraw_method, withdraw_comment, date_withdrawn, related_savings_account_withdrawal_id, withdrawal_authorized_by_id, withdrawal_cleared_by_id) FROM stdin;
1	10000.00	0.00	0	\N	2020-02-18 10:56:17.971632+03	6	2	2
2	10000.00	0.00	0	\N	2020-02-18 10:56:44.759366+03	6	2	2
3	10000.00	0.00	0	\N	2020-02-18 11:06:01.142679+03	6	2	2
4	10000.00	0.00	0	\N	2020-02-18 11:06:28.780111+03	6	2	2
5	10000.00	0.00	0	\N	2020-02-18 17:14:02.167476+03	6	2	2
6	10000.00	0.00	0	\N	2020-02-18 17:29:25.695175+03	6	2	2
7	10000.00	0.00	0	\N	2020-02-18 17:29:26.066896+03	6	2	2
8	10000.00	0.00	0	\N	2020-02-18 20:05:38.225939+03	6	2	2
\.


--
-- Name: accounts_branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.accounts_branch_id_seq', 1, false);


--
-- Name: accounts_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.accounts_client_id_seq', 1, false);


--
-- Name: accounts_clientbackgroundinformation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.accounts_clientbackgroundinformation_id_seq', 1, false);


--
-- Name: accounts_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.accounts_group_id_seq', 1, false);


--
-- Name: accounts_groupclients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.accounts_groupclients_id_seq', 1, false);


--
-- Name: accounts_notificationmessages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.accounts_notificationmessages_id_seq', 1, true);


--
-- Name: accounts_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.accounts_roles_id_seq', 1, true);


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 1, false);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 1, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


--
-- Name: accounts_userdetails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.accounts_userdetails_id_seq', 1, false);


--
-- Name: accounts_userroleschangetracker_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.accounts_userroleschangetracker_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 144, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 36, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 41, true);


--
-- Name: ledgers_categoryclass_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.ledgers_categoryclass_id_seq', 1, false);


--
-- Name: ledgers_chartlevelledger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.ledgers_chartlevelledger_id_seq', 1, false);


--
-- Name: ledgers_chartofaccounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.ledgers_chartofaccounts_id_seq', 1, false);


--
-- Name: ledgers_endofperiod_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.ledgers_endofperiod_id_seq', 1, false);


--
-- Name: ledgers_productledger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.ledgers_productledger_id_seq', 1, true);


--
-- Name: ledgers_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.ledgers_transaction_id_seq', 1, true);


--
-- Name: ledgers_trialbalanceledger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.ledgers_trialbalanceledger_id_seq', 1, true);


--
-- Name: products_loans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_loans_id_seq', 1, false);


--
-- Name: products_loansdisbursementfeeslevied_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_loansdisbursementfeeslevied_id_seq', 1, false);


--
-- Name: products_loansdisbursements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_loansdisbursements_id_seq', 1, false);


--
-- Name: products_loansguarantors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_loansguarantors_id_seq', 1, false);


--
-- Name: products_loansrepayments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_loansrepayments_id_seq', 1, false);


--
-- Name: products_loansrepaymentsfeeslevied_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_loansrepaymentsfeeslevied_id_seq', 1, false);


--
-- Name: products_loantype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_loantype_id_seq', 1, false);


--
-- Name: products_loantypefeesapplicable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_loantypefeesapplicable_id_seq', 1, false);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_product_id_seq', 1, false);


--
-- Name: products_productfeeslevied_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_productfeeslevied_id_seq', 1, false);


--
-- Name: products_productsubscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_productsubscriptions_id_seq', 1, false);


--
-- Name: products_savings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_savings_id_seq', 1, false);


--
-- Name: products_savingsdeposits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_savingsdeposits_id_seq', 1, true);


--
-- Name: products_savingswithdrawal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: djangoappguy
--

SELECT pg_catalog.setval('public.products_savingswithdrawal_id_seq', 1, false);


--
-- Name: accounts_branch accounts_branch_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_branch
    ADD CONSTRAINT accounts_branch_pkey PRIMARY KEY (id);


--
-- Name: accounts_client accounts_client_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_client
    ADD CONSTRAINT accounts_client_pkey PRIMARY KEY (id);


--
-- Name: accounts_clientbackgroundinformation accounts_clientbackgroundinformation_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_clientbackgroundinformation
    ADD CONSTRAINT accounts_clientbackgroundinformation_pkey PRIMARY KEY (id);


--
-- Name: accounts_group accounts_group_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_group
    ADD CONSTRAINT accounts_group_pkey PRIMARY KEY (id);


--
-- Name: accounts_groupclients accounts_groupclients_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_groupclients
    ADD CONSTRAINT accounts_groupclients_pkey PRIMARY KEY (id);


--
-- Name: accounts_notificationmessages accounts_notificationmessages_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_notificationmessages
    ADD CONSTRAINT accounts_notificationmessages_pkey PRIMARY KEY (id);


--
-- Name: accounts_roles accounts_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_roles
    ADD CONSTRAINT accounts_roles_pkey PRIMARY KEY (id);


--
-- Name: accounts_roles accounts_roles_related_user_id_key; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_roles
    ADD CONSTRAINT accounts_roles_related_user_id_key UNIQUE (related_user_id);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_user accounts_user_username_key; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_username_key UNIQUE (username);


--
-- Name: accounts_userdetails accounts_userdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_userdetails
    ADD CONSTRAINT accounts_userdetails_pkey PRIMARY KEY (id);


--
-- Name: accounts_userroleschangetracker accounts_userroleschangetracker_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_userroleschangetracker
    ADD CONSTRAINT accounts_userroleschangetracker_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: ledgers_categoryclass ledgers_categoryclass_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_categoryclass
    ADD CONSTRAINT ledgers_categoryclass_pkey PRIMARY KEY (id);


--
-- Name: ledgers_chartlevelledger ledgers_chartlevelledger_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_chartlevelledger
    ADD CONSTRAINT ledgers_chartlevelledger_pkey PRIMARY KEY (id);


--
-- Name: ledgers_chartofaccounts ledgers_chartofaccounts_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_chartofaccounts
    ADD CONSTRAINT ledgers_chartofaccounts_pkey PRIMARY KEY (id);


--
-- Name: ledgers_endofperiod ledgers_endofperiod_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_endofperiod
    ADD CONSTRAINT ledgers_endofperiod_pkey PRIMARY KEY (id);


--
-- Name: ledgers_productledger ledgers_productledger_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_productledger
    ADD CONSTRAINT ledgers_productledger_pkey PRIMARY KEY (id);


--
-- Name: ledgers_transaction ledgers_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_transaction
    ADD CONSTRAINT ledgers_transaction_pkey PRIMARY KEY (id);


--
-- Name: ledgers_trialbalanceledger ledgers_trialbalanceledger_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_trialbalanceledger
    ADD CONSTRAINT ledgers_trialbalanceledger_pkey PRIMARY KEY (id);


--
-- Name: products_loans products_loans_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loans
    ADD CONSTRAINT products_loans_pkey PRIMARY KEY (id);


--
-- Name: products_loansdisbursementfeeslevied products_loansdisbursementfeeslevied_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansdisbursementfeeslevied
    ADD CONSTRAINT products_loansdisbursementfeeslevied_pkey PRIMARY KEY (id);


--
-- Name: products_loansdisbursements products_loansdisbursements_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansdisbursements
    ADD CONSTRAINT products_loansdisbursements_pkey PRIMARY KEY (id);


--
-- Name: products_loansguarantors products_loansguarantors_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansguarantors
    ADD CONSTRAINT products_loansguarantors_pkey PRIMARY KEY (id);


--
-- Name: products_loansrepayments products_loansrepayments_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansrepayments
    ADD CONSTRAINT products_loansrepayments_pkey PRIMARY KEY (id);


--
-- Name: products_loansrepaymentsfeeslevied products_loansrepaymentsfeeslevied_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansrepaymentsfeeslevied
    ADD CONSTRAINT products_loansrepaymentsfeeslevied_pkey PRIMARY KEY (id);


--
-- Name: products_loantype products_loantype_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loantype
    ADD CONSTRAINT products_loantype_pkey PRIMARY KEY (id);


--
-- Name: products_loantypefeesapplicable products_loantypefeesapplicable_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loantypefeesapplicable
    ADD CONSTRAINT products_loantypefeesapplicable_pkey PRIMARY KEY (id);


--
-- Name: products_product products_product_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_pkey PRIMARY KEY (id);


--
-- Name: products_productfeeslevied products_productfeeslevied_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_productfeeslevied
    ADD CONSTRAINT products_productfeeslevied_pkey PRIMARY KEY (id);


--
-- Name: products_productsubscriptions products_productsubscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_productsubscriptions
    ADD CONSTRAINT products_productsubscriptions_pkey PRIMARY KEY (id);


--
-- Name: products_savings products_savings_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savings
    ADD CONSTRAINT products_savings_pkey PRIMARY KEY (id);


--
-- Name: products_savingsdeposits products_savingsdeposits_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savingsdeposits
    ADD CONSTRAINT products_savingsdeposits_pkey PRIMARY KEY (id);


--
-- Name: products_savingswithdrawal products_savingswithdrawal_pkey; Type: CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savingswithdrawal
    ADD CONSTRAINT products_savingswithdrawal_pkey PRIMARY KEY (id);


--
-- Name: accounts_branch_created_by_id_9cffc056; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_branch_created_by_id_9cffc056 ON public.accounts_branch USING btree (created_by_id);


--
-- Name: accounts_client_added_by_id_27a545ea; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_client_added_by_id_27a545ea ON public.accounts_client USING btree (added_by_id);


--
-- Name: accounts_client_client_branch_id_5ef67eb9; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_client_client_branch_id_5ef67eb9 ON public.accounts_client USING btree (client_branch_id);


--
-- Name: accounts_client_related_user_id_59496c35; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_client_related_user_id_59496c35 ON public.accounts_client USING btree (related_user_id);


--
-- Name: accounts_client_signatory_loans_officer_id_bd23a9f0; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_client_signatory_loans_officer_id_bd23a9f0 ON public.accounts_client USING btree (signatory_loans_officer_id);


--
-- Name: accounts_client_signatory_sales_officer_id_362c38cf; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_client_signatory_sales_officer_id_362c38cf ON public.accounts_client USING btree (signatory_sales_officer_id);


--
-- Name: accounts_client_signatory_savings_officer_id_108a4caa; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_client_signatory_savings_officer_id_108a4caa ON public.accounts_client USING btree (signatory_savings_officer_id);


--
-- Name: accounts_clientbackgroundinformation_related_client_id_c165b15a; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_clientbackgroundinformation_related_client_id_c165b15a ON public.accounts_clientbackgroundinformation USING btree (related_client_id);


--
-- Name: accounts_group_related_branch_id_f15c504e; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_group_related_branch_id_f15c504e ON public.accounts_group USING btree (related_branch_id);


--
-- Name: accounts_groupclients_related_client_id_41662a05; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_groupclients_related_client_id_41662a05 ON public.accounts_groupclients USING btree (related_client_id);


--
-- Name: accounts_groupclients_related_group_id_26bc2918; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_groupclients_related_group_id_26bc2918 ON public.accounts_groupclients USING btree (related_group_id);


--
-- Name: accounts_notificationmessages_content_type_id_1b448914; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_notificationmessages_content_type_id_1b448914 ON public.accounts_notificationmessages USING btree (content_type_id);


--
-- Name: accounts_notificationmessages_recipient_id_4421ad41; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_notificationmessages_recipient_id_4421ad41 ON public.accounts_notificationmessages USING btree (recipient_id);


--
-- Name: accounts_notificationmessages_timestamp_b72c615b; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_notificationmessages_timestamp_b72c615b ON public.accounts_notificationmessages USING btree ("timestamp");


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: accounts_user_username_6088629e_like; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_user_username_6088629e_like ON public.accounts_user USING btree (username varchar_pattern_ops);


--
-- Name: accounts_userdetails_created_by_id_16f632b5; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_userdetails_created_by_id_16f632b5 ON public.accounts_userdetails USING btree (created_by_id);


--
-- Name: accounts_userdetails_current_branch_id_d3fabe9f; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_userdetails_current_branch_id_d3fabe9f ON public.accounts_userdetails USING btree (current_branch_id);


--
-- Name: accounts_userdetails_previous_branch_id_72662f09; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_userdetails_previous_branch_id_72662f09 ON public.accounts_userdetails USING btree (previous_branch_id);


--
-- Name: accounts_userdetails_related_user_id_dec7cced; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_userdetails_related_user_id_dec7cced ON public.accounts_userdetails USING btree (related_user_id);


--
-- Name: accounts_userroleschangetracker_related_role_id_d312d999; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX accounts_userroleschangetracker_related_role_id_d312d999 ON public.accounts_userroleschangetracker USING btree (related_role_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: ledgers_chartlevelledger_related_chart_transaction_id_e8f195a8; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX ledgers_chartlevelledger_related_chart_transaction_id_e8f195a8 ON public.ledgers_chartlevelledger USING btree (related_chart_transaction_id);


--
-- Name: ledgers_chartofaccounts_related_category_id_1df9dc08; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX ledgers_chartofaccounts_related_category_id_1df9dc08 ON public.ledgers_chartofaccounts USING btree (related_category_id);


--
-- Name: ledgers_endofperiod_period_ended_by_id_cdf5bbdb; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX ledgers_endofperiod_period_ended_by_id_cdf5bbdb ON public.ledgers_endofperiod USING btree (period_ended_by_id);


--
-- Name: ledgers_endofperiod_period_started_by_id_13a9674e; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX ledgers_endofperiod_period_started_by_id_13a9674e ON public.ledgers_endofperiod USING btree (period_started_by_id);


--
-- Name: ledgers_productledger_related_ledger_transaction_id_17668b17; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX ledgers_productledger_related_ledger_transaction_id_17668b17 ON public.ledgers_productledger USING btree (related_ledger_transaction_id);


--
-- Name: ledgers_transaction_transaction_cleared_by_id_68352529; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX ledgers_transaction_transaction_cleared_by_id_68352529 ON public.ledgers_transaction USING btree (transaction_cleared_by_id);


--
-- Name: ledgers_transaction_transaction_completed_by_id_7b6b4322; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX ledgers_transaction_transaction_completed_by_id_7b6b4322 ON public.ledgers_transaction USING btree (transaction_completed_by_id);


--
-- Name: ledgers_transaction_transaction_related_product_id_277ad03a; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX ledgers_transaction_transaction_related_product_id_277ad03a ON public.ledgers_transaction USING btree (transaction_related_product_id);


--
-- Name: ledgers_trialbalanceledger_related_trial_transaction__6a1487c0; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX ledgers_trialbalanceledger_related_trial_transaction__6a1487c0 ON public.ledgers_trialbalanceledger USING btree (related_trial_transaction_id);


--
-- Name: products_loans_loan_cleared_by_id_6d0437ab; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loans_loan_cleared_by_id_6d0437ab ON public.products_loans USING btree (loan_cleared_by_id);


--
-- Name: products_loans_loan_received_by_id_224536b0; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loans_loan_received_by_id_224536b0 ON public.products_loans USING btree (loan_received_by_id);


--
-- Name: products_loans_related_loan_subscription_id_d4d4f18f; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loans_related_loan_subscription_id_d4d4f18f ON public.products_loans USING btree (related_loan_subscription_id);


--
-- Name: products_loans_related_loan_type_loans_id_d004b1d9; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loans_related_loan_type_loans_id_d004b1d9 ON public.products_loans USING btree (related_loan_type_loans_id);


--
-- Name: products_loansdisbursement_disbursement_related_fee_i_fc08c2cf; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loansdisbursement_disbursement_related_fee_i_fc08c2cf ON public.products_loansdisbursementfeeslevied USING btree (disbursement_related_fee_id);


--
-- Name: products_loansdisbursement_disbursement_related_loan__121bad0d; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loansdisbursement_disbursement_related_loan__121bad0d ON public.products_loansdisbursementfeeslevied USING btree (disbursement_related_loan_id);


--
-- Name: products_loansdisbursement_related_loan_disbursement__8c06a5c0; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loansdisbursement_related_loan_disbursement__8c06a5c0 ON public.products_loansdisbursements USING btree (related_loan_disbursement_id);


--
-- Name: products_loansdisbursements_disbursed_by_id_61913eab; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loansdisbursements_disbursed_by_id_61913eab ON public.products_loansdisbursements USING btree (disbursed_by_id);


--
-- Name: products_loansdisbursements_disbursement_cleared_by_id_d231f2d5; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loansdisbursements_disbursement_cleared_by_id_d231f2d5 ON public.products_loansdisbursements USING btree (disbursement_cleared_by_id);


--
-- Name: products_loansguarantors_guarantor_id_297b8662; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loansguarantors_guarantor_id_297b8662 ON public.products_loansguarantors USING btree (guarantor_id);


--
-- Name: products_loansguarantors_related_loan_guaranted_id_b8a55e80; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loansguarantors_related_loan_guaranted_id_b8a55e80 ON public.products_loansguarantors USING btree (related_loan_guaranted_id);


--
-- Name: products_loansrepayments_related_loan_repayment_id_91545d35; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loansrepayments_related_loan_repayment_id_91545d35 ON public.products_loansrepayments USING btree (related_loan_repayment_id);


--
-- Name: products_loansrepaymentsfe_related_repayment_fee_id_5cddd422; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loansrepaymentsfe_related_repayment_fee_id_5cddd422 ON public.products_loansrepaymentsfeeslevied USING btree (related_repayment_fee_id);


--
-- Name: products_loantype_loan_type_added_by_id_f89bb76a; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loantype_loan_type_added_by_id_f89bb76a ON public.products_loantype USING btree (loan_type_added_by_id);


--
-- Name: products_loantype_related_product_id_4cb2e6b3; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loantype_related_product_id_4cb2e6b3 ON public.products_loantype USING btree (related_product_id);


--
-- Name: products_loantypefeesapplicable_added_by_id_c9ebf5f0; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loantypefeesapplicable_added_by_id_c9ebf5f0 ON public.products_loantypefeesapplicable USING btree (added_by_id);


--
-- Name: products_loantypefeesapplicable_related_loan_type_id_64fdf88f; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_loantypefeesapplicable_related_loan_type_id_64fdf88f ON public.products_loantypefeesapplicable USING btree (related_loan_type_id);


--
-- Name: products_product_created_by_id_dd4af40e; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_product_created_by_id_dd4af40e ON public.products_product USING btree (created_by_id);


--
-- Name: products_productfeeslevied_fees_added_by_id_080ab82e; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_productfeeslevied_fees_added_by_id_080ab82e ON public.products_productfeeslevied USING btree (fees_added_by_id);


--
-- Name: products_productfeeslevied_related_product_fees_id_572218c4; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_productfeeslevied_related_product_fees_id_572218c4 ON public.products_productfeeslevied USING btree (related_product_fees_id);


--
-- Name: products_productsubscripti_related_client_subscriptio_6759e54f; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_productsubscripti_related_client_subscriptio_6759e54f ON public.products_productsubscriptions USING btree (related_client_subscription_id);


--
-- Name: products_productsubscripti_related_product_subscripti_897326d9; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_productsubscripti_related_product_subscripti_897326d9 ON public.products_productsubscriptions USING btree (related_product_subscription_id);


--
-- Name: products_productsubscriptions_added_by_id_80d65595; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_productsubscriptions_added_by_id_80d65595 ON public.products_productsubscriptions USING btree (added_by_id);


--
-- Name: products_savings_related_savings_subscription_id_6bc5f672; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_savings_related_savings_subscription_id_6bc5f672 ON public.products_savings USING btree (related_savings_subscription_id);


--
-- Name: products_savingsdeposits_deposit_cleared_by_id_9d6f798b; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_savingsdeposits_deposit_cleared_by_id_9d6f798b ON public.products_savingsdeposits USING btree (deposit_cleared_by_id);


--
-- Name: products_savingsdeposits_deposit_received_by_id_49cda82f; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_savingsdeposits_deposit_received_by_id_49cda82f ON public.products_savingsdeposits USING btree (deposit_received_by_id);


--
-- Name: products_savingsdeposits_related_savings_account_id_1c352031; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_savingsdeposits_related_savings_account_id_1c352031 ON public.products_savingsdeposits USING btree (related_savings_account_id);


--
-- Name: products_savingswithdrawal_related_savings_account_wi_d4c4c13a; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_savingswithdrawal_related_savings_account_wi_d4c4c13a ON public.products_savingswithdrawal USING btree (related_savings_account_withdrawal_id);


--
-- Name: products_savingswithdrawal_withdrawal_authorized_by_id_ed6934cb; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_savingswithdrawal_withdrawal_authorized_by_id_ed6934cb ON public.products_savingswithdrawal USING btree (withdrawal_authorized_by_id);


--
-- Name: products_savingswithdrawal_withdrawal_cleared_by_id_a7802578; Type: INDEX; Schema: public; Owner: djangoappguy
--

CREATE INDEX products_savingswithdrawal_withdrawal_cleared_by_id_a7802578 ON public.products_savingswithdrawal USING btree (withdrawal_cleared_by_id);


--
-- Name: accounts_branch accounts_branch_created_by_id_9cffc056_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_branch
    ADD CONSTRAINT accounts_branch_created_by_id_9cffc056_fk_accounts_user_id FOREIGN KEY (created_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_client accounts_client_added_by_id_27a545ea_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_client
    ADD CONSTRAINT accounts_client_added_by_id_27a545ea_fk_accounts_user_id FOREIGN KEY (added_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_client accounts_client_client_branch_id_5ef67eb9_fk_accounts_branch_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_client
    ADD CONSTRAINT accounts_client_client_branch_id_5ef67eb9_fk_accounts_branch_id FOREIGN KEY (client_branch_id) REFERENCES public.accounts_branch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_client accounts_client_related_user_id_59496c35_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_client
    ADD CONSTRAINT accounts_client_related_user_id_59496c35_fk_accounts_user_id FOREIGN KEY (related_user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_client accounts_client_signatory_loans_offi_bd23a9f0_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_client
    ADD CONSTRAINT accounts_client_signatory_loans_offi_bd23a9f0_fk_accounts_ FOREIGN KEY (signatory_loans_officer_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_client accounts_client_signatory_sales_offi_362c38cf_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_client
    ADD CONSTRAINT accounts_client_signatory_sales_offi_362c38cf_fk_accounts_ FOREIGN KEY (signatory_sales_officer_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_client accounts_client_signatory_savings_of_108a4caa_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_client
    ADD CONSTRAINT accounts_client_signatory_savings_of_108a4caa_fk_accounts_ FOREIGN KEY (signatory_savings_officer_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_clientbackgroundinformation accounts_clientbackg_related_client_id_c165b15a_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_clientbackgroundinformation
    ADD CONSTRAINT accounts_clientbackg_related_client_id_c165b15a_fk_accounts_ FOREIGN KEY (related_client_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_group accounts_group_related_branch_id_f15c504e_fk_accounts_branch_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_group
    ADD CONSTRAINT accounts_group_related_branch_id_f15c504e_fk_accounts_branch_id FOREIGN KEY (related_branch_id) REFERENCES public.accounts_branch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_groupclients accounts_groupclient_related_client_id_41662a05_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_groupclients
    ADD CONSTRAINT accounts_groupclient_related_client_id_41662a05_fk_accounts_ FOREIGN KEY (related_client_id) REFERENCES public.accounts_client(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_groupclients accounts_groupclient_related_group_id_26bc2918_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_groupclients
    ADD CONSTRAINT accounts_groupclient_related_group_id_26bc2918_fk_accounts_ FOREIGN KEY (related_group_id) REFERENCES public.accounts_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_notificationmessages accounts_notificatio_content_type_id_1b448914_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_notificationmessages
    ADD CONSTRAINT accounts_notificatio_content_type_id_1b448914_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_notificationmessages accounts_notificatio_recipient_id_4421ad41_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_notificationmessages
    ADD CONSTRAINT accounts_notificatio_recipient_id_4421ad41_fk_accounts_ FOREIGN KEY (recipient_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_roles accounts_roles_related_user_id_53634bd5_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_roles
    ADD CONSTRAINT accounts_roles_related_user_id_53634bd5_fk_accounts_user_id FOREIGN KEY (related_user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_userdetails accounts_userdetails_created_by_id_16f632b5_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_userdetails
    ADD CONSTRAINT accounts_userdetails_created_by_id_16f632b5_fk_accounts_user_id FOREIGN KEY (created_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_userdetails accounts_userdetails_current_branch_id_d3fabe9f_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_userdetails
    ADD CONSTRAINT accounts_userdetails_current_branch_id_d3fabe9f_fk_accounts_ FOREIGN KEY (current_branch_id) REFERENCES public.accounts_branch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_userdetails accounts_userdetails_previous_branch_id_72662f09_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_userdetails
    ADD CONSTRAINT accounts_userdetails_previous_branch_id_72662f09_fk_accounts_ FOREIGN KEY (previous_branch_id) REFERENCES public.accounts_branch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_userdetails accounts_userdetails_related_user_id_dec7cced_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_userdetails
    ADD CONSTRAINT accounts_userdetails_related_user_id_dec7cced_fk_accounts_ FOREIGN KEY (related_user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_userroleschangetracker accounts_userrolesch_related_role_id_d312d999_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.accounts_userroleschangetracker
    ADD CONSTRAINT accounts_userrolesch_related_role_id_d312d999_fk_accounts_ FOREIGN KEY (related_role_id) REFERENCES public.accounts_roles(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_chartlevelledger ledgers_chartlevelle_related_chart_transa_e8f195a8_fk_ledgers_t; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_chartlevelledger
    ADD CONSTRAINT ledgers_chartlevelle_related_chart_transa_e8f195a8_fk_ledgers_t FOREIGN KEY (related_chart_transaction_id) REFERENCES public.ledgers_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_chartofaccounts ledgers_chartofaccou_related_category_id_1df9dc08_fk_ledgers_c; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_chartofaccounts
    ADD CONSTRAINT ledgers_chartofaccou_related_category_id_1df9dc08_fk_ledgers_c FOREIGN KEY (related_category_id) REFERENCES public.ledgers_categoryclass(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_endofperiod ledgers_endofperiod_period_ended_by_id_cdf5bbdb_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_endofperiod
    ADD CONSTRAINT ledgers_endofperiod_period_ended_by_id_cdf5bbdb_fk_accounts_ FOREIGN KEY (period_ended_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_endofperiod ledgers_endofperiod_period_started_by_id_13a9674e_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_endofperiod
    ADD CONSTRAINT ledgers_endofperiod_period_started_by_id_13a9674e_fk_accounts_ FOREIGN KEY (period_started_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_productledger ledgers_productledge_related_ledger_trans_17668b17_fk_ledgers_t; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_productledger
    ADD CONSTRAINT ledgers_productledge_related_ledger_trans_17668b17_fk_ledgers_t FOREIGN KEY (related_ledger_transaction_id) REFERENCES public.ledgers_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_transaction ledgers_transaction_transaction_cleared__68352529_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_transaction
    ADD CONSTRAINT ledgers_transaction_transaction_cleared__68352529_fk_accounts_ FOREIGN KEY (transaction_cleared_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_transaction ledgers_transaction_transaction_complete_7b6b4322_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_transaction
    ADD CONSTRAINT ledgers_transaction_transaction_complete_7b6b4322_fk_accounts_ FOREIGN KEY (transaction_completed_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_transaction ledgers_transaction_transaction_related__277ad03a_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_transaction
    ADD CONSTRAINT ledgers_transaction_transaction_related__277ad03a_fk_products_ FOREIGN KEY (transaction_related_product_id) REFERENCES public.products_productsubscriptions(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_trialbalanceledger ledgers_trialbalance_related_trial_transa_6a1487c0_fk_ledgers_t; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.ledgers_trialbalanceledger
    ADD CONSTRAINT ledgers_trialbalance_related_trial_transa_6a1487c0_fk_ledgers_t FOREIGN KEY (related_trial_transaction_id) REFERENCES public.ledgers_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loans products_loans_loan_cleared_by_id_6d0437ab_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loans
    ADD CONSTRAINT products_loans_loan_cleared_by_id_6d0437ab_fk_accounts_user_id FOREIGN KEY (loan_cleared_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loans products_loans_loan_received_by_id_224536b0_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loans
    ADD CONSTRAINT products_loans_loan_received_by_id_224536b0_fk_accounts_user_id FOREIGN KEY (loan_received_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loans products_loans_related_loan_subscri_d4d4f18f_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loans
    ADD CONSTRAINT products_loans_related_loan_subscri_d4d4f18f_fk_products_ FOREIGN KEY (related_loan_subscription_id) REFERENCES public.products_productsubscriptions(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loans products_loans_related_loan_type_lo_d004b1d9_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loans
    ADD CONSTRAINT products_loans_related_loan_type_lo_d004b1d9_fk_products_ FOREIGN KEY (related_loan_type_loans_id) REFERENCES public.products_loantype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loansdisbursements products_loansdisbur_disbursed_by_id_61913eab_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansdisbursements
    ADD CONSTRAINT products_loansdisbur_disbursed_by_id_61913eab_fk_accounts_ FOREIGN KEY (disbursed_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loansdisbursements products_loansdisbur_disbursement_cleared_d231f2d5_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansdisbursements
    ADD CONSTRAINT products_loansdisbur_disbursement_cleared_d231f2d5_fk_accounts_ FOREIGN KEY (disbursement_cleared_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loansdisbursementfeeslevied products_loansdisbur_disbursement_related_121bad0d_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansdisbursementfeeslevied
    ADD CONSTRAINT products_loansdisbur_disbursement_related_121bad0d_fk_products_ FOREIGN KEY (disbursement_related_loan_id) REFERENCES public.products_loansdisbursements(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loansdisbursementfeeslevied products_loansdisbur_disbursement_related_fc08c2cf_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansdisbursementfeeslevied
    ADD CONSTRAINT products_loansdisbur_disbursement_related_fc08c2cf_fk_products_ FOREIGN KEY (disbursement_related_fee_id) REFERENCES public.products_productfeeslevied(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loansdisbursements products_loansdisbur_related_loan_disburs_8c06a5c0_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansdisbursements
    ADD CONSTRAINT products_loansdisbur_related_loan_disburs_8c06a5c0_fk_products_ FOREIGN KEY (related_loan_disbursement_id) REFERENCES public.products_loans(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loansguarantors products_loansguaran_guarantor_id_297b8662_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansguarantors
    ADD CONSTRAINT products_loansguaran_guarantor_id_297b8662_fk_accounts_ FOREIGN KEY (guarantor_id) REFERENCES public.accounts_client(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loansguarantors products_loansguaran_related_loan_guarant_b8a55e80_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansguarantors
    ADD CONSTRAINT products_loansguaran_related_loan_guarant_b8a55e80_fk_products_ FOREIGN KEY (related_loan_guaranted_id) REFERENCES public.products_loans(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loansrepayments products_loansrepaym_related_loan_repayme_91545d35_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansrepayments
    ADD CONSTRAINT products_loansrepaym_related_loan_repayme_91545d35_fk_products_ FOREIGN KEY (related_loan_repayment_id) REFERENCES public.products_loans(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loansrepaymentsfeeslevied products_loansrepaym_related_repayment_fe_5cddd422_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loansrepaymentsfeeslevied
    ADD CONSTRAINT products_loansrepaym_related_repayment_fe_5cddd422_fk_products_ FOREIGN KEY (related_repayment_fee_id) REFERENCES public.products_productfeeslevied(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loantype products_loantype_loan_type_added_by_i_f89bb76a_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loantype
    ADD CONSTRAINT products_loantype_loan_type_added_by_i_f89bb76a_fk_accounts_ FOREIGN KEY (loan_type_added_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loantype products_loantype_related_product_id_4cb2e6b3_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loantype
    ADD CONSTRAINT products_loantype_related_product_id_4cb2e6b3_fk_products_ FOREIGN KEY (related_product_id) REFERENCES public.products_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loantypefeesapplicable products_loantypefee_added_by_id_c9ebf5f0_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loantypefeesapplicable
    ADD CONSTRAINT products_loantypefee_added_by_id_c9ebf5f0_fk_accounts_ FOREIGN KEY (added_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_loantypefeesapplicable products_loantypefee_related_loan_type_id_64fdf88f_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_loantypefeesapplicable
    ADD CONSTRAINT products_loantypefee_related_loan_type_id_64fdf88f_fk_products_ FOREIGN KEY (related_loan_type_id) REFERENCES public.products_loantype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product products_product_created_by_id_dd4af40e_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_created_by_id_dd4af40e_fk_accounts_user_id FOREIGN KEY (created_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_productfeeslevied products_productfees_fees_added_by_id_080ab82e_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_productfeeslevied
    ADD CONSTRAINT products_productfees_fees_added_by_id_080ab82e_fk_accounts_ FOREIGN KEY (fees_added_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_productfeeslevied products_productfees_related_product_fees_572218c4_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_productfeeslevied
    ADD CONSTRAINT products_productfees_related_product_fees_572218c4_fk_products_ FOREIGN KEY (related_product_fees_id) REFERENCES public.products_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_productsubscriptions products_productsubs_added_by_id_80d65595_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_productsubscriptions
    ADD CONSTRAINT products_productsubs_added_by_id_80d65595_fk_accounts_ FOREIGN KEY (added_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_productsubscriptions products_productsubs_related_client_subsc_6759e54f_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_productsubscriptions
    ADD CONSTRAINT products_productsubs_related_client_subsc_6759e54f_fk_accounts_ FOREIGN KEY (related_client_subscription_id) REFERENCES public.accounts_client(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_productsubscriptions products_productsubs_related_product_subs_897326d9_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_productsubscriptions
    ADD CONSTRAINT products_productsubs_related_product_subs_897326d9_fk_products_ FOREIGN KEY (related_product_subscription_id) REFERENCES public.products_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_savings products_savings_related_savings_subs_6bc5f672_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savings
    ADD CONSTRAINT products_savings_related_savings_subs_6bc5f672_fk_products_ FOREIGN KEY (related_savings_subscription_id) REFERENCES public.products_productsubscriptions(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_savingsdeposits products_savingsdepo_deposit_cleared_by_i_9d6f798b_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savingsdeposits
    ADD CONSTRAINT products_savingsdepo_deposit_cleared_by_i_9d6f798b_fk_accounts_ FOREIGN KEY (deposit_cleared_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_savingsdeposits products_savingsdepo_deposit_received_by__49cda82f_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savingsdeposits
    ADD CONSTRAINT products_savingsdepo_deposit_received_by__49cda82f_fk_accounts_ FOREIGN KEY (deposit_received_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_savingsdeposits products_savingsdepo_related_savings_acco_1c352031_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savingsdeposits
    ADD CONSTRAINT products_savingsdepo_related_savings_acco_1c352031_fk_products_ FOREIGN KEY (related_savings_account_id) REFERENCES public.products_savings(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_savingswithdrawal products_savingswith_related_savings_acco_d4c4c13a_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savingswithdrawal
    ADD CONSTRAINT products_savingswith_related_savings_acco_d4c4c13a_fk_products_ FOREIGN KEY (related_savings_account_withdrawal_id) REFERENCES public.products_savings(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_savingswithdrawal products_savingswith_withdrawal_authorize_ed6934cb_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savingswithdrawal
    ADD CONSTRAINT products_savingswith_withdrawal_authorize_ed6934cb_fk_accounts_ FOREIGN KEY (withdrawal_authorized_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_savingswithdrawal products_savingswith_withdrawal_cleared_b_a7802578_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: djangoappguy
--

ALTER TABLE ONLY public.products_savingswithdrawal
    ADD CONSTRAINT products_savingswith_withdrawal_cleared_b_a7802578_fk_accounts_ FOREIGN KEY (withdrawal_cleared_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

