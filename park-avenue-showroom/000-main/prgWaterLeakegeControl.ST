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

  waterLeackegeControl( //sensor := ,
                        openWater := waterOpen,
                        closeWater := waterClose,
                        alarmReset := waterAlarmReset,
                        //autoControl := ,
                        //valve => ,
                        alarm => waterAlarm,
                        waterState := waterState
                        );
                        
  waterOpen  := false;
  waterClose := false;
  waterAlarmReset := false;

END_PROGRAM

