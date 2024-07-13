-- --------------------------------------------------------------------------------------------------

CREATE TABLE printshop_catalog.boxes (
    box_id int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY CONSTRAINT pk_boxes PRIMARY KEY,
    tag_version int4 NOT NULL DEFAULT 1 CHECK(tag_version > 0),
    box_article character varying(32) NULL,
    box_caption character varying(64) NOT NULL,
    box_length double precision NOT NULL, -- meter
    box_width double precision NOT NULL, -- meter
    box_height double precision NOT NULL, -- meter
    box_thickness double precision NOT NULL, -- meter
    box_weight double precision NOT NULL, -- kilogram
    box_status int2 NOT NULL, -- 1=DRAFT, 2=ENABLED, 3=DISABLED
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone NULL,
    deleted_at timestamp with time zone NULL
);

CREATE UNIQUE INDEX uk_boxes_box_article ON printshop_catalog.boxes (box_article) WHERE deleted_at IS NULL;

-- --------------------------------------------------------------------------------------------------

INSERT INTO printshop_catalog.boxes (box_id, tag_version, box_article, box_caption, box_length, box_width, box_height, box_thickness, box_weight, box_status, created_at, updated_at, deleted_at)
VALUES
    (1, 1, 'T-21-310x260x380', 'СДЭК', 0.310, 0.260, 0.380, 0.002, 1, 2/*ENABLED*/, '2023-07-28 19:47:00.917593', NULL, NULL),
    (2, 1, 'T-23-300x300x300', 'СДЭК', 0.300, 0.300, 0.300, 0.002, 15.160, 2/*ENABLED*/, '2023-07-28 19:49:04.261215', NULL, NULL),
    (3, 1, 'T-23-310x230x195', 'СДЭК', 0.310, 0.230, 0.195, 0.002, 7.400, 2/*ENABLED*/, '2023-07-30 12:28:57.095098', NULL, NULL);

ALTER SEQUENCE printshop_catalog.boxes_box_id_seq RESTART WITH 4;