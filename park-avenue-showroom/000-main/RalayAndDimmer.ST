type
    motionSensorMode: (null, NO, NC);
    doorSensorMode:   (null, NO, NC);
    motionSensor:
        struct
            state:bool;
            mode :motionSensorMode;
        end_struct;
    doorSensor:
        struct
            state:bool;
            mode :doorSensorMode;
        end_struct;
end_type


FUNCTION_BLOCK fbAutoRelay
  VAR_IN_OUT
           //trigButton      : bool ;                  (**)
           //autoMode        : bool :=true;
  END_VAR
  VAR_INPUT
           Sensor_Door      : doorSensor;   (**)
           Sensor_Motion    : motionSensor; (**)

           autoMode      : bool ;                    (**)
           nightMode     : bool ;                    (**)

           forgetMode    : bool :=false;             (**)

           anyLightOn             : bool ;           (**)
           anyLightChanged        : bool ;           (**)

           timeAfterDoorOpenClose : time :=t#1m;     (**)
           timeAfterMotionDetect  : time :=t#10m;     (**)
           timeAfterLastAction    : time :=t#1m;     (**)
           setState               : bool ;           (**)
  END_VAR
  VAR_OUTPUT
           personLeft   : bool ;                     (**)
           forget       : bool ;                     (**)
           stateChanged : bool ;                     (**)
           state        : bool ;                     (**)
  END_VAR
  VAR
           timerAfterDoorOpened     : fbTimer;
           timerAfterDoorClosed     : fbTimer;
           timerAfterMotionDetected : fbTimer;
           timerAfterLastAction     : fbTimer;

           doorSensRise        : r_trig;
           doorSensFall        : f_trig;
           doorClosed          : bool;
           doorOpened          : bool;
           motionSensRise      : r_trig;
           motionSensFall      : f_trig;
           motionDetected      : bool;
           motionEnd           : bool;
           nightModeOff        : f_trig;
  END_VAR

        (*Refresh outputs.*)
        stateChanged:=false;
        personLeft  :=false;
        forget      :=false;

        nightModeOff(CLK := nightMode);
        if nightModeOff.Q then
           timerAfterDoorOpened    (reset := true);
           timerAfterDoorClosed    (reset := true);
           timerAfterMotionDetected(reset := true);
           if autoMode then
              setState:=false; end_if;
        end_if;

        (*Auto*)
        if autoMode and nightMode then
           (*Process move sensor.*)
           motionSensRise(CLK := Sensor_Motion.state);
           motionSensFall(CLK := Sensor_Motion.state);
           case Sensor_Motion.mode of
                NO:
                   motionDetected := motionSensRise.Q;
                   motionEnd      := motionSensFall.Q;
                NC:
                   motionDetected := motionSensFall.Q;
                   motionEnd      := motionSensRise.Q;
           end_case;
           (*Process door sensor.*)
           case Sensor_Door.mode of
                NO:
                   doorSensRise(CLK := Sensor_Door.state, Q => doorOpened);
                   doorSensFall(CLK := Sensor_Door.state, Q => doorClosed);
                NC:
                   doorSensRise(CLK := Sensor_Door.state, Q => doorClosed);
                   doorSensFall(CLK := Sensor_Door.state, Q => doorOpened);
           end_case;
           (*Timers process.*)
           timerAfterDoorOpened     (timeToCount :=timeAfterDoorOpenClose);
           timerAfterDoorClosed     (timeToCount :=timeAfterDoorOpenClose);
           timerAfterMotionDetected (timeToCount :=timeAfterMotionDetect);
           (*Door opened/closed logic.*)
           (*Door opened.*)
           if doorOpened and not anyLightOn then
              setState:=true;
              timerAfterDoorOpened( start := true);
           end_if;
           timerAfterDoorOpened();
           if timerAfterDoorOpened.isDone then
              setState :=false;
              timerAfterDoorOpened(reset := true);
           end_if;
           (*Door closed.*)
           if doorClosed then
              timerAfterDoorClosed( start := true);
           end_if;
           if timerAfterDoorClosed.isDone then
              setState  :=false;
              personLeft:=true;
              timerAfterDoorClosed(reset := true);
           end_if;
           (*Motion detecion logic.*)
           (*Motion detected.*)
           if motionDetected then
              if not anyLightOn then
                 setState := true;
