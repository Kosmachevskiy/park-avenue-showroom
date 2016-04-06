
VAR_GLOBAL RETAIN
  (*Light groups*)
           r1_1HallLight01                                  at %R0.0  : bool;
           r2_3LivingroomLight02_07_08                      at %R0.1  : bool; //dimm
           r3_1BalconyLight                                 at %R0.2  : bool;
           r2_2KitchenLight03                               at %R0.3  : bool;
           r2_2KitchenLight04_24                            at %R0.4  : bool;
           r2_1EatingroomLight05_06_23                      at %R0.5  : bool;
           r4_1Bedroom1Light09                              at %R0.6  : bool;
           r5_1Bedroom2Light10                              at %R0.7  : bool;
           r5_1Bedroom2Light11                              at %R1.0  : bool;
           r5_1Bedroom2Light12                              at %R1.1  : bool;
           r6_1WardrobeLight13_21                           at %R1.2  : bool;
           r8_1Bathroom2Light14_15_16                       at %R1.3  : bool;
           r7_1Bathroom1Light17_18_19                       at %R1.4  : bool; //dimm

(*Lightgroups mode switches*)
           r1_1HallLight01_auto                             at %R1.5  : bool;
           r2_3LivingroomLight02_07_08_auto                 at %R1.6  : bool; //dimm
           r2_2KitchenLight03_auto                          at %R1.7  : bool;
           r2_2KitchenLight04_24_auto                       at %R2.0  : bool;
           r2_1EatingroomLight05_06_23_auto                 at %R2.1  : bool;
           r4_1Bedroom1Light09_auto                         at %R2.2  : bool;
           r5_1Bedroom2Light10_auto                         at %R2.3  : bool;
           r5_15Bedroom2Light11_auto                        at %R2.4  : bool;
           r5_15Bedroom2Light12_auto                        at %R2.5  : bool;
           r6_1WardrobeLight13_21_auto                      at %R2.6  : bool;
           r8_1Bathroom2Light14_15_16_auto                  at %R2.7  : bool;
           r7_1Bathroom1Light17_18_19_auto                  at %R3.0  : bool; //dimm

(*Blinds Moving Buttons*)
           r2_1EatingroomBlindsUp                           at %R3.1  : bool;
           r2_1EatingroomBlindsDown                         at %R3.2  : bool;
           r2_1EatingroomBlindsStop                         at %R3.3  : bool;
           r4_1Bedroom1BlindsUp                             at %R3.4  : bool;
           r4_1Bedroom1BlindsDown                           at %R3.5  : bool;
           r4_1Bedroom1BlindsStop                           at %R3.6  : bool;
           r5_1Bedroom2BlindsUp                             at %R3.7  : bool;
           r5_1Bedroom2BlindsDown                           at %R4.0  : bool;
           r5_1Bedroom2BlindsStop                           at %R4.1  : bool;
           
           generalPower                                     at %R4.2  : bool;

(*Floor Heating control*)
           floorHeatingState                                at %R4.3  : bool;
           
           
(*Water control*)
           waterState                                       at %R4.4  : bool;
           waterClose                                       at %R4.5  : bool;
           waterOpen                                        at %R4.6  : bool;
           waterAlarmReset                                  at %R4.7  : bool;
           waterAlarm                                       at %R5.0  : bool;
           
           
(*Security System*)
           security_arm                                     at %R5.1  : bool;
           security_disarm                                  at %R5.2  : bool;
           security_alarm                                   at %R5.3  : bool;
           security_alarm_reset                             at %R5.4  : bool;
           security_led                                     at %R5.5  : bool;
           security_state                                   at %R5.6  : bool;

(*Dimmed groups brightness level*)
           r2_3LivingroomLight02_07_08_level                at %R105    : real;
           r7_1Bathroom1Light17_18_19_level                 at %R109    : real;

(*Blinds position control*)
           r2_1EatingroomBlindsPosition                     at %R113   : real;
           r4_1Bedroom1BlindsPosition                       at %R117   : real;
           r5_1Bedroom2BlindsPosition                       at %R121   : real;
           
(*Floor Heating control*)
           floorHeatingLevel                                at %R125   : real;
           
(*AC set temperature*)
           r4_Bedroom1ACSetTemperature                      at %R129   : real;
           r5_Bedroom2ACSetTemperature                      at %R133   : real;
           
(*AC mode*)
           r4_Bedroom1ACMode                                at %R137   : usint;
           r5_Bedroom2ACMode                                at %R138   : usint;
           
END_VAR

VAR_GLOBAL CONSTANT
  new : BOOL := false;
  AUTO_MODE_DEFAULT_STATE   : bool := TRUE;
  AUTO_MODE_DEFAULT_TIME    : time := t#5m;
END_VAR

