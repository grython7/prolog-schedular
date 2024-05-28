## A scheduler for TAs written in Prolog to get more familiar with features like backtracking, etc.


### a) week_schedule(WeekSlots, TAs, DayMax, WeekSched)
   - **Parameters:**
     - `WeekSlots`: A list of 6 lists, each representing a working day from Saturday till Thursday. Each list contains 5 numbers representing the 5 slots in the day. The number at position `i` in a day list represents the number of parallel labs at slot `i`.
     - Example:
       ```prolog
       WeekSlots = [ [0, 0, 0, 0, 0], [2, 1, 2, 3, 0], [2, 0, 1, 2, 0], [0, 1, 1, 0, 0], [1, 0, 0, 2, 2], [2, 1, 3, 1, 0] ]
       ```
     - `TAs`: A list of structures of the form `ta(Name, Load)` where `Name` is the name of the TA and `Load` is an integer representing their teaching load.
     - Example:
       ```prolog
       TAs = [ta(y, 4), ta(h, 7), ta(r, 8), ta(s, 8)]
       ```
     - `DayMax`: The maximum number of labs a TA can be assigned per day.
     - Example:
       ```prolog
       DayMax = 3
       ```
     - `WeekSched`: The weekly assignment of TAs to the labs, represented as a list of 6 lists. Each list represents a working day from Saturday to Thursday. Position `i` in a day list is a list containing the names of the assigned TAs to slot `i` in the day.

   - **Description:** 
     - `week_schedule/4` succeeds if `WeekSched` is a possible assignment of the labs to the teaching assistants in `TAs` according to `WeekSlots` so that none is assigned more than their teaching load or assigned more than `DayMax` labs per day.

### b) day_schedule(DaySlots, TAs, RemTAs, Assignment)
   - **Parameters:**
     - `DaySlots`: A list of 5 numbers representing the number of parallel labs in the 5 slots of the day.
     - `TAs`: A list of TA structures.
     - `RemTAs`: A list of TA structures after the assignment to this slot.
     - `Assignment`: A list of lists of TA names in `TAs` representing the assignment of the day.

   - **Description:** 
     - `day_schedule/4` succeeds if `Assignment` is a possible day assignment given the available `DaySlots` and list of course `TAs`, while `RemTAs` is the list of updated TA structures after the day assignment.

### c) max_slots_per_day(DaySched, Max)
   - **Parameters:**
     - `DaySched`: A day schedule showing the assignment of the TAs in every slot.
     - `Max`: A number showing the maximum amount of labs a TA can be assigned in a day.

   - **Description:** 
     - `max_slots_per_day/2` succeeds if no TA is assigned more than `Max` labs in `DaySched`.

### d) slot_assignment(LabsNum, TAs, RemTAs, Assignment)
   - **Parameters:**
     - `LabsNum`: A number representing the amount of parallel labs in this slot.
     - `TAs`: A list of TAs structures.
     - `RemTAs`: The updated list of TAs structures after the assignment to this slot.
     - `Assignment`: A list of the names of TAs in `TAs` assigned to this slot.

   - **Description:** 
     - `slot_assignment/4` succeeds if `Assignment` is a possible assignment to a single slot with `LabsNum` labs and `RemTAs` is the list of modified TAs after the assignment.

### e) ta_slot_assignment(TAs, RemTAs, Name)
   - **Parameters:**
     - `TAs`: A list of TA structures.
     - `RemTAs`: A list of TA structures after the assignment to this slot.
     - `Name`: The name of a TA in `TAs`.

   - **Description:** 
     - `ta_slot_assignment/3` succeeds if `RemTAs` is the list of TA structures resulting from updating the load of TA `Name` in `TAs`.
