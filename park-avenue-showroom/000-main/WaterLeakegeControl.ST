TYPE
  WaterSensorModeType : (NO, NC); (*NO: Alarm when input is TRUE. NC: alarm when input is FALSE.*)
  WaterValveModeType  : (NO, NC); (*NO: Valve is open when output = FALSE; NC: Valve is open when output = TRUE *)
  WaterLeakegeControlConfig:
    STRUCT
      sensorMode                : WaterSensorModeType := NO;
      valveMode                 : WaterValveModeType  := NO;
      timeTreshold              : time           := t#5s;
      waterOnSendorsTimeoutTime : time           := t#10m;
    END_STRUCT;
END_TYPE

FUNCTION_BLOCK fbWaterLeakegeControl
  VAR_INPUT
  //--Inputs--//
      sensor     : bool ;                     (*Water Leakege Sensor.*)
  //--Commands--//
      openWater  : bool r_edge;               (*Flag to open water if it possible.*)
      closeWater : bool r_edge;               (*Flag to close water.*)
      alarmReset : bool r_edge;               (*Flag to reset alarm.*)
  //--Configuration variables--//
      config     : WaterLeakegeControlConfig; (*Zone configuration.*)
      autoControl: bool := true;
  END_VAR
  VAR_OUTPUT
      valve      : bool;                      (*Valve.*)
      alarm      : bool;                      (*True when water was closed by sensor until not reset.*)
  END_VAR
  VAR_IN_OUT
      waterState : bool                       (*TRUE = Water is open.*);
  END_VAR
  VAR
      waterOnSensor         : bool;
      timeTreshold          : ton;
      waterOnSendorsTimeout : tp;
      timeOut               : f_trig;
  END_VAR

  case config.sensorMode of
       NO: waterOnSensor := sensor;
       NC: waterOnSensor := not sensor;
  end_case;

  if openWater then
     waterState := true;
  end_if;
  
  if closeWater then
     waterState := false;
  end_if;

  if alarmReset then
     alarm := false;
     waterOnSendorsTimeout(IN := false); // timer call to reset
     waterOnSendorsTimeout.IN := true;
  end_if;

  timeTreshold(IN := waterOnSensor, PT := config.timeTreshold);
  waterOnSendorsTimeout(PT := config.waterOnSendorsTimeoutTime);
  timeOut(CLK := waterOnSendorsTimeout.Q);

  if timeTreshold.Q or (timeOut.Q and waterOnSensor) then
     alarm := true;
  end_if;
  
  if alarm and autoControl then
     waterState := false;
  end_if;
  
  if waterState and alarm then
     waterState := false;
  end_if;

  case config.valveMode of
       NO: valve := not waterState;
       NC: valve := waterState;
  end_case;
  
END_FUNCTION_BLOCK

