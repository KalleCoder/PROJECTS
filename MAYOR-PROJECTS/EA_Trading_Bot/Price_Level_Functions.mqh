/**
 * @file Price_Level_Functions.mqh
 * @author KalleCoder
 * @brief 
 * This file has some different tasks. But in short it handels almost all the price level assertion. 
 * The historical highest price, changes in take profit price, and price levels under the white line.  
 *
 * @version 1.0
 * @date 2023-12-14
 * 
 * @copyright Copyright (c) 2023
 * 
 */
//+------------------------------------------------------------------+
//| TAKE PROFIT PRICES                      |
//+------------------------------------------------------------------+

/**
 * @brief 
 * This function moves up the take profit price from the nearest 2 digits price to the next one if the current candle price closes above.
 *
 * @param takeProfitPrice 
 * @param BROKE_WHITE_CANDLES 
 * @param RESISTANS_LINE_BROKEN_HIGH 
 */
void take_profit_buy(double &takeProfitPrice, int BROKE_WHITE_CANDLES, bool &RESISTANS_LINE_BROKEN_HIGH)
{   
   for (int i = 2; i < BROKE_WHITE_CANDLES; i++)
   {
      if(iClose(NULL, PERIOD_M15, i) > takeProfitPrice + 0.0001)
      {         
         takeProfitPrice += 0.01; // moving up to the next big price
         RESISTANS_LINE_BROKEN_HIGH = true;
         break;
      }
   }
}


// ------------------------------------------------------------------------------
// HISTORICAL LOWEST AND HIGHEST PRICE
// ------------------------------------------------------------------------------
/**
 * @brief 
 * This function looks back a set amount of hours back in time(Usually 24 hours in main file). 
 * For each index it checks if the price is larger. And in the end the functions assigns the highest price to be that recorded highest price.
 * It also changes keeps track of when the latest high was formed. 
 *
 * @param hours 
 * @param Highest_Price 
 * @param high_candles_passed
 */
void CalculateHighestPrices(int hours, double &Highest_Price, int &high_candles_passed)
{
    int hoursToLookBack = hours;  // Number of hours to look back
    int candlesToLookBack = hoursToLookBack * 4;  // Assuming 15-minute candles

    double highestPrice24h = iHigh(NULL, PERIOD_M15, 1); // too just initialize a higher value than current close
    
    high_candles_passed = 0;
    int added_candles = 0;  // need a variable to track when the latest high was formed during a history search
      
    for (int i = 1; i < candlesToLookBack; i++)
    {
        double comparingPrice = iClose(NULL, PERIOD_M15, i); 
        added_candles++;
        if (comparingPrice > highestPrice24h)
        {
            highestPrice24h = comparingPrice;
            high_candles_passed = i;
            added_candles = 0;
        }
    }
    Highest_Price = highestPrice24h;
}

// ------------------------------------------------------------------------------
// PRICE LEVELS INNER LEVEL
// ------------------------------------------------------------------------------
/**
 * @brief 
 * 
 * This function does all of the price level assertion for possible areas a trade can be entered. 
 * It looks for a higher low pattern below the white line. 
 * If a level is found it also makes sure that it is a correct level.
 * An inner low is always found but if a inner high is not found or closes to close to the white line the function will make up for that. 
 *
 * @param white_linePrice The price of the white line
 * @param White_Breach_Candles The amount of candles since the white line was broken
 * @param white_created_candles The amount of candels since the white line was created
 * @param White_Low_Price_Level[out] A price level under the white line
 * @param White_High_Price_Level[out] A price level under the white line
 * @param White_Low_Price_Wick_Level[out] A price level under the white line
 * @param White_High_Wick_Level[out] A price level under the white line
 */
