

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


CREATE EXTENSION IF NOT EXISTS "pgsodium";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."decrement_likes_count"("message_id" "text") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$BEGIN
UPDATE messages 
SET likes = likes - 1
WHERE id = message_id;
END;$$;


ALTER FUNCTION "public"."decrement_likes_count"("message_id" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."increment_likes_count"("message_id" "text") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$BEGIN
UPDATE messages 
SET likes = likes + 1
WHERE id = message_id;
END;$$;


ALTER FUNCTION "public"."increment_likes_count"("message_id" "text") OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."likes" (
    "message_id" "text" NOT NULL,
    "pubkey" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."likes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."memberships" (
    "pubkey" "text" NOT NULL,
    "provider" "text" NOT NULL,
    "proof" "jsonb" NOT NULL,
    "proof_args" "jsonb" NOT NULL,
    "group_id" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "pubkey_expiry" timestamp with time zone
);


ALTER TABLE "public"."memberships" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."messages" (
    "id" "text" NOT NULL,
    "text" "text" NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    "signature" "text" NOT NULL,
    "pubkey" "text" NOT NULL,
    "internal" boolean NOT NULL,
    "likes" numeric DEFAULT '0'::numeric NOT NULL,
    "group_id" "text" NOT NULL,
    "group_provider" "text" NOT NULL,
    "tweeted" boolean DEFAULT false
);


ALTER TABLE "public"."messages" OWNER TO "postgres";


COMMENT ON TABLE "public"."messages" IS 'Anon messages for all domains';



ALTER TABLE ONLY "public"."memberships"
    ADD CONSTRAINT "keys_pkey" PRIMARY KEY ("pubkey");



ALTER TABLE ONLY "public"."likes"
    ADD CONSTRAINT "likes_pkey" PRIMARY KEY ("message_id", "pubkey");



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."likes"
    ADD CONSTRAINT "likes_pubkey_fkey" FOREIGN KEY ("pubkey") REFERENCES "public"."memberships"("pubkey");



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_pubkey_fkey" FOREIGN KEY ("pubkey") REFERENCES "public"."memberships"("pubkey");



ALTER TABLE "public"."likes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."memberships" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."messages" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";
































































































































































































GRANT ALL ON FUNCTION "public"."decrement_likes_count"("message_id" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."decrement_likes_count"("message_id" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."decrement_likes_count"("message_id" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."increment_likes_count"("message_id" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."increment_likes_count"("message_id" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."increment_likes_count"("message_id" "text") TO "service_role";





















GRANT ALL ON TABLE "public"."likes" TO "anon";
GRANT ALL ON TABLE "public"."likes" TO "authenticated";
GRANT ALL ON TABLE "public"."likes" TO "service_role";



GRANT ALL ON TABLE "public"."memberships" TO "anon";
GRANT ALL ON TABLE "public"."memberships" TO "authenticated";
GRANT ALL ON TABLE "public"."memberships" TO "service_role";



GRANT ALL ON TABLE "public"."messages" TO "anon";
GRANT ALL ON TABLE "public"."messages" TO "authenticated";
GRANT ALL ON TABLE "public"."messages" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";






























RESET ALL;
