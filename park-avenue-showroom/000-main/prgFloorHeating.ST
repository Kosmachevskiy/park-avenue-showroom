PROGRAM prgFloorHeating
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
  
      termostat : fbFloorHeatingSimple;
  
  END_VAR
  VAR_TEMP
  END_VAR
  
  
      termostat( period := T#30m,
                 state  := floorHeatingState,
                 power  := floorHeatingLevel,
                 out    => MODULE4_OUT.DO1
                 );


END_PROGRAM
