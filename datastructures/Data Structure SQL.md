[]()
## sql-query-calendar-dates 

```sql

CREATE TABLE calendar_dates (`
  `calendar_id INTEGER PRIMARY KEY,`
  `calendar_date TEXT,`
  `calendar_year INTEGER NOT NULL,`
  `calendar_month INTEGER NOT NULL,`
  `calendar_week_nb INTEGER NOT NULL,`
  `calendar_day_of_week INTEGER NOT NULL,`
  `calendar_day_of_month INTEGER NOT NULL,`
  `event_description TEXT`
`);`

`CREATE TABLE holiday_calendar (`
  `holiday_id INTEGER PRIMARY KEY,`
  `currency_code TEXT NOT NULL,`
  `holiday_date TEXT NOT NULL,`
  `holiday_name TEXT,`
  `UNIQUE (holiday_date, currency_code)`
`);`

`CREATE TABLE calendar_usd (`
  `calendar_usd_id INTEGER PRIMARY KEY,`
  `calendar_date TEXT NOT NULL,`
  `calendar_year INTEGER,`
  `calendar_month INTEGER,`
  `calendar_week_nb INTEGER,`
  `calendar_day_of_week INTEGER,`
  `calendar_day_of_month INTEGER,`
  `is_begin_of_week INTEGER DEFAULT 0,`
  `is_end_of_week INTEGER DEFAULT 0,`
  `is_begin_of_month INTEGER DEFAULT 0,`
  `is_end_of_month INTEGER DEFAULT 0,`
  `is_end_of_year INTEGER DEFAULT 0,`
  `UNIQUE (calendar_date)`
`);`

`CREATE TABLE daily_history (`
  `daily_history_id INTEGER PRIMARY KEY,`
  `execution_date TEXT NOT NULL,`
  `ticker_symbol TEXT NOT NULL,`
  `begin_date TEXT NOT NULL,`
  `end_date TEXT NOT NULL,`
  `volume_type TEXT,`
  `trend_type TEXT,`
  `angle REAL,`
  `lowest_low REAL,`
  `highest_high REAL,`
  `low_forecast REAL,`
  `high_forecast REAL,`
  `max_low REAL,`
  `min_high REAL,`
  `inside_closes REAL,`
  `UNIQUE (execution_date, ticker_symbol)`
`);`

`CREATE TABLE imported_market_data (`
  `imported_data_id INTEGER PRIMARY KEY,`
  `trade_date TEXT,`
  `open_price TEXT,`
  `high_price TEXT,`
  `low_price TEXT,`
  `close_price TEXT,`
  `trade_volume INTEGER NOT NULL,`
  `ticker_symbol TEXT,`
  `trade_period TEXT`
`);`

`CREATE TABLE indicator_indexing (`
  `indicator_index_id INTEGER PRIMARY KEY,`
  `indicator_name TEXT NOT NULL,`
  `description TEXT,`
  `associated_table TEXT,`
  `is_daily INTEGER DEFAULT 0,`
  `is_weekly INTEGER DEFAULT 0,`
  `is_monthly INTEGER DEFAULT 0`
`);`

`CREATE TABLE last_bar (`
  `last_bar_id INTEGER PRIMARY KEY,`
  `trade_period TEXT NOT NULL,`
  `ticker_symbol TEXT NOT NULL,`
  `trade_date TEXT NOT NULL,`
  `open_price TEXT NOT NULL,`
  `high_price TEXT NOT NULL,`
  `low_price TEXT NOT NULL,`
  `close_price TEXT NOT NULL,`
  `UNIQUE (trade_period, ticker_symbol, trade_date)`
`);`

`CREATE TABLE last_zero_date (`
  `trade_period TEXT NOT NULL,`
  `ticker_symbol TEXT NOT NULL,`
  `execution_date TEXT NOT NULL,`
  `last_zero_date TEXT,`
  `UNIQUE (trade_period, ticker_symbol, execution_date)`
`);`

`CREATE TABLE financial_market_data (`
  `market_data_id INTEGER PRIMARY KEY,`
  `data_source_id INTEGER DEFAULT 1,`
  `ticker_symbol TEXT NOT NULL,`
  `trade_period TEXT NOT NULL,`
  `trade_date TEXT NOT NULL,`
  `open_price REAL,`
  `high_price REAL,`
  `low_price REAL,`
  `close_price REAL,`
  `trade_volume TEXT,`
  `is_adjusted INTEGER DEFAULT 0,`
  `UNIQUE (ticker_symbol, trade_period, trade_date, is_adjusted, data_source_id)`
`);`

`CREATE TABLE market_data_source (`
  `data_source_id INTEGER PRIMARY KEY,`
  `data_source_name TEXT`
`);`

`CREATE TABLE market_data_events (`
  `event_id INTEGER PRIMARY KEY,`
  `ticker_symbol TEXT NOT NULL,`
  `event_type TEXT DEFAULT 'Div',`
  `event_date TEXT NOT NULL,`
  `event_value REAL,`
  `UNIQUE (ticker_symbol, event_date, event_type)`
`);`

`CREATE TABLE market_data_metrics (`
  `metrics_id INTEGER PRIMARY KEY,`
  `ticker_symbol TEXT NOT NULL,`
  `execution_date TEXT NOT NULL,`
  `trade_period TEXT NOT NULL,`
  `indicator_name TEXT NOT NULL,`
  `indicator_value REAL DEFAULT 0,`
  `UNIQUE (execution_date, trade_period, indicator_name, ticker_symbol)`
`);`

