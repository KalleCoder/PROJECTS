/**
 * @file Entry_Bool_Functions-mqh
 * @author KalleCoder
 * @brief 
 * This file contains all the specific entry bool functions. 
 * Each function returns true if a pattern is recognized. 
 *
 * @version 1.0
 * @date 2023-12-14
 * 
 * @copyright Copyright (c) 2023
 * 
 */

// ------------------------------------------------------------------------------
// TRADE LIMIT TRACKER
// ------------------------------------------------------------------------------

/**
 * @brief 
 * Checks if the amount of trades the bot are in are less than the maximum or not 
 *
 * @param Trades The amount of trade the bot are currently in 
 * @param Trade_Max The max amount of trades the bot can be in
 * @return Returns true if the amount of trades are less than the max trades
 */

bool Daily_Trades(int Trades, int Trade_Max)
{
   return Trades < Trade_Max;
}


// ------------------------------------------------------------------------------
// CLOSE ON INNER LOW
// ------------------------------------------------------------------------------

/**
 * @brief 
 * Finds a pattern where the candle closes on the inner low price level
 *
 * @param White_Low_Price_Level Price level under the white line
 * @param White_Breach_Candles Amount of candles passed since the white line was broken
 * @return Returns true if a candle has closed on the inner white level
 */
// BULLISH MARKET
bool Close_On_Inner_Low_WHITE(double White_Low_Price_Level, int White_Breach_Candles)
{
   for (int i = 2; i < White_Breach_Candles; i++)
   {
      if (iClose(NULL, PERIOD_M15, i) < White_Low_Price_Level)
      {
         return false;
      }
   }
   if(White_Breach_Candles >= 2) // waiting for the candles to breach the white line. 
   {
      if (MathAbs(iClose(NULL, PERIOD_M15, 1) - White_Low_Price_Level) < 0.00005)// how close the candle can close to the white line 
      {
         return true;
      }
   }
   return false;
}


// ------------------------------------------------------------------------------
// WICK ON INNER LOW
// ------------------------------------------------------------------------------

/**
 * @brief 
 * Finds a pattern where a candle wick reaches the same price as the inner low price level
 *
 * @param White_Low_Price_Level Price level under the white line
 * @param White_Breach_Candles Amount of candles passed since the white line was broken
 * @return Return true if a candle low reached the same price as the inner low price and the candle closed above
 */
// BULLISH MARKET
bool Wick_On_Inner_Low_WHITE(double White_Low_Price_Level, int White_Breach_Candles)
{
   for (int i = 2; i < White_Breach_Candles; i++)
   {
      if (iLow(NULL, PERIOD_M15, i) < White_Low_Price_Level)
      {
         return false;
      }
   }
   if(White_Breach_Candles >= 2) // waiting for the candles to breach the white line. 
   {
      if (MathAbs(iLow(NULL, PERIOD_M15, 1) - White_Low_Price_Level) < 0.00005)// how close the candle can close to the white line 
      {
         return true;
      }
   }
   return false;
}


// ------------------------------------------------------------------------------
// CLOSE ON INNER WICK LOW
// ------------------------------------------------------------------------------

/**
 * @brief 
 * Finds a pattern where a candle close closes on the inner wick low price level
 *
 * @param White_Low_Price_Level_Wick Price level under the white line
 * @param White_Breach_Candles Amount of candles passed since the white line was broken
 * @return Returns true if the candle closed on the same price as the inner low wick price 
 */
// BULLISH MARKET
bool Close_On_Inner_Low_Wick_WHITE(double White_Low_Price_Wick_Level, int White_Breach_Candles)
{
   for (int i = 2; i < White_Breach_Candles; i++)
   {
      if (iClose(NULL, PERIOD_M15, i) < White_Low_Price_Wick_Level)
      {
         return false;
      }
   }
   if(White_Breach_Candles >= 2) // waiting for the candles to breach the white line. 
   {
      if (MathAbs(iClose(NULL, PERIOD_M15, 1) - White_Low_Price_Wick_Level) <= 0.00005)// how close the candle can close to the white line  //CCOOREECYT LOOK ABD NAYBE FOR SELL ASWELL!!!
      {
         return true;
      }
   }
   return false;
}

