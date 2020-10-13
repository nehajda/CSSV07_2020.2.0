/* Uncomment this section if you need to drop tables for schema refresh

DROP TABLE MS_RPLYBL_MSGS;

DROP TABLE MS_MSG_EVNT;
DROP TABLE MS_MSG_HDR;
DROP TABLE MS_MSG_BDY;

DROP TABLE MS_RCRD_EVNT;
DROP TABLE MS_RCRD_HDR;
DROP TABLE MS_BLK_EVNT;
DROP TABLE MS_BLK_HDR;
DROP TABLE MS_VER; 
DROP TABLE MS_BLK_INGSTN_EVNT;
DROP TABLE MS_BLK_INGSTN;
DROP TABLE MS_INGSTN_RCRD;
DROP TABLE MS_USER_DATA;

*/

CREATE TABLE MS_BLK_EVNT 
( 
	 BLK_EVNT_ID NUMERIC(16) NOT NULL IDENTITY(1,1) ,
     BLK_HDR_ID NUMERIC (16) NOT NULL ,
     STATUS VARCHAR (64) NOT NULL ,
     CRTD_AT DATETIME NOT NULL ,
     BTCH_ID VARCHAR (255) ,
     BTCH_TASK VARCHAR (255) ,
     BTCH_TOT_REC NUMERIC (16) , 
     BTCH_PRC_REC NUMERIC (16) , 
     BTCH_SUC_REC NUMERIC (16) , 
     BTCH_FLD_REC NUMERIC (16) , 
     ERR_CODE VARCHAR (64) ,
     ERR_DESC VARCHAR (1024),
	 CONNECT_ERR NVARCHAR (MAX)
)


EXEC sp_addextendedproperty 'MS_Description' , 'Table that holds information about  events associated with  Bulk Messages' , 'USER' , 'dbo' , 'TABLE' , 'MS_BLK_EVNT'

ALTER TABLE MS_BLK_EVNT ADD CONSTRAINT BLK_EVNT_ID_PK PRIMARY KEY CLUSTERED (BLK_EVNT_ID)

CREATE TABLE MS_BLK_HDR 
( 
	 BLK_HDR_ID NUMERIC(16) NOT NULL IDENTITY(1,1) , 
     CRTD_AT DATETIME NOT NULL , 
     LST_UPDT_AT DATETIME NOT NULL , 
     CRNT_STATUS VARCHAR (255) , 
     SRVC_TYPE VARCHAR (255) NOT NULL , 
     SRVC_NAME VARCHAR (255) NOT NULL , 
     SRVC_VER VARCHAR (255) , 
     SRVC_INST VARCHAR (255) NOT NULL , 
     SRVC_HOST VARCHAR (255) , 
     END_PNT_TYPE VARCHAR (255) NOT NULL , 
     END_PNT_NAME VARCHAR (255) NOT NULL , 
     MDL_TYPE VARCHAR (255) NOT NULL ,
     BLK_ID VARCHAR (255) NOT NULL , 
     BLK_TYPE VARCHAR (255) NOT NULL , 
     BLK_VER VARCHAR (255) NOT NULL , 
     BLK_SRC VARCHAR (255) NOT NULL , 
     BLK_LOC VARCHAR (255) NOT NULL , 
     BLK_FORMAT VARCHAR (255) NOT NULL , 
     BLK_SRC_ID VARCHAR (255) 
)

EXEC sp_addextendedproperty 'MS_Description' , 'Table that holds Bulk level Message Header information.' , 'USER' , 'dbo' , 'TABLE' , 'MS_BLK_HDR'

ALTER TABLE MS_BLK_HDR ADD CONSTRAINT BLK_HDR_ID_PK PRIMARY KEY CLUSTERED (BLK_HDR_ID)

ALTER TABLE MS_BLK_HDR ADD CONSTRAINT BLK_HDR_DTLS_UK UNIQUE NONCLUSTERED (SRVC_NAME, BLK_SRC, BLK_ID)

CREATE TABLE MS_MSG_BDY 
( 
	 MSG_BDY_ID NUMERIC(16) NOT NULL IDENTITY(1,1) , 
     CRTD_AT DATETIME NOT NULL , 
     MSG_FRMT VARCHAR (64) NOT NULL , 
     MSG_BDY NVARCHAR (MAX) NOT NULL 
)

EXEC sp_addextendedproperty 'MS_Description' , 'Table that saves the  body of a  Message' , 'USER' , 'dbo' , 'TABLE' , 'MS_MSG_BDY'

