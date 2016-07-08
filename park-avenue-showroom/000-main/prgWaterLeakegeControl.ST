PROGRAM prgWaterLeakegeControl
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR

      waterLeackegeControl: fbWaterLeakegeControl;
      
      init : bool;

  END_VAR
  VAR_TEMP
  END_VAR
  
  if not init then
     waterLeackegeControl.config.sensorMode := NO;
     waterLeackegeControl.config.valveMode  := NO;
     waterLeackegeControl.config.timeTreshold := t#4s;
  end_if;

  waterLeackegeControl( sensor    := MODULE7_IN.DI3,
                        openWater := waterOpen,
                        closeWater := waterClose,
                        alarmReset := waterAlarmReset,
                        valve => MODULE4_OUT.DO7,
                        alarm => waterAlarm,
                        waterState := waterState
                        );
                        
  waterOpen  := false;
  waterClose := false;
  waterAlarmReset := false;
  
  if generalPowerObserver.falling then
     waterState := false;
  end_if;
  
  if generalPowerObserver.rising then
     waterState := true;
  end_if;

END_PROGRAM