// ------------------------------------------------------------------------------
// WICK ON INNER WICK LOW
// ------------------------------------------------------------------------------

/**
 * @brief 
 * Finds a pattern where a candle wick reaches the same price as the inner low wick level 
 *
 * @param White_Low_Price_Level_Wick Price level under the white line
 * @param White_Breach_Candles Amount of candles passed since the white line was broken
 * @return Returns true if the candle low reaches the same price as the inner low wick price
 */
// BULLISH MARKET
bool Wick_On_Inner_Low_Wick_WHITE(double White_Low_Price_Wick_Level, int White_Breach_Candles)
{
   for (int i = 2; i < White_Breach_Candles; i++)
   {
      if (iLow(NULL, PERIOD_M15, i) <= White_Low_Price_Wick_Level - 0.0001)
      {
         
         return false;
      }
   }
   
   if(White_Breach_Candles >= 2) // waiting for the candles to breach the white line. 
   {
      
      if (MathAbs(iLow(NULL, PERIOD_M15, 1) - White_Low_Price_Wick_Level) <= 0.00005)// how close the candle can close to the wick line 
      {
         return true;
      }
   }
   return false;
}

// ------------------------------------------------------------------------------
// CLOSE ON INNER HIGH
// ------------------------------------------------------------------------------

/**
 * @brief 
 * Finds a pattern where a candle close closes on the same price as the inner high closing level
 *
 * @param White_High_Price_Level Price level under the white line
 * @param White_Breach_Candles Amount of candles passed since the white line was broken
 * @return Returns true if the candle closes on the inner high price 
 */
// BULLISH MARKET
bool Close_On_Inner_High_WHITE(double White_High_Price_Level, int White_Breach_Candles)
{
   for (int i = 2; i < White_Breach_Candles; i++)
   {
      if (iClose(NULL, PERIOD_M15, i) < White_High_Price_Level)
      {
         return false;
      }
   }
   if(White_Breach_Candles >= 2) // waiting for the candles to breach the white line. 
   {
      if (MathAbs(iClose(NULL, PERIOD_M15, 1) - White_High_Price_Level) < 0.00005)// how close the candle can close to the white line 
      {
         Print("Poop");
         return true;
      }
   }
   return false;
}

// ------------------------------------------------------------------------------
// WICK ON INNER HIGH
// ------------------------------------------------------------------------------


/**
 * @brief 
 *  Finds a pattern where a candle wick reaches the same price as the inner high closing price level
 * 
 * @param White_High_Price_Level Price level under the white line
 * @param White_Breach_Candles Amount of candles passed since the white line was broken
 * @return Returns true if the candle low reaches the same price as the inner high price
 */
// BULLISH MARKET
bool Wick_On_Inner_High_WHITE(double White_High_Price_Level, int White_Breach_Candles)
{
   for (int i = 2; i < White_Breach_Candles; i++)
   {
      if (iLow(NULL, PERIOD_M15, i) < White_High_Price_Level)
      {
         return false;
      }
   }
   if(White_Breach_Candles >= 2) // waiting for the candles to breach the white line. 
   {  
      if (MathAbs(iLow(NULL, PERIOD_M15, 1) - White_High_Price_Level) <= 0.00005)// how close the candle can close to the white line 
      {
         return true;
      }
   }
   return false;
}

// ------------------------------------------------------------------------------
// CLOSE ON INNER HIGH WICK
// ------------------------------------------------------------------------------

/**
 * @brief 
 * Find a pattern if a candle close closes on the same price as the inner high wick price
 * 
 * @param White_High_Price_Level_Wick Price level under the white line
 * @param White_Breach_Candles Amount of candles passed since the white line was broken
 * @return Returns true if the current candle close price is the same as the inner high wick price
 */
