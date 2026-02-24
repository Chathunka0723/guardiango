CREATE TABLE public.Attendance (
  recorded_at timestamp without time zone NOT NULL DEFAULT now(),
  attendance_id uuid NOT NULL,
  student_id uuid NOT NULL,
  bus_id uuid NOT NULL,
  attendance_status text NOT NULL,

  CONSTRAINT Attendance_pkey PRIMARY KEY (attendance_id),

  CONSTRAINT Attendance_student_id_fkey 
    FOREIGN KEY (student_id) 
    REFERENCES public.Student(student_id),

  CONSTRAINT Attendance_bus_id_fkey 
    FOREIGN KEY (bus_id) 
    REFERENCES public.Bus(bus_id)
);

CREATE TABLE public.bus (
  bus_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  bus_number text NOT NULL UNIQUE,
  driver_id uuid NOT NULL,
  route_name text NOT NULL,
  capacity integer NOT NULL,
  created_at timestamp without time zone NOT NULL DEFAULT now(),

  CONSTRAINT bus_driver_id_fkey 
    FOREIGN KEY (driver_id) 
    REFERENCES public.profile(profile_id)
    ON DELETE CASCADE
);

CREATE TABLE public.bus_location (
  bus_location_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  bus_id uuid NOT NULL,
  recorded_at timestamp without time zone NOT NULL DEFAULT now(),
  latitude numeric NOT NULL,
  longitude numeric NOT NULL,
  speed numeric NOT NULL,

  CONSTRAINT bus_location_bus_id_fkey
    FOREIGN KEY (bus_id)
    REFERENCES public.bus(bus_id)
    ON DELETE CASCADE
);

CREATE TABLE public.Message (
  message_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  sender_id uuid NOT NULL,
  receiver_id uuid NOT NULL,
  message text NOT NULL,
  sent_at timestamp NOT NULL DEFAULT now(),

  FOREIGN KEY (sender_id) REFERENCES public.Profile(profile_id),
  FOREIGN KEY (receiver_id) REFERENCES public.Profile(profile_id)
);

CREATE TABLE public.Payment (
  payment_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id uuid NOT NULL,
  parent_id uuid NOT NULL,
  amount numeric NOT NULL CHECK (amount > 0),
  payment_status text NOT NULL CHECK (payment_status IN ('PENDING', 'PAID', 'FAILED')),
  payment_date timestamp NOT NULL,
  created_at timestamp NOT NULL DEFAULT now(),

  FOREIGN KEY (student_id) REFERENCES public.Student(student_id),
  FOREIGN KEY (parent_id) REFERENCES public.Profile(profile_id)
);

CREATE TABLE public.Profile (
  profile_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name text NOT NULL,
  phone text NOT NULL,
  role text NOT NULL CHECK (role IN ('PARENT', 'DRIVER', 'ADMIN')),
  created_at timestamp NOT NULL DEFAULT now()
);


