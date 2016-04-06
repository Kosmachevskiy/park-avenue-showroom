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
     waterLeackegeControl.config.timeTreshold := t#5s;
  end_if;

  waterLeackegeControl( sensor := MODULE6_IN.DI.DI7,
                        openWater := waterOpen,
                        closeWater := waterClose,
                        alarmReset := waterAlarmReset,
                        //autoControl := ,
                        valve => MODULE4_OUT.DO7,
                        alarm => waterAlarm,
                        waterState := waterState
                        );
                        
  waterOpen  := false;
  waterClose := false;
  waterAlarmReset := false;

END_PROGRAM

