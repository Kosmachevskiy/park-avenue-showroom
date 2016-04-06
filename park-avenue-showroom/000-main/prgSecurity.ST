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
                 //Z1 := ,
                 //Z2 := ,
                 //Z3 := ,
                 //Z4 := ,
                 //Z5 := ,

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