// BULLISH MARKET
bool Close_On_Inner_High_Wick_WHITE(double White_High_Price_Level_Wick, int White_Breach_Candles)
{
   for (int i = 2; i < White_Breach_Candles; i++)
   {
      if (iClose(NULL, PERIOD_M15, i) < White_High_Price_Level_Wick)
      {
         return false;
      }
   }
   if(White_Breach_Candles >= 2) // waiting for the candles to breach the white line. 
   {
      if (MathAbs(iClose(NULL, PERIOD_M15, 1) - White_High_Price_Level_Wick) < 0.00005)// how close the candle can close to the white line 
      {
         Print("Poop");
         return true;
      }
   }
   return false;
}

// ------------------------------------------------------------------------------
// WICK ON INNER HIGH WICK
// ------------------------------------------------------------------------------

/**
 * @brief 
 * Finds a pattern where a candle wick reaches the same price as the inner high wick price 
 *
 * @param White_High_Price_Level_Wick Price level under the white line
 * @param White_Breach_Candles Amount of candles passed since the white line was broken
 * @return Returns true if the current candle low reaches the same price as the inner high wick high price 
 */
// BULLISH MARKET
bool Wick_On_Inner_High_Wick_WHITE(double White_High_Price_Level_Wick, int White_Breach_Candles)
{
   for (int i = 2; i < White_Breach_Candles; i++)
   {
      if (iLow(NULL, PERIOD_M15, i) < White_High_Price_Level_Wick)
      {
         return false;
      }
   }
   if(White_Breach_Candles >= 2) // waiting for the candles to breach the white line. 
   {  
      if (MathAbs(iLow(NULL, PERIOD_M15, 1) - White_High_Price_Level_Wick) <= 0.00005)// how close the candle can close to the white line 
      {
         return true;
      }
   }
   return false;
}

// ------------------------------------------------------------------------------
// WICK CROSSED INNER HIGH BUT CANDLE CLOSE ABOVE
// ------------------------------------------------------------------------------

/**
 * @brief 
 * Find a pattern where a candle wick went below the inner high price level but the candle body closed above
 *
 * @param White_High_Price_Level Price level under the white line
 * @param White_Breach_Candles Amount of candles passed since the white line was broken
 * @return Returns true if the candle low goes below the inner high price level but the closing body closes above
 */
// BULLISH MARKET
bool Wick_Below_Inner_High_WHITE(double White_High_Price_Level, int White_Breach_Candles)
{
   for (int i = 1; i < White_Breach_Candles; i++)
   {
      if (iClose(NULL, PERIOD_M15, i) < White_High_Price_Level)
      {
         return false;
      }
   }
   if(White_Breach_Candles >= 2) // waiting for the candles to breach the white line. 
   {
      if (MathAbs(iLow(NULL, PERIOD_M15, 1)) < White_High_Price_Level && iClose(NULL, PERIOD_M15, 1) > White_High_Price_Level)// how close the candle can close to the white line 
      {
         return true;
      }
   }
   return false;
}

// ------------------------------------------------------------------------------
// WICK CROSSED INNER HIGH WICK BUT CANDLE CLOSE ABOVE
// ------------------------------------------------------------------------------

/**
 * @brief 
 * 
 * Finding a resitans wick pattern on a inner high wick price level
 *
 * @param White_High_Price_Level_Wick Price level under the white line
 * @param White_Breach_Candles Amount of candles passed since the white line was broken
 * @return Returns true if the candle low goes below the inner high price wick level but the closing body closes above
 */
// BULLISH MARKET
bool Wick_Below_Inner_High_Wick_WHITE(double White_High_Price_Level_Wick, int White_Breach_Candles)
{
   for (int i = 1; i < White_Breach_Candles; i++)
   {
      if (iClose(NULL, PERIOD_M15, i) < White_High_Price_Level_Wick)
      {
         return false;
      }
   }
   if(White_Breach_Candles >= 2) // waiting for the candles to breach the white line. 
   {
      if (MathAbs(iLow(NULL, PERIOD_M15, 1)) < White_High_Price_Level_Wick && iClose(NULL, PERIOD_M15, 1) > White_High_Price_Level_Wick)// how close the candle can close to the white line 
      {
         return true;
      }
   }
   return false;
}

