
//+------------------------------------------------------------------+
//|         Weekly_Map_HL_Day_Pro.mq5 - نسخه حرفه‌ای با پنل کامل     |
//+------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 0
#property indicator_plots   0

input color   HighColor       = clrRed;
input color   LowColor        = clrBlue;
input color   MidColor        = clrGray;
input color   Level25Color    = clrOrange;
input color   Level75Color    = clrOrange;
input color   ExtColor        = clrGreen;
input color   DayLevelColor   = clrAqua;
input color   DayLowColor     = clrAqua;
input color   DayMidColor     = clrYellowGreen;
input color   CloseUSAColor   = clrViolet;
input ENUM_LINE_STYLE lineStyle = STYLE_DOT;
input int     lineWidth       = 1;

bool showExtensions   = true;
bool showDailyLevels  = true;
bool showCloseUSA     = true;
bool showSessions     = true;

string objPanel   = "MAP_Panel";
string btnExt     = "btn_Toggle_Ext";
string btnDay     = "btn_Toggle_Day";
string btnClose   = "btn_Toggle_CloseUSA";
string btnSession = "btn_Toggle_Session";
string btnClear   = "btn_Clear_All";

void SaveSettings() {
   GlobalVariableSet("MAP_ShowExtensions",  (double)showExtensions);
   GlobalVariableSet("MAP_ShowDaily",       (double)showDailyLevels);
   GlobalVariableSet("MAP_ShowCloseUSA",    (double)showCloseUSA);
   GlobalVariableSet("MAP_ShowSessions",    (double)showSessions);
}

void LoadSettings() {
   showExtensions  = (GlobalVariableGet("MAP_ShowExtensions") != 0);
   showDailyLevels = (GlobalVariableGet("MAP_ShowDaily") != 0);
   showCloseUSA    = (GlobalVariableGet("MAP_ShowCloseUSA") != 0);
   showSessions    = (GlobalVariableGet("MAP_ShowSessions") != 0);
}

void DrawLevel(string name, double price, color clr) {
   string objLine = name + "_line";
   if (ObjectFind(0, objLine) < 0) {
      ObjectCreate(0, objLine, OBJ_HLINE, 0, 0, price);
      ObjectSetInteger(0, objLine, OBJPROP_COLOR, clr);
      ObjectSetInteger(0, objLine, OBJPROP_WIDTH, lineWidth);
      ObjectSetInteger(0, objLine, OBJPROP_STYLE, lineStyle);
   }
   ObjectSetDouble(0, objLine, OBJPROP_PRICE, price);
}

void DeleteAllLines() {
   string names[] = {"MAP_High", "MAP_Low", "MAP_Mid", "MAP_25", "MAP_75", 
                     "MAP_Ext125", "MAP_Ext150", "MAP_Ext175", "MAP_Ext200", 
                     "MAP_Ext_M25", "MAP_Ext_M50", "MAP_Ext_M75", "MAP_Ext_M100",
                     "HighDay", "LowDay", "MidDay", "CloseUSA"};
   for (int i = 0; i < ArraySize(names); i++)
      ObjectDelete(0, names[i] + "_line");
}

void DrawAllLevels() {
   DeleteAllLines();

   double highW = iHigh(_Symbol, PERIOD_W1, 1);
   double lowW  = iLow(_Symbol, PERIOD_W1, 1);
   double mid      = (highW + lowW) / 2;
   double level25  = lowW + (highW - lowW) * 0.25;
   double level75  = lowW + (highW - lowW) * 0.75;
   double range    = highW - lowW;

   DrawLevel("MAP_High", highW, HighColor);
   DrawLevel("MAP_Low",  lowW,  LowColor);
   DrawLevel("MAP_Mid",  mid,   MidColor);
   DrawLevel("MAP_25",   level25, Level25Color);
   DrawLevel("MAP_75",   level75, Level75Color);

   if (showExtensions) {
      DrawLevel("MAP_Ext125", highW + range * 0.25, ExtColor);
      DrawLevel("MAP_Ext150", highW + range * 0.5,  ExtColor);
      DrawLevel("MAP_Ext175", highW + range * 0.75, ExtColor);
      DrawLevel("MAP_Ext200", highW + range * 1.0,  ExtColor);

      DrawLevel("MAP_Ext_M25", lowW - range * 0.25, ExtColor);
      DrawLevel("MAP_Ext_M50", lowW - range * 0.5,  ExtColor);
      DrawLevel("MAP_Ext_M75", lowW - range * 0.75, ExtColor);
      DrawLevel("MAP_Ext_M100",lowW - range * 1.0,  ExtColor);
   }

   if (showDailyLevels) {
      double highD = iHigh(_Symbol, PERIOD_D1, 1);
      double lowD  = iLow(_Symbol, PERIOD_D1, 1);
      double midD  = (highD + lowD) / 2;

      DrawLevel("HighDay", highD, DayLevelColor);
      DrawLevel("LowDay",  lowD,  DayLowColor);
      DrawLevel("MidDay",  midD,  DayMidColor);
   }

   if (showCloseUSA) {
      datetime dayStart = iTime(_Symbol, PERIOD_D1, 1);
      datetime closeTime = dayStart + 23 * 3600;
      int index = iBarShift(_Symbol, PERIOD_M1, closeTime, false);
      if (index >= 0) {
         double close23 = iClose(_Symbol, PERIOD_M1, index);
         DrawLevel("CloseUSA", close23, CloseUSAColor);
      }
   }
}

