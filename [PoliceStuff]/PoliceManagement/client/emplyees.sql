
CREATE TABLE IF NOT EXISTS `characters` (
    `charid` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(64) NOT NULL,        -- Player identifier (license or steam)
    `firstname` VARCHAR(50) NOT NULL,
    `lastname` VARCHAR(50) NOT NULL,
    `dob` DATE NOT NULL,
    `gender` ENUM('male','female','other') DEFAULT 'male',
    `department` VARCHAR(50) DEFAULT NULL,
    `csn` VARCHAR(32) UNIQUE DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
