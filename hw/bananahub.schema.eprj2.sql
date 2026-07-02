CREATE TABLE IF NOT EXISTS "attributes" (
	"key" text NOT NULL,
	"value" text NOT NULL,
	"device_uuid" varchar NOT NULL,
	PRIMARY KEY (device_uuid, key)
);
CREATE TABLE IF NOT EXISTS "backups" (
	"uuid" varchar PRIMARY KEY NOT NULL,
	"limit" integer,
	"project_uuid" varchar NOT NULL,
	"auto" boolean NOT NULL DEFAULT (0),
	"name" varchar NOT NULL,
	"description" varchar,
	"archive" boolean NOT NULL DEFAULT (0),
	"user_uuid" varchar NOT NULL,
	"owner_uuid" varchar NOT NULL,
	"project_name" varchar NOT NULL,
	"createtime" datetime NOT NULL DEFAULT (datetime('now')),
	"path" varchar NOT NULL DEFAULT ('')
);
CREATE TABLE IF NOT EXISTS "block_symbol_attributes" (
	"path" varchar PRIMARY KEY NOT NULL,
	"project_uuid" varchar NOT NULL,
	"hash" integer NOT NULL,
	"ticket" integer NOT NULL DEFAULT (1),
	"attr" text NOT NULL
);
CREATE TABLE IF NOT EXISTS "boards" (
	"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	"project_uuid" varchar (32) NOT NULL,
	"sch_uuid" varchar (32) NOT NULL,
	"name" varchar (255) NOT NULL,
	"sort" INTEGER NOT NULL,
	CONSTRAINT "project" FOREIGN KEY ("project_uuid") REFERENCES "projects" ("uuid")
);
CREATE TABLE IF NOT EXISTS "categories" (
	"uuid" varchar PRIMARY KEY NOT NULL,
	"name" varchar NOT NULL,
	"type" integer NOT NULL,
	"user_uuid" varchar,
	"parent_uuid" varchar,
	"name_cn" varchar,
	"order_no" REAL,
	"created_at" datetime NOT NULL DEFAULT (datetime('now')),
	"updated_at" datetime NOT NULL DEFAULT (datetime('now'))
);
CREATE TABLE IF NOT EXISTS "coppers" (
	"path" varchar NOT NULL,
	"project_uuid" varchar NOT NULL,
	"dataStr" varchar NOT NULL,
	"ticket" integer NOT NULL DEFAULT (1),
	PRIMARY KEY ("path", "project_uuid")
);
CREATE TABLE IF NOT EXISTS "notifications" (
	"uuid" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	"user_uuid" varchar NOT NULL,
	"content" varchar NOT NULL,
	"type" varchar NOT NULL,
	"status" varchar NOT NULL,
	"created_at" datetime NOT NULL DEFAULT (datetime('now')),
	"updated_at" datetime NOT NULL DEFAULT (datetime('now'))
);
CREATE TABLE IF NOT EXISTS "project_logs" (
	"uuid" varchar PRIMARY KEY NOT NULL,
	"project_uuid" varchar NOT NULL,
	"content" varchar NOT NULL,
	"created_at" datetime NOT NULL DEFAULT (datetime('now')),
	"updated_at" datetime NOT NULL DEFAULT (datetime('now'))
);
CREATE TABLE IF NOT EXISTS "project_members" (
	"role" integer NOT NULL,
	"project_uuid" varchar NOT NULL,
	"user_uuid" varchar NOT NULL,
	"created_at" datetime NOT NULL DEFAULT (datetime('now')),
	"updated_at" datetime NOT NULL DEFAULT (datetime('now')),
	PRIMARY KEY ("project_uuid", "user_uuid")
);
CREATE TABLE IF NOT EXISTS "schematics" (
	"uuid" varchar PRIMARY KEY NOT NULL,
	"description" varchar NOT NULL DEFAULT (''),
	"ticket" integer NOT NULL DEFAULT (1),
	"sheet_count" integer NOT NULL DEFAULT (0),
	"project_uuid" varchar NOT NULL,
	"name" varchar NOT NULL,
	"display_name" varchar NOT NULL,
	"createtime" integer NOT NULL,
	"updatetime" integer NOT NULL,
	"created_at" datetime NOT NULL DEFAULT (datetime('now')),
	"updated_at" datetime NOT NULL DEFAULT (datetime('now')),
	"sort" varchar NOT NULL DEFAULT ('')
);
CREATE TABLE IF NOT EXISTS "sessions" (
	"uuid" varchar PRIMARY KEY NOT NULL,
	"key" varchar NOT NULL,
	"value" text NOT NULL
);
CREATE TABLE IF NOT EXISTS "system_attributes" (
	"property" varchar (255) PRIMARY KEY NOT NULL,
	"type" varchar (255) NOT NULL,
	"object" varchar (255) NOT NULL,
	"show_status" varchar
);
CREATE TABLE IF NOT EXISTS "team_members" (
	"uuid" varchar PRIMARY KEY NOT NULL,
	"role" integer NOT NULL,
	"team_uuid" varchar,
	"user_uuid" varchar,
	"created_at" datetime NOT NULL DEFAULT (datetime('now')),
	"updated_at" datetime NOT NULL DEFAULT (datetime('now'))
);
CREATE TABLE IF NOT EXISTS "users" (
	"uuid" varchar PRIMARY KEY NOT NULL,
	"username" varchar NOT NULL,
	"nickname" varchar NOT NULL,
	"password" varchar (255),
	"preference" varchar,
	"avatar" varchar,
	"team" boolean NOT NULL DEFAULT (0),
	CONSTRAINT "UQ_4baf95322bd69fe419c26c5430c" UNIQUE ("username")
);
CREATE UNIQUE INDEX "IDX_357dd5c8dce48c981717076e42" ON "backups" ("uuid" ASC);
CREATE UNIQUE INDEX "IDX_018134254db44b1d2c7cafd642" ON "project_logs" ("uuid" ASC);
CREATE UNIQUE INDEX "IDX_3144ec03a84b838fc172774812" ON "schematics" ("uuid" ASC);
CREATE UNIQUE INDEX "IDX_b22d7f930655e00269912e818c" ON "schematics" (
	"project_uuid" ASC,
	"name" ASC
);
CREATE UNIQUE INDEX "IDX_46e9305a61d8ef1c08668ca606" ON "team_members" ("uuid" ASC);
CREATE UNIQUE INDEX "IDX_951b8f1dfc94ac1d0301a14b7e" ON "users" ("uuid" ASC);
CREATE TABLE IF NOT EXISTS "system_config" (
	"key" varchar PRIMARY KEY NOT NULL,
	"value" varchar NOT NULL
);
CREATE TABLE IF NOT EXISTS "db_paths" (
	"path"  varchar NOT NULL PRIMARY KEY,
	"name"  varchar NOT NULL,
	"version"  varchar NOT NULL,
	"system"  boolean NOT NULL,
	"type"  INTEGER NOT NULL,
	"last_open_time" datetime NOT NULL
);
CREATE INDEX "attributes_device_uuid" ON "attributes" ("device_uuid" ASC);
CREATE INDEX "attributes_key" ON "attributes" ("key" ASC);
CREATE INDEX "attributes_value" ON "attributes" ("value" ASC);
CREATE INDEX "categories_uuid" ON "categories" ("uuid" ASC);
CREATE TABLE IF NOT EXISTS "db_versions" (
	"key" varchar PRIMARY KEY NOT NULL,
	"value" varchar NOT NULL
);
CREATE TABLE IF NOT EXISTS "resources" (
	"hash" varchar PRIMARY KEY NOT NULL,
	"dataStr" varchar NOT NULL,
	"filename" varchar,
	"owner_uuid" varchar,
	"ticket" integer NOT NULL DEFAULT (1)
);
CREATE INDEX "resources_hash" ON "resources" ("hash" ASC);
CREATE INDEX "resources_owner_uuid" ON "resources" ("owner_uuid" ASC);
CREATE TABLE IF NOT EXISTS "texts" (
	"path" varchar NOT NULL,
	"project_uuid" varchar NOT NULL,
	"dataStr" varchar NOT NULL,
	"ticket" integer NOT NULL DEFAULT (1),
	PRIMARY KEY ("path", "project_uuid")
);
CREATE TABLE IF NOT EXISTS "editor_caches" (
	"key" varchar NOT NULL,
	"value" TEXT NOT NULL,
	PRIMARY KEY ("key")
);
CREATE TABLE IF NOT EXISTS "broadcast_messages" (
	"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	"key" varchar NOT NULL,
	"value" varchar NOT NULL,
	"created_at" REAL NOT NULL
);
CREATE TABLE IF NOT EXISTS "components_tmp" (
	"uuid" varchar PRIMARY KEY NOT NULL,
	"title" varchar NOT NULL,
	"display_title" varchar NOT NULL,
	"description" varchar NOT NULL,
	"source" varchar,
	"version" varchar,
	"created_at" datetime NOT NULL DEFAULT (datetime('now')),
	"updated_at" datetime NOT NULL DEFAULT (datetime('now')),
	"ticket" integer NOT NULL,
	"docType" integer NOT NULL,
	"dataStr" text NOT NULL,
	"createTime" datetime NOT NULL DEFAULT (datetime('now')),
	"updateTime" datetime NOT NULL DEFAULT (datetime('now')),
	"modifier_uuid" varchar,
	"creator_uuid" varchar,
	"owner_uuid" varchar,
	"project_uuid" varchar,
	"child_tag" varchar NOT NULL DEFAULT (''),
	"parent_tag" varchar NOT NULL DEFAULT (''),
	'custom_tags' varchar DEFAULT ('')
);
CREATE TABLE IF NOT EXISTS "documents" (
    "uuid" varchar PRIMARY KEY NOT NULL,
    "title" varchar NOT NULL,
    "display_title" varchar NOT NULL,
    "description" varchar NOT NULL,
    "docType" integer NOT NULL,
    "dataStr" text NOT NULL,
    "sheet_id" integer NOT NULL DEFAULT (1),
    "ticket" integer NOT NULL DEFAULT (1),
    "sort_ticket" integer NOT NULL DEFAULT (0),
    "created_at" datetime NOT NULL DEFAULT (datetime('now')),
    "updated_at" datetime NOT NULL DEFAULT (datetime('now')),
    "creator_uuid" varchar,
    "schematic_uuid" varchar,
    "project_uuid" varchar,
    "image" text,
    "parent_uuid" varchar
    );
