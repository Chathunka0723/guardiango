


CREATE TABLE `bus` (
    `bus_id` int(11) NOT NULL,
    `bus_number_plate` varchar(15) NOT NULL,
    `driver_id` int(11) NOT NULL,
    `capacity` int(11) NOT NULL,
    `driver name` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE `driver_details` (
    `driver_id` int(11) NOT NULL,
    `full_name` mediumtext NOT NULL,
    `date_of_birth` varchar(12) NOT NULL,
    `email` mediumtext NOT NULL,
    `mobile_number` int(10) NOT NULL,
    `driving license number` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `emergency_contacts` (
    `priority` varchar(100) NOT NULL,
    `name` varchar(10000) NOT NULL,
    `mobile` int(12) NOT NULL,
    `relationship to child` varchar(1000) NOT NULL,
    `email` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `lost_item_database` (
    `item_name` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE `parent` (
    `full name` int(11) NOT NULL,
    `mobile_number` int(10) NOT NULL,
    `email` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `student` (
    `full_name` mediumtext NOT NULL,
    `school_name` varchar(5000) NOT NULL,
    `grade` varchar(15) NOT NULL,
    `Note / additional info` mediumtext NOT NULL,
    `home address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



