
## Tables

### Table: `calendar_dates` [[Data Structure SQL]]
sql

| Column Name             | Type    | Description                              |
| ----------------------- | ------- | ---------------------------------------- |
| `calendar_id`           | INTEGER | Primary key, auto-incremented identifier |
| `calendar_date`         | TEXT    | Date of the calendar                     |
| `calendar_year`         | INTEGER | Year                                     |
| `calendar_month`        | INTEGER | Month (as an integer)                    |
| `calendar_week_nb`      | INTEGER | Week number of the year                  |
| `calendar_day_of_week`  | INTEGER | Day of the week                          |
| `calendar_day_of_month` | INTEGER | Day of the month                         |
| `event_description`     | TEXT    | Description of any event on this date    |

---

### Table: `holiday_calendar`

| Column Name        | Type    | Description                                    |
|--------------------|---------|------------------------------------------------|
| `holiday_id`       | INTEGER | Primary key, auto-incremented identifier        |
| `currency_code`    | TEXT    | Currency code (ISO format)                     |
| `holiday_date`     | TEXT    | Date of the holiday                            |
| `holiday_name`     | TEXT    | Name of the holiday                            |
| **Unique Constraint** | -     | Ensures no duplicate holidays for the same currency code and date. |

---

### Table: `daily_history`

| Column Name         | Type    | Description                                   |
|---------------------|---------|-----------------------------------------------|
| `daily_history_id`  | INTEGER | Primary key, auto-incremented identifier       |
| `execution_date`    | TEXT    | Date of the execution (run date)              |
| `ticker_symbol`     | TEXT    | Ticker symbol                                 |
| `begin_date`        | TEXT    | Begin date for the data                       |
| `end_date`          | TEXT    | End date for the data                         |
| `volume_type`       | TEXT    | Type of volume                                |
| `trend_type`        | TEXT    | Type of trend                                 |
| `angle`             | REAL    | Angle of the trend                            |
| `lowest_low`        | REAL    | Lowest value in the period                    |
| `highest_high`      | REAL    | Highest value in the period                   |
| `low_forecast`      | REAL    | Forecasted low value                          |
| `high_forecast`     | REAL    | Forecasted high value                         |
| `max_low`           | REAL    | Maximum low during the period                 |
| `min_high`          | REAL    | Minimum high during the period                |
| `inside_closes`     | REAL    | Close values inside range                     |
| **Unique Constraint** | -     | Ensures no duplicate entries for `execution_date` and `ticker_symbol`. |

---

### Table: `financial_market_data`

| Column Name          | Type    | Description                                   |
|----------------------|---------|-----------------------------------------------|
| `market_data_id`     | INTEGER | Primary key, auto-incremented identifier       |
| `data_source_id`     | INTEGER | ID of the data source                         |
| `ticker_symbol`      | TEXT    | Ticker symbol                                 |
| `trade_period`       | TEXT    | Period of the trade (e.g., daily, weekly)     |
| `trade_date`         | TEXT    | Date of the trade                             |
| `open_price`         | REAL    | Opening price                                 |
| `high_price`         | REAL    | Highest price during the period               |
| `low_price`          | REAL    | Lowest price during the period                |
| `close_price`        | REAL    | Closing price                                 |
| `trade_volume`       | TEXT    | Volume of trade                               |
| `is_adjusted`        | INTEGER | Flag for adjusted data (1 if adjusted)        |
| **Unique Constraint** | -     | Ensures no duplicate entries for the same ticker, trade period, and date. |

---

### Table: `indicator_metrics`

| Column Name          | Type    | Description                                   |
|----------------------|---------|-----------------------------------------------|
| `metrics_id`         | INTEGER | Primary key, auto-incremented identifier       |
| `perimeter_id`       | INTEGER | Foreign key to the perimeter table            |
| `execution_date`     | TEXT    | Date of execution                             |
| `trade_period`       | TEXT    | Period of the trade (e.g., daily, weekly)     |
| `indicator_name`     | TEXT    | Name of the indicator                         |
| `indicator_value`    | REAL    | Value of the indicator                        |
| **Unique Constraint** | -     | Ensures no duplicate entries for the same perimeter, indicator, and period. |

---

### Table: `trend_metrics_outputs`