CREATE UNIQUE INDEX "IDX_00271f3c9caae51f3b6a41b37b" ON "documents" (
    "schematic_uuid" ASC,
    "title" ASC,
    "project_uuid" ASC,
    "docType" ASC
    );
CREATE UNIQUE INDEX "IDX_f6ab4fff7a383f1f14013ab270" ON "documents" ("uuid" ASC);
CREATE TABLE IF NOT EXISTS "component_histories" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "uuid" varchar NOT NULL,
    "parent" varchar NULL,
    "snapshot" varchar NULL,
    "key" varchar NOT NULL,
    "iv" varchar NOT NULL,
    "num" integer NOT NULL DEFAULT (0),
    "created_at" datetime NOT NULL DEFAULT (datetime('now')),
    "updated_at" datetime NOT NULL DEFAULT (datetime('now'))
    );
CREATE TABLE IF NOT EXISTS "branches" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "uuid" varchar NOT NULL,
    "project_uuid" varchar NOT NULL,
    "name" varchar NOT NULL,
    "history_uuid" varchar NULL,
    "creator_uuid" varchar NOT NULL,
    "description" varchar NOT NULL,
    "parent_uuid" varchar NULL,
    "modifier_uuid" varchar NOT NULL,
    "node" integer NOT NULL DEFAULT (0),
    "delete_status" integer NOT NULL DEFAULT (0),
    "created_at" datetime NOT NULL DEFAULT (datetime('now')),
    "updated_at" datetime NOT NULL DEFAULT (datetime('now'))
    );