// ------------------------------------------------------------------------------
// CLOSE DOUBLE BOTTOM on other close
// ------------------------------------------------------------------------------

/**
 * @brief 
 * A function that find two candle closes on the same price  
 *
 * @param White_Price_Level The price of the hard to breach level
 * @param White_Breach_Candles Amount of candles passed since the white line was broken 
 * @param white_inner_low_wick_price A price level under the white line
 * @return This function return true if two candle closes after the white line has been breach closes on the same price
 */

bool Double_Bottom_Close_White(double White_Price_Level, int White_Breach_Candles, double white_inner_low_wick_price)
{
   bool found_low_close = false;
   double low_price = iClose(NULL, PERIOD_M15, White_Breach_Candles); // setting it to a price above the line first
   
   // first getting the low level
   for (int i = 2; i < White_Breach_Candles; i++)
   {
      if (iClose(NULL, PERIOD_M15, i) < white_inner_low_wick_price) // Has passed the low and shouldnt enter any more
      {
         return false;
      } 
      
      if (iClose(NULL, PERIOD_M15, i) < iClose(NULL, PERIOD_M15, i-1) && iClose(NULL, PERIOD_M15, i) < iClose(NULL, PERIOD_M15, i+1)) // Just getting a good pattern
      {
         if (iClose(NULL, PERIOD_M15, i) < low_price)
         {
            low_price = iClose(NULL, PERIOD_M15, i);
            found_low_close = true;
         }
      }
   }
   
   if (found_low_close == true)
   {
      if (iClose(NULL, PERIOD_M15, 1) < White_Price_Level)
      {
         for (int i = 2; i < White_Breach_Candles; i++)
         {
            if (iClose(NULL, PERIOD_M15, i) == low_price && i < 5) // if it is to close
            {
               return false;
            }
            if (MathAbs(low_price - iClose(NULL, PERIOD_M15, 1)) <= 0.00005 && i >= 5)
            {
               return true;
            }
         }
      }
   }
   return false;
}

// ------------------------------------------------------------------------------
// WICK DOUBLE BOTTOM ON OTHER CLOSE
// ------------------------------------------------------------------------------

/**
 * @brief 
 * A function to find if a wick has reached the same price as an old candle close
 * 
 * @param White_Price_Level The price of the hard to breach level
 * @param White_Breach_Candles Amount of candles passed since the white line was broken 
 * @param white_inner_low_wick_price A price level under the white line
 * @return This function return true if two candle lows after the white line has been breach, reaches the same price
 */

bool Double_Bottom_Wick_White(double White_Price_Level, int White_Breach_Candles, double white_inner_low_wick_price)
{
   bool found_low_close = false;
   double low_price = iClose(NULL, PERIOD_M15, White_Breach_Candles); // setting it to a price above the line first
   
   // first getting the low level
   for (int i = 2; i < White_Breach_Candles; i++)
   {
      if (iClose(NULL, PERIOD_M15, i) < white_inner_low_wick_price) // Has passed the low and shouldnt enter any more
      {
         return false;
      } 
      
      if (iClose(NULL, PERIOD_M15, i) < iClose(NULL, PERIOD_M15, i-1) && iClose(NULL, PERIOD_M15, i) < iClose(NULL, PERIOD_M15, i+1)) // Just getting a good pattern
      {
         if (iClose(NULL, PERIOD_M15, i) < low_price)
         {
            low_price = iClose(NULL, PERIOD_M15, i);
            found_low_close = true;
         }
      }
   }
   
   if (found_low_close == true)
   {
      if (iLow(NULL, PERIOD_M15, 1) < White_Price_Level)
      {
         for (int i = 2; i < White_Breach_Candles; i++)
         {
            if (iClose(NULL, PERIOD_M15, i) == low_price && i < 5) // if it is to close
            {
               return false;
            }
            if (MathAbs(low_price - iLow(NULL, PERIOD_M15, 1)) <= 0.00005 && i >= 5 )
            {
               return true;
            }
         }
      }
   }
   return false;
}

