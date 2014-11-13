# Songroom

Songroom is a multi-user cloud Karaoke player that allows a group of people to
create a shared Karaoke queue that is played via an HTML5 Karaoke player on a
separate screen.

## Origin Story

So one day I ([@mbleigh](http://twitter.com/mbleigh)) was curious how those Karaoke CDs with the terrible
pixelated graphics worked. I read up and learned about the [CD+G](http://en.wikipedia.org/wiki/CD%2BG)
format and its corresponding digital offspring, MP3+G.Continuous Deployment

My next question was: has someone made a web player for this format? The answer,
as it turned out, was yes, mostly. The [CD+Graphics Magic Player](http://cdgmagic.sourceforge.net/html5_cdgplayer/)
was a JS port of a library for reading the format.

To make a longer story short, I first converted the HTML5 CDG player into a
Polymer Web Component, and then before I knew it started building a Firebase
app around it for a multi-user Karaoke app that would let several people manage
a queue of songs and stream them to any connected device.

Because this project has absolutely nothing to do with my company, [Divshot](https://divshot.com)
and was the result of a weekend night of feverish experimentation, I've decided
to open-source the result and open it up to the Web Components LA community.
Perhaps we can, all together, build the best darn Karaoke experience the world
has ever seen using 100% web technology.

And on that day, we'll sing.

## Getting Started

To get started with development, you'll need Grunt, Bower, and Yeoman Polymer
installed:

    npm install -g grunt-cli bower yo generator-polymer

Next you'll need to install NPM and Bower dependencies:

    npm install && bower install

Once you've done that, you can get a development server going:

    grunt serve

The app will now be running on `localhost:8080`.

## Continuous Deployment

This project uses Travis CI for continuous deployment to Divshot. Because there
are presently no tests, `master` deploys to the `development` environment, with
`staging` and `production` branches.

## License

The MIT License (MIT)

Copyright (c) 2014 Michael Bleigh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

**Note:** `app/elements/cdg-canvas/cdg-canvas.js` file is licensed separately
under the terms of the GPL.