ALTER TABLE MS_MSG_BDY ADD CONSTRAINT msg_bdy_id_pk PRIMARY KEY CLUSTERED (MSG_BDY_ID)

CREATE TABLE MS_MSG_EVNT 
( 
	 MSG_EVNT_ID NUMERIC(16) NOT NULL IDENTITY(1,1) , 
     MSG_HDR_ID NUMERIC (16) NOT NULL ,
     MSG_BDY_ID NUMERIC (16) NOT NULL , 
     STATUS VARCHAR (64) NOT NULL , 
     CRTD_AT DATETIME NOT NULL , 
     ERR_CODE VARCHAR (64) , 
     ERR_DESC VARCHAR (1024),
	 CONNECT_ERR NVARCHAR (MAX)
)

EXEC sp_addextendedproperty 'MS_Description' , 'Table which contains events associated with a Message' , 'USER' , 'dbo' , 'TABLE' , 'MS_MSG_EVNT'

ALTER TABLE MS_MSG_EVNT ADD CONSTRAINT MSG_EVNT_ID_PK PRIMARY KEY CLUSTERED (MSG_EVNT_ID)



CREATE TABLE MS_MSG_HDR 
( 
	MSG_HDR_ID NUMERIC(16) NOT NULL IDENTITY(1,1) , 
     MSG_BDY_ID NUMERIC (16) NOT NULL, 
     CRTD_AT DATETIME NOT NULL , 
     LST_UPDT_AT DATETIME NOT NULL , 
     CRNT_STATUS VARCHAR (255) , 
     D_DUP_KEY VARCHAR (255) NOT NULL , 
     SRVC_TYPE VARCHAR (255) NOT NULL , 
     SRVC_NAME VARCHAR (255) NOT NULL , 
     SRVC_VER VARCHAR (255) , 
     SRVC_INST VARCHAR (255) NOT NULL , 
     SRVC_HOST VARCHAR (255) , 
     END_PNT_TYPE VARCHAR (255) NOT NULL , 
     END_PNT_NAME VARCHAR (255) NOT NULL , 
     MDL_TYPE VARCHAR (255) NOT NULL , 
     MSG_CAT VARCHAR (255) NOT NULL , 
     MSG_TYPE VARCHAR (255) NOT NULL , 
     MSG_VER VARCHAR (255) NOT NULL , 
     MSG_ID VARCHAR (255) NOT NULL , 
     MSG_SNDR VARCHAR (255) , 
     MSG_RCVRS VARCHAR (255) , 
     DOC_ID VARCHAR (255) , 
     DOC_CUST_ID VARCHAR (255) , 
     DOC_TMSTMP DATETIME ,
     REF_MSG_SNDR VARCHAR (255) ,
     REF_MSG_ID VARCHAR (255) , 
     REF_DOC_ID VARCHAR (255) , 
     TST_MSG NUMERIC (1) DEFAULT 0 
    )
 
EXEC sp_addextendedproperty 'MS_Description' , 'Table that saves Header level information associated to a Message' , 'USER' , 'dbo' , 'TABLE' , 'MS_MSG_HDR'

ALTER TABLE MS_MSG_HDR ADD CONSTRAINT MSG_HDR_ID_PK PRIMARY KEY CLUSTERED (MSG_HDR_ID)

ALTER TABLE ms_msg_hdr add CONSTRAINT MSG_HDR_DDUP_UK unique nonclustered ( D_DUP_KEY )


CREATE TABLE MS_RCRD_EVNT 
( 
	 BLK_RCRD_EVNT_ID NUMERIC(16) NOT NULL IDENTITY(1,1) , 
     RCRD_HDR_ID NUMERIC (16) NOT NULL , 
     TASK_NAME VARCHAR (255),
     TASK_ID VARCHAR (255),
     STATUS VARCHAR (64) NOT NULL , 
     CRTD_AT DATETIME NOT NULL , 
     ERR_CODE VARCHAR (64) , 
     ERR_DESC VARCHAR (1024),
	 CONNECT_ERR NVARCHAR (MAX)
)

EXEC sp_addextendedproperty 'MS_Description' , 'Table that saves information about events associated with a Record' , 'USER' , 'dbo' , 'TABLE' , 'MS_RCRD_EVNT'

