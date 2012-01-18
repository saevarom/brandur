About
=====

Brandur is a simple IRC bot based on [Cinch](http://github.com/cinchrb/cinch). Right now, Brandur can do some calculations for you or lookup random images on Google.

Requirements
============

You need the following gems to run Brandur

* cinch
* curb

Usage
=====

Copy `constants.rb.example` to `constants.rb` and edit the necessary settings, like `SERVER` and `CHANNELS`.

Then, simply run the bot:

    ruby run.rb

Go ask Brandur a question on a channel or in a private message:

    [me] brandur convert 32 fahrenheit to celsius
    [brandur] 32 degrees Fahrenheit equals 0 degrees Celsius
    [me] brandur calculate 2+2
    [brandur] 2 + 2 equals 4
    [me] brandur image pug costume
    [brandur] http://s3-ak.buzzfed.com/static/imagebuzz/web03/2010/10/13/15/teen-wolf-pug-costume-22885-1286999339-38.jpg
    
    ![Hilarious image of a dog](http://s3-ak.buzzfed.com/static/imagebuzz/web03/2010/10/13/15/teen-wolf-pug-costume-22885-1286999339-38.jpg)
