CREATE TABLE IF NOT EXISTS records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    `character` INT(11) DEFAULT NULL,
    `incidents` LONGTEXT DEFAULT `[]`,
    INDEX `character` (`character`) USING BTREE,
    CONSTRAINT `records_character_fk` FOREIGN KEY (`character`) REFERENCES `characters` (`characterid`) ON DELETE CASCADE ON UPDATE CASCADE
);