ALTER TABLE MS_RCRD_EVNT ADD CONSTRAINT BLK_RCRD_EVNT_ID_PK PRIMARY KEY CLUSTERED (BLK_RCRD_EVNT_ID)


CREATE TABLE MS_RCRD_HDR 
( 
	 BLK_RCRD_HDR_ID NUMERIC(16) NOT NULL IDENTITY(1,1) , 
     BLK_HDR_ID NUMERIC (16) NOT NULL , 
     CRTD_AT DATETIME NOT NULL , 
     LST_UPDT_AT DATETIME NOT NULL ,
     LST_TASK VARCHAR (255) , 
     CRNT_STATUS VARCHAR (255) NOT NULL , 
     RCRD_ID VARCHAR (255) NOT NULL , 
     SEQ_NO NUMERIC (16) NOT NULL , 
     RCRD_HDR_BODY NVARCHAR (MAX) 
)

EXEC sp_addextendedproperty 'MS_Description' , 'Table that saves  Record level information. A bulk is made of one or more records' , 'USER' , 'dbo' , 'TABLE' , 'MS_RCRD_HDR'

ALTER TABLE MS_RCRD_HDR ADD CONSTRAINT BLK_RCRD_HDR_ID_PK PRIMARY KEY CLUSTERED (BLK_RCRD_HDR_ID)

ALTER TABLE MS_RCRD_HDR ADD CONSTRAINT BLK_HDRRCRD_ID_UK UNIQUE NONCLUSTERED (BLK_HDR_ID, RCRD_ID)


CREATE TABLE MS_VER 
(
    VER       VARCHAR(255) NOT NULL,
    CRTD_AT   DATETIME NOT NULL
)

EXEC sp_addextendedproperty 'MS_Description' , 'Table to save schema version information' , 'USER' , 'dbo' , 'TABLE' , 'MS_VER'

ALTER TABLE MS_VER ADD CONSTRAINT MSG_VER_UK UNIQUE NONCLUSTERED ( VER )

ALTER TABLE MS_RCRD_HDR ADD CONSTRAINT BLK_RCRD_HDRID_FK FOREIGN KEY ( BLK_HDR_ID ) REFERENCES MS_BLK_HDR ( BLK_HDR_ID ) ON DELETE CASCADE

ALTER TABLE MS_RCRD_EVNT ADD CONSTRAINT BLK_RCRDHDR_ID_FK FOREIGN KEY ( RCRD_HDR_ID ) REFERENCES MS_RCRD_HDR ( BLK_RCRD_HDR_ID ) ON DELETE CASCADE

ALTER TABLE MS_BLK_EVNT ADD CONSTRAINT BLK_HDRID_FK FOREIGN KEY ( BLK_HDR_ID ) REFERENCES MS_BLK_HDR ( BLK_HDR_ID ) ON DELETE CASCADE

ALTER TABLE MS_MSG_EVNT ADD CONSTRAINT MSG_EVNT_BDY_ID_FK FOREIGN KEY ( MSG_BDY_ID ) REFERENCES MS_MSG_BDY ( MSG_BDY_ID ) ON DELETE CASCADE

ALTER TABLE MS_MSG_HDR ADD CONSTRAINT MSG_HDR_BDY_ID_FK FOREIGN KEY ( MSG_BDY_ID ) REFERENCES MS_MSG_BDY ( MSG_BDY_ID ) ON DELETE CASCADE

/*
Add current version
*/

INSERT INTO MS_VER(VER, CRTD_AT) VALUES('2020.1.0', CURRENT_TIMESTAMP);


/*
   Create replayable messages schema 
*/

CREATE TABLE MS_RPLYBL_MSGS
( 
     RPLYBL_MSG_ID   NUMERIC(16) NOT NULL IDENTITY(1,1) , 
     CRTD_AT         DATETIME NOT NULL , 
     LST_UPDT_AT     DATETIME NOT NULL , 
     MSG_STORE_ID    NUMERIC(16) NOT NULL, 
     RPLY_COUNT      NUMERIC (16) DEFAULT 0, 
     NXT_RUN_AT      DATETIME NOT NULL,
     ACTIVE          NUMERIC (1) DEFAULT 1,
     RPLYNG          NUMERIC (1) DEFAULT 0
);
 
EXEC sp_addextendedproperty 'MS_Description' , 'Table that saves Replay level information associated to a Message' , 'USER' , 'dbo' , 'TABLE' , 'MS_RPLYBL_MSGS';

