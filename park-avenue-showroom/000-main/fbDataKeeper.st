VAR_GLOBAL
    //reader : ReadFromFile; {hidden}
    //writer : WriteToFile;  {hidden}
END_VAR

FUNCTION_BLOCK fbSaveData  {hidden}
  VAR_INPUT
      save     : bool r_edge;
  END_VAR
  VAR_OUTPUT
      idle        : bool := true;
      done        : bool ;
      currentFile : string[20];
  END_VAR
  VAR_IN_OUT
      fullPath    : string[20];
      dataSize    : udint;
      data        : udint;
  END_VAR
  VAR
      lastError: string;
      writer   : WriteToFile;  {hidden}
  END_VAR
  VAR_TEMP
  END_VAR

  done    := false;

  if save then
     idle := false;
     save := false;
  end_if;

  writer( fileName := fullPath,
          srcVar   := data,
          exec     := not idle,
          seek     := 0,
          size     := dataSize);

  if writer.done then
     idle := true;
     done := true;
  end_if;

  if GetLastErr() <> 0 then
     GetLastErrTxt(errCode := GetLastErr(), errMessage := lastError);
  end_if;

  currentFile := fullPath;

END_FUNCTION_BLOCK

FUNCTION_BLOCK fbLoadData  {hidden}
  VAR_INPUT
      load     : bool r_edge;
  END_VAR
  VAR_OUTPUT
      idle        : bool := true;
      done        : bool;
      currentFile : string[20];
  END_VAR
  VAR_IN_OUT
      fullPath    : string[20];
      dataSize : udint;
      data     : udint;
  END_VAR
  VAR
      lastError: string;
      reader   : ReadFromFile; {hidden}
  END_VAR
  VAR_TEMP
  END_VAR

  done    := false;

  if load then
     idle := false;
     load := false;
  end_if;

  reader( fileName := fullPath,
          dstVar   := data,
          exec     := not idle,
          seek     := 0,
          size     := dataSize);

  if reader.done then
     idle := true;
     done := true;
  end_if;

  if GetLastErr() <> 0 then
     GetLastErrTxt(errCode := GetLastErr(), errMessage := lastError);
  end_if;

  currentFile := fullPath;

END_FUNCTION_BLOCK

VAR_GLOBAL RETAIN
    dataSaver  :fbSaveData;    {hidden}
    dataLoader :fbLoadData;    {hidden}
END_VAR

FUNCTION_BLOCK fbDataKeeper
  VAR_INPUT
      path     : string[10];
      fileName : string[10];
      dataSize : udint;
  END_VAR
  VAR_OUTPUT
      load     : bool;
  END_VAR
  VAR_IN_OUT
      data       : udint;
  END_VAR
  VAR
      save     : bool;
      fullPath : string[20];
      init     : bool;
  END_VAR
  VAR_EXTERNAL
      at %s20.3 : bool;
  END_VAR

      fullPath := '/'+ path + '/' +fileName;

      if not init then
         if not FileExists(fileName := fullPath) then
            if not FileExists(fileName := path) then
               DirCreate(dirName := path);
            end_if;
            load := true;
         end_if;
         init := true;
      end_if;

      if not load  then
         if dataLoader.idle then
            dataLoader( load     := true,
                        fullPath := fullPath,
                        dataSize := dataSize,
                        data     := data);
         end_if;
         if dataLoader.done and dataLoader.currentFile = fullPath then
            load := true;
         end_if;
      end_if;
      
      if %S20.3 and init and load then
         save := true;
      end_if;
      
      if dataSaver.idle and save  then
         dataSaver( save      := true,
                    fullPath  := fullPath,
                    dataSize  := dataSize,
                    data      := data);
      end_if;
      if dataSaver.done and dataSaver.currentFile = fullPath then
         save     := false;
      end_if;

      dataSaver (data:=data, fullPath := fullPath, dataSize := dataSize);
      dataLoader(data:=data, fullPath := fullPath, dataSize := dataSize);

END_FUNCTION_BLOCK