//                 timerAfterMotionDetected(start := true);
              end_if;
              timerAfterDoorOpened    (reset := true);
              timerAfterDoorClosed    (reset := true);
           end_if;
           (*Motion end.*)
           if motionEnd then
              timerAfterMotionDetected(start := true);
           end_if;
           if timerAfterMotionDetected.isDone then
              setState:=false;
              timerAfterMotionDetected(reset := true);
           end_if;
        end_if;

        (*Forget mode.*)
        if forgetMode then
           timerAfterLastAction(timeToCount := timeAfterLastAction);
           if motionDetected then
              timerAfterLastAction(start := true);
           end_if;
           if timerAfterLastAction.isDone then
              timerAfterLastAction(reset:=true);
              forget:=true;
           end_if;
           if anyLightChanged then
              timerAfterLastAction(reset:=true);
              timerAfterLastAction(start:=true);
           end_if;;
        end_if;

        (*Set state.*)
        if setState<>state then
           stateChanged:= true;
           state       := setState;
        end_if;
END_FUNCTION_BLOCK

FUNCTION_BLOCK fbManualRelay
  VAR_IN_OUT
           trigButton          : bool ; (*Button for trigger control.*)
  END_VAR
  VAR_INPUT
           setState            : bool ; (*Turn on/off channel.*)
  END_VAR
  VAR
           trigButtonOff   : f_trig;
           trigButtonOn    : r_trig;
  END_VAR
  VAR_OUTPUT
           stateChanged : bool  ;           (*State changed flag.    *)
           state        : bool ;            (*Current state of relay.*)
  END_VAR
        (*Refresh outputs.*)
        stateChanged:=false;

        trigButtonOn (CLK := trigButton);
        trigButtonOff(CLK := trigButton);

        if trigButtonOn.Q  then
           setState:=true;
        end_if;

        if trigButtonOff.Q then
           setState:=false;
        end_if;

        if setState<>state then
           stateChanged := true;
           state        := setState;
           trigButton   := state;
        end_if;
        
END_FUNCTION_BLOCK

function_block fbButtonProcessor
    var_input
        btn          : ptr_to bool; (*Pointer to Button*)
        longPressTime: time := t#1000ms;       (*Long press time detect.*)
    end_var
    var_in_out
    end_var
    var_output
        longPress  :bool;                     (*Long press flag.*)
        shortPress :bool;                     (*Short press flag.*)
        btnPressed :bool;                     (*Event flag on button pressed.*)
        btnReleased:bool;                     (*Event flag on button released.*)
        btnState   :bool;                     (*Button state.*)
        longPressAndHold:bool;                (*Long press and hold flag.*)
    end_var
    var
        btnPrevState  :bool;
        timer         :fbTimer;
    end_var
    var
    end_var
        (*Refresh outputs.*)
        longPress  :=false;
        shortPress :=false;
        btnPressed :=false;
        btnReleased:=false;
        btnState   :=btn^;
        (*Button event detection.*)
        timer(timeToCount := longPressTime);
        if btn^ <> btnPrevState then
           (*Button status changed.*)
           btnPrevState := btn^;
           if btn^ then
              (*Button pressed.*)
              btnPressed:=true;
              if not timer.isRun then
                 timer.start:=true;
                 timer();
              end_if;
           else
              (*Button Released.*)
              btnReleased:=true;
              if timer.isRun then
                 timer.reset := true;
                 timer();
                 shortPress:=true;
              end_if;
           end_if;
        end_if;
        if timer.isDone then
           (*Time out.*)
           timer.reset := true;
           timer();
           longPress:=true;
        end_if;

        if longPress then
           longPressAndHold:=true;
        end_if;

        if btnReleased then
           longPressAndHold := false;
        end_if;
        
end_function_block

