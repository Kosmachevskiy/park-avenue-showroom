PROGRAM prgMain
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
         out_relay1 : ptr_to bool;
         
         init       : bool;
  END_VAR
  VAR_TEMP
  END_VAR

   if not init then
         generalPower     := true;
         out_relay1        := adr(IR_15_01_OUT.DO5);
         //in_awayButton     := adr(MODULE_1IN.DI.DI8);
         //in_comeBackButton := adr(MODULE_1IN.DI.DI7);

         init := true;
      end_if;


//--Light and socets relay control--//
     out_relay1^ := generalPower;
END_PROGRAM

