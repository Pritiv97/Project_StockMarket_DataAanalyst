-- 1- Average Daily Trading Volume -- 

SELECT Ticker,CONCAT(ROUND(AVG(Volume) / 1000000, 3), ' M') as DailyTrendingVolume
FROM stock_market
GROUP BY Ticker;

-- 2- Most Volatile stocks --

SELECT ticker,round(avg(beta), 4) as max_of_beta
FROM stock_market
GROUP BY ticker;


-- 3-Stocks with Highest Dividend and Lowest Dividend --

SELECT 
    Ticker,
    CONCAT(ROUND(SUM(Dividend_Amount) / (SELECT SUM(Dividend_Amount) FROM stock_market) * 100, 2), '%') AS `Dividend Share`,
    SUM(Dividend_Amount) AS `Sum of Dividend Amount`
FROM stock_market
GROUP BY Ticker;


-- 4-Highest and Lowest P/E Ratios --

SELECT
    Ticker,
    MAX(PE_ratio) AS `Maximum PE Ratio`,
    MIN(PE_ratio) AS `Minimum PE Ratio`
FROM stock_market 
GROUP BY Ticker;

-- 5- Stocks with Highest Market Cap --

SELECT Ticker, CONCAT(FORMAT(SUM(Market_Cap) / 1000000000000,2), ' Tn') AS "Sum of Market Cap"
FROM stock_market
GROUP BY Ticker;


-- 6- Stocks with Strong Buy Signals and stocks with Strong Selling Signal --

SELECT Date, RSI_14_days , MACD,
    CASE
        When RSI_14_days < 45 AND MACD > 0 THEN 'Strong Buy'
        When RSI_14_days >= 69 AND MACD < 0 THEN 'Strong Sell'
        ELSE 'Neutral'
    END AS 'Signal'
From stock_market
Where YEAR(Date) BETWEEN 1986 AND 2023; 