; Warning: This file is managed by Mosaic development environment.
; It is not recommended to change it manualy!

#program 000 , V1.0
;**************************************
;<ActionName/>
;<Programmer/>
;<FirmName/>
;<Copyright/>
;**************************************
;<History>
;</History>
;**************************************
#useoption CPM = 9              ; CPM type: K
#useoption RemZone = 144        ; the remanent zone length
#useoption AlarmTime = 500      ; first alarm [milisec]
#useoption MaxCycleTime = 600   ; maximum cycle [milisec]
#useoption PLCstart = 1         ; cold start
#useoption AutoSummerTime = 0   ; internal PLC clock does not switch to daylight saving time
#useoption RestartOnError = 0   ; PLC will not be restarted after hard error

#uselib "LocalLib\StdLib_V21_20140514.mlb"
#uselib "LocalLib\SysLib_V35_20150416.mlb"
#uselib "LocalLib\ComLib_V21_20130528.mlb"
#uselib "LocalLib\BuildingLib_V13_20140707.mlb"
#endlibs

;**************************************
#usefile "Sysgen\CIBMaker.st", 'auto'
#usefile "SysGen\HWConfig.ST", 'auto'
#usefile "Sysgen\CIBMaker.mos", 'auto'
#usefile "SysGen\000-main.hwc", 'auto'
#usefile "..\park-avenue-showroom.hwn", 'auto'
#usefile "000-MAIN.ST"
#usefile "fbGlobalCacheSender.ST"
#usefile "WaterLeakegeControl.ST"
#usefile "fbRealObserver.ST"
#usefile "fbTimer.ST"
#usefile "RalayAndDimmer.ST"
#usefile "fbBlindController.ST"
#usefile "fbFloorHeatingSimple.ST"
#usefile "fbBoolObserver.ST"
#usefile "fbPanel.ST"
#usefile "fbSecuritySystem.ST"
#usefile "prgMain.ST"
#usefile "prgHallLight.ST"
#usefile "prgKitchenLight.ST"
#usefile "prgBalconyLight.ST"
#usefile "prgBedroom2Light.ST"
#usefile "prgEatingroomLight.ST"
#usefile "prgBathroom1Light.ST"
#usefile "prgBathroom2Light.ST"
#usefile "prgLivingroomLight.ST"
#usefile "prgBedroom1Light.ST"
#usefile "prgFloorHeating.ST"
#usefile "prgWaterLeakegeControl.ST"
#usefile "prgSecurity.ST"
#usefile "prgLivingRoomMedia.ST"
#usefile "000-main.mcf", 'auto'
