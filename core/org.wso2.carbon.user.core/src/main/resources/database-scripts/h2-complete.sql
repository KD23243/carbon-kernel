CREATE TABLE REG_CLUSTER_LOCK (
                    REG_LOCK_NAME VARCHAR (20),
                    REG_LOCK_STATUS VARCHAR (20),
                    REG_LOCKED_TIME TIMESTAMP,
                    PRIMARY KEY (REG_LOCK_NAME));

CREATE TABLE REG_CONTENT (
                    REG_CONTENT_ID VARCHAR (50),
                    REG_CONTENT_DATA BINARY,
                    PRIMARY KEY (REG_CONTENT_ID));

CREATE TABLE REG_RESOURCE (
                    REG_RID VARCHAR (50),
                    REG_PATH VARCHAR (2000) NOT NULL,
                    REG_MEDIA_TYPE VARCHAR (500),
                    REG_COLLECTION INTEGER NOT NULL,
                    REG_CREATOR VARCHAR (500),
                    REG_CREATED_TIME TIMESTAMP,
                    REG_LAST_UPDATOR VARCHAR (500),
                    REG_LAST_UPDATED_TIME TIMESTAMP,
                    REG_DESCRIPTION VARCHAR (10000),
                    REG_CONTENT_ID VARCHAR (50),
                    REG_EQUIVALENT_VERSION INTEGER NOT NULL,
                    REG_ASSOCIATED_SNAPSHOT_ID INTEGER NOT NULL,
                    PRIMARY KEY (REG_RID),
                    FOREIGN KEY (REG_CONTENT_ID) REFERENCES REG_CONTENT (REG_CONTENT_ID),
                    UNIQUE(REG_PATH));

CREATE TABLE REG_DEPENDENCY (
                    REG_DEPENDENCY_ID INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    REG_PARENT_RID VARCHAR (50) NOT NULL,
                    REG_CHILD_RID VARCHAR (50) NOT NULL,
                    PRIMARY KEY (REG_DEPENDENCY_ID),
                    UNIQUE (REG_PARENT_RID, REG_CHILD_RID),
                    FOREIGN KEY (REG_PARENT_RID) REFERENCES REG_RESOURCE (REG_RID) ON DELETE CASCADE,
                    FOREIGN KEY (REG_CHILD_RID) REFERENCES REG_RESOURCE (REG_RID) ON DELETE CASCADE);

CREATE TABLE REG_PROPERTY (
                    REG_PROPERTY_ID INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    REG_RID VARCHAR (50) NOT NULL,
                    REG_NAME VARCHAR (100) NOT NULL,
                    REG_PROPERTY_VALUE VARCHAR (1000),
                    PRIMARY KEY (REG_PROPERTY_ID),
                    FOREIGN KEY (REG_RID) REFERENCES REG_RESOURCE (REG_RID));

CREATE TABLE REG_ASSOCIATION (
                    REG_ASSOCIATION_ID INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    REG_SOURCEPATH VARCHAR (2000) NOT NULL,
                    REG_TARGETPATH VARCHAR (2000) NOT NULL,
                    REG_ASSOCIATION_TYPE VARCHAR (2000) NOT NULL,
                    PRIMARY KEY (REG_ASSOCIATION_ID),
                    UNIQUE (REG_SOURCEPATH, REG_TARGETPATH, REG_ASSOCIATION_TYPE));

CREATE TABLE REG_TAG (
                    REG_TAG_ID INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    REG_TAG_NAME VARCHAR (500) NOT NULL,
                    REG_RID VARCHAR (50) NOT NULL,
                    REG_USER_ID VARCHAR (255) NOT NULL,
                    REG_TAGGED_TIME TIMESTAMP NOT NULL,
                    PRIMARY KEY (REG_TAG_ID),
                    UNIQUE (REG_TAG_NAME, REG_RID, REG_USER_ID));

CREATE TABLE REG_COMMENT (
                    REG_COMMENT_ID INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    REG_RID VARCHAR (50) NOT NULL,
                    REG_USER_ID VARCHAR (255) NOT NULL,
                    REG_COMMENT_TEXT VARCHAR (500) NOT NULL,
                    REG_COMMENTED_TIME TIMESTAMP NOT NULL,
                    PRIMARY KEY (REG_COMMENT_ID));

CREATE TABLE REG_RATING (
                    REG_RATING_ID INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    REG_RID VARCHAR (50) NOT NULL,
                    REG_USER_ID VARCHAR (255) NOT NULL,
                    REG_RATING INTEGER NOT NULL,
                    REG_RATED_TIME TIMESTAMP NOT NULL,
                    PRIMARY KEY (REG_RATING_ID));

