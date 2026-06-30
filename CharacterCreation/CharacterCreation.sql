-- =====================================================
-- Character Creation System Database Structure
-- For use with CharacterCreation.js (FiveM)
-- =====================================================

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

-- Optional: spawn locations table (used in the JS when "setSpawns" is triggered)
CREATE TABLE IF NOT EXISTS `spawn_locations` (
    `charid` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `x` FLOAT NOT NULL,
    `y` FLOAT NOT NULL,
    `z` FLOAT NOT NULL,
    PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Example data (you can remove this section)
INSERT INTO `spawn_locations` (`name`, `x`, `y`, `z`) VALUES
('Mission Row PD', 441.2, -981.9, 30.7),
('Sandy Shores', 1853.3, 3687.9, 34.2),
('Paleto Bay', -449.7, 6011.3, 31.7);
