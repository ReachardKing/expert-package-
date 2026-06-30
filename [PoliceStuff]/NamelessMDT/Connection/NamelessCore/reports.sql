CREATE TABLE IF NOT EXISTS incidents (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `report_id` varchar(255) NOT NULL,
    `data` LONGTEXT DEFAULT '[]',
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    primary key (`id`) using BTREE,
);
