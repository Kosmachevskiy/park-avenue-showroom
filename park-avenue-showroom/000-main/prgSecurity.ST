PROGRAM prgSecurity
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
       security : fbSecuritySystem;
  END_VAR
  VAR_TEMP
  END_VAR
  
  
       security(
                 Z1 := true, // door
                 Z2 := true,//(MODULE1_IN.DI0 and MODULE1_IN.DI1 and MODULE1_IN.DI2 and MODULE2_IN.DI.DI1), // entrance/exit zone (hall, kitchen, eatinroom and livingroom)
                 Z3 := (MODULE2_IN.DI.DI4 and MODULE2_IN.DI.DI5 and MODULE1_IN.DI3 and MODULE2_IN.DI.DI2), //bathrooms and bedrooms
                 Z4 := true, //  other sensors, like window contacts and ect.
                 Z5 := true, //  tamper zone

                 arm := security_arm,
                 disarm := security_disarm,
                 alarmReset := security_alarm_reset,

                 securityState => security_state,
                 alarm => security_alarm,
                 ledIndicator => security_led);
                 
      security_arm := false;
      security_alarm_reset:= false;
      security_disarm:= false;

END_PROGRAM

