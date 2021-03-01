SHADOWPAD_ARRAY_BUTTONS = {
	F1, F2, F3, F4, F5,
	 1,  2,  3,  4,  5,
	 Q,  W,  E,  R,  T,
	 A,  S,  D,  F,  G,  H,
	 Z,  X,  C,  V,  B,  N,  M
}

SHADOWPAD_ARRAY_BUTTONS_0 = {
	 6,  7,  8,  9, 10,
	 1,  2,  3,  4,  5,
	11,666, 12, 13, 14,
   666,666,666, 15, 16, 17,
	18, 19, 20, 21, 22, 23, 24
}

SHADOWPAD_ARRAY_BUTTONS_1 = {
	78, 79, 80, 81, 82,
	73, 74, 75, 76, 77,
	83,666, 84, 85, 86,
   666,666,666, 87, 88, 89,
	90, 91, 92, 93, 94, 95, 96
}

SHADOWPAD_ARRAY_BUTTONS_2 = {
   102,103,104,105,106,
	97, 98, 99,100,101,
   107,666,108,109,110,
   666,666,666,111,112,113,
   114,115,116,117,118,119,120
}

SHADOWPAD_ARRAY_BUTTONS_3 = {
	54, 55, 56, 57, 58,
	49, 50, 51, 52, 53,
	59,666, 60, 61, 62,
   666,666,666, 63, 64, 65,
	66, 67, 68, 69, 70, 71, 72
}

-- This function must be removed from the addon. Bindings have to be set throught the Blizzard KeyBinding UI; All keys must count as pressed OnPress, not OnRelease (OnUp). How?
function ShadowPad_SetBindings()
	SetBindingClick("F1", "SHADOWPAD_BUTTON_F1");
	SetBindingClick("SHIFT-1", "SHADOWPAD_BUTTON_F1");
	SetBindingClick("F2", "SHADOWPAD_BUTTON_F2");
	SetBindingClick("SHIFT-2", "SHADOWPAD_BUTTON_F2");
	SetBindingClick("F3", "SHADOWPAD_BUTTON_F3");
	SetBindingClick("SHIFT-3", "SHADOWPAD_BUTTON_F3");
	SetBindingClick("F4", "SHADOWPAD_BUTTON_F4");
	SetBindingClick("SHIFT-4", "SHADOWPAD_BUTTON_F4");
	SetBindingClick("F5", "SHADOWPAD_BUTTON_F5");
	SetBindingClick("SHIFT-5", "SHADOWPAD_BUTTON_F5");

	SetBindingClick("1", "SHADOWPAD_BUTTON_1");
	SetBindingClick("2", "SHADOWPAD_BUTTON_2");
	SetBindingClick("3", "SHADOWPAD_BUTTON_3");
	SetBindingClick("4", "SHADOWPAD_BUTTON_4");
	SetBindingClick("5", "SHADOWPAD_BUTTON_5");

	SetBindingClick("Q", "SHADOWPAD_BUTTON_Q");
--W
	SetBindingClick("E", "SHADOWPAD_BUTTON_E");
	SetBindingClick("R", "SHADOWPAD_BUTTON_R");
	SetBindingClick("T", "SHADOWPAD_BUTTON_T");

--A
--S
--D
	SetBindingClick("F", "SHADOWPAD_BUTTON_F");
	SetBindingClick("G", "SHADOWPAD_BUTTON_G");
	SetBindingClick("H", "SHADOWPAD_BUTTON_H");

	SetBindingClick("Z", "SHADOWPAD_BUTTON_Z");
	SetBindingClick("X", "SHADOWPAD_BUTTON_X");
	SetBindingClick("C", "SHADOWPAD_BUTTON_C");
	SetBindingClick("V", "SHADOWPAD_BUTTON_V");
	SetBindingClick("B", "SHADOWPAD_BUTTON_B");
	SetBindingClick("N", "SHADOWPAD_BUTTON_N");
	SetBindingClick("M", "SHADOWPAD_BUTTON_M");
end

--above arrays contain the button layout and 4 stance actionbutton layout. We'll need only 3 of them (3rd is for shadowdance). I need some help with building a `looping` function for building those buttons throught a function.
function ShadowPad_BuildButtons(existenz)
	if ( existenz == 0 ) then
		SHADOWPAD_BUTTON_F1:SetAttribute("action", 6);
		SHADOWPAD_BUTTON_F2:SetAttribute("action", 7);
		SHADOWPAD_BUTTON_F3:SetAttribute("action", 8);
		SHADOWPAD_BUTTON_F4:SetAttribute("action", 9);
		SHADOWPAD_BUTTON_F5:SetAttribute("action", 10);

		SHADOWPAD_BUTTON_1:SetAttribute("action", 1);
		SHADOWPAD_BUTTON_2:SetAttribute("action", 2);
		SHADOWPAD_BUTTON_3:SetAttribute("action", 3);
		SHADOWPAD_BUTTON_4:SetAttribute("action", 4);
		SHADOWPAD_BUTTON_5:SetAttribute("action", 5);

		SHADOWPAD_BUTTON_Q:SetAttribute("action", 11);
		SHADOWPAD_BUTTON_W:SetAttribute("action", 666);--hell
		SHADOWPAD_BUTTON_E:SetAttribute("action", 12);

		SHADOWPAD_BUTTON_R:SetAttribute("action", 13);
		SHADOWPAD_BUTTON_T:SetAttribute("action", 14);
		SHADOWPAD_BUTTON_A:SetAttribute("action", 666);--hell
		SHADOWPAD_BUTTON_S:SetAttribute("action", 666);--hell
		SHADOWPAD_BUTTON_D:SetAttribute("action", 666);--hell
		SHADOWPAD_BUTTON_F:SetAttribute("action", 15);
		SHADOWPAD_BUTTON_G:SetAttribute("action", 16);
		SHADOWPAD_BUTTON_H:SetAttribute("action", 17);

		SHADOWPAD_BUTTON_Z:SetAttribute("action", 18);
		SHADOWPAD_BUTTON_X:SetAttribute("action", 19);
		SHADOWPAD_BUTTON_C:SetAttribute("action", 20);
		SHADOWPAD_BUTTON_V:SetAttribute("action", 21);
		SHADOWPAD_BUTTON_B:SetAttribute("action", 22);
		SHADOWPAD_BUTTON_N:SetAttribute("action", 23);
		SHADOWPAD_BUTTON_M:SetAttribute("action", 24);