ALTER TABLE MS_RPLYBL_MSGS ADD CONSTRAINT RPLYBL_MSG_ID_PK PRIMARY KEY CLUSTERED (RPLYBL_MSG_ID);

ALTER TABLE MS_RPLYBL_MSGS add CONSTRAINT MSG_STORE_ID_UK unique nonclustered ( MSG_STORE_ID );

ALTER TABLE MS_RPLYBL_MSGS ADD CONSTRAINT RPLYBL_MSGS_HDR_ID_FK FOREIGN KEY ( MSG_STORE_ID ) REFERENCES MS_MSG_HDR ( MSG_HDR_ID ) ON DELETE CASCADE;


/*
   Create bulk ingestion related schema 
*/
CREATE TABLE MS_INGSTN_RCRD 
(
    INGSTN_RCRD_ID  NUMERIC(16) NOT NULL IDENTITY(1,1),
    CRTD_AT        DATETIME NOT NULL,
    SRVC_NAME      VARCHAR(255) NOT NULL,
    SRVC_INST      VARCHAR(255),
	BULK_ID		   VARCHAR(255) NOT NULL,
    BLK_LOC        VARCHAR(255) NOT NULL    
);

EXEC sp_addextendedproperty 'MS_Description' , 'Table that saves bulk ingestion records' , 'USER' , 'dbo' , 'TABLE' , 'MS_INGSTN_RCRD'	

ALTER TABLE MS_INGSTN_RCRD ADD CONSTRAINT INGSTN_RCRD_ID_PK PRIMARY KEY ( INGSTN_RCRD_ID );

ALTER TABLE MS_INGSTN_RCRD ADD CONSTRAINT INGSTN_RCRD_UK UNIQUE ( SRVC_NAME, BULK_ID );

CREATE TABLE MS_BLK_INGSTN 
(
    BLK_INGSTN_ID  NUMERIC(16) NOT NULL IDENTITY(1,1),
    LST_INGSTD_AT  DATETIME NOT NULL,
    BLK_INGSTN_RCRD_ID        NUMERIC(16) NOT NULL,
    ING_SRVC_NAME      VARCHAR(255) NOT NULL,
    CUR_POS            NUMERIC(16) NOT NULL    
);

EXEC sp_addextendedproperty 'MS_Description' , 'Table that keeps track of the bulk ingestions' , 'USER' , 'dbo' , 'TABLE' , 'MS_BLK_INGSTN'	

ALTER TABLE MS_BLK_INGSTN ADD CONSTRAINT BLK_INGSTN_ID_PK PRIMARY KEY ( BLK_INGSTN_ID );

ALTER TABLE MS_BLK_INGSTN ADD CONSTRAINT BLK_INGSTN_UK UNIQUE ( BLK_INGSTN_RCRD_ID, ING_SRVC_NAME );

ALTER TABLE MS_BLK_INGSTN ADD CONSTRAINT MS_BULK_INGSTN_FK FOREIGN KEY ( BLK_INGSTN_RCRD_ID ) REFERENCES MS_INGSTN_RCRD ( INGSTN_RCRD_ID ) ON DELETE CASCADE;

CREATE TABLE MS_BLK_INGSTN_EVNT 
(
    BLK_INGSTN_EVNT_ID        NUMERIC(16) NOT NULL IDENTITY(1,1),
	BLK_INGSTN_ID        NUMERIC(16) NOT NULL,
    INGSTD_AT  DATETIME NOT NULL,
    ING_SRVC_INST      VARCHAR(255),    
    STRT_POS       NUMERIC(16) NOT NULL,
    END_POS       NUMERIC(16) NOT NULL
);

EXEC sp_addextendedproperty 'MS_Description' , 'Table that captures the ingestion events of a service' , 'USER' , 'dbo' , 'TABLE' , 'MS_BLK_INGSTN_EVNT'		

ALTER TABLE MS_BLK_INGSTN_EVNT ADD CONSTRAINT MS_BULK_INGSTN_EVNT_FK FOREIGN KEY ( BLK_INGSTN_ID ) REFERENCES MS_BLK_INGSTN ( BLK_INGSTN_ID ) ON DELETE CASCADE;

/*
   Create user data related schema 
*/

CREATE TABLE MS_USER_DATA
(
	USER_ID		VARCHAR(255)	PRIMARY KEY ,
	USER_DATA	VARCHAR(4000)	NOT NULL ,
	CREATED_AT	DATETIME		NOT NULL
);