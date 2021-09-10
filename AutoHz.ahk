#NoEnv
#Persistent

; setup
VarSetCapacity(powerstatus, 1+1+1+1+4+4)
success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)
initialACStatus := ReadInteger(&powerstatus,0,1,false)

; main loop
while(1) {
  MsgBox, ACStat = %acLineStatus%, %initialACStatus%
  acLineStatus:=ReadInteger(&powerstatus,0,1,false)
  if(%acLineStatus% != %initialACStatus%) {
    MsgBox, %acLineStatus%
    if(%acLineStatus% = 1) {
      ChangeDisplayFrequency(300)
    } else {
      ChangeDisplayFrequency(60)
    }
  }
  Sleep, 500
}




ReadInteger( p_address, p_offset, p_size, p_hex=true )
{
  value = 0
  old_FormatInteger := a_FormatInteger
  if ( p_hex )
    SetFormat, integer, hex
  else
    SetFormat, integer, dec
  loop, %p_size%
    value := value+( *( ( p_address+p_offset )+( a_Index-1 ) ) << ( 8* ( a_Index-1 ) ) )
  SetFormat, integer, %old_FormatInteger%
  return, value
}


ChangeDisplayFrequency(Frequency) {
   VarSetCapacity(DEVMODE, 156, 0)
   NumPut(156, DEVMODE, 36, "UShort")
   DllCall("EnumDisplaySettingsA", "Ptr", 0, "UInt", -1, "Ptr", &DEVMODE)
   NumPut(0x400000, DEVMODE, 40)
   NumPut(Frequency, DEVMODE, 120, "UInt")
   Return DllCall("ChangeDisplaySettingsA", "Ptr", &DEVMODE, "UInt", 0)
}