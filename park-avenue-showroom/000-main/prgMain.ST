VAR_GLOBAL
    globalCache : fbGlobalCacheSender;
    globalCacheCodes : irCodesString;
    panel : fbPanel;
END_VAR

PROGRAM prgMain
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
         init       : bool;

         generalPowerButton : fbButtonProcessor;
  END_VAR
  VAR_TEMP
  END_VAR

   if not init then
         generalPower     := true;
         
         generalPowerButton.longPressTime := T#2s;

         r4_Bedroom1ACSetTemperature := 23.0;
         r5_Bedroom2ACSetTemperature := 20.0;

         init := true;
      end_if;

                        //MODULE2_OUT.DOs.DO8
//--Light and sockets relay control--//
     generalPowerButton(btn := button_24_1);
     
     if generalPowerButton.shortPress then
        generalPower := true;
     end_if;
     
     if generalPowerButton.longPress then
        generalPower := false;
     end_if;

     (*MODULE4_OUT.DO5*)
     electricitySwitch  := generalPower;


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
            
END_PROGRAM

