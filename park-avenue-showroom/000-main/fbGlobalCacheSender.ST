TYPE
  irCodesString   :  array[100..150] of string[255];
END_TYPE

FUNCTION_BLOCK fbGlobalCacheSender
  VAR_INPUT
      sendCode : uint;
      channel  : uint;
  END_VAR
  VAR_IN_OUT
      codes   : irCodesString;
  END_VAR
  VAR
      tcpSender : fbSendTo;
      code      : string[255];
      send      : bool;
  END_VAR
      if sendCode <> 0 and (not send) then
         code := codes[sendCode];
         code := code + '$R';
         send           := true;
         sendCode := 0;
      end_if;

      if send then

          tcpSender( chanCode := channel,
                     rq       := not tcpSender.mesSent,
                     lenTx    := len(code),
                     data     := void(code));

          if tcpSender.mesSent then
             send         := false;
          end_if;
      end_if;
END_FUNCTION_BLOCK