// BULLISH MARKET
void Inner_High_Low_WHITE(double white_linePrice, int White_Breach_Candles, int white_created_candles, double &White_Low_Price_Level, double &White_High_Price_Level, double &White_Low_Price_Wick_Level, double &White_High_Wick_level) 
{
   bool low = false;
   bool high = false;
   int amount_of_candles = White_Breach_Candles + 35;
   int candles_until_low = White_Breach_Candles;
  
   for (int p = White_Breach_Candles; p < amount_of_candles; p++)// checks the candles below the line
   {
      //finding the inner low
      if (low == false)
      {
         candles_until_low++;
         
         if (low_resistans_White(p) == true)
         {
            White_Low_Price_Level = iClose(NULL, PERIOD_M15, p);
            if (iLow(NULL, PERIOD_M15, p) < iLow(NULL, PERIOD_M15, p-1))
            {
               White_Low_Price_Wick_Level = iLow(NULL, PERIOD_M15, p);
            }
            else if (iLow(NULL, PERIOD_M15, p) > iLow(NULL, PERIOD_M15, p-1))
            {
               White_Low_Price_Wick_Level = iLow(NULL, PERIOD_M15, p-1);
            }
            low = true; 
         }       
      }                      
      if(low == true && high == false)  
      {
         //finding the inner high
         if (white_created_candles < 15 + White_Breach_Candles)
         {
            for ( int i = White_Breach_Candles + 5; i < white_created_candles + 100; i++)
            {
               if(MathAbs(iClose(NULL, PERIOD_M15, i) - white_linePrice) < 0.0001)
               {
                  White_High_Price_Level = white_linePrice; // Sets it to the lineprice if a candle has closed before 100 candles since the line has been created
                  White_High_Wick_level = iHigh(NULL, PERIOD_M15, i);
                  break;
               }
            }
         }
         else if (high_resistans_White(p) == true)
         {
            White_High_Price_Level = iClose(NULL, PERIOD_M15, p);
            White_High_Wick_level = iHigh(NULL, PERIOD_M15, p);
            high = true; 
            if (White_High_Price_Level - White_Low_Price_Level <= 0.0003) // if the high is lower than the low it then discards the low and makes a new one and a high.
            {
               p = candles_until_low;
               low = false;
               high = false;
               continue;
            }
            if (white_linePrice - iClose(NULL, PERIOD_M15, p) <= 0.00015 && high_resistans_White(p) == true)
            {
               // Setting the inner high price to the white level.
               White_High_Price_Level = white_linePrice; // if there has been such a small time so no inner high has had the time to form.
               White_High_Wick_level = iHigh(NULL, PERIOD_M15, p);
               break;
            }  
         }      
      } 
      if (high == true) // to see if the low pattern continues after a inner high and it actually has the correct structure 
      {  
         if (MathAbs(iClose(NULL, PERIOD_M15, p) - white_linePrice) < 0.0001)
         {
            p = amount_of_candles - 1; // MAkes it so the below if statement triggers, if no pattern was found. 
         }
            
         //    
         if (low_resistans_White(p) == true && iClose(NULL, PERIOD_M15, p) < White_Low_Price_Level)
         {
            if (iClose(NULL, PERIOD_M15, p) < White_Low_Price_Level && p != amount_of_candles - 1) 
            { 
               break; // it got a good pattern and the low before is under the previous low.
            }
         }
         
         // If no patterns was found 
         if (p == amount_of_candles-1)
         {   
            for ( int i = 10; i < white_created_candles + 100; i++)
            {
               if(iClose(NULL, PERIOD_M15, i) == white_linePrice) // The inner high that was found was to close to the level so the lineprice is the inner high
               {
                  White_High_Price_Level = white_linePrice; // sets it to the high if no level is found
                  White_High_Wick_level = iHigh(NULL, PERIOD_M15, i);
                  break;
               }
            }
         } 
      } 
  }
}

//¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ BOOL FUNCTIONS FOR THE PATTERNS
/**
 * @brief 
 * 
 * This is a helper function for the "Inner_Low_High_White" function, so it can assert its levels.
 * The function looks for a peak formation pointing upwards.
 *
 * @param p Is an index from where to look for the pattern
 * @return Return true if it find the peak pattern 
 */