// ------------------------------------------------------------------------------
// DOUBLE BOTTOM CLOSE ON OTHER WICK
// ------------------------------------------------------------------------------

/**
 * @brief 
 * A function to find a candle close on a wick pattern
 * 
 * @param White_Price_Level The price of the hard to breach level
 * @param White_Breach_Candles Amount of candles passed since the white line was broken 
 * @param white_inner_low_wick_price A price level under the white line
 * @return This function returns true if A current candle low reaches the same price as an older candle close that is formed after the white line has been breached
 */

bool Double_Bottom_Close_On_Wick_White(double White_Price_Level, int White_Breach_Candles, double white_inner_low_wick_price)
{
   bool found_low_close = false;
   double low_price = iClose(NULL, PERIOD_M15, White_Breach_Candles); // setting it to a price above the line first
   
   // first getting the low level
   for (int i = 2; i < White_Breach_Candles; i++)
   {
      if (iClose(NULL, PERIOD_M15, i) < white_inner_low_wick_price) // Has passed the low and shouldnt enter any more
      {
         return false;
      } 
      
      if (iClose(NULL, PERIOD_M15, i) < iClose(NULL, PERIOD_M15, i-1) && iClose(NULL, PERIOD_M15, i) < iClose(NULL, PERIOD_M15, i+1)) // Just getting a good pattern
      {
         if (iLow(NULL, PERIOD_M15, i) < low_price)
         {
            low_price = iLow(NULL, PERIOD_M15, i);
            found_low_close = true;
         }
      }
   }
   
   if (found_low_close == true)
   {
      if (iClose(NULL, PERIOD_M15, 1) < White_Price_Level)
      {
         for (int i = 2; i < White_Breach_Candles; i++)
         {
            if (iLow(NULL, PERIOD_M15, i) == low_price && i < 5) // if it is to close
            {
               return false;
            }
            if (MathAbs(low_price - iClose(NULL, PERIOD_M15, 1)) <= 0.00005 && i >= 5)
            {
               return true;
            }
         }
      }
   }
   return false;
}

// ------------------------------------------------------------------------------
// DOUBLE BOTTOM WICK ON OTHER WICK
// ------------------------------------------------------------------------------

/**
 * @brief 
 * Pattern function for finding double wick levels
 * 
 * @param White_Price_Level The price of the hard to breach level
 * @param White_Breach_Candles Amount of candles passed since the white line was broken
 * @param white_inner_low_wick_price A price level under the white line
 * @return This function returns true if A current candle low reaches the same price as an older candle low that is formed after the white line has been breached
 */

bool Double_Bottom_Wick_On_Wick_White(double White_Price_Level, int White_Breach_Candles, double white_inner_low_wick_price)
{
   bool found_low_close = false;
   double low_price = iClose(NULL, PERIOD_M15, White_Breach_Candles); // setting it to a price above the line first
   
   // first getting the low level
   for (int i = 2; i < White_Breach_Candles; i++)
   {
      if (iClose(NULL, PERIOD_M15, i) < white_inner_low_wick_price) // Has passed the low and shouldnt enter any more
      {
         return false;
      } 
      
      if (iClose(NULL, PERIOD_M15, i) < iClose(NULL, PERIOD_M15, i-1) && iClose(NULL, PERIOD_M15, i) < iClose(NULL, PERIOD_M15, i+1)) // Just getting a good pattern
      {
         if (iLow(NULL, PERIOD_M15, i) < low_price)
         {
            low_price = iLow(NULL, PERIOD_M15, i);
            found_low_close = true;
         }
      }
   }
   
   if (found_low_close == true)
   {
      if (iLow(NULL, PERIOD_M15, 1) < White_Price_Level)
      {
         for (int i = 2; i < White_Breach_Candles; i++)
         {
            if (iLow(NULL, PERIOD_M15, i) == low_price && i < 5)
            {
               return false;
            }
            if (MathAbs(low_price - iLow(NULL, PERIOD_M15, 1)) <= 0.00005 && i >= 5)
            {
               //Print("Low price is for the buy: ", low_price);
               return true;
            }
         }
      }
   }
   return false;
}
