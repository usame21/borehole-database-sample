-- Borehole database (sample design, MySQL 8)
-- Practice project with invented data. Not an official ministry product.

CREATE DATABASE IF NOT EXISTS borehole_sample;
USE borehole_sample;

DROP TABLE IF EXISTS wells;

CREATE TABLE wells (
    well_id          VARCHAR(20)  NOT NULL,   -- format: REG-<region>-S<sub-district>-<number>
    region           VARCHAR(50)  NOT NULL,
    sub_district     VARCHAR(80)  NOT NULL,
    depth_m          INT          NULL,
    drilled_year     INT          NULL,
    status           VARCHAR(25)  NOT NULL,
    failure_reason   VARCHAR(40)  NULL,       -- standardized categories, only set when not functional
    manager_name     VARCHAR(80)  NULL,
    manager_phone    VARCHAR(20)  NULL,
    last_status_date DATE         NULL,
    PRIMARY KEY (well_id),
    CONSTRAINT chk_status CHECK (status IN ('Functional','Partially functional','Non-functional')),
    CONSTRAINT chk_reason CHECK (
        failure_reason IS NULL OR failure_reason IN
        ('Pump failure','Power supply','Water table drop','Pipe leak','Structural damage')
    ),
    CONSTRAINT chk_reason_status CHECK (
        (status = 'Functional' AND failure_reason IS NULL) OR status <> 'Functional'
    )
);

CREATE INDEX idx_wells_region ON wells (region);
CREATE INDEX idx_wells_status ON wells (status);