bool high_resistans_White(int p)
{
   bool candles_after = false;
   // first the closing prices after
   if (iClose(NULL, PERIOD_M15, p) > iClose(NULL, PERIOD_M15, p-1) && iClose(NULL, PERIOD_M15, p) > iClose(NULL, PERIOD_M15, p-2))
   {
      // then the opening prices after
      if (iClose(NULL, PERIOD_M15, p) > iOpen(NULL, PERIOD_M15, p-2))
      {
         candles_after = true;
      }
   }
   
   // now looking at the closing price for the candles before
   if (candles_after == true && iClose(NULL, PERIOD_M15, p) > iClose(NULL, PERIOD_M15, p+1) && iClose(NULL, PERIOD_M15, p) > iClose(NULL, PERIOD_M15, p+2))
   {
      // then the opening prices before
      if (iClose(NULL, PERIOD_M15, p) > iOpen(NULL, PERIOD_M15, p+1) && iClose(NULL, PERIOD_M15, p) > iOpen(NULL, PERIOD_M15, p+1))
      {
         return true;
      }
   }
   
   return false;
}

/**
 * @brief 
 * 
 * This is a helper function for the "Inner_Low_High_White" function, so it can assert its levels.
 * The function looks for a peak formation pointing downwards.
 *
 * @param p Is an index from where to look for the pattern
 * @return Return true if it find the peak pattern pointing downwards.
 */

bool low_resistans_White(int p) 
{
   bool candles_after = false;
   
   
   /// ¦¦¦¦¦¦¦¦¦¦¦¦ NORMAL PATTERN||||||||||||||||¦¦¦¦¦¦¦>¦¦¦¦¦¦¦¦
   // first the closing prices after
   if (iClose(NULL, PERIOD_M15, p) < iClose(NULL, PERIOD_M15, p-1) && iClose(NULL, PERIOD_M15, p) < iClose(NULL, PERIOD_M15, p-2))
   {
      // then the opening prices after
      if (iClose(NULL, PERIOD_M15, p) < iOpen(NULL, PERIOD_M15, p-2))
      {
         candles_after = true;
      }
   }
   
   //¦¦¦¦¦¦¦¦¦¦¦¦¦ SPECIAL OCATIONS WHEN THEY CLOSE PERFECTLY SEPERATLY BEFORE¦¦¦¦¦¦¦¦¦¦
   // here it needs two larger candles as a close and the one before. Then the pattern looks good for me. 
   
   if (candles_after == true && iClose(NULL, PERIOD_M15, p) < iClose(NULL, PERIOD_M15, p+1) && iClose(NULL, PERIOD_M15, p) < iOpen(NULL, PERIOD_M15, p+1)) // just checking normal candles before
   {
      if (iOpen(NULL, PERIOD_M15, p) - iClose(NULL, PERIOD_M15, p) >= 0.0002) // closing candel needs to be atleast 2 pips large
      {
         if (iOpen(NULL, PERIOD_M15, p+1) - iClose(NULL, PERIOD_M15, p+1) >= 0.0003) // closing candel before needs to be atleast 3 pips
         {
            Print("Special low pattern!");
            return true;
         }
      }
   }
   
   
   // ¦¦¦¦¦¦ NORMAL PATTERNS 
   // now looking at the closing price for the candles before
   if (candles_after == true && iClose(NULL, PERIOD_M15, p) < iClose(NULL, PERIOD_M15, p+1) && iClose(NULL, PERIOD_M15, p) < iClose(NULL, PERIOD_M15, p+2))
   {
      // then the opening prices before
      if (iClose(NULL, PERIOD_M15, p) < iOpen(NULL, PERIOD_M15, p+1) && iClose(NULL, PERIOD_M15, p) < iOpen(NULL, PERIOD_M15, p+1))
      {
         return true;
      }
   }
   
   return false;
}