void DrawSessions() {
   datetime today = iTime(_Symbol, PERIOD_D1, 0);
   ObjectCreate(0, "Session_Asia", OBJ_VLINE, 0, today + 3 * 3600, 0);
   ObjectSetInteger(0, "Session_Asia", OBJPROP_COLOR, clrYellow);
   ObjectCreate(0, "Session_London", OBJ_VLINE, 0, today + 10 * 3600, 0);
   ObjectSetInteger(0, "Session_London", OBJPROP_COLOR, clrMagenta);
   ObjectCreate(0, "Session_NY", OBJ_VLINE, 0, today + 16 * 3600, 0);
   ObjectSetInteger(0, "Session_NY", OBJPROP_COLOR, clrAqua);
}

void DeleteSessions() {
   string sessions[] = {"Session_Asia", "Session_London", "Session_NY"};
   for (int i = 0; i < ArraySize(sessions); i++)
      ObjectDelete(0, sessions[i]);
}

void CheckAlerts() {
   string names[] = {"MAP_High", "MAP_Low", "MAP_Mid", "MAP_25", "MAP_75", 
                     "MAP_Ext125", "MAP_Ext150", "MAP_Ext175", "MAP_Ext200", 
                     "MAP_Ext_M25", "MAP_Ext_M50", "MAP_Ext_M75", "MAP_Ext_M100",
                     "HighDay", "LowDay", "MidDay", "CloseUSA"};
   double price = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   for (int i = 0; i < ArraySize(names); i++) {
      string objName = names[i] + "_line";
      if (ObjectFind(0, objName) >= 0) {
         double level = ObjectGetDouble(0, objName, OBJPROP_PRICE);
         if (MathAbs(price - level) < _Point * 10) {
            string msg = "⏰ ALERT: Price near " + names[i] + " level";
            Alert(msg);
            PlaySound("alert.wav");
            SendMail("Price Alert", msg);
         }
      }
   }
}

void CreatePanel() {
   int x = 100, y = 50, w = 50, h = 25;
   ObjectCreate(0, objPanel, OBJ_LABEL, 0, 0, 0);
   ObjectSetInteger(0, objPanel, OBJPROP_CORNER, CORNER_RIGHT_LOWER);
   ObjectSetInteger(0, objPanel, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, objPanel, OBJPROP_YDISTANCE, y - 5);
   ObjectSetInteger(0, objPanel, OBJPROP_FONTSIZE, 12);
   ObjectSetString(0, objPanel, OBJPROP_TEXT, "🗺 .");

   string btns[]  = {btnExt, btnDay, btnClose, btnSession, btnClear};
   string texts[] = {"E", "D", "C", "S", "X"};
   string tips[]  = {"Toggle Extensions", "Toggle Daily Levels", "Toggle Close USA", "Toggle Sessions", "Clear All Lines"};

   for (int i = 0; i < ArraySize(btns); i++) {
      ObjectCreate(0, btns[i], OBJ_BUTTON, 0, 0, 0);
      ObjectSetInteger(0, btns[i], OBJPROP_CORNER, CORNER_RIGHT_LOWER);
      ObjectSetInteger(0, btns[i], OBJPROP_XDISTANCE, x);
      ObjectSetInteger(0, btns[i], OBJPROP_YDISTANCE, y + (h + 5) * i);
      ObjectSetInteger(0, btns[i], OBJPROP_XSIZE, w);
      ObjectSetInteger(0, btns[i], OBJPROP_YSIZE, h);
      ObjectSetString(0, btns[i], OBJPROP_TEXT, texts[i]);
      ObjectSetString(0, btns[i], OBJPROP_TOOLTIP, tips[i]);
   }
}

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam) {
   if (id == CHARTEVENT_OBJECT_CLICK) {
      if (sparam == btnExt) { showExtensions = !showExtensions; SaveSettings(); DrawAllLevels(); }
      else if (sparam == btnDay) { showDailyLevels = !showDailyLevels; SaveSettings(); DrawAllLevels(); }
      else if (sparam == btnClose) { showCloseUSA = !showCloseUSA; SaveSettings(); DrawAllLevels(); }
      else if (sparam == btnClear) { DeleteAllLines(); DeleteSessions(); }
      else if (sparam == btnSession) {
         showSessions = !showSessions;
         SaveSettings();
         DeleteSessions();
         if (showSessions) DrawSessions();
      }
   }
}

int OnInit() {
   LoadSettings();
   CreatePanel();
   if (showSessions) DrawSessions();
   DrawAllLevels();
   return INIT_SUCCEEDED;
}

void OnDeinit(const int reason) {
   DeleteAllLines();
   DeleteSessions();
   string objs[] = {objPanel, btnExt, btnDay, btnClose, btnSession, btnClear};
   for (int i = 0; i < ArraySize(objs); i++)
      ObjectDelete(0, objs[i]);
}

void OnTick() {
   CheckAlerts();
}

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]) {
   return rates_total;
}
//+------------------------------------------------------------------+
