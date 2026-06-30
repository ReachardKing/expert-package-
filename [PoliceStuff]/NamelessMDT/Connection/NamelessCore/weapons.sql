CREATE TABLE IF NOT EXISTS weapons (
    `character` INT(11) DEFAULT NULL,
    `weapon` varchar(50) DEFAULT NULL,,
    `serial` varchar(50) DEFAULT NULL,
    index `NC_WEpons_Character` (`character`) USING BTREE, CONSTRAINT `NC_WEpons_Character` FOREIGN KEY (`character`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
);
