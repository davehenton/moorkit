
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';

-- schema table
CREATE TABLE schema_migrations (
    version character varying NOT NULL
);

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


-- api_keys table
CREATE TABLE api_keys (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    shared_secret_hash character varying,
    expires_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

ALTER TABLE ONLY api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (id);


-- api_requests table
CREATE TABLE api_requests (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    api_key_id uuid,
    method character varying,
    path character varying,
    headers jsonb,
    payload jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

ALTER TABLE ONLY api_requests
    ADD CONSTRAINT api_requests_pkey PRIMARY KEY (id);

CREATE INDEX index_api_requests_on_api_key_id ON api_requests USING btree (api_key_id);
CREATE INDEX index_api_requests_on_payload ON api_requests USING gin (payload);


-- members table
CREATE TABLE members (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    sso_uuid uuid NOT NULL,
    details jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

ALTER TABLE ONLY members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);

CREATE INDEX index_members_on_sso_uuid ON members USING btree (sso_uuid);
CREATE INDEX index_members_on_details ON members USING gin (details);