| Column Name           | Type    | Description                                   |
|-----------------------|---------|-----------------------------------------------|
| `output_id`           | INTEGER | Primary key, auto-incremented identifier       |
| `execution_date`      | TEXT    | Date of execution                             |
| `daily_trend`         | REAL    | Daily trend indicator                         |
| `weekly_trend`        | REAL    | Weekly trend indicator                        |
| `monthly_trend`       | REAL    | Monthly trend indicator                       |
| `proportion_index`    | REAL    | Proportion index value                        |
| `double_trend`        | REAL    | Double trend indicator                        |
| `daily_high_low`      | REAL    | Daily high/low indicator                      |
| `weekly_high_low`     | REAL    | Weekly high/low indicator                     |
| `monthly_high_low`    | REAL    | Monthly high/low indicator                    |
| `daily_volume`        | REAL    | Daily volume indicator                        |
| `weekly_volume`       | REAL    | Weekly volume indicator                       |
| `monthly_volume`      | REAL    | Monthly volume indicator                      |
| `daily_cms`           | REAL    | Daily CMS (Custom Metric)                     |
| `weekly_cms`          | REAL    | Weekly CMS                                    |
| `monthly_cms`         | REAL    | Monthly CMS                                   |
| **Unique Constraint** | -       | Ensures no duplicate `execution_date` entries. |

---

## Views

### View: `alt_vol`

This view aggregates data to count the number of indicators on a specific run date, filtering by a specific perimeter and period.

```sql
CREATE VIEW alt_vol AS
SELECT t.execution_date, COUNT(t.indicator_value) AS count_indicator_value
FROM (
    SELECT m.execution_date, m.indicator_value
    FROM market_data_metrics m
    JOIN perimeter_ticker p
    ON m.ticker_symbol = p.ticker_symbol
    WHERE p.perimeter_id = 1
    AND m.trade_period = 'Daily'
    ORDER BY m.execution_date DESC
) t
WHERE ABS(t.indicator_value) >= 0.01
GROUP BY t.execution_date
ORDER BY t.execution_date;
```

---

### View: `asset_1`

This view groups ticker data by asset class and counts the number of assets per perimeter.

```sql
CREATE VIEW asset_1 AS
SELECT t.asset_class, COUNT(0) AS nb
FROM ticker t
JOIN perimeter_ticker pht
ON t.ticker_symbol = pht.ticker_symbol
WHERE pht.perimeter_id = 1
GROUP BY t.asset_class;
```

---

### View: `daily_trend_start`

This view shows the daily trend start for a specific execution date, determined by the maximum trend start count.

```sql
CREATE VIEW daily_trend_start AS
SELECT c.begin_date AS daily_start, c.execution_date AS execution_date
FROM (
    SELECT daily_history.execution_date, daily_history.begin_date, COUNT(0) AS trend_start
    FROM daily_history
    GROUP BY daily_history.execution_date, daily_history.begin_date
) c
JOIN (
    SELECT t.execution_date, MAX(t.trend_start) AS max_trend_start
    FROM (
        SELECT daily_history.execution_date, daily_history.begin_date, COUNT(0) AS trend_start
        FROM daily_history
        GROUP BY daily_history.execution_date, daily_history.begin_date
    ) t
    GROUP BY t.execution_date
) m
ON c.execution_date = m.execution_date AND c.trend_start = m.max_trend_start
ORDER BY c.execution_date DESC;
```

---

### View: `dailyindicators`

This view aggregates daily indicator metrics such as on_total, off_total, and various trend values.

```sql
CREATE VIEW dailyindicators AS
SELECT ont.trade_period, ont.execution_date, ont.perimeter_id, ont.on_total, oft.off_total, onu.on_up, ond.on_down, ofu.off_up, ofd.off_down, 
dtonu.dt_on_up, dtond.dt_on_down, dtofu.dt_off_up, dtofd.dt_off_down
FROM ((((((((((SELECT metrics.execution_date, metrics.indicator_value AS on_total, metrics.trade_period, metrics.perimeter_id
               FROM indicator_metrics
               WHERE metrics.indicator_name = 'On_Tot') ont
         JOIN (SELECT metrics.execution_date, metrics.indicator_value AS off_total, metrics.trade_period, metrics.perimeter_id
               FROM indicator_metrics
               WHERE metrics.indicator_name = 'Off_Tot') oft
         ON ont.execution_date = oft.execution_date AND ont.trade_period = oft.trade_period AND ont.perimeter_id = oft.perimeter_id)
         JOIN (SELECT metrics.execution_date, metrics.indicator_value AS on_up, metrics.trade_period, metrics.perimeter_id
               FROM indicator_metrics
               WHERE metrics.indicator_name = 'On_Up