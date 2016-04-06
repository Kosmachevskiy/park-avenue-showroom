PROGRAM prgMain
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
         init       : bool;
  END_VAR
  VAR_TEMP
  END_VAR

   if not init then
         generalPower     := true;
         //in_awayButton     := adr(MODULE_1IN.DI.DI8);
         //in_comeBackButton := adr(MODULE_1IN.DI.DI7);

         init := true;
      end_if;


//--Light and socets relay control--//
     MODULE4_OUT.DO5  := generalPower;
END_PROGRAM

