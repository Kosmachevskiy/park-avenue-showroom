PROGRAM prgKitchenLight
   VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      Lamp1     : fbManualRelay;
      
      Auto2     : fbAutoRelay;
      
      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     supervisorAuto02               := AUTO_MODE_DEFAULT_STATE;
     Auto2.timeAfterMotionDetect    := AUTO_MODE_DEFAULT_TIME;
     Auto2.Sensor_Motion.mode       := NC;
     Auto2.nightMode                := true;
     init := true;
  end_if;
  
  if panel.button[2].shortPress then
     Lamp1.setState := not Lamp1.state;
  end_if;
  
  lamp1( trigButton := supervisorLight_03_04,
         state      => light_03_04
         );
         

  panel.led[2]:= Lamp1.state;

  Auto2( Sensor_Motion.state   := msensor02,
        autoMode               := supervisorAuto02
        );

  if Auto2.stateChanged then
     Lamp1.setState := Auto2.state;
  end_if;
  
  if generalPowerObserver.falling then
     Lamp1.setState := false;
  end_if;

END_PROGRAM

