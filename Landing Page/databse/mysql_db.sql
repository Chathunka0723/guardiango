


CREATE TABLE `bus` (
    `bus_id` int(11) NOT NULL,
    `bus_number_plate` varchar(15) NOT NULL,
    `capacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE `driver_details` (
    `driver_id` int(11) NOT NULL,
    `full_name` mediumtext NOT NULL,
    `mobile_number` int(10) NOT NULL,
    `driving license number` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;