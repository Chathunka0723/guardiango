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