CREATE TABLE IF NOT EXISTS "branch_locks" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "document_uuid" varchar NOT NULL,
    "user_uuid" varchar NOT NULL,
    "branch_uuid" varchar NOT NULL,
    "created_at" datetime NOT NULL DEFAULT (datetime('now')),
    "updated_at" datetime NOT NULL DEFAULT (datetime('now'))
    );
CREATE TABLE IF NOT EXISTS "project_images" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "uuid"         varchar NOT NULL,
    "ticket" integer NOT NULL DEFAULT (0),
    "project_uuid" varchar NOT NULL,
    "branch_uuid"  varchar NOT NULL,
    "url"          varchar NOT NULL,
    "image_data"          varchar NULL
);
CREATE TABLE IF NOT EXISTS "project_structures" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "ticket"       integer       NOT NULL DEFAULT (0),
    "project_uuid" varchar NOT NULL,
    "branch_uuid"   varchar NOT NULL,
    "structure"    TEXT         NOT NULL
);
CREATE TABLE IF NOT EXISTS "project_histories" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "uuid" varchar NOT NULL,
    "parent" varchar NULL,
    "snapshot" varchar NULL,
    "key" varchar NOT NULL,
    "is_lock" integer NOT NULL DEFAULT (0),
    "num" integer NOT NULL DEFAULT (0),
    "snapshot_num" integer NOT NULL DEFAULT (0),
    "lock_time" datetime NOT NULL DEFAULT ('1970-01-01 08:00:00'),
    "created_at" datetime NOT NULL DEFAULT (datetime('now')),
    "updated_at" datetime NOT NULL DEFAULT (datetime('now'))
    );
CREATE TABLE IF NOT EXISTS "history_data" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "uuid" varchar UNIQUE NOT NULL,
    "history_uuid" varchar NOT NULL,
    "dataStr" TEXT NOT NULL,
    "created_at" datetime NOT NULL DEFAULT (datetime('now')),
    "updated_at" datetime NOT NULL DEFAULT (datetime('now'))
    );
