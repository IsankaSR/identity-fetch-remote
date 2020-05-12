IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_REMOTE_FETCH_CONFIG]') AND TYPE IN (N'U'))
CREATE TABLE IDN_REMOTE_FETCH_CONFIG (
  ID VARCHAR(255) NOT NULL,
  TENANT_ID	INTEGER	 NOT NULL,
  IS_ENABLED CHAR(1) NOT NULL,
  REPO_MANAGER_TYPE  VARCHAR(255) NOT NULL,
  ACTION_LISTENER_TYPE VARCHAR(255) NOT NULL,
  CONFIG_DEPLOYER_TYPE VARCHAR(255) NOT NULL,
  REMOTE_FETCH_NAME VARCHAR(255),
  REMOTE_RESOURCE_URI VARCHAR(255) NOT NULL,
  ATTRIBUTES_JSON TEXT NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT UC_REMOTE_RESOURCE_URI UNIQUE (REMOTE_RESOURCE_URI)
);

IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_REMOTE_FETCH_REVISIONS]') AND TYPE IN (N'U'))
CREATE TABLE IDN_REMOTE_FETCH_REVISIONS (
  ID VARCHAR(255) NOT NULL,
  CONFIG_ID VARCHAR(255) NOT NULL,
  FILE_PATH VARCHAR(255) NOT NULL,
  FILE_HASH VARCHAR(255),
  DEPLOYED_DATE DATETIME,
  DEPLOYMENT_STATUS VARCHAR(255),
  ITEM_NAME 	VARCHAR(255),
  DEPLOY_ERR_LOG TEXT,
  PRIMARY KEY (ID),
  FOREIGN KEY (CONFIG_ID) REFERENCES IDN_REMOTE_FETCH_CONFIG(ID) ON DELETE CASCADE,
  CONSTRAINT UC_REVISIONS UNIQUE (CONFIG_ID,ITEM_NAME)
);