CREATE TABLE REG_LOG (
                    REG_LOG_ID INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    REG_PATH VARCHAR (2000),
                    REG_USER_ID VARCHAR (255) NOT NULL,
                    REG_LOGGED_TIME TIMESTAMP NOT NULL,
                    REG_ACTION INTEGER NOT NULL,
                    REG_ACTION_DATA VARCHAR (500),
                    PRIMARY KEY (REG_LOG_ID));

CREATE TABLE REG_CONTENT_VERSION (
                    REG_CONTENT_VERSION_ID VARCHAR (50),
                    REG_CONTENT_DATA BINARY,
                    PRIMARY KEY (REG_CONTENT_VERSION_ID));

CREATE TABLE REG_RESOURCE_VERSION (
                    REG_RESOURCE_VERSION_ID INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    REG_RID VARCHAR (50) NOT NULL,
                    REG_VERSION INTEGER NOT NULL,
                    REG_PATH VARCHAR (2000) NOT NULL,
                    REG_MEDIA_TYPE VARCHAR (500),
                    REG_COLLECTION INTEGER NOT NULL,
                    REG_CREATOR VARCHAR (500),
                    REG_CREATED_TIME TIMESTAMP,
                    REG_LAST_UPDATOR VARCHAR (500),
                    REG_LAST_UPDATED_TIME TIMESTAMP,
                    REG_DESCRIPTION VARCHAR (10000),
                    REG_CONTENT_ID VARCHAR (50),
                    REG_ASSOCIATED_SNAPSHOT_ID INTEGER NOT NULL,
                    FOREIGN KEY (REG_CONTENT_ID) REFERENCES REG_CONTENT_VERSION (REG_CONTENT_VERSION_ID),
                    PRIMARY KEY (REG_RESOURCE_VERSION_ID),
                    UNIQUE(REG_RID, REG_VERSION));

CREATE TABLE REG_DEPENDENCY_VERSION (
                    REG_DEPENDENCY_VERSION_ID INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    REG_PARENT_RID VARCHAR (50) NOT NULL,
                    REG_PARENT_VERSION INTEGER NOT NULL,
                    REG_CHILD_RID VARCHAR (50) NOT NULL,
                    PRIMARY KEY (REG_DEPENDENCY_VERSION_ID),
                    UNIQUE (REG_PARENT_RID, REG_PARENT_VERSION, REG_CHILD_RID));

CREATE TABLE REG_PROPERTY_VERSION (
                    REG_PROPERTY_VERSION_ID INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    REG_RID VARCHAR (50) NOT NULL,
                    REG_VERSION INTEGER NOT NULL,
                    REG_NAME VARCHAR (100) NOT NULL,
                    REG_PROPERTY_VALUE VARCHAR (1000),
                    PRIMARY KEY (REG_PROPERTY_VERSION_ID),
                    FOREIGN KEY (REG_RID, REG_VERSION) REFERENCES REG_RESOURCE_VERSION (REG_RID, REG_VERSION));

CREATE TABLE REG_SNAPSHOT (
                    REG_SNAPSHOT_ID INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    REG_ROOT_ID VARCHAR (50) NOT NULL,
                    PRIMARY KEY (REG_SNAPSHOT_ID),
                    UNIQUE (REG_SNAPSHOT_ID, REG_ROOT_ID));

CREATE INDEX REG_INDEX_SNAPSHOT_ROOT_ID ON REG_SNAPSHOT (REG_ROOT_ID);

CREATE TABLE REG_SNAPSHOT_RESOURCE_VERSION (
                    REG_SRV_ID INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    REG_SNAPSHOT_ID INTEGER NOT NULL,
                    REG_RID VARCHAR (50) NOT NULL,
                    REG_VERSION INTEGER NOT NULL,
                    PRIMARY KEY (REG_SRV_ID),
                    UNIQUE (REG_SNAPSHOT_ID, REG_RID, REG_VERSION));

CREATE TABLE UM_USERS (
			ID INTEGER GENERATED ALWAYS AS IDENTITY,
			USER_NAME VARCHAR(255) NOT NULL,
			USER_PASSWORD VARCHAR(255) NOT NULL,
			PRIMARY KEY (ID),
			UNIQUE(USER_NAME));

CREATE TABLE IF NOT EXISTS UM_SYSTEM_USER (
			UM_ID INTEGER NOT NULL AUTO_INCREMENT,
			UM_USER_NAME VARCHAR(255) NOT NULL,
			UM_USER_PASSWORD VARCHAR(255) NOT NULL,
			UM_SALT_VALUE VARCHAR(31),
			UM_REQUIRE_CHANGE BOOLEAN DEFAULT FALSE,
            UM_CHANGED_TIME TIMESTAMP NOT NULL,
			UM_TENANT_ID INTEGER DEFAULT 0,
			PRIMARY KEY (UM_ID, UM_TENANT_ID),
			UNIQUE(UM_USER_NAME, UM_TENANT_ID));

