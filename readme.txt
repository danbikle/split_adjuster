~/sa/readme.txt

This repo demonstrates a simple technique to adjust closing price data
after a stock split.

Why do I need to adjust closing price data after a stock split?

If I adjust closing price data after a stock split,
it allows me to keep my moving average calculations accurate.

For example, when IBM split, 2 shares for 1, on 1999-05-27 I see an
abrupt change in my price data.

On 1999-05-26, IBM closed at 236.25.
On 1999-05-27, IBM opened at 116.69.

A moving average calculation using those prices is inaccurate.

So, to keep the moving average calculation accurate I adjust the
closing price used to calculate that average.

The adjustment I make is to multiply closing prices after the split date by 2.

The SQL I use to adjust the data can be described with the statement below:

UPDATE ydata
SET closing_price = closing_price * 2
WHERE tkr = 'IBM'
AND ydate > '1999-05-27';

Although the above syntax is simple, it is a chore to type if
my data contains hundreds of tickers and and several thousand splits.

A way to simplify this chore is to ask the DBA to type only two pieces
of information into a CSV file: ticker, and split date.

Once that chore is done, the scripts in this repo could be used to transform
that two-column CSV file into a series of several thousand UPDATE statements
like the one displayed above.


