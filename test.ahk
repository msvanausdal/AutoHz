ChangeDisplayFrequency(300)
ChangeDisplayFrequency(Frequency) {
   VarSetCapacity(DEVMODE, 156, 0)
   NumPut(156, DEVMODE, 36, "UShort")
   DllCall("EnumDisplaySettingsA", "Ptr", 0, "UInt", -1, "Ptr", &DEVMODE)
   NumPut(0x400000, DEVMODE, 40)
   NumPut(Frequency, DEVMODE, 120, "UInt")
   Return DllCall("ChangeDisplaySettingsA", "Ptr", &DEVMODE, "UInt", 0)
}