CREATE TABLE UM_USER_ATTRIBUTES (
			ID INTEGER GENERATED ALWAYS AS IDENTITY,
			ATTR_NAME VARCHAR(255) NOT NULL,
			ATTR_VALUE VARCHAR(255),
			USER_ID INTEGER,
			FOREIGN KEY (USER_ID) REFERENCES UM_USERS(ID) ON DELETE CASCADE,
			PRIMARY KEY (ID));

CREATE TABLE UM_ROLES (
			ID INTEGER GENERATED ALWAYS AS IDENTITY,
			ROLE_NAME VARCHAR(255) NOT NULL,
			PRIMARY KEY (ID),
			UNIQUE(ROLE_NAME));

CREATE TABLE UM_ROLE_ATTRIBUTES (
			ID INTEGER GENERATED ALWAYS AS IDENTITY,
			ATTR_NAME VARCHAR(255) NOT NULL,
			ATTR_VALUE VARCHAR(255),
			ROLE_ID INTEGER,
			FOREIGN KEY (ROLE_ID) REFERENCES UM_ROLES(ID) ON DELETE CASCADE,
			PRIMARY KEY (ID));

CREATE TABLE UM_PERMISSIONS (
			ID INTEGER GENERATED ALWAYS AS IDENTITY,
			RESOURCE_ID VARCHAR(255) NOT NULL,
			ACTION VARCHAR(255) NOT NULL,
			PRIMARY KEY (ID));

CREATE INDEX INDEX_UM_PERMISSIONS_RESOURCE_ID_ACTION ON UM_PERMISSIONS (RESOURCE_ID, ACTION);

CREATE TABLE UM_ROLE_PERMISSIONS (
			ID INTEGER GENERATED ALWAYS AS IDENTITY,
			PERMISSION_ID INTEGER NOT NULL,
			ROLE_ID INTEGER NOT NULL,
			IS_ALLOWED SMALLINT NOT NULL,
			UNIQUE (PERMISSION_ID, ROLE_ID),
			FOREIGN KEY (PERMISSION_ID) REFERENCES UM_PERMISSIONS(ID) ON DELETE  CASCADE,
			FOREIGN KEY (ROLE_ID) REFERENCES UM_ROLES(ID) ON DELETE CASCADE,
			PRIMARY KEY (ID));

CREATE TABLE UM_USER_PERMISSIONS (
			ID INTEGER GENERATED ALWAYS AS IDENTITY,
			PERMISSION_ID INTEGER NOT NULL,
			USER_ID INTEGER NOT NULL,
			IS_ALLOWED SMALLINT NOT NULL,
			UNIQUE (PERMISSION_ID, USER_ID),
			FOREIGN KEY (PERMISSION_ID) REFERENCES UM_PERMISSIONS(ID) ON DELETE CASCADE,
			FOREIGN KEY (USER_ID) REFERENCES UM_USERS(ID) ON DELETE CASCADE,
			PRIMARY KEY (ID));

CREATE TABLE UM_USER_ROLES (
			ID INTEGER GENERATED ALWAYS AS IDENTITY,
			ROLE_ID INTEGER NOT NULL,
			USER_ID INTEGER NOT NULL,
			UNIQUE (USER_ID, ROLE_ID),
			FOREIGN KEY (ROLE_ID) REFERENCES UM_ROLES(ID) ON DELETE CASCADE,
			FOREIGN KEY (USER_ID) REFERENCES UM_USERS(ID) ON DELETE CASCADE,
			PRIMARY KEY (ID));

CREATE TABLE IF NOT EXISTS UM_SYSTEM_ROLE(
       UM_ID INTEGER NOT NULL AUTO_INCREMENT,
       UM_ROLE_NAME VARCHAR(255),
       UM_TENANT_ID INTEGER DEFAULT 0,
       PRIMARY KEY (UM_ID, UM_TENANT_ID));

CREATE TABLE IF NOT EXISTS UM_SYSTEM_USER_ROLE(
       UM_ID INTEGER NOT NULL AUTO_INCREMENT,
       UM_USER_NAME VARCHAR(255),
       UM_ROLE_ID INTEGER NOT NULL,
       UM_TENANT_ID INTEGER DEFAULT 0,
       UNIQUE (UM_USER_NAME, UM_ROLE_ID, UM_TENANT_ID),
       FOREIGN KEY (UM_ROLE_ID, UM_TENANT_ID) REFERENCES UM_SYSTEM_ROLE(UM_ID, UM_TENANT_ID),
       PRIMARY KEY (UM_ID, UM_TENANT_ID));