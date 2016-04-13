PROGRAM prgFloorHeating
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      termostat : fbFloorHeatingSimple;
      
      init : bool;
  END_VAR
  VAR_TEMP
  END_VAR
  
      if not init then
         floorHeatingState := true;
         floorHeatingLevel := 50.;
         init := true;
      end_if;
  
      termostat(
                 state  := floorHeatingState,
                 power  := floorHeatingLevel,
                 out    => MODULE7_OUT.DO0,
                 out    => MODULE7_OUT.DO1
                 );
END_PROGRAM