function_block fbManualDimm
    var_input
        btn      : bool;                       (*Pointer to button processor.*)
        minValue : real:=20.0;                 (*Minimum value of channel.*)
        maxValue : real:=100.0;                (*Maximum value of channel.*)
        dimmSpeed: real:=25.0;                 (*Up/Down dimming speed, %/sec.*)
        setValue : real;                       (**)
        setState : bool;                       (*Turn on/off channel like relay. Set to levels like short press.*)
    end_var
    var_in_out
        slider    :real;                       (*Slider in % in range from minValue to maxValue.*)
        trigButton:bool;                       (*Button for trigger contol.*)
    end_var
    var_output                                 (*Current value of channel.*)
        value       :real;
        valueChanged:bool;
        state       :bool;
        stateChanged:bool;
    end_var
    var
        direction :real:=1.0;
        userValue :real;
        dimming   :bool;
        timer     :TON;
        cycleTime :time;
        prevTime  :time;
        step      :real;
        init      :bool;
        prevValue :real;
        prevSetValue:real;
        prevSlider:real;
        buttonProcessor : fbButtonProcessor;
    end_var
    var_temp

    end_var
        (*Init block.*)
        if not init then
           init:=true;
           userValue:=maxValue;
        end_if;

        buttonProcessor(btn := adr(btn));

        (*Calc 1% in current range.*)
        if minValue<20. then
           minValue:=20.; end_if;
        step:=((maxValue-minValue)/100.);
        
        (*Reset outputs.*)
        valueChanged:=false;
        stateChanged:=false;

        (*Set value by setValue variable.*)
        if setValue<>prevSetValue then
           if setValue=0.0 then
              value:=0.0;
           elsif setValue=1.0 then
              value := minValue;
           else
              value := minValue + (step*setValue);
           end_if;
        end_if;
        
        (*Set value by slider.*)
        if slider<>prevSlider then
           if slider=0.0 then
              value:=0.0;
           elsif slider=1.0 then
              value := minValue;
           else
              value := minValue + (step*slider);
           end_if;
        end_if;

        (*On/Off channel.*)
        (*On/Off by impulse button.*)
        if buttonProcessor.shortPress then
           if value >= minValue then
              userValue := value;
              value  := 0.0;
           else
              value := userValue;
           end_if;
        end_if;
        (*On/Off by setState variable.*)
        if setState<>state then
           if setState then
              value:=userValue;
           else
              value:=0.0;
           end_if;
        end_if;
        (*On/Off by triggButton variable.*)
        if trigButton <> state then
           if trigButton then
              value:=userValue;
           else
               value:=0.0;
           end_if;
        end_if;

        (*Dimming.*)
        timer(IN := buttonProcessor.longPressAndHold , PT := t#100s);
        cycleTime:=SUB_TIME(IN1 := timer.ET, IN2 := prevTime);
        prevTime:=timer.ET;

        if buttonProcessor.longPressAndHold then
           dimming:=true;
           value:=value + (direction * (step * dimmSpeed * (TIME_TO_REAL(cycleTime)/1000.)));
           if value > maxValue then
              value := maxValue; end_if;
           if value < minValue then
              value := minValue; end_if;
        end_if;

        (*End_dimming.*)
        if dimming and buttonProcessor.btnReleased then
           dimming   := false;
           direction := direction*(-1.0);
           userValue := value;
        end_if;
        
         (*Update slider and local variables.*)
         if value=0.0 then
            slider:=0.0;
         elsif value=minValue then
            slider:=1.0;
         else
            slider:=((value-minValue)/step);
            if slider>100. then
               slider:=100.; end_if;
         end_if;
         prevSlider  :=slider;
         setValue    :=slider;
         prevSetValue:=slider;
         trigButton  := REAL_TO_BOOL(value);
         setState    := trigButton;
         
         (*Update outputs.*)
         if state <> REAL_TO_BOOL(value) then
            stateChanged:=true;
            state := REAL_TO_BOOL(value);
         end_if;
         if value <> prevValue then
            prevValue    :=value;
            valueChanged :=true;
         end_if;
end_function_block



