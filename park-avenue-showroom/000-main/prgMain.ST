VAR_GLOBAL
    globalCache : fbGlobalCacheSender;
    globalCacheCodes : irCodesString;
    generalPowerObserver : fbBoolObserver;
    panel : fbPanel;
END_VAR

PROGRAM prgMain
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
         init       : bool;

         generalPowerButton   : fbButtonProcessor;

  END_VAR
  VAR_TEMP
  END_VAR

   if not init then
         generalPower      := true;
         electricitySwitch := true;
         
         generalPowerButton.longPressTime := T#2s;

         r2_3_GuestRoomACSetTemperature := 23.0;
         r5_Bedroom2ACSetTemperature := 20.0;
         r4_Bedroom1ACSetTemperature := 20.0;

         init := true;
      end_if;


//--Light and sockets relay control--//
     generalPowerButton(btn := button_24_1);
     
     if generalPowerButton.shortPress then
        generalPower := true;
     end_if;
     
     if generalPowerButton.longPress then
        generalPower := false;
     end_if;

     (*MODULE4_OUT.DO5*)
     //electricitySwitch  := generalPower;
     
     generalPowerObserver(state := generalPower);


//--Global Cache--//
     globalCache( channel := ETH1_uni0 ,
                  codes   := globalCacheCodes);

//--Panel --//
     panel( button[1].btn := MODULE6_IN.DI.DI1,
            button[2].btn := MODULE6_IN.DI.DI2,
            button[3].btn := MODULE6_IN.DI.DI5,
            button[4].btn := MODULE6_IN.DI.DI6,
            button[5].btn := MODULE6_IN.DI.DI4,
            button[6].btn := MODULE6_IN.DI.DI3,
            led[1] => MODULE6_OUT.DOs.DO2,
            led[2] => MODULE6_OUT.DOs.DO3,
            led[3] => MODULE6_OUT.DOs.DO6,
            led[4] => MODULE6_OUT.DOs.DO7,
            led[5] => MODULE6_OUT.DOs.DO5,
            led[6] => MODULE6_OUT.DOs.DO4);
            
            
     if generalPowerObserver.rising then
        supervisorAuto01 := true;
        supervisorAuto02 := true;
        supervisorAuto03 := true;
        supervisorAuto04 := true;
        supervisorAuto05 := true;
        supervisorAuto06 := true;
        supervisorAuto07 := true;
        supervisorAuto08 := true;
        //supervisorAuto09 := true;
     end_if;
     if generalPowerObserver.falling then
        supervisorAuto01 := false;
        supervisorAuto02 := false;
        supervisorAuto03 := false;
        supervisorAuto04 := false;
        supervisorAuto05 := false;
        supervisorAuto06 := false;
        supervisorAuto07 := false;
        supervisorAuto08 := false;
        //supervisorAuto09 := false;
     end_if;
     
END_PROGRAM