--		DEFAULT_CHAT_FRAME:AddMessage("spDebug: BuildButtons(0) has finished");
	elseif ( existenz == 1) then
		SHADOWPAD_BUTTON_F1:SetAttribute("action", 78);
		SHADOWPAD_BUTTON_F2:SetAttribute("action", 79);
		SHADOWPAD_BUTTON_F3:SetAttribute("action", 80);
		SHADOWPAD_BUTTON_F4:SetAttribute("action", 81);
		SHADOWPAD_BUTTON_F5:SetAttribute("action", 82);

		SHADOWPAD_BUTTON_1:SetAttribute("action", 73);
		SHADOWPAD_BUTTON_2:SetAttribute("action", 74);
		SHADOWPAD_BUTTON_3:SetAttribute("action", 75);
		SHADOWPAD_BUTTON_4:SetAttribute("action", 76);
		SHADOWPAD_BUTTON_5:SetAttribute("action", 77);

		SHADOWPAD_BUTTON_Q:SetAttribute("action", 83);
		SHADOWPAD_BUTTON_W:SetAttribute("action", 666);--hell
		SHADOWPAD_BUTTON_E:SetAttribute("action", 84);

		SHADOWPAD_BUTTON_R:SetAttribute("action", 85);
		SHADOWPAD_BUTTON_T:SetAttribute("action", 86);
		SHADOWPAD_BUTTON_A:SetAttribute("action", 666);--hell
		SHADOWPAD_BUTTON_S:SetAttribute("action", 666);--hell
		SHADOWPAD_BUTTON_D:SetAttribute("action", 666);--hell
		SHADOWPAD_BUTTON_F:SetAttribute("action", 87);
		SHADOWPAD_BUTTON_G:SetAttribute("action", 88);
		SHADOWPAD_BUTTON_H:SetAttribute("action", 89);

		SHADOWPAD_BUTTON_Z:SetAttribute("action", 90);
		SHADOWPAD_BUTTON_X:SetAttribute("action", 91);
		SHADOWPAD_BUTTON_C:SetAttribute("action", 92);
		SHADOWPAD_BUTTON_V:SetAttribute("action", 93);
		SHADOWPAD_BUTTON_B:SetAttribute("action", 94);
		SHADOWPAD_BUTTON_N:SetAttribute("action", 95);
		SHADOWPAD_BUTTON_M:SetAttribute("action", 96);
--		DEFAULT_CHAT_FRAME:AddMessage("spDebug: BuildButtons(1) has finished");
	elseif ( existenz == 2) then
		SHADOWPAD_BUTTON_F1:SetAttribute("action", 102);
		SHADOWPAD_BUTTON_F2:SetAttribute("action", 103);
		SHADOWPAD_BUTTON_F3:SetAttribute("action", 104);
		SHADOWPAD_BUTTON_F4:SetAttribute("action", 105);
		SHADOWPAD_BUTTON_F5:SetAttribute("action", 106);

		SHADOWPAD_BUTTON_1:SetAttribute("action", 97);
		SHADOWPAD_BUTTON_2:SetAttribute("action", 98);
		SHADOWPAD_BUTTON_3:SetAttribute("action", 99);
		SHADOWPAD_BUTTON_4:SetAttribute("action", 100);
		SHADOWPAD_BUTTON_5:SetAttribute("action", 101);

		SHADOWPAD_BUTTON_Q:SetAttribute("action", 107);
		SHADOWPAD_BUTTON_W:SetAttribute("action", 666);--hell
		SHADOWPAD_BUTTON_E:SetAttribute("action", 108);

		SHADOWPAD_BUTTON_R:SetAttribute("action", 109);
		SHADOWPAD_BUTTON_T:SetAttribute("action", 110);
		SHADOWPAD_BUTTON_A:SetAttribute("action", 666);--hell
		SHADOWPAD_BUTTON_S:SetAttribute("action", 666);--hell
		SHADOWPAD_BUTTON_D:SetAttribute("action", 666);--hell
		SHADOWPAD_BUTTON_F:SetAttribute("action", 111);
		SHADOWPAD_BUTTON_G:SetAttribute("action", 112);
		SHADOWPAD_BUTTON_H:SetAttribute("action", 113);

		SHADOWPAD_BUTTON_Z:SetAttribute("action", 114);
		SHADOWPAD_BUTTON_X:SetAttribute("action", 115);
		SHADOWPAD_BUTTON_C:SetAttribute("action", 116);
		SHADOWPAD_BUTTON_V:SetAttribute("action", 117);
		SHADOWPAD_BUTTON_B:SetAttribute("action", 118);
		SHADOWPAD_BUTTON_N:SetAttribute("action", 119);
		SHADOWPAD_BUTTON_M:SetAttribute("action", 120);
--		DEFAULT_CHAT_FRAME:AddMessage("spDebug: BuildButtons(2) has finished");
	end
end