CREATE TABLE IF NOT EXISTS "components" (
    "uuid" varchar PRIMARY KEY NOT NULL,
    "title" varchar NOT NULL,
    "display_title" varchar NOT NULL,
    "description" varchar NOT NULL,
    "source" varchar,
    "version" varchar,
    "created_at" datetime NOT NULL DEFAULT (datetime('now')),
    "updated_at" datetime NOT NULL DEFAULT (datetime('now')),
    "ticket" integer NOT NULL,
    "docType" integer NOT NULL,
    "dataStr" text NOT NULL,
    "createTime" datetime NOT NULL DEFAULT (datetime('now')),
    "updateTime" datetime NOT NULL DEFAULT (datetime('now')),
    "modifier_uuid" varchar,
    "creator_uuid" varchar,
    "owner_uuid" varchar,
    "project_uuid" varchar,
    "child_tag" varchar NOT NULL DEFAULT (''),
    "parent_tag" varchar NOT NULL DEFAULT (''),
    'custom_tags' varchar DEFAULT (''),
    'history_uuid' varchar
    );
CREATE INDEX "IDX_f9312828d80136f7afaf47c554" ON "components" ("project_uuid" ASC,"title" ASC,"docType" ASC);
CREATE UNIQUE INDEX "IDX_fba3398cf283439c13afec000e" ON "components" ("uuid" ASC);
CREATE INDEX "components_updateTime" ON "components" ("updateTime" DESC);
CREATE INDEX "components_docType" ON "components" ("docType" ASC);
CREATE INDEX "components_project_uuid" ON "components" ("project_uuid" ASC);
CREATE TABLE IF NOT EXISTS "devices" (
    "uuid" varchar PRIMARY KEY NOT NULL,
    "description" varchar NOT NULL,
    "title" varchar NOT NULL,
    "display_title" varchar NOT NULL,
    "images" text NOT NULL DEFAULT (''),
    "source" varchar,
    "version" varchar,
    "ticket" integer NOT NULL,
    "footprint_type" integer,
    "symbol_type" integer,
    "created_at" datetime NOT NULL DEFAULT (datetime('now')),
    "updated_at" datetime NOT NULL DEFAULT (datetime('now')),
    "createTime" datetime NOT NULL DEFAULT (datetime('now')),
    "updateTime" datetime NOT NULL DEFAULT (datetime('now')),
    "modifier_uuid" varchar,
    "creator_uuid" varchar,
    "owner_uuid" varchar,
    "project_uuid" varchar NOT NULL,
    "child_tag" varchar NOT NULL DEFAULT (''),
    "parent_tag" varchar NOT NULL DEFAULT (''),
    'custom_tags' varchar DEFAULT (''),
    'history_uuid' varchar
    );
CREATE INDEX "devices_title_owner_uuid_project_uuid" ON "devices" ("project_uuid" ASC,"title" ASC,"owner_uuid" ASC);
CREATE UNIQUE INDEX "IDX_707b5b8b374103d40974e670d3" ON "devices" ("uuid" ASC);
CREATE INDEX "devices_updateTime" ON "devices" ("updateTime" DESC);
CREATE TABLE IF NOT EXISTS "projects"
(
    "uuid" varchar PRIMARY KEY NOT NULL,
    "archive"                   boolean                            NOT NULL,
    "name"                      varchar                            NOT NULL,
    "content"                   varchar                            NOT NULL,
    "cbb_project"               boolean  default 0                 NOT NULL,
    "thumb"                     varchar                            NOT NULL,
    "ticket"                    integer                            NOT NULL,
    "g_ticket"                  integer  default 1                 NOT NULL,
    "owner_uuid"                varchar,
    "creator_uuid"              varchar,
    "created_at"                datetime default (datetime('now')) NOT NULL,
    "updated_at"                datetime default (datetime('now')) NOT NULL,
    "modifier_uuid"             varchar,
    "boards"                    varchar  default '{}'              NOT NULL,
    "block_symbol_attrs_groups" varchar  default '{}'              NOT NULL,
    "pcb_count"                 integer  default 0                 NOT NULL,
    "branch_uuid"               varchar                                null,
    "default_sheet"             text     default ''
    );
CREATE UNIQUE INDEX IDX_fc9f1e64d4626f18beff534a9f
    on projects (uuid);
CREATE TABLE project_history_cf2935424ed64cc5b5fad29630f08c4e (id integer NOT NULL  PRIMARY KEY, uuid varchar NOT NULL   UNIQUE, parent varchar NULL, snapshot varchar NULL, key varchar NOT NULL, is_lock integer NOT NULL DEFAULT 0, num integer NOT NULL DEFAULT 0, created_at datetime NOT NULL DEFAULT (datetime('now')), updated_at datetime NOT NULL DEFAULT (datetime('now')), lock_time datetime NOT NULL DEFAULT (datetime('1970-01-01 08:00:00')), snapshot_num integer NOT NULL DEFAULT 0);