`CREATE TABLE mars_signal (`
  `mars_signal_id INTEGER PRIMARY KEY,`
  `ticker_symbol TEXT NOT NULL,`
  `execution_date TEXT NOT NULL,`
  `trade_period TEXT NOT NULL,`
  `mars_signal_value INTEGER DEFAULT 0,`
  `UNIQUE (ticker_symbol, execution_date, trade_period)`
`);`

`CREATE TABLE indicator_metrics (`
  `metrics_id INTEGER PRIMARY KEY,`
  `perimeter_id INTEGER NOT NULL,`
  `execution_date TEXT NOT NULL,`
  `trade_period TEXT NOT NULL,`
  `indicator_name TEXT NOT NULL,`
  `indicator_value REAL DEFAULT 0,`
  `UNIQUE (execution_date, trade_period, indicator_name, perimeter_id)`
`);`

`CREATE TABLE trend_metrics_outputs (`
  `output_id INTEGER PRIMARY KEY,`
  `execution_date TEXT,`
  `daily_trend REAL,`
  `weekly_trend REAL,`
  `monthly_trend REAL,`
  `proportion_index REAL,`
  `double_trend REAL,`
  `daily_high_low REAL,`
  `weekly_high_low REAL,`
  `monthly_high_low REAL,`
  `daily_volume REAL,`
  `weekly_volume REAL,`
  `monthly_volume REAL,`
  `daily_cms REAL,`
  `weekly_cms REAL,`
  `monthly_cms REAL,`
  `UNIQUE (execution_date)`
`);`

`CREATE TABLE perimeter (`
  `perimeter_id INTEGER PRIMARY KEY,`
  `perimeter_name TEXT NOT NULL,`
  `description TEXT`
`);`

`CREATE TABLE perimeter_ticker (`
  `perimeter_id INTEGER NOT NULL,`
  `ticker_symbol TEXT NOT NULL,`
  `PRIMARY KEY (perimeter_id, ticker_symbol)`
`);`

`CREATE TABLE stock_ranking (`
  `ranking_id INTEGER PRIMARY KEY,`
  `table_name TEXT NOT NULL,`
  `execution_date TEXT NOT NULL,`
  `ticker_symbol TEXT NOT NULL,`
  `row_rank INTEGER NOT NULL,`
  `UNIQUE (table_name, execution_date, ticker_symbol)`
`);`

`CREATE TABLE signal_metrics (`
  `signal_metrics_id INTEGER PRIMARY KEY,`
  `indicator_name TEXT,`
  `trade_period TEXT,`
  `execution_date TEXT,`
  `return_sign INTEGER,`
  `streak INTEGER,`
  `next_log_return REAL`
`);`

`CREATE TABLE ticker (`
  `ticker_symbol TEXT PRIMARY KEY,`
  `long_name TEXT NOT NULL,`
  `region TEXT NOT NULL,`
  `asset_class TEXT NOT NULL,`
  `sector TEXT NOT NULL,`
  `risk_profile TEXT NOT NULL,`
  `data_source TEXT,`
  `inverse_name TEXT,`
  `double_name TEXT,`
  `equivalent_name TEXT,`
  `raw_data_flag TEXT DEFAULT 'No',`
  `external_link TEXT`
`);`

`CREATE TABLE ticker_metrics (`
  `metrics_id INTEGER PRIMARY KEY,`
  `ticker_symbol TEXT NOT NULL,`
  `execution_date TEXT NOT NULL,`
  `trade_period TEXT NOT NULL,`
  `indicator_name TEXT NOT NULL,`
  `indicator_value INTEGER DEFAULT 0,`
  `UNIQUE (ticker_symbol, execution_date, trade_period, indicator_name)`
`);`

`CREATE TABLE temporary_metrics (`
  `temp_metrics_id INTEGER PRIMARY KEY,`
  `perimeter_id INTEGER NOT NULL,`
  `execution_date TEXT NOT NULL,`
  `trade_period TEXT NOT NULL,`
  `indicator_name TEXT NOT NULL,`
  `indicator_value REAL DEFAULT 0,`
  `order_id INTEGER DEFAULT 0,`
  `UNIQUE (execution_date, trade_period, indicator_name, perimeter_id)`
`);`

`CREATE TABLE temporary_market_data (`
  `temp_market_data_id INTEGER PRIMARY KEY,`
  `data_source_id INTEGER DEFAULT 1,`
  `ticker_symbol TEXT NOT NULL,`
  `trade_period TEXT NOT NULL,`
  `trade_date TEXT NOT NULL,`
  `open_price REAL,`
  `high_price REAL,`
  `low_price REAL,`
  `close_price REAL,`
  `trade_volume TEXT,`
  `is_adjusted INTEGER,`
  `order_id INTEGER,`
  `dividend REAL,`
  `UNIQUE (ticker_symbol, trade_period, trade_date, is_adjusted, data_source_id)`
`);`

`CREATE TABLE trigger_control_panel (`
  `trigger_control_id INTEGER PRIMARY KEY,`
  `indicator_name TEXT,`
  `trigger_value TEXT,`
  `trigger_description TEXT`
`);`

`CREATE TABLE weekly_history (`
  `weekly_history_id INTEGER PRIMARY KEY,`
  `execution_date TEXT NOT NULL,`
  `ticker_symbol TEXT,`
  `begin_date TEXT NOT NULL,`
  `end_date TEXT NOT NULL,`
  `volume_type TEXT,`
  `trend_type TEXT,`
  `angle REAL,`
  `lowest_low REAL,`
  `highest_high REAL,`
  `low_forecast REAL,`
  `high_forecast REAL,`
  `max_low REAL,`
  `min_high REAL,`
  `inside_closes REAL,`
  `UNIQUE (execution_date, ticker_symbol)`
`);

```
